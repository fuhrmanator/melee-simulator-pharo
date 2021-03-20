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

{ #category : #'as yet unclassified' }
MSTournament class >> runSimulationAllHeroes [
	<script>
	| t results |
	t := self with: MSHero allHeroes for: 40.
	t run.
	results := Bag new.
	t bouts
		do: [ :b | 
			b winner notNil
				ifTrue: [ results add: b winner name ] ].
	results inspect
]

{ #category : #'as yet unclassified' }
MSTournament class >> with: heroCollection for: number [
	^ self new heroes: heroCollection nBouts: number
]

{ #category : #'as yet unclassified' }
MSTournament >> bouts [
	^ bouts
]

{ #category : #'as yet unclassified' }
MSTournament >> heroes: aCollection nBouts: number [ 
	heroes := aCollection.
	nBouts := number
]

{ #category : #'as yet unclassified' }
MSTournament >> initialize [ 
	super initialize.
	bouts := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
MSTournament >> run [
	| combinations counter |
	combinations := heroes size take: 2.
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
				title: 'Pairing up ' , h1 name , ' and ' , h2 name.
			self crTrace: '>>>> Pairing up ' , h1 name , ' and ' , h2 name.
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
