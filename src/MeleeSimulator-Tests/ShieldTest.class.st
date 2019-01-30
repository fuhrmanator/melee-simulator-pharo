Class {
	#name : #ShieldTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
ShieldTest >> testShieldTypes [
	"test all types of armor"

	self assert: MSShield none name equals: 'No shield'.
	self assert: MSShield none hitsStopped equals: 0.
	self assert: MSShield none dxAdjustment equals: 0.
	self assert: MSShield smallShield name equals: 'Small shield'.
	self assert: MSShield smallShield hitsStopped equals: 1.
	self assert: MSShield smallShield dxAdjustment equals: 0.
	self assert: MSShield largeShield name equals: 'Large shield'.
	self assert: MSShield largeShield hitsStopped equals: 2.
	self assert: MSShield largeShield dxAdjustment equals: 1.

]
