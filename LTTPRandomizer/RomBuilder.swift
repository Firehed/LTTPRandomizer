//
//  RomBuilder.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

class RomBuilder {

    var writeSRAMTrace: Bool = false

    /// The pseudo-randomizer
    private var randomizer: PRNG

    init(randomizer: PRNG) {
        self.randomizer = randomizer
    }

    func patch(locations: Locations, additionalPatches patches: [Patch]) -> Data? {
        guard let sourcePath = Bundle.main.path(forResource: "v6", ofType: "sfc") else {
            NSLog("Bundled ROM not found")
            return nil
        }

        var rom: Data
        do {
            try rom = Data(contentsOf: URL.init(fileURLWithPath: sourcePath))
        } catch {
            return nil
        }

        for location in locations {

            if location.item == .Nothing {
                if location.region != .Progression {
                    NSLog("%@ has no item", location.name)
                }
                continue
            }

            if let addr = location.address {
                rom.patch(atByteOffset: addr, withData: location.item.asData())
            }

            // Apply additional patch if one exists
            if location.onPatchingRom != nil {
                location.onPatchingRom!(&rom, location.item)
            }
        }

        if writeSRAMTrace {
            let bytes: [UInt8] = [0x00, 0x80, 0x21]
            rom.patch(atByteOffset: 0x57, withData: Data(bytes: bytes))
        }

        for patch in patches {
            patch(&rom)
        }

        return rom
    }

    func write(rom: Data, to destination: URL) {
        do {
            try rom.write(to: destination, options: .atomic)
        } catch {
            print("write error")
        }

    }

}
