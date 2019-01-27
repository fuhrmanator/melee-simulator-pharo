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
			armorRegistry
				at: #none put: (self new name: 'No armor';
				hitsStopped: 0;
				maAdjustment: 0;
				dxAdjustment: 0).
			armorRegistry
				at: #leather put: (self new name: 'Leather';
				hitsStopped: 2;
				maAdjustment: 2;
				dxAdjustment: 2).
			armorRegistry
				at: #chain put: (self new name: 'Chain';
				hitsStopped: 3;
				maAdjustment: 4;
				dxAdjustment: 4).
			armorRegistry
				at: #plate put: (self new name: 'Plate';
				hitsStopped: 5;
				maAdjustment: 6;
				dxAdjustment: 6) ].
	^ armorRegistry
]

{ #category : #'as yet unclassified' }
MSArmor class >> chain [
	^ armorRegistry at: #chain
]

{ #category : #predefined }
MSArmor class >> leather [
	^ self armorRegistry at: #leather.
]

{ #category : #'as yet unclassified' }
MSArmor class >> none [
	^ armorRegistry at: #none.
]

{ #category : #'as yet unclassified' }
MSArmor class >> plate [
	^ armorRegistry at: #plate
]

{ #category : #initialization }
MSArmor class >> reset [
	armorRegistry := nil.
]

{ #category : #accessing }
MSArmor >> dxAdjustment [
	^ dxAdjustment
]

{ #category : #accessing }
MSArmor >> dxAdjustment: anInteger [ 
	dxAdjustment := anInteger
]

{ #category : #accessing }
MSArmor >> hitsStopped [
	^ hitsStopped
]

{ #category : #accessing }
MSArmor >> hitsStopped: anInteger [ 
	hitsStopped := anInteger.
]

{ #category : #accessing }
MSArmor >> maAdjustment [
	^ maAdjustment
]

{ #category : #accessing }
MSArmor >> maAdjustment: anInteger [ 
	maAdjustment := anInteger
]

{ #category : #accessing }
MSArmor >> name [
	^ name
]

{ #category : #accessing }
MSArmor >> name: aString [ 
	name := aString
]
