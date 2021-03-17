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
MSWeapon class >> battleaxe [
	^ self weaponRegistry at: #battleaxe
]

{ #category : #'as yet unclassified' }
MSWeapon class >> broadsword [
	^ self weaponRegistry at: #broadsword
]

{ #category : #'as yet unclassified' }
MSWeapon class >> club [
	^ self weaponRegistry at: #club
]

{ #category : #'as yet unclassified' }
MSWeapon class >> cutlass [
	^ self weaponRegistry at: #cutlass
]

{ #category : #'as yet unclassified' }
MSWeapon class >> dagger [
	^ self weaponRegistry at: #dagger
]

{ #category : #'as yet unclassified' }
MSWeapon class >> halberd [
	^ self weaponRegistry at: #halberd
]

{ #category : #'as yet unclassified' }
MSWeapon class >> hammer [
	^ self weaponRegistry at: #hammer
]

{ #category : #'as yet unclassified' }
MSWeapon class >> javelin [
	^ self weaponRegistry at: #javelin
]

{ #category : #'as yet unclassified' }
MSWeapon class >> mace [
	^ self weaponRegistry at: #mace
]

{ #category : #'as yet unclassified' }
MSWeapon class >> morningstar [
	^ self weaponRegistry at: #morningstar
]

{ #category : #'as yet unclassified' }
MSWeapon class >> none [
	^ self weaponRegistry at: #none
]

{ #category : #'as yet unclassified' }
MSWeapon class >> pikeAxe [
	^ self weaponRegistry at: #pikeAxe
]

{ #category : #'as yet unclassified' }
MSWeapon class >> rapier [
	^ self weaponRegistry at: #rapier
]

{ #category : #'as yet unclassified' }
MSWeapon class >> reset [
	weaponRegistry := nil
]

{ #category : #'as yet unclassified' }
MSWeapon class >> shortsword [
	^ self weaponRegistry at: #shortsword
]

{ #category : #'as yet unclassified' }
MSWeapon class >> smallAx [
	^ self weaponRegistry at: #smallAx
]

{ #category : #'as yet unclassified' }
MSWeapon class >> spear [
	^ self weaponRegistry at: #spear
]

{ #category : #'as yet unclassified' }
MSWeapon class >> twoHandedSword [
	^ self weaponRegistry at: #twoHandedSword
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
						name: 'None';
						st: 0;
						dice: 0;
						modifier: 0;
						isThrown: false;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #dagger
				put:
					(self new
						name: 'Dagger';
						st: 0;
						dice: 1;
						modifier: -1;
						isThrown: true;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #rapier
				put:
					(self new
						name: 'Rapier';
						st: 9;
						dice: 1;
						modifier: 0;
						isThrown: false;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #club
				put:
					(self new
						name: 'Club';
						st: 9;
						dice: 1;
						modifier: 0;
						isThrown: true;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #hammer
				put:
					(self new
						name: 'Hammer';
						st: 10;
						dice: 1;
						modifier: 1;
						isThrown: true;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #cutlass
				put:
					(self new
						name: 'Cutlass';
						st: 10;
						dice: 2;
						modifier: -2;
						isThrown: false;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #shortsword
				put:
					(self new
						name: 'Shortsword';
						st: 11;
						dice: 2;
						modifier: -1;
						isThrown: false;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #mace
				put:
					(self new
						name: 'Mace';
						st: 11;
						dice: 2;
						modifier: -1;
						isThrown: true;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #smallAx
				put:
					(self new
						name: 'Small ax';
						st: 11;
						dice: 1;
						modifier: 2;
						isThrown: false;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #broadsword
				put:
					(self new
						name: 'Broadsword';
						st: 12;
						dice: 2;
						modifier: 0;
						isThrown: false;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #morningstar
				put:
					(self new
						name: 'Morningstar';
						st: 13;
						dice: 2;
						modifier: 1;
						isThrown: false;
						isTwoHanded: false;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #twoHandedSword
				put:
					(self new
						name: 'Two-handed sword';
						st: 14;
						dice: 3;
						modifier: -1;
						isThrown: false;
						isTwoHanded: true;
						isPole: false;
						isMissile: false).
			weaponRegistry
				at: #battleaxe
				put:
					(self new
						name: 'Battleaxe';
						st: 15;
						dice: 3;
						modifier: 0;
						isThrown: false;
						isTwoHanded: true;
						isPole: false;
						isMissile: false).

			"pole weapons"
			weaponRegistry
				at: #javelin
				put:
					(self new
						name: 'Javelin';
						st: 9;
						dice: 1;
						modifier: -1;
						isThrown: true;
						isTwoHanded: false;
						isPole: true;
						isMissile: false).
			weaponRegistry
				at: #spear
				put:
					(self new
						name: 'Spear';
						st: 11;
						dice: 1;
						modifier: 1;
						isThrown: true;
						isTwoHanded: true;
						isPole: true;
						isMissile: false).
			weaponRegistry
				at: #halberd
				put:
					(self new
						name: 'Halberd';
						st: 13;
						dice: 2;
						modifier: -1;
						isThrown: false;
						isTwoHanded: true;
						isPole: true;
						isMissile: false).
			weaponRegistry
				at: #pikeAxe
				put:
					(self new
						name: 'Pike axe';
						st: 15;
						dice: 2;
						modifier: 2;
						isThrown: false;
						isTwoHanded: true;
						isPole: true;
						isMissile: false) ].
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

{ #category : #'as yet unclassified' }
MSWeapon >> doDamage [
	| damage |
	self
		crTrace:
			'Rolling for weapon doing ' , dice asString , 'd'
				,
					(modifier > 0
						ifTrue: [ '+' ]
						ifFalse: [ '' ])
				,
					(modifier = 0
						ifTrue: [ '' ]
						ifFalse: [ modifier asString ]) , ' damage.'.
	damage := 0.
	dice timesRepeat: [ damage := damage + MSDie roll ].
	damage := damage + modifier.
	modifier ~= 0
		ifTrue: [ self
				crTrace:
					(modifier > 0
						ifTrue: [ '+' ]
						ifFalse: [ '' ]) , modifier asString ].
	"Strange smalltalk semantics"
	damage := damage max: 0.
	self crTrace: 'Total weapon damage: ' , damage asString.
	^ damage
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
