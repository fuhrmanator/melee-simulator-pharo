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

{ #category : #accessing }
MSHero >> armor [
	^ armor
]

{ #category : #accessing }
MSHero >> armor: aMSArmor [ 
	armor := aMSArmor
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
MSHero >> name [
	^ name
]

{ #category : #accessing }
MSHero >> name: aString [ 
	name := aString
]

{ #category : #accessing }
MSHero >> st [
	^ st
]

{ #category : #accessing }
MSHero >> st: anInteger [ 
	st := anInteger
]
