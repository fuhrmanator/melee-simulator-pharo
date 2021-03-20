Class {
	#name : #MSTournamentExample,
	#superclass : #Object,
	#category : #'MeleeSimulator-Core'
}

{ #category : #'as yet unclassified' }
MSTournamentExample >> runSimulationAllHeroes [
	<script: 'self new runSimulationAllHeroes open'>
	| t results c p heroes x wins horizontal |
	t := MSTournament with: MSHero allHeroes for: 100.
	t run.
	results := Bag new.
	t bouts
		do: [ :b | 
			b winner notNil
				ifTrue: [ results add: b winner asString ] ].
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
	p bars
		doWithIndex: [ :bar :index | 
			bar
				@ (RSPopup text: [ :i | (heroes at: index) , String cr , i asString ]) ].
	c canvas @ RSCanvasController.
	^ c canvas
]
