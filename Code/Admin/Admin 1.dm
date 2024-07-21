

mob/proc
	Who_Ignores_Realm_Teleport()
		set category="Admin Other"
		for(var/mob/M in Players) if(M.IgnoreRealmTeleport) usr<<"[M] ignores Realm Teleport"

	Who_EC()
		for(var/mob/M in Players) if(M.EventCharacter) usr<<"[M] is an EC made on year [M.EventCharacter] and expected to die year [M.EventCharacter+3] - [M.EventCharacter+5]."


	WhoUnspentXP()
		for(var/mob/M in Players) if(M.XP) usr<<"[M] has [M.XP] ([M.Race])"

	KillCountWho()
		set category="Admin Other"
		for(var/mob/player/M in Players) if(M.Kills)
			usr<<"[M] has killed [M.Kills] people."


	WhoTooMuchXP()
		for(var/mob/M in Players)
			if(M.TotalXP>Year*XPRate*48) usr<<"[M] has [M.TotalXP] XP ([M.Race])"


	WhoPrecog()
		for(var/mob/M in Players) if(M.Precognition) usr<<"[M] has Precognition ([M.Race])"

	WhoRacialPower()
		for(var/mob/M in Players) if(M.RacialPowerAdd) usr<<"[M] has [M.RacialPowerAdd] add ([M.Race])"

	WhoTooMuchMoney()
		for(var/mob/M in Players)
			for(var/obj/Resources/R in M) if(R.Value>50000000)  usr<<"[M] has [R.Value] resouces"
			for(var/obj/Mana/R in M) if(R.Value>50000000)  usr<<"[M] has [R.Value] mana"
		for(var/obj/Mana/R in world) if(R.z) if(R.Value>50000000)  usr<<"[R.Value] mana ([R.x],[R.y],[R.z])"
		for(var/obj/Resources/R in world) if(R.z) if(R.Value>50000000)  usr<<"[R.Value] resouces ([R.x],[R.y],[R.z])"




	Who_Professions()
		var/Mining=0
		var/Smithing=0
		var/Fishing=0
		var/Cooking=0
		for(var/mob/M in Players)
			if(M.Cooking_Level>5)
				Cooking++
				usr<<"[M] has [M.Cooking_Level] Cooking."
			if(M.Fishing_Level>5)
				Fishing++
				usr<<"[M] has [M.Fishing_Level] Fishing."
			if(M.Mining_Level>5)
				Mining++
				usr<<"[M] has [M.Mining_Level] Mining."
			if(M.Smithing_Level>5)
				Smithing++
				usr<<"[M] has [M.Smithing_Level] Smithing."
		usr<<"There are [Cooking] Cooks."
		usr<<"There are [Fishing] Fishermen."
		usr<<"There are [Mining] Miners."
		usr<<"There are [Smithing] Blacksmithers."




	Who_Sizes()
		var/Smalls=0
		var/Mediums=0
		var/Larges=0
		for(var/mob/M in Players)
			if(M.Size=="Small") Smalls++
			if(M.Size=="Medium") Mediums++
			if(M.Size=="Large") Larges++
		usr<<"There are [Smalls] Smalls."
		usr<<"There are [Mediums] Mediums."
		usr<<"There are [Larges] Larges."


	Who_How_Many()
		set category="Admin Other"
		var/list/Pcount=list()
		for(var/mob/M in Players)
			if(M.client.computer_id in Pcount) continue
			else Pcount+=M.client.computer_id
		for(var/client/C in world)
			if(C.computer_id in Pcount) continue
			else Pcount+=C.computer_id
		usr<<"[Pcount.len] unique players."
	Who_Mutation_Check()
		set category="Admin Other"
		for(var/mob/M in Players) if(M.MutationNumber>0) usr<<"[M]: [M.MutationNumber]"
	Who_Can_Build_In_Space()
		set category="Admin Other"
		for(var/mob/M in Players) if(M.BuildInSpace) usr<<"[M]: Space Builder"
	Who_Offspring()
		set category="Admin Other"
		var/Offs=0
		var/Droids=0
		var/SDs=0
		for(var/mob/M in Players)
			if(M.Offspring)
				Offs++
				usr<<"[M] is an Offspring [M.Parents]"
			if(M.Builder)
				if(M.Race=="Android")Droids++
				if(M.Race=="Spirit Doll") SDs++
				usr<<"[M] is an [M.Race] [M.Builder]"
		usr<<"There are [Offs] Offspring and [Droids] Androids and [SDs] Spirit Dolls."
	Who_Unlocked()
		set category="Admin Other"
		for(var/mob/M in Players) if(isnum(M.PotentialUnlocked))
			if(M.PotentialUnlocked==1) usr<<"[M] (Unlock Potential)"
			if(M.PotentialUnlocked==2) usr<<"[M] (Dark Blessing)"
			if(M.PotentialUnlocked==3) usr<<"[M] (Book of Power)"
			if(M.PotentialUnlocked==4) usr<<"[M] (Dragon Ball Wish)"
	Who_RPPower()
		set category="Admin Other"
		for(var/mob/M in Players) if(isnum(M.RPPower)) if(M.RPPower>1) usr<<"[M]: [M.RPPower]"
		for(var/mob/M in Players) if(isnum(M.RPPowerAdd)) if(M.RPPowerAdd>=1) usr<<"[M]: [M.RPPowerAdd] (ADD)"
	Who_Dead()
		set category="Admin Other"
		var/Deads=0
		for(var/mob/M in Players) if(M.Dead)
			Deads++
			usr<<"[M] is Dead [M.KeepsBody ? "(Body)" : ""]"
		usr<<"There are [Deads] dead people."
	Who_SSJ()
		set category="Admin Other"
		var/SSJs=0
		var/SSJ2s=0
		var/SSJ3s=0
		var/SSJ4s=0
		var/SSBs=0
		for(var/mob/M in Players) if(M.HasSSj)
			SSJs++
			usr<<"[M] has SSJ [M.HasSSj]"
			if(M.HasSSj>=2) SSJ2s++
			if(M.HasSSj>=3) SSJ3s++
			if(M.HasSSj4) SSJ4s++
			if(M.MaxGodKi) SSBs++
		usr<<"There are [SSJs] SSjs."
		usr<<"There are [SSJ2s] SSj2s."
		usr<<"There are [SSJ3s] SSj3s."
		usr<<"There are [SSJ4s] SSj4s."
		usr<<"There are [SSBs] SSBs."
		var/BJ2s
		for(var/mob/M in Players) if(M.HasBojack==2)
			BJ2s++
			usr<<"[M] has Super Bojack."
		usr<<"There are [BJ2s] Super Bojacks."
	WhoPlanets()
		set category="Admin Other"
		var/Earth=0
		var/Namek=0
		var/Vegeta=0
		var/Arconia=0
		var/Icer=0
		var/DarkPlanet=0
		var/SpaceStation=0
		var/AlienP=0
		var/AL=0
		for(var/mob/M in Players) if(M.z)
			switch(M.z)
				if(1)Earth++
				if(2)Namek++
				if(3)Vegeta++
				if(4)Icer++
				if(5)Arconia++
				if(6)DarkPlanet++
				if(7)SpaceStation++
				if(14)AlienP++
				if(8||10||11)AL++
		usr<<"Earth [Earth]"
		usr<<"Namek [Namek]"
		usr<<"Vegeta [Vegeta]"
		usr<<"Arconia [Arconia]"
		usr<<"Icer [Icer]"
		usr<<"DarkPlanet [DarkPlanet]"
		usr<<"SpaceStation [SpaceStation]"
		usr<<"AlienP [AlienP]"
		usr<<"AL [AL]"



	RelicCount()
		var/PCount=0
		for(var/mob/player/P in Players)
			PCount=0
			for(var/obj/items/relic/Old_World_Relic/OWR in P) PCount++
			if(PCount) usr<<"[P] has [PCount] relics."



	Who_XP()
		for(var/mob/player/P in Players) if(P.XP) usr<<"[P] has [P.XP] XP."

	Who_Milestones()
		set category="Admin Other"

		var/list/ListOfMPs=list()
		for(var/mob/player/P in Players) for(var/Milestone/MP in P) ListOfMPs["[MP]"]++//ListOfMPs.Add("[MP]"=1)
		//usr<<"[ListOfMPs.Join("<br>")]"
		for(var/P in ListOfMPs) usr<<"[P] : [ListOfMPs[P]]"
/*		var/PHasArmorMastery=0
		var/PHasAgileMastery=0
		var/PHasMortar=0
		var/PHasBullsEye=0
		var/PHasKillDriver=0
		var/PHasMarchOfFury=0
		var/PHasRockBlast=0
		var/PHasTKPull=0
		var/PHasTKPullMaster=0
		var/PHasShieldMaster=0
		var/PHasBeamExpert=0
		var/PHasRockThrowExpert=0
		var/PHasWarpAttackMaster=0
		var/PHasCustomStance=0
		var/PHasSturdyBuild=0
		var/PHasSwordsman=0
//		var/PHasGuideBomb=0
		var/PHasZanzokenMaster=0
//		var/PHasGrabMaster=0
		var/PHasPCExpert=0
		var/PHasMiningExpert=0
		var/PHasManaExpert=0
		var/PHasBurningFists=0
		var/PHasBleedingEdge=0
		var/PHasKiBlade=0
		var/PHasEnergyMarksmanship=0
		var/PHasWayOfTheFist=0
		var/PHasFlightMaster=0
		var/PHasHammerTime=0
		var/PHasDeepPockets=0
//		var/PHasUltraIntellect=0
		var/PHasThunderingBlows=0
		var/PHasManaSiphon=0
		var/PHasBeastOfBurden=0
		var/PHasGravityWell=0
		var/PHasAutoDriller=0
		var/PHasBuildingPermit=0
		var/PHasEnchantMaster=0
//		var/PHasArchmage=0
		var/PHasWayOfTheOpenPalm=0
		var/PHasDeftHands=0
		var/PHasSwiftReflexes=0
		var/PHasCooldownMastery=0
		var/PHasIntMiles=0
		var/PHasMagicMiles=0
		var/PHasBerserking=0
		var/PHasWillOfFire=0
		var/PHasCustomLanguage=0
		var/PHasWiseMentor=0
		var/PHasPilotSkill=0
		var/PHasNewType=0
		var/PHasKeyRing=0
		var/PHasGravitySpecialist=0
		var/PHasArcaneBrokerage=0
		var/PHasBlacksmith=0
		var/PHasAndroidSpecialist=0
		var/PHasTelekinesis=0
		var/PHasDeathRegen=0
		var/PHasInvisibility=0
		var/PHasImitate=0
		var/PHasMatterAbsorb=0
		var/PHasTimeFreeze=0
		var/PHasBoundlessStamina=0
		var/PHasResolveOfTheMountain=0

		var/PHasBorrowedTime=0
		var/PHasFriendOrFoe=0
		var/PHasForcefulNegotiator=0
		var/PHasRangeOfMotion=0
		var/PHasConcentratedFire=0
		var/PHasNRAMembership=0
		var/PHasChakraBlocking=0
		var/PHasTheSeedIsStrong=0
		var/PHasWing_Clip=0
		var/PHasPursuitOfKnowledge=0
		var/PHasRapidDeployment=0
		var/PHasPrecog=0


		for(var/mob/M in Players)
			if(M.HasArmorMastery)PHasArmorMastery++
			if(M.HasAgileMastery)PHasAgileMastery++
			if(M.HasTKPullMaster)PHasTKPullMaster++
			if(M.HasBullsEye)PHasBullsEye++
			if(M.HasShieldMaster)PHasShieldMaster++
			if(M.HasBeamExpert)PHasBeamExpert++
			if(M.HasRockThrowExpert)PHasRockThrowExpert++
			if(M.HasWarpAttackMaster)PHasWarpAttackMaster++
			if(M.HasCustomStance)PHasCustomStance++
			if(M.HasSturdyBuild)PHasSturdyBuild++
			if(M.HasSwordsman)PHasSwordsman++
			if(M.HasZanzokenMaster)PHasZanzokenMaster++
			if(M.HasNewType) PHasNewType++
			if(M.HasPCExpert)PHasPCExpert++
			if(M.HasMiningExpert)PHasMiningExpert++
			if(M.HasManaExpert)PHasManaExpert++
			if(M.HasBurningFists)PHasBurningFists++
			if(M.HasBleedingEdge)PHasBleedingEdge++
			if(M.HasEnergyMarksmanship)PHasEnergyMarksmanship++
			if(M.HasWayOfTheFist)PHasWayOfTheFist++
			if(M.HasFlightMaster)PHasFlightMaster++
			if(M.HasHammerTime)PHasHammerTime++
			if(M.HasDeepPockets)PHasDeepPockets++
			if(M.HasThunderingBlows)PHasThunderingBlows++
			if(M.HasManaSiphon)PHasManaSiphon++
			if(M.HasBeastOfBurden)PHasBeastOfBurden++
			if(M.HasGravityWell)PHasGravityWell++
			if(M.HasAutoDriller)PHasAutoDriller++
			if(M.HasBuildingPermit)PHasBuildingPermit++
			if(M.HasResolveOfTheMountain)PHasResolveOfTheMountain++
			if(M.HasWayOfTheOpenPalm)PHasWayOfTheOpenPalm++
			if(M.HasDeftHands)PHasDeftHands++
			if(M.HasSwiftReflexes)PHasSwiftReflexes++
			if(M.HasEnchantMaster)PHasEnchantMaster++
			if(M.HasBerserking) PHasBerserking++
			if(M.HasCooldownMastery)PHasCooldownMastery++
			if(M.HasIntMiles)PHasIntMiles++
			if(M.HasMagicMiles)PHasMagicMiles++
			if(M.HasWillOfFire)PHasWillOfFire++
			if(M.HasCustomLanguage)PHasCustomLanguage++
			if(M.HasWiseMentor)PHasWiseMentor++
			if(M.HasPilotSkill)PHasPilotSkill++
			if(M.HasKeyRing)PHasKeyRing++
			if(M.HasTelekinesis)PHasTelekinesis++
			if(M.HasDeathRegen)PHasDeathRegen++
			if(M.HasInvisibility)PHasInvisibility++
			if(M.HasImitate)PHasImitate++
			if(M.HasMatterAbsorb)PHasMatterAbsorb++
			if(M.HasTimeFreeze)PHasTimeFreeze++
			if(M.HasBoundlessStamina)PHasBoundlessStamina++
			if(M.HasBuildingPermit)PHasBuildingPermit++
			if(M.HasFriendOrFoe)PHasFriendOrFoe++
			if(M.HasForcefulNegotiator)PHasForcefulNegotiator++
			if(M.HasRangeOfMotion)PHasRangeOfMotion++
			if(M.HasConcentratedFire)PHasConcentratedFire++
			if(M.HasNRAMembership)PHasNRAMembership++
			if(M.HasChakraBlocking)PHasChakraBlocking++
			if(M.HasTheSeedIsStrong)PHasTheSeedIsStrong++
			if(M.HasPursuitOfKnowledge)PHasPursuitOfKnowledge++
			if(M.HasRapidDeployment)PHasRapidDeployment++
			if(M.HasPrecognition)PHasPrecog++

		usr<<{"
	ArmorMastery=[PHasArmorMastery]
	AgileMastery=[PHasAgileMastery]
	TKPull=[PHasTKPull]
	TKPullMaster=[PHasTKPullMaster]
	ShieldMaster=[PHasShieldMaster]
	BeamExpert=[PHasBeamExpert]
	RockThrowExpert=[PHasRockThrowExpert]
	WarpAttackMaster=[PHasWarpAttackMaster]
	CustomStance=[PHasCustomStance]
	SturdyBuild=[PHasSturdyBuild]
	Swordsman=[PHasSwordsman]
	Mortar=[PHasMortar]
	Rock Tomb=[PHasRockBlast]
	March of Fury =[PHasMarchOfFury]
	ZanzokenMaster=[PHasZanzokenMaster]
	Kill Driver=[PHasKillDriver]
	PilotSkill=[PHasPilotSkill]
	PCExpert=[PHasPCExpert]
	MiningExpert=[PHasMiningExpert]
	ManaExpert=[PHasManaExpert]
	BurningFists=[PHasBurningFists]
	BleedingEdge=[PHasBleedingEdge]
	KiBlade=[PHasKiBlade]
	EnergyMarksmanship=[PHasEnergyMarksmanship]
	WayOfTheFist=[PHasWayOfTheFist]
	FlightMaster=[PHasFlightMaster]
	HammerTime=[PHasHammerTime]
	DeepPockets=[PHasDeepPockets]
	NewType=[PHasNewType]
	ThunderingBlows=[PHasThunderingBlows]
	ManaSiphon=[PHasManaSiphon]
	BeastOfBurden=[PHasBeastOfBurden]
	GravityWell=[PHasGravityWell]
	AutoDriller=[PHasAutoDriller]
	Architect=[PHasBuildingPermit]
	Building Permit = [PHasBuildingPermit]
	Bulls Eye = [PHasBullsEye]
	Berserking = [PHasBerserking]
	Precognition = [PHasPrecog]
	WayOfTheOpenPalm=[PHasWayOfTheOpenPalm]
	DeftHands=[PHasDeftHands]
	SwiftReflexes=[PHasSwiftReflexes]
	EnchantMaster=[PHasEnchantMaster]
	CooldownMastery=[PHasCooldownMastery]
	IntMiles=[PHasIntMiles]
	MagicMiles=[PHasMagicMiles]
	WillOfFire=[PHasWillOfFire]
	ArcaneBrokerage=[PHasArcaneBrokerage]
	CustomLanguage=[PHasCustomLanguage]
	WiseMentor=[PHasWiseMentor]
	KeyRing=[PHasKeyRing]
	GravitySpecialist=[PHasGravitySpecialist]
	Blacksmith=[PHasBlacksmith]
	AndroidSpecialist=[PHasAndroidSpecialist]
	Telekinesis=[PHasTelekinesis]
	DeathRegen=[PHasDeathRegen]
	Invisibility=[PHasInvisibility]
	Imitate=[PHasImitate]
	MatterAbsorb=[PHasMatterAbsorb]
	TimeFreeze=[PHasTimeFreeze]
	BoundlessStamina=[PHasBoundlessStamina]
	ResolveOfTheMountain=[PHasResolveOfTheMountain]
	Borrowed Time = [PHasBorrowedTime]
	Friend Or Foe = [PHasFriendOrFoe]
	Forceful Negotiator = [PHasForcefulNegotiator]
	Range Of Motion = [PHasRangeOfMotion]
	Concentrated Fire = [PHasConcentratedFire]
	NRA Membership = [PHasNRAMembership]
	ChakraB locking = [PHasChakraBlocking]
	The Seed Is Strong = [PHasTheSeedIsStrong]
	Wing Clip = [PHasWing_Clip]
	Pursuit Of Knowledge = [PHasPursuitOfKnowledge]
	Rapid Deployment = [PHasRapidDeployment]
	"}
	*/
	Who_FBM()
		set category="Admin Other"
		var/FBMs=0
		var/FBM2s=0
		for(var/mob/M in Players)
			if(M.FBMAchieved==1)
				FBMs++
				usr<<"[M] has ascended ([M.BPMod])"
			if(M.FBMAchieved==2)
				FBM2s++
				usr<<"[M] has ascended further beyond! ([M.BPMod])"
		usr<<"[FBMs] people have ascended."
		usr<<"[FBM2s] people have ascended further beyond."
	Who_Is_BP_Capped()
		set category="Admin Other"
		var/Capps=0
		for(var/mob/M in Players)
			if(M.Base/M.BPMod>=TrueBPCap*0.9)
				Capps++
				usr<<"[M] is BP Capped ([M.Base])"
		usr<<"[Capps] people have capped BP."
	Who_God_Ki()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/GodKis=0
		for(var/mob/M in Players) if(M.MaxGodKi)
			GodKis++
			usr<<"[M] : [M.MaxGodKi] x God Ki"
		usr<<"There are [GodKis] people with God Ki."
	Who_Transformation()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/mob/M in Players)
			if(M.ssj==1&&M.SSjDrain<300) usr<<"[M] (SSj)"
			else if(M.ssj==1) usr<<"[M] (SSj FP)"
			else if(M.ssj==2) usr<<"[M] (SSj2)"
			else if(M.ssj==3) usr<<"[M] (SSj3)"
			else if(M.ssj==4) usr<<"[M] (SSj4)"
			else if(M.ssj==5)
				if(M.SSGSSColor=="Rose") usr<<"[M] (SSGR)"
				else usr<<"[M] (SSGSS)"
			else if(M.Form==1) usr<<"[M] (Form 2)"
			else if(M.Form==2) usr<<"[M] (Form 3)"
			else if(M.Form==3) usr<<"[M] (Form 4)"
			else if(M.AlienTrans==1)usr<<"[M] (Alien Trans)"
			else
				if(M.Bojack==1) usr<<"[M] (Bojack)"
				if(M.Bojack==2) usr<<"[M] (Super Bojack)"
			if(M.ismystic) usr<<"[M] (Mystic)"
			if(M.ismajin) usr<<"[M] (Majin)"
mob/var/ServerInfoOn=0
client/var/ServerInfoOn=0

mob/Admin1/verb
/*	Player_Panel()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if (usr.client.holder)
			usr.client.holder.player()
		return*/

	Check_Spawns()
		set category = "Admin Other"

		usr<<"YardratSpawn=[YardratSpawn]"
		usr<<"DemigodSpawn=[DemigodSpawn]"
		usr<<"Heran=[HeranSpawn]"
		usr<<"Kanassan=[KanassanSpawn]"
		usr<<"OniSpawn=[OniSpawn]"
		usr<<"AlienSpawn=[AlienSpawn]"
		usr<<"HumanSpawn=[HumanSpawn]"
		usr<<"TuffleSpawn=[TuffleSpawn]"
		usr<<"NamekianSpawn=[NamekianSpawn]"
		usr<<"SaiyanSpawn=[SaiyanSpawn]"
		usr<<"IcerSpawn=[IcerSpawn]"
		usr<<"MakyoSpawn=[MakyoSpawn]"
		usr<<"PuarSpawn=[PuarSpawn]"
		usr<<"KonatsianSpawn=[KonatsianSpawn]"
		usr<<"ShinjinSpawn=[ShinjinSpawn]"
		usr<<"DemonSpawn=[DemonSpawn]"
		usr<<"CerealianSpawn=[CerealianSpawn]"
		usr<<"HeeterSpawn=[HeeterSpawn]"
		usr<<"GreysSpawn=[GreysSpawn]"
		usr<<"DragonSpawn=[DragonSpawn]"
		usr<<"PrimalSpawn=[PrimalSpawn]"


	Who_Needs_Audit()
		set category = "Admin Other"
		for(var/mob/player/P in Players) if(Year-P.LastEmoteAudit>4) usr<<"[P] was last audited year [P.LastEmoteAudit]"

	Show_Server_Info_Tab()
		set category = "Admin Other"
		if(ServerInfoOn) ServerInfoOn=0
		else
			usr<<"ServerInfoOn"
			ServerInfoOn=1
	Mark_As_Alignment(mob/M in Players)
		set category="Admin Other"
		if(M.LastAlignmentAssign+1<=Year)
			var/Align=input("Mark [M] as being which alignment?") in list("Good","Evil","Neutral")
			view(M)<<"[M] has been marked as [Align]."
			if(M.LastAlignmentAssign+1> Year) return
			switch(Align)
				if("Evil") M.AlignmentNumber-=1
				if("Good") M.AlignmentNumber+=1
				if("Neutral") if(M.AlignmentNumber!=0) M.AlignmentNumber/=3
			M.AlignmentCalibrate()
			M.LastAlignmentAssign=Year
			logAndAlertAdmins("([M.Rank]) [key_name(usr)] marked [key_name(M)] to [Align].")
			M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
		else usr<<"Their alignment is on cooldown."
/*	Reward_Experience(mob/M in Players)
		set category="Admin Other"
		if(usr.Confirm("Grant [M] +100 XP? They were last rewarded year [M.LastXPAssign]."))
			M<<"You have been rewarded 100 XP."
			M.XP+=100
			M.LastXPAssign=Year
			logAndAlertAdmins("[M] has been rewarded +100 XP by [usr].")
			var/addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> [usr.key] rewarded [M] ([M.key]) +100 XP<br><hr>"
			M.mind.store_memory(addedMemory)

	Reward_Roleplay_Power(mob/M in Players)
		set category="Admin Other"
		if(usr.Confirm("Grant [M] Roleplay Power?"))
			M<<"You have been rewarded 5% Roleplay Power."
			M.RPPower+=0.05
			logAndAlertAdmins("[M] has been rewarded 5% RP Power by [usr] and now has [M.RPPower] RP Power.")
			var/addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> [usr.key] rewarded [M] ([M.key]) +5% RP power and now has [M.RPPower] RP Power.<br><hr>"
			M.mind.store_memory(addedMemory)
*/
	Player_Panel(mob/M in Players)
		set category =null// "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(!ismob(M)) return
		var/dat = "<html><head><title>Options for [M.key]</title></head>"
		var/foo = "\[ "
		if(M.client)
			foo += text("<A href='?src=\ref[usr.client.holder];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.sfIsMuted(M.client) ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[usr.client.holder];givemenu=\ref[M]'>Give Menu</A> | ")
			foo += text("<A href='?src=\ref[usr.client.holder];privatemessage=\ref[M]'>Private Message</A> | ")
			if (Players.Find(M))
				foo += text("<A HREF='?src=\ref[usr.client.holder];observe=\ref[M]'>Watch</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];sendToSpawn=\ref[M]'>Send to Spawn</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];assess=\ref[M]'>Assess</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];giveobj=\ref[M]'>Give Obj</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];kill=\ref[M]'>Kill</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];knockout=\ref[M]'>Knockout</A> | ")
//				if(usr.client.holder.level>=2) foo += text("<A HREF='?src=\ref[usr.client.holder];CapStats=\ref[M]'>Cap Stats</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];heal=\ref[M]'>Heal</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];revive=\ref[M]'>Revive</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];readmind=\ref[M]'>Player Journal</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];getlog=[M.lastKnownKey];portion=0'>Check Logs</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];emoteaudit=\ref[M]'>Mark Emote Audit</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];subtlemessage=\ref[M]'>IC Message</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];summon=\ref[M]'>Summon</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];jumpto=\ref[M]'>Jump to</A> | ")
				foo += text("<A href='?src=\ref[usr.client.holder];XYZTele=\ref[M];'>XYZ Teleport</A> | ")
				if(usr.client.holder.level>=2) foo += text("<A href='?src=\ref[usr.client.holder];command=edit;target=\ref[M];type=view;'>Edit</A> | ")
				//foo += text("<A HREF='?src=\ref[usr.client.holder];starterboost=\ref[M]'>Starter Boost</A> | ")
				//foo += text("<A HREF='?src=\ref[usr.client.holder];statredo=\ref[M]'>Give Redo Stats</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];alterstats=\ref[M]'>Alter Stats</A> | ")
				foo += text("<A HREF='?src=\ref[usr.client.holder];altermuts=\ref[M]'>Alter Mutations</A> | ")
		foo += text("<A href='?src=\ref[usr.client.holder];boot2=\ref[M]'>Boot</A> | ")
		foo += text("<A href='?src=\ref[usr.client.holder];newban=\ref[M]'>Ban</A> \]")
		dat += text("<body>[foo]</body></html>")
		usr << browse(dat, "window=adminplayeropts;size=500x130")


	Force_RolePlay_Mode(mob/M in Players)
		set category =null// "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(usr.Confirm("Toggle their RPMode?")) M.RPMode()


/*
	Narrate_From(mob/M in Players, var/message as message)
		set category = "Admin"
		set desc = "Narrate to those within 55 tiles of the target"
		if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
			message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
		if (message)
			if(usr.client.holder.rank != "Owner" )
				message = adminscrub(message,MAX_MESSAGE_LEN)
			for(var/mob/MM in range(MM,55)) M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			alertAdmins("[key_name(usr)] used narrate.")
*/
/*
	Reccomend_Better_Reward(mob/M in Players)
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!usr.Confirm("Suggest [M] get a better reward?")) return
		var/addedMemory = input("Reccomend a better reward for what?") as message
		log_admin("[key_name(usr)] reccomended [key_name(M)] get a better reward.")
		alertAdmins("[key_name(usr)] reccomended [key_name(M)] get a better reward.")
		addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key])<hr> [addedMemory]<br><hr>"
		M.mind.store_memory(addedMemory)
		M.GoldStarsTotal++
*/

	Refund(obj/items/O)
		set category =null// "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!O)
			alert("Mob doesn't exist!")
			return
		if(usr.Confirm("Refund [O]?"))
			var/C=input("Refund as mana or resources?") in list("Mana","Resources")
			switch(C)
				if("Resources")
					var/obj/Resources/A=new
					if(isturf(O.loc)) A.loc=O.loc
					else A.loc=O.loc.loc
					A.Value=O.cost
					A.name="[A.Value] Resouces"
				if("Mana")
					var/obj/Mana/A=new
					if(isturf(O.loc)) A.loc=O.loc
					else A.loc=O.loc.loc
					A.Value=O.cost
					A.name="[A.Value] Mana"
			del(O)




	ARestore(mob/M in Players)
		//set category = "Admin"
		set name = "Admin Restore"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(M.KOd) M.Un_KO()
		M.Health = M.MaxHealth
		M.Frozen=0
		M.attacking=0
		if(usr.Confirm("Restore their Willpower?")) M.Willpower=M.MaxWillpower
		if(usr.Confirm("Heal Injuries?"))  for(var/BodyPart/P in M) if(P.Health<=P.MaxHealth) M.Injure_Heal(200,P,1)
		if(M.KOd) M.Un_KO()
		M.Health = M.MaxHealth
		M.Ki = M.MaxKi
		M.Calm()
		M.Ki = M.MaxKi
		log_admin("[key_name(usr)] used AdminHeal on [key_name(M)]")
		alertAdmins("[key_name(usr)] used AdminHeal on [key_name(M)]")

	Check_Dragon_Balls()
		set category = "Admin Other"
		for(var/obj/Magic_Ball/G in DragonBalls)
			src << "Magic Ball [G] located at: [G.x?"([G.x],[G.y],[G.z])":"[G.loc]"] ([G.Creator]) ([G.BallsAreInert/12] Years CD)"
	Manual_Ban()
		set category="Admin"
		if(!usr.client.holder) return
		if(!usr.Confirm("Manual ban?")) return
		src << "To manual ban a player at least ONE of the pop ups need to be filled in."
		var/keyname = ckey(input(src, "What is the name of their BYOND key?","Keyname?","") as text)
		var/pc_id = input(src,"What is their IP or computer_id?","IP/PC_ID","") as text
		if(!keyname&&!pc_id){ src<<"Need atleast a key OR an IP OR a computer_id!"; return }
		switch(alert("Temporary Ban?",,"Yes","No"))
			if("Yes")
				var/mins = input(src,"How long (in minutes)?","Ban time",1440) as num
				if(!mins||mins==0||mins<0)
					return
				if(mins >= 525600) mins = 525599
				var/reason = input(usr,"Reason?","reason","Griefer") as text
				if(!reason)
					return
				AddBan(keyname, pc_id, reason, src.ckey, 1, mins)
				logAndAlertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis will be removed in [mins] minutes.",1)
				//alertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis will be removed in [mins] minutes.")
				//file("AdminLog.log")<<"[src]([src.key]) has temporarily manual banned [keyname] for [reason] for [mins] minutes at [time2text(world.realtime,"Day DD hh:mm")]\n"
			if("No")
				var/reason = input(usr,"Reason?","reason","Griefer") as text
				if(!reason)
					return
				AddBan(keyname, pc_id, reason, src.ckey, 0, 0)
				logAndAlertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis is a permanent ban.",1)
			//	alertAdmins("[src] has manual banned [keyname] || [pc_id].\nReason: [reason]\nThis is a permanent ban.")
				//file("AdminLog.log")<<"[src]([src.key]) has permanently manual banned [keyname] for [reason] at [time2text(world.realtime,"Day DD hh:mm")]\n"
	Edit_Notes()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!WritingNotes)
			WritingNotes=src
			logAndAlertAdmins("[src.key] is editing the notes...",1)
			Notes=input(usr,"Edit!","Edit Notes",Notes) as message
			logAndAlertAdmins("[src.key] is done editing the notes...",1)
			WritingNotes=0
			SaveNotes()
		else usr<<"<b>Someone is already editing the notes."
	Edit_Story()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!WritingStory)
			WritingStory=src
			logAndAlertAdmins("[src.key] is editing the story...",1)
			Story=input(usr,"Edit!","Edit Story",Story) as message
			logAndAlertAdmins("[src.key] is done editing the story...",1)
			WritingStory=0
			SaveNotes()
		else usr<<"<b>Someone is already editing the story."
	Edit_Rules()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!WritingRules)
			WritingRules=src
			logAndAlertAdmins("[src.key] is editing the rules...",1)
			Rules=input(usr,"Edit!","Edit Rules",Rules) as message
			logAndAlertAdmins("[src.key] is done editing the rules...",1)
			WritingRules=0
			SaveNotes()
		else usr<<"<b>Someone is already editing the rules."


/*	BP_Mult_Check()
		set category="Admin Other"
		for(var/mob/M in Players) if(M.BPMult!=1)
			usr<<"[M]: BP Mult [round(M.BPMult,0.001)]"*/
	Admin_Docs()
		set category="Admin"
		usr<<link("https://docs.google.com/spreadsheets/d/1H4LEF7BrPnAnU1uScb0vO4CKirYQV5PUOSJ7hdw-4hw/edit?usp=sharing")
/*	Check_Gravity_Machines()
		set category = "Admin Other"
		for(var/obj/items/Gravity/G in world)
			src << "Gravity ([G.Max] x) located at: [G.x?"([G.x],[G.y],[G.z])":"[G.loc]"] ([G.Builder])"*/
	Check_Cloning_Machines()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "[glob_ClonTanks] list is [global.glob_ClonTanks.len] long."
		src << "[glob_ClonTanks] contains: [list2params(global.glob_ClonTanks)]"
		for(var/obj/items/Cloning_Tank/tank as anything in glob_ClonTanks)
			src << "Cloning tank [tank.type] located at: [tank.x],[tank.y],[tank.z] has password [tank.Password]"
	Check_Allow_Rares()
		set category = "Admin Other"
		src << "[AllowRares] list is [global.AllowRares.len] long."
		src << "[AllowRares] contains: [list2params(global.AllowRares)]"
		for(var/atom/I as anything in AllowRares)
			src << "[I] is a [I.type]"
	Show_Muted_List()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "Muted list contains: [list2params(global.MutedList)]"
	Assess_All()
		set category = "Admin"   //<font color="#CCCCCC"><style type="text/css"><!--body {color:#449999;background-color:black;font-size:14;}table {font-size:12;}//--></style><body>
		var/list/Powers=new
		var/Power_Window={"<html><body style="background-color:#212121" text="#80d8FF"><font color=#80d8FF><font size=10>Assess All<hr><table border=1 cellspacing=5 font size=6><font size=6>"}
		for(var/mob/player/A in Players) Powers += A.Base
		for(var/P in Powers)
			var/Lowest_Power=min(Powers)
			for(var/mob/player/A in Players)
				if(Lowest_Power==A.Base) //if(P==A.BP)
					if(A in Power_Window) continue
					var/text = "<td><font color=[A.TextColor]>[A]<font color=#80d8FF> ([A.Race]) [A.Class=="Undefined Class" ? "" : "([A.Class])"]</td> <td>BP: [Commas(A.BP)] ([A.BPMult] Mult)</td> <td>Energy: [Commas(A.BaseMaxKi)] ([A.KiMod])</td> <td>Base:"
					text += " [Commas(min(Powers))] ([A.BPMod] Mod)</td><td>(BP Rank [round(A.BPRank)])</td><td>[round(A.WeightedStats)] Weighted Stats</td><td>(Stat Rank [round(A.StatRank)])</td><tr>"
					Power_Window += text
					Powers-=min(Powers)
		usr << browse(Power_Window,"window=World Assess;size=880x720")
		//log_admin("[key_name(src)] used assess all.")
	Ghost_Form()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.adminDensity)
			usr.adminDensity=0
			usr.density=1
			usr.immortal=0
			usr.invisibility = 0
			usr.icon=usr.last_icon
			usr.client.mob.see_invisible=usr.client.mob.Old_Sight
		//	view(usr) << "([usr.key])[usr] disables their admin ghost form."
			log_admin("[key_name(usr)] exits ghost form.")
		else
			usr.adminDensity=1
			usr.density=0
			usr.immortal=1
			usr.invisibility = 1000
			usr.client.mob.Old_Sight=usr.client.mob.see_invisible
			usr.client.mob.see_invisible=5000
			usr.last_icon=usr.icon
			var/icon/I=new(usr.icon)
			I.Blend(rgb(0,0,0,100),ICON_ADD)
			usr.icon=I
		//	view(usr) << "([usr.key])[usr] activates their admin ghost form."
			log_admin("[key_name(usr)] enters ghost form.")
	Warper()
		set category="Admin"
		//if(!src.client.holder||src.client.holder.level<2) return
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Make a warper here?"))
			var/obj/Warper/A=new(locate(usr.x,usr.y,usr.z))
			if(usr.Confirm("Do you want the warper to set a player's gravity?")) A.giveGravity=1
			A.gotox=input("x location to send to") as num
			A.gotoy=input("y location to send to") as num
			A.gotoz=input("z location to send to") as num
			logAndAlertAdmins("[key_name_admin(src)] created a warper at ([A.x],[A.y],[A.z])",2)
	Create_Magic_Portal()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/obj/Magical_Portal/P in range(4,usr))
			usr << "This is too close to another portal."
			return
		if(usr.Confirm("Make a portal here?"))
			alert(usr,"Choose the X,Y,Z of the location you want to travel to. These portals either last indefinitely or the duration of a timer before they close.")
			var/x = input(usr,"x coordinate") as num
			var/y = input(usr,"y coordinate") as num
			var/z = input(usr,"z coordinate") as num
			var/restricted = list(9,13,16,17)
			if(z in restricted)
				usr << "Unable to teleport to that z coordinate, please choose another!"
				return
			if(usr.z in restricted)
				usr << "Unable to teleport from this z coordinate!"
				return
			var/turf/location = locate(x,y,z)
			for(var/obj/Magical_Portal/P in range(4,location))
				usr << "The destination is too close to another portal."
				return
			var/t = input(usr,"timer in seconds (Default 900, -1 for INF)") as num
			if(t == 0)
				usr << "You need to enter a valid time, either a number in seconds or -1 for an indefinite duration."
				return
			if(t < 0) t = -1
			if(!usr.Confirm("Create portal to [x], [y], [z] for [t] seconds?")) return
			else
				var/obj/Magical_Portal/P = new
				P.tag = "Admin"
				P.timer = (t * 10)
				P.loc = usr.loc
				P.Portal_Number = rand(100000,1000000)
				P.Builder="[usr.real_name]"
				var/turf/T = usr.loc
				if(T) T.Wave(5,100)
				var/obj/Magical_Portal/P2 = new
				P2.tag = "Admin"
				P2.timer = (t * 10)
				P2.loc = locate(x,y,z)
				P2.Portal_Number = P.Portal_Number
				P2.Builder="[usr.real_name]"
				var/turf/T2 = P2.loc
				if(T2) T2.Wave(5,100)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a portal to [x],[y],[z] for [t] seconds.\n")
				alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name_admin(usr)] created a portal to [x],[y],[z] for [t] seconds.", 1)
				return
	Change_Weather()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/weather = input("What weather effect would you like to play?") in list ("Clear","Dark","Fog","Night Snow","Rain","Snow","Storm","Sunrise","Sunset","Namek Rain","Smog","Blood Rain","Dark Blood Rain","Blizzard","Space","Super Darkness","Rising Rocks","Lightning","Rave","Dark Rain","Dark Fog","Dark Blizzard","HeavenLight","HeavenDark","NamekUnderwater","Underwater2","Day Storm","Static","VoidFlash","VoidFlash2","Void","Firestorm","Cancel")
		if(weather=="Cancel") return
		else
			for(var/area/A in range(0,usr))
				if(A)
					if(weather=="Clear")
						A.icon_state=null
					else
						A.icon_state=weather
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changed the weather on [A] (z: [usr.z]) to [weather].\n")
					alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name_admin(usr)] changed the weather on [A] (z: [usr.z]) to [weather].", 1)
					break
			return
	Notes()
		set category="Admin"
		usr<<browse(Notes,"window= ;size=700x600")
	Rank_Chat_Admin(A as text)
		set category="Admin Other"
		var/msg = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
//		log_ooc("RC: ([usr.Rank]) [usr.name]/[usr.key] : [msg]")
		for(var/mob/player/B in Players)
			if(locate(/obj/RankChat) in B)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) Admin: [msg]"
			else if(locate(/obj/RankChat2) in B)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) Admin: [msg]"
			else if(locate(/obj/RankChatECPool) in B)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) Admin: [msg]"
			else if(B.client.holder)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] Admin: [msg]"
	Add_Admin_Note(mob/M in Players)
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		M.mind.show_memory(usr)
/*		var/addedMemory = input("Admin Note for [M]") as message
		if(!usr.Confirm("Save this note?")) return
		addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key])<hr> [addedMemory]<br><hr>"
		M.mind.store_memory(addedMemory)
		log_admin({"<div class="ban">[key_name(usr)] added to [key_name(M)]'s mind.</div>"})
		alertAdmins("[key_name(usr)] added to [key_name(M)]'s mind.")*/
	Announce(var/message as message)
		set category = "Admin"
		set desc="Announce your desires to the world"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!message)	//Lets you do announce "stuff" OR announce -> "bla bla"
			message = input("Global message to send:", "Admin Announce", null, null)  as message
		if (message)
			if(usr.client.holder.rank != "Owner" ) message = adminscrub(message,MAX_MESSAGE_LEN)
			world << "<span class=\"announce\"><b>[usr.client.stealth ? "[usr]" : usr.key] Announces:</b><br>[message]</center></span>"
			log_admin("Announce: [key_name(usr)] : [message]")
	Who_Has()
		set category="Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/C=input("Who...") in list("Too Much XP","Professions","Realm Teleport","How Many","Kill Count","Mutations","XP","Relics","Who EC","Unspent XP","Precog","Sizes","Racial Power","Planets","Space Building","Riches","Offspring","Unlocked","RP Power","Dead","SSj","Milestones","FBM","Capped","God Ki","Transformations","Cancel")
		switch(C)
			if("Realm Teleport")usr.Who_Ignores_Realm_Teleport()
			if("How Many")usr.Who_How_Many()
			if("Mutations")usr.Who_Mutation_Check()
			if("Space Building")usr.Who_Can_Build_In_Space()
			if("Offspring")usr.Who_Offspring()
			if("Unlocked")usr.Who_Unlocked()
			if("RP Power")usr.Who_RPPower()
			if("XP")usr.Who_XP()
			if("Dead")usr.Who_Dead()
			if("SSj")usr.Who_SSJ()
			if("Milestones")usr.Who_Milestones()
			if("FBM")usr.Who_FBM()
			if("Capped")usr.Who_Is_BP_Capped()
			if("God Ki")usr.Who_God_Ki()
			if("Transformations")usr.Who_Transformation()
			if("Racial Power") usr.WhoRacialPower()
			if("Unspent XP") usr.WhoUnspentXP()
			if("Who EC")usr.Who_EC()
			if("Precog") usr.WhoPrecog()
			if("Riches") usr.WhoTooMuchMoney()
			if("Too Much XP") usr.WhoTooMuchXP()
			if("Sizes") usr.Who_Sizes()
			if("Professions") usr.Who_Professions()
			if("Planets") usr.WhoPlanets()
			if("Kill Count") usr.KillCountWho()
			if("Relics") usr.RelicCount()




	Count_Drills()
		set category="Admin Other"
		var/Drills=0
		var/Pylons=0
		for(var/obj/Drill/D in global.DrillList)Drills++
		for(var/obj/Mana_Pylon/P in global.DrillList)Pylons++
		usr<<"There are [Drills] Drills, and [Pylons] Pylons."

	Show_Notes()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		alertAdmins("[key_name(usr)] displayed notes to all admins.</b>")
		for(var/mob/M in Players)
			if(M.client) if(M.client.holder)
				var/html_doc="<head><title>Admin Notes</title></head><body bgcolor=#000000 text=#FFFF00>[Notes]"
				M<<browse(html_doc,"window=Admin Notes")
/*	AdminLogs()
		set category="Admin"
		set name="Admin Logs"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		//usr<<browse(file("AdminLog.log"))
		usr << ftp("AdminLog.log")*/
	FRename(atom/A in world)
		set category = "Admin"
		set name = "Force Rename"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/newname = copytext(sanitize(input("Renaming [A]",A.name)), 1, MAX_NAME_LENGTH)
		if(!newname) return
		else
			log_admin("[key_name(usr)] changed [key_name(A)]'s name to [newname]")
			alertAdmins("[key_name(usr)] changed [key_name(A)]'s name to [newname]")
			A.name = newname
			if(ismob(A))
				var/mob/B = A
				B.real_name = newname


	Locate_Ships()
		set category = "Admin"
		if(!usr.client.holder||usr.client.holder.level<1) return
		var/count
		for(var/obj/AndroidShip/A in world)
			src << "AndroidShip found at ([A.x],[A.y],[A.z])"
			count++
		if(count>=2)
			src<<"Found more then one AndroidShip, deleting duplicate."
			SpawnAndroidShip()
			src << "Done."
		if(count<=0)
			src<< "Found NO AndroidShip."
			if(usr.Confirm("Spawn a new Android Ship?")) SpawnAndroidShip()
			src << "Done."
		for(var/obj/Ships/Ship/Ardent/A in world) src << "Ardent found at ([A.x],[A.y],[A.z])"
		for(var/obj/Ships/Ship/Icebreaker/A in world) src << "Icebreaker found at ([A.x],[A.y],[A.z])"

	Multikey_Check(var/mob/M in world)
		set category="Admin"
		if(!usr.client.holder||usr.client.holder.level<1) return
		for(var/mob/player/A in world) if(A.client) if(A.ckey!="blackclaw185"&&A.ckey!="saizetsu")//for(var/mob/player/AA in world)
			if(A == M) continue
			if(A.client&&((M.client.address==A.client.address)&&(M.client.computer_id==A.client.computer_id)))
				src<<"<font size=1 color=\"red\">   Multikey: [M] ([M.key]) (Same Computer)</font>"
				src<<"<font size=1 color=\"red\">   Multikey: [A] ([A.key]) (Same Computer)</font>"
			if(A.client&&((M.client.address==A.client.address)&&(M.client.computer_id!=A.client.computer_id)))
				src<<"<font size=1 color=\"#FF8040\">   Multikey: [M] ([M.key]) (Same Network)</font>"
				src<<"<font size=1 color=\"#FF8040\">   Multikey: [A] ([A.key]) (Same Network)</font>"

	Assess(mob/M in Players)
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr.Get_Assess(M)

