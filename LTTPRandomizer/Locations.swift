//
//  Locations.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/3/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

typealias Locations = [Location]

func allLocations() -> Locations {
    var all = Locations()
    for region in Region.all {
        all.append(contentsOf: locationsForRegion(region: region))
    }
    return all
}

func hyruleEscapeItems() -> Locations {
    return [
        // FIXME: No keys here!
        Location(
            region: Region.HyruleCastleEscape,
            name: "[cave-040] Link's House",
            address: 0xE9BC
        ),
        // FIXME: No keys here! (?)
        Location(
            region: Region.HyruleCastleEscape,
            name: "[cave-034] Hyrule Castle secret entrance",
            address: 0xE971
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - first B1 room",
            address: 0xE96E,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Hyrule Castle - boomerang room",
            address: 0xE974,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        // FIXME: no keys here!
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-1F] Sanctuary",
            address: 0xEA79,
            keyZone: 4,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B3] Hyrule Castle - next to Zelda",
            address: 0xEB09,
            keyZone: 2,
            bigKeyNeeded: false // Technically it is needed, but BK doesn't spawn in a chest so this would break
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Hyrule Castle - map room",
            address: 0xEB0C
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - final basement room [left chest]",
            address: 0xEB5D,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLiftRocks()
            }
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - final basement room [middle chest]",
            address: 0xEB60,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLiftRocks()
            }
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - final basement room [right chest]",
            address: 0xEB63,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLiftRocks()
            }
        ),
    ]
}

