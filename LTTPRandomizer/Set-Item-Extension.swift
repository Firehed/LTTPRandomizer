//
//  Set-Item-Extension.swift
//  LTTPRandomizer
//
//  Created by Eric Stern on 7/30/16.
//  Copyright © 2016 Eric Stern. All rights reserved.
//

import Foundation

// For some reason, `extension Set where Element: Item` is invalid. *shrug*

// MARK: Light world: Overworld
extension SetAlgebra where Element == Item {

    func canAccessDeathMountain() -> Bool {
        return canEscapeCastle()
            && canLiftRocks()
    }

    /// "Wall of caves" area
    func canAccessEasternDeathMountain() -> Bool {
        return canAccessDeathMountain()
            && (contains(Item.Hookshot) // Southern route
                || containsAll(Item.Hammer, Item.MagicMirror)) // from Hera
    }

    func canAccessZorasDomain() -> Bool {
        // Original logic said (Flippers OR (Glove AND (Boots or Mitt))), which is just wrong:
        // * The flippers don't help you get to ZD (can't bypass rock near witch)
        // * You don't need to do anything with the rocks in front of the pit on the way
        return canEscapeCastle() && canLiftRocks()
    }

}

// MARK: Light world: Enter dungeons
extension SetAlgebra where Element == Item {

    func canEscapeCastle() -> Bool {
        return true
    }

    func canEnterEasternPalace() -> Bool {
        return canEscapeCastle()
    }

    func canEnterDesertPalace() -> Bool {
        return canEscapeCastle()
            && contains(Item.BookOfMudora)
    }

    func canEnterTowerOfHera() -> Bool {
        return canEscapeCastle()
            && canAccessDeathMountain()
            && contains(Item.MagicMirror)
    }

    func canEnterHyruleCastleTower() -> Bool {
        return canGetMasterSword() || contains(Item.Cape)
    }

}

// MARK: Light world: Defeat dungeons
extension SetAlgebra where Element == Item {

    func canDefeatEasternPalace() -> Bool {
        return canEnterEasternPalace()
            && contains(Item.Bow)
    }

    func canDefeatDesertPalace() -> Bool {
        // Note: Originally contained Bow. Very confident that isn't required.
        return canEnterDesertPalace()
            && canLightTorches()
            && canLiftRocks()
    }

    func canDefeatTowerOfHera() -> Bool {
        return canEnterTowerOfHera()
    }

    // Technically cape+net could work in place of master sword I think, so this may be wrong
    func canDefeatAgahnim1() -> Bool {
        return canEnterHyruleCastleTower()
    }


}

// MARK: Dark world: Overworld
extension SetAlgebra where Element == Item {

    func canAccessCatfish() -> Bool {
        return canAccessPyramid() && canLiftRocks()
    }

    func canAccessDarkWorld() -> Bool {
        return canMoveInDarkWorld()
            && (canDefeatAgahnim1() || containsAny(Item.Hammer, Item.TitansMitt))
    }

    func canAccessEastDarkWorldDeathMountain() -> Bool {
        return canAccessDeathMountain()
            && canMoveInDarkWorld()
            && canLiftHeavyRocks()
            && contains(Item.Hammer)
    }

    func canAccessNorthWestDarkWorld() -> Bool {
        guard contains(.MoonPearl) else {
            return false
        }
        // Village warp tile direct path
        if canLiftHeavyRocks() {
            return true
        }
        // Village warp tile through forest (typical NMG route)
        if canLiftRocks() && contains(.Hammer) {
            return true
        }
        // Start at Pyramid and hookshot across
        return canAccessPyramid()
            && contains(.Hookshot)
            && (canLiftRocks() || contains(.Flippers) || contains(.Hammer))
    }

    func canAccessLowerDarkWorld() -> Bool {
        return canAccessDarkWorld()
            && containsAny(Item.Hammer, Item.Hookshot)
    }

    func canAccessSouthDarkWorld() -> Bool {
        guard contains(.MoonPearl) else {
            return false
        }
        // Can access south from north, reverse not guarateed
        if canAccessNorthWestDarkWorld() {
            return true
        }
        // v5 says hammer or hookshot... I'm pretty sure it's actually just hammer
        return canAccessPyramid() && contains(.Hammer)
//        return canAccessPyramid() && containsAny(.Hammer, .Hookshot)
    }

    func canAccessMireArea() -> Bool {
        return canFly()
            && canLiftHeavyRocks()
            && canMoveInDarkWorld()
    }

    func canAccessPyramid() -> Bool {
        // If Link arrives in DW from having an early Titan's Mitt but no hammer, the Pyramid is inaccessible
        return canAccessDarkWorld()
            && (canDefeatAgahnim1() || contains(Item.Hammer))
    }

}

// MARK: Dark world: Enter dungeons
extension SetAlgebra where Element == Item {

    func canEnterDarkPalace() -> Bool {
        return canAccessPyramid()
    }

    func canEnterSwampPalace() -> Bool {
        return canAccessSouthDarkWorld()
            && contains(Item.Flippers)
            && contains(Item.MagicMirror)
    }

    func canEnterSkullWoods() -> Bool {
        return canAccessNorthWestDarkWorld()
    }

    // Boss section
    func canEnterSkullWoods2() -> Bool {
        return canEnterSkullWoods()
            && contains(Item.FireRod)
    }

    func canEnterThievesTown() -> Bool {
        return canAccessNorthWestDarkWorld()
    }

    func canEnterIcePalace() -> Bool {
        return containsAll(Item.Flippers, Item.MoonPearl)
            && canLiftHeavyRocks()
            && containsAny(Item.FireRod, Item.Bombos)
    }

    func canEnterMiseryMire() -> Bool {
        return canAccessMireArea()
            && containsAll(Item.Ether, Item.MoonPearl)
            && containsAny(Item.PegasusBoots, Item.Hookshot)
    }

    func canEnterTurtleRock() -> Bool {
        return canAccessEastDarkWorldDeathMountain()
            && containsAll(Item.Hammer, Item.Quake, Item.CaneOfSomaria)
    }

    func canEnterGanonsTower() -> Bool {
        return canDefeatDarkPalace()
            && canDefeatSwampPalace()
            && canDefeatSkullWoods()
            && canDefeatThievesTown()
            && canDefeatIcePalace()
            && canDefeatMiseryMire()
            && canDefeatTurtleRock()
    }

}

// MARK: Dark world: Defeat dungeons
extension SetAlgebra where Element == Item {

    func canDefeatDarkPalace() -> Bool {
        return canEnterDarkPalace()
            && canLightTorches()
            && containsAll(Item.Bow, Item.Hammer)
    }

    func canDefeatSwampPalace() -> Bool {
        return canEnterSwampPalace()
            && contains(Item.Hookshot)
    }

    func canDefeatSkullWoods() -> Bool {
        return canEnterSkullWoods2()
    }

    func canDefeatThievesTown() -> Bool {
        return canEnterThievesTown()
    }

    func canDefeatIcePalace() -> Bool {
        return canEnterIcePalace()
            && contains(.Hammer)
    }

    func canDefeatMiseryMire() -> Bool {
        // Note: Used to have Lamp instead of canLightTorches
        return canEnterMiseryMire()
            && contains(Item.CaneOfSomaria)
            && canLightTorches()
    }

    func canDefeatTurtleRock() -> Bool {
        return canEnterTurtleRock()
            && contains(Item.IceRod)
            && contains(Item.FireRod)
    }

}


// MARK: Item interactions
extension SetAlgebra where Element == Item {

    func canFly() -> Bool {
        // Currently the Shovel location is randomized but the Flute is fixed to the dig location. If that changes, this will need to be updated.
        return containsAny(Item.Shovel, Item.OcarinaInactive, Item.OcarinaActive)
    }

    func canGetMasterSword() -> Bool {
        // Or containsAny(Sword2, Sword3, Sword4) ?
        return canDefeatEasternPalace()
            && canDefeatDesertPalace()
            && canDefeatTowerOfHera()
    }

    func canLiftHeavyRocks() -> Bool {
        return contains(Item.TitansMitt)
    }

    func canLiftRocks() -> Bool {
        return containsAny(Item.PowerGlove, Item.TitansMitt)
    }

    func canLightTorches() -> Bool {
        return containsAny(Item.Lamp, Item.FireRod)
    }

    /// Link will have general free movement in DW (not bunny, can go to LW)
    func canMoveInDarkWorld() -> Bool {
        return containsAll(Item.MoonPearl, Item.MagicMirror)
    }
    
}
