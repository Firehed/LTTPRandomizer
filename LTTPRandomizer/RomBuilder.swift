//
//  RomBuilder.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class RomBuilder {

    private let version = 6

    var writeSRAMTrace: Bool = false

    /// The pseudo-randomizer
    private var randomizer: Randomizer

    /// The provider of the item pool, location list, and placement rules
    private var difficulty: Difficulty

    /// Locations to be randomized
    private(set) public var locations: Locations = []

    /// Items that have been placed into randomized locations.
    ///
    /// This is stored as a Set rather than an Array for performance reasons
    /// (faster `contains` during dependency solving) with no negative impact
    /// since no dependencies care about having e.g. two bottles
    private var haveItems = Set<Item>()

    /// Items that are available to be placed in randomized locations.
    private var itemPool: [Item] = []

    init(randomizer: Randomizer, difficulty: Difficulty) {
        self.difficulty = difficulty
        self.randomizer = randomizer
    }

    func assignItems() {
        generateItemList()
        let _ = placeDungeonItems()
        let _ = generateItemPositions()
    }

    var defaultFileName: String {
        return String(format: "LTTP_%d%@%@%@.sfc",
                      version,
                      difficulty.abbreviatedName,
                      randomizer.abbreviatedName,
                      String(format: "%06d", randomizer.seed))
    }

    func write(to destination: URL) {
        guard let sourcePath = Bundle.main.path(forResource: "v6", ofType: "sfc") else {
            NSLog("Bundled ROM not found")
            return
        }
        guard itemPool.isEmpty else {
            NSLog("There are unplaced items")
            return
        }
        var rom: Data
        do {
            try rom = Data(contentsOf: URL.init(fileURLWithPath: sourcePath))
        } catch { return }
        locations.sort { $0.region.rawValue < $1.region.rawValue }

        for location in locations {

            if location.item == .Nothing {
                if location.region != .Progression {
                    NSLog("%@ has no item", location.name)
                }
                continue
            }

            if let addr = location.address {
                rom.patch(atByteOffset: addr, withData: location.item.asData())
            }

            // Apply additional patch if one exists
            if location.onPatchingRom != nil {
                location.onPatchingRom!(&rom, location.item)
            }
        }

        if writeSRAMTrace {
            let bytes: [UInt8] = [0x00, 0x80, 0x21]
            rom.patch(atByteOffset: 0x57, withData: Data(bytes: bytes))
        }
        writeRNG(in: &rom)

        do {
            try rom.write(to: destination, options: .atomic)
        } catch {
            print("write error")
        }

    }

    func writeRNG(in rom: inout Data) {
        for addr in 0x178000...0x1783FF {
            let rnd = Data(bytes: [UInt8(randomizer.next(lessThan: 0x100))])
            rom.patch(atByteOffset: addr, withData: rnd)
        }
    }

    private func generateItemList() -> Void {
        difficulty.reset()
        itemPool = difficulty.getItemPool()
        locations = difficulty.getLocations()
        haveItems = []

        // Pick up any pre-assigned items from virtual locations
        for location in locations.filter({ $0.item != .Nothing && $0.region == .PatchOnly }) {
            haveItems.insert(location.item)
        }
    }

    /**
        For each dungeon, figure out where to place its progression items based
        on which areas are locked behind keyed doors
    */
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
                location.item = filter.item
                itemPool.removeFirst(filter.item)
            }
        }
        return true
    }

    /**
        Figures out where to place any items remaining in the pool based on the
        progression requirements for other locations with no specified item.
        Delegates general item "appropriateness" to the Difficulty so that e.g.
        late-game items can be forced early or vice-versa
    */
    private func generateItemPositions() -> Bool {
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
            haveItems.insert(selected)
            itemPool.removeFirst(selected)

            // Remove locations that can't hold the selected item
            possibleLocations = possibleLocations.filter { $0.canHoldItem?(selected) ?? true }

            let targetLocation = difficulty.getLocationForItemPlacement(possibleLocations: possibleLocations, item: selected)
            targetLocation.item = selected
        } while (itemPool.isNonEmpty)
        return true
    }

}

