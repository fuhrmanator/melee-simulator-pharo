Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
DieTest >> testRoll [
	| results |
	1 to: 100 do: [ :i | self assert: ((1 to: 6) includes: (MSDie roll))].
	"More precise test?"
	results := Set new.
	1 to: 100 do: [ :i | results add: MSDie roll ].
	self assert: ((1 to: 6) asSet difference: results) isEmpty.

]

{ #category : #tests }
DieTest >> testRollDice [
	| results |
	results := Set new.
	1 to: 100 do: [ :i | 
		results add: (MSDie rollDice: 1).
	 ].
	self assert: ((1 to: 6) asSet difference: results) isEmpty.
	results := Set new.
	1 to: 100 do: [ :i | 
		results add: (MSDie rollDice: 2).
	 ].
	self assert: ((2 to: 12) asSet difference: results) isEmpty.

]

{ #category : #tests }
DieTest >> testRollFourDice [
	| results |
	results := Set new.
	1 to: 1500 do: [ :i | 
		results add: MSDie rollFourDice ].
	self assert: ((4 to: 24) asSet difference: results) isEmpty.

]

{ #category : #tests }
DieTest >> testRollThreeDice [
	| results |
	results := Set new.
	1 to: 300 do: [ :i | 
		results add: MSDie rollThreeDice ].
	self assert: ((3 to: 18) asSet difference: results) isEmpty.

]
