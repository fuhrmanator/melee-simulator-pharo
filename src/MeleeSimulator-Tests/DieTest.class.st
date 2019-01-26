Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
DieTest >> testRoll [
	1 to: 100 do: [ :i | self assert: ((1 to: 6) includes: (MSDie roll))].
]

{ #category : #tests }
DieTest >> testRollDice [
	1 to: 100 do: [ :i | 
		self assert: ((1 to: 6) includes: (MSDie rollDice: 1)).
		self assert: ((2 to: 12) includes: (MSDie rollDice: 2)).
		self assert: ((3 to: 18) includes: (MSDie rollDice: 3)).
		self assert: ((4 to: 24) includes: (MSDie rollDice: 4))
		 ]
]
