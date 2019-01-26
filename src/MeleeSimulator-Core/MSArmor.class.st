Class {
	#name : #MSArmor,
	#superclass : #Object,
	#instVars : [
		'name',
		'hitsStopped',
		'maAdjustment',
		'dxAdjustment'
	],
	#classInstVars : [
		'armorRegistry'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #'as yet unclassified' }
MSArmor class >> armorRegistry [
	armorRegistry
		ifNil: [ armorRegistry := Dictionary new.
			0halt.
			armorRegistry
				at: #none put: (self new name: 'No armor';
				hitStopped: 0;
				maAdjustment: 0;
				dxAdjustment: 0).
			armorRegistry
				at: #leather put: (self new name: 'Leather';
				hitStopped: 2;
				maAdjustment: 2;
				dxAdjustment: 2).
			armorRegistry
				at: #chain put: (self new name: 'Chain';
				hitStopped: 3;
				maAdjustment: 4;
				dxAdjustment: 4).
			armorRegistry
				at: #plate put: (self new name: 'Plate';
				hitStopped: 5;
				maAdjustment: 6;
				dxAdjustment: 6) ].
	^ armorRegistry
]

{ #category : #predefined }
MSArmor class >> leather [
	^ self armorRegistry at: #leather.
]

{ #category : #initialization }
MSArmor class >> reset [
	armorRegistry := nil.
]

{ #category : #accessing }
MSArmor >> dxAdjustment: anInteger [ 
	dxAdjustment := anInteger
]

{ #category : #accessing }
MSArmor >> hitStopped: anInteger [ 
	hitsStopped := anInteger.
]

{ #category : #accessing }
MSArmor >> maAdjustment: anInteger [ 
	maAdjustment := anInteger
]

{ #category : #accessing }
MSArmor >> name: aString [ 
	name := aString
]
