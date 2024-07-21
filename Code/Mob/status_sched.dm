


//mob/var/InvisibleOn=0
mob/proc/Invisibility_Check() if(invisibility>0)
	for(var/Skill/Support/Invisibility/A in src) if(A.Using) A.Using=0
	invisibility = 0
	see_invisible = 0
	winset(client,"INVIS","is-visible=false")




mob/var
	LogTime=0
	RestedTime=0
	InspiredTime=0
//Stat Loop Finder
mob/var
	ManaCycle=0
	ResourceCycle=0
	BindPower=0
mob/var/tmp/DoNotUnfreeze=0




mob/proc/Status()
	set background=1
	set waitfor=0
	ASSERT(src)  // null bug check  May not be needed/may interrupt stat proc
	spawn if(src) Steroid_Wearoff()
	spawn if(src) Power_Giving_Reset()
	spawn if(src) if(Regenerating) Regenerate()
	spawn if(src) Invisibility_Check()
	spawn if(src) InventoryCheck()
	spawn if(src) LowResourceHTFUpdate()
	while(src&&(client||adminObserve||TestChar))

		if(src.afk) if(src.client.inactivity <= 90) if(src.client.inactivity >= 0) if(src.Went_Afk == 0) src.TRIGGER_AFK()
		if(src.client.inactivity>=afk_time) if(!src.afk) src.TRIGGER_AFK(1)
		if(src.client) if(src.see_invisible>=src.invisibility&&!src.client.holder) src.see_invisible=src.invisibility
//		if(src.Critical_Sight == 0) if(src.sight != (SEE_MOBS|SEE_OBJS|SEE_TURFS)) if(src.sight&&prob(src.Regeneration*2)) src.sight=0
		if(!isnum(SpdMod)) SpdMod=1 // Sanity check
		if(Base<=0||!isnum(Base)) Base=1 // Sanity check
		src.Available_Power()
		src.Available_Stats()

		LogTime=world.realtime
//		if(prob(1)&&prob(1)) InventoryCheck()
		if(Target) TargetCheck()
		if(Smashing&&Smashing<5) SmashCheck(1)

		StunCheck(src)
		StunImmuneCheck(src)
		StaggerImmuneCheck(src)
		SlowCheck(src)
		SlowImmuneCheck(src)
		AlignmentCalibrate()

		getOnlineMinutes()
		SetStatusOverlays()

		//Meditate / Healing
		if((Health/MaxHealth)>(Willpower/MaxWillpower)) Health=(Willpower/MaxWillpower)*MaxHealth
		spawn if(src) if(!src.RPMode)
			src.Healing()
			WillpowerRestoreCheck()
			if(Willpower<=0) WillpowerFailure()
			if(ssj==1||Bojack==1) SSjDrain=min(300, SSjDrain+0.5)
			if(ssj==2||Bojack==2) SSj2Drain=min(300, SSj2Drain+0.5)
			if(ssj==3) SSj3Drain=min(300, SSj3Drain+0.5)
			if(ssj==5) SSGSSDrain=min(300, SSGSSDrain+0.5)

			if(AlienTrans==1) TransDrain=min(300, TransDrain+0.5)
			if(Form==5) Form6Drain=min(300, Form6Drain+0.5)

			if(RecentSendEnergy) RecentSendEnergy--
			if(Ki<=MaxKi) GotPower=0
			if(ElementTicks) ElementTicks--
			if(!ElementTicks&&Element)
				overlays-=/Icon_Obj/Customization/Auras/Sparkles
				Element=null
			if(EmpoweredDefenseTicks)
				EmpoweredDefenseTicks--
				if(!EmpoweredDefenseTicks) overlays-=/Icon_Obj/Customization/Auras/Sparkles

			if(HasFoodRegen>0) FoodLoss()
			if(HasDrugs>0) DrugLoss()
			if(TicksOfMerriment>0) TicksOfMerriment--
			if(FusionTimer>0&&IsFusion)
				FusionTimer--
				if(FusionTimer<=0) ReleaseFusion()
			if(LethalCombatTracker>0)
				LethalCombatTracker--
				if(TicksOfReplenish>0)
					TicksOfReplenish--
					LethalCombatTracker-=2
				if(HasRapidDeployment)LethalCombatTracker--
				if(LethalCombatTracker<=0)
					winset(src.client, "lethalcombat","is-visible=false")
					src.BuffOut("Your body recovers from the recent combat.")
					winset(src,"lethalcombat","is-visible=false")
					LethalCombatTracker=0
			if(Blocking)
				Blocking--
				if(!Blocking)for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer blocking.")
			if(GuardBreaking)
				GuardBreaking--
				if(!GuardBreaking)for(var/mob/player/M in view(src))
					M.BuffOut("[src] is no longer guard breaking.")
					GuardBreakingImmunity=14
			if(GuardBreakingImmunity>0) GuardBreakingImmunity--
			if(HeartAiming)
				HeartAiming--
				if(!HeartAiming)for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer aiming for the heart.")
			if(IceyGrip)
				IceyGrip--
				if(!IceyGrip)for(var/mob/player/M in view(src))
					M.BuffOut("[src]'s ice wings melt.")
					for(var/Skill/Misc/Icey_Grip/IG in src) overlays-=IG
			if(CriticalEdge)
				CriticalEdge--
				if(!CriticalEdge)for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer aiming for critical blows.")
			if(PSand)
				PSand--
				if(!PSand)for(var/mob/player/M in view(src)) M.BuffOut("[src] no longer has sand in their eyes.")
			if(ChakraBlocking)
				ChakraBlocking--
				if(!ChakraBlocking)for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer targeting chakra points.")
			if(RiposteActive)
				RiposteActive--
				if(!RiposteActive)for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer ready to parry.")
			if(CatchBladeActive)
				CatchBladeActive--
				if(!CatchBladeActive)for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer catching the blade.")
			if(Disarmed)
				Disarmed--
				if(!Disarmed)for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer disarmed.")
			if(GuardBroken)
				GuardBroken--
				if(!GuardBroken)
					if(!GuardBroken)
						for(var/mob/player/M in view(src)) M.BuffOut("[src]s guard is no longer broken.")
			if(ChakraBlocked)
				ChakraBlocked--
				if(!ChakraBlocked)
					for(var/mob/player/M in view(src)) M.BuffOut("[src]s chakra is no longer blocked.")
			if(Wing_Clipped)
				Wing_Clipped--
				if(!Wing_Clipped)
					for(var/mob/player/M in view(src)) M.BuffOut("[src] is no longer wing clipped.")



		src.CD_Tick()
		src.InventoryCheck()
		if(KOd) icon_state="KO"
		if(SeenYouBleed>0) SeenYouBleed-=1

		//Weighted Clothing
		var/BaseWeight=1
		for(var/obj/items/Weights/A in contents) if(A.suffix) BaseWeight+=A.Weight
		if(BaseWeight>1+((BaseStr+BaseEnd)*2)) BaseWeight=1+((BaseStr+BaseEnd)*2) //src.KO("wearing too heavy of weights")
		Weight=(BaseWeight/(BaseStr+BaseEnd))
		if(Weight<1) Weight=1

		//Gravity
		if(src.Gravity <= 0) src.Gravity = 1
		if(src.Gravity>src.GravMastered) src.Gravity_Gain()
		src.GravMulti = 1+((max(Gravity,GravMastered)/25)/25)// ((src.Gravity/src.GravMastered)*((src.Gravity/(src.GravMastered/20))/20)) /20)
		if(src.GravMulti > 2) src.GravMulti=2
		if(src.GravMulti<1) src.GravMulti=1

		if(HasManaSiphon)
			ManaCycle++
			if(ManaCycle>=5)
				var/obj/items/Spell_Book/Book
				var/obj/Circle
				for(var/obj/items/Spell_Book/B in src) Book = B
				for(var/obj/items/Magic_Circle/C in range(2,src)) Circle = C
				for(var/obj/items/Magic_Circle/C in src) Circle = C
				for(var/obj/Mana/A in src)
					var/Add=3
					if(Circle) Add += 2
					if(Book) Add*=Book.ManaMult+Book.ExtraManaMult
					if(HasManaExpert) Add*=1.8
					Add=round(Add)
					A.Value+=Add
					if(ToggleViewResMana) CombatOut("Gained [Add] Mana (Mana Siphon)")
				ManaCycle=0
		if(HasAutoDriller)
			ResourceCycle++
			if(ResourceCycle>=5)
				var/obj/items/Digging/Driller
				for(var/obj/items/Digging/C in src) if(C.suffix) Driller = C
				if(Driller)
					for(var/obj/Resources/A in src)
						var/Add=5*(Driller.DigMult)
						if(HasMiningExpert)Add*=1.8
						Add=round(Add)
						A.Value+=Add
						if(ToggleViewResMana) CombatOut("Gained [Add] Resources (Auto Driller)")
				ResourceCycle=0

		src<<output("[YearOutput()]","yearDis")


		if(src.Opp)
			OppTicks--
			if(OppTicks<=0) Opp=null
		if(src.Senzu)
			if(src.Senzu >= 8) src.Senzu = 8
			src.Senzu -=0.1
			if(src.Senzu <= 0.1) src.Senzu = 0
		if(src.HealthPotion)
			if(src.HealthPotion >= 8) src.HealthPotion = 8
			src.HealthPotion -=0.25
			if(src.HealthPotion <= 0.1) src.HealthPotion = 0
		if(!afk)
			Stat_Labels()
			FactionUpdate()
			if(VillainTrain)VillainCap()
			if(Gravity<=10&&Health<0) Health=0
			if(Ki<0) Ki=0
			Gravity()
			if(src.Opp) src.Attack_Gain() //if(src.Opp)  -   Original pre-null bug code
			if(src.attacking==3) src.Blast_Gain()  //if(src.attacking)  -  Original pre-null bug code
			//Return to Afterlife if you run out of energy in the living world
			if(Dead) if(Willpower<30||SeanceYear&&Year>SeanceYear) if(!src.RPMode) src.Dead_In_Living_World()
			//KO
			if(src.Health<=0&&src.KOd==0) src.KO("low health")
//			if(src.KOd&&!src.StatOverlay) KOOverlay()
//			else if(src.Anger>100&&src.KOd==0&&!src.StatOverlay) AngerOverlay()
			updateBars()
			addBPs()
			addTeams()
			Experience_Transferrence()
			// Health
			if(!src.RPMode)
				if(HasPrayerTPd)
					if(z==11) HasPrayerTPd=0
					else if(Willpower<33) PrayerYoink()
				Drains()
				PC_Drain()
				HemoCheck()
				FireCheck()
				WaterCheck()
				SpaceCheck()
				if(Oozaru)
					OozaruTimer--
					if(OozaruTimer<=0) Oozaru_Revert()
				if(Werewolf)
					OozaruTimer--
					if(OozaruTimer<=0) Werewolf_Revert()
				if(src.Ki>src.MaxKi) src.Ki*=0.997
				if(Health/MaxHealth>Willpower/MaxWillpower) src.Health*=0.998
				if(IsBandaged)
					IsBandaged--
					if(IsBandaged<=5) Bandages()
			//Anger
			if(Health>=MaxHealth*0.75&&!LethalCombatTracker)
				if(Anger>100)
					Anger-=(MaxAnger/100)
					if(Anger<=100)
						Anger=100
						src.Calm()
			if(src.icon_state in list("Meditate")&&Health>=MaxHealth*0.5)
				if(Anger>100)
					Anger-=(MaxAnger/100)*2.5
					if(Anger<=100)
						Anger=100
						src.Calm()
			if(src.Health/src.MaxHealth<=0.5) if(src.Anger<=MaxAnger) src.Anger()
			EmotionCheck()

			if((winget(src.client,"emoteW","is-visible")=="true"))
				winset(src.client,"WordCounter","text=\"Word Count: [wordcount(winget(src.client, "emoteW.emoteinput", "text"))]\"")
				EmoteSaveProgress()

			if(IsInSpace()&&!RPMode&&!Vampire)
				TakeDamage("suffocating in space", rand(1,5))
				BPDamage("suffocation",rand(1,5))
				view(src)<<"[src] is suffocating due to the lack of oxygen!"

		if(SkillTierUses) SkillTierUses=max(0,SkillTierUses-1)

		sleep(15)

