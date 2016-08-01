//
//  DifficultyCasual.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class DifficultyCasual: Difficulty {
    var locations: [Location] = []

    func reset() {
        locations = allLocations()
    }

    func getUnavailableLocations(have: Set<Item>) -> [Location] {
        return locations.filter({
            $0.item == .Nothing
        }).filter({
            !$0.isAccessible(inventory: have)
        })
    }

    func getItemForInsertion(possibleItems: [Item], possibleLocations: [Location], randomizer: Randomizer) -> Item {
        var badLateGameItem: Bool,
            needUniqueItem: Bool,
            preferLateGameItem: Bool

        var item: Item
        repeat {
            // Grab an item randomly
            item = possibleItems.selectAtRandom(randomizer)

            // Late-game items are discarded if no late-game locations are available
            badLateGameItem = isLateGameItem(item)
                && possibleLocations.filter({ $0.isLateGame }).isEmpty

            // Non-unique items are discarded if only unique-item locations are available
            needUniqueItem = !isUniqueItem(item)
                && possibleLocations.filter({ !$0.uniqueItemOnly }).isEmpty

            // If we picked a non-late game item, and we have both late-game items and late-game locations, discard
            preferLateGameItem = !isLateGameItem(item)
                && possibleLocations.filter({ $0.isLateGame }).isNonEmpty
                && possibleItems.filter({ isLateGameItem($0) }).isNonEmpty

        } while (badLateGameItem || needUniqueItem || preferLateGameItem)
        return item
    }

    func getLocationForItemPlacement(possibleLocations: [Location], item: Item, randomizer: Randomizer) -> Location {
        var badLateGameLocation: Bool,
            badUniqueItemLocation: Bool,
            unusedUniqueLocation: Bool

        var location: Location
        repeat {
            location = possibleLocations.selectAtRandom(randomizer)

            badLateGameLocation = isLateGameItem(item) // Late game item
                && !location.isLateGame // early-game location

            badUniqueItemLocation = !isUniqueItem(item) // Non-unique item
                && location.uniqueItemOnly // in a unique location

            unusedUniqueLocation = isUniqueItem(item) // Unique item
                && !location.uniqueItemOnly // non-unique-item location
                && possibleLocations.filter({ $0.uniqueItemOnly }).isNonEmpty // unique-item locations available

            // TODO: bad first item (don't really care)
        } while (badLateGameLocation || badUniqueItemLocation || unusedUniqueLocation)
        return location
    }

    func getItemPool(random: Randomizer) -> [Item] {
//        setLateGateItems()
        return [
            Item.Bombos,
            Item.BookOfMudora,
            Item.Bow,
            Item.CaneOfSomaria,
            Item.Ether,
            Item.FireRod,
            Item.Flippers,
            Item.Hammer,
            Item.Hookshot,
            Item.IceRod,
            Item.Lamp,
            //Item.L1SwordAndShield,
            Item.MagicMirror,
            Item.MoonPearl,
            Item.PegasusBoots,
            Item.PowerGlove,
            Item.Quake,
            Item.Shovel,
            Item.TitansMitt,
            // nice-to-have items
            Item.BlueMail,
            Item.Boomerang,
            // 4
            Item.Bottle,
            Item.Bottle,
            Item.Bottle,
            Item.Bottle,
            Item.BugCatchingNet,
            Item.Cape,
            Item.HeartContainer,
            Item.MirrorShield,
            // 22 POH (excl dig and chest games)
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            Item.PieceOfHeart,
            //Item.PieceOfHeart,
            Item.RedBoomerang,
            Item.RedMail,
            Item.RedShield,
            Item.StaffOfByrna,
            // other treasure box contents
            Item.Arrow,
            // 11
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            Item.TenArrows,
            // 17
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            Item.ThreeBombs,
            // 2
            Item.OneRupee,
            Item.OneRupee,
            // 2
            Item.FiveRupees,
            Item.FiveRupees,
            // 26
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            Item.TwentyRupees,
            // 7
            Item.FiftyRupees,
            Item.FiftyRupees,
            Item.FiftyRupees,
            Item.FiftyRupees,
            Item.FiftyRupees,
            Item.FiftyRupees,
            Item.FiftyRupees,

            // 6
            Item.OneHundredRupees,
            Item.OneHundredRupees,
            Item.OneHundredRupees,
            Item.OneHundredRupees,
            Item.OneHundredRupees,
            Item.OneHundredRupees,
            // 4
            Item.ThreeHundredRupees,
            Item.ThreeHundredRupees,
            Item.ThreeHundredRupees,
            Item.ThreeHundredRupees,
        ]
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

    private func isUniqueItem(_ item: Item) -> Bool {
        switch item {
        case Item.Bow: fallthrough
        case Item.CaneOfSomaria: fallthrough
        case Item.FireRod: fallthrough
        case Item.Flippers: fallthrough
        //case Item.Hammer: fallthrough
        case Item.Hookshot: fallthrough
        case Item.IceRod: fallthrough
        //case Item.Lamp: fallthrough
        case Item.MagicMirror: fallthrough
        case Item.MoonPearl: fallthrough
        case Item.PegasusBoots: fallthrough
        case Item.PowerGlove: fallthrough
        case Item.Quake: fallthrough
        case Item.Shovel: fallthrough
        //case Item.TitansMitt: fallthrough
        case Item.BlueMail: fallthrough
        //case Item.Boomerang: fallthrough
        case Item.BugCatchingNet: fallthrough
        case Item.Cape: fallthrough
        //case Item.MirrorShield: fallthrough
        //case Item.RedBoomerang: fallthrough
        //case Item.RedMail: fallthrough
        case Item.StaffOfByrna:
            return true
        default:
            return false
        }
    }

    private func isBadFirstItem(_ item: Item) -> Bool {
        switch item {
        case Item.PowerGlove: fallthrough
        case Item.TitansMitt: fallthrough
        case Item.RedShield: fallthrough
        case Item.MirrorShield:
            return true
        default:
            return false
        }
    }
}

