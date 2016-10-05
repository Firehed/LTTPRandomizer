//
//  SeededRandomizer.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/24/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class SeededRandomizer: PRNG {

    /// a one-character string for encoding the ROM information
    internal var abbreviatedName: String { return "S" }

    /// The initial randomization seed
    let seed: UInt

    /// Current randomization state
    private var state: UInt

    init(seed: UInt) {
        self.seed = seed
        state = seed
    }

    func next(lessThan: UInt) -> UInt {
        return xorshift() % lessThan
    }

    /// Modifies the internal state to return a pseudo-random value
    private func xorshift() -> UInt {
        // There is absolutely no significance to these values, they were copied
        // as-is from [the Wikipedia article on `xorshift`]
        // (https://en.wikipedia.org/wiki/Xorshift#xorshift.2A)
        //
        // The only goal is consistency of output, not quality of randomness
        state ^= state >> 12
        state ^= state << 25
        state ^= state >> 27
        return UInt.multiplyWithOverflow(state, 2_685_821_657_736_338_717).0
    }

}
