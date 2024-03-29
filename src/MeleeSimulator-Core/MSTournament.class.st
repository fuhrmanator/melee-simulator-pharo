Class {
	#name : #MSTournament,
	#superclass : #Object,
	#instVars : [
		'bouts',
		'heroes',
		'nBouts'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #'accessing - convenience' }
MSTournament class >> with: heroCollection for: number [
	^ self new heroes: heroCollection nBouts: number
]

{ #category : #accessing }
MSTournament >> bouts [
	^ bouts
]

{ #category : #accessing }
MSTournament >> heroes: aCollection nBouts: number [ 
	heroes := aCollection.
	nBouts := number
]

{ #category : #initialization }
MSTournament >> initialize [ 
	super initialize.
	bouts := OrderedCollection new.
]

{ #category : #rules }
MSTournament >> run [
	| combinations counter |
	combinations := heroes size numberOfCombinationsTaken: 2.
	counter := 0.
	[ :job | 
	heroes
		combinations: 2
		atATimeDo: [ :pair | 
			| h1 h2 |
			h1 := pair first.
			h2 := pair second.
			counter := counter + 1.
			job
				progress: counter / combinations ;
				title: 'Pairing up ' , h1 asString , ' and ' , h2 asString.
			self crTrace: '>>>> Pairing up ' , h1 asString , ' and ' , h2 asString.
			1 to: nBouts do: [ :i | 
				| bout |
				self crTrace: '>>>> Bout: ' , i asString.
				bout := MSBout
					hero1: h1 copy
					hero2: h2 copy
					poleCharge: false
					defendPoleCharge: false.
				bout fightToTheDeath.
				bouts add: bout ] ] ] asJob run
]
