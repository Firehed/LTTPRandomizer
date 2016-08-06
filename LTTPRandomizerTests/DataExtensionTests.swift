//
//  DataExtensionTests.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/6/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import XCTest
@testable import LTTPRandomizer


class DataExtensionTests: XCTestCase {

    func testFullDataPatch() {
        var data = Data(count: 10)!
        let patch = Data(bytes: [0,1,2,3,4,5,6,7,8,9])
        data.patch(atByteOffset: 0, withData: patch)
        for i in 0..<10 {
            XCTAssertEqual(data[i], UInt8(i), "Patch failed at byte \(i)")
        }
    }

    func testSubDataPatch() {
        var data = Data(count: 10)!
        let patch = Data(bytes: [1,2])
        data.patch(atByteOffset: 1, withData: patch)
        XCTAssertEqual(data[0], UInt8(0), "Byte 0 changed")
        XCTAssertEqual(data[1], UInt8(1), "Byte 1 failed")
        XCTAssertEqual(data[2], UInt8(2), "Byte 2 failed")
        for i in 3..<10  {
            XCTAssertEqual(data[i], UInt8(0), "Byte \(i) changed")
        }
    }

}
