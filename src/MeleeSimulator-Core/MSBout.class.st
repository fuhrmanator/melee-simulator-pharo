Class {
	#name : #MSBout,
	#superclass : #Object,
	#instVars : [
		'hero1',
		'hero2',
		'round',
		'winHero1',
		'winHero2',
		'criticalMisses',
		'criticalHits',
		'isPoleCharge',
		'isDefendOnPoleCharge',
		'heroMap'
	],
	#category : #'MeleeSimulator-Core'
}

{ #category : #'class initialization' }
MSBout class >> hero1: aMSHero hero2: aMSHero2 poleCharge: boolean1 defendPoleCharge: boolean2 [
	^ self new
		hero1: aMSHero;
		hero2: aMSHero2;
		poleCharge: boolean1;
		defendPoleCharge: boolean2
]

{ #category : #accessing }
MSBout >> defendPoleCharge: boolean [ 
	isDefendOnPoleCharge := boolean.
]

{ #category : #'as yet unclassified' }
MSBout >> fightToTheDeath [
	| winner firstAttacker secondAttacker |
	winner := nil.
	[ self isBoutUnfinished ]
		whileTrue: [ round := round + 1.
			hero1 newRound.
			hero2 newRound.
			self crTrace: '--->Round ' , round asString.
			self
				crTrace:
					'Hero 1: ' , hero1 name , ', ST: ' , hero1 st asString , '('
						, hero1 adjSt asString , ')'.
			self
				crTrace:
					'Hero 2: ' , hero2 name , ', ST: ' , hero2 st asString , '('
						, hero2 adjSt asString , ')'.
			firstAttacker := hero1.
			secondAttacker := hero2.
			hero1 adjDx < hero2 adjDx
				ifTrue: [ firstAttacker := hero2.
					secondAttacker := hero1 ]
				ifFalse: [ hero1 adjDx = hero2 adjDx
						ifTrue: [ self
								crTrace: 'Adjusted dexterities are equal; rolling to decide attack order'.
							2 atRandom < 2
								ifTrue: [ firstAttacker := hero2.
									secondAttacker := hero1 ] ] ].
			self
				crTrace:
					firstAttacker name , ' (adjDx = ' , firstAttacker adjDx asString
						, ') attacks before ' , secondAttacker name , ' (adjDx = '
						, secondAttacker adjDx asString , ')'.
			hero1
				isCharging: isPoleCharge & (round = 1) & hero1 readiedWeapon isPole.
			hero2
				isCharging: isPoleCharge & (round = 1) & hero2 readiedWeapon isPole.
			self
				tryDefendingAttacker: hero1
				defender: hero2
				defendOnPoleCharge: isDefendOnPoleCharge.
			self
				tryDefendingAttacker: hero2
				defender: hero1
				defendOnPoleCharge: isDefendOnPoleCharge.
			self tryStandUp: firstAttacker.
			self tryStandUp: secondAttacker.
			self tryPickUp: firstAttacker.
			self tryPickUp: secondAttacker.
			self tryAttackFor: firstAttacker on: secondAttacker.
			self tryAttackFor: secondAttacker on: firstAttacker ].
	winner := nil.
	hero1 canDoDamage
		ifTrue: [ winner := hero1 ]
		ifFalse: [ hero2 canDoDamage
				ifTrue: [ winner := hero2 ] ].
	winner isNotNil
		ifTrue: [ self crTrace: '-------> The winner of this bout is ' , winner name ]
		ifFalse: [ self crLog: '-------> This bout was a TIE!' ].
	^ winner
]

{ #category : #accessing }
MSBout >> hero1: aMSHero [ 
	hero1 := aMSHero
]

{ #category : #accessing }
MSBout >> hero2: aMSHero [ 
	hero2 := aMSHero
]

{ #category : #initialization }
MSBout >> initialize [
	super initialize.
	hero1 := nil.
	hero2 := nil.
	round := 0.
	winHero1 := 0.
	winHero2 := 0.
	criticalMisses :=0. criticalHits:=0.  isPoleCharge:=false.  isDefendOnPoleCharge:=false.  heroMap := Dictionary new.
]

{ #category : #'as yet unclassified' }
MSBout >> isAutomaticHitForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal <= 5 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	nDice = 4 ifTrue: [ ^ false ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isAutomaticMissForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal >= 16 ].
	nDice = 4 ifTrue: [ ^ rollTotal >= 20 ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isBoutFinished [
	^ (hero1 isConscious & hero2 isConscious & hero1 canDoDamage & hero2 canDoDamage) not
]

{ #category : #'as yet unclassified' }
MSBout >> isBoutUnfinished [
	^ hero1 isConscious & hero2 isConscious & hero1 canDoDamage
		& hero2 canDoDamage
]

{ #category : #'as yet unclassified' }
MSBout >> isBrokenWeaponForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 18 ].
	nDice = 4 ifTrue: [ ^ (rollTotal = 23) | (rollTotal = 24) ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isDoubleDamageForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 4 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	nDice = 4 ifTrue: [ ^ false ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isDroppedWeaponForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 17 ].
	nDice = 4 ifTrue: [ ^ (rollTotal = 21) | (rollTotal = 22) ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isTripleDamageForRoll: rollTotal forDice: nDice [ 
	nDice = 3 ifTrue: [ ^ rollTotal = 3 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	nDice = 4 ifTrue: [ ^ false ].
	self error: 'Unsupported number of dice: ', nDice asString
]

{ #category : #accessing }
MSBout >> poleCharge: boolean [ 
	isPoleCharge := boolean.
]

{ #category : #bloodyhell }
MSBout >> resolveAttackFor: attacker attacking: attackee withRoll: roll using: numDice [
	| facingBonus hits |
	facingBonus := attacker isProne
		ifTrue: [ 4 ]
		ifFalse: [ 0 ].
	self
		crTrace:
			attacker name , ' rolled ' , roll asString , ' with adjDex '
				,
					(attackee isProne
						ifTrue: [ (attacker adjDx + facingBonus) asString , ' ('
								, attacker adjDx asString , ' + ' , facingBonus asString
								, ', target is prone, i.e., knocked down or picking up a weapon).' ]
						ifFalse: [ attacker adjDx asString ]).

	"A hit is a roll that is NOT an automatic miss AND (below or equal to the attacker's adjDex OR and automatic hit)"
	(self isAutomaticMissForRoll: roll forDice: numDice) not
		&
			(roll <= (attacker adjDx + facingBonus)
				| (self isAutomaticHitForRoll: roll forDice: numDice))
		ifTrue: [ self crTrace: 'Hit! '.
			hits := attacker readiedWeapon doDamage.
			attacker isCharging & attacker readiedWeapon isPole
				ifTrue: [ self crLog: 'Pole weapon charge does double damage!'.
					criticalHits := criticalHits + 1.
					hits := hits * 2 ].
			(self isDoubleDamageForRoll: roll forDice: numDice)
				ifTrue: [ self
						crLog:
							'Double damage! (roll of ' , roll asString , ' on ' , numDice asString
								, ' dice.)'.
					criticalHits := criticalHits + 1.
					hits := hits * 2 ]
				ifFalse: [ (self isTripleDamageForRoll: roll forDice: numDice)
						ifTrue: [ self
								crLog:
									'Triple damage! (roll of ' , roll asString , ' on ' , numDice asString
										, ' dice.)'.
							criticalHits := criticalHits + 1.
							hits := hits * 3 ] ].
			self
				crTrace:
					'Total damage done by ' , attacker name , ': ' , hits asString
						, ' hits.'.
			attackee takeHits: hits ]
		ifFalse: [ "It's a miss"
			self crTrace: 'Missed. '.
			(self isDroppedWeaponForRoll: roll forDice: numDice)
				ifTrue: [ self crLog: 'Dropped weapon! '.
					criticalMisses := criticalMisses + 1.
					attacker dropWeapon ]
				ifFalse: [ (self isBrokenWeaponForRoll: roll forDice: numDice)
						ifTrue: [ self crLog: 'Broke weapon! '.
							criticalMisses := criticalMisses + 1.
							attacker breakWeapon ] ] ]
]

{ #category : #'as yet unclassified' }
MSBout >> showStatusOfAttacker: attacker attacking: attackee [
	self crTrace: attacker name , ' gets his turn to attack.'.
	attacker hasDxPenaltyFromInjuries
		ifTrue: [ self
				crTrace:
					'Attacker has -2 DX penalty due to having taken '
						, attacker damageTakenThisRound asString , ' hits this round.' ].
	attacker isCharging
		ifTrue: [ self crLog: 'Attacker is charging this round.' ].
	attacker isDefending
		ifTrue: [ self crLog: 'Attacker is defending this round.' ].
	attacker isPickingUpWeapon
		ifTrue: [ self crLog: 'Attacker is picking up his weapon this round.' ].
	attacker isStandingUp
		ifTrue: [ self crTrace: 'Attacker is standing up this round.' ].
	attacker isKnockedDown
		ifTrue: [ self crTrace: 'Attacker is knocked down this round.' ].
	attackee isProne
		ifTrue: [ self
				crLog:
					'Defender is prone (knocked down?) giving the attacker +4 DX adjustment.' ].
	attackee isDefending
		ifTrue:
			[ self crLog: 'Defender is defending making the attacker roll 4 dice.' ]
]

{ #category : #'as yet unclassified' }
MSBout >> tryAttackFor: attacker on: attackee [
	| numDice roll |
	self showStatusOfAttacker: attacker attacking: attackee.
	attacker isDefending
		ifFalse: [ attacker isConscious
				ifTrue: [ attacker isKnockedDown
						ifFalse: [ attacker readiedWeapon ~= MSWeapon none
								ifTrue: [ attacker isCharging
										ifTrue: [ self
												crLog: 'He''s charging with a pole weapon (double damage if he hits).' ].
									numDice := attackee isDefending
										ifTrue: [ 4 ]
										ifFalse: [ 3 ].
									self
										crTrace: 'Rolling to hit on ' , numDice asString , ' dice.'.
									roll := MSDie rollDice: numDice.
									self
										resolveAttackFor: attacker
										attacking: attackee
										withRoll: roll
										using: numDice ]
								ifFalse: [ self
										crLog: 'But he''s not able to attack because he has no readied weapon.' ] ]
						ifTrue: [ self
								crTrace: 'But he''s not able to attack because he was knocked down.' ] ]
				ifFalse: [ self
						crTrace:
							'But he''s not able to attack because he''s '
								,
									(attacker isAlive
										ifTrue: [ 'unconscious.' ]
										ifFalse: [ 'dead.' ]) ] ]
		ifTrue: [ self crLog: 'But he''s defending.' ]
]

{ #category : #'as yet unclassified' }
MSBout >> tryDefendingAttacker: attacker defender: defender defendOnPoleCharge: defendOnPoleCharge [
	defender isKnockedDown not
		& (defender readiedWeapon ~= MSWeapon none)
		& defender hasDxPenaltyFromInjuries & (defender adjDx < 8)
		ifTrue: [ defender isDefending: true.
			self
				crLog:
					defender name
						, ' is defending this turn because adjDX < 8 and temporarily penalized.' ]
		ifFalse: [ 
			(defendOnPoleCharge & defender isKnockedDown not
				& (defender readiedWeapon ~= MSWeapon none)
				& (attacker readiedWeapon ~= MSWeapon none)
				& attacker readiedWeapon isPole & attacker isCharging
				& defender isCharging not) "don't defend if also charging with pole weapon"
				ifTrue: [ defender isDefending: true.
					self
						crLog:
							defender name
								,
									' is defending this turn because attacker is charging with pole weapon.' ] ]
]

{ #category : #'as yet unclassified' }
MSBout >> tryPickUp: hero [
	hero droppedWeapon ~= MSWeapon none
		ifTrue: [ hero pickUpWeapon.
			self
				crLog:
					hero name
						,
							' is picking up his weapon this turn (facing rear in all six directions).' ]
]

{ #category : #'as yet unclassified' }
MSBout >> tryStandUp: hero [
	hero isKnockedDown
		ifTrue: [ hero standUp.
			self crTrace: hero name , ' is standing up this turn.' ]
]
