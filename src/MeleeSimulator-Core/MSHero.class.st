Class {
	#name : #MSHero,
	#superclass : #Object,
	#instVars : [
		'name',
		'st',
		'dx',
		'readiedWeapon',
		'droppedWeapon',
		'armor',
		'shield',
		'isKnockedDown',
		'isStandingUp',
		'isPickingUpWeapon',
		'damageTaken',
		'damageTakenThisRound',
		'hasDxPenaltyFromInjuries',
		'isRecovering',
		'isDefending',
		'isCharging'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #'as yet unclassified' }
MSHero class >> myrmidon [
	^ self new
		name: 'Myrmidon';
		st: 12;
		dx: 12;
		readiedWeapon: MSWeapon broadsword;
		armor: MSArmor none;
		shield: MSShield smallShield
]

{ #category : #'as yet unclassified' }
MSHero class >> name: heroName st: heroSt dx: heroDx weapon: heroWeapon armor: heroArmor shield: heroShield [
	^ self new
		name: heroName;
		st: heroSt;
		dx: heroDx;
		readiedWeapon: heroWeapon;
		armor: heroArmor;
		shield: heroShield
]

{ #category : #accessing }
MSHero >> adjDx [
	^ dx - armor dxAdjustment - shield dxAdjustment
		-
			(hasDxPenaltyFromInjuries
				ifTrue: [ 2 ]
				ifFalse: [ 0 ])
		-
			(self hasStrengthLowPenalty
				ifTrue: [ 3 ]
				ifFalse: [ 0 ])
]

{ #category : #combat }
MSHero >> adjSt [
	^ (st - damageTaken) max: 0

]

{ #category : #accessing }
MSHero >> armor [
	^ armor
]

{ #category : #accessing }
MSHero >> armor: aMSArmor [ 
	armor := aMSArmor
]

{ #category : #combat }
MSHero >> breakWeapon [
	readiedWeapon := MSWeapon none.
	droppedWeapon := MSWeapon none.
]

{ #category : #combat }
MSHero >> canDoDamage [
	"Is conscious and has a weapon (or dropped one) that can do damage"
	^ self isConscious
		& (readiedWeapon ~= MSWeapon none | (droppedWeapon ~= MSWeapon none))
]

{ #category : #accessing }
MSHero >> damageTaken [
	^ damageTaken
]

{ #category : #accessing }
MSHero >> damageTakenThisRound [
	^ damageTakenThisRound
]

{ #category : #combat }
MSHero >> dropWeapon [
	droppedWeapon := readiedWeapon.
	readiedWeapon := MSWeapon none.
]

{ #category : #accessing }
MSHero >> droppedWeapon [
	^ droppedWeapon
]

{ #category : #accessing }
MSHero >> dx [
	^ dx
]

{ #category : #accessing }
MSHero >> dx: anInteger [ 
	dx := anInteger
]

{ #category : #accessing }
MSHero >> hasDxPenaltyFromInjuries [
	^ hasDxPenaltyFromInjuries
]

{ #category : #combat }
MSHero >> hasStrengthLowPenalty [
	^ (st - damageTaken) <= 3
]

{ #category : #initialization }
MSHero >> initialize [
	super initialize.
	name := ''.
	st := 0.
	dx := 0.
	readiedWeapon := MSWeapon none.
	droppedWeapon := MSWeapon none.
	armor := MSArmor none.
	shield := MSShield none.
	isKnockedDown := false.
	isStandingUp := false.
	isPickingUpWeapon := false.
	damageTaken := 0.
	damageTakenThisRound := 0.
	hasDxPenaltyFromInjuries := false.
	isRecovering := false.
	isDefending := false.
	isCharging := false
]

{ #category : #combat }
MSHero >> isAlive [
	^ st - damageTaken > 0
]

{ #category : #accessing }
MSHero >> isCharging [
	^ isCharging
]

{ #category : #accessing }
MSHero >> isCharging: anObject [
	isCharging := anObject
]

{ #category : #combat }
MSHero >> isConscious [
	^ st - damageTaken > 1
]

{ #category : #accessing }
MSHero >> isDefending [
	^ isDefending
]

{ #category : #accessing }
MSHero >> isDefending: anObject [
	isDefending := anObject
]

{ #category : #accessing }
MSHero >> isKnockedDown [
	^ isKnockedDown
]

{ #category : #accessing }
MSHero >> isPickingUpWeapon [
	^ isPickingUpWeapon
]

{ #category : #combat }
MSHero >> isProne [
	^ isPickingUpWeapon 
]

{ #category : #accessing }
MSHero >> isRecovering [
	^ isRecovering
]

{ #category : #accessing }
MSHero >> isStandingUp [
	^ isStandingUp
]

{ #category : #accessing }
MSHero >> name [
	^ name
]

{ #category : #accessing }
MSHero >> name: aString [ 
	name := aString
]

{ #category : #combat }
MSHero >> newRound [
	"Called to transition the hero's state to a new round"

	isCharging := false.
	isDefending := false.
	damageTakenThisRound := 0.

	"Stand up, or pick up dropped weapon?"
	isStandingUp
		ifTrue: [ isKnockedDown := false.
			isStandingUp := false ]
		ifFalse: [ isPickingUpWeapon
				ifTrue: [ readiedWeapon := droppedWeapon.
					droppedWeapon := MSWeapon none.
					isPickingUpWeapon := false ] ].

	"Dx penalty lasts one complete round"
	hasDxPenaltyFromInjuries & isRecovering
		ifTrue: [ hasDxPenaltyFromInjuries := false.
			isRecovering := false ]
		ifFalse: [ hasDxPenaltyFromInjuries
				ifTrue: [ isRecovering := true ] ]
]

{ #category : #combat }
MSHero >> pickUpWeapon [
	isPickingUpWeapon := true.
]

{ #category : #accessing }
MSHero >> readiedWeapon [
	^ readiedWeapon
]

{ #category : #accessing }
MSHero >> readiedWeapon: aMSWeapon [ 
	readiedWeapon := aMSWeapon 
]

{ #category : #accessing }
MSHero >> shield [ 
	^ shield
]

{ #category : #accessing }
MSHero >> shield: aMSShield [
	shield := aMSShield.
]

{ #category : #accessing }
MSHero >> st [
	^ st
]

{ #category : #accessing }
MSHero >> st: anInteger [ 
	st := anInteger
]

{ #category : #'as yet unclassified' }
MSHero >> standUp [
	isStandingUp := true.
]

{ #category : #combat }
MSHero >> sufferingDexPenalty [
	^ (damageTakenThisRound >= 5) | isRecovering 
]

{ #category : #private }
MSHero >> takeDamage: damage [
	damageTaken := damageTaken + damage.
	damageTakenThisRound := damageTakenThisRound + damage.

	hasDxPenaltyFromInjuries := self sufferingDexPenalty.

	damageTakenThisRound >= 8 ifTrue: [ isKnockedDown := true ]

]

{ #category : #combat }
MSHero >> takeHits: anInteger [
	| armorPoints damageDone |
	armorPoints := armor hitsStopped + shield hitsStopped.
	damageDone := anInteger - armorPoints.
	damageDone < 0 ifTrue: [ damageDone := 0 ].
	
	self takeDamage: damageDone
]
