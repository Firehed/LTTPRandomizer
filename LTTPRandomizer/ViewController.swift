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

    let font = NSFont.userFixedPitchFont(ofSize: NSFont.systemFontSize()-1)!

    @IBOutlet weak var seedField: NSTextField!
    @IBOutlet weak var difficultyButton: NSPopUpButton!
    @IBOutlet var spoilerLog: NSTextView!
    @IBOutlet weak var spoilerDisclosureButton: NSButton!
    @IBOutlet weak var spoilerDisclosureButtonLabel: NSButton!

    @IBAction func spoilerDisclosureButtonLabelPressed(_ sender: AnyObject) {
        // XOR 1 to flip state
        spoilerDisclosureButton.state ^= 1
        spoilerDisclosureButtonPressed(sender)
    }
    @IBAction func spoilerDisclosureButtonPressed(_ sender: AnyObject) {
        toggleShowSpoliers(show: spoilerDisclosureButton.state == 1)
    }

    func toggleShowSpoliers(show: Bool) {
        if show {
            spoilerLog.enclosingScrollView?.isHidden = false
            spoilerDisclosureButtonLabel.title = "Hide spoliers"
        } else {
            spoilerLog.enclosingScrollView?.isHidden = true
            spoilerDisclosureButtonLabel.title = "Show spoliers"
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
        let randomizer: PRNG = SeededRandomizer(seed: seed)
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

        let itemRandomizer = ItemRandomizer(randomizer: randomizer, difficulty: difficulty)

        let builder = RomBuilder(randomizer: randomizer)

        let panel = NSSavePanel()
        panel.allowedFileTypes = ["sfc"]
        panel.nameFieldStringValue = itemRandomizer.defaultFileName
        if panel.runModal() == NSFileHandlingPanelOKButton {
            let (locations, patches) = itemRandomizer.randomize()
            writeSpolierLog(seedName: itemRandomizer.defaultFileName, locations: locations)
            if let rom = builder.patch(locations: locations, additionalPatches: patches) {
                builder.write(rom: rom, to: panel.url!)
            } else {
                NSLog("builder.patch returned nil")
            }
        }
    }

    func writeSpolierLog(seedName: String, locations: Locations) {
        var logText = ""
        logText.append(String(format: "Seed %@\n", seedName))

        let keyItems: [Item] = [
            .Bow, .Boomerang, .RedBoomerang, .Hookshot, .Mushroom, .Powder,
            .FireRod, .IceRod, .Bombos, .Ether, .Quake,
            .Lamp, .Hammer, .Shovel, .OcarinaInactive, .BugCatchingNet, .BookOfMudora,
            .CaneOfSomaria, .StaffOfByrna, .Cape, .MagicMirror,
            .PegasusBoots, .PowerGlove, .TitansMitt, .Flippers, .MoonPearl
        ]

        let keyItemText = keyItems.map { item in
            return locations.filter { $0.item == item }.first
        }.reduce("") {
            guard $1 != nil else { return $0 }
            return $0 + $1!.spoilerLogText + "\n"
        }

        logText.append(String(format: "Key items:\n%@\n\n", keyItemText))

        for location in locations {
            logText.append(location.spoilerLogText + "\n")
        }

        let atstr = NSAttributedString(string: logText, attributes: [NSFontAttributeName: font])
        spoilerLog.string = "" // Clear any existing text
        spoilerLog.textStorage?.insert(atstr, at: 0)
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
        difficultyButton.sizeToFit()

        spoilerLog.font = font
        spoilerLog.string = "ROM not yet generated"
        spoilerLog.isEditable = false
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

private extension Location {
    var spoilerLogText: String {
        return String(format: "%@: %@", item.description, name)
    }
}
