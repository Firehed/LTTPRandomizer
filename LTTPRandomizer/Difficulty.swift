//
//  Difficulty.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

protocol Difficulty {
    var locations: [Location] { get }
    func reset() -> Void
    func getItemPool(random: Randomizer) -> [Item]

    /**
     Given a pool of items and currently-accessible locations, returns an item to place.
     - parameters:
        - possibleItems: the item pool
        - possibleLocations: the currently accessible locations
        - randomizer: a randomizer
     - returns: the Item to place
    */
    func getItemForInsertion(possibleItems: [Item], possibleLocations: [Location], randomizer: Randomizer) -> Item

    /**
     Given an item to place and currently-accessible locations, return the location to place the item
     - parameters:
        - possibleLocations: the currently accessible locations
        - item: the Item being placed
        - randomizer: a randomizer
     - returns: the Location to place the Item
    */
    func getLocationForItemPlacement(possibleLocations: [Location], item: Item, randomizer: Randomizer) -> Location
}
