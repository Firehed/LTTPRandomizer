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
            && contains(Item.PowerGlove)
    }

    /// "Wall of caves" area
    func canAccessEasternDeathMountain() -> Bool {
        return canAccessDeathMountain()
            && (contains(Item.Hookshot) || containsAll(Item.Hammer, Item.MagicMirror))
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
            && contains(Item.PowerGlove)
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

    func canAccessLowerDarkWorld() -> Bool {
        return canAccessDarkWorld()
            && containsAny(Item.Hammer, Item.Hookshot)
    }

    func canAccessMireArea() -> Bool {
        return canFly()
            && contains(Item.TitansMitt)
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
        return canAccessLowerDarkWorld()
            && contains(Item.Flippers)
    }

    func canEnterSkullWoods() -> Bool {
        return canAccessLowerDarkWorld()
    }

    // Boss section
    func canEnterSkullWoods2() -> Bool {
        return canEnterSkullWoods()
            && contains(Item.FireRod)
    }

    func canEnterThievesTown() -> Bool {
        return canAccessLowerDarkWorld()
    }

    func canEnterIcePalace() -> Bool {
        return canMoveInDarkWorld()
            && containsAll(Item.Flippers)
            && canLiftHeavyRocks()
            && containsAny(Item.FireRod, Item.Bombos)
    }

    func canEnterMiseryMire() -> Bool {
        return canAccessMireArea()
            && contains(Item.Ether)
            && containsAny(Item.PegasusBoots, Item.Hookshot)
    }

    func canEnterTurtleRock() -> Bool {
        return canAccessEastDarkWorldDeathMountain()
            && contains(Item.Hammer)
            && contains(Item.Quake)
            && contains(Item.CaneOfSomaria)
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
            && contains(Item.Bow)
            && contains(Item.Hammer)
            && contains(Item.Lamp) // canLightTorches?
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
