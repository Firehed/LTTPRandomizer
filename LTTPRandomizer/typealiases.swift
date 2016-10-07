//
//  typealiases.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 10/6/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

typealias Inventory = Set<Item>

typealias Locations = [Location]

typealias Patch = (inout Data) -> Void
