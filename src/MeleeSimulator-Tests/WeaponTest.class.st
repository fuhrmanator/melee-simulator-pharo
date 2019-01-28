Class {
	#name : #WeaponTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
WeaponTest >> testDoDamage [
	| weapon results |
	weapon := MSWeapon dagger.
	results := Set new.
	100 timesRepeat: [ results add: weapon doDamage ].
	self assert: ((0 to: 5) asSet difference: results) isEmpty.
]
