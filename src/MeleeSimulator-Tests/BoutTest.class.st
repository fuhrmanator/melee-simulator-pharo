Class {
	#name : #BoutTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
BoutTest >> testFightToTheDeath [
	| hero1 hero2 bout winner |
	hero1 := MSHero myrmidon.
	hero1 name: 'Fred'.
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
	| bout |
	bout := MSBout new.
	self deny: (bout isAutomaticHitForRoll: 7 forDice: 3).
	self deny: (bout isAutomaticHitForRoll: 6 forDice: 3).
	self assert: (bout isAutomaticHitForRoll: 5 forDice: 3).
	self assert: (bout isAutomaticHitForRoll: 4 forDice: 3).
	self assert: (bout isAutomaticHitForRoll: 3 forDice: 3).
	"No automatic hits for 4-die rolls (assumed defending)"
	self deny: (bout isAutomaticHitForRoll: 4 forDice: 4).

]

{ #category : #tests }
BoutTest >> testIsAutomaticMiss [
	| bout |
	bout := MSBout new.
	self deny: (bout isAutomaticMissForRoll: 14 forDice: 3).
	self deny: (bout isAutomaticMissForRoll: 15 forDice: 3).
	self assert: (bout isAutomaticMissForRoll: 16 forDice: 3).
	self assert: (bout isAutomaticMissForRoll: 17 forDice: 3).
	self assert: (bout isAutomaticMissForRoll: 18 forDice: 3).

	self deny: (bout isAutomaticMissForRoll: 18 forDice: 4).
	self deny: (bout isAutomaticMissForRoll: 19 forDice: 4).
	self assert: (bout isAutomaticMissForRoll: 20 forDice: 4).
	self assert: (bout isAutomaticMissForRoll: 21 forDice: 4).
	self assert: (bout isAutomaticMissForRoll: 22 forDice: 4).
	self assert: (bout isAutomaticMissForRoll: 23 forDice: 4).
	self assert: (bout isAutomaticMissForRoll: 24 forDice: 4).

]

{ #category : #tests }
BoutTest >> testIsBoutUnfinished [
	| hero1 hero2 bout |
	hero1 := MSHero name: 'H1' st: 12 dx: 12 weapon: MSWeapon broadsword armor: MSArmor none shield: MSShield none.
	hero2 := MSHero name: 'H2' st: 12 dx: 12 weapon: MSWeapon broadsword armor: MSArmor none shield: MSShield none.
	bout := MSBout hero1: hero1 hero2: hero2 poleCharge: false defendPoleCharge: false.
	self assert: bout isBoutUnfinished.
	

]

{ #category : #tests }
BoutTest >> testIsBrokenWeapon [
	| bout |
	bout := MSBout new.
	self deny: (bout isBrokenWeaponForRoll: 16 forDice: 3).
	self deny: (bout isBrokenWeaponForRoll: 17 forDice: 3).
	self assert: (bout isBrokenWeaponForRoll: 18 forDice: 3).

	self deny: (bout isBrokenWeaponForRoll: 20 forDice: 4).
	self deny: (bout isBrokenWeaponForRoll: 21 forDice: 4).
	self deny: (bout isBrokenWeaponForRoll: 22 forDice: 4).
	self assert: (bout isBrokenWeaponForRoll: 23 forDice: 4).
	self assert: (bout isBrokenWeaponForRoll: 24 forDice: 4).

]

{ #category : #tests }
BoutTest >> testIsDoubleDamage [
	| bout |
	bout := MSBout new.
	self deny: (bout isDoubleDamageForRoll: 5 forDice: 3).
	self assert: (bout isDoubleDamageForRoll: 4 forDice: 3).
	self deny: (bout isDoubleDamageForRoll: 3 forDice: 3).
	"Double damage not possible on 4 dice in Melee (defending)"
	self deny: (bout isDoubleDamageForRoll: 6 forDice: 4).
	self deny: (bout isDoubleDamageForRoll: 5 forDice: 4).
	self deny: (bout isDoubleDamageForRoll: 4 forDice: 4).

]

{ #category : #tests }
BoutTest >> testIsDroppedWeapon [
	| bout |
	bout := MSBout new.
	self deny: (bout isDroppedWeaponForRoll: 16 forDice: 3).
	self assert: (bout isDroppedWeaponForRoll: 17 forDice: 3).
	self deny: (bout isDroppedWeaponForRoll: 18 forDice: 3).

	self deny: (bout isDroppedWeaponForRoll: 20 forDice: 4).
	self assert: (bout isDroppedWeaponForRoll: 21 forDice: 4).
	self assert: (bout isDroppedWeaponForRoll: 22 forDice: 4).
	self deny: (bout isDroppedWeaponForRoll: 23 forDice: 4).
	self deny: (bout isDroppedWeaponForRoll: 24 forDice: 4).

]

{ #category : #tests }
BoutTest >> testIsTripleDamage [
	| bout |
	bout := MSBout new.
	self deny: (bout isTripleDamageForRoll: 5 forDice: 3).
	self deny: (bout isTripleDamageForRoll: 4 forDice: 3).
	self assert: (bout isTripleDamageForRoll: 3 forDice: 3).
	"Triple damage not possible on 4 dice in Melee (defending)"
	self deny: (bout isTripleDamageForRoll: 5 forDice: 4).
	self deny: (bout isTripleDamageForRoll: 4 forDice: 4).
	self deny: (bout isTripleDamageForRoll: 6 forDice: 4).

]
