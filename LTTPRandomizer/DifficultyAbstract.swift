//
//  DifficultyAbstract.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/14/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

/// This is a pseudo-mixin to implement the Difficulty protocol
class DifficultyAbstract {

    /// The locations to be randomized
    internal var locations = Locations()

    /// The items to be placed
    internal var pool = [Item]()

    /// The pseudo-randomizer
    internal var randomizer: PRNG

    /// Array of computed dungeon item info
    internal var dungeonInfo = [DungeonInfo]()

    /**
     Initializer. Provides a randomizer to use during selection
     - parameters:
        - randomizer: a Randomizer
     */
    required init(randomizer: PRNG) {
        self.randomizer = randomizer
    }

    /**
     Return a list of `Location`s that need items
     - returns: an array of `Location`s
     */
    func getLocations() -> Locations {
        return locations
    }

    func getDungeonInfo() -> [DungeonInfo] {
        return dungeonInfo
    }

    /**
     Selects which medallion shall be required for entrance to MM and TR. Must
     be performed before standard item placement to allow depsolving access to
     the randomized item.
     */
    internal func randomizeEntrances() -> Void {
        for var entrance in entranceLocations() {
            let pool: [Item]
            guard entrance.item.isMiseryMireEntranceItem || entrance.item.isTurtleRockEntranceItem else {
                NSLog("Entrance location %@ didn't have an entrance item", entrance.name)
                locations.append(entrance)
                return
            }
            if entrance.item.isMiseryMireEntranceItem {
                pool = [.MireBombos, .MireEther, .MireQuake]
            } else {
                pool = [.TRBombos, .TREther, .TRQuake]
            }
            entrance.item = pool.selectAtRandom(randomizer)
            // Insert the virtual location so the onWrite callback fires. The
            // item is not .Nothing so it won't receive an actual item
            locations.append(entrance)
        }
    }

    /**
     Selects what to put in your empty bottle when you drop it in a puddle
     */
    internal func randomizeFairies() -> Void {
        for var fairy in fairyLocations() {
            fairy.item = Item.filledBottles.selectAtRandom(randomizer)
            locations.append(fairy)
        }
    }


    /// Builds the 1/2 magic bat location, randomly turning it into 1/4 or
    /// non-upgraded magic based on the provided parameters
    ///
    /// - parameter quarterChance: the fractional chance of giving 1/4 magic
    /// - parameter fullChance:    the fractional chance of giving no upgrade
    ///
    /// - returns: the Location of the magic bat, with the correct upgrade item
    internal func randomizeBat(quarterChance: (UInt, in: UInt), fullChance: (UInt, in: UInt)) -> Location {
        var bat = getHalfMagicBatLocation()

        // Cross-multiply to ensure we don't cheat the distribution; e.g. 1/3
        // and 1/2 chances are 2/6 and 3/6 (with 1/6 of no change)
        let denominator = quarterChance.in * fullChance.in
        let quarterNumerator = quarterChance.0 * fullChance.in
        let fullNumerator = fullChance.0 * quarterChance.in

        guard quarterNumerator + fullNumerator <= denominator else {
            NSLog("Combined chances of 1/4 and 1/1 magic exceed 100%")
            return bat
        }

        // Number line of sorts: per above, random value will be in 0...5
        let value = randomizer.next(lessThan: denominator)
        // 0, 1 for quarter magic
        if value < quarterNumerator {
            bat.item = .QuarterMagic
        }
        // effectively 2, 3, 4 for full magic
        else if value < (quarterNumerator + fullNumerator) {
            bat.item = .FullMagic
        }
        // effectively 5 for standard 1/2 magic (default)
        return bat
    }

    internal func setItemsToNothing(locations: Locations) -> Locations {
        return locations.map {
            var loc = $0
            loc.item = .Nothing
            return loc
        }
    }
}
