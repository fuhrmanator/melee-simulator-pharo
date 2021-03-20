Class {
	#name : #MSDie,
	#superclass : #Object,
	#category : #'MeleeSimulator-Core'
}

{ #category : #utility }
MSDie class >> roll [
	| roll |
	roll := 6 atRandom.
	Transcript
		crShow: 'Die roll: ';
		show: roll asString.
	^ roll
]

{ #category : #utility }
MSDie class >> rollDice: anInteger [
	| total |
	total := 0.
	1 to: anInteger do: [ :i | total := total + self roll ].
	^ total
]

{ #category : #utility }
MSDie class >> rollFourDice [
	^ self rollDice: 4
]

{ #category : #utility }
MSDie class >> rollThreeDice [
	^ self rollDice: 3
]
