//
//  ViewController.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    enum difficulties: String {
        case Annoying
        case Casual
        case Easy
    }

    @IBOutlet weak var seedField: NSTextField!
    @IBOutlet weak var difficultyButton: NSPopUpButton!

    @IBAction func generateROM(_ sender: NSButton) {
        guard let selectedDifficulty = difficultyButton.selectedItem else {
            NSLog("No difficulty selected")
            return
        }
        guard let currentDifficulty = difficulties(rawValue: selectedDifficulty.title) else {
            NSLog("Invalid difficulty")
            return
        }

        let seed = UInt(seedField.integerValue)
        let randomizer: Randomizer = SeededRandomizer(seed: seed)
        let difficulty: Difficulty
        switch currentDifficulty {
        case .Annoying:
            difficulty = DifficultyAnnoying(randomizer: randomizer)
            break
        case .Casual:
            difficulty = DifficultyCasual(randomizer: randomizer)
            break
        case .Easy:
            difficulty = DifficultyEasy(randomizer: randomizer)
            break
        }

        let builder = RomBuilder(randomizer: randomizer, difficulty: difficulty)
        builder.assignItems()
        builder.write()
    }

    @IBAction func randomizeSeed(_ sender: AnyObject?) {
        let max = 1000000
        let seed = Int(arc4random_uniform(UInt32(max)))
        seedField.stringValue = String(seed)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        randomizeSeed(nil)

        difficultyButton.removeAllItems()
        difficultyButton.addItem(withTitle: difficulties.Easy.rawValue)
        difficultyButton.addItem(withTitle: difficulties.Casual.rawValue)
        difficultyButton.addItem(withTitle: difficulties.Annoying.rawValue)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

