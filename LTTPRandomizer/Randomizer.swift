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

    var seed: UInt { get }

    /**
     Returns a pseudo-random integer between 0 and `max`, exclusive.

     - parameters:
        - lessThan: the exclusive upper limit of valid output
     - returns: a positive integer
    */
    func next(lessThan: UInt) -> UInt
}
