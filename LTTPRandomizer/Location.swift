//
//  Location.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

/// This is a class not a struct since (for now) we want the side-effect of setting the `item` to non-nil to propagate over all containers
class Location {

    var name: String
    var address: Int
    var region: Region
    var _additionalAccessRequirements: ((Set<Item>) -> Bool)?
    var onPatchingRom: ((NSMutableData, Item) -> Void)?

    var uniqueItemOnly: Bool = false
    var keyZone: Int = 0
    var bigKeyNeeded: Bool = false

//    public Action<FileStream, Item> WriteItemCheck { get; set; }

    var item: Item = Item.Nothing
    var weight: Int = 0

    var isLateGame: Bool {
        // There are a few exceptions in this in the original, filing under "close enough" for now
        return region.isDarkWorld
    }

    init(region: Region, name: String, address: Int) {
        self.name = name
        self.address = address
        self.region = region
    }
    init(region: Region, name: String, address: Int, keyZone: Int, bigKeyNeeded: Bool) {
        self.name = name
        self.address = address
        self.region = region
        self.keyZone = keyZone
        self.bigKeyNeeded = bigKeyNeeded
    }

    init(region: Region, name: String, address: Int, accessRequirements: ((Set<Item>) -> Bool)) {
        self.name = name
        self.address = address
        self.region = region
        self._additionalAccessRequirements = accessRequirements

    }

    init(region: Region, name: String, address: Int, keyZone: Int, bigKeyNeeded: Bool, accessRequirements: ((Set<Item>) -> Bool)) {
        self.name = name
        self.address = address
        self.region = region
        self._additionalAccessRequirements = accessRequirements
        self.keyZone = keyZone
        self.bigKeyNeeded = bigKeyNeeded
    }



    init(region: Region, name: String, address: Int, uniqueItemOnly: Bool, accessRequirements: ((Set<Item>) -> Bool)) {
        self.name = name
        self.address = address
        self.region = region
        self._additionalAccessRequirements = accessRequirements
        self.uniqueItemOnly = uniqueItemOnly
    }
    init(region: Region, name: String, address: Int, accessRequirements: ((Set<Item>) -> Bool), onPatchingRom: ((NSMutableData, Item) -> Void)) {
        self.name = name
        self.address = address
        self.region = region
        self._additionalAccessRequirements = accessRequirements
        self.onPatchingRom = onPatchingRom
    }

    func isInOrBeforeKeyZone(_ zone: Int) -> Bool {
        return item == .Nothing && !name.contains("big chest") && keyZone <= zone
    }
    func isInKeyZone(_ zone: Int) -> Bool {
        return item == .Nothing && !name.contains("big chest") && keyZone == zone
    }
    func isAccessible(inventory: Set<Item>) -> Bool {
        return region.isAccessible(inventory: inventory)
            && (_additionalAccessRequirements?(inventory) ?? true)
    }
}

typealias Inventory = Set<Item>

extension Region {
    func isAccessible(inventory: Inventory) -> Bool {
        switch self {

        case .HyruleCastleEscape:
            return true
        case .LightWorld:
            return inventory.canEscapeCastle()
        case .EasternPalace:
            return inventory.canEnterEasternPalace()
        case .DesertPalace:
            return inventory.canEnterDesertPalace()
        case .TowerOfHera:
            return inventory.canEnterTowerOfHera()
        case .HyruleCastleTower:
            return inventory.canEnterHyruleCastleTower()

        case .DarkPalace:
            return inventory.canEnterDarkPalace()
        case .SwampPalace:
            return inventory.canEnterSwampPalace()
        case .SkullWoods:
            return inventory.canEnterSkullWoods()
        case .ThievesTown:
            return inventory.canEnterThievesTown()
        case .IcePalace:
            return inventory.canEnterIcePalace()
        case .MiseryMire:
            return inventory.canEnterMiseryMire()
        case .TurtleRock:
            return inventory.canEnterTurtleRock()
        case .GanonsTower:
            return inventory.canEnterGanonsTower()

        case .LightWorldDeathMountain:
            return inventory.canAccessDeathMountain()
        case .LightWorldEasternDeathMountain:
            return inventory.canAccessEasternDeathMountain()
        case .ZorasDomain:
            return inventory.canAccessZorasDomain()

        case .DarkWorldPyramid:
            return inventory.canAccessPyramid()
        case .DarkWorldMire:
            return inventory.canAccessMireArea()
        case .DarkWorldNorthWest:
            return inventory.canAccessNorthWestDarkWorld()
        case .DarkWorldSouth:
            return inventory.canAccessSouthDarkWorld()
        case .DarkWorldEasternDeathMountain:
            return inventory.canAccessEastDarkWorldDeathMountain()

        case .Progression:
            return true
        }
    }
}

func locationsForRegion(region: Region) -> [Location] {
    switch region {
    case .HyruleCastleEscape:
        return hyruleEscapeItems()
    case .EasternPalace:
        return easternPalaceItems()
    case .DesertPalace:
        return desertPalaceItems()
    case .TowerOfHera:
        return towerOfHeraItems()
    case .DarkPalace:
        return darkPalaceItems()
    case .SwampPalace:
        return swampPalaceItems()
    case .SkullWoods:
        return skullWoodsItems()
    case .ThievesTown:
        return thievesTownItems()
    case .IcePalace:
        return icePalaceItems()
    case .MiseryMire:
        return miseryMireItems()
    case .TurtleRock:
        return turtleRockItems()
    case .LightWorld:
        return lightWorldItems()
    case .LightWorldDeathMountain:
        return lightWorthDeathMountainItems()
    case .LightWorldEasternDeathMountain:
        return lightWorldEasternDeathMountainItems()
    case .ZorasDomain:
        return zorasDomainItems()
    case .DarkWorldPyramid:
        return darkWorldPyramidItems()
    case .DarkWorldMire:
        return mireItems()
    case .DarkWorldNorthWest:
        return northWestDarkWorldItems()
    case .DarkWorldSouth:
        return southDarkWorldItems()
    case .DarkWorldEasternDeathMountain:
        return easternDarkWorldDeathMountainItems()
    case .HyruleCastleTower:
        return hyruleCastleTowerItems()
    case .GanonsTower:
        return ganonsTowerItems()
    case .Progression:
        return progressionItems()
    }
}

/**
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
func progressionItems() -> [Location] {
    return [
        Location(
            region: Region.Progression,
            name: "Undeadlock: Quake",
            address: 0,
            accessRequirements: { items in
                return items.contains(Item.Quake)
            }
        ),
        Location(
            region: Region.Progression,
            name: "Undeadlock: Cane of Somaria",
            address: 0,
            accessRequirements: { items in
                return items.contains(Item.CaneOfSomaria)
            }
        ),
    ]
}

func easternDarkWorldDeathMountainItems() -> [Location] {
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

func southDarkWorldItems() -> [Location] {
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

func mireItems() -> [Location] {
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

func darkPalaceItems() -> [Location] {
    return [
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - big key room",
            address: 0xEA37,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - jump room [right chest]",
            address: 0xEA3A,
            accessRequirements: { items in
                return items.contains(Item.Bow)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - jump room [left chest]",
            address: 0xEA3D,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - big chest",
            address: 0xEA40,
            keyZone: 3,
            bigKeyNeeded: true,
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
            accessRequirements: { items in
                return items.contains(Item.Lamp)
                    && items.contains(Item.Bow)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - compass room",
            address: 0xEA43,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - spike statue room",
            address: 0xEA46,
            keyZone: 3,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - turtle stalfos room",
            address: 0xEA49,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - room leading to Helmasaur [left chest]",
            address: 0xEA4C,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - room leading to Helmasaur [right chest]",
            address: 0xEA4F,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - statue push room",
            address: 0xEA52,
            accessRequirements: { items in
                return items.contains(Item.Bow)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - maze room [top chest]",
            address: 0xEA55,
            keyZone: 3,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-1F] Dark Palace - maze room [bottom chest]",
            address: 0xEA58,
            keyZone: 3,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.DarkPalace,
            name: "[dungeon-D1-B1] Dark Palace - shooter room",
            address: 0xEA5B
        ),
    ]
}

func swampPalaceItems() -> [Location] {
    return [
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - map room",
            address: 0xE986,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - big chest",
            address: 0xE989,
            keyZone: 3,
            bigKeyNeeded: true
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-1F] Swamp Palace - first room",
            address: 0xEA9D
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - south of hookshot room",
            address: 0xEAA0,
            keyZone: 3,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - push 4 blocks room",
            address: 0xEAA3,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B1] Swamp Palace - big key room",
            address: 0xEAA6,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B2] Swamp Palace - flooded room [left chest]",
            address: 0xEAA9,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
                    && items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B2] Swamp Palace - flooded room [right chest]",
            address: 0xEAAC,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
                    && items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.SwampPalace,
            name: "[dungeon-D2-B2] Swamp Palace - hidden waterfall door room",
            address: 0xEAAF,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
                    && items.contains(Item.Hammer)
            }
        ),


    ]
}

func skullWoodsItems() -> [Location] {
    return [
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Compass room",
            address: 0xE992,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - big chest",
            address: 0xE998,
            keyZone: 2,
            bigKeyNeeded: true
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - east of Fire Rod room",
            address: 0xE99B,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Big Key room",
            address: 0xE99E,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Gibdo/Stalfos room",
            address: 0xE9A1,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - south of Fire Rod room",
            address: 0xE9C8
        ),
        Location(
            region: Region.SkullWoods,
            name: "[dungeon-D3-B1] Skull Woods - Entrance to part 2",
            address: 0xE9FE,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canEnterSkullWoods2()
            }
        ),

    ]
}

func thievesTownItems() -> [Location] {
    return [
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Bottom left of huge room [top left chest]",
            address: 0xEA01
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Bottom left of huge room [bottom right chest]",
            address: 0xEA04
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Bottom right of huge room",
            address: 0xEA07
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B1] Thieves' Town - Top left of huge room",
            address: 0xEA0A
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-1F] Thieves' Town - Room above boss",
            address: 0xEA0D,
            keyZone: 2,
            bigKeyNeeded: true
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B2] Thieves' Town - big chest",
            address: 0xEA10,
            keyZone: 2,
            bigKeyNeeded: true,
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
            accessRequirements: { items in
                return items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.ThievesTown,
            name: "[dungeon-D4-B2] Thieves' Town - next to Blind",
            address: 0xEA13,
            keyZone: 1,
            bigKeyNeeded: true
        ),
    ]
}

func icePalaceItems() -> [Location] {
    return [
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B4] Ice Palace - above Blue Mail room",
            address: 0xE995,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B1] Ice Palace - Big Key room",
            address: 0xE9A4,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
                    && items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B5] Ice Palace - big chest",
            address: 0xE9AA,
            keyZone: 2,
            bigKeyNeeded: true,
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
                    && items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B1] Ice Palace - compass room",
            address: 0xE9D4,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B2] Ice Palace - map room",
            address: 0xE9DD,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
                    && items.contains(Item.Hammer)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B3] Ice Palace - spike room",
            address: 0xE9E0,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.Hookshot)
            }
        ),
        Location(
            region: Region.IcePalace,
            name: "[dungeon-D5-B5] Ice Palace - b5 up staircase",
            address: 0xE9E3,
            keyZone: 2,
            bigKeyNeeded: false
        ),
    ]
}

func miseryMireItems() -> [Location] {
    return [
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - spike room",
            address: 0xE9DA
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - big hub room",
            address: 0xEA5E,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - end of bridge",
            address: 0xEA61
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - compass",
            address: 0xEA64,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - big chest",
            address: 0xEA67,
            keyZone: 0,
            bigKeyNeeded: true,
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
            accessRequirements: { items in
                return items.containsAny(Item.Hookshot, Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - map room",
            address: 0xEA6A,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.MiseryMire,
            name: "[dungeon-D6-B1] Misery Mire - big key",
            address: 0xEA6D,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
    ]
}

func turtleRockItems() -> [Location] {
    return [
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - Chain chomp room",
            address: 0xEA16,
            keyZone: 2,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B1] Turtle Rock - big chest",
            address: 0xEA19,
            keyZone: 3,
            bigKeyNeeded: true,
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - Map room [left chest]",
            address: 0xEA1C,
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - Map room [right chest]",
            address: 0xEA1F,
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-1F] Turtle Rock - compass room",
            address: 0xEA22
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B1] Turtle Rock - big key room",
            address: 0xEA25,
            keyZone: 4,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [top right chest]",
            address: 0xEA28,
            keyZone: 6,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.contains(Item.MirrorShield)
                    && items.contains(Item.FireRod)
                    && items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [top left chest]",
            address: 0xEA2B,
            keyZone: 6,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.contains(Item.MirrorShield)
                    && items.contains(Item.FireRod)
                    && items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [bottom right chest]",
            address: 0xEA2E,
            keyZone: 6,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.contains(Item.MirrorShield)
                    && items.contains(Item.FireRod)
                    && items.contains(Item.Lamp)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B2] Turtle Rock - Eye bridge room [bottom left chest]",
            address: 0xEA31,
            keyZone: 6,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.contains(Item.MirrorShield)
                    && items.contains(Item.FireRod)
            }
        ),
        Location(
            region: Region.TurtleRock,
            name: "[dungeon-D7-B1] Turtle Rock - Roller switch room",
            address: 0xEA34,
            keyZone: 5,
            bigKeyNeeded: true,
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
            accessRequirements: { items in
                return items.canEnterTurtleRock()
                    // FireRod should not strictly be necessary depending on key placement
                    && items.containsAll(Item.FireRod, Item.MagicMirror)
            }
        ),
    ]
}

func northWestDarkWorldItems() -> [Location] {
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

func darkWorldPyramidItems() -> [Location] {
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

func ganonsTowerItems() -> [Location] {
    return [
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [top left chest]",
            address: 0xEAB8
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [top right chest]",
            address: 0xEABB
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [bottom left chest]",
            address: 0xEABE
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of gap room [bottom right chest]",
            address: 0xEAC1
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [top left chest]",
            address: 0xEAC4,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [top right chest]",
            address: 0xEAC7,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [bottom left chest]",
            address: 0xEACA,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - west of teleport room [bottom right chest]",
            address: 0xEACD,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - north of teleport room",
            address: 0xEAD0,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - map room",
            address: 0xEAD3,
            keyZone: 1,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - big chest",
            address: 0xEAD6,
            keyZone: 2,
            bigKeyNeeded: true
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - down right staircase from entrance [left chest]",
            address: 0xEAD9
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - down right staircase from entrance [right chest]",
            address: 0xEADC
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - above Armos",
            address: 0xEADF,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - east of down right staircase from entrace",
            address: 0xEAE2
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [top left chest]",
            address: 0xEAE5,
            keyZone: 1,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [top right chest]",
            address: 0xEAE8,
            keyZone: 1,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [bottom left chest]",
            address: 0xEAEB,
            keyZone: 1,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-1F] Ganon's Tower - compass room [bottom right chest]",
            address: 0xEAEE,
            keyZone: 1,
            bigKeyNeeded: false,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [bottom chest]",
            address: 0xEAF1,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [left chest]",
            address: 0xEAF4,
            keyZone: 2,
            bigKeyNeeded: false
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-B1] Ganon's Tower - north of Armos room [right chest]",
            address: 0xEAF7,
            keyZone: 2,
            bigKeyNeeded: false
        ),

        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - north of falling floor four torches [top left chest]",
            address: 0xEAFD,
            keyZone: 3,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - north of falling floor four torches [top right chest]",
            address: 0xEB00,
            keyZone: 3,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - before Moldorm",
            address: 0xEB03,
            keyZone: 4,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
        Location(
            region: Region.GanonsTower,
            name: "[dungeon-A2-6F] Ganon's Tower - Moldorm room",
            address: 0xEB06,
            keyZone: 5,
            bigKeyNeeded: true,
            accessRequirements: { items in
                return items.canLightTorches()
            }
        ),
    ]
}
