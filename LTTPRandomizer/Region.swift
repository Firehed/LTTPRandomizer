//
//  Location.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

enum Region: Int {
    /// Fake rooms created to break ambiguous depsolving
    case Progression
    /// Special case: holds the bottle fill-up info
    case Fairy
    /// Special case: alters other game behavior
    case PatchOnly

    case HyruleCastleEscape
    case LightWorld
    case LightWorldDeathMountain
    case LightWorldEasternDeathMountain
    case EasternPalace
    case DesertPalace
    case TowerOfHera
    case HyruleCastleTower
    case ZorasDomain

    case DarkWorldMire
    case DarkWorldNorthWest
    case DarkWorldPyramid
    case DarkWorldSouth
    case DarkWorldEasternDeathMountain
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
        .Fairy,
        .PatchOnly,
        .HyruleCastleEscape,
        .LightWorld,
        .LightWorldDeathMountain,
        .LightWorldEasternDeathMountain,
        .EasternPalace,
        .DesertPalace,
        .TowerOfHera,
        .HyruleCastleTower,
        .ZorasDomain,
        .DarkWorldMire,
        .DarkWorldNorthWest,
        .DarkWorldPyramid,
        .DarkWorldSouth,
        .DarkWorldEasternDeathMountain,
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
        case .Progression, .Fairy, .PatchOnly:
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
        case .DarkWorldMire: fallthrough
        case .DarkWorldNorthWest: fallthrough
        case .DarkWorldPyramid: fallthrough
        case .DarkWorldSouth: fallthrough
        case .DarkWorldEasternDeathMountain: fallthrough
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
