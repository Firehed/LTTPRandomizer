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

        let seed = seedField.integerValue
        let randomizer: Randomizer = SeededRandomizer(seed: seed)
        let difficulty: Difficulty
        switch currentDifficulty {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let seed = 0
        seedField.stringValue = String(seed)

        difficultyButton.removeAllItems()
        difficultyButton.addItem(withTitle: difficulties.Easy.rawValue)
        difficultyButton.addItem(withTitle: difficulties.Casual.rawValue)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

