//
//  Difficulty.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

protocol Difficulty {

    /**
     Initializer. Provides a randomizer to use during selection
     - parameters:
        - randomizer: a Randomizer
    */
    init(randomizer: Randomizer)

    /**
     Reset any state in the difficulty
     */
    func reset() -> Void

    /**
     Return a list of `Item`s that can be randomly placed
     - returns: an array of `Item`s
    */
    func getItemPool() -> [Item]

    /**
     Return a list of `Location`s that need items
     - returns: an array of `Location`s
    */
    func getLocations() -> Locations

    /**
     Return a list of `DungeonInfo`s for all of the randomized dungeon items
     - returns: an array of `DungeonInfo`s
    */
    func getDungeonInfo() -> [DungeonInfo]

    /**
     Given a pool of items and currently-accessible locations, returns an item to place.
     - parameters:
        - possibleItems: the item pool
        - possibleLocations: the currently accessible locations
     - returns: the Item to place
    */
    func getItemForInsertion(possibleItems: [Item], possibleLocations: Locations) -> Item

    /**
     Given an item to place and currently-accessible locations, return the location to place the item
     - parameters:
        - possibleLocations: the currently accessible locations
        - item: the Item being placed
     - returns: the Location to place the Item
    */
    func getLocationForItemPlacement(possibleLocations: Locations, item: Item) -> Location
}
