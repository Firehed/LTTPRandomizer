//
//  Randomizer.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

protocol Randomizer {
    func next(max: Int) -> Int
}
