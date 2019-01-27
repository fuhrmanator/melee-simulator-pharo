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
	^ weaponRegistry at: #none
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
