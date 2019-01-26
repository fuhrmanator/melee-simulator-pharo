Class {
	#name : #HeroTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
HeroTest >> testArmor [
	| hero |
	hero := MSHero new armor: MSArmor leather.
	self assert: hero armor equals: MSArmor leather.
]

{ #category : #tests }
HeroTest >> testDx [
	| hero |
	hero := MSHero new dx: 12.
	self assert: hero dx equals: 12.
]

{ #category : #tests }
HeroTest >> testName [
	| hero |
	hero := MSHero new name: 'Trevor'.
	self assert: hero name equals: 'Trevor'.
]

{ #category : #tests }
HeroTest >> testNew [
	| hero |
	hero := MSHero new.
	self assert: (hero st isNil).
]

{ #category : #tests }
HeroTest >> testSt [
	| hero |
	hero := MSHero new st: 12.
	self assert: hero st equals: 12.
]
