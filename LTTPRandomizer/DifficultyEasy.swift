//
//  DifficultyEasy.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/6/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyEasy: DifficultyAbstract, Difficulty {

    /// a one-character string for encoding the ROM information
    internal var abbreviatedName: String { return "E" }

    /// Selects an item at semi-random, preferring to place progression items first
    func getItemForInsertion(possibleItems: [Item], possibleLocations: Locations) -> Item {
        let progression = possibleItems.filter { !$0.isJunk }
        // Prefer to place progression items first
        if progression.count > 0 {
            return progression.selectAtRandom(randomizer)
        }
        return possibleItems.selectAtRandom(randomizer)
    }

    /// Returns the items to be placed. Upgrades some item types because this is easy mode
    func getItemPool() -> [Item] {
        // Turn some money into upgrades that wouldn't normally be encountered

        pool[pool.index(of: .TwentyRupees)!] = .BowAndSilverArrows

        // No .L2Sword, it crashes the game :(
        pool[pool.index(of: .TwentyRupees)!] = .L3Sword
        // If luck doesn't favor you, you'll pick this up before finding the
        // L3Sword and downgrade. With some luck this will get fixed in a v7
        // ROM. https://github.com/Dessyreqt/alttprandomizer/issues/159
        pool[pool.index(of: .TwentyRupees)!] = .L4Sword

        /* To increase sillyness of easy mode, this may happen at some point
        pool[pool.index(of: .TwentyRupees)!] = .PendantOfPower
        pool[pool.index(of: .TwentyRupees)!] = .PendantOfWisdom
        pool[pool.index(of: .TwentyRupees)!] = .PendantOfCourage
        */

        return pool
            .map { $0.isMoney ? Item.ThreeHundredRupees : $0 }
            .map { $0.isBottle ? Item.allBottles.selectAtRandom(randomizer) : $0 }
            .map { $0.isHealth ? Item.HeartContainer : $0 }
            .map { $0.isBombs ? Item.TenBombs : $0 }
            .map { $0.isArrows ? Item.TenArrows : $0 }
    }

    /// Selects a location at semi-random, preferring to place progression items in the light world
    func getLocationForItemPlacement(possibleLocations: Locations, item: Item) -> Location {
        let lightWorld = possibleLocations.filter { $0.region.isLightWorld }
        if !item.isJunk && lightWorld.count > 0 {
            return lightWorld.selectAtRandom(randomizer)
        }
        return possibleLocations.selectAtRandom(randomizer)
    }

    /// Resets item pool, locations, etc.
    func reset() -> Void {
        pool = []
        locations = allLocations()
        dungeonInfo = DungeonInfo.get(locations: locations)
        for location in locations {
            pool.append(location.item)
        }
        locations = setItemsToNothing(locations: locations)
        // Easy mode: always grant 1/4 magic ✨
        locations.append(randomizeBat(quarterChance: (1, in: 1), fullChance: (0, in: 1)))
        randomizeEntrances()
        randomizeFairies()
    }

}
