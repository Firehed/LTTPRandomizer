//
//  RomBuilder.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

extension NSMutableData {

    func patch(atByteOffset: Int, withData data: NSData) {
        let range = NSRange(location: atByteOffset, length: data.length)
        replaceBytes(in: range, withBytes: data.bytes)
    }

}

class RomBuilder {

    var writeSRAMTrace: Bool = false

    /// The pseudo-randomizer
    private var randomizer: Randomizer

    /// The provider of the item pool, location list, and placement rules
    private var difficulty: Difficulty

    /// Locations to be randomized
    private var locations: Locations

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
        self.locations = difficulty.getLocations()
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
        locations.sort(isOrderedBefore: { $0.region.rawValue < $1.region.rawValue })

        for location in locations {

            if location.item == .Nothing {
                if location.region != .Progression {
                    NSLog("%@ has no item", location.name)
                }
                continue
            }

            if !location.item.isJunk {
                NSLog("%@: %@", location.item.description, location.name)
            }

            let addr = location.address
            rom.patch(atByteOffset: addr, withData: location.item.asData())

            // Apply additional patch if one exists
            if location.onPatchingRom != nil {
                location.onPatchingRom!(rom, location.item)
            }
        }

        if writeSRAMTrace {
            let bytes: [UInt8] = [0x00, 0x80, 0x21]
            rom.patch(atByteOffset: 0x57, withData: NSData(bytes: bytes, length: 3))
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
        itemPool = difficulty.getItemPool()
        haveItems = []
    }

    /**
        For each dungeon, figure out where to place its progression items based
        on which areas are locked behind keyed doors
    */
    private func generateDungeonItems() -> Void {
        for dungeon in Dungeon.all {
            let dungeonLocations = locations
                .filter({ $0.region == dungeon.region })
                .filter({ $0.dungeonRules.canHoldDungeonItems })

            for zone in dungeon.keyZones {
                for _ in 0..<zone.count {
                    let current: [Location]
                    // I'm reasonably sure this could drop the isInKeyZone logic entirely and always use inOrBefore
                    if zone.lte {
                        current = dungeonLocations.filter({ $0.isInOrBeforeKeyZone(zone.id) })
                    } else {
                        current = dungeonLocations.filter({ $0.isInKeyZone(zone.id) })
                    }
                    current.selectAtRandom(randomizer).item = Item.Key
                }
            }
            if dungeon.hasBigKey {
                let avail = dungeonLocations.withNoItems().filter({ !$0.dungeonRules.isBigKeyZone })
                avail.selectAtRandom(randomizer).item = Item.BigKey
            }
            if dungeon.hasMap {
                let avail = dungeonLocations.withNoItems()
                avail.selectAtRandom(randomizer).item = Item.Map
            }
            if dungeon.hasCompass {
                let avail = dungeonLocations.withNoItems()
                avail.selectAtRandom(randomizer).item = Item.Compass
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
            let emptyLocations = locations.withNoItems()
            var possibleLocations = emptyLocations.filter({ $0.isAccessible(inventory: haveItems) })

            // Something has gone deeply wrong during the dependency-solving process
            if (possibleLocations.isEmpty) {
                NSLog("Created inaccessible locations")
                emptyLocations.forEach({ NSLog("%@", $0.name) })
                return
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
            itemPool.remove(at: itemPool.index(of: selected)!) // remove the first one found
            let targetLocation = difficulty.getLocationForItemPlacement(possibleLocations: possibleLocations, item: selected)
            targetLocation.item = selected
        } while (itemPool.isNonEmpty)
    }

}
