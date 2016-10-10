//
//  DifficultyCasual.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyCasual: DifficultyAbstract, Difficulty {

    /// a one-character string for encoding the ROM information
    internal var abbreviatedName: String { return "C" }

    /// Selects the item to place mostly at random, slightly preferring to put certain items towards the late game
    func getItemForInsertion(possibleItems: [Item], possibleLocations: Locations) -> Item {
        if possibleItems.count == 1 {
            return possibleItems.first!
        }
        var badLateGameItem: Bool,
            preferLateGameItem: Bool

        var item: Item
        repeat {
            // Grab an item randomly
            item = possibleItems.selectAtRandom(randomizer)

            // Late-game items are discarded if no late-game locations are available
            badLateGameItem = item.isLateGame
                && possibleLocations.filter({ $0.isLateGame }).isEmpty

            // If we picked a non-late game item, and we have both late-game items and late-game locations, discard
            preferLateGameItem = !item.isLateGame
                && possibleLocations.filter({ $0.isLateGame }).isNonEmpty
                && possibleItems.filter({ $0.isLateGame }).isNonEmpty

        } while (badLateGameItem || preferLateGameItem)
        return item
    }

    func getItemPool() -> [Item] {
        return pool
            .map { $0.isBottle ? Item.allBottles.selectAtRandom(randomizer) : $0 }
    }

    /// Places the item mostly at random, preferring to put ceratain items in the late game
    func getLocationForItemPlacement(possibleLocations: Locations, item: Item) -> Location {
        if possibleLocations.count == 1 {
            return possibleLocations.first!
        }
        var badLateGameLocation: Bool

        var location: Location
        repeat {
            location = possibleLocations.selectAtRandom(randomizer)

            badLateGameLocation = item.isLateGame // Late game item
                && !location.isLateGame // early-game location

            // TODO: bad first item (don't really care)
        } while (badLateGameLocation)
        return location
    }

    /// Rebuilds the item pool, location list, and other areas
    func reset() -> Void {
        pool = []
        locations = allLocations()
        dungeonInfo = DungeonInfo.get(locations: locations)
        for location in locations {
            pool.append(location.item)
        }
        locations = setItemsToNothing(locations: locations)
        locations.append(randomizeBat(quarterChance: (1, in: 3), fullChance: (1, in: 3)))
        randomizeEntrances()
        randomizeFairies()
    }

}

private extension Item {
    var isLateGame: Bool {
        switch self {
        case .TitansMitt, .RedMail, .MirrorShield:
            return true
        default:
            return false
        }
    }
}

private extension Location {
    var isLateGame: Bool {
        return region.isDarkWorld
    }
}
