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

// MARK: Progression (deadlock prevention)
/**
 (Substitute the randomized medallion for Quake)

 The entrance to TRock require Quake and Cane of Somaria. Neither is
 individually required for any location, so during item placement neither will
 be selected during the search for expansion-enabling items unless the other had
 already been selected totally at random. This can cause the unlucky
 circumstance of filling all remaining chests with junk items and deadlocking
 progress.

 The locations in here create artification progression so that the items *do*
 get picked up during the expansion search. They get filtered out as potential
 destinatons during placement so no items get vanished.
 */
func progressionItems() -> Locations {
    return [
        Location(
            region: Region.Progression,
            name: "Undeadlock: Turtle Rock Medallion",
            address: nil,
            item: Item.Nothing,
            accessRequirements: { items in
                return items.contains(items.findTurtleRockRequiredMedallion())
            }
        ),
        Location(
            region: Region.Progression,
            name: "Undeadlock: Cane of Somaria",
            address: nil,
            item: Item.Nothing,
            accessRequirements: { items in
                return items.contains(Item.CaneOfSomaria)
            }
        ),
    ]
}

// MARK: LW Overworld

func lightWorldItems() -> Locations {
    return [
        Location(
            region: Region.LightWorld,
            name: "[cave-018] Graveyard - top right grave",
            address: 0xE97A,
            item: Item.Cape,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
                    && (items.canLiftHeavyRocks()
                        || (items.canAccessNorthWestDarkWorld()
                            && items.containsAll(Item.MagicMirror, Item.MoonPearl)))
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-047] Dam",
            address: 0xE98C,
            item: Item.ThreeBombs
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-031] Tavern",
            address: 0xE9CE,
            item: Item.Bottle
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-026] chicken house",
            address: 0xE9E9,
            item: Item.TenArrows
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-044] Aginah's cave",
            address: 0xE9F2,
            item: Item.PieceOfHeart
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [left chest]",
            address: 0xEA82,
            item: Item.FiftyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [center chest]",
            address: 0xEA85,
            item: Item.ThreeBombs
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [right chest]",
            address: 0xEA88,
            item: Item.FiftyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [top chest]",
            address: 0xEA8E,
            item: Item.PieceOfHeart
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [left chest row of 3]",
            address: 0xEA91,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [center chest row of 3]",
            address: 0xEA94,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [right chest row of 3]",
            address: 0xEA97,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [bottom chest]",
            address: 0xEA9A,
            item: Item.ThreeBombs
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top chest]",
            address: 0xEB0F,
            item: Item.PieceOfHeart
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top left chest]",
            address: 0xEB12,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top right chest]",
            address: 0xEB15,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [bottom left chest]",
            address: 0xEB18,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [bottom right chest]",
            address: 0xEB1B,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-016] cave under rocks west of Santuary",
            address: 0xEB3F,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [bottom left chest]",
            address: 0xEB42,
            item: Item.ThreeBombs
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [top left chest]",
            address: 0xEB45,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [top right chest]",
            address: 0xEB48,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [bottom right chest]",
            address: 0xEB4B,
            item: Item.TenArrows
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-051] Ice Cave",
            address: 0xEB4E,
            item: Item.IceRod
        ),
        //// Getting anything other than the sword here can be bad for progress... may as well keep the sword here since you can't use it if you get it before the uncle.
        //Location(
        //    lateGameItem: false,
        //    region: Region.LightWorld,
        //    name: "Uncle",
        //    address: 0x2DF45,
        //    item: Item.Nothing,
        //    accessRequirements: { items in
        //        return true
        //    }
        //),
        Location(
            region: Region.LightWorld,
            name: "Bottle Vendor",
            address: 0x2EB18,
            item: Item.Bottle
        ),
        Location(
            region: Region.LightWorld,
            name: "Sahasrahla",
            address: 0x2F1FC,
            item: Item.PegasusBoots,
            accessRequirements: { items in
                return items.canDefeatEasternPalace()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Sick Kid",
            address: 0x339CF,
            item: Item.BugCatchingNet,
            accessRequirements: { items in
                return items.hasAnyBottle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Hobo",
            address: 0x33E7D,
            item: Item.Bottle,
            accessRequirements: { items in
                return items.contains(Item.Flippers)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Ether Tablet",
            address: 0x48B7C,
            item: Item.Ether,
            accessRequirements: { items in
                return items.canEnterTowerOfHera()
                    && items.canGetAtLeastMasterSword()
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
            address: 0x180000,
            item: Item.PieceOfHeart
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Lumberjack Tree)",
            address: 0x180001,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.canDefeatAgahnim1()
                    && items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia - generous guy",
            address: 0x180010,
            item: Item.ThreeHundredRupees
        ),
        Location(
            region: Region.LightWorld,
            name: "Library",
            address: 0x180012,
            item: Item.BookOfMudora,
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Maze Race)",
            address: 0x180142,
            item: Item.PieceOfHeart
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Desert - west side)",
            address: 0x180143,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.contains(Item.BookOfMudora)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Dam)",
            address: 0x180145,
            item: Item.PieceOfHeart
        ),
        Location(
            region: Region.LightWorld,
            name: "Mushroom",
            address: 0x180013,
            item: Item.Mushroom
        ),
        Location(
            region: Region.LightWorld,
            name: "Witch",
            address: 0x180014,
            item: Item.Powder,
            accessRequirements: { items in
                return items.contains(Item.Mushroom)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Haunted Grove Item",
            address: 0x18014A,
            item: Item.OcarinaInactive
        ),
    ]
}

func lightWorthDeathMountainItems() -> Locations {
    return [
        Location(
            region: Region.LightWorldDeathMountain,
            name: "Old mountain man",
            address: 0xF69FA,
            item: Item.MagicMirror
        ),
        Location(
            region: Region.LightWorldDeathMountain,
            name: "Piece of Heart (Spectacle Rock Cave)",
            address: 0x180002,
            item: Item.PieceOfHeart
        ),
        Location(
            region: Region.LightWorldDeathMountain,
            name: "Piece of Heart (Spectacle Rock)",
            address: 0x180140,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.contains(Item.MagicMirror)
            }
        ),
        // This is technically in DW directly below the warp tile
        Location(
            region: Region.LightWorldDeathMountain,
            name: "[cave-055] Spike cave",
            address: 0xEA8B,
            item: Item.StaffOfByrna,
            accessRequirements: { items in
                return items.canLiftRocks()
                    && items.containsAll(Item.MoonPearl, Item.Hammer)
            }
        ),
    ]
}

func lightWorldEasternDeathMountainItems() -> Locations {
    return [
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left chest]",
            address: 0xEB2A,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left middle chest]",
            address: 0xEB2D,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right middle chest]",
            address: 0xEB30,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right chest]",
            address: 0xEB33,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [bottom chest]",
            address: 0xEB36,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-B1] Death Mountain - wall of caves - right cave [left chest]",
            address: 0xEB39,
            item: Item.ThreeBombs
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-009-B1] Death Mountain - wall of caves - right cave [right chest]",
            address: 0xEB3C,
            item: Item.TenArrows
        ),
        Location(
            region: Region.LightWorldEasternDeathMountain,
            name: "[cave-012-1F] Death Mountain - wall of caves - left cave",
            address: 0xE9BF,
            item: Item.FiftyRupees
        ),
    ]
}

func zorasDomainItems() -> Locations {
    return [
        // Zora's appearance is based on if you items flippers or not
        Location(
            region: Region.ZorasDomain,
            name: "King Zora",
            address: 0xEE1C3,
            item: Item.Flippers,
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
            region: Region.ZorasDomain,
            name: "Piece of Heart (Zora's River)",
            address: 0x180149,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.contains(Item.Flippers)
            }
        ),
    ]
}

// MARK: LW Dungeons

func hyruleEscapeItems() -> Locations {
    // If you get a sword or shield upgrade before reaching your uncle (link's house chest only), it looks like he hands you the upgraded item but it's just a visual bug and they get reset
    // If you get a sword upgrade before entering the room with Zelda's jail cell, she won't spawn and the game is deadlocked
    var linksHouse = Location(
        region: Region.HyruleCastleEscape,
        name: "[cave-040] Link's House",
        address: 0xE9BC,
        item: Item.Lamp
    )
    linksHouse.canHoldItem = { !$0.isSword && !$0.isShield }

    var secret = Location(
        region: Region.HyruleCastleEscape,
        name: "[cave-034] Hyrule Castle secret entrance",
        address: 0xE971,
        item: Item.FiveRupees
    )
    secret.canHoldItem = { !$0.isSword }

    var map = Location(
        region: Region.HyruleCastleEscape,
        name: "[dungeon-C-B1] Hyrule Castle - map room",
        address: 0xEB0C,
        item: Item.Map,
        rules: DungeonRules(zone: 0, bigKeyZone: false)
    )
    map.canHoldItem = { !$0.isSword }

    var boomerang = Location(
        region: Region.HyruleCastleEscape,
        name: "[dungeon-C-B1] Hyrule Castle - boomerang room",
        address: 0xE974,
        item: Item.Boomerang,
        rules: DungeonRules(zone: 1, bigKeyZone: false)
    )
    boomerang.canHoldItem = { !$0.isSword }

    return [
        linksHouse,
        secret,
        map,
        boomerang,
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B3] Hyrule Castle - next to Zelda",
            address: 0xEB09,
            item: Item.FiveRupees,
            rules: DungeonRules(zone: 2, bigKeyZone: false) // Technically it is needed, but BK doesn't spawn in a chest so this would break
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - first B1 room",
            address: 0xE96E,
            item: Item.Key,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - final basement room [left chest]",
            address: 0xEB5D,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.canLiftRocks()
            }
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - final basement room [middle chest]",
            address: 0xEB60,
            item: Item.ThreeHundredRupees,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.canLiftRocks()
            }
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B1] Escape - final basement room [right chest]",
            address: 0xEB63,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.canLiftRocks()
            }
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-1F] Sanctuary",
            address: 0xEA79,
            item: Item.HeartContainer,
            rules: DungeonRules(zone: 4, bigKeyZone: false)
        ),
    ]
}

func easternPalaceItems() -> Locations {
    return [
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - compass room",
            address: 0xE977,
            item: Item.Compass,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - big chest",
            address: 0xE97D,
            item: Item.Bow,
            rules: DungeonRules(zone: 0, bigKeyZone: true)
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - big ball room",
            address: 0xE9B3,
            item: Item.OneHundredRupees,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - Big key",
            address: 0xE9B9,
            item: Item.BigKey,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.EasternPalace,
            name: "[dungeon-L1-1F] Eastern Palace - map room",
            address: 0xE9F5,
            item: Item.Map,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
    ]
}

func desertPalaceItems() -> Locations {
    return [
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - big chest",
            address: 0xE98F,
            item: Item.PowerGlove,
            rules: DungeonRules(zone: 0, bigKeyZone: true),
            accessRequirements: { $0.contains(.PegasusBoots) }
        ),
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - Map room",
            address: 0xE9B6,
            item: Item.Map,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - Big key room",
            address: 0xE9C2,
            item: Item.BigKey,
            rules: DungeonRules(zone: 1, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - compass room",
            address: 0xE9CB,
            item: Item.Compass,
            rules: DungeonRules(zone: 1, bigKeyZone: false),
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
            address: 0xE9AD,
            item: Item.Map,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.TowerOfHera,
            name: "[dungeon-L3-1F] Tower of Hera - first floor",
            address: 0xE9E6,
            item: Item.BigKey,
            rules: DungeonRules(zone: 1, bigKeyZone: false),
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.TowerOfHera,
            name: "[dungeon-L3-4F] Tower of Hera - big chest",
            address: 0xE9F8,
            item: Item.MoonPearl,
            rules: DungeonRules(zone: 0, bigKeyZone: true)
        ),
        Location(
            region: Region.TowerOfHera,
            name: "[dungeon-L3-4F] Tower of Hera - 4F [small chest]",
            address: 0xE9FB,
            item: Item.Compass,
            rules: DungeonRules(zone: 0, bigKeyZone: true)
        ),
    ]
}

func hyruleCastleTowerItems() -> Locations {
    return [
        Location(
            region: Region.HyruleCastleTower,
            name: "[dungeon-A1-3F] Hyrule Castle Tower - maze room",
            address: 0xEAB2,
            item: Item.Key,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.HyruleCastleTower,
            name: "[dungeon-A1-2F] Hyrule Castle Tower - 2 knife guys room",
            address: 0xEAB5,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
    ]
}

// MARK: DW Overworld

func darkWorldPyramidItems() -> Locations {
    return [
        Location(
            region: Region.DarkWorldPyramid,
            name: "Catfish",
            address: 0xEE185,
            item: Item.Quake,
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
        Location(
            region: Region.DarkWorldPyramid,
            name: "Piece of Heart (Pyramid)",
            address: 0x180147,
            item: Item.PieceOfHeart
        ),
    ]
}

func southDarkWorldItems() -> Locations {
    return [
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [top chest]",
            address: 0xEB1E,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [top middle chest]",
            address: 0xEB21,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [bottom middle chest]",
            address: 0xEB24,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace [bottom chest]",
            address: 0xEB27,
            item: Item.TwentyRupees
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "Flute Boy",
            address: 0x330C7,
            item: Item.Shovel
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "[cave-073] cave northeast of swamp palace - generous guy",
            address: 0x180011,
            item: Item.ThreeHundredRupees
        ),
        // Technically spawns in LW (warp from peg area)
        Location(
            region: Region.DarkWorldSouth,
            name: "Bombos Tablet",
            address: 0x48B81,
            item: Item.Bombos,
            accessRequirements: { items in
                return items.canGetAtLeastMasterSword()
                    && items.containsAll(Item.BookOfMudora, Item.MagicMirror)
            },
            onPatchingRom: { rom, item in
                // Inventory item check?
                rom.patch(atByteOffset: 0x44AAE, withData: item.asData())
            }
        ),
        // Technically spawns in LW (warp from circle of bushes)
        Location(
            region: Region.DarkWorldSouth,
            name: "Piece of Heart (south of Haunted Grove)",
            address: 0x180003,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.contains(Item.MagicMirror)
            }
        ),
        // Technically spawns in LW (warp from circle of stones in lake)
        Location(
            region: Region.DarkWorldSouth,
            name: "Piece of Heart (Lake Hylia)",
            address: 0x180144,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.containsAll(Item.Flippers, Item.MagicMirror)
            }
        ),
        Location(
            region: Region.DarkWorldSouth,
            name: "Piece of Heart (Digging Game)",
            address: 0x180148,
            item: Item.PieceOfHeart
        ),
    ]
}

func northWestDarkWorldItems() -> Locations {
    return [
        Location(
            // If you've already picked up the blue boomerang, this spawns 300 rupees in a normal run
            region: Region.DarkWorldNorthWest,
            name: "[cave-063] doorless hut",
            address: 0xE9EC,
            item: Item.RedBoomerang
        ),
        Location(
            region: Region.DarkWorldNorthWest,
            name: "[cave-062] C-shaped house",
            address: 0xE9EF,
            item: Item.ThreeHundredRupees
        ),
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Piece of Heart (Dark World blacksmith pegs)",
            address: 0x180006,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.canLiftHeavyRocks()
                    && items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Piece of Heart (Dark World - bumper cave)",
            address: 0x180146,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.containsAll(Item.Cape, Item.Hookshot)
            }
        ),
        // Technically item is in LW, but put here for access reqs
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Purple Chest",
            address: 0x33D68,
            item: Item.Bottle,
            accessRequirements: { items in
                return items.canLiftHeavyRocks()
                    && items.contains(Item.MagicMirror)
            }
        ),
        // Same
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Piece of Heart (Graveyard)",
            address: 0x180004,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.contains(Item.MagicMirror)
            }
        ),
        Location(
            region: Region.DarkWorldNorthWest,
            name: "Piece of Heart (Treasure Chest Game)",
            address: 0xEDA8,
            item: Item.PieceOfHeart
        ),
    ]
}

func mireItems() -> Locations {
    return [
        Location(
            region: Region.DarkWorldMire,
            name: "[cave-071] Misery Mire west area [left chest]",
            address: 0xEA73,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.contains(.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldMire,
            name: "[cave-071] Misery Mire west area [right chest]",
            address: 0xEA76,
            item: Item.TwentyRupees,
            accessRequirements: { items in
                return items.contains(.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldMire,
            name: "Piece of Heart (Desert - northeast corner)",
            address: 0x180005,
            item: Item.PieceOfHeart,
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
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.containsAll(Item.MagicMirror, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [top chest]",
            address: 0xEA7C,
            item: Item.ThreeBombs,
            accessRequirements: { $0.contains(.MoonPearl) }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [bottom chest]",
            address: 0xEA7F,
            item: Item.TwentyRupees,
            accessRequirements: { $0.contains(.MoonPearl) }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [top right chest]",
            address: 0xEB51,
            item: Item.FiftyRupees,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [top left chest]",
            address: 0xEB54,
            item: Item.FiftyRupees,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom left chest]",
            address: 0xEB57,
            item: Item.FiftyRupees,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
            }
        ),
        Location(
            region: Region.DarkWorldEasternDeathMountain,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom right chest]",
            address: 0xEB5A,
            item: Item.FiftyRupees,
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.MoonPearl)
                    // not actually required here, but stops some deadlocks
                    && items.contains(Item.FireRod)
            }
        ),
    ]
}

// MARK: DW Dungeons

func darkPalaceItems() -> Locations {
    return [
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - big key room",
            address: 0xEA37,
            item: Item.BigKey,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - jump room [right chest]",
            address: 0xEA3A,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false),
            accessRequirements: { items in
                return items.hasAnyBow()
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - jump room [left chest]",
            address: 0xEA3D,
            item: Item.Key,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - big chest",
            address: 0xEA40,
            item: Item.Hammer,
            rules: DungeonRules(zone: 3, bigKeyZone: true),
            accessRequirements: { items in
                // FIXME: bow shouldn't be strictly required here
                return items.contains(Item.Lamp) && items.hasAnyBow()
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - compass room",
            address: 0xEA43,
            item: Item.Compass,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - spike statue room",
            address: 0xEA46,
            item: Item.FiveRupees,
            rules: DungeonRules(zone: 3, bigKeyZone: false)
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - turtle stalfos room",
            address: 0xEA49,
            item: Item.Key,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - room leading to Helmasaur [left chest]",
            address: 0xEA4C,
            item: Item.Arrow,
            rules: DungeonRules(zone: 2, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - room leading to Helmasaur [right chest]",
            address: 0xEA4F,
            item: Item.Key,
            rules: DungeonRules(zone: 2, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - statue push room",
            address: 0xEA52,
            item: Item.Map,
            rules: DungeonRules(zone: 0, bigKeyZone: false),
            accessRequirements: { items in
                return items.hasAnyBow()
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - maze room [top chest]",
            address: 0xEA55,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 3, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - maze room [bottom chest]",
            address: 0xEA58,
            item: Item.Key,
            rules: DungeonRules(zone: 3, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - shooter room",
            address: 0xEA5B,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
    ]
}

func swampPalaceItems() -> Locations {
    return [
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - map room",
            address: 0xE986,
            item: Item.Map,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - big chest",
            address: 0xE989,
            item: Item.Hookshot,
            rules: DungeonRules(zone: 3, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-1F] Swamp Palace - first room",
            address: 0xEA9D,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - south of hookshot room",
            address: 0xEAA0,
            item: Item.Compass,
            rules: DungeonRules(zone: 3, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - push 4 blocks room",
            address: 0xEAA3,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - big key room",
            address: 0xEAA6,
            item: Item.BigKey,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B2] Swamp Palace - flooded room [left chest]",
            address: 0xEAA9,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B2] Swamp Palace - flooded room [right chest]",
            address: 0xEAAC,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B2] Swamp Palace - hidden waterfall door room",
            address: 0xEAAF,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.Hammer)
            }
        ),
    ]
}

func skullWoodsItems() -> Locations {
    return [
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Compass room",
            address: 0xE992,
            item: Item.Compass,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - big chest",
            address: 0xE998,
            item: Item.FireRod,
            rules: DungeonRules(zone: 2, bigKeyZone: true)
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - east of Fire Rod room",
            address: 0xE99B,
            item: Item.Map,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Big Key room",
            address: 0xE99E,
            item: Item.BigKey,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Gibdo/Stalfos room",
            address: 0xE9A1,
            item: Item.Key,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - south of Fire Rod room",
            address: 0xE9C8,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Entrance to part 2",
            address: 0xE9FE,
            item: Item.Key,
            rules: DungeonRules(zone: 2, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
    ]
}

func thievesTownItems() -> Locations {
    return [
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Bottom left of huge room [top left chest]",
            address: 0xEA01,
            item: Item.Map,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Bottom left of huge room [bottom right chest]",
            address: 0xEA04,
            item: Item.BigKey,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Bottom right of huge room",
            address: 0xEA07,
            item: Item.Compass,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Top left of huge room",
            address: 0xEA0A,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-1F] Thieves' Town - Room above boss",
            address: 0xEA0D,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 2, bigKeyZone: true)
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B2] Thieves' Town - big chest",
            address: 0xEA10,
            item: Item.TitansMitt,
            rules: DungeonRules(zone: 2, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B2] Thieves' Town - next to Blind",
            address: 0xEA13,
            item: Item.Key,
            rules: DungeonRules(zone: 1, bigKeyZone: true)
        ),
    ]
}

func icePalaceItems() -> Locations {
    return [
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B4] Ice Palace - above Blue Mail room",
            address: 0xE995,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B1] Ice Palace - Big Key room",
            address: 0xE9A4,
            item: Item.BigKey,
            rules: DungeonRules(zone: 2, bigKeyZone: false),
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.Hammer)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B5] Ice Palace - big chest",
            address: 0xE9AA,
            item: Item.BlueMail,
            rules: DungeonRules(zone: 2, bigKeyZone: true),
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.Hammer)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B1] Ice Palace - compass room",
            address: 0xE9D4,
            item: Item.Compass,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B2] Ice Palace - map room",
            address: 0xE9DD,
            item: Item.Map,
            rules: DungeonRules(zone: 2, bigKeyZone: false),
            accessRequirements: { items in
                return items.containsAll(Item.Hookshot, Item.Hammer)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B3] Ice Palace - spike room",
            address: 0xE9E0,
            item: Item.Key,
            rules: DungeonRules(zone: 2, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B5] Ice Palace - b5 up staircase",
            address: 0xE9E3,
            item: Item.Key,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
    ]
}

func miseryMireItems() -> Locations {
    return [
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - spike room",
            address: 0xE9DA,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - big hub room",
            address: 0xEA5E,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - end of bridge",
            address: 0xEA61,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - compass",
            address: 0xEA64,
            item: Item.Compass,
            rules: DungeonRules(zone: 0, bigKeyZone: false),
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - big chest",
            address: 0xEA67,
            item: Item.CaneOfSomaria,
            rules: DungeonRules(zone: 0, bigKeyZone: true),
            accessRequirements: { items in
                return items.containsAny(Item.Hookshot, Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - map room",
            address: 0xEA6A,
            item: Item.Map,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - big key",
            address: 0xEA6D,
            item: Item.BigKey,
            rules: DungeonRules(zone: 0, bigKeyZone: false),
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
    ]
}

func turtleRockItems() -> Locations {
    // FIXME: everywhere except the map room chests don't actually require the
    // Fire Rod. This is a workaround for a shortcoming in dependency solving
    // where available keys aren't considered when placing items in a dungeon.
    return [
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - Chain chomp room",
            address: 0xEA16,
            item: Item.Key,
            rules: DungeonRules(zone: 2, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B1] Turtle Rock - big chest",
            address: 0xEA19,
            item: Item.MirrorShield,
            rules: DungeonRules(zone: 3, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - Map room [left chest]",
            address: 0xEA1C,
            item: Item.Map,
            rules: DungeonRules(zone: 0, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - Map room [right chest]",
            address: 0xEA1F,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - compass room",
            address: 0xEA22,
            item: Item.Compass,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B1] Turtle Rock - big key room",
            address: 0xEA25,
            item: Item.BigKey,
            rules: DungeonRules(zone: 4, bigKeyZone: false),
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [top right chest]",
            address: 0xEA28,
            item: Item.OneRupee,
            rules: DungeonRules(zone: 6, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(.FireRod) && items.containsAny(.MirrorShield, .StaffOfByrna, .Cape)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [top left chest]",
            address: 0xEA2B,
            item: Item.FiveRupees,
            rules: DungeonRules(zone: 6, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(.FireRod) && items.containsAny(.MirrorShield, .StaffOfByrna, .Cape)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [bottom right chest]",
            address: 0xEA2E,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 6, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(.FireRod) && items.containsAny(.MirrorShield, .StaffOfByrna, .Cape)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [bottom left chest]",
            address: 0xEA31,
            item: Item.Key,
            rules: DungeonRules(zone: 6, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(.FireRod) && items.containsAny(.MirrorShield, .StaffOfByrna, .Cape)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B1] Turtle Rock - Roller switch room",
            address: 0xEA34,
            item: Item.Key,
            rules: DungeonRules(zone: 5, bigKeyZone: true),
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        // Technically it's LW, but accessed inside TR
        // FIXME: no key here
        Location(
            region: Region.TurtleRock,
            name: "[cave-013] Mimic cave (from Turtle Rock)",
            address: 0xE9C5,
            item: Item.PieceOfHeart,
            accessRequirements: { items in
                return items.canEnterTurtleRock()
                    // FireRod should not strictly be necessary depending on key placement
                    && items.containsAll(Item.FireRod, Item.MagicMirror)
            }
        ),
    ]
}

func ganonsTowerItems() -> Locations {
    return [
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [top left chest]",
            address: 0xEAB8,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [top right chest]",
            address: 0xEABB,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [bottom left chest]",
            address: 0xEABE,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [bottom right chest]",
            address: 0xEAC1,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [top left chest]",
            address: 0xEAC4,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [top right chest]",
            address: 0xEAC7,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [bottom left chest]",
            address: 0xEACA,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [bottom right chest]",
            address: 0xEACD,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of teleport room",
            address: 0xEAD0,
            item: Item.Key,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - map room",
            address: 0xEAD3,
            item: Item.Map,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - big chest",
            address: 0xEAD6,
            item: Item.RedMail,
            rules: DungeonRules(zone: 2, bigKeyZone: true)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - down right staircase from entrance [left chest]",
            address: 0xEAD9,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - down right staircase from entrance [right chest]",
            address: 0xEADC,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - above Armos",
            address: 0xEADF,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - east of down right staircase from entrace",
            address: 0xEAE2,
            item: Item.Key,
            rules: DungeonRules(zone: 0, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [top left chest]",
            address: 0xEAE5,
            item: Item.Compass,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
            // This room needs FireRod, but it's guaranteed from SW
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [top right chest]",
            address: 0xEAE8,
            item: Item.OneRupee,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [bottom left chest]",
            address: 0xEAEB,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [bottom right chest]",
            address: 0xEAEE,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 1, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [bottom chest]",
            address: 0xEAF1,
            item: Item.BigKey,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [left chest]",
            address: 0xEAF4,
            item: Item.TenArrows,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [right chest]",
            address: 0xEAF7,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 2, bigKeyZone: false)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - north of falling floor four torches [top left chest]",
            address: 0xEAFD,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 3, bigKeyZone: true)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - north of falling floor four torches [top right chest]",
            address: 0xEB00,
            item: Item.ThreeBombs,
            rules: DungeonRules(zone: 3, bigKeyZone: true)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - before Moldorm",
            address: 0xEB03,
            item: Item.Key,
            rules: DungeonRules(zone: 4, bigKeyZone: true)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - Moldorm room",
            address: 0xEB06,
            item: Item.TwentyRupees,
            rules: DungeonRules(zone: 5, bigKeyZone: true)
        ),
    ]
}


func fairyLocations() -> Locations {
    return [
        Location(region: Region.Fairy, name: "Waterfall of Wishing Fairy", address: 0x348FF, item: Item.BottleWithGreenPotion),
        Location(region: Region.Fairy, name: "Cursed Fairy", address: 0x3493B, item: Item.BottleWithGreenPotion),
    ]
}

func entranceLocations() -> Locations {
    return [
        Location(
            region: Region.PatchOnly,
            name: "Misery Mire Entrance Medallion",
            address: nil,
            item: Item.MireEther,
            accessRequirements: { _ in true }, // TODO: remove after tidying initializers
            onPatchingRom: { rom, item in
                var bytes = [(addr: Int, value: UInt8)]()
                switch item {
                case .MireBombos:
                    bytes.append((addr: 0x4FF2, value: 0x31))
                    bytes.append((addr: 0x50D1, value: 0x80))
                    bytes.append((addr: 0x51B0, value: 0))
                    bytes.append((addr: 0x180022, value: 0))
                    break
                case .MireEther:
                    bytes.append((addr: 0x180022, value: 1))
                    break
                case .MireQuake:
                    bytes.append((addr: 0x4FF2, value: 0x31))
                    bytes.append((addr: 0x50D1, value: 0x88))
                    bytes.append((addr: 0x51B0, value: 0))
                    bytes.append((addr: 0x180022, value: 2))
                    break
                default:
                    break
                }
                for byte in bytes {
                    rom.patch(atByteOffset: byte.addr, withData: Data(bytes: [byte.value]))
                }
            }
        ),
        Location(
            region: Region.PatchOnly,
            name: "Turtle Rock Entrance Medallion",
            address: nil,
            item: Item.TRQuake,
            accessRequirements: { _ in true }, // TODO: remove after tidying initializers
            onPatchingRom: { rom, item in
                var bytes = [(addr: Int, value: UInt8)]()
                switch item {
                case .TRBombos:
                    bytes.append((addr: 0x5020, value: 0x31))
                    bytes.append((addr: 0x50FF, value: 0x90))
                    bytes.append((addr: 0x51DE, value: 0))
                    bytes.append((addr: 0x180023, value: 0))
                    break
                case .TREther:
                    bytes.append((addr: 0x5020, value: 0x31))
                    bytes.append((addr: 0x50FF, value: 0x98))
                    bytes.append((addr: 0x51DE, value: 0))
                    bytes.append((addr: 0x180023, value: 1))
                    break
                case .TRQuake:
                    bytes.append((addr: 0x180023, value: 2))
                    break
                default:
                    break
                }
                for byte in bytes {
                    rom.patch(atByteOffset: byte.addr, withData: Data(bytes: [byte.value]))
                }
            }
        ),
    ]
}

func getHalfMagicBatLocation() -> Location {
    return Location(
        region: Region.PatchOnly,
        name: "Magic Bat",
        address: nil,
        item: Item.HalfMagic,
        accessRequirements: { items in
            return items.containsAll(Item.Hammer, Item.Powder)
        },
        onPatchingRom: { rom, item in
            var byte: UInt8
            switch item {
            case .FullMagic:
                byte = 0
                break
            case .HalfMagic:
                byte = 1
                break
            case .QuarterMagic:
                byte = 2
                break
            default:
                return
            }
            rom.patch(atByteOffset: 0x2FBD2, withData: Data(bytes: [byte]))
        }
    )
}
