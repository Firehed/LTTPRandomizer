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
    internal var randomizer: Randomizer

    /**
     Initializer. Provides a randomizer to use during selection
     - parameters:
        - randomizer: a Randomizer
     */
    required init(randomizer: Randomizer) {
        self.randomizer = randomizer
    }

    /**
     Return a list of `Location`s that need items
     - returns: an array of `Location`s
     */
    func getLocations() -> Locations {
        return locations
    }

    /**
     Selects which medallion shall be required for entrance to MM and TR. Must
     be performed before standard item placement to allow depsolving access to
     the randomized item.
     */
    internal func randomizeEntrances() -> Void {
        for entrance in entranceLocations() {
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
    
}
