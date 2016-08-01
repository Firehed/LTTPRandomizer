//
//  Item.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/23/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

enum Item: UInt8, CustomStringConvertible {
    
    case Nothing = 0xFF
    case L1SwordAndShield = 0x00 // can't be used until after uncle dies
    case L2Sword = 0x01 // crashes game
    case L3Sword = 0x02 // can't be used until after uncle dies
    case L4Sword = 0x03 // can't be used until after uncle dies
    case BlueShield = 0x04 // can't be used until after uncle dies
    case RedShield = 0x05 // can't be used until after uncle dies
    case MirrorShield = 0x06 // can't be used until after uncle dies
    case FireRod = 0x07
    case IceRod = 0x08
    case Hammer = 0x09
    case Hookshot = 0x0a
    case Bow = 0x0b
    case Boomerang = 0x0c // alt: 10 arrows
    case Powder = 0x0d
    case Bee = 0x0e // does nothing if no bottle
    case Bombos = 0x0f
    case Ether = 0x10
    case Quake = 0x11
    case Lamp = 0x12 // alt: 5 rupees
    case Shovel = 0x13
    case OcarinaInactive = 0x14
    case CaneOfSomaria = 0x15
    case Bottle = 0x16
    case PieceOfHeart = 0x17
    case StaffOfByrna = 0x18
    case Cape = 0x19
    case MagicMirror = 0x1a
    case PowerGlove = 0x1b
    case TitansMitt = 0x1c
    case BookOfMudora = 0x1d
    case Flippers = 0x1e
    case MoonPearl = 0x1f
    case Crystal = 0x20 // crashes game
    case BugCatchingNet = 0x21
    case BlueMail = 0x22
    case RedMail = 0x23
    case Key = 0x24
    case Compass = 0x25
    case HeartContainerNoAnimation = 0x26
    case Bomb = 0x27
    case ThreeBombs = 0x28
    case Mushroom = 0x29
    case RedBoomerang = 0x2a
    case BottleWithRedPotion = 0x2b // does nothing if no bottle
    case BottleWithGreenPotion = 0x2c // does nothing if no bottle
    case BottleWithBluePotion = 0x2d // does nothing if no bottle
    case RedPotion = 0x2e // does nothing if no bottle
    case GreenPotion = 0x2f // does nothing if no bottle
    case BluePotion = 0x30 // does nothing if no bottle
    case TenBombs = 0x31
    case BigKey = 0x32
    case Map = 0x33
    case OneRupee = 0x34
    case FiveRupees = 0x35
    case TwentyRupees = 0x36
    case PendantOfCourage = 0x37 // green
    case PendantOfWisdom = 0x38 // red
    case PendantOfPower = 0x39 // blue
    case BowAndArrows = 0x3a
    case BowAndSilverArrows = 0x3b
    case BottleWithBee = 0x3c // does nothing if no bottle
    case BottleWithFairy = 0x3d // does nothing if no bottle
    case HeartContainerNoDialog = 0x3e
    case HeartContainer = 0x3f
    case OneHundredRupees = 0x40
    case FiftyRupees = 0x41
    case Heart = 0x42
    case Arrow = 0x43
    case TenArrows = 0x44
    case SmallMagic = 0x45
    case ThreeHundredRupees = 0x46
    case TwentyRupees2 = 0x47
    case BottleWithGoldBee = 0x48 // does nothing if no bottle
    case L1Sword = 0x49 // can't be used until after uncle dies
    case OcarinaActive = 0x4a
    case PegasusBoots = 0x4b

    var description: String {
        switch self {
        case .OneRupee: return "$1"
        case .FiveRupees: return "$5"
        case .TwentyRupees: return "$20"
        case .FiftyRupees: return "$50"
        case .OneHundredRupees: return "$100"
        case .ThreeHundredRupees: return "$300"
        case .PieceOfHeart: return "Heart Piece"
        case .HeartContainer: return "Full Heart Container"
        case .Key: return "Small key"
        case .BigKey: return "Big key"
        case .Compass: return "Compass"
        case .Map: return "Map"
        case .Bomb: return "Bomb x1"
        case .ThreeBombs: return "Bomb x3"
        case .TenBombs: return "Bomb x10"
        case .Arrow: return "Arrow x1"
        case .TenArrows: return "Arrow x10"

        case .Bow: return "Bow"
        case .Boomerang: return "Blue Boomerang"
        case .Hookshot: return "Hookshot"
            // bombs
        case .Powder: return "Powder"

        case .FireRod: return "Fire rod"
        case .IceRod: return "Ice rod"
        case .Bombos: return "Bombos"
        case .Ether: return "Ether"
        case .Quake: return "Quake"

        case .Lamp: return "Lamp"
        case .Hammer: return "Hammer"
        case .Shovel: return "Shovel"
        case .BugCatchingNet: return "Net"
        case .BookOfMudora: return "Book of Mudora"

        case .Bottle: return "Bottle"
        case .CaneOfSomaria: return "Red Cane"
        case .StaffOfByrna: return "Blue Cane"
        case .Cape: return "Cape"
        case .MagicMirror: return "Mirror"

        case .OcarinaInactive: return "Flute"
        case .RedBoomerang: return "Red Boomerang"

        case .BlueMail: return "Blue Mail"
        case .RedMail: return "Red Mail"

        case .RedShield: return "Red Shield"
        case .MirrorShield: return "Mirror Shield"

        case .PowerGlove: return "Power Glove"
        case .TitansMitt: return "Titan's Mitt"

        case .Flippers: return "Flippers"
        case .MoonPearl: return "Moon Pearl"
        case .PegasusBoots: return "Pegasus Boots"

        default:
            return String(self.rawValue)
//            return "Something I need to write"
        }
    }

    /// Various quantities of rupees
    var isMoney: Bool {
        switch self {
        case .OneRupee: fallthrough
        case .FiveRupees: fallthrough
        case .TwentyRupees: fallthrough
        case .TwentyRupees2: fallthrough // wtf
        case .FiftyRupees: fallthrough
        case .OneHundredRupees: fallthrough
        case .ThreeHundredRupees:
            return true
        default:
            return false
        }
    }

    /// Bombs and arrows
    var isConsumable: Bool {
        switch self {
        case .Bomb: fallthrough
        case .ThreeBombs: fallthrough
        case .TenBombs: fallthrough
        case .Arrow: fallthrough
        case .TenArrows:
            return true
        default:
            return false
        }
    }

    /// Heart containers
    var isHealth: Bool {
        switch self {
        case .HeartContainer: fallthrough
        case .PieceOfHeart:
            return true
        default:
            return false
        }
    }

    /// Keys, compass, map
    var isDungeonItem: Bool {
        switch self {
        case .Key: fallthrough
        case .BigKey: fallthrough
        case .Map: fallthrough
        case .Compass:
            return true
        default:
            return false
        }
    }

    /// Clothes and shields
    var isArmor: Bool {
        switch self {
        case .BlueShield: fallthrough
        case .RedShield: fallthrough
        case .MirrorShield: fallthrough
        case .BlueMail: fallthrough
        case .RedMail:
            return true
        default:
            return false
        }
    }

    /// Bottles and pre-filled variants
    var isBottle: Bool {
        switch self {
        case .Bottle: fallthrough
        case .BottleWithGreenPotion: fallthrough
        case .BottleWithBluePotion: fallthrough
        case .BottleWithRedPotion: fallthrough
        case .BottleWithBee: fallthrough
        case .BottleWithGoldBee: fallthrough
        case .BottleWithFairy:
            return true
        default:
            return false
        }
    }

    /// Does not help game progression
    var isJunk: Bool {
        return isConsumable || isMoney || isHealth || isDungeonItem || isArmor
    }

    private var level: UInt8 {
        switch self {
        case .RedBoomerang: fallthrough
        case .Powder: fallthrough
        case .MagicMirror: fallthrough
        case .TitansMitt: fallthrough
        case .RedShield: fallthrough
        case .OcarinaInactive: fallthrough
        case .L2Sword: fallthrough
        case .BowAndArrows: fallthrough
        case .RedMail:
            return 2
        case .BowAndSilverArrows: fallthrough
        case .OcarinaActive: fallthrough
        case .MirrorShield: fallthrough
        case .L3Sword:
            return 3
        case .L4Sword:
            return 4
        default:
            return 1
        }
    }

    private var inventoryCheckLocation: UInt8 {
        switch self {
        case Item.Bow: fallthrough
        case Item.BowAndArrows: fallthrough
        case Item.BowAndSilverArrows:
            return 0x40;
        case Item.Boomerang: fallthrough
        case Item.RedBoomerang:
            return 0x41
        case Item.Hookshot:
            return 0x42
        case Item.Mushroom: fallthrough
        case Item.Powder:
            return 0x44
        case Item.FireRod:
            return 0x45
        case Item.IceRod:
            return 0x46
        case Item.Bombos:
            return 0x47
        case Item.Ether:
            return 0x48
        case Item.Quake:
            return 0x49
        case Item.Lamp:
            return 0x4a
        case Item.Hammer:
            return 0x4b
        case Item.Shovel: fallthrough
        case Item.OcarinaActive: fallthrough
        case Item.OcarinaInactive:
            return 0x4c
        case Item.BugCatchingNet:
            return 0x4d
        case Item.BookOfMudora:
            return 0x4e
        case Item.CaneOfSomaria:
            return 0x50
        case Item.StaffOfByrna:
            return 0x51
        case Item.Cape:
            return 0x52
        case Item.MagicMirror:
            return 0x53
        case Item.PowerGlove: fallthrough
        case Item.TitansMitt:
            return 0x54
        case Item.PegasusBoots:
            return 0x55
        case Item.Flippers:
            return 0x56
        case Item.MoonPearl:
            return 0x57
        case Item.L1Sword: fallthrough
        case Item.L1SwordAndShield: fallthrough
        case Item.L2Sword: fallthrough
        case Item.L3Sword: fallthrough
        case Item.L4Sword:
            return 0x59
        case Item.BlueShield: fallthrough
        case Item.RedShield: fallthrough
        case Item.MirrorShield:
            return 0x5a
        case Item.BlueMail: fallthrough
        case Item.RedMail:
            return 0x5b
        default:
            return 0x00
        }
    }

    /// Special sequence of bytes to write indicating which item must not be in Link's posession to proceed
    var bytesForInventoryCheckOverride: NSData {
        if inventoryCheckLocation == 0 {
            return NSMutableData(length: 4)! // NUL x4
        }
        return NSData(bytes: [level, inventoryCheckLocation, 0xF3, 0x7E], length: 4)
    }

    func asData() -> NSData {
        return NSData(bytes: [self.rawValue], length: 1)
    }

    var bytesForCredits: NSData {
        // TODO: Vary text based on item
        let creditText = " cash money for sale"
        guard var bytes = creditText.data(using: String.Encoding.ascii, allowLossyConversion: false) else {
            return NSMutableData(length: 20)! // NUL x20
        }

        let text: NSMutableData = NSMutableData(capacity: 20)!
        for i in 0..<20 {
            var byte: UInt8
            switch bytes[i] {
            case 0x20: // space
                byte = 0x9f
                break
            case 0x5c: // \
                byte = 0x35
                break
            case 0x2d: // -
                byte = 0x36
                break
            case 0x2c: // ,
                byte = 0x37
                break
            default:
                byte = bytes[i] - 0x47
                break
            }
            text.append([byte], length: 1)
        }
        return text
    }
}
