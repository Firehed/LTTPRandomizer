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
    
    func testNoLocationsAreMissingItems() {
        let locations = allLocations().filter { $0.region != .Progression }
        for location in locations {
            XCTAssertFalse(location.item == .Nothing,
                           "No item in \(location.name)")
        }
    }
    
}
