//
//  ArrayExtension.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

extension Array {
    var isNonEmpty: Bool {
        return !isEmpty
    }

    func selectAtRandom(_ randomizer: Randomizer) -> Element {
        guard count > 0 else {
            NSLog("Selecting at random from an empty array")
            exit(EXIT_FAILURE)
        }
        return self[Int(randomizer.next(lessThan: UInt(count)))]
    }
}

extension Array where Element: ItemBearer {
    func withNoItems() -> [Element] {
        return self.filter({ $0.item == .Nothing })
    }
}

extension Array where Element: Equatable {

    /// Removes the first element in the array equal to the specified value
    mutating func removeFirst(_ item: Element) {
        remove(at: index(of: item)!)
    }
}
