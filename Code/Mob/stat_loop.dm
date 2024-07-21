mob/proc/Regenerate()
	loc=locate(335,135,9)
	for(var/BodyPart/P in src) Injure_Heal(200,P,1)
	spawn(3000/Regenerate) if(src)
		loc=locate(savedX,savedY,savedZ)
		for(var/mob/A in view(src)) if(A.name=="Body of [src]") del(A)
		if(Race=="Alien"||"Majin") Willpower=50
		else Willpower=70
		LethalCombatTracker=0
		src<<"[src] regenerates back to life!"
		Regenerating=0
		TotalDeaths--
		Regenerate=max(0,Regenerate-0.5)
		flick("Regenerate",src)
		if(Race=="Bio-Android")
			if(Perfect_Form==1&&MaxGodKi&&!(locate(/Skill/Buff/Super_Perfect_Form) in src))
				contents+=new/Skill/Buff/Super_Perfect_Form
				src<<"You have utterly shattered your limitations. Due to your extreme training and high levels of power, you have awakened another evolution...."
				alertAdmins("[src] has unlocked Super Perfect Form")





mob/proc/IsInSpace()
	var/turf/Turf=loc
	if(istype(Turf,/turf/Other/Stars)&&!BreathInSpace) if(src.z==12&&!Dead) if(istype(Turf,/turf/Other/Stars)) return 1
	else return 0




mob/proc/Experience_Transferrence() if(!afk)
	for(var/mob/player/A in oview(src)) if(GainMultiplier<A.GainMultiplier*0.4) if(A.Opp)
		GainMultiplier+=A.GainMultiplier*0.05
		src<<"[A]'s dedication to training and power has inspired you to work harder. (Inspired)"
		src.InspiredTime=world.realtime+10000


mob/proc/Steroid_Wearoff() while(src&&(client||adminObserve))
	if(RoidPower)
		RoidPower*=0.99
		if(RoidPower<=Base*0.1) RoidPower=0
	else break
	sleep(1200)


mob/proc/Bind_Return() while(src&&(BindPower))
	set background=1
	if(z!=11&&BindPower)
		//if(src.insidePhylactery == null) if(src.insideTank == null)
		if(isGrabbing)
			GrabRelease()
		src<<"The bind on you takes effect and you are returned to the afterlife."
		loc=locate(175, 80, 11)
	if(!BindPower) break
	sleep(1200)

mob/proc/Power_Giving_Reset()// while(src&&(client||adminObserve))
	if(GavePower)
		sleep(9000)
		GavePower=0
	//else break




mob/var/LethalCombatTracker=0

mob/proc/Drains()
//	src<<"You have energydraining [energydraining], transenergydraining [transenergydraining] and healthdraining [healthdraining]"
	if(energydraining<0)energydraining=0
	if(transenergydraining<0)transenergydraining=0
	if(staticenergydraining<0)staticenergydraining=0
	if(transstaticenergydraining<0)transstaticenergydraining=0
	if(staticenergydraining+transstaticenergydraining>0) DrainKi("Static Drains",1,staticenergydraining+transstaticenergydraining)
	if(energydraining+transenergydraining>0) DrainKi("Drains", "Percent", energydraining+transenergydraining)
	if(healthdraining) TakeDamage(src, healthdraining, "Drains")
	if(Ki<=10) RevertDrains()
	if(GodKiActive) DrainGodKi()



mob/proc/Healing() if(!Dead||(Dead&&!Check_Dead_Location())) if(!RPMode)
	if(BindPower&&!CheckBind()) return
	if(Willpower<MaxWillpower*0.7)spawn() Zenkai()
	if(KOd==0)

		if(src)if(!DisableRegen) //if(!OverdrivePower)
		/*	var/HH=0.07*Regeneration*(3+Senzu+(HealthPotion/3))*(MaxHealth/100)
			var/LH=0.002*Regeneration*(25+Senzu+(HealthPotion/3))*(HasWillOfFire+1)
			if(locate(/obj/items/Philosophers_Stone) in src)
				HH=0.07*(Regeneration+0.5)*(3+Senzu+(HealthPotion/3))*(MaxHealth/100)
				LH=0.002*(Regeneration+0.5)*(25+Senzu+(HealthPotion/3))*(HasWillOfFire+1)
			var/WH=1
			if(HasFoodRegen)
				if(HasHyperEnzymes>0) HH*=1.25
				else HH*=1.1
			if(HasFoodWP) WH*=1.1
			if(HasCialis) HH*=0.7
			if(TicksOfReplenish) WH=4
			if(locate(/Skill/Buff/Majin) in src) HH+=0.1
			if(locate(/obj/items/Medicine_Cabinet) in oview(2,src))
				LH*=1.5
				HH*=1.5
			if(icon_state=="Meditate")
				LH*=1.5
				HH*=3
			if(icon_state == "Train")
				LH*=0.2
				HH*=0.2
			if(GodKiActive)
				LH*=1.3
				HH*=1.3
			if(Vampire)HH*=0.8
			if(Werewolf)HH*=0.8
			HH*=AbsorbReduction*/
			var/WH=1//willpower regen mod
			if(HasFoodWP) WH=1.1
			if(TicksOfReplenish) WH=4
			if((Health/MaxHealth)<(Willpower/MaxWillpower))
				Health+=HPTick
				if(LethalCombatTracker) //if(Race!="Android")
					var/HDiv=1
					if(Health/MaxHealth<0.7)HDiv=1.3
					if(Health/MaxHealth<0.5)HDiv=1.6
					if(Health/MaxHealth<0.3)HDiv=1.9
					if(Health/MaxHealth<0.1)HDiv=2.2
					if(GodKiActive) HDiv=0.5
					if(HasMorphine) Willpower-=HDiv*(0.1125/(HasWillOfFire+1))
					else Willpower-=HDiv*(0.075/(HasWillOfFire+1))
				if((Health/MaxHealth)>(Willpower/MaxWillpower)) Health=(Willpower/MaxWillpower)*MaxHealth
				if(Willpower<0) Willpower=0
			if(!LethalCombatTracker) for(var/BodyPart/P in src) if(P.Health<=P.MaxHealth)
				Injure_Heal(HPTick*0.1,P)
				if(P.CanRegen) if(prob(Regenerate)) P.InjuryHealed(src)
			if(!LethalCombatTracker) if(Willpower<MaxWillpower&&Willpower>0)
				Willpower+=HPTick*0.01*WH
				if(Willpower>MaxWillpower) Willpower=MaxWillpower
			if(Willpower<0) Willpower=0
			if(Willpower>MaxWillpower) Willpower=MaxWillpower

		if(src)
		/*	var/DBMult=1
			DBMult+=HasDeepBreathing*0.125
			var/KMult=1
			KMult=100/BPpcnt
			if(KMult>2) KMult=2
			if(KMult<0.5) KMult=0.5
			if(ChakraBlocked) KMult*=0
			if(HasFoodRecov)
				if(HasHyperEnzymes>0) KMult*=1.25
				else KMult*=1.1
			if(HasPercocet) KMult*=0.6
			if(KiDoesNotAffectBP==2) KMult*=0.7
			if(RecentSendEnergy) KMult*=0.5
//			if(transenergydraining) KMult*=transenergydraining
			if(GodKiActive) KMult*=1.5
			if(StanceCore==5) KMult*=1.5
			if(Race=="Spirit Doll") KMult=1.5
			if(HasControlOfPower) KMult*=1.5
			KMult*=DBMult
			KMult*=AbsorbReduction
			if(IsInSpace()) KMult*=0*/
			if(CurrentAction!="Training"&&Ki<MaxKi)
				Ki+=KiTick//0.005*MaxKi*Recovery*(1+Senzu)*KMult
				if(Ki>MaxKi) Ki=MaxKi
			if(Senzu)
				Senzu-=0.05
				if(Senzu<0)Senzu=0
			if(HealthPotion)
				HealthPotion-=0.05
				if(HealthPotion<0)HealthPotion=0


mob/proc/Available_Power()
	if(BPpcnt<0.01) BPpcnt=0.01
	if(Ki<0) Ki=0
	if(AndroidLevel<0) AndroidLevel=0
	if(Gravity<=10+GravMastered&&Health<0) Health=0
	if(RPPower<1) RPPower=1
	Body()
	var/RawHP=Health/MaxHealth
	var/Health_Multiplier=RawHP
	if(RawHP>0.9&&RawHP<=0.95) Health_Multiplier=0.95
	if(RawHP>0.85&&RawHP<=0.9) Health_Multiplier=0.90
	if(RawHP>0.8&&RawHP<=0.85) Health_Multiplier=0.85
	if(RawHP>0.75&&RawHP<=0.8) Health_Multiplier=0.80
	if(RawHP>0.7&&RawHP<=0.75) Health_Multiplier=0.75
	if(RawHP>0.65&&RawHP<=0.7) Health_Multiplier=0.70
	if(RawHP>0.60&&RawHP<=0.65) Health_Multiplier=0.65
	if(RawHP>0.55&&RawHP<=0.60) Health_Multiplier=0.60
	if(RawHP>0.50&&RawHP<=0.55) Health_Multiplier=0.55
	if(RawHP>0.45&&RawHP<=0.50) Health_Multiplier=0.50
	if(RawHP>0.40&&RawHP<=0.45) Health_Multiplier=0.45
	if(RawHP>0.35&&RawHP<=0.40) Health_Multiplier=0.40
	if(RawHP>0.30&&RawHP<=0.35) Health_Multiplier=0.35
	if(RawHP<=0.30) Health_Multiplier=0.30
	if(!AndroidLevel) Health_Multiplier=max(0.3,Health_Multiplier)
	else Health_Multiplier=max(0.5,Health_Multiplier)


	if(HPDoesNotAffectBP||HasPercocet||Vampire||HasAsLongAsMyHeartBeats||Werewolf)
		if(RawHP>0.9&&RawHP<0.97) Health_Multiplier=0.97
		if(RawHP>0.8&&RawHP<=0.9) Health_Multiplier=0.95
		if(RawHP>0.7&&RawHP<=0.8) Health_Multiplier=0.92
		if(RawHP>0.6&&RawHP<=0.7) Health_Multiplier=0.90
		if(RawHP>0.5&&RawHP<=0.6) Health_Multiplier=0.87
		if(RawHP>0.4&&RawHP<=0.5) Health_Multiplier=0.85
		if(RawHP>0.3&&RawHP<=0.4) Health_Multiplier=0.82
		if(RawHP>0.2&&RawHP<=0.3) Health_Multiplier=0.80
		if(RawHP>0.1&&RawHP<=0.2) Health_Multiplier=0.77
		Health_Multiplier=max(0.75,Health_Multiplier)

	if(Anger_Restoration) Health_Multiplier=1
	if(KOd)  Health_Multiplier=1

	var/RawKi=Ki/MaxKi


	if(Ki/MaxKi>9.99) RawKi=9.99
	else if(Ki/MaxKi>0.95&&Ki/MaxKi<1) RawKi=1
	else if(Ki/MaxKi>0.9) RawKi=0.98
	else if(Ki/MaxKi>0.85) RawKi=0.93
	else if(Ki/MaxKi>0.80) RawKi=0.84
	else if(Ki/MaxKi<=0.8) RawKi=RawKi**1.3 //starts aroun 75% caps around 18%

	var/Energy_Multiplier=max(0.1,RawKi)

	RawKi=Ki/MaxKi
	if(KiDoesNotAffectBP) if(Race!="Android")
		if(RawKi>0.9&&RawKi<1) RawKi=0.99
		if(RawKi>0.8&&RawKi<=0.9) RawKi=0.96
		if(RawKi>0.7&&RawKi<=0.8) RawKi=0.93
		if(RawKi>0.6&&RawKi<=0.7) RawKi=0.90
		if(RawKi>0.5&&RawKi<=0.6) RawKi=0.87
		if(RawKi>0.4&&RawKi<=0.5) RawKi=0.84
		if(RawKi>0.3&&RawKi<=0.4) RawKi=0.81
		if(RawKi>0.2&&RawKi<=0.3) RawKi=0.78
		if(RawKi>0.1&&RawKi<=0.2) RawKi=0.75
		Energy_Multiplier=max(0.7,RawKi)
	if(Race=="Android") //Energy_Multiplier=1
		if(RawKi>0.9&&RawKi<0.99) RawKi=0.98
		if(RawKi>0.8&&RawKi<=0.9) RawKi=0.96
		if(RawKi>0.7&&RawKi<=0.8) RawKi=0.94
		if(RawKi>0.6&&RawKi<=0.7) RawKi=0.92
		if(RawKi>0.5&&RawKi<=0.6) RawKi=0.90
		if(RawKi>0.4&&RawKi<=0.5) RawKi=0.88
		if(RawKi>0.3&&RawKi<=0.4) RawKi=0.86
		if(RawKi>0.2&&RawKi<=0.3) RawKi=0.84
		if(RawKi>0.1&&RawKi<=0.2) RawKi=0.82
		Energy_Multiplier=max(0.8,RawKi)
	var/Gravity_Multiplier=min(2.5,1+((GravMastered/25)/25))
	//if(Race=="Android")
	var/RPMults=RPPower*BPMult
	var/AngerM=(Anger/100)
	if(AngerM<1)AngerM=1
	var/BodyMults=Energy_Multiplier*Health_Multiplier*AngerM/Weight
	if(RacialPowerAdd<0) RacialPowerAdd=0
	BP=(RacialPowerAdd+Base)*Body*Gravity_Multiplier*(BPpcnt/100)*RPMults*BodyMults
	BP+=RoidPower*BodyMults*RPMults*Body
	BP+=Absorb*(BPpcnt/100)*RPMults*BodyMults*Body
	if(HBTCPower>0) BP+=HBTCPower*(Base/12)*RPMults*BodyMults*Body
	if(BlackWaterPower>0) BP+=BlackWaterPower*(Base*0.11)*RPMults*BodyMults*Body
	BP+=(BP*(Modules*0.015))//Each module is 1.5% BP
	//if(AndroidLevel&&Race!="Android") BP+=(BP*(AndroidLevel*0.0005))//Each AndroidLevel is 0.2% BP for androids
	if(AndroidLevel&&Race=="Android") BP+=(BP*(AndroidLevel*0.0025))//Each AndroidLevel is 0.22% BP for androids
	BP+=(BP*(Fusions*0.03))//Each Fusion is 3% BP
	BP+=RPPowerAdd*Body
//	if(AlignmentNumber<-2) BP*=1.025
//	if(AlignmentNumber<-5) BP*=1.05
	if(HasMagicMiles)
		if(HasRitualOfPower&&HasRitualOfPower+5>=WipeDay) BP*=(1-(HasMagicMiles*0.01))
		else BP*=(1-(HasMagicMiles*0.05))
	if(HasIntMiles&&!AndroidLevel)BP*=(1-(HasIntMiles*0.075))
	if(BeenCloned>=2) BP*=(1-((BeenCloned-1)*0.075))
	//if(Race=="Makyojin") if(HadStarBoost<2) BP*=(1-(0.05*(2-HadStarBoost)))

	if(locate(/obj/items/Mark_Of_The_Beast) in src) BP*=1.05
	if(locate(/obj/items/Ring_Of_Power) in src) BP*=1.1
	if(BP<1) BP=1
mob/var/SeanceYear=0
mob/var/tmp/GoingHome=0
mob/proc/Dead_In_Living_World()
	set waitfor =0
	if(!GoingHome)
		if(Dead&&Check_Dead_Location())
			if(src)
	//			Ki=0
				src<<"You have exhausted all your time in the living realm, you will return to the afterlife in 1 minute."
				GoingHome=1
				spawn(600) if(src&&src.Dead)
					view(src)<<"[src] is returned to the afterlife."
					loc=locate(DEADX,DEADY,DEADZ)
					SeanceYear=0
					GoingHome=0
					KeepsBody=0

mob/proc/Check_Dead_Location()
	var/turf/t = locate(src.x, src.y, src.z) // Locate returns a turf.
	if(!t) return
	if((z in list(1,2,3,4,5,6,7,8,12,14,15,17)) ) return TRUE
	else return FALSE


mob/proc/CheckBind()
	var/turf/t = locate(src.x, src.y, src.z) // Locate returns a turf.
	if(!t) return
	if(z==11) return TRUE
	else return FALSE
	