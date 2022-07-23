Class {
	#name : #MSShield,
	#superclass : #Object,
	#instVars : [
		'name',
		'hitsStopped',
		'dxAdjustment'
	],
	#classInstVars : [
		'shieldRegistry'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #accessing }
MSShield class >> largeShield [
	^ self shieldRegistry at: #largeShield
]

{ #category : #accessing }
MSShield class >> none [
	^ self shieldRegistry at: #none
]

{ #category : #initialization }
MSShield class >> reset [
	shieldRegistry := nil.
]

{ #category : #initialization }
MSShield class >> shieldRegistry [
	shieldRegistry
		ifNil: [ shieldRegistry := Dictionary new.
			shieldRegistry
				at: #none put: (self new name: 'No shield';
				hitsStopped: 0;
				dxAdjustment: 0).
			shieldRegistry
				at: #smallShield put: (self new name: 'Small shield';
				hitsStopped: 1;
				dxAdjustment: 0).
			shieldRegistry
				at: #largeShield put: (self new name: 'Large shield';
				hitsStopped: 2;
				dxAdjustment: 1) ].
	^ shieldRegistry
]

{ #category : #accessing }
MSShield class >> smallShield [
	^ self shieldRegistry at: #smallShield
]

{ #category : #accessing }
MSShield >> dxAdjustment [
	^ dxAdjustment
]

{ #category : #accessing }
MSShield >> dxAdjustment: anObject [
	dxAdjustment := anObject
]

{ #category : #accessing }
MSShield >> hitsStopped [
	^ hitsStopped
]

{ #category : #accessing }
MSShield >> hitsStopped: anObject [
	hitsStopped := anObject
]

{ #category : #accessing }
MSShield >> name [
	^ name
]

{ #category : #accessing }
MSShield >> name: anObject [
	name := anObject
]
