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


        case .Progression: fallthrough
        case .LightWorld: fallthrough
        case .DarkWorld:
            return true
        }
    }
}

func allLocations() -> [Location] {
    var all = [Location]()
    for region in Region.all {
        all.append(contentsOf: locationsForRegion(region: region))
    }
    return all
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
    case .DarkWorld:
        return darkWorldItems()
    case .HyruleCastleTower:
        return hyruleCastleTowerItems()
    case .GanonsTower:
        return ganonsTowerItems()
    case .Progression:
        return []
    }
}

func hyruleEscapeItems() -> [Location] {
    return [
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
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-1F] Sanctuary",
            address: 0xEA79,
            keyZone: 4,
            bigKeyNeeded: false // Technically it is needed, but BK doesn't spawn in a chest so this would break
        ),
        Location(
            region: Region.HyruleCastleEscape,
            name: "[dungeon-C-B3] Hyrule Castle - next to Zelda",
            address: 0xEB09,
            keyZone: 2,
            bigKeyNeeded: false
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

func easternPalaceItems() -> [Location] {
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
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
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

func desertPalaceItems() -> [Location] {
    return [
        Location(
            region: Region.DesertPalace,
            name: "[dungeon-L2-B1] Desert Palace - big chest",
            address: 0xE98F,
            keyZone: 0,
            bigKeyNeeded: true
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
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

func towerOfHeraItems() -> [Location] {
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
            keyZone: 1,
            bigKeyNeeded: true,
            // big chests require all the items that other chests in the dungeon require (that also don't require big key)
            accessRequirements: { items in
                return items.canLightTorches()
            }
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
                return (items.contains(Item.Hookshot)
                        || items.contains(Item.PegasusBoots))
                    && items.canLightTorches()
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
    ]
}

func lightWorldItems() -> [Location] {
    return [
        Location(
            region: Region.LightWorld,
            name: "[cave-034] Hyrule Castle secret entrance",
            address: 0xE971
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-018] Graveyard - top right grave",
            address: 0xE97A,
            accessRequirements: { items in
                return items.canEscapeCastle()
                    && items.contains(Item.PegasusBoots)
                    && (items.contains(Item.TitansMitt)
                        || items.canAccessLowerDarkWorld())
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-047] Dam",
            address: 0xE98C,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-040] Link's House",
            address: 0xE9BC
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-012-1F] Death Mountain - wall of caves - left cave",
            address: 0xE9BF,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        // MARK: Late Game
        Location(
            region: Region.LightWorld,
            name: "[cave-013] Mimic cave (from Turtle Rock)",
            address: 0xE9C5,
            accessRequirements: { items in
                return items.canEnterTurtleRock()
                    && items.contains(Item.FireRod)
            }
        ),

        Location(
            region: Region.LightWorld,
            name: "[cave-031] Tavern",
            address: 0xE9CE,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),



        Location(
            region: Region.LightWorld,
            name: "[cave-026] chicken house",
            address: 0xE9E9,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-044] Aginah's cave",
            address: 0xE9F2,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [left chest]",
            address: 0xEA82,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [center chest]",
            address: 0xEA85,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-035] Sahasrahla's Hut [right chest]",
            address: 0xEA88,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [top chest]",
            address: 0xEA8E,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [left chest row of 3]",
            address: 0xEA91,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [center chest row of 3]",
            address: 0xEA94,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [right chest row of 3]",
            address: 0xEA97,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-021] Kakariko well [bottom chest]",
            address: 0xEA9A,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top chest]",
            address: 0xEB0F,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top left chest]",
            address: 0xEB12,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [top right chest]",
            address: 0xEB15,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [bottom left chest]",
            address: 0xEB18,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-022-B1] Thief's hut [bottom right chest]",
            address: 0xEB1B,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left chest]",
            address: 0xEB2A,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top left middle chest]",
            address: 0xEB2D,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right middle chest]",
            address: 0xEB30,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [top right chest]",
            address: 0xEB33,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-009-1F] Death Mountain - wall of caves - right cave [bottom chest]",
            address: 0xEB36,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-009-B1] Death Mountain - wall of caves - right cave [left chest]",
            address: 0xEB39,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-009-B1] Death Mountain - wall of caves - right cave [right chest]",
            address: 0xEB3C,
            accessRequirements: { items in
                return items.canAccessEasternDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-016] cave under rocks west of Santuary",
            address: 0xEB3F,
            accessRequirements: { items in
                return items.canEscapeCastle()
                    && items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [bottom left chest]",
            address: 0xEB42,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [top left chest]",
            address: 0xEB45,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [top right chest]",
            address: 0xEB48,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia [bottom right chest]",
            address: 0xEB4B,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-051] Ice Cave",
            address: 0xEB4E,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
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
            address: 0x2EB18,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
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
                return items.canEscapeCastle()
                    && items.contains(Item.Bottle)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Purple Chest",
            address: 0x33D68,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
                    && items.contains(Item.TitansMitt)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Hobo",
            address: 0x33E7D,
            accessRequirements: { items in
                return items.canEscapeCastle()
                    && items.contains(Item.Flippers)
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
            name: "Bombos",
            address: 0x48B81,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
                    && items.canGetMasterSword()
                    && items.contains(Item.BookOfMudora)
            },
            onPatchingRom: { rom, item in
                // Inventory item check?
                rom.patch(atByteOffset: 0x44AAE, withData: item.asData())
            }
        ),
        // Zora's appearance is based on if you items flippers or not
        Location(
            region: Region.LightWorld,
            name: "King Zora",
            address: 0xEE1C3,
            accessRequirements: { items in
                return items.canAccessZorasDomain()
            },
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
            name: "Old mountain man",
            address: 0xF69FA,
            accessRequirements: { items in
                return items.canAccessDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Thieves' Forest Hideout)",
            address: 0x180000,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
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
            name: "Piece of Heart (Spectacle Rock Cave)",
            address: 0x180002,
            accessRequirements: { items in
                return items.canAccessDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (south of Haunted Grove)",
            address: 0x180003,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Graveyard)",
            address: 0x180004,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Desert - northeast corner)",
            address: 0x180005,
            accessRequirements: { items in
                // Mirror is techincally redundant
                return items.canAccessMireArea() && items.contains(Item.MagicMirror)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "[cave-050] cave southwest of Lake Hylia - generous guy",
            address: 0x180010,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Library",
            address: 0x180012,
            accessRequirements: { items in
                return items.canEscapeCastle()
                    && items.contains(Item.PegasusBoots)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Spectacle Rock)",
            address: 0x180140,
            accessRequirements: { items in
                return items.canAccessDeathMountain()
                    && items.contains(Item.MagicMirror)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Death Mountain - floating island)",
            address: 0x180141,
            accessRequirements: { items in
                return items.canAccessEastDarkWorldDeathMountain()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Maze Race)",
            address: 0x180142,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Desert - west side)",
            address: 0x180143,
            accessRequirements: { items in
                return items.canEscapeCastle()
                    && items.contains(Item.BookOfMudora)
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Lake Hylia)",
            address: 0x180144,
            accessRequirements: { items in
                return items.canEscapeCastle()
                    && items.contains(Item.Flippers)
                    && items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Dam)",
            address: 0x180145,
            accessRequirements: { items in
                return items.canEscapeCastle()
            }
        ),
        Location(
            region: Region.LightWorld,
            name: "Piece of Heart (Zora's River)",
            address: 0x180149,
            accessRequirements: { items in
                return items.canAccessZorasDomain()
                    && items.contains(Item.Flippers)
            }
        ),
    ]
}

func darkWorldItems() -> [Location] {
    return [
        Location(
            region: Region.DarkWorld,
            name: "[cave-063] doorless hut",
            address: 0xE9EC,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-062] C-shaped house",
            address: 0xE9EF,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-071] Misery Mire west area [left chest]",
            address: 0xEA73,
            accessRequirements: { items in
                return items.canAccessMireArea()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-071] Misery Mire west area [right chest]",
            address: 0xEA76,
            accessRequirements: { items in
                return items.canAccessMireArea()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [top chest]",
            address: 0xEA7C,
            accessRequirements: { items in
                return items.canAccessEastDarkWorldDeathMountain()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-057-1F] Dark World Death Mountain - cave from top to bottom [bottom chest]",
            address: 0xEA7F,
            accessRequirements: { items in
                return items.canAccessEastDarkWorldDeathMountain()
            }
        ),
        // TODO: watch for softlock?
        Location(
            region: Region.DarkWorld,
            name: "[cave-055] Spike cave",
            address: 0xEA8B,
            accessRequirements: { items in
                return items.canAccessDeathMountain()
                    && items.contains(Item.MoonPearl)
                    && items.contains(Item.Hammer)
                // Quake: Why? "stops some deadlocks"
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-073] cave northeast of swamp palace [top chest]",
            address: 0xEB1E,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-073] cave northeast of swamp palace [top middle chest]",
            address: 0xEB21,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-073] cave northeast of swamp palace [bottom middle chest]",
            address: 0xEB24,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-073] cave northeast of swamp palace [bottom chest]",
            address: 0xEB27,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),

        Location(
            region: Region.DarkWorld,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [top right chest]",
            address: 0xEB51,
            accessRequirements: { items in
                return items.canAccessEastDarkWorldDeathMountain()
                    && items.contains(Item.Hookshot)
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [top left chest]",
            address: 0xEB54,
            accessRequirements: { items in
                return items.canAccessEastDarkWorldDeathMountain()
                    && items.contains(Item.Hookshot)
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom left chest]",
            address: 0xEB57,
            accessRequirements: { items in
                return items.canAccessEastDarkWorldDeathMountain()
                    && items.contains(Item.Hookshot)
            }
        ),
        Location(
            region: Region.DarkWorld,
            name: "[cave-056] Dark World Death Mountain - cave under boulder [bottom right chest]",
            address: 0xEB5A,
            accessRequirements: { items in
                return items.canAccessEastDarkWorldDeathMountain()
                    && items.contains(Item.Hookshot)
                    // not actually required here, but stops some deadlocks
                    && items.contains(Item.FireRod)
            }
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorld,
            name: "Flute Boy",
            address: 0x330C7,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorld,
            name: "Catfish",
            address: 0xEE185,
            accessRequirements: { items in
                return items.canAccessPyramid()
                    && items.contains(Item.PowerGlove)
                    && (items.contains(Item.PegasusBoots)
                        || items.contains(Item.TitansMitt))
            },
            onPatchingRom: { rom, item in
                // (This is a guess based on the Windows source)
                // Indicates what item's presence will block the Catfish scene
                rom.patch(atByteOffset: 0x180204, withData: item.bytesForInventoryCheckOverride)
            }
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorld,
            name: "Piece of Heart (Dark World blacksmith pegs)",
            address: 0x180006,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
                    && items.contains(Item.TitansMitt)
                    && items.contains(Item.Hammer)
            }
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorld,
            name: "[cave-073] cave northeast of swamp palace - generous guy",
            address: 0x180011,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
            }
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorld,
            name: "Piece of Heart (Dark World - bumper cave)",
            address: 0x180146,
            accessRequirements: { items in
                return items.canAccessLowerDarkWorld()
                    && items.contains(Item.Cape)
            }
        ),
        // MARK: not late game
        Location(
            region: Region.DarkWorld,
            name: "Piece of Heart (Pyramid)",
            address: 0x180147,
            accessRequirements: { items in
                return items.canAccessPyramid()
            }
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

func hyruleCastleTowerItems() -> [Location] {
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
