Class {
	#name : #MSRoll,
	#superclass : #Object,
	#instVars : [
		'diceRolls'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #'as yet unclassified' }
MSRoll class >> numberOfDice: n [
	^ self new
		diceRolls: ((1 to: n) collect: [ :i | MSDie roll ])

]

{ #category : #accessing }
MSRoll >> diceRolls: collRolls [
	diceRolls := collRolls
]

{ #category : #access }
MSRoll >> numberOfDice [
	^ diceRolls size
]

{ #category : #access }
MSRoll >> total [
	^diceRolls inject: 0 into: [ :sum :each | sum + each ].
]
