Class {
	#name : #ArmorTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
ArmorTest >> testArmorTypes [
	"test all types of armor"

	self assert: MSArmor none name equals: 'No armor'.
	self assert: MSArmor none hitsStopped equals: 0.
	self assert: MSArmor none maAdjustment equals: 0.
	self assert: MSArmor none dxAdjustment equals: 0.
	self assert: MSArmor leather name equals: 'Leather'.
	self assert: MSArmor leather hitsStopped equals: 2.
	self assert: MSArmor leather maAdjustment equals: 2.
	self assert: MSArmor leather dxAdjustment equals: 2.
	self assert: MSArmor chain name equals: 'Chain'.
	self assert: MSArmor chain hitsStopped equals: 3.
	self assert: MSArmor chain maAdjustment equals: 4.
	self assert: MSArmor chain dxAdjustment equals: 4.
	self assert: MSArmor plate name equals: 'Plate'.
	self assert: MSArmor plate hitsStopped equals: 5.
	self assert: MSArmor plate maAdjustment equals: 6.
	self assert: MSArmor plate dxAdjustment equals: 6
]
