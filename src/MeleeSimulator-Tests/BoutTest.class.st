Class {
	#name : #BoutTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
BoutTest >> testIsBoutUnfinished [
	| hero1 hero2 bout |
	hero1 := MSHero name: 'H1' st: 12 dx: 12 weapon: MSWeapon broadsword armor: MSArmor none shield: MSShield none.
	hero2 := MSHero name: 'H2' st: 12 dx: 12 weapon: MSWeapon broadsword armor: MSArmor none shield: MSShield none.
	bout := MSBout hero1: hero1 hero2: hero2 poleCharge: false defendPoleCharge: false.
	self assert: bout isBoutUnfinished.
	

]
