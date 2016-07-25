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
    func getUnavailableLocations(have: Set<Item>) -> [Location]
    func getItemForInsertion(possibleItems: [Item], possibleLocations: [Location], randomizer: Randomizer) -> Item
    func getLocationForItemPlacement(possibleLocations: [Location], item: Item, randomizer: Randomizer) -> Location
}
