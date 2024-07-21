


Milestone
	parent_type=/obj
	var/YearAcquired=0
	//var/PointsSpent=0
	var/Ranks=0
	var/MaxRanks=1
	var/PointsCost=0
	var/MPvar
	var/Refundable=1
	var/AlienMP=0
	var/UB1
	var/UB2
	desc="This is a milestone.  This one is a placeholder."

	Click()
		..()
		if(src)
			for(var/Milestone/MM in usr) if(MM.AlienMP&&AlienMP)
				usr<<"You already have an Alien MP."
				return
			if(usr.vars[MPvar]>=MaxRanks)
				usr<<"You have already bought the last rank of this."
				return
			else if(AlienMP&&usr.Race!="Alien")
				usr<<"You must be the Alien race to buy Alien MP."
				return
			if(usr.InMiles) return
			usr.InMiles=1

			var/CostUse=src.PointsCost
			var/IntMiles = 0
			var/MagicMiles = 0
			if(istype(src,/Milestone/Intelligence))
				IntMiles = (usr.HasIntMiles*180)*2
				CostUse=max(180,IntMiles)
			if(istype(src,/Milestone/Mysticism))
				MagicMiles = (usr.HasMagicMiles*180)*2
				CostUse=max(180,MagicMiles)
			var/XPTaken=CostUse
			if(usr.Race=="Human") XPTaken*=0.85//humans get a 10% discount on MPs
			var/Choice=alert(usr,"Buy [src] (Cost [XPTaken]): [src.desc] [src.Refundable==0?"Non-Refundable!":""]","[src] [src.MaxRanks>1?"[usr.vars[src.MPvar]+1] / [src.MaxRanks]":""]","Yes","No")
			switch(Choice)
				if("Yes")
					if(usr.XP>=XPTaken)
						usr.XP-=XPTaken
						usr.SpentXP+=XPTaken
						var/Milestone/C= new src.type
						if(locate(C) in usr)
							var/Milestone/newMPu = (locate(C) in usr)
							newMPu.Ranks++
							usr.vars[newMPu.MPvar]+=1
							usr.contents+=newMPu
							usr<<"You bought [newMPu] [newMPu.MaxRanks>1?"[usr.vars[newMPu.MPvar]] / [newMPu.MaxRanks]":""]!"
						else
							C.Ranks=1
							C.YearAcquired=Year
							usr.vars[C.MPvar]=1
							usr.contents+=C
							usr<<"You bought [C] [C.MaxRanks>1?"[usr.vars[C.MPvar]] / [C.MaxRanks]":""]!"
						if(istype(C,/Milestone/Pursuit_Of_Knowledge))
							usr.Int_Mod+=0.5
							usr.Magic_Potential+=0.5
							usr.magicfocus="Magical Skill"
							usr.ifocus="Intelligence"
						if(istype(C,/Milestone/Intelligence))usr.Int_Mod++
						if(istype(C,/Milestone/Mysticism))usr.Magic_Potential++
						if(istype(C,/Milestone/Genius)) usr.Int_Mod++
						if(istype(C,/Milestone/Mystical)) usr.Magic_Potential++
						if(istype(C,/Milestone/I_Studied_The_Blade)) usr.contents+=new/Skill/Buff/Bound_Weapon
						if(istype(C,/Milestone/Well_Studied))
							usr.Int_Mod+=0.5
							usr.Magic_Potential+=0.5
						if(istype(C,/Milestone/Resolve_Of_The_Mountain))
							usr.MaxHealth+=20
							usr.Health+=20
							usr.MaxWillpower+=20
							usr.Willpower+=20
						if(istype(C,/Milestone/Matter_Absorb)) usr.contents+=new/Skill/Misc/Absorb
						if(istype(C,/Milestone/Burning_Fists)) usr.contents+=new/Skill/Unarmed/BurningFists
						if(istype(C,/Milestone/Aim_For_The_Heart)) usr.contents+=new/Skill/Misc/AimForTheHeart
						if(istype(C,/Milestone/Icey_Grip)) usr.contents+=new/Skill/Misc/Icey_Grip
						if(istype(C,/Milestone/Bleeding_Edge)) usr.contents+=new/Skill/Weapon/BleedingEdge
						if(istype(C,/Milestone/Thundering_Blows)) usr.contents+=new/Skill/Weapon/ThunderingBlows
						if(istype(C,/Milestone/Chakra_Blocking)) usr.contents+=new/Skill/Melee/Chakra_Blocking
//						if(istype(C,/Milestone/Custom_Beam)) usr.contents+=new/Skill/Attacks/Beams/CustomEnergyWave
						if(istype(C,/Milestone/Brood_Mother))
							usr.HiveMind=usr.Signature
							usr.contents+=new/Skill/Misc/HiveMind
						if(istype(C,/Milestone/Mana_Siphon)) usr.contents+=new/Skill/Misc/Mana_Siphon
						if(istype(C,/Milestone/Custom_Language))
							var/Language/CustomLanguage/CL = new
							CL.name=input("Name your custom language. (Adhere to all other rules when choosing this name.  Troll/Toxic names will result in punishment.)") as text
							usr.contents+=CL


						if(istype(C,/Milestone/Imitate))
							usr.contents+=new/Skill/Support/Invisibility
							usr.contents+=new/Skill/Support/Imitation
						if(istype(C,/Milestone/Time_Freeze))
							usr.contents+=new/Skill/Attacks/Time_Freeze
						if(istype(C,/Milestone/Death_Regeneration))
							usr.HasDeathRegen=1
							usr.Regenerate+=2
							usr.BaseRegeneration+=0.4
							usr.CanLimbRegen=1
						if(istype(C,/Milestone/Ki_Manipulation)) usr.KiManipulation+=50
						if(istype(C,/Milestone/Unarmed_Mastery)) usr.UnarmedSkill+=50
						if(istype(C,/Milestone/Weapon_Training)) usr.SwordSkill+=50
						if(istype(C,/Milestone/Evasive_Maneuvering)) usr.Athleticism+=50


						if(istype(C,/Milestone/Intelligence) && IntMiles)
							if(usr.Race=="Human")
								usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bought [C] for [IntMiles*0.85] XP.\n")
								alertAdmins("[key_name(usr)] bought [C] for [IntMiles*0.85] XP.")
							else
								usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bought [C] for [IntMiles] XP.\n")
								alertAdmins("[key_name(usr)] bought [C] for [IntMiles] XP.")
						else if(istype(C,/Milestone/Mysticism) && MagicMiles)
							if(usr.Race=="Human")
								usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bought [C] for [MagicMiles*0.85] XP.\n")
								alertAdmins("[key_name(usr)] bought [C] for [MagicMiles*0.85] XP.")
							else
								usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bought [C] for [MagicMiles] XP.\n")
								alertAdmins("[key_name(usr)] bought [C] for [MagicMiles] XP.")
						else
							if(usr.Race=="Human")
								usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bought [C] for [CostUse*0.85] XP.\n")
								alertAdmins("[key_name(usr)] bought [C] for [C.PointsCost*0.85] XP.")
							else
								usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] bought [C] for [CostUse] XP.\n")
								alertAdmins("[key_name(usr)] bought [C] for [C.PointsCost] XP.")
						usr.Reset_StatMultipliers()
						usr.InMiles=0

					else
						usr.InMiles=0
						usr.AllOut("You need [XPTaken] XP to choose [src].")
				if("No") usr.InMiles=0
	Imitate
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasImitate"
		desc="You can use this on someone to imitate them in almost every way, so much so that you may be confused with them. You can hit it again to stop imitating. Choosing this MP will also grant you the invisibility skill."
	Death_Regeneration
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasDeathRegen"
		desc="This will grant you 3 charges of death regen and a small increase to the Base Regeneration stat.  You can not get additional charges after using them."
	Precognition
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasPrecognition"
		desc="This will cause you to attempt to auto dodge projectile based attacks at the cost of a small amount of energy. This will increase the amount your Speed contributes towards Defense to 25% from 15%."
	Time_Freeze
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasTimeFreeze"
		desc="This will send paralyzing energy rings all around nearby people and they will not be able to move until it wears off."
	Matter_Absorb
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasMatterAbsorb"
		desc="This will allow you to absorb people and take a portion of their power into yourself. (Max +30% base as absorb BP)"
	Genius
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasGenius"
		desc="This will increase your base Int mod to 2x."
	Mystical
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasMystical"
		desc="This will increase your base Magic mod to 2x."
	Well_Studied
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasWellStudied"
		desc="This will increase your base Magic mod to 1.5x and base Int mod to 1.5x."
	Brood_Mother
		PointsCost=720
		Refundable=0
		AlienMP=1
		MPvar="HasBroodMother"
		desc="This will increase your child limit by +4 and gives your Mate no CD as well as linking you and all offspring via hive mind."


//Variable MPs
	Intelligence
		PointsCost=180
		MaxRanks=4
		Refundable=0
		MPvar="HasIntMiles"
		desc="This will increase your Int mod by +1 for each rank, it will also decrease your BP by 7.5% each rank."
		UB1="Machine Force"
		UB2="Armament"
	Mysticism
		PointsCost=180
		MaxRanks=4
		Refundable=0
		UB1="Arcane Power"
		UB2="Shadow King"
		MPvar="HasMagicMiles"
		desc="This will increase your Magic mod by +1 for each rank, it will also decrease your BP by 5% each rank."



//	__Tier_1_Milestones
	Pilot_Skill
		PointsCost=180
		UB1="Machine Force"
		UB2="Machine Force"
		Refundable=0
		MPvar="HasPilotSkill"
		desc="This will allow you to pilot ships."
	Key_Ring
		PointsCost=180
		Refundable=0
		MPvar="HasKeyRing"
		UB1="Channel"
		UB2="Channel"
		desc="This will make it so door passes do not take inventory slots.  In addition, you will gain +10% max ki. (Backend)"
	Bulls_Eye
		PointsCost=180
		MaxRanks=4
		MPvar="HasBullsEye"
		UB1="Bestial Wrath"
		UB2="Machine Force"
		desc="This will give you a flat +3% chance to hit with projectile based attacks."
	Deep_Breathing
		PointsCost=180
		MaxRanks=2
		UB1="Fists of Fury"
		UB2="High Tension"
		MPvar="HasDeepBreathing"
		desc="This will increase you recovery ticks by 12.5% per rank. (Does not affect Recovery stat, just the energy tick.)"
	Ki_Manipulation
		PointsCost=180
		MaxRanks=2
		UB1="Channel"
		UB2="Arcane Power"
		Refundable=0
		MPvar="HasKiManip"
		desc="This will grant you +25% Ki Manipulation gains per level, and +50 Ki Manipulation as a one-time boost. Also increases your Ki Manipulation by a flat +50 permanently per rank, allowing you to bypass the cap up to a point."
	Unarmed_Mastery
		PointsCost=180
		MaxRanks=2
		Refundable=0
		UB1="High Tension"
		UB2="Fists of Fury"
		MPvar="HasUnarmed"
		desc="This will grant you +25% Unarmed Skill gains per level and +50 Unarmed Skill as both a one time boost and a 50 flat addition."
	Weapon_Training
		PointsCost=180
		MaxRanks=2
		Refundable=0
		UB1="Armament"
		UB2="Armament"
		MPvar="HasWeapon"
		desc="This will grant you +25% Weapon Skill gains per level and +50 Weapon Skill as both a one time boost and a 50 flat addition."
	Evasive_Maneuvering
		PointsCost=180
		MaxRanks=2
		UB1="Godspeed"
		UB2="Fists of Fury"
		Refundable=0
		MPvar="HasEvasion"
		desc="This will grant you +25% Evasion gains per level and +50 Evasion Skill as both a one time boost and a 50 flat addition. (Each rank will increase jump backwards distance by +1)"
	Building_Permit
		PointsCost=180
		UB1="Machine Force"
		UB2="Shadow King"
		Refundable=0
		MPvar="HasBuildingPermit"
		desc="This will allow you to build turf and objects. This will make every level you upgrade a wall/door grant 3x as much HP and make all resources and mana you put into it worth 3x the amount you invest. This will also make building free for you. This will cause you to inflict double damage to all buildings and objects."
	Extension_Of_My_Arm
		PointsCost=180
		MPvar="HasEOMA"
		UB1="Armament"
		UB2="Machine Force"
		desc="This will make it so handheld weapons(Swords and Hammers) no longer take inventory space and you become immune to disarms."
	State_Of_Zen
		PointsCost=180
		MaxRanks=2
		MPvar="HasStateOfZen"
		desc="This will increase your meditation gains by 33% per rank. (Non refundable. Does not affect int/magic exp)"
	Body_Builder
		PointsCost=180
		MaxRanks=2
		Refundable=0
		UB1="High Tension"
		UB2="Kaioken"
		MPvar="HasBodyBuilder"
		desc="This will increase your self train gains by 50% per rank. "
	Practical_Learner
		PointsCost=180
		MaxRanks=2
		Refundable=0
		UB2="High Tension"
		UB1="Fists of Fury"
		MPvar="HasPracticalLearner"
		desc="This will increase your sparring gains by 50% per rank. "
	Exponential_Growth
		PointsCost=180
		MaxRanks=2
		Refundable=0
		UB1="High Tension"
		UB2="Kaioken"
		MPvar="HasExponentialGrowth"
		desc="This will increase your gain multiplier gains by 15% per rank. "
	Unflinching
		PointsCost=180
		MaxRanks=2
		UB1="Bestial Wrath"
		UB2="Fungal Plague"
		MPvar="HasUnflinching"
		desc="This will increase your crowd control and knockback resistance by 2.5 per rank. "
	Turtle_Shell
		PointsCost=180
		MaxRanks=2
		UB1="Bestial Wrath"
		UB2="Fungal Plague"
		MPvar="HasTurtleShell"
		desc="This will increase Endurance towards attacks from behind by 10% per rank."
	Surgical_Strikes
		PointsCost=180
		MaxRanks=5
		UB1="Fists of Fury"
		UB2="Godspeed"
		MPvar="HasSurgicalStrikes"
		desc="This will give you a flat +5% damage to your opponents limbs per rank, rank 5 will cause you to be able to see your target's limb health."
	Liberal_Arts_Degree
		PointsCost=180
		Refundable=0
		UB1="Machine Force"
		UB2="Arcane Power"
		MPvar="HasLiberalArtsDegree"
		desc="This will cause you to gain any profession exp(smithing/mining/etc) as Tech/Magic exp. "

//	__Tier_2_Milestones
	Flight_Master
		PointsCost=360
		UB2="Godspeed"
		UB1="Arcane Power"
		MPvar="HasFlightMaster"
		desc="This will reduce the cost of Flight and Super Flight to 5% its normal cost, all gains from flight are increased by 50% and you will fly 50% faster. This will also give your Leave Planet a reduced cooldown and you will learn it sooner."
	Beast_Of_Burden
		PointsCost=360
		UB1="Bestial Wrath"
		UB2="High Tension"
		MPvar="HasBeastOfBurden"
		desc="This will increase your inventory space by 10 and increase your Strength by 3%. (Backend)"
	Deft_Hands
		PointsCost=360
		MaxRanks=4
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasDeftHands"
		desc="This will give you a flat +2.5% chance to hit. (Only affects melee attacks)"
	Swift_Reflexes
		PointsCost=360
		UB1="Godspeed"
		UB2="Bestial Wrath"
		MaxRanks=4
		MPvar="HasSwiftReflexes"
		desc="This will give you a flat +2.5% chance to dodge. (Only affects melee attacks)"
	Way_Of_The_Turtle
		PointsCost=360
		UB2="Fungal Plague"
		UB1="Bestial Wrath"
		MaxRanks=4
		MPvar="HasWayOfTheTurtle"
		desc="This will give you a flat +2.5% chance to block. (Only affects melee attacks)"
	Fleet_Of_Foot
		PointsCost=360
		MaxRanks=2
		UB1="Godspeed"
		UB2="Armament"
		Refundable=0
		MPvar="HasFleetOfFoot"
		desc="This will give you a flat +0.05 movespeed per rank. (Does not affect flying.)"
	One_Two_Punch
		PointsCost=360
		MaxRanks=4
		UB1="Fists of Fury"
		UB2="High Tension"
		MPvar="HasFireKeeper"
		desc="This will give you +10% attack speed per rank."
	Auto_Driller
		PointsCost=360
		Refundable=0
		UB1="Machine Force"
		MPvar="HasAutoDriller"
		desc="This will grant you the ability to passively generate resources using your hand drill."
	NRA_Membership
		PointsCost=360
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasNRAMembership"
		desc="This will make you deal +50% damage when firing guns. Gives a 30% chance to not consume ammo when firing."
	Elite_Gun_Training
		PointsCost=360
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasEliteGunTraining"
		desc="This will cause any guns you fire to be modified by your BP multiplier and add 30% of your offense as accuracy."
	The_Seed_Is_Strong
		PointsCost=360
		Refundable=0
		UB1="Fungal Plague"
		UB2="Fungal Plague"
		MPvar="HasTheSeedIsStrong"
		desc="This will allow you to have 2 more offspring and reduce your offspring's incline age by 3."
	Deep_Pockets
		PointsCost=360
		UB1="Shadow King"
		UB2="Machine Force"
		MaxRanks=3
		Refundable=0
		MPvar="HasDeepPockets"
		desc="This will reduce the cost of everything that costs resources or mana by 15% per rank."
	Mana_Siphon
		desc="This will cause you to constantly gain passive mana at 5% the normal rate, no matter what you are doing. This stacks with meditating for mana. This will also cause your melee attacks to have a 25% chance to leech 2.5% of your opponents mana."
		PointsCost=360
		UB1="Fungal Plague"
		UB2="Arcane Power"
		Refundable=0
		MPvar="HasManaSiphon"
	Custom_Language
		PointsCost=360
		Refundable=0
		MPvar="HasCustomLanguage"
		desc="This will grant you a customizable language. "
	Master_Chef
		desc="This will cause food you cook to have an increased duration."
		PointsCost=360
		UB1="Fungal Plague"
		UB2="Fungal Plague"
		MPvar="HasMasterChef"
	Sturdy_Build
		PointsCost=360
		MaxRanks=2
		UB1="High Tension"
		UB2="Bestial Wrath"
		MPvar="HasSturdyBuild"
		desc="This will increase your knockback resistance by 2.5% everytime this is taken, up to a max of +5% KB resist. This will also increase Endurance by 3% per rank up to a max of 6%. This is applied in the backend and you will not see a change in End/Res mult. Each rank also increases the Max Health of all of your body parts by 10."
	Eat_The_Rich
		PointsCost=360
		UB1="Fungal Plague"
		UB2="Kaioken"
		MPvar="HasEatTheRich"
		desc="Deal +5% damage to anyone with more than 100 million resources and mana on them."
	Midas_Punch
		PointsCost=360
		UB1="Fists of Fury"
		UB2="Machine Force"
		MPvar="HasMidasPunch"
		desc="Deal +5% damage to anyone while you have more than 100 million resources and mana on you."
	Energy_Movement
		PointsCost=360
		UB1="Godspeed"
		UB2="Kaioken"
		MPvar="HasEnergyMovement"
		desc="Allows you to zanzoken while charging or firing an attack."
	Wise_Mentor
		PointsCost=360
		UB1="Fists of Fury"
		UB2="Shadow King"
		MPvar="HasWiseMentor"
		Refundable=0
		desc="This will increase your max stored uses of teach from 2 to 5 and you will be able to teach someone new every 2 months instead of every 6."


//	__Tier_3_Milestones
	Mining_Expert
		PointsCost=540
		Refundable=0
		MPvar="HasMiningExpert"
		UB1="Machine Force"
		UB2="Shadow King"
		desc="This will increase your natural dig rate by 1.5x"
	Mana_Expert
		PointsCost=540
		UB1="Arcane Power"
		UB2="Shadow King"
		Refundable=0
		MPvar="HasManaExpert"
		desc="This will increase your natural mana rate by 1.5x"
	Rapid_Deployment
		PointsCost=540
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasRapidDeployment"
		desc="This will cause your Lethal Combat Tracker to tick down at 2x the regular rate. In addition increases your speed by 5% backend. It will also add 2 to Flee/Chase rolls."
	Fast_Metabolism
		PointsCost=540
		UB1="Fungal Plague"
		UB2="Godspeed"
		MPvar="HasFastMetabolism"
		desc="This will cause you to take 10% less damage while you have the a food buff active."
	Salt_Of_The_Earth
		PointsCost=540
		UB1="Fungal Plague"
		UB2="Fungal Plague"
		MPvar="HasSaltOfTheEarth"
		desc="This will cause you to gain anger at 2x the normal rate. "
	Hypermetabolic_Digestive_Enzymes
		PointsCost=540
		UB1="Fungal Plague"
		UB2="Kaioken"
		MPvar="HasHyperEnzymes"
		desc="This will cause you to get +150% to the food boost to regen and recov ticks, but it will only last 25% as long."
	Moral_Compass
		PointsCost=540
		UB1="Fists of Fury"
		UB2="Kaioken"
		MPvar="HasMoralCompass"
		desc="Depending on your alignment this will grant a different bonus. Good: +7.5% Defense, Evil +7.5% Offense, Neutral +5% Off and Def"
	Desperate_Struggle
		PointsCost=540
		UB1="Kaioken"
		UB2="High Tension"
		MPvar="HasDesperateStruggle"
		Refundable=0
		desc="This will increase Offense by 20% while below 50 Willpower."
	Swordsman
		PointsCost=540
		UB1="Armament"
		UB2="Armament"
		desc="This will increase your Offense by 8% while using a sword."
		MPvar="HasSwordsman"
	Hemophilia
		UB1="Fungal Plague"
		UB2="Fungal Plague"
		desc="This will increase your chance to bleed.  For every pool of blood within 10 tiles, you will take 0.5% less damage and deal 0.5% more damage, up to 10% in each. (Will not work for Androids.)"
		PointsCost=540
		MPvar="HasHemophilia"
	King_Of_The_Sea
		desc="For every tile of water within 15 tiles, you will take 0.5% less damage and deal 0.5% more damage, up to 10% in each. (Doesn't count surf.)"
		PointsCost=540
		UB1="Shadow King"
		UB2="Shadow King"
		MPvar="HasKingOfTheSea"
	Fire_Lord
		desc="This will you to take 0.5% less damage and deal 0.5% more damage for every object/turf on fire and burning embers within 10 tiles and person on fire, up to 10% boost to damage and damage reduction."
		PointsCost=540
		UB1="War"
		UB2="War"
		MPvar="HasFireLord"
	New_Type
		desc="This will you to take 0.5% less damage and deal 0.5% more damage for every space tile 10 tiles, up to 10% in each."
		PointsCost=540
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasNewType"
	Friend_Or_Foe
		PointsCost=540
		UB1="War"
		UB2="Shadow King"
		MPvar="HasFriendOrFoe"
		desc="This will make you deal -10% damage to teammates and +5% damage to enemies."
	Side_Swipe
		PointsCost=540
		UB1="Fists of Fury"
		UB2="Godspeed"
		MPvar="HasSideSwipe"
		desc="Attacks against an opponent's side will have +30% flat accuracy."
	Energy_Marksmanship
		PointsCost=540
		UB1="Channel"
		UB2="Channel"
		MPvar="HasEnergyMarksmanship"
		desc="Increases the accuracy of all of your blast based attacks by a flat 10% and gives a 30% chance to ignore Precognition."




//	__Tier_4_Milestones
	Cleanse_The_Wicked
		PointsCost=720
		UB1="Fists of Fury"
		UB2="Armament"
		MPvar="HasCleanseWicked"
		desc="This will cause you to gain +5% damage per kill your opponent has, up to +10% at 2 kills."
	Will_Unbroken
		UB1="Arcane Power"
		UB2="Kaioken"
		PointsCost=720
		MPvar="HasWillUnbroken"
		desc="This will cause your Resist skill to have no cooldown and cost 3% energy instead of 10%. In addition, each time you get up from a lethal KO, you will gain 5 WP."
	Enchant_Master
		PointsCost=720
		UB1="Arcane Power"
		UB2="Shadow King"
		MPvar="HasEnchantMaster"
		desc="This will make you able to enchant items up to 15% total stats (5 stats with 3%, 3% in one stat is the max) and reduces the cost of it by 50%."
	Boundless_Stamina
		PointsCost=720
		Refundable=0
		UB1="Kaioken"
		UB2="High Tension"
		MPvar="HasBoundlessStamina"
		desc="This will increase your ki reserves by 25%. In addition, self train will cost 90% less energy, and the rate your Fatigue increases is reduced by 50%. (This is backend and will affect unlocks and teach requirements.)"
	Burning_Fists
		PointsCost=720
		UB1="Fists of Fury"
		UB2="Kaioken"
		MPvar="HasBurningFists"
		desc="Gives your melee attacks a 66% chance to cause burning damage. (Does not work with swords or hammer.)"
	Bleeding_Edge
		PointsCost=720
		UB1="Armament"
		UB2="Death"
		MPvar="HasBleedingEdge"
		desc="Gives your melee attacks with a weapon a 50% chance to cause bleeding damage, but reduces Speed by 10% due to the concentration required. "
	Thundering_Blows
		desc="Gives your melee attacks with a weapon a 50% chance to cause an extra tick of 10% of the damage of the original attack and apply one tick of stagger OR cause a short stun, but reduces Speed by 10%. "
		PointsCost=720
		UB1="Armament"
		UB2="War"
		MPvar="HasThunderingBlows"
	Exploit_Weakness
		PointsCost=720
		UB1="Bestial Wrath"
		UB2="Fungal Plague"
		MPvar="HasExploitWeakness"
		desc="Attacks against an opponent's back will have +10% damage and +25% flat accuracy."
	Float_Like_A_Butterfly
		PointsCost=720
		UB1="Bestial Wrath"
		UB2="Fungal Plague"
		MPvar="HasFloatLike"
		desc="Each time you dodge an opponent's attack verb they will lose 0.5% energy."
	Keep_Your_Enemies_Closer
		PointsCost=720
		UB2="Shadow King"
		UB1="War"
		MPvar="HasKeepYourEnemies"
		desc="This will cause you to deal extra damage against people you have contact points with, up to +5% damage at 50 CP."
	Lone_Wolf
		PointsCost=720
		UB1="Bestial Wrath"
		UB2="Fists of Fury"
		MPvar="HasLoneWolf"
		desc="This will cause you to deal 5% extra damage and take 5% less damage as long as you have no one in your Team and are not a part of a Faction."
	Agile_Nature
		PointsCost=720
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasAgileMastery"
		desc="This will increase your Speed by 25% while wearing no armor at all and no helmet."
	Armor_Mastery
		PointsCost=720
		UB1="War"
		UB2="Bestial Wrath"
		MPvar="HasArmorMastery"
		desc="This will cause wearing armor, power armor and Gundams to buff your Endurance by an extra 7%."
	Shield_Mastery
		PointsCost=720
		UB1="War"
		UB2="Bestial Wrath"
		MPvar="HasShieldMaster"
		desc="This will cause your shield to increase your Endurance by an extra 5%."
	Embrace_The_Future
		desc="This will cause all of your cyber limbs to give 2x the benefit. "
		PointsCost=720
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasEmbraceTheFuture"
	Range_Of_Motion
		PointsCost=720
		UB1="Godspeed"
		UB2="Godspeed"
		MPvar="HasRangeOfMotion"
		desc="This will increase your Offense and Defense by 10% each while wearing no armor, no helmet and not using a handheld weapon. (No Armor, Swords or Hammer.)"
	Wild_Animal
		PointsCost=720
		UB1="Bestial Wrath"
		UB2="Bestial Wrath"
	//	Refundable=0
		MPvar="HasWildAnimal"
		desc="This will increase your Might by 5% for every 15 Willpower you are missing, up to +20%."

	Chakra_Blocking
		PointsCost=720
		MPvar="HasChakraBlocking"
		UB1="Fungal Plague"
		UB2="Fungal Plague"
		desc="Gives you an attack that drains 1.5x its damage from the target's energy and freezes their recovery for 3 seconds."

	We_Have_The_Technology
		desc="This will allow you to cyberize other people, provided you know how to cyberize yourself already, and cyberizing yourself or others will automatically install all cyber limbs. "
		PointsCost=720
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasWeHaveTheTechnology"
		Refundable=0
	Master_Blacksmith
		desc="This will cause any weapon or armor you create or infuse with metal to have +5% Max BP Add or +5 Kinetic Barrier."
		PointsCost=720
		Refundable=0
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasMasterBlacksmith"
		verb/Reforge()
			set category="Other"
			var/list/L=list()
			for(var/obj/items/Sword/A in view(1,usr))L+=A
			for(var/obj/items/Hammer/A in view(1,usr))L+=A
			for(var/obj/items/Gauntlets/A in view(1,usr))L+=A
			for(var/obj/items/Armor/A in view(1,usr))L+=A
			L+="Cancel"
			var/obj/items/I=input("Reforge what?") in L
			if(L!="Cancel")
				if(istype(I,/obj/items/Armor))
					var/obj/items/Armor/AA=I
					if(AA.KineticBarrier == initial(AA.KineticBarrier))
						AA.KineticBarrier=initial(AA.KineticBarrier)+5
						I.EquipmentDescAssign()
					else
						usr << "This is already a master craft armor."
						return
				else
					if(I.MaxBPAdd == initial(I.MaxBPAdd))
						I.MaxBPAdd=initial(I.MaxBPAdd)+5
						I.EquipmentDescAssign()
					else
						usr << "This is already a master craft weapon."
						return
				view(15,usr) << "[usr] reforges [I] into a master craft."



//		Refundable=0
//	__Tier_5_Milestones
	Zanzoken_Mastery
		PointsCost=900
		UB1="Godspeed"
		UB2="Godspeed"
		MPvar="HasZanzokenMaster"
		desc="This will reduce the cost of Zanzoken to 5% its normal cost. It will increase the damage of warp combo and Warp Attack by 30%. This will cause your zanzoken charges to reset quicker."
	Beam_Expert
		PointsCost=900
		UB1="Channel"
		UB2="Fungal Plague"
		MPvar="HasBeamExpert"
		desc="This will change your Beam to be 3 tiles wide but drain 2 times as much and do 75% damage."
	Concentrated_Fire
		PointsCost=900
		UB1="Channel"
		UB2="War"
		MPvar="HasConcentratedFire"
		desc="This will cause you to deal 10% more damage to your target, but 5% less damage to anyone that is not targeted."
	Hammer_Time
		PointsCost=900
		UB1="Armament"
		UB2="War"
		MPvar="HasHammerTime"
		desc="This will increase your Speed and Offense by 6% while using a hammer."
	Way_Of_The_Fist
		desc="Increases Strength by 10% while not using a weapon."
		PointsCost=900
		UB1="Fists of Fury"
		UB2="High Tension"
		MPvar="HasWayOfTheFist"
	Endless_Expanse
		PointsCost=900
		UB1="High Tension"
		UB2="Fists of Fury"
		MPvar="HasExpand5"
		desc="This will cause your expand to give you 40% Endurance instead of 30%."
	Power_Control_Expert
		desc="This will increase the rate at which you power up by 50% and increase your base Recovery by 0.4 (+5% Power Up after the 0.4 Recov is applied)"
		PointsCost=660
		MPvar="HasPCExpert"

//	__Tier_6_Milestones
	Heavy_Armor_Training
		PointsCost=1080
		UB1="War"
		UB2="War"
		MPvar="HasHeavyArmorTraining"
		desc="Allows you to wear armor and helmets at the same time."
	Resolve_Of_The_Mountain
		PointsCost=1080
		UB1="Kaioken"
		UB2="High Tension"
		Refundable=0
		MPvar="HasResolveOfTheMountain"
		desc="This will increase your Max Health and Max Willpower by +20"
	A_Swift_Death
		desc="This will cause any KO you inflict in lethal to reduce the victim's willpower by an extra 10. "
		PointsCost=1080
		UB1="Death"
		UB2="Arcane Power"
		Refundable=0
		MPvar="HasASwiftDeath"
	Xenophobia
		desc="This will cause you to deal 10% more damage to other races, but you will take 3% more damage from them."
		PointsCost=1080
		UB1="War"
		UB2="Fungal Plague"
		MPvar="HasXenophobia"
	Grime_Reaper
		PointsCost=1080
		UB1="Death"
		UB2="Arcane Power"
		MPvar="HasGrimeReaper"
		desc="This will cause you to gain +5% damage per kill, up to +10% at 2 kills."
	Forceful_Negotiator
		PointsCost=1080
		UB1="Channel"
		UB2="War"
		MPvar="HasForcefulNegotiator"
		desc="This will increase your Force by 13%."
	Challengers_Mark
		PointsCost=1080
		Refundable=0
		UB1="War"
		UB2="Fists of Fury"
		MPvar="HasChallengersMark"
		desc="This will cause you to take 15% less damage from your target but 5% extra damage from sources you do not have targetted."
	Smolder
		desc="This will cause your ki to apply burns and your explosive techniques to leave behind burning embers that will cause damage to those that enter their tile. Lasts for around 15 seconds and deals around 0.7 damage every second. You are not considered to be the origin of this damage, so damage % effects will not increase this."
		PointsCost=1080
		UB1="Kaioken"
		UB2="Channel"
		MPvar="HasSmolder"
	The_Best_Defense
		desc="This will cause any damage you deal to be applied as a percentage damage reduction on your next tick of damage. Stacks up to 20% DR and resets on taking damage. (i.e. you deal 5 damage, get 5% DR)"
		PointsCost=1080
		UB1="High Tension"
		UB2="Bestial Wrath"
		MPvar="HasBestDefense"
	Berserking
		desc="Berserking reduces your Regeneration by 10%, increases damage by 15%."
		PointsCost=1080
		UB1="Kaioken"
		UB2="Bestial Wrath"
		MPvar="HasBerserking"

//	__Tier_8_Milestones

	I_Studied_The_Blade
		PointsCost=1440
		UB1="Armament"
		UB2="War"
		MPvar="HasStudiedBlade"
		desc="This will cause you to learn to summon a physical manifestation of your willpower into a weapon. Counts as all weapon types and has customizable stats. You can not use this with a regular weapon. Has 4 points to invest (Can not invest in Force) and starts with +20% Weapon BP. Drains 0.01 WP per durability loss."
	Anchor_Arms
		PointsCost=1440
		UB1="High Tension"
		UB2="Fists of Fury"
		MPvar="HasThrowYourWeight"
		desc="This will grant you 5% of your Endurance as Strength."
	Weaponized_Ki
		PointsCost=1440
		UB1="Channel"
		UB2="War"
		MPvar="HasWeaponizedKi"
		desc="This will cause your Barrage and Charge attack to benefit from the +BP of your equipped weapon."
	I_Like_To_See_You_Bleed
		PointsCost=1440
		UB1="Fungal Plague"
		UB2="Death"
		MPvar="HasSeeYouBleed"
		desc="This will cause you to regenerate +10 Willpower whenever you knock someone out in lethal, 3 minute CD. (Event characters may not take this)"
	Aim_For_The_Heart
		PointsCost=1440
		UB1="Death"
		UB2="Shadow King"
		MPvar="HasAimForHeart"
		desc="This will grant you a timed buff that reduces damage to 10% but it is dealt as pure willpower damage and bypasses HP. (Event characters may not take this)"
	Icey_Grip
		PointsCost=1440
		UB1="Death"
		UB2="Shadow King"
		MPvar="HasAimForHeart"
		desc="This will grant you a timed buff that causes your attack verb to apply a slow and have a chance to stun. Lasts around 10 seconds."
	Double_Attack
		PointsCost=1440
		UB1="Godspeed"
		UB2="Shadow King"
		MPvar="HasDoubleAttack"
		desc="This will cause you to attack twice in a row 18% of the time when using basic attack."
	Cooldown_Mastery
		PointsCost=1440
		UB1="Godspeed"
		UB2="High Tension"
		MPvar="HasCooldownMastery"
		desc="This will cause all of your CDs to be reduced by 30%."
	Will_Of_Fire
		desc="This will increase your Regeneration Mod by 0.5(backend) and reduce the cost you pay in Willpower to regenerate HP to 50% its normal rate. Reduces WP loss from KO by 8."
		PointsCost=1440
		UB1="Kaioken"
		UB2="Arcane Power"
		MPvar="HasWillOfFire"
		Refundable=0
	Way_Of_The_Open_Palm
		desc="Increases attack damage by 10% Speed while not using a weapon."
		PointsCost=1440
		UB1="Godspeed"
		UB2="Fists of Fury"
		MPvar="HasWayOfTheOpenPalm"
	Control_Of_Power
		desc="This will increase recovery ticks by 50% and increases your power up cap. (+3% PU x Recov)"
		PointsCost=1440
		UB1="Kaioken"
		UB2="Arcane Power"
		MPvar="HasControlOfPower"
	Pursuit_Of_Knowledge
		desc="This will cause you to gain both Int and Magic exp when focused on one or the other. This will also increase your Int and Magic mods by +0.5"
		PointsCost=1440
		UB1="Machine Force"
		UB2="Machine Force"
		MPvar="HasPursuitOfKnowledge"
		Refundable=0
	Blade_Of_Light
		UB1="Channel"
		UB2="Armament"
		desc="This will cause your Ki Blade/Hammer and Spirit Sword to count as a weapon and cause your Ki Blade to grant 40% Weapon BP instead of 33% and causes your Ki Hammer to only reduce Offense and Speed by 15% insetad of 20% and your Spirit Sword to reduce Speed by 20% instead of 30%."
		PointsCost=1440
		MPvar="HasBladeOfLight"
	As_Long_As_My_Heart_Beats
		desc="This will cause your HP to only reduce your BP down to 75% at 1% HP instead of 30% or 50% for someone cyberized.(Will not work for Androids)"
		PointsCost=1440
		UB1="Kaioken"
		UB2="Death"
		MPvar="HasAsLongAsMyHeartBeats"
	This_Drill_Will_Pierce_The_Heavens
		desc="This will cause all of your damage to ignore 10% of your opponents Endurance. "
		PointsCost=1440
		UB1="War"
		UB2="Armament"
		MPvar="HasThisDrill"
	Refuse_To_Lose
		desc="This will increase your chance for Refuse to Die and Burning Desire for Victory by 2x and your chances for a Decisive Blow by 10%. This will also reduce your cooldown on those by 10%."
		PointsCost=1440
		Refundable=0
		UB1="Kaioken"
		UB2="War"
		MPvar="HasRefuseToLose"


mob/proc/MPPurgeRefund()

	for(var/Milestone/MP in src) if(MP.Refundable)
		src.vars[MP.MPvar]=0
		if(istype(MP,/Milestone/Mana_Siphon)) for(var/Skill/Misc/Mana_Siphon/BE in src) del(BE)
		if(istype(MP,/Milestone/Burning_Fists)) for(var/Skill/Unarmed/BurningFists/BF in src) del(BF)
		if(istype(MP,/Milestone/Aim_For_The_Heart)) for(var/Skill/Misc/AimForTheHeart/BF in src) del(BF)
		if(istype(MP,/Milestone/Icey_Grip)) for(var/Skill/Misc/Icey_Grip/BF in src) del(BF)
		if(istype(MP,/Milestone/Bleeding_Edge)) for(var/Skill/Weapon/BleedingEdge/BE in src) del(BE)
		if(istype(MP,/Milestone/Thundering_Blows)) for(var/Skill/Weapon/ThunderingBlows/BE in src) del(BE)
		if(istype(MP,/Milestone/Chakra_Blocking)) for(var/Skill/Melee/Chakra_Blocking/BE in src) del(BE)
		if(istype(MP,/Milestone/I_Studied_The_Blade)) for(var/Skill/Buff/Bound_Weapon/BE in usr) del(BE)
		if(istype(MP,/Milestone/Imitate))
			for(var/Skill/Support/Invisibility/BE in src) del(BE)
			for(var/Skill/Support/Imitation/BE in src) del(BE)
		if(istype(MP,/Milestone/Time_Freeze))for(var/Skill/Attacks/Time_Freeze/BE in src) del(BE)
		if(istype(MP,/Milestone/Death_Regeneration))
			src.HasDeathRegen=0
			src.Regenerate=0
			src.BaseRegeneration-=0.4
			src.CanLimbRegen=0
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
			src.magicfocus=0
			src.ifocus=0
		if(istype(MP,/Milestone/Intelligence))src.Int_Mod-=1*MP.Ranks
		if(istype(MP,/Milestone/Mysticism))src.Magic_Potential-=1*MP.Ranks
		if(istype(MP,/Milestone/Genius))src.Int_Mod--
		if(istype(MP,/Milestone/Mystical))src.Magic_Potential--
		if(istype(MP,/Milestone/Well_Studied))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
		if(istype(MP,/Milestone/Resolve_Of_The_Mountain))
			src.MaxHealth-=20
			src.Health=src.MaxHealth
			src.MaxWillpower-=20
			src.Willpower=src.MaxWillpower
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
		if(istype(MP,/Milestone/Ki_Manipulation)) src.KiManipulation-=50*MP.Ranks
		if(istype(MP,/Milestone/Unarmed_Mastery)) src.UnarmedSkill-=50*MP.Ranks
		if(istype(MP,/Milestone/Weapon_Training)) src.SwordSkill-=50*MP.Ranks
		if(istype(MP,/Milestone/Evasive_Maneuvering)) src.Athleticism-=50*MP.Ranks
		Reset_StatMultipliers()


		var/XPGiven=MP.PointsCost*MP.Ranks
		if(Race=="Human") XPGiven*=0.85//humans get a 10% discount on MPs
		XP+=XPGiven
		SpentXP-=XPGiven
		del MP
	src.BurningFists=0
	src<<"XP corrected. You will recalculate on month tick."
	src.Reset_StatMultipliers()



/*
mob/proc/MPPurge()

	for(var/Milestone/MP in src)
		src.vars[MP.MPvar]=0
		if(istype(MP,/Milestone/Mana_Siphon)) for(var/Skill/Misc/Mana_Siphon/BE in src) del(BE)
		if(istype(MP,/Milestone/Burning_Fists)) for(var/Skill/Unarmed/BurningFists/BF in src) del(BF)
		if(istype(MP,/Milestone/Icey_Grip)) for(var/Skill/Misc/Icey_Grip/BF in src) del(BF)
		if(istype(MP,/Milestone/Aim_For_The_Heart)) for(var/Skill/Misc/AimForTheHeart/BF in src) del(BF)
		if(istype(MP,/Milestone/Bleeding_Edge)) for(var/Skill/Weapon/BleedingEdge/BE in src) del(BE)
		if(istype(MP,/Milestone/Thundering_Blows)) for(var/Skill/Weapon/ThunderingBlows/BE in src) del(BE)
		if(istype(MP,/Milestone/Chakra_Blocking)) for(var/Skill/Melee/Chakra_Blocking/BE in src) del(BE)
		if(istype(MP,/Milestone/I_Studied_The_Blade)) for(var/Skill/Buff/Bound_Weapon/BE in usr) del(BE)
		if(istype(MP,/Milestone/Imitate))
			for(var/Skill/Support/Invisibility/BE in src) del(BE)
			for(var/Skill/Support/Imitation/BE in src) del(BE)
		if(istype(MP,/Milestone/Time_Freeze))for(var/Skill/Attacks/Time_Freeze/BE in src) del(BE)
		if(istype(MP,/Milestone/Death_Regeneration))
			src.HasDeathRegen=0
			src.Regenerate=0
			src.BaseRegeneration-=0.4
			src.CanLimbRegen=0
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
			src.magicfocus=0
			src.ifocus=0
		if(istype(MP,/Milestone/Intelligence))src.Int_Mod-=1*MP.Ranks
		if(istype(MP,/Milestone/Mysticism))src.Magic_Potential-=1*MP.Ranks
		if(istype(MP,/Milestone/Genius))src.Int_Mod--
		if(istype(MP,/Milestone/Mystical))src.Magic_Potential--
		if(istype(MP,/Milestone/Well_Studied))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
		if(istype(MP,/Milestone/Resolve_Of_The_Mountain))
			src.MaxHealth-=20
			src.Health=src.MaxHealth
			src.MaxWillpower-=20
			src.Willpower=src.MaxWillpower
		if(istype(MP,/Milestone/Pursuit_Of_Knowledge))
			src.Int_Mod-=0.5
			src.Magic_Potential-=0.5
		if(istype(MP,/Milestone/Ki_Manipulation)) src.KiManipulation-=50*MP.Ranks
		if(istype(MP,/Milestone/Unarmed_Mastery)) src.UnarmedSkill-=50*MP.Ranks
		if(istype(MP,/Milestone/Weapon_Training)) src.SwordSkill-=50*MP.Ranks
		if(istype(MP,/Milestone/Evasive_Maneuvering)) src.Athleticism-=50*MP.Ranks
		Reset_StatMultipliers()
		del MP
	src.TotalXP=0
	src.XP=0
	src.BurningFists=0
	src.SpentXP=0
	src<<"XP corrected. You will recalculate on month tick."
	if(src.Race=="Alien")
		src.XP+=720
		src<<"Alien XP added, you have one year to spend them."
//	src.LastXP=0
	src.Reset_StatMultipliers()
*/
var/list/global/Milestones = new //typesof(/Milestone) - /Milestone



proc/SetMPList()
	for(var/C in typesof(/Milestone) - /Milestone) global.Milestones+=new C
mob/verb/seeMP()
	usr<<"[Milestones.Join(", ")]"

mob/verb/Buy_Milestones()
//	SetMPList()
	var/list/MPtoBuy=Milestones
	src=usr
	//SetMPList()
	winclone(src, "GenericSheet", "Milestones2")
	winshow(client,"Milestones2",1)
	winset(client,"Milestones2.Grid","cells=0x0")
	var/Row=0
	for(var/Milestone/MP in MPtoBuy)
		//var/Milestone/MP=new M
		Row++

		var/PointsC=MP.PointsCost
		var/IntMiles = (usr.HasIntMiles*180)*2
		var/MagicMiles = (usr.HasMagicMiles*180)*2
		if(istype(MP,/Milestone/Intelligence))PointsC=max(180,IntMiles)
		if(istype(MP,/Milestone/Mysticism))PointsC=max(180,MagicMiles)

		src << output(MP, "Milestones2.Grid:1,[Row]")
		if(src.Race=="Human")
			src << output("[MP.MaxRanks>1?"Rank [usr.vars[MP.MPvar]]/[MP.MaxRanks]<br>":""](Cost [PointsC*0.85] XP[MP.Refundable==0?" Non-Refundable!":""])[MP.AlienMP==1?"(Alien Only)":""]", "Milestones2.Grid:2,[Row]")
		else
			src << output("[MP.MaxRanks>1?"Rank [usr.vars[MP.MPvar]]/[MP.MaxRanks]<br>":""](Cost [PointsC] XP[MP.Refundable==0?" Non-Refundable!":""])[MP.AlienMP==1?"(Alien Only)":""]", "Milestones2.Grid:2,[Row]")
		src << output("[MP.desc]","Milestones2.Grid:3,[Row]")
		//src << output("[MP.desc] [MP.UB1 ? "([MP.UB1] / [MP.UB2])" : ""]","Milestones2.Grid:3,[Row]")

mob/var/tmp/InMiles=0
mob/var/LastMPRefund=-1
mob/verb/RefundMP()
	if(InMiles) return
	if(LastMPRefund+1>WipeDay)
		usr<<"You may only refund an MP once every 1 days. Next available on day [LastMPRefund+1]."
		return
	if(usr.EnablementSlot)
		usr<<"You can not bring yourself to do this. (Already have a unique buff.)"
		return
	var/list/MPtoRefund=list()
	for(var/Milestone/MP in usr) if(MP.Refundable) MPtoRefund+=MP
	MPtoRefund+="Cancel"
	var/Milestone/C=input("Available Milestones to Refund") in MPtoRefund
	if(C=="Cancel")
		InMiles=0
		return
	var/XPGiven=C.PointsCost*C.Ranks
	if(usr.Race=="Human")
		XPGiven*=0.85
	var/Choice=alert(usr,"Refund [C] for 100% of its cost (Cost [round(XPGiven)]): [C.desc]","Refund [C] [C.MaxRanks>1?"[usr.vars[C.MPvar]] / [C.MaxRanks]":""]","Yes","No")
	switch(Choice)
		if("Yes")
			XPGiven*=1//70% refund, undoin that
			XPGiven=round(XPGiven)
			if(!usr.Confirm("You will only get 100% of the XP back ([XPGiven]), are you sure?")) return
			usr.XP+=XPGiven//C.PointsCost*C.Ranks
			SpentXP-=XPGiven//C.PointsCost*C.Ranks
			C.Ranks=0
			usr.vars[C.MPvar]=0
			LastMPRefund=WipeDay
			usr<<"You refunded [C] for [XPGiven] XP!"
			if(istype(C,/Milestone/Burning_Fists)) for(var/Skill/Unarmed/BurningFists/BF in usr)
				BurningFists=0
				del(BF)
			if(istype(C,/Milestone/Aim_For_The_Heart)) for(var/Skill/Misc/AimForTheHeart/BF in src) del(BF)
			if(istype(C,/Milestone/Mana_Siphon)) for(var/Skill/Misc/Mana_Siphon/BE in usr) del(BE)
			if(istype(C,/Milestone/Icey_Grip)) for(var/Skill/Misc/Icey_Grip/BF in src) del(BF)
			if(istype(C,/Milestone/Bleeding_Edge)) for(var/Skill/Weapon/BleedingEdge/BE in usr) del(BE)
			if(istype(C,/Milestone/Thundering_Blows)) for(var/Skill/Weapon/ThunderingBlows/BE in usr) del(BE)
			if(istype(C,/Milestone/Chakra_Blocking)) for(var/Skill/Melee/Chakra_Blocking/BE in usr) del(BE)
			if(istype(C,/Milestone/I_Studied_The_Blade)) for(var/Skill/Buff/Bound_Weapon/BE in usr) del(BE)
			Reset_StatMultipliers()
			if(C.Ranks==0) spawn del C
			InMiles=0









mob/var
	HasBeastOfBurden=0
	HasKiManip=0
	HasStateOfZen=0
	HasBodyBuilder=0
	HasLiberalArtsDegree=0
	HasWildAnimal=0
	HasWeaponizedKi=0
	HasThrowYourWeight=0
	HasPracticalLearner=0
	HasEvasion=0
	HasGrimeReaper=0
	HasHeavyArmorTraining=0
	HasDesperateStruggle=0
	HasEnergyMovement=0
	HasFleetOfFoot=0
	HasSaltOfTheEarth=0
	HasWeHaveTheTechnology=0
	HasWeapon=0
	HasUnarmed=0
	HasFireKeeper=0
	HasKingOfTheSea=0
	HasControlOfPower=0
	HasBuildingPermit=0
	HasArmorMastery=0
	HasAgileMastery=0
	HasNewType=0
	HasStudiedBlade=0
	HasShieldMaster=0
	HasBeamExpert=0
	HasWellStudied=0
	HasMasterBlacksmith=0
	HasRockThrowExpert=0
	HasWayOfTheTurtle=0
	HasSmolder=0
	HasWarpAttackMaster=0
	HasCustomStance=0
	HasSturdyBuild=0
	HasSwordsman=0
	HasSeeYouBleed=0
	HasBroodMother=0
	HasZanzokenMaster=0
	HasPCExpert=0
	HasBestDefense=0
	HasFloatLike=0
	HasTurtleShell=0
	HasMiningExpert=0
	HasManaExpert=0
	HasBurningFists=0
	HasBleedingEdge=0
	HasEnergyMarksmanship=0
	HasEatTheRich=0
	HasMidasPunch=0
	HasWayOfTheFist=0
	HasFireLord=0
	HasFlightMaster=0
	HasHammerTime=0
	HasDeepPockets=0
	HasRefuseToLose=0
	HasAimForHeart=0
	HasLoneWolf=0
	HasThunderingBlows=0
	HasManaSiphon=0
	HasKeepYourEnemies=0

	HasGravityWell=0
	HasSurgeonsVision=0
	HasAutoDriller=0
	HasXenophobia=0
	HasEnchantMaster=0
	HasASwiftDeath=0
	HasHyperEnzymes=0
	HasBladeOfLight=0
	HasAsLongAsMyHeartBeats=0
	HasMasterChef=0
	HasUnflinching=0
	HasExponentialGrowth=0
	HasWayOfTheOpenPalm=0
	HasDeftHands=0
	HasSwiftReflexes=0
	HasWillOfFire=0
	HasCooldownMastery=0
	HasFastMetabolism=0
	HasIntMiles=0
	HasMagicMiles=0
	HasExploitWeakness=0
	HasSideSwipe=0
	HasCustomLanguage=0
	HasWiseMentor=0
	HasPilotSkill=0
	HasKeyRing=0
	HasBoundlessStamina=0
	HasResolveOfTheMountain=0
	HasHemophilia=0
	HasBullsEye=0
	HasSurgicalStrikes=0
	HasDeepBreathing=0
	HasBerserking=0
	HasFriendOrFoe=0
	HasForcefulNegotiator=0
	HasRangeOfMotion=0
	HasConcentratedFire=0
	HasNRAMembership=0
	HasChakraBlocking=0
	HasTheSeedIsStrong=0
	HasPursuitOfKnowledge=0
	HasRapidDeployment=0
	HasEOMA=0
	HasThisDrill=0
	HasEmbraceTheFuture=0
	HasWillUnbroken=0
	HasCleanseWicked=0
	HasTelekinesis=0
	HasDeathRegen=0
	HasInvisibility=0
	HasImitate=0
	HasMatterAbsorb=0
	HasTimeFreeze=0
	HasGenius=0
	HasMystical=0
	HasPrecognition=0
	HasEliteGunTraining=0
	HasCustomEnergyWave=0
	HasDoubleAttack=0
	HasMoralCompass=0
	HasChallengersMark=0
	list/MPs=list()


mob/var/ManaLeech=0
Skill/Misc/Mana_Siphon
	desc="This will cause your melee attacks to have a 25%  chance to leech 2.5% of your opponents mana."
	Experience=100
	verb/Toggle_Mana_Siphon()
		set category="Other"
		usr.ManaLeech=!usr.ManaLeech
		if(usr.ManaLeech)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] begins drawing mana into their body.")
			usr.ManaLeech=1
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] stops drawing mana into their body..")
			usr.ManaLeech=0


mob/proc/LeechMana(mob/M)
	for(var/obj/Mana/T in M) if(T.Value>100)if(prob(25))
		var/Take=round(T.Value*0.025)
		if(Take<1)Take=1
		//if(Take>10000)Take=10000
		T.Value-=Take
		for(var/obj/Mana/MT in src) MT.Value+=Take
		M.CombatOut("Someone siphoned some of your mana. ([Take] Mana)")
		CombatOut("You siphon some of [M]'s mana. ([Take] Mana)")
mob/var/ThunderingBlows=0
Skill/Weapon/ThunderingBlows
	desc="Gives your melee attacks with a weapon a 50% chance to slow your opponent and cause an extra tick of 10% of the damage of original attack OR cause a short stun, but reduces Speed by 10% due to the concentration required."
	Experience=100
	New()
		..()
		icon+=rgb(100,0,20)
	verb/Toggle_Thundering_Blows()
		set category="Other"
		usr.ThunderingBlows=!usr.ThunderingBlows
		if(usr.ThunderingBlows)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] swings their weapon with thunderous blows!")
			usr.SpdMult*=0.9
			usr.ThunderingBlows=1
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] swings their weapon normally.")
			usr.SpdMult/=0.9
			usr.ThunderingBlows=0

mob/var/BoundWeaponOn=0
Skill/Weapon/Bound_Weapon
	Experience=100
	var
		buffon="starts swinging Excalibur." // set a string for when the buff is turned on
		buffoff="puts away Excalibur." // same for when its turned off
		buffslot = 0 // set this to 0 to not take a buff slot, 1 to take one
		PointsSpent=0
		PointsHas=2
		PointsCan=2
		YearDeveloped=0
		CritCan=0
		WeaponLevel=1
		StrMult=1
		EndMult=1
		SpdMult=1
		PowMult=1
		OffMult=1
		DefMult=1
		tmp/Cuzin=0





Skill/Buff/Bound_Weapon
	Experience=100
	buffon="starts swinging Excalibur." // set a string for when the buff is turned on
	buffoff="puts away Excalibur." // same for when its turned off
	buffslot = 0 // set this to 0 to not take a buff slot, 1 to take one
	Str=1
	End=1
	Spd=0.9
	Pow=1
	Off=0.9
	Def=1
	energydrain=LowDrain
	var
		PointsSpent=0
		PointsHas=4
		PointsCan=4
		//CritCan=0
		//WeaponLevel=1
		tmp/Cuzin=0
	New()
		icon=pick('Spirit Sword.dmi','Soul Eater.dmi','Kingdom Key.dmi','Sam Sword.dmi','Sagefire Sword.dmi','DualScim.dmi','Double Helix Sword.dmi')
		if(prob(80)) icon+=rgb(rand(0,55),rand(0,55),rand(0,55))
		if(prob(80)) icon-=rgb(rand(0,55),rand(0,55),rand(0,55))
		..()
	verb/Customize_Bound_Weapon()
		set category="Other"
		if(Cuzin) return
		if(Using)
			usr<<"You can not do this while using the weapon."
			return
		Cuzin=1
		if(usr.Confirm("Refund points?"))
			Cuzin=1
			Str=1
			End=1
			Spd=0.9
			Pow=1
			Off=0.9
			Def=1
			CritCan=0
			WeaponLevel=1
			PointsSpent=0
			PointsHas=PointsCan
		if(usr.Confirm("Change the Bound Weapon Name?"))
			usr<<"Do not use this to give a name that is against the rules or somehow blank names."
			name=input(usr) as text
			if(!name||name==" "||name=="  ") name="Excalibur"
		if(usr.Confirm("Change the buffon message?")) buffon=input(usr) as text
		if(usr.Confirm("Change the buffoff message?")) buffoff=input(usr) as text
		Marker1
		if(PointsHas>0&&PointsSpent<PointsCan)
			if(!usr.Confirm("Invest points? ([PointsHas] points remaining)"))
				Cuzin=0
				return
			else
				var/Pinc=input(usr,"Choose which stat","Customize Bound Weapon") in list("Strength","Endurance","Speed","Offense","Defense","Can Crit","+10% Weapon BP")
				switch(Pinc)
					if("Strength")
						if(Str<1.2)
							Str+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Endurance")
						if(End<1.2)
							End+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Speed")
						if(Spd<1.2)
							Spd+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Offense")
						if(Off<1.2)
							Off+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Defense")
						if(Def<1.2)
							Def+=0.1
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("Can Crit")
						if(CritCan<2)
							CritCan++
							PointsHas--
							PointsSpent++
						else usr<<"This is already capped."
					if("+10% Weapon BP")
						WeaponLevel++
						PointsHas--
						PointsSpent++
		if(PointsHas>0&&PointsSpent<PointsCan)  goto Marker1
		Cuzin=0
	verb/Summon_Bound_Weapon()
		set category = "Other"
		if(usr.WeaponCheck()&&!Using)
			usr << "You must be unarmed to use this skill."
			return
		else
			use(usr,0,0,0,0,0,0,0,0,0,BoundWeapon=1)
mob/proc/BWWillpowerDrain()
	Willpower-=0.005

mob/var/BleedingEdge=0
Skill/Weapon/BleedingEdge
	desc="Gives your melee attacks with a weapon a 50% chance to cause bleeding damage, but reduces Speed by 10% due to the concentration required."
	Experience=100
	verb/Toggle_Bleeding_Edge()
		set category="Other"
		usr.BleedingEdge=!usr.BleedingEdge
		if(usr.BleedingEdge)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] adjusts their aim, seeking to draw blood with their weapon.")
			usr.SpdMult*=0.9
			usr.BleedingEdge=1
			usr.overlays+=src
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] holds their weapon normally.")
			usr.SpdMult/=0.9
			usr.BleedingEdge=0
			usr.overlays-=src

mob/var/Calculated_Strikes=0
mob/var/Calculated_Target="Body"
Skill/Technology/Calculated_Strikes
	Experience=100
	desc="Allows you to choose which area to concentrate your body part damage on. (Has a 60% chance to hit the targetted area instead of random)"
	verb/Toggle_Calculated_Strikes()
		set category="Other"
		usr.Calculated_Strikes=!usr.Calculated_Strikes
		if(usr.Calculated_Strikes) for(var/mob/player/M in view(usr)) M.BuffOut("[usr] seems to be aiming for their opponent's [usr.Calculated_Target] now.")
		else for(var/mob/player/M in view(usr)) M.BuffOut("[usr] stops aiming for their opponent's [usr.Calculated_Target].")
	verb/Set_Calculate_Strikes()
		set category="Other"
		var/list/BPChoices=list("Head","Arms","Body","Legs")
		usr.Calculated_Target=input("Select which area of the body to target with your body part damage.") in BPChoices
		usr.BuffOut("Calculated Strikes set to [usr.Calculated_Target].")

Skill/Unarmed/BurningFists
	Experience=100
	icon='Flaming fists.dmi'
	desc="Gives your attacks a 50% chance to cause burning damage. (Does not work with swords or hammers. Works with ki blade and ki fists but reduces chance to occur by 20%.)"
	verb/Toggle_Burning_Fists()
		set category="Other"
		usr.BurningFists=!usr.BurningFists
		if(usr.BurningFists)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s fists light ablaze!")
			usr.overlays += image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr]s hands stop burning.")
			usr.overlays -= image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)

mob/var/HasKiFists=0//remove me

mob/var/KiFists=0

mob/var/BurningFists=0
Skill/Misc/KiFists
	icon='Flaming_Purple_fists.dmi'
	Experience=100
	Tier=1
	desc="This will give your unarmed attacks +30% Force damage, but 70% Strength. (Doesn't work with other ki-weapon moves. Counts as  +18% BP if you do not have better gauntlets equipped.)"
	New()
		icon+=rgb(rand(0,225),rand(0,225),rand(0,225))
		..()
	verb/Toggle_Ki_Fists()
		set category="Other"
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
			return
		if(usr.SpiritSword)
			usr<<"This can not be used with Spirit Sword"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.KiBow)
			usr<<"This can not be used with Ki Bow"
			return
		usr.KiFists=!usr.KiFists
		if(usr.KiFists)
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] activated Ki Fists.")
			usr.overlays += image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)
		else
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] deactivated Ki Fists.")
			usr.overlays -= image(src,layer=MOB_LAYER+EFFECTS_LAYER+1)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
		