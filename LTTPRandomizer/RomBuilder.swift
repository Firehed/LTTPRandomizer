//
//  RomBuilder.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class RomBuilder {

    /// The pseudo-randomizer
    private var random: Randomizer

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

    init(seed: Int, locations: Difficulty) {
        difficulty = locations
        random = SeededRandomizer(seed: seed)
    }

    func assignItems() {
        generateItemList()
        generateDungeonItems()
        generateItemPositions()
    }

    func write() {
        let path = "/Users/firehed/dev/alttprandomizer/AlttpRandomizer/Resources/alttp.sfc"
        var rom: NSMutableData
        do {
            try rom = NSMutableData(contentsOfFile: path, options: NSData.ReadingOptions.uncached)
        } catch { return }
        var locations = difficulty.locations
        locations.sort(isOrderedBefore: { $0.region.rawValue < $1.region.rawValue })

        for location in locations {

            if location.item == .Nothing {
                NSLog("%@ has no item", location.name)
                continue
            }

            if !location.item.isJunk {
                NSLog("%@: %@", location.name, location.item.description)
            }

            let addr = location.address
            var value = location.item.rawValue
            let range = NSRange(location: addr, length: 1)
            rom.replaceBytes(in: range, withBytes: &value)
        }
        let output = "/Users/firehed/Desktop/lttp_patched.sfc"
        do {
            try rom.write(toFile: output, options: NSData.WritingOptions.atomic)
        } catch {
            print("write error")
        }


    }

    private func generateItemList() -> Void {
        difficulty.reset()
        itemPool = difficulty.getItemPool(random: random)
    }

    /**
        For each dungeon, figure out where to place its progression items based
        on which areas are locked behind keyed doors
    */
    private func generateDungeonItems() -> Void {
        for dungeon in Dungeon.all {
            let dungeonLocations = difficulty.locations.filter({ $0.region == dungeon.region })
            for zone in dungeon.keyZones {
                for _ in 0..<zone.count {
                    let current: [Location]
                    // I'm reasonably sure this could drop the isInKeyZone logic entirely and always use inOrBefore
                    if zone.lte {
                        current = dungeonLocations.filter({ $0.isInOrBeforeKeyZone(zone.id) })
                    } else {
                        current = dungeonLocations.filter({ $0.isInKeyZone(zone.id) })
                    }
                    current.selectAtRandom(random).item = Item.Key
                }
            }
            if dungeon.hasMap {
                let avail = dungeonLocations.withNoItems()
                avail.selectAtRandom(random).item = Item.Map
            }
            if dungeon.hasCompass {
                let avail = dungeonLocations.withNoItems()
                avail.selectAtRandom(random).item = Item.Compass
            }
            if dungeon.hasBigKey {
                let avail = dungeonLocations.withNoItems()
                avail.selectAtRandom(random).item = Item.BigKey
            }
        }
    }

    /**
        Figures out where to place any items remaining in the pool based on the
        progression requirements for other locations with no specified item.
        Delegates general item "appropriateness" to the Difficulty so that e.g.
        late-game items can be forced early or vice-versa
    */
    private func generateItemPositions() -> Void {
        repeat {
            let emptyLocations = difficulty.locations.withNoItems()
            let possibleLocations = emptyLocations.filter({ $0.isAccessibleWithInventory(haveItems) })

            // Something has gone deeply wrong during the dependency-solving process
            if (possibleLocations.isEmpty) {
                NSLog("Created inaccessible locations")
                emptyLocations.forEach({ NSLog("%@", $0.name) })
                return
            }

            var candidateItems: [Item] = []
            // Prefer to place an item from the available pool that expands the
            // number of accessible locations
            for item in itemPool {
                var haveTemp = haveItems
                haveTemp.insert(item)
                let newLocations = emptyLocations.filter({ $0.isAccessibleWithInventory(haveTemp) })
                if newLocations.count > possibleLocations.count {
                    candidateItems.append(item)
                }
            }

            var selected: Item
            if candidateItems.count > 0 {
                selected = candidateItems.selectAtRandom(random)
            } else {
                selected = difficulty.getItemForInsertion(possibleItems: itemPool, possibleLocations: possibleLocations, randomizer: random)
            }
            haveItems.insert(selected)
            itemPool.remove(at: itemPool.index(of: selected)!) // remove the first one found
            let targetLocation = difficulty.getLocationForItemPlacement(possibleLocations: possibleLocations, item: selected, randomizer: random)
            targetLocation.item = selected
        } while (itemPool.isNonEmpty)
    }

}
