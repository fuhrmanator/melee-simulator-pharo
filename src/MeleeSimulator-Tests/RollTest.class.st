Class {
	#name : #RollTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
RollTest >> testNumberOfDice [
	self assert: ((MSRoll numberOfDice: 1) numberOfDice) equals: 1.
]

{ #category : #tests }
RollTest >> testTotal [
	| n results |
	n := 100.
	results := Set new.
	
	1 to: n do: [ :i | 
		results add: ((MSRoll numberOfDice: 1) total).
	 ].
	self assert: ((1 to: 6) asSet) equals: results.

	results := Set new.
	1 to: n * 2 do: [ :i | 
		results add: ((MSRoll numberOfDice: 2) total).
	 ].
	self assert: ((2 to: 12) asSet) equals: results.

	results := Set new.
	1 to: n * 3 do: [ :i | 
		results add: ((MSRoll numberOfDice: 3) total).
	 ].
	self assert: ((3 to: 18) asSet) equals: results.

]
