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
	tourney := MSTournament with: { (MSHero myrmidon) name: 'H1' . (MSHero myrmidon) name: 'H2' } for: 1.
	tourney run.
	tourney bouts size = 1
]
