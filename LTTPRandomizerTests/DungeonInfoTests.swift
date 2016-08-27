//
//  DungeonInfoTests.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/27/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import XCTest
@testable import LTTPRandomizer

class DungeonInfoTests: XCTestCase {

    func assertGetCalculatesCorrectly(locations: Locations) -> (Int, Int, Int, Int) {
        let bigKeyCount = locations.filter { $0.item == .BigKey }.count
        let smallKeyCount = locations.filter { $0.item == .Key }.count
        let mapCount = locations.filter { $0.item == .Map }.count
        let compassCount = locations.filter { $0.item == .Compass }.count

        let dungeonInfo = DungeonInfo.get(locations: locations)

        XCTAssertEqual(dungeonInfo.filter { $0.hasBigKey }.count, bigKeyCount,
                       "Big Key count did not match")
        XCTAssertEqual(dungeonInfo.filter { $0.hasMap }.count, mapCount,
                       "Map count did not match")
        XCTAssertEqual(dungeonInfo.filter { $0.hasCompass }.count, compassCount,
                       "Compass count did not match")

        // Reduce all of the keyZone counts in all of the DungeonInfos to a total small key count
        XCTAssertEqual(dungeonInfo.reduce(0, { $0 + $1.keyZones.reduce(0, { $0 + $1.value }) }),
                       smallKeyCount,
                       "Small Key count did not match")

        return (bigKeyCount, smallKeyCount, mapCount, compassCount)

    }

    func testGetWithAllLocations() {
        let (b, s, m, c) = assertGetCalculatesCorrectly(locations: allLocations())
        // Sanity check the locations themselves
        XCTAssertEqual(b, 11, "Should have no big keys") // 3LW 8DW
        XCTAssertEqual(s, 26, "Should have no small keys")
        XCTAssertEqual(m, 12, "Should have no maps") // 4LW 8DW
        XCTAssertEqual(c, 11, "Should have no compasses") // 3LW 7DW
    }

    func testGetWithEmptyLocations() {
        let (b, s, m, c) = assertGetCalculatesCorrectly(locations: [])
        XCTAssertEqual(b, 0, "Should have no big keys")
        XCTAssertEqual(s, 0, "Should have no small keys")
        XCTAssertEqual(m, 0, "Should have no maps")
        XCTAssertEqual(c, 0, "Should have no compasses")

    }
}
