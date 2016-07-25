//
//  Dungeon.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

/**
    Dungeons/sequences within the game
*/
enum Dungeon: String {
    case Escape
    case LW1
    case LW2
    case LW3
    case LWTower
    case DW1
    case DW2
    case DW3
    case DW4
    case DW5
    case DW6
    case DW7
    case DWTower

    static let all = [Dungeon.Escape, .LW1, .LW2, .LW3, .LWTower,
                      .DW1, .DW2, .DW3, .DW4, .DW5, .DW6, .DW7, .DWTower]

    /**
        The Region associated with this dungeon
    */
    var region: Region {
        switch self {
        case .Escape:
            return Region.HyruleCastleEscape
        case .LW1:
            return Region.EasternPalace
        case .LW2:
            return Region.DesertPalace
        case .LW3:
            return Region.TowerOfHera
        case .LWTower:
            return Region.HyruleCastleTower
        case .DW1:
            return Region.DarkPalace
        case .DW2:
            return Region.SwampPalace
        case .DW3:
            return Region.SkullWoods
        case .DW4:
            return Region.ThievesTown
        case .DW5:
            return Region.IcePalace
        case .DW6:
            return Region.MiseryMire
        case .DW7:
            return Region.TurtleRock
        case .DWTower:
            return Region.GanonsTower
        }
    }

    var hasMap: Bool {
        switch self {
        case .LWTower:
            return false
        default:
            return true
        }
    }
    var hasCompass: Bool {
        switch self {
        case .Escape: fallthrough
        case .LWTower:
            return false
        default:
            return true
        }
    }
    var hasBigKey: Bool {
        switch self {
        case .Escape: fallthrough
        case .LWTower:
            return false
        default:
            return true
        }
    }

    /**
        An array of tuples containing the data for small key placement
        requirements within a Dungeon.

            - id: Int, corresponding to the Location.keyZone property
            - count: The number of keys in the keyZone
            - lte: Search for locations with <=keyZone if true, =zone if false
    */
    var keyZones: [(id: Int, count: Int, lte: Bool)] {
        switch self {
        case .Escape:
            return [(2, 1, true)]
        case .LW1: return []
        case .LW2: return []
        case .LW3: return []
        case .LWTower:
            return [(0, 1, false), (1, 1, false)]
        case .DW1:
            return [(0, 2, false), (1, 2, false), (2, 1, false), (3, 1, false)]
        case .DW2:
            return [(0, 1, false)]
        case .DW3:
            return [(0, 1, false), (1, 1, false), (2, 1, false)]
        case .DW4:
            return [(1, 1, true)]
        case .DW5:
            return [(2, 2, true)]
        case .DW6:
            return [(0, 2, false), (1, 1, false)]
        case .DW7:
            return [(0, 1, false), (2, 1, true), (5, 1, true), (6, 1, false)]
        case .DWTower:
            return [(0, 1, false), (1, 1, false), (4, 1, true)]
        }
    }
}
