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
        return canLiftRocks() || canFly()
    }

    /// "Wall of caves" area
    func canAccessEasternDeathMountain() -> Bool {
        return canAccessDeathMountain()
            && (contains(Item.Hookshot) // Southern route
                || containsAll(Item.Hammer, Item.MagicMirror)) // from Hera
    }

    func canAccessZorasDomain() -> Bool {
        return canLiftRocks() // Normal route
            || contains(Item.Flippers) // Use warp whirlpool near wishing well
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
        return canAccessDeathMountain()
            && (containsAll(Item.Hookshot, Item.Hammer) // wrap around via Eastern
                || contains(Item.MagicMirror)) // standard route
    }

    func canEnterHyruleCastleTower() -> Bool {
        // Technically, this is canGetAtLeastMasterSword, but using that logic
        // creates infinite recursion since the check for tempered sword ends up
        // calling back into this function. As such, just do the explicit master
        // sword check. In practice it doesn't really matter for spawn points.
        return canGetMasterSword() || contains(Item.Cape)
    }

}

// MARK: Light world: Defeat dungeons
extension SetAlgebra where Element == Item {

    func canDefeatEasternPalace() -> Bool {
        return canEnterEasternPalace()
            && hasAnyBow()
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

    func canDefeatAgahnim1() -> Bool {
        return canEnterHyruleCastleTower()
    }

}

// MARK: Dark world: Overworld
extension SetAlgebra where Element == Item {

    func canAccessEastDarkWorldDeathMountain() -> Bool {
        return canAccessEasternDeathMountain()
            && canLiftHeavyRocks() // All warp tiles require
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

    func canAccessSouthDarkWorld() -> Bool {
        guard contains(.MoonPearl) else {
            return false
        }
        // Can access south from north, reverse not guarateed
        if canAccessNorthWestDarkWorld() {
            return true
        }
        // Intended route based on in-game crystal order
        return canAccessPyramid() && contains(.Hammer)
    }

    func canAccessMireArea() -> Bool {
        return canFly()
            && canLiftHeavyRocks()
    }

    func canAccessPyramid() -> Bool {
        return canDefeatAgahnim1() // Normal progression
            || (containsAll(.Hammer, .MoonPearl) && canLiftRocks()) // Swamp palace warp tile
            || (containsAll(.Flippers, .MoonPearl) && canLiftHeavyRocks()) // Village and swim
    }

}

// MARK: Dark world: Enter dungeons
extension SetAlgebra where Element == Item {

    func canEnterDarkPalace() -> Bool {
        return canAccessPyramid()
            && contains(.MoonPearl)
    }

    func canEnterSwampPalace() -> Bool {
        return canAccessSouthDarkWorld()
            && containsAll(Item.Flippers, Item.MagicMirror)
    }

    func canEnterSkullWoods() -> Bool {
        return canAccessNorthWestDarkWorld()
    }

    func canEnterThievesTown() -> Bool {
        return canAccessNorthWestDarkWorld()
    }

    func canEnterIcePalace() -> Bool {
        return containsAll(Item.Flippers, Item.MoonPearl)
            && canLiftHeavyRocks()
            && containsAny(Item.FireRod, Item.Bombos)
    }

    private func findRequiredMedallion(from: [Item], default defaultItem: Item) -> Item {
        let possible = Set(from) as! Self
        let medallion = intersection(possible) as! Set<Item>
        guard medallion.count == 1 else {
            NSLog("No source medallion found")
            return defaultItem
        }
        return medallion.first!.associatedMedallion ?? defaultItem
    }

    private func findMireRequiredMedallion() -> Item {
        return findRequiredMedallion(from: [.MireBombos, .MireEther, .MireQuake], default: .Ether)
    }

    func canEnterMiseryMire() -> Bool {
        return canAccessMireArea()
            && containsAll(findMireRequiredMedallion(), Item.MoonPearl)
            && containsAny(Item.PegasusBoots, Item.Hookshot)
    }

    func findTurtleRockRequiredMedallion() -> Item {
        return findRequiredMedallion(from: [.TRBombos, .TREther, .TRQuake], default: .Quake)
    }

    func canEnterTurtleRock() -> Bool {
        return canAccessEastDarkWorldDeathMountain()
            && containsAll(Item.Hammer, findTurtleRockRequiredMedallion(), Item.CaneOfSomaria, Item.MoonPearl)
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
            && hasAnyBow()
            && contains(Item.Hammer)
    }

    func canDefeatSwampPalace() -> Bool {
        return canEnterSwampPalace()
            && containsAll(Item.Hookshot, Item.Hammer)
    }

    func canDefeatSkullWoods() -> Bool {
        return canEnterSkullWoods()
            && contains(Item.FireRod)
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
            && containsAll(Item.IceRod, Item.FireRod)
    }

}


// MARK: Item interactions
extension SetAlgebra where Element == Item {

    func canFly() -> Bool {
        return containsAny(Item.OcarinaInactive, Item.OcarinaActive)
    }

    func canGetMasterSword() -> Bool {
        return containsAny(.L2Sword, .L3Sword, .L4Sword)
            || ((canDefeatEasternPalace() || contains(.PendantOfCourage))
                && (canDefeatDesertPalace() || contains(.PendantOfPower))
                && (canDefeatTowerOfHera() || contains(.PendantOfWisdom)))
    }

    func canGetTemperedSword() -> Bool {
        return containsAny(.L3Sword, .L4Sword)
            || (canAccessNorthWestDarkWorld()
                && canLiftHeavyRocks()
                && contains(Item.MagicMirror))
    }

    func canGetGoldenSword() -> Bool {
        return contains(.L4Sword)
            || (canAccessPyramid()
                && canGetTemperedSword()
                && canDefeatDarkPalace()
                && canDefeatSwampPalace()
                && canDefeatSkullWoods()
                && canDefeatThievesTown()
                && canDefeatIcePalace()
                && canDefeatMiseryMire())
    }

    func canGetAtLeastMasterSword() -> Bool {
        return canGetMasterSword()
            || canGetTemperedSword()
            || canGetGoldenSword()
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

    func hasAnyBottle() -> Bool {
        return containsAny(
            Item.Bottle,
            Item.BottleWithGreenPotion,
            Item.BottleWithRedPotion,
            Item.BottleWithBluePotion,
            Item.BottleWithFairy,
            Item.BottleWithBee,
            Item.BottleWithGoldBee
        )
    }

    func hasAnyBow() -> Bool {
        return containsAny(.Bow, .BowAndArrows, .BowAndSilverArrows)
    }

}
