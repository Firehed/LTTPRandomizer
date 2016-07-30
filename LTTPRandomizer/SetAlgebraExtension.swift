//
//  SetAlgebraExtension.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/30/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

extension SetAlgebra {

    /// Complexity: O(n) (worst case)
    /// - parameter items: 0 or more `Element`s
    /// - returns: true iff all `items` are present in the set; false otherwise
    func containsAll(_ items: Element...) -> Bool {
        for item in items {
            if !contains(item) {
                return false
            }
        }
        return true
    }

    /// Complexity: O(n) (worst case)
    /// - parameter items: 0 or more `Element`s
    /// - returns: true if any parameter is present in the set; false otherwise.
    func containsAny(_ items: Element...) -> Bool {
        for item in items {
            if contains(item) {
                return true
            }
        }
        return false
    }
    
}
