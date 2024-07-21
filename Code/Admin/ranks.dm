





client/proc/Assign_Rank (var/mob/M in Players)
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/Rank_Name = input("Enter the name of the rank you're creating an entry for [M].","Rank Name") as text|null
	if(Rank_Name==null) return
	log_admin({"[key_name(usr)] assigned [M] as a [Rank_Name] inside the Rank entries."})
	alertAdmins("[key_name(usr)] assigned [M] as a [Rank_Name] inside the Rank entries.", 1)
	M.CreateRank("[Rank_Name]")


/client/proc/Give_Rank(mob/A in Players)
	set category="Admin"
	set name = "Give Rank"
	if(!usr.client.holder&&!global.TestServerOn)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/Remove = 0
	var/TXT = "made"
	var/list/choice=new
	choice.Add("Cancel","Add Rank","Remove Rank")
	switch(input(src,"Choose") in choice)
		if("Cancel") return
		if("Remove Rank")
			Remove = 1
			TXT = "removed"
	var/list/Planets=new
	Planets.Add("Cancel","Faction Leader","Guardian","Korin","Major Teacher","Minor Teacher","Major Villain","Minor Villain","Demon","Kaio","Custom","Changeling Tyrant","Space King","Alien King","Saiyan Royalty","Namek Elder","North Cardinal","South Cardinal","East Cardinal","West Cardinal","Archdemon of War","Archdemon of Death","Archdemon of Famine","Archdemon of Pestilence","Turtle Hermit","Crane Hermit","Wolf Hermit", "Black Water Magician","Red Ribbon Leader", "Demon Lord", "Grand Kaioshin","Judge of Souls")
	var/RankPick=input(src,"Choose Rank") in Planets
	switch(RankPick)
		if("Cancel") return
		if("Faction Leader") A.FactionLeader(Remove)
		if("Changeling Tyrant") A.Changeling_Lord(Remove)
		if("Space King") A.SpaceKing(Remove)
		if("Alien King") A.Alien_King(Remove)
		if("Saiyan Royalty") A.Royalty(Remove)
		if("Guardian") A.Guardian(Remove)
		if("Namek Elder") A.Elder(Remove)
		if("Korin") A.Korin(Remove)
		if("Major Teacher") A.MajorTeacher(Remove)
		if("North Cardinal") A.North_Kaio(Remove)
		if("Archdemon of Death") A.DeathH(Remove)
		if("South Cardinal") A.South_Kaio(Remove)
		if("Archdemon of War") A.War(Remove)
		if("East Cardinal") A.East_Kaio(Remove)
		if("Archdemon of Famine") A.Famine(Remove)
		if("West Cardinal") A.West_Kaio(Remove)
		if("Archdemon of Pestilence") A.Pestilence(Remove)
		if("Turtle Hermit") A.Turtle_Hermit(Remove)
		if("Crane Hermit") A.Crane_Hermit(Remove)
		if("Wolf Hermit") A.Wolf_Hermit(Remove)
		if("Minor Teacher") A.MinorTeacher(Remove)
		if("Major Villain") A.MajorVillain(Remove)
		if("Minor Villain") A.MinorVillain(Remove)
		if("Black Water Magician") A.Black_Water_Magician(Remove)
		if("Red Ribbon Leader") A.Red_Ribbon_Leader(Remove)
		if("Demon Lord") A.Daimaou(Remove)
		if("Grand Kaioshin") A.Kaioshin(Remove)
		if("Judge of Souls") A.Judge(Remove)
		if("Demon") A.DemonR(Remove)
		if("Kaio") A.KaioR(Remove)
		if("Custom") usr.client.Assign_Rank(A)
	A.CreateRank("[RankPick]")
	logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] [RankPick]",1)

/*
		if("Space")
			Ranks.Add("Cancel","Android Mainframe","King of Space Pirates","Sword Master","Red Ribbon Leader","Black Water Magician","Skill Master")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Android Mainframe")
					A.AndroidMainframe(Remove)
					A.CreateRank("Android Mainframe")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Android Mainframe",2)
				if("King of Space Pirates")
					A.SpaceKing(Remove)
					A.CreateRank("King of Space Pirates")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] King of Space Pirates",2)
				if("Sword Master")
					A.SwordMaster(Remove)
					A.CreateRank("Sword Master")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Sword Master",2)
				if("Red Ribbon Leader")
					A.Red_Ribbon_Leader(Remove)
					A.CreateRank("Red Ribbon Leader")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Red Ribbon Leader",2)
				if("Black Water Magician")
					A.Black_Water_Magician(Remove)
					A.CreateRank("Black Water Magician")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Black Water Magician",2)
				if("Skill Master")
					A.Skill_Master(Remove)
					A.CreateRank("Skill Master")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Skill Master",2)
		if("Earth")
			Ranks.Add("Cancel","Earth Guardian","Korin","Turtle Hermit","Crane Hermit","Wolf Hermit")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Earth Guardian")
					A.Guardian(Remove)
					A.CreateRank("Earth Guardian")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Earth Guardian",2)
				if("Korin")
					A.Korin(Remove)
					A.CreateRank("Korin")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Korin",2)
				if("Turtle Hermit")
					A.Turtle_Hermit(Remove)
					A.CreateRank("Turtle Hermit")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Turtle Hermit",2)
				if("Crane Hermit")
					A.Crane_Hermit(Remove)
					A.CreateRank("Crane Hermit")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Crane Hermit",2)
				if("Wolf Hermit")
					A.Wolf_Hermit(Remove)
					A.CreateRank("Wolf Hermit")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Wolf Hermit",2)
		if("Namek")
			Ranks.Add("Cancel","Elder","Teacher")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Elder")
					A.Elder(Remove)
					A.CreateRank("Namek Elder")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Namekian elder",2)
				if("Teacher")
					A.Namek_Teacher(Remove)
					A.CreateRank("Namek Teacher")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Namekian Teacher",2)
		if("Vegeta")
			Ranks.Add("Cancel","King/Queen")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("King/Queen")
					A.Royalty(Remove)
					A.CreateRank("King/Queen")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] King/Queen of Vegeta",2)
		if("Arconia")
			Ranks.Add("Cancel","Alien King")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Alien King")
					A.Alien_King(Remove)
					A.CreateRank("Alien King")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Alien King",2)
		if("Ice Planet")
			Ranks.Add("Cancel","Changeling Lord")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Changeling Lord")
					A.Changeling_Lord(Remove)
					A.CreateRank("Changeling Lord")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Changeling Lord",2)
		if("Heaven")
			Ranks.Add("Cancel","Kaioshin","North Kaio","South Kaio","East Kaio","West Kaio","Judge")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Kaioshin")
					A.Kaioshin(Remove)
					A.CreateRank("Kaioshin")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Kaioshin",2)
				if("North Kaio")
					A.North_Kaio(Remove)
					A.CreateRank("North Kai")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] North Kaio",2)
				if("South Kaio")
					A.South_Kaio(Remove)
					A.CreateRank("South Kai")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] South Kaio",2)
				if("East Kaio")
					A.East_Kaio(Remove)
					A.CreateRank("East Kai")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] East Kaio",2)
				if("West Kaio")
					A.West_Kaio(Remove)
					A.CreateRank("West Kai")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] West Kaio",2)
				if("Judge")
					A.Judge(Remove)
					A.CreateRank("Judge")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Judge",2)
		if("Hell")
			Ranks.Add("Cancel","Demon Lord","Death","War","Fungal Plague","Famine")
			switch(input(src,"What Rank?") in Ranks)
				if("Cancel") return
				if("Demon Lord")
					A.Daimaou(Remove)
					A.contents+=new/Skill/Spell/Telekinesis_Magic
					A.contents+=new/Skill/Support/Telekinesis
					A.TK = 1
					A.TK_Magic = 1
					A.CreateRank("Demon Lord")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Daimaou",2)
				if("Death")
					A.DeathH(Remove)
					A.CreateRank("Archdemon of Death")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Archdemon of Death",2)
				if("War")
					A.War(Remove)
					A.CreateRank("Archdemon of War")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Archdemon of War",2)
				if("Famine")
					A.Famine(Remove)
					A.CreateRank("Archdemon of Famine")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Archdemon of Famine",2)
				if("Fungal Plague")
					A.Pestilence(Remove)
					A.CreateRank("Archdemon of Pestilence")
					logAndAlertAdmins("[key_name(src)] [TXT] [key_name(A)] Archdemon of Pestilence",2)
					*/
	A.Remove_Duplicate_Moves() // A dirty fix.

mob/proc
	Guardian(var/R)
		if(R == 0)
			for(var/X in EarthGuardianRank) if(!locate(X) in src) src.contents+=new X
			if(Race=="Namekian")
				if(!locate(/Skill/Support/Make_Magic_Balls) in src) contents+=new/Skill/Support/Make_Magic_Balls
				if(!locate(/Skill/Support/NamekianFusion) in src) contents+=new/Skill/Support/NamekianFusion
			var/obj/items/Crystal_Ball/B = new
			B.Special_Ball = 1
			contents+=B
			Rank="Earth Guardian"
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
			//HBTCPower=15
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in EarthGuardianRank) del(O)
			for(var/Skill/Support/Make_Magic_Balls/MMB in src) del(MMB)
			for(var/Skill/Support/NamekianFusion/NF in src) del(NF)
	// Need to make Senzu a verb instead of just an item
	Korin(var/R)
		if(R == 0)
			for(var/X in KorinRank) if(!locate(X) in src) src.contents+=new X
			Rank="Korin"
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in KorinRank) del(O)

/*
Major Villains: (Serve as faction leaders/teachers)
Starting Resources/Mana, Advanced Faction Controls, 5 point stance, auto cap stats, energy and bp but disables overcap, they can not be leeched from and cannot teach, Dark Blessing, 3 Limited Skills

EC Pool Minor Villains:
Minor Villain Kit, auto cap stats/bp/energy, small RP power 10-30%, becomes save locked after 3-5 days (can be extended with admin), intended to be a disposable character that those in the EC pool can freely create to continue conflict for players.  These villains will be spawned in as members of the current major villains faction and will continue to drive their storyline. Cannot leech or teach

*/
	FactionLeader(var/R)
		if(R == 0)
			PassiveSkillsIncrease(1000,1000,1000,1000)
			if(!locate(/obj/RankChat) in src) src.contents+=new /obj/RankChat
			for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
			var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
			switch(Template)
				if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"

			for(var/obj/Resources/Res in src) Res.Value+=5000000
			for(var/obj/Mana/Man in src) Man.Value+=5000000

			var/Skill/Fac = new /Skill/Misc/FactionLeaderCommands
			Fac.RankKit=1
			contents+=Fac
			src<<"Added [Fac] to skill set"

			var/Skill/Sup = new /Skill/Support/Unlock_Potential
			Sup.RankKit=1
			contents+=Sup
			src<<"Added [Sup] to skill set"

			var/BC=input(src,"Choose a Unique Beam") in UniqueBeams
			UniqueBeams-=BC
			var/Skill/S1 = new BC
			S1.RankKit=1
			contents+=S1
			src<<"Added [S1] to skill set"


			var/Skill/PS = new /Skill/Support/PlantSenzu
			PS.RankKit=1
			contents+=PS
			src<<"Added [PS] to skill set"

			var/Skill/MA = new /Skill/MartialArt
			MA.RankKit=1
			contents+=MA
			src<<"Added [MA] to skill set"

			// var/Skill/LB = new /Skill/Buff/Limit_Breaker
			// LB.RankKit=1
			// contents+=LB
			// src<<"Added [LB] to skill set"

			var/list/LChoices=list()
			for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X

			var/SC=input(src,"Choose 3 more of these skills") in LChoices
			LChoices-=SC
			var/Skill/S2 = new SC
			S2.RankKit=1
			contents+=S2
			src<<"Added [S2] to skill set"

			var/SEC=input(src,"Choose 2 more of these skills") in LChoices
			LChoices-=SEC
			var/Skill/S3 = new SEC
			S3.RankKit=1
			contents+=S3
			src<<"Added [S3] to skill set"

			var/SCC=input(src,"Choose 1 more of these skills") in LChoices
			LChoices-=SCC
			var/Skill/S4 = new SCC
			S4.RankKit=1
			contents+=S4
			src<<"Added [S4] to skill set"

			if(Race=="Namekian")
				var/Skill/NF = new /Skill/Support/NamekianFusion
				NF.RankKit=1
				contents+=NF
				src<<"Added [NF] to skill set"

			Rank="Faction Leader"
			HasBuildingPermit=1
			var/list/L=list()
			for(var/Skill/SSS in src) if(SSS.RankKit) L+=SSS
			logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their kit.",1)
		else
			src << "Your rank was removed."
			Rank=null
			PassiveSkillsIncrease(-1000,-1000,-1000,-1000)
			for(var/Skill/S in src) if(S.RankKit) del(S)
			for(var/obj/RankChat/S in src) del(S)
			for(var/obj/RankChat2/S in src) del(S)

	MajorTeacher(var/R)
		if(R == 0)

			PassiveSkillsIncrease(1000,1000,1000,1000)
			if(!locate(/obj/RankChat) in src) src.contents+=new /obj/RankChat
			for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
			var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
			switch(Template)
				if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"

			var/Skill/MA = new /Skill/MartialArt
			MA.RankKit=1
			contents+=MA
			src<<"Added [MA] to skill set"

			var/UA=input(src,"Choose a Unique Attack") in UniqueAttacks
			UniqueAttacks-=UA
			var/Skill/UAA = new UA
			UAA.RankKit=1
			contents+=UAA
			src<<"Added [UAA] to skill set"
/*
			var/UB=input(src,"Choose a Unique Buff") in UniqueBuffs
			UniqueBuffs-=UB
			var/Skill/SBB = new UB
			SBB.RankKit=1
			contents+=SBB
			src<<"Added [SBB] to skill set"*/


			var/Skill/Attacks/Beams/CustomEnergyWave/CBB = new /Skill/Attacks/Beams/CustomEnergyWave
			CBB.RankKit=1
			contents+=CBB
			CBB.Creator=1
			src<<"Added [CBB] to skill set"



			var/list/LChoices=list()
			for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X
			var/SC=input(src,"Choose 3 more of these skills") in LChoices
			LChoices-=SC
			var/Skill/S2 = new SC
			S2.RankKit=1
			contents+=S2
			src<<"Added [S2] to skill set"

			var/SEC=input(src,"Choose 2 more of these skills") in LChoices
			LChoices-=SEC
			var/Skill/S3 = new SEC
			S3.RankKit=1
			contents+=S3
			src<<"Added [S3] to skill set"

			if(Race=="Namekian")
				var/Skill/NF = new /Skill/Support/NamekianFusion
				NF.RankKit=1
				contents+=NF
				src<<"Added [NF] to skill set"

			var/SCC=input(src,"Choose 1 more of these skills") in LChoices
			LChoices-=SCC
			var/Skill/S4 = new SCC
			S4.RankKit=1
			contents+=S4
			src<<"Added [S4] to skill set"
			var/list/L=list()
			for(var/Skill/SSS in src) if(SSS.RankKit) L+=SSS
			logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their kit.",1)
			Rank="Major Teacher"
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			PassiveSkillsIncrease(-1000,-1000,-1000,-1000)
			for(var/Skill/S in src) if(S.RankKit) del(S)
			for(var/obj/RankChat/S in src) del(S)
			for(var/obj/RankChat2/S in src) del(S)
	MinorTeacher(var/R)
		if(R == 0)
			PassiveSkillsIncrease(500,500,500,500)
			if(!locate(/obj/RankChat) in src) src.contents+=new /obj/RankChat
			for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
			var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
			switch(Template)
				if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"

			// var/Skill/LB = new /Skill/Buff/Limit_Breaker
			// LB.RankKit=1
			// contents+=LB
			// src<<"Added [LB] to skill set"

			var/Skill/MA = new /Skill/MartialArt
			MA.RankKit=1
			contents+=MA
			src<<"Added [MA] to skill set"

			var/list/LChoices=list()
			for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X

			var/Skill/Attacks/Beams/CustomEnergyWave/CBB = new /Skill/Attacks/Beams/CustomEnergyWave
			CBB.RankKit=1
			contents+=CBB
			CBB.Creator=1
			src<<"Added [CBB] to skill set"

			var/SEC=input(src,"Choose 2 more of these skills") in LChoices
			LChoices-=SEC
			var/Skill/S3 = new SEC
			S3.RankKit=1
			contents+=S3
			src<<"Added [S3] to skill set"

			var/SCC=input(src,"Choose 1 more of these skills") in LChoices
			LChoices-=SCC
			var/Skill/S4 = new SCC
			S4.RankKit=1
			contents+=S4
			src<<"Added [S4] to skill set"
			var/list/L=list()
			for(var/Skill/SSS in src) if(SSS.RankKit) L+=SSS
			logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their kit.",1)
			Rank="Minor Teacher"
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			PassiveSkillsIncrease(-500,-500,-500,-500)
			for(var/Skill/S in src) if(S.RankKit) del(S)
			for(var/obj/RankChat/S in src) del(S)
			for(var/obj/RankChat2/S in src) del(S)
	KaioR(var/R)
		if(R == 0)

			PassiveSkillsIncrease(500,500,500,500)
			if(!locate(/obj/RankChat2) in src) src.contents+=new /obj/RankChat2
			for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
			var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
			switch(Template)
				if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"

			var/Skill/LB = new /Skill/Buff/Mystic
			LB.RankKit=1
			contents+=LB
			src<<"Added [LB] to skill set"

			var/Skill/MA = new /Skill/MartialArt
			MA.RankKit=1
			contents+=MA
			src<<"Added [MA] to skill set"

			var/Skill/GP = new /Skill/Support/Give_Power
			GP.RankKit=1
			contents+=GP
			src<<"Added [GP] to skill set"


			var/list/LChoices=list()
			for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X
			var/SC=input(src,"Choose 3 more of these skills") in LChoices
			LChoices-=SC
			var/Skill/S2 = new SC
			S2.RankKit=1
			contents+=S2
			src<<"Added [S2] to skill set"
			var/SEC=input(src,"Choose 2 more of these skills") in LChoices
			LChoices-=SEC
			var/Skill/S3 = new SEC
			S3.RankKit=1
			contents+=S3
			src<<"Added [S3] to skill set"

			var/Skill/CBB = new /Skill/Support/Make_Fruit
			CBB.RankKit=1
			contents+=CBB
			src<<"Added [CBB] to skill set"


			var/SCC=input(src,"Choose 1 more of these skills") in LChoices
			LChoices-=SCC
			var/Skill/S4 = new SCC
			S4.RankKit=1
			contents+=S4
			src<<"Added [S4] to skill set"

			var/Skill/MAA = new /Skill/Support/Mystify
			MAA.RankKit=1
			contents+=MAA
			src<<"Added [MAA] to skill set"
			var/list/L=list()
			for(var/Skill/SSS in src) if(SSS.RankKit) L+=SSS
			logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their kit.",1)
			Rank="Kaio"
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			PassiveSkillsIncrease(-500,-500,-500,-500)
			for(var/Skill/S in src) if(S.RankKit) del(S)
			for(var/obj/RankChat/S in src) del(S)
			for(var/obj/RankChat2/S in src) del(S)
	DemonR(var/R)
		if(R == 0)

			PassiveSkillsIncrease(500,500,500,500)
			if(!locate(/obj/RankChat2) in src) src.contents+=new /obj/RankChat2
			for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
			var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
			switch(Template)
				if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"

			var/Skill/LB = new /Skill/Buff/Majin
			LB.RankKit=1
			contents+=LB
			src<<"Added [LB] to skill set"

/*			var/Skill/SCCC = new /Skill/Support/Soul_Contract
			SCCC.RankKit=1
			contents+=SCCC
			src<<"Added [SCCC] to skill set"*/

			var/Skill/MAA = new /Skill/Support/Majinize
			MAA.RankKit=1
			contents+=MAA
			src<<"Added [MAA] to skill set"

			var/Skill/MA = new /Skill/MartialArt
			MA.RankKit=1
			contents+=MA
			src<<"Added [MA] to skill set"

			var/list/LChoices=list()
			for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X

			var/SC=input(src,"Choose 3 more of these skills") in LChoices
			LChoices-=SC
			var/Skill/S2 = new SC
			S2.RankKit=1
			contents+=S2
			src<<"Added [S2] to skill set"

			var/SEC=input(src,"Choose 2 more of these skills") in LChoices
			LChoices-=SEC
			var/Skill/S3 = new SEC
			S3.RankKit=1
			contents+=S3
			src<<"Added [S3] to skill set"

			var/Skill/CBB = new /Skill/Support/Make_Fruit
			CBB.RankKit=1
			contents+=CBB
			src<<"Added [CBB] to skill set"


			var/SCC=input(src,"Choose 1 more of these skills") in LChoices
			LChoices-=SCC
			var/Skill/S4 = new SCC
			S4.RankKit=1
			contents+=S4
			src<<"Added [S4] to skill set"

			var/list/L=list()
			for(var/Skill/SSS in src) if(SSS.RankKit) L+=SSS
			logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their kit.",1)
			Rank="Demon"
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			PassiveSkillsIncrease(-500,-500,-500,-500)
			for(var/Skill/S in src) if(S.RankKit) del(S)
			for(var/obj/RankChat/S in src) del(S)
			for(var/obj/RankChat2/S in src) del(S)

	MajorVillain(var/R)
		if(R == 0)

			PassiveSkillsIncrease(1000,1000,1000,1000)
			if(!locate(/obj/RankChat2) in src) src.contents+=new /obj/RankChat2
			for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
			var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
			switch(Template)
				if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"

			for(var/obj/Resources/Res in src) Res.Value+=5000000
			for(var/obj/Mana/Man in src) Man.Value+=5000000

			// var/Skill/LB = new /Skill/Buff/Limit_Breaker
			// LB.RankKit=1
			// contents+=LB
			// src<<"Added [LB] to skill set"

			var/Skill/Fac = new /Skill/Misc/FactionLeaderCommands
			Fac.RankKit=1
			contents+=Fac
			src<<"Added [Fac] to skill set"

			var/Skill/Attacks/Beams/CustomEnergyWave/CBB = new /Skill/Attacks/Beams/CustomEnergyWave
			CBB.RankKit=1
			contents+=CBB
			CBB.Creator=1
			src<<"Added [CBB] to skill set"

			var/Skill/Sup = new /Skill/Support/Dark_Blessing
			Sup.RankKit=1
			contents+=Sup
			src<<"Added [Sup] to skill set"

			var/Skill/MA = new /Skill/MartialArt
			MA.RankKit=1
			contents+=MA
			src<<"Added [MA] to skill set"

			var/list/LChoices=list()
			for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X

			var/SC=input(src,"Choose 3 more of these skills") in LChoices
			LChoices-=SC
			var/Skill/S2 = new SC
			S2.RankKit=1
			contents+=S2
			src<<"Added [S2] to skill set"

			var/SEC=input(src,"Choose 2 more of these skills") in LChoices
			LChoices-=SEC
			var/Skill/S3 = new SEC
			S3.RankKit=1
			contents+=S3
			src<<"Added [S3] to skill set"

			var/SCC=input(src,"Choose 1 more of these skills") in LChoices
			LChoices-=SCC
			var/Skill/S4 = new SCC
			S4.RankKit=1
			contents+=S4
			src<<"Added [S4] to skill set"
			var/list/L=list()
			for(var/Skill/SSS in src) if(SSS.RankKit) L+=SSS
			logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their kit.",1)
			Rank="Major Villain"
			VillainTrain=1
			HasBuildingPermit=1
			MaxHealth=150
			MaxWillpower=150

		else
			src << "Your rank was removed."
			Rank=null
			PassiveSkillsIncrease(-1000,-1000,-1000,-1000)
			for(var/Skill/S in src) if(S.RankKit) del(S)
			for(var/obj/RankChat/S in src) del(S)
			for(var/obj/RankChat2/S in src) del(S)
	MinorVillain(var/R)
		if(R == 0)

			PassiveSkillsIncrease(500,500,500,500)
			if(!locate(/obj/RankChat2) in src) src.contents+=new /obj/RankChat2
			for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
			var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
			switch(Template)
				if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"
				if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
					var/Skill/S = new X
					S.RankKit=1
					contents+=S
					src<<"Added [X] to skill set"

			// var/Skill/LB = new /Skill/Buff/Limit_Breaker
			// LB.RankKit=1
			// contents+=LB
			// src<<"Added [LB] to skill set"

			var/Skill/MA = new /Skill/MartialArt
			MA.RankKit=1
			contents+=MA
			src<<"Added [MA] to skill set"

			var/list/LChoices=list()
			for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X

			var/SEC=input(src,"Choose 2 more of these skills") in LChoices
			LChoices-=SEC
			var/Skill/S3 = new SEC
			S3.RankKit=1
			contents+=S3
			src<<"Added [S3] to skill set"

			var/SCC=input(src,"Choose 1 more of these skills") in LChoices
			LChoices-=SCC
			var/Skill/S4 = new SCC
			S4.RankKit=1
			contents+=S4
			src<<"Added [S4] to skill set"
			var/list/L=list()
			for(var/Skill/SSS in src) if(SSS.RankKit) L+=SSS
			logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their kit.",1)
			Rank="Minor Villain"
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			PassiveSkillsIncrease(-500,-500,-500,-500)
			for(var/Skill/S in src) if(S.RankKit) del(S)
			for(var/obj/RankChat/S in src) del(S)
			for(var/obj/RankChat2/S in src) del(S)



	Turtle_Hermit(var/R)
		if(R == 0)
			for(var/X in TurtleHermitRank) if(!locate(X) in src) src.contents+=new X
			GetStance()
			HasBuildingPermit=1
			Rank="Turtle Hermit"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in TurtleHermitRank) del(O)
	Wolf_Hermit(var/R)
		if(R == 0)
			for(var/X in WolfHermitRank) if(!locate(X) in src) src.contents+=new X
			GetStance()
			HasBuildingPermit=1
			Rank="Wolf Hermit"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in WolfHermitRank) del(O)
	Crane_Hermit(var/R)
		if(R == 0)
			for(var/X in CraneHermitRank) if(!locate(X) in src) src.contents+=new X
			GetStance()
			HasBuildingPermit=1
			Rank="Crane Hermit"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in CraneHermitRank) del(O)
	Black_Water_Magician(var/R)
		if(R == 0)
			for(var/X in BlackWaterMagicianRank) if(!locate(X) in src) src.contents+=new X
			Rank="Black Water Magician"
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
			/*var/obj/items/Enchanted_Doll/C = new
			C.loc = src.loc
			C.Password=input(src,"Choose a password for your Spirit Doll") as text*/
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in BlackWaterMagicianRank) del(O)
	Red_Ribbon_Leader(var/R)
		if(R == 0)
			for(var/X in RedRibbonLeaderRank) if(!locate(X) in src) src.contents+=new X
			Rank="Red Ribbon Leader"
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
			Int_Mod++
		else
			src << "Your rank was removed."
			Int_Mod--
			Rank=null
			for(var/Skill/O in src) if(O.type in RedRibbonLeaderRank) del(O)
	Elder(var/R)
		if(R == 0)
			for(var/X in ElderRank) if(!locate(X) in src) src.contents+=new X
			Rank="Namekian Elder"
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			TK = 0
			TK_Magic = 0
			for(var/Skill/O in src) if(O.type in ElderRank) del(O)
	Namek_Teacher(var/R)
		if(R == 0)
			for(var/X in NamekTeacherRank) if(!locate(X) in src) src.contents+=new X
			GetStance()
			HasBuildingPermit=1
			Rank="Namek Teacher"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in NamekTeacherRank) del(O)
	Royalty(var/R)
		if(R == 0)
			for(var/X in KingVegetaRank) if(!locate(X) in src) src.contents+=new X
			GetStance()
			Rank="Monarch of Vegeta"
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in KingVegetaRank) del(O)
	Alien_King(var/R)
		if(R == 0)
			for(var/X in AlienKingRank) if(!locate(X) in src) src.contents+=new X
			Rank="Alien King"
			GetStance()
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			for(var/Skill/Support/InstantTransmission/SI in src) SI.Teachable=1
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in AlienKingRank) del(O)
	Changeling_Lord(var/R)
		if(R == 0)
			for(var/X in IceSkillMasterRank) if(!locate(X) in src) src.contents+=new X
			Rank="Changeling Lord"
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
		else
			src << "Your rank was removed."
			Rank=null
			TK = 0
			for(var/Skill/O in src) if(O.type in IceSkillMasterRank) del(O)
	Kaioshin(var/R)
		if(R == 0)
			for(var/X in KaioshinRank) if(!locate(X) in src) src.contents+=new X
			Rank="Kaioshin"
			for(var/Skill/Buff/Mystic/M in src) M.Super=1
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
			AlignmentNumber=5
			Alignment="Very Pure"
		else
			src << "Your rank was removed."
			Rank=null
			TK = 0
			TK_Magic = 0
			KPAuthorized = 0
			for(var/Skill/O in src) if(O.type in KaioshinRank) del(O)
	North_Kaio(var/R)
		if(R == 0)
			for(var/X in NorthKaioRank) if(!locate(X) in src) src.contents+=new X
			Rank="North Kaio"
			if(GravMastered < 50) GravMastered = 50
			AlignmentNumber=5
			HasBuildingPermit=1
			Alignment="Very Pure"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in NorthKaioRank) del(O)
	East_Kaio(var/R)
		if(R == 0)
			for(var/X in EastKaioRank) if(!locate(X) in src) src.contents+=new X
			Rank="East Kaio"
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			AlignmentNumber=5
			Alignment="Very Pure"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in EastKaioRank) del(O)
	West_Kaio(var/R)
		if(R == 0)
			for(var/X in WestKaioRank) if(!locate(X) in src) src.contents+=new X
			Rank="West Kaio"
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			AlignmentNumber=5
			Alignment="Very Pure"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in WestKaioRank) del(O)
	South_Kaio(var/R)
		if(R == 0)
			for(var/X in SouthKaioRank) if(!locate(X) in src) src.contents+=new X
			Rank="South Kaio"
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			AlignmentNumber=5
			Alignment="Very Pure"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in SouthKaioRank) del(O)
	Judge(var/R)
		if(R == 0)
			for(var/X in JudgeRank) if(!locate(X) in src) src.contents+=new X
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
			Rank="Judge"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in JudgeRank) del(O)
	Daimaou(var/R)
		if(R == 0)
			for(var/X in DaimaouRank) if(!locate(X) in src) src.contents+=new X
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
			Rank="Demon Lord"
			for(var/Skill/Buff/Majin/M in src) M.Super=1
			AlignmentNumber=-5
			Alignment="Very Chaotic"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in DaimaouRank) del(O)
	DeathH(var/R)
		if(R == 0)
			for(var/X in DeathRank) if(!locate(X) in src) src.contents+=new X
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			Rank="Archdemon of Death"
			AlignmentNumber=-5
			Alignment="Very Chaotic"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in DeathRank) del(O)
	Famine(var/R)
		if(R == 0)
			for(var/X in FamineRank) if(!locate(X) in src) src.contents+=new X
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			Rank="Archdemon of Famine"
			AlignmentNumber=-5
			Alignment="Very Chaotic"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in FamineRank) del(O)
	War(var/R)
		if(R == 0)
			for(var/X in WarRank) if(!locate(X) in src) src.contents+=new X
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			Rank="Archdemon of War"
			AlignmentNumber=-5
			Alignment="Very Chaotic"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in WarRank) del(O)
	Pestilence(var/R)
		if(R == 0)
			for(var/X in PestilenceRank) if(!locate(X) in src) src.contents+=new X
			if(GravMastered < 50) GravMastered = 50
			HasBuildingPermit=1
			Rank="Archdemon of Pestilence"
			AlignmentNumber=-5
			Alignment="Very Chaotic"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in PestilenceRank) del(O)
	Skill_Master(var/R)
		if(R == 0)
			for(var/X in SkillMasterRank) if(!locate(X) in src) src.contents+=new X
			GetStance()
			HasBuildingPermit=1
			Rank="Skill Master"
			if(GravMastered < 50) GravMastered = 50
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in SwordMasterRank) del(O)
	SwordMaster(var/R)
		if(R == 0)
			for(var/X in SwordMasterRank) if(!locate(X) in src) src.contents+=new X
			GetStance()
			HasBuildingPermit=1
			Rank="Sword Master"
			if(GravMastered < 50) GravMastered = 50
			src<<"Ask admin about the potential for an enchanted sword!"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in SwordMasterRank) del(O)
	AndroidMainframe(var/R)
		if(R == 0)
			for(var/X in AndroidMainframeRank) if(!locate(X) in src) src.contents+=new X
			CanPilotAS=1
			Rank="Mainframe"
			HasBuildingPermit=1
			if(GravMastered < 200) GravMastered = 200
		else
			src << "Your rank was removed."
			CanPilotAS=0
			Rank=null
			for(var/Skill/O in src) if(O.type in AndroidMainframeRank) del(O)
	SpaceKing(var/R)
		if(R == 0)
			for(var/X in SpaceKingRank) if(!locate(X) in src) src.contents+=new X
			if(GravMastered < 100) GravMastered = 100
			HasBuildingPermit=1
			GetStance()
			Rank="Pirate King"
		else
			src << "Your rank was removed."
			Rank=null
			for(var/Skill/O in src) if(O.type in SpaceKingRank) del(O)

obj/MainframeControls
	verb/Authorize_Pilot(mob/M in oview(1))
		set category="Android Ship"
		if(M.client)
			if(!M.CanPilotAS)
				M.CanPilotAS=1
				usr<<"[M] can now pilot the Android Ship and will be revived by the ship."
				M<<"[usr] has granted you access to the Android Ship controls."
			else
				M.CanPilotAS=0
				usr<<"[M] can no longer pilot the Android Ship and will no longer be revived by the ship."
				M<<"[usr] has revoked your access to the Android Ship controls."
	verb/View_Android_Ship()
		set category="Android Ship"
		for(var/obj/AndroidShip/A)
			usr<<"Click the ship to stop observing"
			usr.reset_view(A)
			return
	verb/Pilot_Android_Ship()
		set category="Android Ship"
		if(!usr.CanPilotAS)
			usr <<"You are not authorized to operate the ship!"
			return
		if(Year<1) usr<<"The ship is still recharging its engines. Try again later. (Year 1+)"
		for(var/obj/AndroidShip/A)
			if(A.Pilot)
				usr<<"[A.Pilot] is already piloting the ship"
				return
			A.Pilot=usr
			usr.PilotLocation=usr.loc
			usr.reset_view(A)
			usr.S=A
			usr<<"Click the ship to stop piloting"
			view(usr)<<"[usr] is now piloting the ship"
			A.Tech=2
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is piloting the ship.\n")
			return
	verb/Launch_Android_Ship()
		set category="Android Ship"
		if(!usr.CanPilotAS)
			usr << "You are not authorized to operate the ship!"
			return
		for(var/obj/AndroidShip/A) if(A.z!=12&&!A.Launching)
			A.Launching=1
			usr<<"Launching in 3 minutes..."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
			spawn(1800) if(src&&A)
				A.Launching=0
				Liftoff(A)
	verb/View_Cameras()
		set category="Android Ship"
		var/Choices=list("Cancel")
		for(var/obj/items/Security_Camera/SC in world) if(SC.Frequency=="Communication Matrix") Choices+=SC
		var/VC=input(usr, "Choose a camera to view") in Choices
		if(VC!="Cancel")
			usr.reset_view(VC)
			usr << "Now viewing [VC]. Click the camera to reset your view."

/obj/JudgeControls/verb/Check_Logs(mob/player/M in view(usr))
	set category = "Skills"
	set name = "Check Player Logs"
	if(!fexists("Data/Players/[M.key]/Logs/"))
		alert("No world logs found!")
		return
	var/filedialog/F = new(usr.client, /client/proc/get_log)
	F.msg = "Choose a logfile."   // message in the window
	F.title = "Load Player Log"      // popup window title
	F.root = "Data/Players/[M.key]/Logs/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
	F.ext = ".log"                  // default extension
	F.filter = ".log"
	usr << ftp(F)
	F.Create(usr.client)            // now display the dialog


mob/proc/Alter_Age(A as num)
	Age+=A
	Real_Age+=A
	Decline+=A
	BirthYear-=A

var/Notes={"<html>
<head><title>Admin Notes</title><body><body bgcolor="#000000"><font size=2><font color="#CCCCCC">
<hr><br>
<b>Admin Rules:</b><br>
1) Admins may not censor OOC, this ruling is over-ruled by Chat Rules 1-4. Examples would be admins telling OOC to stop talking about religion or another sensitive topic.<br>
2) Admins may not reward themselves under any circumstances. The exception to this rule is for the development of event characters, which are only to be done by appointed level 3 admins with permission from atleast 2 other admins.<br>
3) Admins may not use any of there verbs to affect their characters ICly. If an admin has to teleport to someone, they need to return to their previous location immediately after resolving the conflict.<br>
4) Admins may not rank or reward anyone they have extensive relationships with. If you feel an admin has done so, please contact me through email and I will look into your accusations.<br>
5) The admin team as a whole is only permitted to disable OOC up to 2 times per day for RP Hour, each RP hour may not be longer than sixty minutes.<br>
6) Due to the way gains work, OOC sparring while on Admin duty/using admin verbs is not allowed. You may not teleport to someone just for an OOC fight.<br>
<br><br>
</body><html>"}
