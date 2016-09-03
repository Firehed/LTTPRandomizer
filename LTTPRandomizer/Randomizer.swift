//
//  Randomizer.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

protocol Randomizer {

    /// a one-character string for encoding the ROM information
    var abbreviatedName: String { get }

    var seed: Int { get }

    /// Returns a pseudo-random integer between 0 and `max`, exclusive
    func next(lessThan: Int) -> Int
}
