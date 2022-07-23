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
	200 timesRepeat: [ results add: weapon doDamage ].
	self assert: ((0 to: 5) asSet) equals: results.
	
	weapon := MSWeapon broadsword.
	results := Set new.
	200 timesRepeat: [ results add: weapon doDamage ].
	self assert: ((2 to: 12) asSet) equals: results.

]
