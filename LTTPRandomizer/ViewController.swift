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
    @IBOutlet var spoilerLog: NSTextView!
    @IBOutlet weak var spoilerDisclosureButtonLabel: NSTextField!

    @IBAction func spoilerDisclosureButtonPressed(_ sender: NSButton) {
        toggleShowSpoliers(show: sender.state == 1)
    }

    func toggleShowSpoliers(show: Bool) {
        if show {
            spoilerLog.enclosingScrollView?.isHidden = false
            spoilerDisclosureButtonLabel.stringValue = "Hide spoliers"
        } else {
            spoilerLog.enclosingScrollView?.isHidden = true
            spoilerDisclosureButtonLabel.stringValue = "Show spoliers"
        }
    }

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

        let panel = NSSavePanel()
        panel.allowedFileTypes = ["sfc"]
        panel.nameFieldStringValue = builder.defaultFileName
        if panel.runModal() == NSFileHandlingPanelOKButton {
            builder.assignItems()
            writeSpolierLog(locations: builder.locations)
            builder.write(to: panel.url!)
        }
    }

    func writeSpolierLog(locations: Locations) {
        spoilerLog.isEditable = true
        spoilerLog.string = ""
        for location in locations {
            let text = String(format: "%@: %@\n", location.item.description, location.name)
            spoilerLog.insertText(text, replacementRange: NSRange(location: 0, length: 0))
        }
        spoilerLog.isEditable = false
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

        toggleShowSpoliers(show: false)

        difficultyButton.removeAllItems()
        difficultyButton.addItem(withTitle: difficulties.Easy.rawValue)
        difficultyButton.addItem(withTitle: difficulties.Casual.rawValue)
        difficultyButton.addItem(withTitle: difficulties.Annoying.rawValue)

        spoilerLog.font = NSFont.userFixedPitchFont(ofSize: NSFont.systemFontSize()-1)
        spoilerLog.string = "ROM not yet generated"
        spoilerLog.isEditable = false
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

