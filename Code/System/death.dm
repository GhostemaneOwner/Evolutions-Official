mob/proc/immortality(var/time=2)
// This proc disables death check for the relevant mob.
// time - time in seconds (is multiplied by 10 because spawn measures time in 1/10 of a second)
	immortal = 1
	spawn(time*10) immortal = 0

mob/var/tmp/DeadCap = 0 //Puts a cap/stopper on the Death() proc to avoid spamm killing that results from some ki attacks.

mob/var/LastKill=0

mob/proc
	Mercy(mob/A)
		for(var/mob/player/P in view(A)) P.BuffOut("[A] has shown [src] mercy and helped them to their feet.")
		if(A.LastMercy!=Year)
			A.AlignmentNumber+=1.5
			A.AlignmentCalibrate()
			A.LastMercy=Year
			A.ShownMercy++
		if(RPMode) RPMode()
	Humiliate(mob/A)
		for(var/mob/player/P in view(A)) P.BuffOut("[A] utterly humiliates [src].")
		if(A.LastHumiliate!=Year)
			A.AlignmentNumber-=1.5
			A.AlignmentCalibrate()
			A.Humiliated++
			A.LastHumiliate=Year
	//	if(RPMode) RPMode()


mob/proc/Death(var/Z,forced=0, MajAbsorber)
	if(client) if(src.client.stealth == 1) return
	if(ismob(Z)) if(src.client) if(forced==0)
		var/mob/ZM=Z
		if(!ZM.Lethality) return
		if(src.Willpower>30) return
		if(ZM.Target==src) ZM.Target=null
	//ASSERT(Z)  test assert
	if(Z!="admin"&&Z!="Admin"&&Z!="Self Destruct"&&Z!="old age"&&!forced) if(EventCharacter==0) if(SaveAge<1) return
	if(src.immortal) return // if they're temporary disabled from death, then do nothing.
	if(src.DeadCap) return //Same as above, only this is a tmp var instead, which is not saved and requires no further tweaks or changes elsewhere to function.
	src.DeadCap = 1 //Part of the anti death spam code.
	spawn(100) if(src) src.DeadCap = 0 //Part of the anti death spam code.
	RevertAll()
	if(S) loc=S.loc
	view(src)<<"[src] was just killed by [Z]!"
	if(Willpower<30) Willpower=30
	if(Target) Target=null
	ArmorRemove()
	ScouterOn=0
	MajinAbsorbed=0
	if(MajAbsorber) MajinAbsorbed = "[MajAbsorber]"
	SwordRemove()
	GlovesRemove()
	HammerRemove()
	HelmetRemove()
	RemoveVampire_Skills()
	RemoveWerewolf_Skills()
	Hunger = 100
	Thirst = 100
	Fatigue = 100
	
//	if(ismob(Z)&&EventCharacter) if(Confirm("Should [Z] get a reward for killing you?")) EventKillReward(Z,src)

	if(ismob(Z)) for(var/mob/player/A in view(10,src))
		WitnessedDeath++
		for(var/obj/Contact/C in A.Contacts) if(C.Signature == src.Signature) if(C.familiarity>=45&&C.positiverelation>=1)
			A.DeathAnger=1
			A.Anger()
			view(A)<<"<font color=red>[A] has become insane with rage from the death of [src]!!!"
			var/mob/M = Z
			M.AlignmentNumber-=1.5
	if(ismob(Z))
		var/mob/M = Z
		if(M != src) if(src.client) M.Kills += 1
	move=1 // If they were being revived at the time, then they should be allowed to move.
		//M.SaveToEmoteLog("([key_name(src)] was just killed by [Z].\n")
//	log_game("([key_name(src)] was just killed by [Z].\n")
	src.Save()
	if(client)
		if(ismob(Z))
			var/mob/M = Z
			if(AlignmentNumber>1)
				M.GoodKills++
			else if(AlignmentNumber<-1)
				M.BadKills++
			M.AlignmentNumber-=3

			M.AlignmentCalibrate()
			M.LastKill=Year
			alertAdmins(" | ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [key_name(M)].\n")
			alertAdmins(" | [M] has killed [M.Kills] total.\n")
		else
			alertAdmins(" | ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [Z].\n")
		resetChargelvl(src)
		src.Frozen=0
		if(ismob(Z))
			var/mob/X = Z
			src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] was just killed by [key_name(X)] \n")
			X.saveToLog("[key_name(X)] ([X.x], [X.y], [X.z]) [X] just killed [key_name(src)] \n")
	if(GrabbedMob)
		if(src.isGrabbing==1&&src.GrabbedMob)  // somebody added a retarded check that checks if it's both 0 and 1 at the same time. that dun work yo
			view(src)<<"[src] is forced to release [GrabbedMob]!"
			if(ismob(GrabbedMob)) GrabbedMob.attacking=0
			attacking=0
			GrabbedMob=null
	for(var/mob/A) if(A.GrabbedMob==src&&A.isGrabbing==1)
		A.GrabbedMob.attacking=0
		A.attacking=0
		A.isGrabbing=null
	if(MajinAbsorbed)
		spawn Un_KO()
		src<<"You have been absorbed by [Z]. You are now trapped inside them. You have the option to reincarnate at any time while in this altered dimension or choose to proceed to the Afterlife. All of your time here is IC and if [Z] is killed, you will be released."
		src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] was majin absorbed by [Z].\n")
		alertAdmins("[src] has been placed into the majin absorb holding area.")
		loc=locate(283,214,17)
		return

	if(client||Logged_Out_Body)
		for(var/obj/items/Power_Armor/A in src) src.Eject(A)
		for(var/obj/A in contents)
			if(A.Stealable)
				if(A.suffix) src.Equip_Magic(A,"Remove")
				A.suffix=null
				overlays-=A.icon
				A.loc=loc
			if(istype(A,/obj/Resources))
				var/obj/Resources/R=A
				if(R.Value)
					var/obj/Resources/S=new(loc)
					S.Value=R.Value
					R.Value=0
					S.name="[Commas(S.Value)] Resources"
			if(istype(A,/obj/Mana))
				var/obj/Mana/R=A
				if(R.Value)
					var/obj/Mana/S=new(loc)
					S.Value=R.Value
					R.Value=0
					S.name="[Commas(S.Value)] Mana"
		if(TotalDeaths>2)
			loc=locate(420,116,9)
			DeathBasedReincarnation()
			return

		if(Regenerate>0&&!Dead&&!Regenerating&&!Absorbed) // This deals with natural regeneration after death.
			spawn Un_KO()
			src<<"You will regenerate in [5/Regenerate] minutes"
			src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] will regenerate in [2/Regenerate] minutes.\n")
			Regenerating=1
			savedX=x
			savedY=y
			savedZ=z
			Leave_Body()
			Regenerate()
			return

		if(Dead)// If they were already dead
			view(src)<<"[src] has been sent to the Final Realms"
			for(var/Skill/Misc/Absorb_Majin/MA in src)
				var/obj/MajinAbsorbReleaser/MAR=new
				MAR.SendX=src.x
				MAR.SendY=src.y
				MAR.SendZ=src.z
				MAR.MajinKey=src.key
				MAR.name="[src] Majin Absorb"
				if(MajinAbsorbRemove) MajinAbsorbRemove+=MAR
				else
					MajinAbsorbRemove=list()
					MajinAbsorbRemove+=MAR
				spawn(5)
				for(var/mob/player/MM in Players) if(MM.MajinAbsorbed) MM.MajinAbsorbRelease()
			for(var/Skill/Misc/Absorb_Bio/MA in src)
				var/obj/MajinAbsorbReleaser/MAR=new
				MAR.SendX=src.x
				MAR.SendY=src.y
				MAR.SendZ=src.z
				MAR.MajinKey=src.key
				MAR.name="[src] Bio Absorb"
				MajinAbsorbRemove+=MAR
				spawn(5)
				for(var/mob/player/MM in Players) if(MM.MajinAbsorbed) MM.MajinAbsorbRelease()

			src.KeepsBody=0
			Absorb=0
			MajinAbsorbed=0
			src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] has been sent to the Final Realms.\n")
			loc=locate(400,265,9)
			Willpower=100
			Save()
			src.NewGameReincarnation()
			return
		if(!Dead)
			for(var/Skill/Misc/Absorb_Majin/MA in src)
				var/obj/MajinAbsorbReleaser/MAR=new
				MAR.SendX=src.x
				MAR.SendY=src.y
				MAR.SendZ=src.z
				MAR.MajinKey=src.key
				MajinAbsorbRemove+=MAR
				spawn(5)
				for(var/mob/player/MM in Players) if(MM.MajinAbsorbed) MM.MajinAbsorbRelease()
			for(var/Skill/Misc/Absorb_Bio/MA in src)
				var/obj/MajinAbsorbReleaser/MAR=new
				MAR.SendX=src.x
				MAR.SendY=src.y
				MAR.SendZ=src.z
				MAR.MajinKey=src.key
				MajinAbsorbRemove+=MAR
				spawn(5)
				for(var/mob/player/MM in Players) if(MM.MajinAbsorbed) MM.MajinAbsorbRelease()

			RoidPower=0
			Absorb=0
			MajinAbsorbed=0
			TotalDeaths++
			Death_Zenkai()
			Died = WipeDay
			Willpower=MaxWillpower
			LethalCombatTracker=0
//			AugmentedPowerRevert(1)

			if(HasAdamantineSkeleton)
				HasAdamantineSkeleton=0
				NoBreak = 0
				src<<"You lose the skeletal enhancements inside your old body."
			for(var/BodyPart/BP in src)
				BP.Cybernetic=0
				src<<"You [BP] has returned to its natural state."
			Critical_Left_Arm = 0
			Critical_Left_Leg = 0
			Critical_Right_Leg = 0
			Critical_Right_Arm = 0
			Critical_Head = 0
			Critical_Sight = 0
			Critical_Throat = 0
			Critical_Torso = 0
			Critical_Hearing = 0
			Critical_Mate = 0
			Critical_Tail = 0
			Cyber_Left_Arm = 0
			Cyber_Left_Leg = 0
			Cyber_Right_Leg = 0
			Cyber_Right_Arm = 0
			Cyber_Sight = 0
			for(var/BodyPart/P in src) if(P.Health<=P.MaxHealth) Injure_Heal(200,P,1)

			Leave_Body()

			if(ismob(Z))
				var/mob/MMM=Z
				if(MMM.client)
					if(Z1ControllingRuler==name||FactionApproved(Z1FactionCode,4)) MMM.TakeCP(src)
					if(Z2ControllingRuler==name||FactionApproved(Z2FactionCode,4)) MMM.TakeCP(src)
					if(Z3ControllingRuler==name||FactionApproved(Z3FactionCode,4)) MMM.TakeCP(src)
					if(Z4ControllingRuler==name||FactionApproved(Z4FactionCode,4)) MMM.TakeCP(src)
					if(Z5ControllingRuler==name||FactionApproved(Z5FactionCode,4)) MMM.TakeCP(src)
					if(Z6ControllingRuler==name||FactionApproved(Z6FactionCode,4)) MMM.TakeCP(src)
					if(Z7ControllingRuler==name||FactionApproved(Z7FactionCode,4)) MMM.TakeCP(src)



			if(!Dead)
				switch(Alignment)
					if("Very Pure") overlays += image('HaloVP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
					if("Pure") overlays += image('HaloP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
					if("Very Chaotic") overlays += image('HaloVC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
					if("Chaotic")overlays += image('HaloC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
					if("Neutral") overlays += image('HaloN.dmi',layer=MOB_LAYER+EFFECTS_LAYER)


			Dead=1
			AndroidLevel=0

		if(Has_Tank(src)&&!Regenerating) // See if they have a cloning tank and they're NOT regenerating.
			loc = locate(/area/The_Final_Realm) // Send them to the Limbo area to wait for 2.5 seconds
			spawn(25)
				Clone_Detection(src) // Trigger a check for cloning machines related to this player.
				for(var/BodyPart/P in src) if(P.Health<=P.MaxHealth) Injure_Heal(200,P,1)
		else if(Has_Phylactery(src)&&!Regenerating) // See if they have a cloning tank and they're NOT regenerating.
			loc = locate(/area/The_Final_Realm) // Send them to the Limbo area to wait for 2.5 seconds
			spawn(25)
				Phylactery_Detection(src) // Trigger a check for cloning machines related to this player.
				for(var/BodyPart/P in src) if(P.Health<=P.MaxHealth) Injure_Heal(200,P,1)
		else // they weren't already dead
			loc=locate(DEADX,DEADY,DEADZ) // Send them to the checkpoint
			src.last_icon = src.icon
			src.BeenCloned=0
			src.WasCloned=0
			if(!src.KeepsBody)//setting Soul icon
				src.icon='Soul.dmi'
				overlays  = null
				underlays = null
				src.alpha=initial(src.alpha)
				switch(Alignment)
					if("Very Pure") overlays += 'HaloVP.dmi'
					if("Pure") overlays += 'HaloP.dmi'
					if("Very Chaotic") overlays += 'HaloVC.dmi'
					if("Chaotic") overlays += 'HaloC.dmi'
					if("Neutral") overlays += 'HaloN.dmi'
				overlays-=HealthBar
				overlays-=EnergyBar
				overlays+=HealthBar
				overlays+=EnergyBar
				/*var/icon/I=new(src.icon)
				I.Blend(rgb(0,0,0,100),ICON_ADD)
				src.icon=I*/
			//WishPower=0
			Phylactery = 0
			Save()
			//if(Reincarnation_Status == "On") src.NewGameReincarnation()
			return
	else del(src)


obj/Cookable/Body/proc/Barely_Alive(mob/P) if(P)
	P.loc=loc
	P.Un_KO()
	P.Health=5
	P.Willpower=5
	P.Ki=5
	P.HasStruggled=1
	P.Revive()
	for(var/mob/player/PP in view(P)) PP.BuffOut("[P] has struggled on and refused to let death take them!")
	del(src)



mob/proc/Leave_Body()
	var/obj/Cookable/Body/A=new
	for(var/obj/Stun_Chip/S in src) A.contents+=S
	A.icon=icon
	if(client) A.icon_state="KO"
	A.overlays+=overlays
	A.overlays-=HealthBar
	A.overlays-=EnergyBar
	A.overlays+='Zombie.dmi'
	A.loc=loc
	A.Health=End
	A.KilledName=src.name
	A.name="Body of [src]"
	spawn(600) if(prob(20)&&!HasStruggled&&A.HasHead) A.Barely_Alive(src)

mob/proc/Revive()
	Dead=0
	overlays -= image('HaloVP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	overlays -= image('HaloP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	overlays -= image('HaloVC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	overlays -= image('HaloC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	overlays -= image('HaloN.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	overlays -= 'HaloVP.dmi'
	overlays -= 'HaloP.dmi'
	overlays -= 'HaloVC.dmi'
	overlays -= 'HaloC.dmi'
	overlays -= 'HaloN.dmi'
	src.icon = src.last_icon
	src.alpha=initial(src.alpha)
	