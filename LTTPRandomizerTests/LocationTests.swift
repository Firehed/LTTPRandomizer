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

    func testDungeonsItems() {
        let locations = allLocations()
        // Counts the dungeon items by region, and checks that no region has >1 of any item
        let x = locations.reduce([Region: (bk: Int, map: Int, compass: Int)](), {
            var seen = $0[$1.region] ?? (bk: 0, map: 0, compass: 0)
            switch $1.item {
            case .BigKey:
                seen.bk += 1
                break
            case .Map:
                seen.map += 1
                break
            case .Compass:
                seen.compass += 1
                break
            default:
                break

            }
            var reduced = $0
            reduced[$1.region] = seen
            return reduced
        })
        for (region, contents) in x {
            XCTAssertLessThanOrEqual(contents.bk, 1, ">1 BK in \(region)")
            XCTAssertLessThanOrEqual(contents.map, 1, ">1 map in \(region)")
            XCTAssertLessThanOrEqual(contents.compass, 1, ">1 compass in \(region)")
        }
    }

}
