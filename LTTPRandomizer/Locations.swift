//
//  Locations.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/3/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

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

 The Fire Rod shouldn't be able to create a deadlock but a breaker was present
 in the original version, so I'm leaving it in.

 The locations in here create artification progression so that the items *do*
 get picked up during the expansion search. They get filtered out as potential
 destinatons during placement so no items get vanished.
 */
func progressionItems() -> Locations {
    let r = Region.Progression
    return [
        Location(region: r, name: "Undeadlock: Turtle Rock Medallion", address: nil, item: .Nothing, accessRequirements: { $0.contains($0.findTurtleRockRequiredMedallion()) }),
        Location(region: r, name: "Undeadlock: Cane of Somaria", address: nil, item: .Nothing, accessRequirements: { $0.contains(.CaneOfSomaria) }),
        Location(region: r, name: "Undeadlock: Fire Rod", address: nil, item: .Nothing, accessRequirements: { $0.contains(.FireRod) }),
    ]
}

// MARK: LW Overworld

func lightWorldItems() -> Locations {
    let r = Region.LightWorld

    var ether = Location(region: r, name: "Ether Tablet", address: 0x48B7C, item: .Ether, accessRequirements: { $0.canEnterTowerOfHera() && $0.canGetAtLeastMasterSword() && $0.contains(.BookOfMudora) })
    ether.onPatchingRom = { rom, item in
        // Inventory item check?
        rom.patch(atByteOffset: 0x44AA9, withData: item.asData())
    }

    let capeAccess: (Inventory) -> Bool = { items in
        return items.contains(.PegasusBoots)
            && (items.canLiftHeavyRocks() // LW intended
                || (items.canAccessNorthWestDarkWorld()
                    && items.containsAll(.MagicMirror, .MoonPearl)))
    }

    return [
        ether,
        Location(region: r, name: "[cave-016] cave under rocks west of Santuary", address: 0xEB3F, item: .PieceOfHeart, accessRequirements: { $0.contains(.PegasusBoots) }),
        Location(region: r, name: "[cave-018] Graveyard - top right grave", address: 0xE97A, item: .Cape, accessRequirements: capeAccess),
        Location(region: r, name: "[cave-021] Kakariko well [top chest]", address: 0xEA8E, item: .PieceOfHeart),
        Location(region: r, name: "[cave-021] Kakariko well [left chest row of 3]", address: 0xEA91, item: .TwentyRupees),
        Location(region: r, name: "[cave-021] Kakariko well [center chest row of 3]", address: 0xEA94, item: .TwentyRupees),
        Location(region: r, name: "[cave-021] Kakariko well [right chest row of 3]", address: 0xEA97, item: .TwentyRupees),
        Location(region: r, name: "[cave-021] Kakariko well [bottom chest]", address: 0xEA9A, item: .ThreeBombs),
        Location(region: r, name: "[cave-022-B1] Thief's hut [top chest]", address: 0xEB0F, item: .PieceOfHeart),
        Location(region: r, name: "[cave-022-B1] Thief's hut [top left chest]", address: 0xEB12, item: .TwentyRupees),
        Location(region: r, name: "[cave-022-B1] Thief's hut [top right chest]", address: 0xEB15, item: .TwentyRupees),
        Location(region: r, name: "[cave-022-B1] Thief's hut [bottom left chest]", address: 0xEB18, item: .TwentyRupees),
        Location(region: r, name: "[cave-022-B1] Thief's hut [bottom right chest]", address: 0xEB1B, item: .TwentyRupees),
        Location(region: r, name: "[cave-026] chicken house", address: 0xE9E9, item: .TenArrows),
        Location(region: r, name: "[cave-031] Tavern", address: 0xE9CE, item: .Bottle),
        Location(region: r, name: "[cave-035] Sahasrahla's Hut [left chest]", address: 0xEA82, item: .FiftyRupees),
        Location(region: r, name: "[cave-035] Sahasrahla's Hut [center chest]", address: 0xEA85, item: .ThreeBombs),
        Location(region: r, name: "[cave-035] Sahasrahla's Hut [right chest]", address: 0xEA88, item: .FiftyRupees),
        Location(region: r, name: "[cave-044] Aginah's cave", address: 0xE9F2, item: .PieceOfHeart),
        Location(region: r, name: "[cave-047] Dam", address: 0xE98C, item: .ThreeBombs),
        Location(region: r, name: "[cave-050] cave southwest of Lake Hylia - generous guy", address: 0x180010, item: .ThreeHundredRupees),
        Location(region: r, name: "[cave-050] cave southwest of Lake Hylia [bottom left chest]", address: 0xEB42, item: .ThreeBombs),
        Location(region: r, name: "[cave-050] cave southwest of Lake Hylia [top left chest]", address: 0xEB45, item: .TwentyRupees),
        Location(region: r, name: "[cave-050] cave southwest of Lake Hylia [top right chest]", address: 0xEB48, item: .TwentyRupees),
        Location(region: r, name: "[cave-050] cave southwest of Lake Hylia [bottom right chest]", address: 0xEB4B, item: .TenArrows),
        Location(region: r, name: "[cave-051] Ice Cave", address: 0xEB4E, item: .IceRod),
        Location(region: r, name: "Bottle Vendor", address: 0x2EB18, item: .Bottle),
        Location(region: r, name: "Haunted Grove Item", address: 0x18014A, item: .OcarinaInactive, accessRequirements: { $0.contains(.Shovel) }),
        Location(region: r, name: "Hobo", address: 0x33E7D, item: .Bottle, accessRequirements: { $0.contains(.Flippers) }),
        Location(region: r, name: "Library", address: 0x180012, item: .BookOfMudora, accessRequirements: { $0.contains(.PegasusBoots) }),
        Location(region: r, name: "Mushroom", address: 0x180013, item: .Mushroom),
        Location(region: r, name: "Piece of Heart (Dam)", address: 0x180145, item: .PieceOfHeart),
        Location(region: r, name: "Piece of Heart (Desert - west side)", address: 0x180143, item: .PieceOfHeart, accessRequirements: { $0.contains(.BookOfMudora) }),
        Location(region: r, name: "Piece of Heart (Lumberjack Tree)", address: 0x180001, item: .PieceOfHeart, accessRequirements: { $0.canDefeatAgahnim1() && $0.contains(.PegasusBoots) }),
        Location(region: r, name: "Piece of Heart (Maze Race)", address: 0x180142, item: .PieceOfHeart),
        Location(region: r, name: "Piece of Heart (Thieves' Forest Hideout)", address: 0x180000, item: .PieceOfHeart),
        Location(region: r, name: "Sahasrahla", address: 0x2F1FC, item: .PegasusBoots, accessRequirements: { $0.canDefeatEasternPalace() }),
        Location(region: r, name: "Sick Kid", address: 0x339CF, item: .BugCatchingNet, accessRequirements: { $0.hasAnyBottle() }),
        Location(region: r, name: "Witch", address: 0x180014, item: .Powder, accessRequirements: { $0.contains(.Mushroom) }),
    ]
}

func lightWorthDeathMountainItems() -> Locations {
    let r = Region.LightWorldDeathMountain
    return [
        Location(region: r, name: "Old mountain man", address: 0xF69FA, item: .MagicMirror),
        Location(region: r, name: "Piece of Heart (Spectacle Rock Cave)", address: 0x180002, item: .PieceOfHeart),
        Location(region: r, name: "Piece of Heart (Spectacle Rock)", address: 0x180140, item: .PieceOfHeart, accessRequirements: { $0.contains(.MagicMirror) }),
        // This is technically in DW directly below the warp tile
        Location(region: r, name: "[cave-055] Spike cave", address: 0xEA8B, item: .StaffOfByrna, accessRequirements: { $0.canLiftRocks() && $0.containsAll(.MoonPearl, .Hammer) }),
    ]
}

func lightWorldEasternDeathMountainItems() -> Locations {
    let r = Region.LightWorldEasternDeathMountain
    return [
        Location(region: r, name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left chest]", address: 0xEB2A, item: .TwentyRupees),
        Location(region: r, name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left middle chest]", address: 0xEB2D, item: .TwentyRupees),
        Location(region: r, name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right middle chest]", address: 0xEB30, item: .TwentyRupees),
        Location(region: r, name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right chest]", address: 0xEB33, item: .TwentyRupees),
        Location(region: r, name: "[cave-009-1F] Death Mountain - wall of caves - right cave [bottom chest]", address: 0xEB36, item: .TwentyRupees),
        Location(region: r, name: "[cave-009-B1] Death Mountain - wall of caves - right cave [left chest]", address: 0xEB39, item: .ThreeBombs),
        Location(region: r, name: "[cave-009-B1] Death Mountain - wall of caves - right cave [right chest]", address: 0xEB3C, item: .TenArrows),
        Location(region: r, name: "[cave-012-1F] Death Mountain - wall of caves - left cave", address: 0xE9BF, item: .FiftyRupees),
    ]
}

func zorasDomainItems() -> Locations {
    let r = Region.ZorasDomain

    var zora = Location(region: r, name: "King Zora", address: 0xEE1C3, item: .Flippers)
    zora.onPatchingRom = { rom, item in
        // (This is a guess based on the Windows source)
        // Indicates what item's presence will block the Zora scene
        rom.patch(atByteOffset: 0x180200, withData: item.bytesForInventoryCheckOverride)
        // Update end-game credits
        rom.patch(atByteOffset: 0x76A85, withData: item.bytesForCredits)
    }

    return [
        zora,
        Location(region: r, name: "Piece of Heart (Zora's River)", address: 0x180149, item: .PieceOfHeart, accessRequirements: { $0.contains(.Flippers) }),
    ]
}

// MARK: LW Dungeons

func hyruleEscapeItems() -> Locations {
    let r = Region.HyruleCastleEscape
    // If you get a sword or shield upgrade before reaching your uncle (link's house chest only), it looks like he hands you the upgraded item but it's just a visual bug and they get reset
    // If you get a sword upgrade before entering the room with Zelda's jail cell, she won't spawn and the game is deadlocked
    var linksHouse = Location(region: r, name: "[cave-040] Link's House", address: 0xE9BC, item: .Lamp)
    linksHouse.canHoldItem = { !$0.isSword && !$0.isShield }

    var secret = Location(region: r, name: "[cave-034] Hyrule Castle secret entrance", address: 0xE971, item: .FiveRupees)
    secret.canHoldItem = { !$0.isSword }

    var map = Location(region: r, name: "[dungeon-C-B1] Hyrule Castle - map room", address: 0xEB0C, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false))
    map.canHoldItem = { !$0.isSword }

    var boomerang = Location(region: r, name: "[dungeon-C-B1] Hyrule Castle - boomerang room", address: 0xE974, item: .Boomerang, rules: DungeonRules(zone: 1, bigKeyZone: false))
    boomerang.canHoldItem = { !$0.isSword }

    return [
        linksHouse,
        secret,
        map,
        boomerang,
        // Location(region: r, name: "Uncle", address: 0x2DF45, item: .L1SwordAndShield) // Leave your uncle alone
        Location(region: r, name: "[dungeon-C-B3] Hyrule Castle - next to Zelda", address: 0xEB09, item: .FiveRupees, rules: DungeonRules(zone: 2, bigKeyZone: false)), // Technically it is needed, but BK doesn't spawn in a chest so this would break
        Location(region: r, name: "[dungeon-C-B1] Escape - first B1 room", address: 0xE96E, item: .Key, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-C-B1] Escape - final basement room [left chest]", address: 0xEB5D, item: .ThreeBombs, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.canLiftRocks() }),
        Location(region: r, name: "[dungeon-C-B1] Escape - final basement room [middle chest]", address: 0xEB60, item: .ThreeHundredRupees, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.canLiftRocks() }),
        Location(region: r, name: "[dungeon-C-B1] Escape - final basement room [right chest]", address: 0xEB63, item: .TenArrows, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.canLiftRocks() }),
        Location(region: r, name: "[dungeon-C-1F] Sanctuary", address: 0xEA79, item: .HeartContainer, rules: DungeonRules(zone: 4, bigKeyZone: false)),
    ]
}

func easternPalaceItems() -> Locations {
    let r = Region.EasternPalace
    return [
        Location(region: r, name: "[dungeon-L1-1F] Eastern Palace - compass room", address: 0xE977, item: .Compass, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-L1-1F] Eastern Palace - big chest", address: 0xE97D, item: .Bow, rules: DungeonRules(zone: 0, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-L1-1F] Eastern Palace - big ball room", address: 0xE9B3, item: .OneHundredRupees, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-L1-1F] Eastern Palace - Big key", address: 0xE9B9, item: .BigKey, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-L1-1F] Eastern Palace - map room", address: 0xE9F5, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false)),
    ]
}

func desertPalaceItems() -> Locations {
    let r = Region.DesertPalace
    return [
        Location(region: r, name: "[dungeon-L2-B1] Desert Palace - big chest", address: 0xE98F, item: .PowerGlove, rules: DungeonRules(zone: 0, bigKeyZone: true), accessRequirements: { $0.contains(.PegasusBoots) }),
        Location(region: r, name: "[dungeon-L2-B1] Desert Palace - Map room", address: 0xE9B6, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-L2-B1] Desert Palace - Big key room", address: 0xE9C2, item: .BigKey, rules: DungeonRules(zone: 1, bigKeyZone: false), accessRequirements: { $0.contains(.PegasusBoots) }),
        Location(region: r, name: "[dungeon-L2-B1] Desert Palace - compass room", address: 0xE9CB, item: .Compass, rules: DungeonRules(zone: 1, bigKeyZone: false), accessRequirements: { $0.contains(.PegasusBoots) }),
    ]
}

func towerOfHeraItems() -> Locations {
    let r = Region.TowerOfHera
    return [
        Location(region: r, name: "[dungeon-L3-2F] Tower of Hera - Entrance", address: 0xE9AD, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-L3-1F] Tower of Hera - first floor", address: 0xE9E6, item: .BigKey, rules: DungeonRules(zone: 1, bigKeyZone: false), accessRequirements: { $0.canLightTorches() }),
        Location(region: r, name: "[dungeon-L3-4F] Tower of Hera - big chest", address: 0xE9F8, item: .MoonPearl, rules: DungeonRules(zone: 0, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-L3-4F] Tower of Hera - 4F [small chest]", address: 0xE9FB, item: .Compass, rules: DungeonRules(zone: 0, bigKeyZone: true)),
    ]
}

func hyruleCastleTowerItems() -> Locations {
    let r = Region.HyruleCastleTower
    return [
        Location(region: r, name: "[dungeon-A1-3F] Hyrule Castle Tower - maze room", address: 0xEAB2, item: .Key, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A1-2F] Hyrule Castle Tower - 2 knife guys room", address: 0xEAB5, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
    ]
}

// MARK: DW Overworld

func darkWorldPyramidItems() -> Locations {
    let r = Region.DarkWorldPyramid
    var catfish = Location(region: r, name: "Catfish", address: 0xEE185, item: .Quake, accessRequirements: { $0.canLiftRocks() && $0.contains(.MoonPearl) })
    // Credits patch
    catfish.onPatchingRom = { rom, item in
        rom.patch(atByteOffset: 0x180204, withData: item.bytesForInventoryCheckOverride)
    }
    return [
        catfish,
        Location(region: r, name: "Piece of Heart (Pyramid)", address: 0x180147, item: .PieceOfHeart),
    ]
}

func southDarkWorldItems() -> Locations {
    let r = Region.DarkWorldSouth

    // Technically spawns in LW (warp from peg area)
    var bombos = Location(region: r, name: "Bombos Tablet", address: 0x48B81, item: .Bombos, accessRequirements: { $0.canGetAtLeastMasterSword() && $0.containsAll(.BookOfMudora, .MagicMirror) })
    bombos.onPatchingRom = { rom, item in
        rom.patch(atByteOffset: 0x44AAE, withData: item.asData())
    }

    return [
        bombos,
        Location(region: r, name: "[cave-073] cave northeast of swamp palace [top chest]", address: 0xEB1E, item: .TwentyRupees),
        Location(region: r, name: "[cave-073] cave northeast of swamp palace [top middle chest]", address: 0xEB21, item: .TwentyRupees),
        Location(region: r, name: "[cave-073] cave northeast of swamp palace [bottom middle chest]", address: 0xEB24, item: .TwentyRupees),
        Location(region: r, name: "[cave-073] cave northeast of swamp palace [bottom chest]", address: 0xEB27, item: .TwentyRupees),
        Location(region: r, name: "[cave-073] cave northeast of swamp palace - generous guy", address: 0x180011, item: .ThreeHundredRupees),
        Location(region: r, name: "Flute Boy", address: 0x330C7, item: .Shovel),
        // Technically spawns in LW (warp from circle of bushes)
        Location(region: r, name: "Piece of Heart (south of Haunted Grove)", address: 0x180003, item: .PieceOfHeart, accessRequirements: { $0.contains(.MagicMirror) }),
        // Technically spawns in LW (warp from circle of stones in lake)
        Location(region: r, name: "Piece of Heart (Lake Hylia)", address: 0x180144, item: .PieceOfHeart, accessRequirements: { $0.containsAll(.Flippers, .MagicMirror) }),
        Location(region: r, name: "Piece of Heart (Digging Game)", address: 0x180148, item: .PieceOfHeart),
    ]
}

func northWestDarkWorldItems() -> Locations {
    let r = Region.DarkWorldNorthWest
    return [
        Location(region: r, name: "[cave-062] C-shaped house", address: 0xE9EF, item: .ThreeHundredRupees),
        // If you've already picked up the blue boomerang, this spawns 300 rupees in a normal run
        Location(region: r, name: "[cave-063] doorless hut", address: 0xE9EC, item: .RedBoomerang),
        Location(region: r, name: "Piece of Heart (Dark World blacksmith pegs)", address: 0x180006, item: .PieceOfHeart, accessRequirements: { $0.canLiftHeavyRocks() && $0.contains(.Hammer) }),
        Location(region: r, name: "Piece of Heart (Dark World - bumper cave)", address: 0x180146, item: .PieceOfHeart, accessRequirements: { $0.containsAll(.Cape, .Hookshot) }),
        // Technically item is in LW, but put here for access reqs
        Location(region: r, name: "Piece of Heart (Graveyard)", address: 0x180004, item: .PieceOfHeart, accessRequirements: { $0.contains(.MagicMirror) }),
        Location(region: r, name: "Piece of Heart (Treasure Chest Game)", address: 0xEDA8, item: .PieceOfHeart),
        // Same
        Location(region: r, name: "Purple Chest", address: 0x33D68, item: .Bottle, accessRequirements: { $0.canLiftHeavyRocks() && $0.contains(.MagicMirror) }),
    ]
}

func mireItems() -> Locations {
    let r = Region.DarkWorldMire
    return [
        Location(region: r, name: "[cave-071] Misery Mire west area [left chest]", address: 0xEA73, item: .PieceOfHeart, accessRequirements: { $0.contains(.MoonPearl) }),
        Location(region: r, name: "[cave-071] Misery Mire west area [right chest]", address: 0xEA76, item: .TwentyRupees, accessRequirements: { $0.contains(.MoonPearl) }),
        Location(region: r, name: "Piece of Heart (Desert - northeast corner)", address: 0x180005, item: .PieceOfHeart, accessRequirements: { $0.contains(.MagicMirror) }),
    ]
}

func easternDarkWorldDeathMountainItems() -> Locations {
    let r = Region.DarkWorldEasternDeathMountain
    return [
        Location(region: r, name: "Piece of Heart (Death Mountain - floating island)", address: 0x180141, item: .PieceOfHeart, accessRequirements: { $0.contains(.MagicMirror) }),
        Location(region: r, name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [top chest]", address: 0xEA7C, item: .ThreeBombs),
        Location(region: r, name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [bottom chest]", address: 0xEA7F, item: .TwentyRupees),
        Location(region: r, name: "[cave-056] Dark World Death Mountain - cave under boulder [top right chest]", address: 0xEB51, item: .FiftyRupees, accessRequirements: { $0.contains(.Hookshot) }),
        Location(region: r, name: "[cave-056] Dark World Death Mountain - cave under boulder [top left chest]", address: 0xEB54, item: .FiftyRupees, accessRequirements: { $0.contains(.Hookshot) }),
        Location(region: r, name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom left chest]", address: 0xEB57, item: .FiftyRupees, accessRequirements: { $0.contains(.Hookshot) }),
        Location(region: r, name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom right chest]", address: 0xEB5A, item: .FiftyRupees, accessRequirements: { $0.contains(.Hookshot) }),
    ]
}

// MARK: DW Dungeons

func darkPalaceItems() -> Locations {
    let r = Region.DarkPalace
    // Note: None of the lamp requirements are strictly necessary, but the room
    // will be totally dark without it which is fully miserable
    return [
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - big key room", address: 0xEA37, item: .BigKey, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - jump room [right chest]", address: 0xEA3A, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false), accessRequirements: { $0.hasAnyBow() }),
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - jump room [left chest]", address: 0xEA3D, item: .Key, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        // FIXME: bow shouldn't be strictly required here
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - big chest", address: 0xEA40, item: .Hammer, rules: DungeonRules(zone: 3, bigKeyZone: true), accessRequirements: { $0.contains(.Lamp) && $0.hasAnyBow() }),
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - compass room", address: 0xEA43, item: .Compass, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - spike statue room", address: 0xEA46, item: .FiveRupees, rules: DungeonRules(zone: 3, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D1-B1] Dark Palace - turtle stalfos room", address: 0xEA49, item: .Key, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D1-B1] Dark Palace - room leading to Helmasaur [left chest]", address: 0xEA4C, item: .Arrow, rules: DungeonRules(zone: 2, bigKeyZone: false), accessRequirements: { $0.contains(.Lamp) }),
        Location(region: r, name: "[dungeon-D1-B1] Dark Palace - room leading to Helmasaur [right chest]", address: 0xEA4F, item: .Key, rules: DungeonRules(zone: 2, bigKeyZone: false), accessRequirements: { $0.contains(.Lamp) }),
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - statue push room", address: 0xEA52, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false), accessRequirements: { $0.hasAnyBow() }),
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - maze room [top chest]", address: 0xEA55, item: .ThreeBombs, rules: DungeonRules(zone: 3, bigKeyZone: false), accessRequirements: { $0.contains(.Lamp) }),
        Location(region: r, name: "[dungeon-D1-1F] Dark Palace - maze room [bottom chest]", address: 0xEA58, item: .Key, rules: DungeonRules(zone: 3, bigKeyZone: false), accessRequirements: { $0.contains(.Lamp) }),
        Location(region: r, name: "[dungeon-D1-B1] Dark Palace - shooter room", address: 0xEA5B, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
    ]
}

func swampPalaceItems() -> Locations {
    let r = Region.SwampPalace
    return [
        Location(region: r, name: "[dungeon-D2-B1] Swamp Palace - map room", address: 0xE986, item: .Map, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D2-B1] Swamp Palace - big chest", address: 0xE989, item: .Hookshot, rules: DungeonRules(zone: 3, bigKeyZone: true), accessRequirements: { $0.contains(.Hammer) }),
        Location(region: r, name: "[dungeon-D2-1F] Swamp Palace - first room", address: 0xEA9D, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D2-B1] Swamp Palace - south of hookshot room", address: 0xEAA0, item: .Compass, rules: DungeonRules(zone: 3, bigKeyZone: false), accessRequirements: { $0.contains(.Hammer) }),
        Location(region: r, name: "[dungeon-D2-B1] Swamp Palace - push 4 blocks room", address: 0xEAA3, item: .TwentyRupees, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.contains(.Hammer) }),
        Location(region: r, name: "[dungeon-D2-B1] Swamp Palace - big key room", address: 0xEAA6, item: .BigKey, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.contains(.Hammer) }),
        Location(region: r, name: "[dungeon-D2-B2] Swamp Palace - flooded room [left chest]", address: 0xEAA9, item: .TwentyRupees, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.containsAll(.Hookshot, .Hammer) }),
        Location(region: r, name: "[dungeon-D2-B2] Swamp Palace - flooded room [right chest]", address: 0xEAAC, item: .TwentyRupees, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.containsAll(.Hookshot, .Hammer) }),
        Location(region: r, name: "[dungeon-D2-B2] Swamp Palace - hidden waterfall door room", address: 0xEAAF, item: .TwentyRupees, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: { $0.containsAll(.Hookshot, .Hammer) }),
    ]
}

func skullWoodsItems() -> Locations {
    let r = Region.SkullWoods
    return [
        Location(region: r, name: "[dungeon-D3-B1] Skull Woods - Compass room", address: 0xE992, item: .Compass, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D3-B1] Skull Woods - big chest", address: 0xE998, item: .FireRod, rules: DungeonRules(zone: 2, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-D3-B1] Skull Woods - east of Fire Rod room", address: 0xE99B, item: .Map, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D3-B1] Skull Woods - Big Key room", address: 0xE99E, item: .BigKey, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D3-B1] Skull Woods - Gibdo/Stalfos room", address: 0xE9A1, item: .Key, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D3-B1] Skull Woods - south of Fire Rod room", address: 0xE9C8, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D3-B1] Skull Woods - Entrance to part 2", address: 0xE9FE, item: .Key, rules: DungeonRules(zone: 2, bigKeyZone: false), accessRequirements: { $0.contains(.FireRod) }),
    ]
}

func thievesTownItems() -> Locations {
    let r = Region.ThievesTown
    return [
        Location(region: r, name: "[dungeon-D4-B1] Thieves' Town - Bottom left of huge room [top left chest]", address: 0xEA01, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D4-B1] Thieves' Town - Bottom left of huge room [bottom right chest]", address: 0xEA04, item: .BigKey, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D4-B1] Thieves' Town - Bottom right of huge room", address: 0xEA07, item: .Compass, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D4-B1] Thieves' Town - Top left of huge room", address: 0xEA0A, item: .TwentyRupees, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D4-1F] Thieves' Town - Room above boss", address: 0xEA0D, item: .ThreeBombs, rules: DungeonRules(zone: 2, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-D4-B2] Thieves' Town - big chest", address: 0xEA10, item: .TitansMitt, rules: DungeonRules(zone: 2, bigKeyZone: true), accessRequirements: { $0.contains(.Hammer) }),
        Location(region: r, name: "[dungeon-D4-B2] Thieves' Town - next to Blind", address: 0xEA13, item: .Key, rules: DungeonRules(zone: 1, bigKeyZone: true)),
    ]
}

func icePalaceItems() -> Locations {
    let r = Region.IcePalace
    return [
        Location(region: r, name: "[dungeon-D5-B4] Ice Palace - above Blue Mail room", address: 0xE995, item: .ThreeBombs, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D5-B1] Ice Palace - Big Key room", address: 0xE9A4, item: .BigKey, rules: DungeonRules(zone: 2, bigKeyZone: false), accessRequirements: { $0.containsAll(.Hookshot, .Hammer) }),
        Location(region: r, name: "[dungeon-D5-B5] Ice Palace - big chest", address: 0xE9AA, item: .BlueMail, rules: DungeonRules(zone: 2, bigKeyZone: true), accessRequirements: { $0.containsAll(.Hookshot, .Hammer) }),
        Location(region: r, name: "[dungeon-D5-B1] Ice Palace - compass room", address: 0xE9D4, item: .Compass, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D5-B2] Ice Palace - map room", address: 0xE9DD, item: .Map, rules: DungeonRules(zone: 2, bigKeyZone: false), accessRequirements: { $0.containsAll(.Hookshot, .Hammer) }),
        Location(region: r, name: "[dungeon-D5-B3] Ice Palace - spike room", address: 0xE9E0, item: .Key, rules: DungeonRules(zone: 2, bigKeyZone: false), accessRequirements: { $0.contains(.Hookshot) }),
        Location(region: r, name: "[dungeon-D5-B5] Ice Palace - b5 up staircase", address: 0xE9E3, item: .Key, rules: DungeonRules(zone: 2, bigKeyZone: false)),
    ]
}

func miseryMireItems() -> Locations {
    let r = Region.MiseryMire
    return [
        Location(region: r, name: "[dungeon-D6-B1] Misery Mire - spike room", address: 0xE9DA, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D6-B1] Misery Mire - big hub room", address: 0xEA5E, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D6-B1] Misery Mire - end of bridge", address: 0xEA61, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D6-B1] Misery Mire - compass", address: 0xEA64, item: .Compass, rules: DungeonRules(zone: 0, bigKeyZone: false), accessRequirements: { $0.canLightTorches() }),
        Location(region: r, name: "[dungeon-D6-B1] Misery Mire - big chest", address: 0xEA67, item: .CaneOfSomaria, rules: DungeonRules(zone: 0, bigKeyZone: true), accessRequirements: { $0.containsAny(.Hookshot, .PegasusBoots) }),
        Location(region: r, name: "[dungeon-D6-B1] Misery Mire - map room", address: 0xEA6A, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-D6-B1] Misery Mire - big key", address: 0xEA6D, item: .BigKey, rules: DungeonRules(zone: 0, bigKeyZone: false), accessRequirements: { $0.canLightTorches() }),
    ]
}

func turtleRockItems() -> Locations {
    let r = Region.TurtleRock

    // FIXME: everywhere except the map room chests don't actually require the
    // Fire Rod. This is a workaround for a shortcoming in dependency solving
    // where available keys aren't considered when placing items in a dungeon;
    // i.e. if the map room key and the compass are swapped, there's no reason
    // that the entire dungeon isn't solvable without the Fire Rod (boss battle
    // excepted)
    let burn: (Inventory) -> Bool = { $0.contains(.FireRod) }
    return [
        Location(region: r, name: "[dungeon-D7-1F] Turtle Rock - compass room", address: 0xEA22, item: .Compass, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        // Actual FR requirement
        Location(region: r, name: "[dungeon-D7-1F] Turtle Rock - Map room [left chest]", address: 0xEA1C, item: .Map, rules: DungeonRules(zone: 0, bigKeyZone: false), accessRequirements: burn),
        Location(region: r, name: "[dungeon-D7-1F] Turtle Rock - Map room [right chest]", address: 0xEA1F, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false), accessRequirements: burn),
        // All fake FR per above
        Location(region: r, name: "[dungeon-D7-1F] Turtle Rock - Chain chomp room", address: 0xEA16, item: .Key, rules: DungeonRules(zone: 2, bigKeyZone: false), accessRequirements: burn),
        Location(region: r, name: "[dungeon-D7-B1] Turtle Rock - big chest", address: 0xEA19, item: .MirrorShield, rules: DungeonRules(zone: 3, bigKeyZone: true), accessRequirements: burn),
        Location(region: r, name: "[dungeon-D7-B1] Turtle Rock - big key room", address: 0xEA25, item: .BigKey, rules: DungeonRules(zone: 4, bigKeyZone: false), accessRequirements: burn),
        Location(region: r, name: "[dungeon-D7-B1] Turtle Rock - Roller switch room", address: 0xEA34, item: .Key, rules: DungeonRules(zone: 5, bigKeyZone: true), accessRequirements: burn),
        // Technically these are doable with no items and just high precision
        // (or maybe boots are required?) but that's just mean
        Location(region: r, name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [top right chest]", address: 0xEA28, item: .OneRupee, rules: DungeonRules(zone: 6, bigKeyZone: true), accessRequirements: { $0.contains(.FireRod) && $0.containsAny(.MirrorShield, .StaffOfByrna, .Cape) }),
        Location(region: r, name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [top left chest]", address: 0xEA2B, item: .FiveRupees, rules: DungeonRules(zone: 6, bigKeyZone: true), accessRequirements: { $0.contains(.FireRod) && $0.containsAny(.MirrorShield, .StaffOfByrna, .Cape) }),
        Location(region: r, name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [bottom right chest]", address: 0xEA2E, item: .TwentyRupees, rules: DungeonRules(zone: 6, bigKeyZone: true), accessRequirements: { $0.contains(.FireRod) && $0.containsAny(.MirrorShield, .StaffOfByrna, .Cape) }),
        Location(region: r, name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [bottom left chest]", address: 0xEA31, item: .Key, rules: DungeonRules(zone: 6, bigKeyZone: true), accessRequirements: { $0.contains(.FireRod) && $0.containsAny(.MirrorShield, .StaffOfByrna, .Cape) }),
        // LW, but accessed from inside TR
        Location(region: r, name: "[cave-013] Mimic cave (from Turtle Rock)", address: 0xE9C5, item: .PieceOfHeart, accessRequirements: { $0.containsAll(.FireRod, .MagicMirror) }),
    ]
}

func ganonsTowerItems() -> Locations {
    let r = Region.GanonsTower
    return [
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [top left chest]", address: 0xEAB8, item: .ThreeBombs, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [top right chest]", address: 0xEABB, item: .TenArrows, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [bottom left chest]", address: 0xEABE, item: .TwentyRupees, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [bottom right chest]", address: 0xEAC1, item: .TwentyRupees, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [top left chest]", address: 0xEAC4, item: .TenArrows, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [top right chest]", address: 0xEAC7, item: .TenArrows, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [bottom left chest]", address: 0xEACA, item: .ThreeBombs, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [bottom right chest]", address: 0xEACD, item: .ThreeBombs, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - north of teleport room", address: 0xEAD0, item: .Key, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - map room", address: 0xEAD3, item: .Map, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - big chest", address: 0xEAD6, item: .RedMail, rules: DungeonRules(zone: 2, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - down right staircase from entrance [left chest]", address: 0xEAD9, item: .TenArrows, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - down right staircase from entrance [right chest]", address: 0xEADC, item: .ThreeBombs, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - above Armos", address: 0xEADF, item: .TenArrows, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - east of down right staircase from entrace", address: 0xEAE2, item: .Key, rules: DungeonRules(zone: 0, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - compass room [top left chest]", address: 0xEAE5, item: .Compass, rules: DungeonRules(zone: 1, bigKeyZone: false)), // This room needs FireRod, but it's guaranteed from SW
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - compass room [top right chest]", address: 0xEAE8, item: .OneRupee, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - compass room [bottom left chest]", address: 0xEAEB, item: .TwentyRupees, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-1F] Ganon's Tower - compass room [bottom right chest]", address: 0xEAEE, item: .TenArrows, rules: DungeonRules(zone: 1, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [bottom chest]", address: 0xEAF1, item: .BigKey, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [left chest]", address: 0xEAF4, item: .TenArrows, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [right chest]", address: 0xEAF7, item: .ThreeBombs, rules: DungeonRules(zone: 2, bigKeyZone: false)),
        Location(region: r, name: "[dungeon-A2-6F] Ganon's Tower - north of falling floor four torches [top left chest]", address: 0xEAFD, item: .ThreeBombs, rules: DungeonRules(zone: 3, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-A2-6F] Ganon's Tower - north of falling floor four torches [top right chest]", address: 0xEB00, item: .ThreeBombs, rules: DungeonRules(zone: 3, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-A2-6F] Ganon's Tower - before Moldorm", address: 0xEB03, item: .Key, rules: DungeonRules(zone: 4, bigKeyZone: true)),
        Location(region: r, name: "[dungeon-A2-6F] Ganon's Tower - Moldorm room", address: 0xEB06, item: .TwentyRupees, rules: DungeonRules(zone: 5, bigKeyZone: true)),
    ]
}

// MARK: Pseudo-locations

func fairyLocations() -> Locations {
    let r = Region.Fairy
    return [
        Location(region: r, name: "Waterfall of Wishing Fairy", address: 0x348FF, item: .BottleWithGreenPotion),
        Location(region: r, name: "Cursed Fairy", address: 0x3493B, item: .BottleWithGreenPotion),
    ]
}

func entranceLocations() -> Locations {
    let r = Region.PatchOnly

    var mire = Location(region: r, name: "Misery Mire Entrance Medallion", address: nil, item: .MireEther)
    mire.onPatchingRom = { rom, item in
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

    var turtleRock = Location(region: r, name: "Turtle Rock Entrance Medallion", address: nil, item: .TRQuake)
    turtleRock.onPatchingRom = { rom, item in
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

    return [mire, turtleRock]
}

func getHalfMagicBatLocation() -> Location {
    var bat = Location(region: .PatchOnly, name: "Magic Bat", address: nil, item: .HalfMagic, accessRequirements: { $0.containsAll(.Hammer, .Powder) })
    bat.onPatchingRom = { rom, item in
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
    return bat
}
