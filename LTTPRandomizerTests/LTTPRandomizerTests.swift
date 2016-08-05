//
//  LTTPRandomizerTests.swift
//  LTTPRandomizerTests
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import XCTest
@testable import LTTPRandomizer

class LTTPRandomizerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testDungeonsItems() {
        let locations = allLocations()
        for dungeon in Dungeon.all {
            let dungeonLocations = locations.filter { $0.region == dungeon.region }
            // Big key
            XCTAssertLessThanOrEqual(dungeonLocations.filter({ $0.item == .BigKey }).count,
                                     1,
                                     "Region \(dungeon.region) has multiple big keys")
            // Map
            XCTAssertLessThanOrEqual(dungeonLocations.filter({ $0.item == .Map }).count,
                                     1,
                                     "Region \(dungeon.region) has multiple maps")
            // Compass
            XCTAssertLessThanOrEqual(dungeonLocations.filter({ $0.item == .Compass }).count,
                                     1,
                                     "Region \(dungeon.region) has multiple compasses")
            // Small keys
            let numKeys = dungeon.keyZones.reduce(0) { $0 + $1.count }
            XCTAssertEqual(dungeonLocations.filter({ $0.item == .Key }).count,
                           numKeys,
                           "Region \(dungeon.region) has the wrong number of keys")
            // Everything else: nothing left as "none"
            XCTAssertEqual(dungeonLocations.filter({ $0.item == .Nothing }).count,
                           0,
                           "Region \(dungeon.region) has some items set to Nothing")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
