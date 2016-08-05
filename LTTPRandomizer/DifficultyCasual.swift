//
//  DifficultyCasual.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyCasual: Difficulty {

    /// Locations that will be randomized
    private var locations: [Location] = []

    private var pool = [Item]()

    func reset() {
        pool = []
        locations = allLocations()
        for location in locations {
            if !location.item.isDungeonItem {
                pool.append(location.item)
            }
            location.item = .Nothing
        }
    }

    func getLocations() -> Locations {
        return locations
    }

    func getItemForInsertion(possibleItems: [Item], possibleLocations: [Location], randomizer: Randomizer) -> Item {
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

    func getLocationForItemPlacement(possibleLocations: [Location], item: Item, randomizer: Randomizer) -> Location {
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

    func getItemPool(random: Randomizer) -> [Item] {
        // TODO: possible difficulty shifts
        // - Change rupees/bombs/arrows
        // - Change bottle contents
        // - Replace non-critical inventory items
        // - Replace heart pieces
        return pool
    }

    private func isLateGameItem(_ item: Item) -> Bool {
        // TODO: original randomizer seeds one of four (mitt, hammer, mitt again, hammer+mitt) to raise difficulty during earlier setup. not touching that for now.
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

