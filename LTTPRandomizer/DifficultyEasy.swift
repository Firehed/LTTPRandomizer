//
//  DifficultyEasy.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/6/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyEasy: Difficulty {

    private var randomizer: Randomizer
    private var pool = [Item]()
    private var locations = Locations()

    /**
     Initializer. Provides a randomizer to use during selection
     - parameters:
        - randomizer: a Randomizer
     */
    required init(randomizer: Randomizer) {
        self.randomizer = randomizer
        reset()

    }

    /**
     Reset any state in the difficulty
     */
    func reset() -> Void {
        pool = []
        locations = allLocations()
        for location in locations {
            if !location.item.isDungeonItem {
                pool.append(location.item)
            }
            location.item = .Nothing
        }
    }

    /**
     Return a list of `Item`s that can be randomly placed
     - returns: an array of `Item`s
     */
    func getItemPool() -> [Item] {
        return pool
    }

    /**
     Return a list of `Location`s that need items
     - returns: an array of `Location`s
     */
    func getLocations() -> Locations {
        return locations
    }

    /**
     Given a pool of items and currently-accessible locations, returns an item to place.
     - parameters:
        - possibleItems: the item pool
        - possibleLocations: the currently accessible locations
     - returns: the Item to place
     */
    func getItemForInsertion(possibleItems: [Item], possibleLocations: [Location]) -> Item {
        let progression = possibleItems.filter { !$0.isJunk }
        // Prefer to place progression items first
        if progression.count > 0 {
            return progression.selectAtRandom(randomizer)
        }
        return possibleItems.selectAtRandom(randomizer)
    }

    /**
     Given an item to place and currently-accessible locations, return the location to place the item
     - parameters:
        - possibleLocations: the currently accessible locations
        - item: the Item being placed
     - returns: the Location to place the Item
     */
    func getLocationForItemPlacement(possibleLocations: [Location], item: Item) -> Location {
        let lightWorld = possibleLocations.filter { $0.region.isLightWorld }
        if lightWorld.count > 0 {
            return lightWorld.selectAtRandom(randomizer)
        }
        return possibleLocations.selectAtRandom(randomizer)
    }
}
