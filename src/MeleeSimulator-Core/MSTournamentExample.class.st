Class {
	#name : #MSTournamentExample,
	#superclass : #Object,
	#category : #'MeleeSimulator-Core'
}

{ #category : #'as yet unclassified' }
MSTournamentExample >> runSimulationAllHeroes [
	<script: 'self new runSimulationAllHeroes open'>
	| t results c p heroes x wins size horizontal |
	t := MSTournament with: MSHero allHeroes for: 1.
	t run.
	results := Bag new.
	t bouts
		do: [ :b | 
			b winner notNil
				ifTrue: [ results add: b winner name ] ].
	results inspect.

	"Roassal bar chart on results"
	heroes := OrderedCollection new.
	wins := OrderedCollection new.
	results sortedCounts
		do: [ :i | 
			heroes add: i value.
			wins add: i key ].
	x := 1 to: heroes size.
	c := RSChart new.
	p := RSBarPlot new x: x y: wins.
"	size := 1.
	p barSize: size.
	p barOffset: size / 2."
	c addPlot: p.
	c
		addDecoration:
			(horizontal := RSHorizontalTick new
				fromNames: heroes;
				yourself).
	horizontal configuration fontSize: 2.
	horizontal useDiagonalLabel.
	c
		addDecoration:
			(RSVerticalTick new
				numberOfTicks: 10;
				asFloat).
	c title: 'Wins for each Hero'.
	c build.
	p bars @ RSPopup.
	p bars interaction popupText: [ :i | 'Test' ]. 
	^ c canvas
]
