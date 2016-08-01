//
//  Location.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

enum Region: Int {
    case Progression
    case HyruleCastleEscape
    case LightWorld
    case LightWorldDeathMountain
    case LightWorldEasternDeathMountain
    case EasternPalace
    case DesertPalace
    case TowerOfHera
    case HyruleCastleTower
    case ZorasDomain

    case DarkWorld
    case DarkWorldMire
    case DarkWorldSouth
    case DarkPalace
    case SwampPalace
    case SkullWoods
    case ThievesTown
    case IcePalace
    case MiseryMire
    case TurtleRock
    case GanonsTower

    static let all: [Region] = [
        .Progression,
        .HyruleCastleEscape,
        .LightWorld,
        .LightWorldDeathMountain,
        .LightWorldEasternDeathMountain,
        .EasternPalace,
        .DesertPalace,
        .TowerOfHera,
        .HyruleCastleTower,
        .ZorasDomain,
        .DarkWorld,
        .DarkWorldMire,
        .DarkWorldSouth,
        .DarkPalace,
        .SwampPalace,
        .SkullWoods,
        .ThievesTown,
        .IcePalace,
        .MiseryMire,
        .TurtleRock,
        .GanonsTower,
    ]

    var isLightWorld: Bool {
        switch self {
        case .Progression:
            return true
        case .HyruleCastleEscape: fallthrough
        case .LightWorld: fallthrough
        case .LightWorldDeathMountain: fallthrough
        case .LightWorldEasternDeathMountain: fallthrough
        case .EasternPalace: fallthrough
        case .DesertPalace: fallthrough
        case .TowerOfHera: fallthrough
        case .HyruleCastleTower: fallthrough
        case .ZorasDomain:
            return true
        case .DarkWorld: fallthrough
        case .DarkWorldMire: fallthrough
        case .DarkWorldSouth: fallthrough
        case .DarkPalace: fallthrough
        case .SwampPalace: fallthrough
        case .SkullWoods: fallthrough
        case .ThievesTown: fallthrough
        case .IcePalace: fallthrough
        case .MiseryMire: fallthrough
        case .TurtleRock: fallthrough
        case .GanonsTower:
            return false

        }
    }
    var isDarkWorld: Bool {
        return !isLightWorld
    }
}
