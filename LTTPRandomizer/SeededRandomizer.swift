//
//  SeededRandomizer.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

struct SeededRandomizer: Randomizer {
    let seed: Int


    func next(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
//        return 0
    }
}
