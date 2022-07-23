Class {
	#name : #MSRoll,
	#superclass : #Object,
	#instVars : [
		'diceRolls',
		'modifier'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #initialization }
MSRoll class >> numberOfDice: n [
	^ self new
		diceRolls: (self rolled: n)
]

{ #category : #initialization }
MSRoll class >> numberOfDice: n modifier: mod [
	^ self new
		diceRolls: (self rolled: n);
		modifier: mod yourself
]

{ #category : #helper }
MSRoll class >> rolled: n [
	^ (1 to: n) collect: [ :i | MSDie roll ]
]

{ #category : #accessing }
MSRoll >> diceRolls: collRolls [
	diceRolls := collRolls
]

{ #category : #initialization }
MSRoll >> initialize [
	super initialize.
	modifier := 0.
]

{ #category : #accessing }
MSRoll >> modifier: mod [ 
	modifier := mod
]

{ #category : #accessing }
MSRoll >> numberOfDice [
	^ diceRolls size
]

{ #category : #accessing }
MSRoll >> total [
	^ modifier + (diceRolls inject: 0 into: [ :sum :each | sum + each ])
]
