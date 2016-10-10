//
//  Location.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

struct Location: Equatable, ItemBearer {

    var name: String
    var address: Int?
    var region: Region
    var _additionalAccessRequirements: ((Inventory) -> Bool)?
    var onPatchingRom: ((inout Data, Item) -> Void)?
    var canHoldItem: ((Item) -> Bool)?

    var dungeonRules: DungeonRules

//    public Action<FileStream, Item> WriteItemCheck { get; set; }

    var item: Item = Item.Nothing
    var weight: Int = 0

    // MARK: Out-of-dungeon initializers

    init(region: Region, name: String, address: Int?, item: Item) {
        self.name = name
        self.address = address
        self.region = region
        self.dungeonRules = DungeonRules.none()
        self.item = item
    }

    init(region: Region, name: String, address: Int?, item: Item, accessRequirements: @escaping ((Inventory) -> Bool)) {
        self.name = name
        self.address = address
        self.region = region
        self._additionalAccessRequirements = accessRequirements
        self.dungeonRules = DungeonRules.none()
        self.item = item
    }

    // MARK: In-dungeon initializers

    init(region: Region, name: String, address: Int, item: Item, rules: DungeonRules) {
        self.name = name
        self.address = address
        self.region = region
        self.dungeonRules = rules
        self.item = item
    }

    init(region: Region, name: String, address: Int, item: Item, rules: DungeonRules, accessRequirements: @escaping ((Inventory) -> Bool)) {
        self.name = name
        self.address = address
        self.region = region
        self.dungeonRules = rules
        self._additionalAccessRequirements = accessRequirements
        self.item = item
    }

    func isInOrBeforeKeyZone(_ zone: Int) -> Bool {
        return item == .Nothing && !name.contains("big chest") && dungeonRules.zone <= zone
    }

    func isAccessible(with inventory: Inventory) -> Bool {
        return region.isAccessible(with: inventory)
            && (_additionalAccessRequirements?(inventory) ?? true)
    }

    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.item == rhs.item
            && lhs.address == rhs.address
            && lhs.dungeonRules == rhs.dungeonRules
            && lhs.region == rhs.region
    }
}

private extension Region {
    func isAccessible(with inventory: Inventory) -> Bool {
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

        case .Progression, .Fairy, .PatchOnly:
            return true
        }
    }
}

func locationsForRegion(region: Region) -> Locations {
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
    case .Fairy, .PatchOnly:
        // Fairies get special placement rules, and are intentionally left out here
        // Entrances are fake locations that don't get normal items placed
        return []
    }
}

