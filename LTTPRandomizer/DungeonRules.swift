//
//  DungeonRules.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/3/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

struct DungeonRules: Equatable {

    /// Key zone
    private(set) public var zone: Int

    /// Requires big key to access
    private(set) public var isBigKeyZone: Bool

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
        self.isBigKeyZone = bigKeyZone
        self.canHoldDungeonItems = true
    }

    static func ==(lhs: DungeonRules, rhs: DungeonRules) -> Bool {
        return lhs.canHoldDungeonItems == rhs.canHoldDungeonItems
            && lhs.isBigKeyZone == rhs.isBigKeyZone
            && lhs.zone == rhs.zone
    }
}
