Class {
	#name : #HeroTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
HeroTest >> testAdjDx [
	| hero |
	hero := MSHero new st:12; dx: 12.
	self assert: hero dx equals: 12.
	hero armor: MSArmor leather.
	self assert: hero adjDx equals: 10.
	
	"Reaction to injury"
	hero := MSHero name: 'Joe' st: 12 dx: 12 weapon: MSWeapon none armor: MSArmor leather shield: MSShield none.
	self assert: hero dx equals: 12.
	self assert: hero adjDx equals: 10.
	"5 or more damage (leather stops 2) should make dx -2 adjustment"
	hero takeHits: 7.
	self assert: hero adjDx equals: 8.
]

{ #category : #tests }
HeroTest >> testArmor [
	| hero |
	hero := MSHero new armor: MSArmor leather.
	self assert: hero armor equals: MSArmor leather.
	hero armor: MSArmor none.
	self assert: hero armor equals: MSArmor none.
	hero armor: MSArmor chain.
	self assert: hero armor equals: MSArmor chain.
	hero armor: MSArmor plate.
	self assert: hero armor equals: MSArmor plate.
]

{ #category : #tests }
HeroTest >> testDx [
	| hero |
	hero := MSHero new dx: 12.
	self assert: hero dx equals: 12.
]

{ #category : #tests }
HeroTest >> testName [
	| hero |
	hero := MSHero new name: 'Trevor'.
	self assert: hero name equals: 'Trevor'.
]

{ #category : #tests }
HeroTest >> testSt [
	| hero |
	hero := MSHero new st: 12.
	self assert: hero st equals: 12.
]
