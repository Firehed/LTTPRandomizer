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

}

