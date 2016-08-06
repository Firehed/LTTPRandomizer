//
//  DataExtension.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 8/6/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

extension Data {
    mutating func patch(atByteOffset: Int, withData data: Data) {
        let range = atByteOffset..<(atByteOffset+data.count) as Range<Index>
        replaceBytes(in: range, with: data)
    }
}
