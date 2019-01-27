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
HeroTest >> testDamageTakenThisRound [
	| hero |
	
	hero := MSHero name: 'Joe' st: 12 dx: 12 weapon: MSWeapon none armor: MSArmor none shield: MSShield none.
	hero takeHits: 2.
	self assert: hero damageTakenThisRound equals: 2.
	hero takeHits: 4.
	self assert: hero damageTakenThisRound equals: 6.
	hero takeHits: 4.
	self assert: hero damageTakenThisRound equals: 10.

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
HeroTest >> testNewRound [
	| hero |
	
	hero := MSHero name: 'Joe' st: 12 dx: 12 weapon: MSWeapon none armor: MSArmor none shield: MSShield none.
	"Damage taken this round should reset to 0"
	self assert: hero damageTakenThisRound equals: 0.
	hero takeHits: 2.
	self assert: hero damageTakenThisRound equals: 2.
	hero takeHits: 4.
	self assert: hero damageTakenThisRound equals: 6.
	hero takeHits: 4.
	self assert: hero damageTakenThisRound equals: 10.
	hero newRound.
	self assert: hero damageTakenThisRound equals: 0.
	
	"Dex penalty lasts one complete round"
	hero := MSHero name: 'Joe' st: 12 dx: 12 weapon: MSWeapon none armor: MSArmor none shield: MSShield none.
	hero takeHits: 5.
	self assert: hero hasDxPenaltyFromInjuries.	
	"end of (partial) round when injury sustained"
	hero newRound.
	self assert: hero hasDxPenaltyFromInjuries.
	"end of one complete round"
	hero newRound.
	self deny: hero hasDxPenaltyFromInjuries.
	
	"Pick up weapon after one complete round"
	hero := MSHero name: 'Joe' st: 12 dx: 12 weapon: MSWeapon dagger armor: MSArmor none shield: MSShield none.
	hero dropWeapon.
	self assert: hero readiedWeapon equals: MSWeapon none. 
	hero newRound.
	hero pickUpWeapon.
	self assert: hero readiedWeapon equals: MSWeapon none. 
	hero newRound.
	self assert: hero readiedWeapon equals: MSWeapon dagger. 
	
]

{ #category : #tests }
HeroTest >> testSt [
	| hero |
	hero := MSHero new st: 12.
	self assert: hero st equals: 12.
]

{ #category : #tests }
HeroTest >> testTakeHits [
	| hero |
	
	hero := MSHero name: 'Joe' st: 12 dx: 12 weapon: MSWeapon none armor: MSArmor leather shield: MSShield none.
	hero takeHits: 2.
	self assert: hero damageTaken equals: 0.
	hero takeHits: 4.
	self assert: hero damageTaken equals: 2.
	hero armor: MSArmor none; takeHits: 4.
	self assert: hero damageTaken equals: 6.

]
