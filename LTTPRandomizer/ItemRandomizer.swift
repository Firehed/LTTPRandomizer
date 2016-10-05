//
//  ItemRandomizer.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 10/5/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

typealias Patch = (inout Data) -> Void

class ItemRandomizer {

    /// The default filename, encoding the version, seed and difficulty
    var defaultFileName: String {
        return String(format: "LTTP_%d%@%@%@.sfc",
                      version,
                      difficulty.abbreviatedName,
                      randomizer.abbreviatedName,
                      String(format: "%06d", randomizer.seed))
    }

    /// The provider of the item pool, location list, and placement rules
    private var difficulty: Difficulty

    /// Items that have been placed into randomized locations.
    ///
    /// This is stored as a Set rather than an Array for performance reasons
    /// (faster `contains` during dependency solving) with no negative impact
    /// since no dependencies care about having e.g. two bottles
    private var haveItems = Set<Item>()

    /// Items that are available to be placed in randomized locations.
    private var itemPool: [Item] = []
    
    /// Locations to be randomized
    private var locations: Locations = []

    private var patches: [Patch] = []

    /// The pseudo-random number generator
    private var randomizer: PRNG

    /// The filename to patch
    var romFilename = "v6"

    /// Version of the randomizer
    private let version = 6

    init(randomizer: PRNG, difficulty: Difficulty) {
        self.difficulty = difficulty
        self.randomizer = randomizer
    }

    /// Employs the strategy implemented by the Difficulty to build a list of
    /// `Location`s that need to be patched, with the items to place and any
    /// additional patching logic filled in
    ///
    /// - returns: a tuple containing the modified Locations to patch the ROM
    ///            with, and any additional patches that should be performed
    func randomize() -> (Locations, [Patch]) {
        reset()
        let _ = placeDungeonItems()
        let _ = placeOverworldItems()

        guard itemPool.isEmpty else {
            NSLog("There are unplaced items")
            exit(EXIT_FAILURE)
        }

        // Random bytes to be patched into the ROM
        patches.append({ rom in
            for addr in 0x178000...0x1783FF {
                let rnd = Data(bytes: [UInt8(self.randomizer.next(lessThan: 0x100))])
                rom.patch(atByteOffset: addr, withData: rnd)
            }
        })

        return (locations, patches)
    }

    /// After resetting states where applicable, builds the list of items to
    /// place and locations to hold them
    private func reset() -> Void {
        difficulty.reset()
        itemPool = difficulty.getItemPool()
        locations = difficulty.getLocations()
        haveItems = []
        patches = []

        // Pick up any pre-assigned items from virtual locations
        for location in locations.filter({ $0.item != .Nothing && $0.region == .PatchOnly }) {
            haveItems.insert(location.item)
        }
    }
    

    /// For each dungeon, figure out where to place its progression items based
    /// on which areas are locked behind keyed doors
    private func placeDungeonItems() -> Bool {
        guard itemPool.filter({ $0.isDungeonItem }).count > 0 else {
            NSLog("No dungeon items to place")
            return false
        }

        for dungeon in difficulty.getDungeonInfo() {
            var filters = [(item: Item, callback: (Location) -> Bool)]()

            for zone in dungeon.keyZones.sorted(by: { $0.key < $1.key }) {
                for _ in 0..<zone.value {
                    filters.append((.Key, { $0.isInOrBeforeKeyZone(zone.key) } ))
                }
            }
            if dungeon.hasBigKey {
                filters.append((.BigKey, { !$0.dungeonRules.isBigKeyZone }))
            }
            if dungeon.hasMap {
                filters.append((.Map, { _ in true } ))
            }
            if dungeon.hasCompass {
                filters.append((.Compass, { _ in true } ))
            }

            for filter in filters {
                let location = locations
                    .withNoItems()
                    .filter { $0.region == dungeon.region }
                    .filter { $0.dungeonRules.canHoldDungeonItems }
                    .filter(filter.callback)
                    .selectAtRandom(randomizer)
                place(item: filter.item, in: location)
            }
        }
        return true
    }

    /// Figures out where to place any items remaining in the pool based on the
    /// progression requirements for other locations with no specified item.
    /// Delegates general item "appropriateness" to the Difficulty so that e.g.
    /// late-game items can be forced early or vice-versa
    private func placeOverworldItems() -> Bool {
        guard itemPool.filter({ $0.isDungeonItem }).count == 0 else {
            NSLog("Dungeon items remain")
            return false
        }
        repeat {
            let emptyLocations = locations.withNoItems()
            var possibleLocations = emptyLocations.filter({ $0.isAccessible(inventory: haveItems) })

            // Something has gone deeply wrong during the dependency-solving process
            if (possibleLocations.isEmpty) {
                NSLog("Created inaccessible locations")
                emptyLocations.forEach({ NSLog("%@", $0.name) })
                return false
            }

            var progressionItems: [Item] = []
            // Prefer to place an item from the available pool that expands the
            // number of accessible locations
            for item in itemPool.filter({ !$0.isJunk }) { // Only solve on items that even have a chance of improving progression - just a performance optimization
                var haveTemp = haveItems
                haveTemp.insert(item)
                let newLocations = emptyLocations.filter({ $0.isAccessible(inventory: haveTemp) })
                if newLocations.count > possibleLocations.count {
                    progressionItems.append(item)
                }
            }
            // Remove the fake locations
            possibleLocations = possibleLocations.filter({ return $0.region != .Progression })

            var selected: Item
            if progressionItems.count > 0 {
                selected = difficulty.getItemForInsertion(possibleItems: progressionItems, possibleLocations: possibleLocations)
            } else {
                selected = difficulty.getItemForInsertion(possibleItems: itemPool, possibleLocations: possibleLocations)
            }

            // Remove locations that can't hold the selected item
            possibleLocations = possibleLocations.filter { $0.canHoldItem?(selected) ?? true }

            let targetLocation = difficulty.getLocationForItemPlacement(possibleLocations: possibleLocations, item: selected)
            place(item: selected, in: targetLocation)
        } while (itemPool.isNonEmpty)
        return true
    }

    /// Places an item in the given location, tracking Link's inventory contents
    /// for subsequent item placement
    ///
    /// - parameter item:     the item to place
    /// - parameter location: the location that will hold the item
    private func place(item: Item, in location: Location) -> Void {
        // This is the approximate effect of modifying it in place
        locations.removeFirst(location)
        var location = location
        location.item = item
        locations.append(location)

        itemPool.removeFirst(item)
        haveItems.insert(item)
    }
    

}
