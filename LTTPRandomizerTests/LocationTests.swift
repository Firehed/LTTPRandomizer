//
//  LocationTests.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/11/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import XCTest
@testable import LTTPRandomizer

class LocationTests: XCTestCase {

    func testAddressesAreNotZero() {
        for location in allLocations() {
            XCTAssertNotEqual(location.address, 0, "Location \(location.name) address must not be 0")
        }
    }

}
