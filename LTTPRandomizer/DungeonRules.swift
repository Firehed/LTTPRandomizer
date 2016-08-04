//
//  DungeonRules.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/3/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

public struct DungeonRules {

    /// Key zone
    private(set) public var zone: Int

    /// Requires big key to access
    private(set) public var bigKeyZone: Bool

    /// If false, loacation may not hold keys, map, or compass
    private(set) public var canHoldDungeonItems: Bool

    /// Factory method for Locations that may not hold dungeon items
    static func none() -> DungeonRules {
        var rule = DungeonRules(zone: 0, bigKeyZone: false)
        rule.canHoldDungeonItems = false
        return rule
    }

    init(zone: Int, bigKeyZone: Bool) {
        self.zone = zone
        self.bigKeyZone = bigKeyZone
        self.canHoldDungeonItems = true
    }

}
