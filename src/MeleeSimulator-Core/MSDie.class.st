Class {
	#name : #MSDie,
	#superclass : #Object,
	#category : #'MeleeSimulator-Core'
}

{ #category : #utility }
MSDie class >> roll [
	^ 6 atRandom.
]

{ #category : #utilities }
MSDie class >> rollDice: anInteger [
	| total |
	total := 0.
	1 to: anInteger do: [ :i | total := total + 6 atRandom ].
	^ total
]
