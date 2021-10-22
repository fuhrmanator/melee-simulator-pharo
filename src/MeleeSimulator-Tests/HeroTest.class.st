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
HeroTest >> testAdjSt [
	| hero |
	hero := MSHero new st:12; dx: 12.
	self assert: hero adjSt equals: 12.
	hero takeHits: 7.
	self assert: hero adjSt equals: 5.
	hero takeHits: 6.
	self assert: hero adjSt equals: 0.

]

{ #category : #tests }
HeroTest >> testAllHeroes [
	self assert: MSHero allHeroes size equals: 116
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
HeroTest >> testBreakWeapon [
	| hero heroCopy weapon |
	hero := MSHero myrmidon.
	weapon := hero weapon.
	heroCopy := hero copy.
	
	heroCopy breakWeapon.
	self assert: heroCopy readiedWeapon equals: MSWeapon none.
	self assert: heroCopy droppedWeapon equals: MSWeapon none.
	self assert: heroCopy weapon equals: weapon.

	hero readiedWeapon: weapon.
	self assert: hero readiedWeapon equals: weapon.
	self assert: hero droppedWeapon equals: MSWeapon none.

]

{ #category : #tests }
HeroTest >> testCanDoDamage [
	| hero |
	hero := MSHero name: 'Fred' st: 12 dx: 12 weapon: MSWeapon broadsword  armor: MSArmor none shield: MSShield none.
	self assert: hero canDoDamage.
	hero dropWeapon.
	"can still do damage (just later)"
	self assert: hero canDoDamage.
	"make hero unconscious"
	hero takeHits: 11.
	self deny: hero isConscious.
	self deny: hero canDoDamage.

	hero := MSHero name: 'Fred' st: 12 dx: 12 weapon: MSWeapon broadsword  armor: MSArmor none shield: MSShield none.
	self assert: hero canDoDamage.
	"make hero dead"
	hero takeHits: 12.
	self deny: hero isAlive.
	self deny: hero canDoDamage.

]

{ #category : #tests }
HeroTest >> testConfiguredWeapon [
	| hero |
	hero := MSHero new.
	hero weapon: MSWeapon none.
	self assert: hero readiedWeapon equals: MSWeapon none.
	self assert: hero weapon equals: MSWeapon none.
	hero weapon: MSWeapon dagger.
	self assert: hero readiedWeapon equals: MSWeapon dagger.
	self assert: hero weapon equals: MSWeapon dagger.

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
HeroTest >> testDropWeapon [
	| hero weapon |
	hero := MSHero new.
	weapon := MSWeapon morningstar.
	hero readiedWeapon: weapon.
	self assert: hero readiedWeapon equals: weapon.
	
	hero dropWeapon.
	self assert: hero readiedWeapon equals: MSWeapon none.
	self assert: hero droppedWeapon equals: weapon.
	

]

{ #category : #tests }
HeroTest >> testDx [
	| hero |
	hero := MSHero new dx: 12.
	self assert: hero dx equals: 12.
]

{ #category : #tests }
HeroTest >> testHasDxPenaltyFromInjuries [
	| hero |
	hero := MSHero myrmidon. "No armor, small shield"
	hero shield: MSShield none. "drop shield"
	hero takeHits: 2.
	self deny: hero hasDxPenaltyFromInjuries.
	hero takeHits: 3.
	"dex penalty applies after 5 hits"
	self assert: hero hasDxPenaltyFromInjuries.
	"lasts next round, too"
	hero newRound.
	self assert: hero hasDxPenaltyFromInjuries.
	"recover"
	hero newRound.
	self deny: hero hasDxPenaltyFromInjuries.
	
]

{ #category : #tests }
HeroTest >> testIsAlive [
	| hero |
	hero := MSHero name: 'Fred' st: 12 dx: 12 weapon: MSWeapon broadsword  armor: MSArmor none shield: MSShield none.
	self assert: hero isAlive.
	hero takeHits: 12.
	self deny: hero isAlive
]

{ #category : #tests }
HeroTest >> testMyrmidon [
	| hero |
	hero := MSHero myrmidon.
	self assert: hero readiedWeapon equals: MSWeapon broadsword.
	self assert: hero st equals: 12.
	self assert: hero dx equals: 12.
	self assert: hero armor equals: MSArmor none.
	self assert: hero shield equals: MSShield smallShield.
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
	
	"Advance round doesn't change anything"
	hero := MSHero name: 'Joe' st: 12 dx: 12 weapon: MSWeapon dagger armor: MSArmor none shield: MSShield none.
	hero newRound.
	self assert: hero readiedWeapon equals: MSWeapon dagger.
]

{ #category : #tests }
HeroTest >> testPickupWeapon [
	| hero weapon |
	hero := MSHero new.
	weapon := MSWeapon morningstar.
	hero readiedWeapon: weapon.
	self assert: hero readiedWeapon equals: weapon.
	
	hero dropWeapon.
	self assert: hero readiedWeapon equals: MSWeapon none.
	self assert: hero droppedWeapon equals: weapon.
	self deny: hero isPickingUpWeapon.
	
	hero pickUpWeapon.
	self assert: hero isPickingUpWeapon.
]

{ #category : #tests }
HeroTest >> testReadiedWeapon [
	| hero |
	hero := MSHero new.
	hero readiedWeapon: MSWeapon none.
	self assert: hero readiedWeapon equals: MSWeapon none.
	hero readiedWeapon: MSWeapon dagger.
	self assert: hero readiedWeapon equals: MSWeapon dagger.
	hero readiedWeapon: MSWeapon rapier.
	self assert: hero readiedWeapon equals: MSWeapon rapier.
	hero readiedWeapon: MSWeapon club.
	self assert: hero readiedWeapon equals: MSWeapon club.
	hero readiedWeapon: MSWeapon hammer.
	self assert: hero readiedWeapon equals: MSWeapon hammer.
	hero readiedWeapon: MSWeapon cutlass.
	self assert: hero readiedWeapon equals: MSWeapon cutlass.
	hero readiedWeapon: MSWeapon shortsword.
	self assert: hero readiedWeapon equals: MSWeapon shortsword.
	hero readiedWeapon: MSWeapon mace.
	self assert: hero readiedWeapon equals: MSWeapon mace.
	hero readiedWeapon: MSWeapon smallAx.
	self assert: hero readiedWeapon equals: MSWeapon smallAx.
	hero readiedWeapon: MSWeapon broadsword.
	self assert: hero readiedWeapon equals: MSWeapon broadsword.
	hero readiedWeapon: MSWeapon morningstar.
	self assert: hero readiedWeapon equals: MSWeapon morningstar.
	hero readiedWeapon: MSWeapon twoHandedSword.
	self assert: hero readiedWeapon equals: MSWeapon twoHandedSword.
	hero readiedWeapon: MSWeapon battleaxe.
	self assert: hero readiedWeapon equals: MSWeapon battleaxe.
	hero readiedWeapon: MSWeapon javelin.
	self assert: hero readiedWeapon equals: MSWeapon javelin.
	hero readiedWeapon: MSWeapon spear.
	self assert: hero readiedWeapon equals: MSWeapon spear.
	hero readiedWeapon: MSWeapon halberd.
	self assert: hero readiedWeapon equals: MSWeapon halberd.
	hero readiedWeapon: MSWeapon pikeAxe.
	self assert: hero readiedWeapon equals: MSWeapon pikeAxe
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
	hero := MSHero
		name: 'Joe'
		st: 12
		dx: 12
		weapon: MSWeapon none
		armor: MSArmor leather
		shield: MSShield none.
	hero takeHits: 2.
	self assert: hero damageTaken equals: 0.
	hero takeHits: 4.
	self assert: hero damageTaken equals: 2.
	"Drop armor"
	hero
		armor: MSArmor none;
		takeHits: 4.
	self assert: hero damageTaken equals: 6.
	"Ready a Shield"
	hero shield: MSShield smallShield; takeHits: 3.
	self assert: hero damageTaken equals: 8.
]
