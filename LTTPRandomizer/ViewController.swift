//
//  ViewController.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let randomizer: Randomizer = SeededRandomizer(seed: 0)
        let difficulty = DifficultyCasual(randomizer: randomizer)
        let r = RomBuilder(randomizer: randomizer, difficulty: difficulty)
        r.assignItems()
        r.write()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

