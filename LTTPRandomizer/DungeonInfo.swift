//
//  DungeonInfo.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/25/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

/**
 A structure for tracking dungeon item requirements based on the locations being
 randomized.
 */
struct DungeonInfo {

    var region: Region

    var hasBigKey: Bool = false
    var hasMap: Bool = false
    var hasCompass: Bool = false

    /// A dictionary mapping key zones to the number of small keys needing placement in that zone
    var keyZones = [Int: Int]()

    init(region: Region) {
        self.region = region
    }

    /**
     Given an input of Locations that will be randomized, calculates the dungeon
     item placement requirements
     - parameters:
        - locations: The Locations to be randomized
     - returns: An array of `DungeonInfo`s based on the `Locations` provided
     */
    static func get(locations: Locations) -> [DungeonInfo] {
        var dungeons = [Region: DungeonInfo]()
        for location in locations {
            if !location.item.isDungeonItem {
                continue
            }
            var dungeon: DungeonInfo
            if dungeons[location.region] == nil {
                dungeon = DungeonInfo(region: location.region)
            } else {
                dungeon = dungeons[location.region]!
            }
            switch location.item {
            case .BigKey:
                dungeon.hasBigKey = true
                break
            case .Map:
                dungeon.hasMap = true
                break
            case .Compass:
                dungeon.hasCompass = true
                break
            case .Key:
                var keys = dungeon.keyZones
                var count = dungeon.keyZones[location.dungeonRules.zone] ?? 0
                count += 1
                keys[location.dungeonRules.zone] = count
                dungeon.keyZones = keys
                break
            default:
                break

            }
            dungeons[location.region] = dungeon
        }
        return dungeons.map({ $0.value })
    }
}
