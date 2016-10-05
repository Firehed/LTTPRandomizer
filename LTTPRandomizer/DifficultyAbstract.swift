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
            NSLog("%@ opened with %@", entrance.name, entrance.item.description)
        }
    }

    /**
     Selects what to put in your empty bottle when you drop it in a puddle
     */
    internal func randomizeFairies() -> Void {
        for var fairy in fairyLocations() {
            fairy.item = Item.filledBottles.selectAtRandom(randomizer)
            locations.append(fairy)
            NSLog("%@ fills you with %@", fairy.name, fairy.item.description)
        }
    }

    internal func randomizeBat(chance numerator: UInt, in denominator: UInt) -> Void {
        var bat = getHalfMagicBatLocation()
        // chance of granting 1/4 magic instead of 1/2
        if randomizer.next(lessThan: denominator) < numerator {
            bat.item = .QuarterMagic
        }
        locations.append(bat)
    }

    internal func setItemsToNothing(locations: Locations) -> Locations {
        return locations.map {
            var loc = $0
            loc.item = .Nothing
            return loc
        }
    }
}
