Class {
	#name : #RollTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
RollTest >> testNumberOfDice [
	self assert: ((MSRoll numberOfDice: 1) numberOfDice) equals: 1.
	self assert: ((MSRoll numberOfDice: 2 modifier: 2) numberOfDice) equals: 2.
]

{ #category : #tests }
RollTest >> testTotal [
	| n results |
	n := 100.
	results := Set new.
	1 to: n do: [ :i | results add: (MSRoll numberOfDice: 1) total ].
	self assert: (1 to: 6) asSet equals: results.
	results := Set new.
	1 to: n * 2 do: [ :i | results add: (MSRoll numberOfDice: 2) total ].
	self assert: (2 to: 12) asSet equals: results.
	results := Set new.
	1 to: n * 8 do: [ :i | results add: (MSRoll numberOfDice: 3) total ].
	self assert: (3 to: 18) asSet equals: results.

	"Test with modifier"
	results := Set new.
	1 to: n do:
		[ :i | results add: (MSRoll numberOfDice: 1 modifier: -1) total ].
	self assert: (0 to: 5) asSet equals: results
]
