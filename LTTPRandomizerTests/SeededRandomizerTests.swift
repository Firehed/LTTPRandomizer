//
//  SeededRandomizerTests.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 9/11/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import XCTest
@testable import LTTPRandomizer

/**
 Test cases to assert that the outputs from a given seed are consistent across runs
 */
class SeededRandomizerTests: XCTestCase {

    /**
     Given a known seed and lessThan value, assert that the output of
     `next(lessThan:)` matches the expected value
    */
    func testOutputConsistencyWithSameLessThanValue() {
        let sr = SeededRandomizer(seed: 278521)
        let expected: [UInt] = [
            132,24,102,86,20,101,219,2,16,178,
            198,209,86,244,234,164,222,60,159,193,
            203,118,78,49,3,188,1,35,233,144,
            38,218,9,16,111,105,12,232,176,37,
            9,44,117,82,229,27,29,230,10,191,
            2,159,127,228,173,142,164,159,131,196,
            242,241,40,19,199,250,146,128,209,81,
            169,61,152,57,10,233,26,189,240,232,
            214,223,249,166,117,218,237,12,157,189,
            35,180,30,70,64,254,224,0,5,181
        ]
        for i in 0..<100 {
            let out = sr.next(lessThan: 256)
            XCTAssertEqual(out, expected[i], "Output mismatch on output #\(i)")
            XCTAssertLessThan(out, 256)
            XCTAssertGreaterThanOrEqual(out, 0)
        }
    }

    /**
     Given a known seed and varying but known lessThan value, assert that the
     output of `next(lessThan:)` matches the expected value
    */
    func testOutputConsistencyWithVaryingLessThanValue() {
        let sr = SeededRandomizer(seed: 961126)
        let expected: [UInt] = [
            501,238,931,521,665,393,913,693,574,669,
            471,221,529,835,485,649,448,303,242,5,
            571,784,172,545,569,214,159,856,883,481,
            399,127,956,746,410,219,111,522,795,901,
            474,285,410,155,982,459,310,964,792,934
        ]
        for lt in 950..<1000 {
            let out = sr.next(lessThan: UInt(lt))
            let i = lt - 950
            XCTAssertEqual(out, expected[i], "Output mismatch on output #\(i)")
            XCTAssertLessThan(out, UInt(lt))
            XCTAssertGreaterThanOrEqual(out, 0)
        }
    }

}
