"
A MSTournamentTest is a test class for testing the behavior of MSTournament
"
Class {
	#name : #MSTournamentTest,
	#superclass : #TestCase,
	#category : #'MeleeSimulator-Tests'
}

{ #category : #tests }
MSTournamentTest >> testRun [
	| tourney |
	tourney := MSTournament
		with:
			{
			(MSHero myrmidon name: 'H1').
			(MSHero myrmidon name: 'H2').
			(MSHero myrmidon name: 'H3').
			(MSHero myrmidon name: 'H4').
			(MSHero myrmidon name: 'H5')
			}
		for: 1.
	tourney run.
	tourney bouts size = 1
]
