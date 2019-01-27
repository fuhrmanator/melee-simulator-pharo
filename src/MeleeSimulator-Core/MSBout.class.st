Class {
	#name : #MSBout,
	#superclass : #Object,
	#instVars : [
		'hero1',
		'hero2',
		'round',
		'winHero1',
		'winHero2',
		'criticalMisses',
		'criticalHits',
		'isPoleCharge',
		'isDefendOnPoleCharge',
		'heroMap'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #'class initialization' }
MSBout class >> hero1: aMSHero hero2: aMSHero2 poleCharge: boolean1 defendPoleCharge: boolean2 [
	^ self new
		hero1: aMSHero;
		hero2: aMSHero2;
		poleCharge: boolean1;
		defendPoleCharge: boolean2
]

{ #category : #accessing }
MSBout >> defendPoleCharge: boolean [ 
	isDefendOnPoleCharge := boolean.
]

{ #category : #accessing }
MSBout >> hero1: aMSHero [ 
	hero1 := aMSHero
]

{ #category : #accessing }
MSBout >> hero2: aMSHero [ 
	hero2 := aMSHero
]

{ #category : #initialization }
MSBout >> initialize [
	super initialize.
	hero1 := nil.
	hero2 := nil.
	round := 0.
	winHero1 := 0.
	winHero2 := 0.
	criticalMisses :=0. criticalHits:=0.  isPoleCharge:=false.  isDefendOnPoleCharge:=false.  heroMap := Dictionary new.
]

{ #category : #'as yet unclassified' }
MSBout >> isAutomaticHitForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal <= 5 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	nDice = 4 ifTrue: [ ^ false ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isAutomaticMissForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal >= 16 ].
	nDice = 4 ifTrue: [ ^ rollTotal >= 20 ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isBoutFinished [
	^ (hero1 isConscious & hero2 isConscious & hero1 canDoDamage & hero2 canDoDamage) not
]

{ #category : #'as yet unclassified' }
MSBout >> isBoutUnfinished [
	^ hero1 isConscious & hero2 isConscious & hero1 canDoDamage
		& hero2 canDoDamage
]

{ #category : #'as yet unclassified' }
MSBout >> isBrokenWeaponForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 18 ].
	nDice = 4 ifTrue: [ ^ (rollTotal = 23) | (rollTotal = 24) ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isDoubleDamageForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 4 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	nDice = 4 ifTrue: [ ^ false ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isDroppedWeaponForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 17 ].
	nDice = 4 ifTrue: [ ^ (rollTotal = 21) | (rollTotal = 22) ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isTripleDamageForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 3 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	nDice = 4 ifTrue: [ ^ false ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #accessing }
MSBout >> poleCharge: boolean [ 
	isPoleCharge := boolean.
]
