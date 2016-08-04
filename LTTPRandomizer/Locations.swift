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

// MARK: LW Overworld

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

func lightWorthDeathMountainItems() -> Locations {
    return [
        Location(
            region: Region.LightWorldDeathMountain,
            name: "Old mountain man",
            address: 0xF69FA
        ),
        Location(
            region: Region.LightWorldDeathMountain,
            name: "Piece of Heart (Spectacle Rock Cave)",
            address: 0x180002
        ),
        Location(
            region: Region.LightWorldDeathMountain,
            name: "Piece of Heart (Spectacle Rock)",
            address: 0x180140,
            accessRequirements: { items in
                return items.contains(Item.MagicMirror)
            }
        ),
        // This is technically in DW directly below the warp tile
        Location(
            region: Region.LightWorldDeathMountain,
            name: "[cave-055] Spike cave",
            address: 0xEA8B,
            accessRequirements: { items in
                return items.contains(Item.MoonPearl)
                    && items.contains(Item.Hammer)
            }
        ),
    ]
}

func lightWorldEasternDeathMountainItems() -> Locations {
    return [
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left chest]",
            address: 0xEB2A
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left middle chest]",
            address: 0xEB2D
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right middle chest]",
            address: 0xEB30
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right chest]",
            address: 0xEB33
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [bottom chest]",
            address: 0xEB36
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-B1] Death Mountain - wall of caves - right cave [left chest]",
            address: 0xEB39
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-B1] Death Mountain - wall of caves - right cave [right chest]",
            address: 0xEB3C
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-012-1F] Death Mountain - wall of caves - left cave",
            address: 0xE9BF
        ),
    ]
}

func zorasDomainItems() -> Locations {
    return [
        // Zora's appearance is based on if you items flippers or not
        Location(
            region: Region.LightWorld,
            name: "King Zora",
            address: 0xEE1C3,
            accessRequirements: { _ in return true }, // TODO: remove after tidying initializers
            onPatchingRom: { rom, item in
                // (This is a guess based on the Windows source)
                // Indicates what item's presence will block the Zora scene
                rom.patch(atByteOffset: 0x180200, withData: item.bytesForInventoryCheckOverride)
                // Update end-game credits
                rom.patch(atByteOffset: 0x76A85, withData: item.bytesForCredits)

            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Zora's River)",
            address: 0x180149,
            accessRequirements: { items in
                return items.contains(Item.Flippers)
            }
        ),
    ]
}

// MARK: LW Dungeons

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

func easternPalaceItems() -> Locations {
    return [
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - compass room",
            address: 0xE977
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - big chest",
            address: 0xE97D,
            keyZone: 0,
            bigKeyNeeded: true
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - big ball room",
            address: 0xE9B3
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - Big key",
            address: 0xE9B9,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - map room",
            address: 0xE9F5
        ),
    ]
}

func desertPalaceItems() -> Locations {
    return [
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - big chest",
            address: 0xE98F,
            keyZone: 0,
            bigKeyNeeded: true
        ),
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - Map room",
            address: 0xE9B6
        ),
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - Big key room",
            address: 0xE9C2,
            keyZone: 1,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - compass room",
            address: 0xE9CB,
            keyZone: 1,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
            }
        ),
    ]
}

func towerOfHeraItems() -> Locations {
    return [
        Location(
            region: Region.TowerOfHera,
            name: "[dungeon-L3-2F] Tower of Hera - Entrance",
            address: 0xE9AD
        ),
        Location(
            region: Region.TowerOfHera,
            name: "[dungeon-L3-1F] Tower of Hera - first floor",
            address: 0xE9E6,
            keyZone: 1,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.TowerOfHera,
            name: "[dungeon-L3-4F] Tower of Hera - big chest",
            address: 0xE9F8,
            keyZone: 0,
            bigKeyNeeded: true
        ),
        Location(
            region: Region.TowerOfHera,
            name: "[dungeon-L3-4F] Tower of Hera - 4F [small chest]",
            address: 0xE9FB,
            keyZone: 0,
            bigKeyNeeded: true
        ),
    ]
}

func hyruleCastleTowerItems() -> Locations {
    return [
        Location(
            region: Region.HyruleCastleTower,
            name: "[dungeon-A1-3F] Hyrule Castle Tower - maze room",
            address: 0xEAB2,
            keyZone: 1, // added this
            bigKeyNeeded: false
        ),
        Location(
            region: Region.HyruleCastleTower,
            name: "[dungeon-A1-2F] Hyrule Castle Tower - 2 knife guys room",
            address: 0xEAB5,
            keyZone: 0, // added this
            bigKeyNeeded: false
        ),
    ]
}

// MARK: DW Overworld

func darkWorldPyramidItems() -> Locations {
    return [

        // MARK: not late game
        Location(
            region: Region.DarkWorldPyramid,
            name: "Catfish",
            address: 0xEE185,
            accessRequirements: { items in
                // Note: Upstream says (boots || mitt) also required
                return items.canLiftRocks()
                    && items.contains(Item.MoonPearl)
            },
            onPatchingRom: { rom, item in
                // (This is a guess based on the Windows source)
                // Indicates what item's presence will block the Catfish scene
                rom.patch(atByteOffset: 0x180204, withData: item.bytesForInventoryCheckOverride)
            }
        ),

        // MARK: not late game
        Location(
            region: Region.DarkWorldPyramid,
            name: "Piece of Heart (Pyramid)",
            address: 0x180147
        ),
        // MARK: not late game
        //new Location
        //{
        //    lateGameItem: false,
        //    region: Region.DarkWorld,
        //    name: "Piece of Heart (Digging Game)",
        //    address: 0x180148,
        //    accessRequirements: { items in
        //        return items.canAccessLowerDarkWorld()
        //    }
        //),
    ]
}

func southDarkWorldItems() -> Locations {
    return [
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [top chest]",
            address: 0xEB1E
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [top middle chest]",
            address: 0xEB21
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [bottom middle chest]",
            address: 0xEB24
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [bottom chest]",
            address: 0xEB27
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorldSouth,
            name: "Flute Boy",
            address: 0x330C7
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace - generous guy",
            address: 0x180011
        ),
        // Technically spawns in LW (warp from peg area)
        // MARK: not late game
        Location(
            region: Region.DarkWorldSouth,
            name: "Bombos",
            address: 0x48B81,
            accessRequirements: { items in
                return items.canGetMasterSword()
                    && items.containsAll(Item.BookOfMudora, Item.MagicMirror)
            },
            onPatchingRom: { rom, item in
                // Inventory item check?
                rom.patch(atByteOffset: 0x44AAE, withData: item.asData())
            }
        ),
        // Technically spawns in LW (warp from circle of bushes)
        // MARK: not late game
        Location(
            region: Region.DarkWorldSouth,
            name: "Piece of Heart (south of Haunted Grove)",
            address: 0x180003,
            accessRequirements: { items in
                return items.contains(Item.MagicMirror)
            }
        ),
        // Technically spawns in LW (warp from circle of stones in lake)
        // MARK: not late game
        Location(
            region: Region.DarkWorldSouth,
            name: "Piece of Heart (Lake Hylia)",
            address: 0x180144,
            accessRequirements: { items in
                return items.containsAll(Item.Flippers, Item.MagicMirror)
            }
        ),
    ]
}

func northWestDarkWorldItems() -> Locations {
    return [
        Location(
            region: Region.DarkWorldNorthWest,
            name: "[cave-063] doorless hut",
            address: 0xE9EC
        ),
        Location(
            region: Region.DarkWorldNorthWest,
            name: "[cave-062] C-shaped house",
            address: 0xE9EF
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Piece of Heart (Dark World blacksmith pegs)",
            address: 0x180006,
            accessRequirements: { items in
                return items.canLiftHeavyRocks()
                    && items.contains(Item.Hammer)
            }
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Piece of Heart (Dark World - bumper cave)",
            address: 0x180146,
            accessRequirements: { items in
                return items.contains(Item.Cape)
            }
        ),
        // Technically item is in LW, but put here for access reqs
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Purple Chest",
            address: 0x33D68,
            accessRequirements: { items in
                return items.canLiftHeavyRocks()
                    && items.contains(Item.MagicMirror)
            }
        ),
    ]
}

func mireItems() -> Locations {
    return [
        Location(
            region: Region.DarkWorldMire,
            name: "[cave-071] Misery Mire west area [left chest]",
            address: 0xEA73
        ),
        Location(
            region: Region.DarkWorldMire,
            name: "[cave-071] Misery Mire west area [right chest]",
            address: 0xEA76
        ),
        Location(
            region: Region.DarkWorldMire,
            name: "Piece of Heart (Desert - northeast corner)",
            address: 0x180005,
            accessRequirements: { items in
                return items.contains(Item.MagicMirror)
            }
        ),
    ]
}

func easternDarkWorldDeathMountainItems() -> Locations {
    return [
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "Piece of Heart (Death Mountain - floating island)",
            address: 0x180141,
            accessRequirements: { items in
                // No hookshot here, just the invisible path
                return items.containsAll(Item.MagicMirror, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [top chest]",
            address: 0xEA7C
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [bottom chest]",
            address: 0xEA7F
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [top right chest]",
            address: 0xEB51,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [top left chest]",
            address: 0xEB54,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom left chest]",
            address: 0xEB57,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom right chest]",
            address: 0xEB5A,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
                    // not actually required here, but stops some deadlocks
                    && items.contains(Item.FireRod)
            }
        ),
    ]
}
