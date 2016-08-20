//
//  DifficultyEasy.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/6/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyEasy: DifficultyAbstract, Difficulty {

    /// Selects an item at semi-random, preferring to place progression items first
    func getItemForInsertion(possibleItems: [Item], possibleLocations: [Location]) -> Item {
        let progression = possibleItems.filter { !$0.isJunk }
        // Prefer to place progression items first
        if progression.count > 0 {
            return progression.selectAtRandom(randomizer)
        }
        return possibleItems.selectAtRandom(randomizer)
    }

    /// Returns the items to be placed. Upgrades some item types because this is easy mode
    func getItemPool() -> [Item] {
        return pool
            .map { $0.isMoney ? Item.ThreeHundredRupees : $0 }
            .map { $0.isBottle ? Item.allBottles.selectAtRandom(randomizer) : $0 }
            .map { $0.isHealth ? Item.HeartContainer : $0 }
            .map { $0.isBombs ? Item.TenBombs : $0 }
            .map { $0.isArrows ? Item.TenArrows : $0 }
    }

    /// Selects a location at semi-random, preferring to place progression items in the light world
    func getLocationForItemPlacement(possibleLocations: [Location], item: Item) -> Location {
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
        for location in locations {
            pool.append(location.item)
            location.item = .Nothing
        }

        // Easy mode: always grant 1/4 magic ✨
        randomizeBat(chance: 1, in: 1)
        randomizeEntrances()
        randomizeFairies()
    }

}
