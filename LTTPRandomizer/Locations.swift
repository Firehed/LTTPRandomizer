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

func lightWorldItems() -> Locations {
    return [
        Location(
            region: Region.LightWorld,
            name: "[cave-018] Graveyard - top right grave",
            address: 0xE97A,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
                    && (items.canLiftHeavyRocks()
                        || (items.canAccessNorthWestDarkWorld()
                            && items.contains(Item.MagicMirror)))
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-047] Dam",
            address: 0xE98C
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-031] Tavern",
            address: 0xE9CE
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-026] chicken house",
            address: 0xE9E9
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-044] Aginah's cave",
            address: 0xE9F2
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [left chest]",
            address: 0xEA82
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [center chest]",
            address: 0xEA85
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [right chest]",
            address: 0xEA88
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [top chest]",
            address: 0xEA8E
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [left chest row of 3]",
            address: 0xEA91
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [center chest row of 3]",
            address: 0xEA94
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [right chest row of 3]",
            address: 0xEA97
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [bottom chest]",
            address: 0xEA9A
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top chest]",
            address: 0xEB0F
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top left chest]",
            address: 0xEB12
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top right chest]",
            address: 0xEB15
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [bottom left chest]",
            address: 0xEB18
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [bottom right chest]",
            address: 0xEB1B
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-016] cave under rocks west of Santuary",
            address: 0xEB3F,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [bottom left chest]",
            address: 0xEB42
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [top left chest]",
            address: 0xEB45
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [top right chest]",
            address: 0xEB48
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [bottom right chest]",
            address: 0xEB4B
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-051] Ice Cave",
            address: 0xEB4E
        ),
        //// Getting anything other than the sword here can be bad for progress... may as well keep the sword here since you can't use it if you get it before the uncle.
        //Location(
        //    lateGameItem: false,
        //    region: Region.LightWorld,
        //    name: "Uncle",
        //    address: 0x2DF45,
        //    accessRequirements: { items in
        //        return true
        //    }
        //),
        Location(
            region: Region.LightWorld,
            name: "Bottle Vendor",
            address: 0x2EB18
        ),
        Location(
            region: Region.LightWorld,
            name: "Sahasrahla",
            address: 0x2F1FC,
            accessRequirements: { items in
                return items.canDefeatEasternPalace()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Sick Kid",
            address: 0x339CF,
            accessRequirements: { items in
                return items.contains(Item.Bottle)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Hobo",
            address: 0x33E7D,
            accessRequirements: { items in
                return items.contains(Item.Flippers)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Ether",
            address: 0x48B7C,
            accessRequirements: { items in
                return items.canEnterTowerOfHera()
                    && items.canGetMasterSword()
                    && items.contains(Item.BookOfMudora)
            },
            onPatchingRom: { rom, item in
                // Inventory item check?
                rom.patch(atByteOffset: 0x44AA9, withData: item.asData())
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Thieves' Forest Hideout)",
            address: 0x180000
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Lumberjack Tree)",
            address: 0x180001,
            accessRequirements: { items in
                return items.canDefeatAgahnim1()
                    && items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Graveyard)",
            address: 0x180004,
            accessRequirements: { items in
                return items.canAccessNorthWestDarkWorld()
                    && items.contains(Item.MagicMirror)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia - generous guy",
            address: 0x180010
        ),
        Location(
            region: Region.LightWorld,
            name: "Library",
            address: 0x180012,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Maze Race)",
            address: 0x180142
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Desert - west side)",
            address: 0x180143,
            accessRequirements: { items in
                return items.contains(Item.BookOfMudora)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Dam)",
            address: 0x180145
        ),
    ]
}
