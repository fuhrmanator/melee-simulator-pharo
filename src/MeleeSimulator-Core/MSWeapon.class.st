Class {
	#name : #MSWeapon,
	#superclass : #Object,
	#instVars : [
		'name',
		'st',
		'dice',
		'modifier',
		'isTwoHanded',
		'isThrown',
		'isMissile',
		'isPole'
	],
	#classInstVars : [
		'weaponRegistry'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #'as yet unclassified' }
MSWeapon class >> none [
	^ self weaponRegistry at: #none
]

{ #category : #'as yet unclassified' }
MSWeapon class >> reset [
	weaponRegistry := nil
]

{ #category : #accessing }
MSWeapon class >> weaponRegistry [
	"name st dice modifier isTwoHanded isThrown isMissile isPole"
	weaponRegistry
		ifNil: [ weaponRegistry := Dictionary new.
			weaponRegistry
				at: #none
				put:
					(self new
						name: 'No weapon';
						st: 0;
						dice: 0;
						modifier: 0;
						isTwoHanded: false;
						isThrown: false;
						isMissile: false;
						isPole: false) ].
	^ weaponRegistry
]

{ #category : #accessing }
MSWeapon >> dice [
	^ dice
]

{ #category : #accessing }
MSWeapon >> dice: anObject [
	dice := anObject
]

{ #category : #accessing }
MSWeapon >> isMissile [
	^ isMissile
]

{ #category : #accessing }
MSWeapon >> isMissile: anObject [
	isMissile := anObject
]

{ #category : #accessing }
MSWeapon >> isPole [
	^ isPole
]

{ #category : #accessing }
MSWeapon >> isPole: anObject [
	isPole := anObject
]

{ #category : #accessing }
MSWeapon >> isThrown [
	^ isThrown
]

{ #category : #accessing }
MSWeapon >> isThrown: anObject [
	isThrown := anObject
]

{ #category : #accessing }
MSWeapon >> isTwoHanded [
	^ isTwoHanded
]

{ #category : #accessing }
MSWeapon >> isTwoHanded: anObject [
	isTwoHanded := anObject
]

{ #category : #accessing }
MSWeapon >> modifier [
	^ modifier
]

{ #category : #accessing }
MSWeapon >> modifier: anObject [
	modifier := anObject
]

{ #category : #accessing }
MSWeapon >> name [
	^ name
]

{ #category : #accessing }
MSWeapon >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MSWeapon >> st [
	^ st
]

{ #category : #accessing }
MSWeapon >> st: anObject [
	st := anObject
]
