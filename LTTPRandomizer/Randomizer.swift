//
//  Randomizer.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

protocol Randomizer {

    /// Returns a pseudo-random integer between 0 and `max`, exclusive
    func next(lessThan: Int) -> Int
}
