//
//  DifficultyCasual.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyCasual: DifficultyAbstract, Difficulty {

    /// Selects the item to place mostly at random, slightly preferring to put certain items towards the late game
    func getItemForInsertion(possibleItems: [Item], possibleLocations: [Location]) -> Item {
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
            badLateGameItem = isLateGameItem(item)
                && possibleLocations.filter({ $0.isLateGame }).isEmpty

            // If we picked a non-late game item, and we have both late-game items and late-game locations, discard
            preferLateGameItem = !isLateGameItem(item)
                && possibleLocations.filter({ $0.isLateGame }).isNonEmpty
                && possibleItems.filter({ isLateGameItem($0) }).isNonEmpty

        } while (badLateGameItem || preferLateGameItem)
        return item
    }

    func getItemPool() -> [Item] {
        // TODO: possible difficulty shifts
        // - Change rupees/bombs/arrows
        // - Replace non-critical inventory items
        // - Replace heart pieces
        return pool
            .map { $0.isBottle ? Item.allBottles.selectAtRandom(randomizer) : $0 }
    }

    /// Places the item mostly at random, preferring to put ceratain items in the late game
    func getLocationForItemPlacement(possibleLocations: [Location], item: Item) -> Location {
        if possibleLocations.count == 1 {
            return possibleLocations.first!
        }
        var badLateGameLocation: Bool

        var location: Location
        repeat {
            location = possibleLocations.selectAtRandom(randomizer)

            badLateGameLocation = isLateGameItem(item) // Late game item
                && !location.isLateGame // early-game location

            // TODO: bad first item (don't really care)
        } while (badLateGameLocation)
        return location
    }

    /// Rebuilds the item pool, location list, and other areas
    func reset() -> Void {
        pool = []
        locations = allLocations()
        for location in locations {
            pool.append(location.item)
            location.item = .Nothing
        }

        randomizeBat(chance: 1, in: 3)
        randomizeEntrances()
        randomizeFairies()
    }

    private func isLateGameItem(_ item: Item) -> Bool {
        switch item {
        case .TitansMitt: fallthrough
        case .RedMail: fallthrough
        case .MirrorShield:
            return true
        default:
            return false
        }
    }

}

