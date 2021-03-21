Class {
	#name : #MSBout,
	#superclass : #Object,
	#instVars : [
		'hero1',
		'hero2',
		'round',
		'winner',
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

{ #category : #'as yet unclassified' }
MSBout >> attackeeFacingBonus: attackee [
	^ attackee isProne
		ifTrue: [ 4 ]
		ifFalse: [ 0 ]
]

{ #category : #accessing }
MSBout >> defendPoleCharge: boolean [
	"should heroes defend when a pole charge happens?"

	isDefendOnPoleCharge := boolean
]

{ #category : #'as yet unclassified' }
MSBout >> fightToTheDeath [
	| firstAttacker secondAttacker |
	hero1 readiedWeapon ~= MSWeapon none
		& (hero2 readiedWeapon ~= MSWeapon none)
		ifFalse: [ self
				error: 'both heroes must have ready weapons at the start of a bout.' ].
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
		ifFalse: [ self crTrace: '-------> This bout was a TIE!' ].
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
	round := 0.
	criticalMisses := 0.
	criticalHits := 0.
	isPoleCharge := false.
	isDefendOnPoleCharge := false.
	heroMap := Dictionary new
]

{ #category : #'as yet unclassified' }
MSBout >> isAutomaticHitForRoll: roll [
	roll numberOfDice = 3
		ifTrue: [ ^ roll total <= 5 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	roll numberOfDice = 4
		ifTrue: [ ^ false ].
	self
		error: 'Unsupported number of dice: ' , roll numberOfDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isAutomaticMissForRoll: roll [
	roll numberOfDice = 3
		ifTrue: [ ^ roll total >= 16 ].
	roll numberOfDice = 4
		ifTrue: [ ^ roll total >= 20 ].
	self
		error: 'Unsupported number of dice: ' , roll numberOfDice asString
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
MSBout >> isBrokenWeaponForRoll: roll [
	roll numberOfDice = 3
		ifTrue: [ ^ roll total = 18 ].
	roll numberOfDice = 4
		ifTrue: [ ^ roll total = 23 | (roll total = 24) ].
	self
		error: 'Unsupported number of dice: ' , roll numberOfDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isDoubleDamageForRoll: roll [
	roll numberOfDice = 3
		ifTrue: [ ^ roll total = 4 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	roll numberOfDice = 4
		ifTrue: [ ^ false ].
	self
		error: 'Unsupported number of dice: ' , roll numberOfDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isDroppedWeaponForRoll: roll [
	roll numberOfDice = 3
		ifTrue: [ ^ roll total = 17 ].
	roll numberOfDice = 4
		ifTrue: [ ^ roll total = 21 | (roll total = 22) ].
	self
		error: 'Unsupported number of dice: ' , roll numberOfDice asString
]

{ #category : #'as yet unclassified' }
MSBout >> isTripleDamageForRoll: roll [
	roll numberOfDice = 3
		ifTrue: [ ^ roll total = 3 ].
	"4 dice roll is assumed to be defending, so no automatic hits according to melee rules"
	roll numberOfDice = 4
		ifTrue: [ ^ false ].
	self
		error: 'Unsupported number of dice: ' , roll numberOfDice asString
]

{ #category : #accessing }
MSBout >> poleCharge: boolean [
	"do heroes charge on first attach with pole weapons?"

	isPoleCharge := boolean
]

{ #category : #bloodyhell }
MSBout >> resolveAttackFor: attacker attacking: attackee withRoll: roll [
	| hits facingBonus numDice doCriticalDamage |
	hits := 0.
	numDice := roll numberOfDice.
	facingBonus := self attackeeFacingBonus: attackee.
	doCriticalDamage := [ :multiplier :s | 
	self crTrace: s.
	criticalHits := criticalHits + 1.
	hits := hits * multiplier ].
	Transcript
		crShow: attacker name;
		show: ' rolled ';
		show: roll total asString;
		show: ' with adjDex ';
		show:
			(attackee isProne
				ifTrue: [ String
						streamContents: [ :stream | 
							stream
								nextPutAll: (attacker adjDx + facingBonus) asString;
								nextPutAll: ' (';
								nextPutAll: attacker adjDx asString;
								nextPutAll: ' + ';
								nextPutAll: facingBonus asString;
								nextPutAll: ', target is prone, i.e., knocked down or picking up a weapon).' ] ]
				ifFalse: [ attacker adjDx asString ]).

	"A hit is a roll that is NOT an automatic miss AND (below or equal to the attacker's adjDex OR and automatic hit)"
	(self isAutomaticMissForRoll: roll) not
		&
			(roll total <= (attacker adjDx + facingBonus)
				| (self isAutomaticHitForRoll: roll))
		ifTrue: [ Transcript crShow: 'Hit! '.
			hits := attacker readiedWeapon doDamage.
			attacker isCharging & attacker readiedWeapon isPole
				ifTrue: [ doCriticalDamage
						cull: 2
						cull: 'Pole weapon charge does double damage!' ].
			(self isDoubleDamageForRoll: roll)
				ifTrue: [ doCriticalDamage
						cull: 2
						cull:
							(String
								streamContents: [ :stream | 
									stream
										nextPutAll: 'Double damage! (roll of ';
										nextPutAll: roll total asString;
										nextPutAll: ' on ';
										nextPutAll: numDice asString;
										nextPutAll: ' dice).' ]) ]
				ifFalse: [ (self isTripleDamageForRoll: roll)
						ifTrue: [ doCriticalDamage
								cull: 3
								cull:
									(String
										streamContents: [ :stream | 
											stream
												nextPutAll: 'Triple damage! (roll of ';
												nextPutAll: roll total asString;
												nextPutAll: ' on ';
												nextPutAll: numDice asString;
												nextPutAll: ' dice).' ]) ] ].
			Transcript
				crShow: 'Total damage done by ';
				show: attacker name;
				show: ': ';
				show: hits asString;
				show: ' hits.'.
			Transcript
				crShow: attackee name;
				show: ' takes ';
				show: (attackee takeHits: hits) asString;
				show: ' hits';
				show:
					(attackee isKnockedDown
						ifTrue: ', is knocked down'
						ifFalse: '');
				show:
					(attackee isAlive not
						ifTrue: [ String
								streamContents: [ :stream | 
									stream
										nextPutAll: ' and is dead ST: ';
										nextPutAll: attackee st asString;
										nextPut: $(;
										nextPutAll: (attackee st - attackee damageTaken) asString;
										nextPut: $) ] ]
						ifFalse: '');
				show:
					(attackee isConscious not & attackee isAlive
						ifTrue: ', and is unconscious'
						ifFalse: '') , '.' ]
		ifFalse: [ "It's a miss"
			Transcript crShow: 'Missed. '.
			(self isDroppedWeaponForRoll: roll)
				ifTrue: [ Transcript crShow: 'Dropped weapon! '.
					criticalMisses := criticalMisses + 1.
					attacker dropWeapon ]
				ifFalse: [ (self isBrokenWeaponForRoll: roll)
						ifTrue: [ Transcript crShow: 'Broke weapon! '.
							criticalMisses := criticalMisses + 1.
							attacker breakWeapon ] ] ]
]

{ #category : #logging }
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
		ifTrue: [ self crTrace: 'Attacker is defending this round.' ].
	attacker isPickingUpWeapon
		ifTrue: [ self crTrace: 'Attacker is picking up his weapon this round.' ].
	attacker isStandingUp
		ifTrue: [ self crTrace: 'Attacker is standing up this round.' ].
	attacker isKnockedDown
		ifTrue: [ self crTrace: 'Attacker is knocked down this round.' ].
	attackee isProne
		ifTrue: [ self
				crTrace:
					'Defender is prone (knocked down?) giving the attacker +4 DX adjustment.' ].
	attackee isDefending
		ifTrue: [ self
				crTrace: 'Defender is defending making the attacker roll 4 dice.' ]
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
									roll := MSRoll numberOfDice: numDice.
									self
										resolveAttackFor: attacker
										attacking: attackee
										withRoll: roll ]
								ifFalse: [ self
										crTrace: 'But he''s not able to attack because he has no readied weapon.' ] ]
						ifTrue: [ self
								crTrace: 'But he''s not able to attack because he was knocked down.' ] ]
				ifFalse: [ self
						crTrace:
							'But he''s not able to attack because he''s '
								,
									(attacker isAlive
										ifTrue: [ 'unconscious.' ]
										ifFalse: [ 'dead.' ]) ] ]
		ifTrue: [ self crTrace: 'But he''s defending.' ]
]

{ #category : #'as yet unclassified' }
MSBout >> tryDefendingAttacker: attacker defender: defender defendOnPoleCharge: defendOnPoleCharge [
	defender isKnockedDown not
		& (defender readiedWeapon ~= MSWeapon none)
		& defender hasDxPenaltyFromInjuries & (defender adjDx < 8)
		ifTrue: [ defender isDefending: true.
			self
				crTrace:
					defender name
						, ' is defending this turn because adjDX < 8 and temporarily penalized.' ]
		ifFalse: [ defendOnPoleCharge & defender isKnockedDown not
				& (defender readiedWeapon ~= MSWeapon none)
				& (attacker readiedWeapon ~= MSWeapon none)
				& attacker readiedWeapon isPole & attacker isCharging
				& defender isCharging not
				ifTrue: [ defender isDefending: true.
					self
						crLog:
							defender name
								,
									' is defending this turn because attacker is charging with pole weapon.' ]	"don't defend if also charging with pole weapon" ]
]

{ #category : #accessing }
MSBout >> tryPickUp: hero [
	hero droppedWeapon = MSWeapon none
		ifTrue: [ ^ self ].
	hero pickUpWeapon.
	self
		crTrace:
			hero name
				,
					' is picking up his weapon this turn (facing rear in all six directions).'
]

{ #category : #accessing }
MSBout >> tryStandUp: hero [
	hero isKnockedDown
		ifFalse: [ ^ self ].
	hero standUp.
	self crTrace: hero name , ' is standing up this turn.'
]

{ #category : #'as yet unclassified' }
MSBout >> winner [
	^ winner
]
