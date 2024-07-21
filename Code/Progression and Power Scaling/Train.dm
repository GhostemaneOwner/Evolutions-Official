



mob/proc/Heal_Zenkai()
	if(ZenkaiPower<Base*0.5)
		var/Amount=1
		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))**2
		if(Amount>10) Amount=10
		var/increase=Amount*100*Zenkai*Regeneration*(1+Senzu)
		BaseGain(increase,1)
	if(Race=="Saiyan")
		var/Amount=1
		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))
		if(Amount>10) Amount=10
		var/Multiplier=1
		if(KOd) Multiplier=10
		var/increase=Amount*5*Multiplier*Zenkai*Regeneration*(1+Senzu)
		BaseGain(increase,1)

mob/proc/Zenkai()
	if(ZenkaiPower<Base*0.8)
		var/Amount=1
		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))
		if(Amount>10) Amount=10
		var/Multiplier=1
		if(KOd) Multiplier=10
		var/increase=Amount*10*Multiplier*Zenkai*Regeneration*(1+Senzu)
		BaseGain(increase,1)
	if(Race=="Saiyan")
		var/Amount=1
		if(ZenkaiPower) Amount=(Base/(ZenkaiPower*5))
		if(Amount>10) Amount=10
		var/Multiplier=1
		if(KOd) Multiplier=10
		var/increase=Amount*1*Multiplier*Zenkai*Regeneration*(1+Senzu)
		BaseGain(increase,1)



mob/proc/Death_Zenkai() if(!Dead)
	BaseGain(10000*Zenkai,1)

mob/proc/BPCatchUp()
	var/Mult=1
	if(HasUsedBookOfLessons+1>=WipeDay) Mult+=5
	else if(HasFoodBPTrain) Mult+=0.25
	if(BPRank>=70) Mult++
	if(BPRank>=50) Mult++
	if(WipeDay>14)
		if(BPRank>=70) Mult++
		if(BPRank>=40) Mult++
	if(WipeDay>32)
		if(BPRank>=70) Mult+=0.5
		if(BPRank>=40) Mult+=0.5
	if(VillainTrain) Mult=0.001
	return Mult

mob/var/HTFGain=1

mob/proc/HungerThirstFatigue()
	var/HTF = ((src.Hunger + src.Thirst + src.Fatigue)/3)
	if (src.Race == "Namekian")
		HTF = ((src.Thirst + src.Fatigue)/2)
	if(HTF <= 25) HTFGain = 1.5
	else if(HTF > 25 && HTF <= 50) HTFGain = 1.25
	else if(HTF > 50 && HTF <= 75) HTFGain = 1
	else if(HTF > 75) HTFGain = 0.75
	else if(HTF == 100) HTFGain = 0.5
	return HTFGain

mob/proc/CatchUp()
	var/Mult=1
	if(WipeDay>14)//When the beginning of Catchups Apply
		if(StatRank>=40) Mult++
		if(StatRank>=60) Mult++
		if(StatRank>=80) Mult++
		if(WeightedStats<SoftStatCap*4.5) Mult+=0.5
	if(WipeDay>32)
		if(StatRank>=70) Mult+=0.25
		if(StatRank>=40) Mult+=0.25
	if(HasUsedBookOfLessons+1>=WipeDay) Mult+=5
	else if(HasFoodStatsTrain) Mult+=0.25
	if(HasVitamins) Mult+=0.1
	if(z==11||z==10) Mult+=0.25
	if(WeightedStats<SoftStatCap*3.5) Mult++
	if(WeightedStats<SoftStatCap*2.5) Mult*=1.25
	if(WeightedStats<SoftStatCap*1.5) Mult*=1.5
	if(WeightedStats>SoftStatCap*6.0) Mult*=0.7
	if(WeightedStats>SoftStatCap*6.6) Mult*=0.7
	if(WeightedStats>SoftStatCap*7.2) Mult*=0.7
	if(WeightedStats>SoftStatCap*7.8) Mult=0
	if(VillainTrain) Mult=0.001
	return Mult

mob/proc/StatCapCheck(Stat)
	var/returner=1
	if(RestedTime>world.realtime)returner+=0.25
	if(InspiredTime>world.realtime)returner+=0.5
	if(Stat>=SoftStatCap)
		returner*=1 // 1
		if(Stat>SoftStatCap*1.1)
			returner*=0.4 //0.4
			if(Stat>SoftStatCap*1.2)
				returner*=0.2 //0.08
				if(Stat>SoftStatCap*1.3)
					returner*=0.1
					if(Stat>SoftStatCap*1.4)
						returner*=0.05
						if(Stat>SoftStatCap*1.5)
							returner*=0.025
							if(Stat>SoftStatCap*1.6)
								returner*=0.0001
	else if(Stat<=SoftStatCap*1) returner*=1.5
	if(VillainTrain) returner=0.0001
	return returner
/*
mob/proc/EnergyCapCheck(Stat)
	var/returner=1
	if(RoleplayRewards>Year) returner+=0.25
	if(RestedTime>world.realtime)returner+=0.25
	if(HasUsedBookOfLessons+1>=Year) returner+=2.5
	else if(HasFoodEnergyTrain) returner+=0.5
	if(Stat>=EnergySoftCap)
		returner*=0.75
		if(Stat>EnergySoftCap*1.1)
			returner*=0.75
			if(Stat>EnergySoftCap*1.2)
				returner*=0.75
				if(Stat>EnergySoftCap*1.3)
					returner*=0.1
	else if(Stat<=EnergySoftCap*0.5) returner*=1.8
	if(VillainTrain) returner=0.001
	return returner*/

mob/proc/IntCapCheck(Stat,Limit)
	var/returner=1
	if(HasMethyl) returner+=0.25
	if(InspiredTime>world.realtime) returner+=0.5
	if(RestedTime>world.realtime)returner+=0.25
	if(Stat>=(TechCap*0.8)+Limit)
		returner*=0.9
		if(Stat>=(TechCap*0.9)+Limit)
			returner*=0.9
			if(Stat>=TechCap+Limit)
				returner*=0.5
				if(Stat>=(TechCap*1.1)+Limit)
					returner*=0.25
					if(Stat>=(TechCap*1.2)+Limit)
						returner*=0.1
						if(Stat>=(TechCap*1.3)+Limit)
							returner*=0.01
							if(Stat>=(TechCap*1.4)+Limit)
								returner*=0.0001
								if(Stat>=(TechCap*1.5)+Limit)
									returner*=0
	return returner

mob/proc/BPCapCheck()
	var/returner=1
	if(z==11||z==10) returner+=0.25 //These Z planes have a higher BP Cap now
	if(RestedTime>world.realtime)returner+=0.25
	if(InspiredTime>world.realtime)returner+=0.5
	if(LethalCombatTracker>2000)returner+=0.2
	if(Base/BPMod>=TrueBPCap*0.8) returner*=0.7
	if(Base/BPMod>=TrueBPCap*0.9) returner*=0.7
	if(Base/BPMod>=TrueBPCap) returner*=0.5
	if(Base/BPMod>=TrueBPCap*1.1) returner*=0.25
	if(Base/BPMod>=TrueBPCap*1.2) returner*=0.125
	if(Base/BPMod>=TrueBPCap*1.3) returner*=0.05
	if(Base/BPMod>=TrueBPCap*1.4) returner*=0.025
	if(Base/BPMod>=TrueBPCap*1.5) returner*=0.0125
	if(Base/BPMod>=TrueBPCap*1.6) returner*=0.001
	if(VillainTrain) returner=0.001
	return returner

mob/proc/IntCatchUp()
	var/returner=1
	if(z==11||z==10) returner+=0.25
	if(Int_Mod<=2) return returner
	if(Int_Level<TechCap*0.7) returner*=1.1
	else if(Int_Level<TechCap*0.5) returner*=1.2
	else if(Int_Level<TechCap*0.3) returner*=1.3
	else if(Int_Level<TechCap*0.1) returner*=1.4
	return returner


mob/proc/MagicCatchUp()
	var/returner=1
	if(z==11||z==10) returner+=0.25
	if(Magic_Potential<=2) return returner
	if(Magic_Level<TechCap*0.7) returner*=1.1
	else if(Magic_Level<TechCap*0.5) returner*=1.2
	else if(Magic_Level<TechCap*0.3) returner*=1.3
	else if(Magic_Level<TechCap*0.1) returner*=1.4
	return returner



mob/proc/Increase_GainMultiplier(Amount=1)
	if(RestedTime>world.realtime)Amount+=0.5
	if(HasExponentialGrowth) Amount*=1+(HasExponentialGrowth*0.15)
	GainMultiplier+=0.005*Amount*GainMultRate*Weight//

mob/proc/Attack_Gain()
	set waitfor=0
	ASSERT(src)
	if(!src) return
	if(src.Opp)if(ismob(src.Opp))
		var/mob/M = src.Opp
		if(M.Opp) if(M.Opp != src)
			return // (This fix was broken, so I re-fixed the fix. - Ginseng)If their Opponent is a player, but that player's opponent isn't them (i.e. reverse sparring) then they don't gain shit.
	var/BP_Gain=2
//	EZ++
//	EZCheck()
	if(BPRank>65) BP_Gain*=2
	if(ismob(Opp)) if(Opp.FBMAchieved&&!FBMAchieved) BP_Gain*=2
	if(BPRank>40&&Year>20) BP_Gain*=1.25
	if(istype(Opp,/mob/player)) if(prob(70)) if(Opp.client)
		if(Opp.HasSSj||Opp.HasBojack||Opp.HasAlienTrans) SparSSj++
		if(Opp.FBMAchieved) SparAscended++
		if(Opp.MaxGodKi&&Opp.GodKiActive) SparGodKi++
		if(prob(SparSSj/100)||prob(SparAscended/5)) if(Opp.HasSSj||Opp.HasAlienTrans||Opp.HasBojack||Opp.FBMAchieved) if(Race=="Alien"||Race=="Kanassan"||Race=="Half-Alien") if(!HasAlienTrans)
			if(Base/BPMod>=Tier1Req)
				HasAlienTrans=1
				usr<<"Fighting with [Opp] is beginning to pay off, you can feel your body growing accustomed to their level of power and you can feel a surge of energy deep within you. (Transformation Unlocked)"
				logAndAlertAdmins("[src] unlocked Alien Trans fighting with [Opp]",1)
		if(prob(SparSSj/1000))
			if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan") if(Opp.HasSSj&&!HasSSj) if(Base/BPMod>=SSjAt)
				HasSSj=1
				usr<<"Fighting with [Opp] is beginning to pay off, you can feel your body growing accustomed to their level of power and you can feel a surge of energy deep within you. (SSj Unlocked)"
				logAndAlertAdmins("[src] unlocked SSj fighting with [Opp]",1)
			if(Race=="Heran"||Race=="Half-Heran") if(Opp.HasSSj&&!HasBojack||Opp.HasBojack&&!HasBojack) if(Base/BPMod>=SSjAt)
				HasBojack=1
				usr<<"Fighting with [Opp] is beginning to pay off, you can feel your body growing accustomed to their level of power and you can feel a surge of energy deep within you. (Bojack Unlocked)"
				logAndAlertAdmins("[src] unlocked Bojack fighting with [Opp]",1)
		if(prob(SparAscended/2000)&&Opp.FBMAchieved)
			if(HasSSj==1&&Base/BPMod>=Tier2Req&&SSjDrain>=300)
				HasSSj=2
				usr<<"Fighting with [Opp] is pushing your body to its absolute limits. You have awakened the ability to tap into a power even greater than Super Saiyan! (SSj 2 Unlocked)"
				logAndAlertAdmins("[src] unlocked SSj 2 fighting with [Opp]",1)
			if(HasBojack==1&&Base/BPMod>=Tier2Req&&SSjDrain>=300)
				HasBojack=2
				usr<<"Fighting with [Opp] is pushing your body to its absolute limits. You have awakened the ability to tap into a power even greater than Bojack! (Super Bojack Unlocked)"
				logAndAlertAdmins("[src] unlocked Super Bojack fighting with [Opp]",1)
		if(prob(SparAscended/6000)&&Opp.FBMAchieved==2)
			if(HasSSj==2&&Base/BPMod>=Tier3Req&&SSj2Drain>=300)
				HasSSj=3
				usr<<"Fighting with [Opp] is pushing your body to its absolute limits. You have awakened the ability to tap into a power even further beyond a Super Saiyan! (SSj 3 Unlocked)"
				logAndAlertAdmins("[src] unlocked SSj 3 fighting with [Opp]",1)
		if(Global_GodKi) if(Opp.GodKi>=1&&!MaxGodKi) if(prob(SparGodKi/200)||SparGodKi>1500) if(Opp.GodKiActive)
			usr<<"Fighting with [Opp] is beginning to pay off. You feel a tingling sensation within your gut as you tap into their otherwordly power... (God Ki Unlocked)"
			logAndAlertAdmins("[src] unlocked God Ki fighting with [Opp]",1)
			MaxGodKi=1
			for(var/mob/player/M in view(15,src)) M<<'Carl_Orff_35_SEC.wav'
			if(!locate(/obj/God_Ki) in usr) contents+=new/obj/God_Ki
		if(src)
			if(Opp.GainMultiplier>GainMultiplier) Increase_GainMultiplier(2)
			if(Opp.GainMultiplier*0.9>GainMultiplier) if(prob(35))
				if(prob(10)) src<<"You are learning from [Opp]'s experience and skill in combat. (Inspired)"
				src.InspiredTime=world.realtime+10000
				GainMultiplier+=Opp.GainMultiplier*0.05
				if(DEBUGMATH) src<<"Gain Mult + [Opp.GainMultiplier*0.05] (Gain Mult Leech)"
				if(GainMultiplier>Opp.GainMultiplier*0.9) GainMultiplier=Opp.GainMultiplier*0.9
			if(Opp.Base/Opp.BPMod>Base/BPMod) if(!Opp.VillainTrain&&!VillainTrain)
				BP_Gain*=1.75
				var/Go=1
				//if(Opp.Race=="Android") if(Race!="Android") Go=0
				if(Go) if(!Lethality&&!Opp.Lethality) if((Opp.Base/Opp.BPMod)*0.7>Base/BPMod) if(prob(40))
					var/BG=(Opp.Base/Opp.BPMod)*0.003
					if(BG>Base*0.005) BG=Base*0.005
					BaseGain(BG)
					if(DEBUGMATH) src<<"Base + [BG] (Base Leeching) ([(Opp.Base/Opp.BPMod)*0.7] Leechable BP)"
	if(SwordOn||HammerOn) PassiveSkillsIncrease(0,0.5,0,0.25)//ki,sword,unarmed,evasion
	else if(KiBlade||KiHammer||SpiritSword||KiBow) PassiveSkillsIncrease(0.5,0,0,0.25)//ki,sword,unarmed,evasion
	else if(KiFists) PassiveSkillsIncrease(0.25,0,0.25,0.25)//ki,sword,unarmed,evasion
	else PassiveSkillsIncrease(0,0,0.5,0.25)//ki,sword,unarmed,evasion

	if(src.Opp)if(ismob(src.Opp))
		var/mob/M = src.Opp
		if(M.EvasionTeaches&&Athleticism<M.Athleticism*0.7) PassiveSkillsIncrease(0,0,0,0.005*M.Athleticism)//ki,sword,unarmed,evasion
		if(M.WeaponTeaches&&SwordSkill<M.SwordSkill*0.7)  PassiveSkillsIncrease(0,0.005*M.SwordSkill,0,0)//ki,sword,unarmed,evasion
		if(M.UnarmedTeaches&&UnarmedSkill<M.UnarmedSkill*0.7) PassiveSkillsIncrease(0,0,0.005*M.UnarmedSkill,0)//ki,sword,unarmed,evasion
		if(M.KiManipTeaches&&KiManipulation<M.KiManipulation*0.7) PassiveSkillsIncrease(0.005*M.KiManipulation,0,0,0)//ki,sword,unarmed,evasion
//Passive Skills Gains Adjustements Above - SR Team

	if(Opp) Increase_GainMultiplier(3)
	if(Gravity>=GravMastered) if(prob(5)) src.Gravity_Gain()
//	StatRank()
	var/N = 20 * GravMulti
	if(Spar) N= 30 * GravMulti
	var/TrainingInc=1
	if(HasPracticalLearner) TrainingInc=1+(HasPracticalLearner*0.33)
	N*=TrainingInc
	var/PBAG=1
	if(Opp) if(Opp.P_BagG) PBAG=Opp.P_BagG
	if(PBAG<2) if(StatRank<50) PBAG=2
	if(ismob(Opp)) for(var/obj/Contact/CC in Opp) if(CC.Signature==Signature) if(CC.relation=="Disciple(+)")
		N+=5
		PBAG+=3
	if(ismob(Opp)) for(var/obj/Contact/CC in Opp) if(CC.Signature==Signature) if(CC.relation=="Rival")
		PBAG+=3
		N+=5
	Zanzoken+=0.06*ZanzoMod
	if(prob(0.01*(BaseRegeneration+BaseRecovery))) Decline+=0.1
	BaseGain(N)
	StatGains(Rate=PBAG*TrainingInc,Energy=1,Might=0.25,Endurance=0.25,Speed=1,Offense=1,Defense=1)
//PBAG Gains Adjustments - 

mob/proc/Flying_Gain()
	var/FMMult=0.1
	if(HasFlightMaster) FMMult=0.15
	BaseGain(FMMult)
	StatGains(Rate=1,Energy=1,Might=0,Endurance=0,Speed=1,Offense=0,Defense=0)
	if(prob(50)) Increase_GainMultiplier(1+HasFlightMaster)


mob/proc/Blast_Gain()
	BaseGain(0.5) //Base Gain for Blasting/Beams - SR Team
	StatGains(Rate=1,Energy=1,Might=0,Endurance=0,Speed=0,Offense=0,Defense=0)
	PassiveSkillsIncrease(0.1,0,0,0)//ki,sword,unarmed,evasion





