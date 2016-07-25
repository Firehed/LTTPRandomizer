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

    func selectAtRandom(_ randomizer: SeededRandomizer) -> Element {
        return self[randomizer.next(max: count)]
    }
}

extension Array where Element: Location {
    func withNoItems() -> [Location] {
        return self.filter({ $0.item == .Nothing })
    }
}
