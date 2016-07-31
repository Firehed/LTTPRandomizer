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
    case EasternPalace
    case DesertPalace
    case TowerOfHera
    case HyruleCastleTower
    case DarkWorld
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
        .EasternPalace,
        .DesertPalace,
        .TowerOfHera,
        .HyruleCastleTower,
        .DarkWorld,
        .DarkPalace,
        .SwampPalace,
        .SkullWoods,
        .ThievesTown,
        .IcePalace,
        .MiseryMire,
        .TurtleRock,
        .GanonsTower,
    ]
}
