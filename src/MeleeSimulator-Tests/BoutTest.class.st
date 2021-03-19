Class {
	#name : #BoutTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
BoutTest >> testAttackeeFacingBonus [
	| bout hero |
	bout := MSBout new.
	hero := MSHero myrmidon.
	self assert: (bout attackeeFacingBonus: hero) equals: 0.
	hero dropWeapon.
	bout tryPickUp: hero.
	self assert: (bout attackeeFacingBonus: hero) equals: 4.

]

{ #category : #tests }
BoutTest >> testFightToTheDeath [
	| hero1 hero2 bout winner |
	hero1 := MSHero myrmidon.
	hero1 name: 'Fred'; readiedWeapon: MSWeapon shortsword.
	hero2 := MSHero myrmidon.
	hero2 name: 'Barney'.
	bout := MSBout
		hero1: hero1
		hero2: hero2
		poleCharge: false
		defendPoleCharge: false.
	winner := bout fightToTheDeath.
	self assert: winner = hero1 | (winner = hero2) | winner isNil
]

{ #category : #tests }
BoutTest >> testIsAutomaticHit [
	| bout roll |
	bout := MSBout new.
	roll := MSRoll new diceRolls: #(3 3 1). "7 on three dice"
	self deny: (bout isAutomaticHitForRoll: roll).
	roll diceRolls: #(3 2 1). "6 on three dice"
	self deny: (bout isAutomaticHitForRoll: roll).
	roll diceRolls: #(3 1 1). "5 on three dice"
	self assert: (bout isAutomaticHitForRoll: roll).
	roll diceRolls: #(2 1 1). "4 on three dice"
	self assert: (bout isAutomaticHitForRoll: roll).
	roll diceRolls: #(1 1 1). "3 on three dice"
	self assert: (bout isAutomaticHitForRoll: roll).
	"No automatic hits for 4-die rolls (assumed defending)"
	roll diceRolls: #(1 1 1 1). "4 on four dice"
	self deny: (bout isAutomaticHitForRoll: roll).

]

{ #category : #tests }
BoutTest >> testIsAutomaticMiss [
	| bout roll |
	bout := MSBout new.
	roll := MSRoll new diceRolls: #(5 5 4).	"14 on 3 dice"
	self deny: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(5 5 5).	"15 on 3 dice"
	self deny: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(5 5 6).	"16 on 3 dice"
	self assert: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(5 6 6).	"17 on 3 dice"
	self assert: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 6).	"18 on 3 dice"
	self assert: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 5 1).	"18 on 4 dice"
	self deny: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 5 2).	"19 on 4 dice"
	self deny: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 5 3).	"20 on 4 dice"
	self assert: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 5 4).	"21 on 4 dice"
	self assert: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 5 5).	"22 on 4 dice"
	self assert: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 5 6).	"23 on 4 dice"
	self assert: (bout isAutomaticMissForRoll: roll).
	roll := roll diceRolls: #(6 6 6 6).	"24 on 4 dice"
	self assert: (bout isAutomaticMissForRoll: roll)
]

{ #category : #tests }
BoutTest >> testIsBoutUnfinished [
	| hero1 hero2 bout |
	hero1 := MSHero
		name: 'H1'
		st: 12
		dx: 12
		weapon: MSWeapon broadsword
		armor: MSArmor none
		shield: MSShield none.
	hero2 := MSHero
		name: 'H2'
		st: 12
		dx: 12
		weapon: MSWeapon broadsword
		armor: MSArmor none
		shield: MSShield none.
	bout := MSBout
		hero1: hero1
		hero2: hero2
		poleCharge: false
		defendPoleCharge: false.
	self assert: bout isBoutUnfinished
]

{ #category : #tests }
BoutTest >> testIsBrokenWeapon [
	| bout roll |
	bout := MSBout new.
	roll := MSRoll new.
	roll diceRolls: #(5 5 6).	"16 on 3 dice"
	self deny: (bout isBrokenWeaponForRoll: roll).
	roll diceRolls: #(5 6 6).	"17 on 3 dice"
	self deny: (bout isBrokenWeaponForRoll: roll).
	roll diceRolls: #(6 6 6).	"18 on 3 dice"
	self assert: (bout isBrokenWeaponForRoll: roll).
	roll diceRolls: #(6 6 6 2).	"20 on 4 dice"
	self deny: (bout isBrokenWeaponForRoll: roll).
	roll diceRolls: #(6 6 6 3).	"21 on 4 dice"
	self deny: (bout isBrokenWeaponForRoll: roll).
	roll diceRolls: #(6 6 6 4).	"22 on 4 dice"
	self deny: (bout isBrokenWeaponForRoll: roll).
	roll diceRolls: #(6 6 6 5).	"23 on 4 dice"
	self assert: (bout isBrokenWeaponForRoll: roll).
	roll diceRolls: #(6 6 6 6).	"24 on 4 dice"
	self assert: (bout isBrokenWeaponForRoll: roll)
]

{ #category : #tests }
BoutTest >> testIsDoubleDamage [
	| bout roll |
	bout := MSBout new.
	roll := MSRoll new.
	roll diceRolls: #(1 1 3).	"5 on 3 dice"
	self deny: (bout isDoubleDamageForRoll: roll).
	roll diceRolls: #(1 1 2).	"4 on 3 dice"
	self assert: (bout isDoubleDamageForRoll: roll).
	roll diceRolls: #(1 1 1).	"3 on 3 dice"
	self deny: (bout isDoubleDamageForRoll: roll).
	"Double damage not possible on 4 dice in Melee (defending)"
	roll diceRolls: #(1 1 3 1).	"6 on 4 dice"
	self deny: (bout isDoubleDamageForRoll: roll).
	roll diceRolls: #(1 1 2 1).	"5 on 4 dice"
	self deny: (bout isDoubleDamageForRoll: roll).
	roll diceRolls: #(1 1 1 1).	"4 on 4 dice"
	self deny: (bout isDoubleDamageForRoll: roll).

]

{ #category : #tests }
BoutTest >> testIsDroppedWeapon [
	| bout roll |
	bout := MSBout new.
	roll := MSRoll new.
	roll diceRolls: #(6 6 4).	"16 on 3 dice"
	self deny: (bout isDroppedWeaponForRoll: roll).
	roll diceRolls: #(6 6 5).	"17 on 3 dice"
	self assert: (bout isDroppedWeaponForRoll: roll).
	roll diceRolls: #(6 6 6).	"18 on 3 dice"
	self deny: (bout isDroppedWeaponForRoll: roll).

	roll diceRolls: #(6 6 5 3).	"20 on 4 dice"
	self deny: (bout isDroppedWeaponForRoll: roll).
	roll diceRolls: #(6 6 5 4).	"21 on 4 dice"
	self assert: (bout isDroppedWeaponForRoll: roll).
	roll diceRolls: #(6 6 5 5).	"22 on 4 dice"
	self assert: (bout isDroppedWeaponForRoll: roll).
	roll diceRolls: #(6 6 6 5).	"23 on 4 dice"
	self deny: (bout isDroppedWeaponForRoll: roll).
	roll diceRolls: #(6 6 6 6).	"24 on 4 dice"
	self deny: (bout isDroppedWeaponForRoll: roll).

]

{ #category : #tests }
BoutTest >> testIsTripleDamage [
	| bout roll |
	bout := MSBout new.
	roll := MSRoll new.
	roll diceRolls: #(1 1 3).	"5 on 3 dice"
	self deny: (bout isTripleDamageForRoll: roll).
	roll diceRolls: #(1 1 2).	"4 on 3 dice"
	self deny: (bout isTripleDamageForRoll: roll).
	roll diceRolls: #(1 1 1).	"3 on 3 dice"
	self assert: (bout isTripleDamageForRoll: roll).
	"Triple damage not possible on 4 dice in Melee (defending)"
	roll diceRolls: #(1 1 1 2).	"5 on 4 dice"
	self deny: (bout isTripleDamageForRoll: roll).
	roll diceRolls: #(1 1 1 1).	"4 on 4 dice"
	self deny: (bout isTripleDamageForRoll: roll).
	roll diceRolls: #(1 1 1 3).	"6 on 4 dice"
	self deny: (bout isTripleDamageForRoll: roll)
]

{ #category : #tests }
BoutTest >> testTryPickUp [
	| bout hero |
	bout := MSBout new.
	hero := MSHero myrmidon.
	hero dropWeapon.
	bout tryPickUp: hero.
	self assert: hero isPickingUpWeapon.
	self assert: hero isProne.
	self assert: hero readiedWeapon equals: MSWeapon none.

]
