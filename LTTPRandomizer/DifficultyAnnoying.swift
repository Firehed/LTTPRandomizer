//
//  DifficultyAnnoying.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 9/3/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyAnnoying: DifficultyAbstract, Difficulty {

    /// a one-character string for encoding the ROM information
    internal var abbreviatedName: String { return "A" }

    func reset() -> Void {
        pool = []
        locations = allLocations().map {
            var location = $0
            // Replace map and compass with more junk so it's less practical to quick-exit a dungeon
            var item = location.item
            if item == .Compass {
                item = .OneRupee
            } else if item == .Map {
                item = .Arrow
            }
            location.item = item
            return location
        }
        dungeonInfo = DungeonInfo.get(locations: locations)

        for location in locations {
            pool.append(location.item)
        }
        locations = setItemsToNothing(locations: locations)
        // No extra magic power for you
        var bat = getHalfMagicBatLocation()
        bat.item = .FullMagic
        locations.append(bat)

        randomizeEntrances()
        randomizeFairies()
    }

    func getItemPool() -> [Item] {
        return pool
    }

    func getItemForInsertion(possibleItems: [Item], possibleLocations: Locations) -> Item {
        return possibleItems.selectAtRandom(randomizer)
    }

    func getLocationForItemPlacement(possibleLocations: Locations, item: Item) -> Location {
        return possibleLocations.selectAtRandom(randomizer)
    }

}
