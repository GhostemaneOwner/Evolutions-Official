



mob/var/tmp/HomingAttack=0

/*
mob/proc/EZCheck()
	if(EZ>175)
		EZFlags+++
		EZ=0

	//animate(src, transform = turn(matrix(), 90), time = 2)
	//animate(transform = turn(matrix(), 180), time = 2)
	//animate(transform = turn(matrix(), 270), time = 2)
	//animate(src, transform = turn(matrix(), 360), time = 5)
	//animate(transform = null, time = 2)
mob/proc/EZCleanse()
	if(EZ>0)EZ--
	if(EZ<=0&&EZFlags>0)
		EZFlags--
		EZ=175
*/
mob/proc/Blast() if(!istype(src,/mob/NPC)) flick("Blast",src)
mob/proc/Fight() if(!istype(src,/mob/NPC)) flick("Attack",src)
mob/var/tmp/SeenYouBleed=0
mob/proc/RHK()
	set waitfor=0
	dir=turn(dir,90)
	sleep(1)
	dir=turn(dir,90)
	sleep(1)
	dir=turn(dir,90)
	sleep(1)
	dir=turn(dir,90)
	sleep(1)
mob/proc/KO(mob/Z)
	ASSERT(Z)   //test assert
	if(src.afk) if(Z!="low health") return
	//if(src.client.stealth == 1) return
	if(istype(src,/obj/TrainingEq/Dummy)) del(src)
	if(IsFishing)
		IsFishing=0
		usr<<"You stopped fishing."
	if(IsMining)
		IsMining=0
		usr<<"You stopped mining."
	if(IsCooking)
		IsCooking=0
		usr<<"You were interrupted."
	if(Creating)
		usr<<"You were interrupted."
		Creating=0
	if(client) if(!KOd) // The one who got knocked out
		KOd=1
		if(ismob(Z)&&ismob(src)) if(Z.Lethality)
			var/mob/M=src
			if(M.Willpower>40) M.LethalCombatTracker=900
			else M.LethalCombatTracker=1800
			if(prob(30))
				if(Race=="Android"||AndroidLevel&&prob(50)) OilTrail(src)
				else BloodTrail(src)
			if(Z.HasSeeYouBleed&&!Z.SeenYouBleed)
				SeenYouBleed=100
				Z.Willpower=min(Z.Willpower+10,Z.MaxWillpower)
				for(var/mob/player/MM in view(src)) MM.BuffOut("[Z] smirks at [src].")
		if(LethalCombatTracker)
			if(!RPMode) RPMode()
			Willpower=max(0,Willpower-(30-(HasWillOfFire*8)))
			src<<"Willpower drain from [Z] knocking you out!"
			if(Z.HasASwiftDeath) Willpower=(max(0,Willpower-10))
			if(Health<=-500) Willpower=max(0,Willpower-10)
			if(Willpower<=0) WillpowerFailure()

		//if(usr.InAutoAttack) usr.AutoAttack()
		Stop_TrainDig_Schedulers()
		Flight_Land()
		Calm()
		Life=100
	//	hearers(6,src) << 'Knockout.wav'
		if(client) src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] is knocked out by [key_name(Z)]\n")
		icon_state="KO"
		//KOOverlay()
		KB=0
		Health=0
		if(!LethalCombatTracker) DeathAnger=0
		for(var/Activity/O in Z) if(O.Subtype=="KO") if(!locate("[src.name]") in O.Tracker)
			var/op=O.Progress
			O.CheckProgress(1,"[src.name]",Z)
			if(O.Progress>op) Z<<"You have gained progress on your daily activity. ([O])"
		if(src.BPpcnt > 100)
			src<<"Your energy escapes as you are knocked out."
			src.BPpcnt = 100
		//Anger to onlookers...
		if(ismob(Z)&&Z.client) // For the one who's the responsible player
			Z.Stop_TrainDig_Schedulers()
			for(var/mob/player/M in view(src))
				M.ICOut("[src] is knocked out by [Z]!")
				M.CombatOut("[src] is knocked out by [Z]!")
			saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] is knocked out by [Z]\n")
		else
			for(var/mob/player/M in view(src))
				M.ICOut("[src] is knocked out by [Z]!")
				M.CombatOut("[src] is knocked out by [Z]!")
		saveToLog("| [key_name(src)] is knocked out by [Z]\n")
		RevertAll()
		if(prob(20)) ImitationCancel()
		if(istype(Z,/mob/NPC))
			for(var/mob/player/P in range(50)) P.BuffOut("You hear a loud noise to the [dir2text(get_dir(src,P))]!")
			if(Willpower<=10) if(src.MineX&&src.MineY&&src.MineZ)
				for(var/area/UndergroundMine/B in range(0,src))
					src.loc=locate(src.MineX,src.MineY,src.MineZ)
					src<<"Returned to the surface."

		var/T = rand(800,1600)/(Regeneration)
		if(T<=300) T=300
		if(isnum(Regeneration)) spawn(300) spawn(T) src.Un_KO()
	else if(!Frozen)
		Life=100
		if(istype(src,/mob/Splitform))
			var/mob/Splitform/SF=src
			SF.function=0
		Frozen=1
		view(src)<<"[src] is defeated."
		//if(!client) del(src)
		if(!client){del(src);return}
		//if(sim){del(src);return}
		spawn(rand(500,700)) if(src)
			view(src)<<"[src] regains consciousness"
			Health=MaxHealth
			Frozen=0




mob/proc/Un_KO() if(client&&KOd)
	if(!RPMode&&Willpower>0)
		icon_state=""
		KOd=0
		attacking=0
		Health=1
		Life=100
		//Ki=0
		move=1
		Frozen=0
		for(var/mob/player/M in view(src))
			M.ICOut("[src] regains consciousness.")
			M.CombatOut("[src] regains consciousness.")
		if(isSwimming)
			Injure_Hurt(rand(25,100)/10,"Throat","Water")
			src <<"You have taken damage to your body after taking on too much water!"
			Ki = MaxKi/2
		if(LethalCombatTracker&&HasWillUnbroken) Willpower=min(Willpower+5,MaxWillpower)
//		src.RemoveStatOverlays()
		if(src.client)
			spawn(20) if(prob(10))
				src<<"Being knocked out so much angers you..."
				src.CombatOut("Being knocked out so much angers you...")
				Anger()
				SecondWindCD=0
	else if(RPMode)
		sleep(600/Regeneration)
		Un_KO()

mob/proc/resetChargelvl(mob/player/P)
	for(var/Skill/Attacks/A in P)
		if(A.chargelvl>1) A.chargelvl=1
		sleep(1)

mob/verb/Attack()
	set category="Skills"
	if(usr.DashAttacking)
		src <<("You cannot use combo moves and attack at the same time!")
		return
	if(usr.InAutoAttack) usr.Toggle_Auto_Attack()
	Stop_TrainDig_Schedulers()
	if(adminDensity)
		src << "You're currently in Ghost Form. Disable it first."
		return
	if(!usr.CanAttack(1)) return
	MeleeAttack()

mob/verb/Toggle_Auto_Attack()
	set category="Other"
	InAutoAttack=!InAutoAttack
	if(InAutoAttack)
		winset(client,"AUTO","is-visible=true")
		usr<<"Auto Attack initiated."
		spawn() AutoAttack()
	else
		AALoop=0
		winset(client,"AUTO","is-visible=false")
		usr<<"Auto Attack cancelled."

mob/var/tmp
	InAutoAttack=0
	AALoop=0
mob/proc/AutoAttack()
	set waitfor=0
	set background=1
	if(AALoop) return
	while(InAutoAttack&&!KOd)
		AALoop=1
		Stop_TrainDig_Schedulers()
		if(CanAttack(1)) MeleeAttack()
		if(Ki<=MaxKi*0.05)
			InAutoAttack=0
			winset(client,"AUTO","is-visible=false")
			src<<"You stop Auto Attacking due to lack of energy. (<5% Energy)"
		sleep(Refire)

mob/proc/GrabRelease()
	if(src.isGrabbing)
		isGrabbing=null
		GrabbedMob.attacking=0
		attacking=0
		GrabbedMob.grabberSTR=null
		GrabbedMob=null

mob/var/tmp/OppTicks=0
mob/proc/Opp(var/mob/P) if(!Opp) if(istype(P,/mob))
	Opp=P
	OppTicks=6
	Stop_TrainDig_Schedulers()
	//awn(100) Opp=null




mob/proc/TrainOpp(var/P)
	if(!P) return
	if(args.len>1)
		return
	var/obj/TrainingEq/_equipment
	if(!istype(P, /obj/TrainingEq))
		return
	else
		_equipment = P
	if(Opp) return
	Opp=_equipment
	OppTicks=4
	Stop_TrainDig_Schedulers()
	//awn(100) Opp=null
mob/var/tmp/TargetWarpCD=0
mob/proc/TargetWarp() if(!TargetWarpCD)
	if(src.Target&&src.Target.z==src.z) if(get_dist(src,Target)<10)
		Comboz(Target)
		TargetWarpCD=12
mob/var/tmp/mob/LastAttacked
mob/proc/MeleeAttack(skiprefire=0,skipKB=0)
	set background=1
	set waitfor=0
	if(S) return
	Bandages()
	if(src.invisibility)
		src.invisibility=0
		src.see_invisible=0
		winset(usr.client,"INVIS","is-visible=false")
		src << "As you attack, you feel your body become tense and you turn visible again!"
		for(var/Skill/Support/Invisibility/A in src) if(A.Using) spawn(45){A.Using=0;src<<"You feel your body relax again."}
	for(var/obj/items/Soccer_Ball/E in get_step(src,dir))
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)
		sleep(0)
		step_away(E,src,StrMod*2)
	for(var/obj/TrainingEq/E in get_step(src,dir)) if(icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
		var/Bag = 0
		if(istype(E,/obj/TrainingEq/Dummy))
			if(!attacking)
				attacking=1
				if(E.icon_state=="Off") spawn(1000) if(E) E.icon_state="Off"
				E.icon_state="On"
				if(E.dir==turn(dir,180))
					getAttackXY()
					Fight()
					TrainOpp(E)
					if(prob(50)) E.dir=turn(E.dir,90)
					else E.dir=turn(E.dir,-90)
					spawn(Refire*0.5) attacking=0
				else
					flick("Attack",src)
					Opp=null
					spawn(Refire*2) attacking=0
					return
					//DisableTraining()
					//if(ProcOn==1&&TimerOn==0) TrainingTimer()  //	if(!usr.TrainingTimer()
				var/Damage=((Str/E.End)+(BP/(E.BP*10)))
				for(var/obj/items/Boxing_Gloves/G in src)
					if(G.suffix)
						Damage = Damage / 20
						//src.Spar = 1
						break
				if(!isnum(E.Health)) return
				E.TakeDamage(src, Damage, "Attack")
				//E.Health-=Damage
				if(E.Health<=0&&E.icon_state!="KO")
					E.Health=0
					E.icon_state="KO"
					spawn(600) if(E) if(E.Health<=0) del(E)
					return
		else if(istype(E,/obj/TrainingEq/Punching_Bag)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			for(var/obj/TrainingEq/Magic_Goo/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			for(var/obj/TrainingEq/Punching_Bag/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			Bag = 1
		else if(istype(E,/obj/TrainingEq/Magic_Goo)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			for(var/obj/TrainingEq/Magic_Goo/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			for(var/obj/TrainingEq/Punching_Bag/R in range(0,src)) if(R!=src)
				view(src)<<"You can't hit the [src] because [R] is in the way."
				sleep(1)
				return
			Bag = 1
		else if(istype(E,/obj/TrainingEq/Punchometer)) if(E.Health>0&&dir==EAST&&Ki>0.1)
			Bag=1
		if(Bag)
			if(!attacking)
				attacking=1
				TrainOpp(E)
				DrainKi(E, 1, 0.5,0)//src.DrainKi("PBag","Percent",0.5)
				spawn(Refire) attacking=0 //Refire*.05 original code -  Combat CPU optimization
				//flick("hit",E)
				getAttackXY()
				Fight()
				flick("hit",E)
				var/Damage=((Str/E.End)+(BP/(E.BP*10)))//Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
				for(var/obj/items/Boxing_Gloves/G in src)
					if(G.suffix)
						Damage = Damage / 20
						break
				if(!isnum(E.Health)) return
				E.TakeDamage(src, Damage, "Attack")
				if(E.Health<=0&&E.icon_state!="Destroyed") E.icon_state="Destroyed"
		return
	//for(var/mob/M in get_step(src,dir))

	if(KiBow)
		//t1 30% Strength and 80% Force
		//t2 40% Strength and 90% Force
		//t3 50% Strength and 100% Force
		//var/Drain = (roll("1d4"))
		//usr.DrainKi("KiBow","Percent",Drain)
		DrainKi("Ki Bow", 1, 1,0)
		attacking=1
		if(skiprefire)attacking=0
		var/obj/ranged/Blast/A=unpool("Blasts")
		flick("Blast",usr)
		A.Belongs_To=usr
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-16,16)
		A.pixel_y+=rand(-16,16)
		A.name="Ki Arrow [KiBow]"
		A.icon='Quincy Arrow.dmi'
		var/MaskDamage=0
		if(src.MaskOn) for(var/obj/items/Magic_Mask/MM in src) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(src)
			break
		if(MaskDamage>src.BP*0.33)MaskDamage=src.BP*0.33
		switch(KiBow)
			if(1)
				A.Damage=1.5*(src.BP+MaskDamage)*((src.Pow*0.8)+(src.Str*0.3))*Ki_Power  //200
				A.Power=(src.BP+MaskDamage)*Ki_Power
			if(2)
				A.Damage=1.5*(src.BP+MaskDamage)*((src.Pow*0.9)+(src.Str*0.4))*Ki_Power  //200
				A.Power=(src.BP+MaskDamage)*Ki_Power
			if(3)
				A.Damage=1.5*(src.BP+MaskDamage)*((src.Pow)+(src.Str*0.5))*Ki_Power  //200
				A.Power=(src.BP+MaskDamage)*Ki_Power
		A.Offense=src.Off
		if(prob(30)) A.Shockwave=1
		if(src.HasSmolder)
			A.icon='Arrow Charge.dmi'
			A.CausesBurns=1
		if(CriticalEdge&&prob(50))
			A.icon='Quincy Arrow 2.dmi'
			if(A.CausesBurns) A.icon='Arrow Barrage.dmi'
			A.Damage*=1.33
		A.dir=src.dir
		A.loc=src.loc
		if(IceyGrip)A.IceGrips=1
		walk(A,A.dir)
		spawn(Refire/4) attacking=0
		return
	var/mob/M=null
	for(var/mob/MN in oview(src,1)) if(MN==LastAttacked&&Warp) M=MN
	if(!M)
		for(var/mob/MM in get_step(src,dir))
			M=MM
			//break
	if(M) if(!M.adminDensity&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0) //if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
		if(HasDoubleAttack) if(prob(18))
			src.FreeAttack(M,1)
		if(M.RPMode) return
		for(var/obj/items/Regenerator/R in range(0,src)) if(R.z) return
		if(client)
			if(Ki<1+(KiBlade+KiFists+BurningFists+KiHammer)) return
			//var/Drain = (roll("1d2")+(KiBlade*2)+(KiFists*1.5)+(BurningFists*1.5)+(KiHammer*1.5))
			//src.DrainKi("Attack","Percent",Drain)
			DrainKi("Attack", 1, 1+(KiBlade*3)+(KiFists*2)+(BurningFists*2)+(KiHammer*2),0)
		/*if(M.client&&client) if(M.client.computer_id==client.computer_id) // Based on computer ID instead of IP.
			src<<"Do not interact with alternate keys"
			alertAdmins("|| ([src.x], [src.y], [src.z]) | [key_name(src)] has been forced off the server for attempted alt interaction with [key_name(M)].\n")
			src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] has been forced off the server for attempted alt interaction with [key_name(M)].\n")
			Logout()*/
		if(!attacking||skiprefire) if(M.afk == 0)
			//if(M.Flying!=Flying) return
			if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
				attacking=1
				if(skiprefire)attacking=0
				if(prob(20)&&locate(/Skill/Zanzoken) in src&&Zanzoken>=1000) Comboz(M)
				if(!Oozaru&&!Werewolf)getAttackXY()
				Fight()
				/*
				if(FancyFight&&!incoolattack&&!M.incoolattack&&prob(25)&&locate(/Skill/Zanzoken) in src&&locate(/Skill/Zanzoken) in M) PrettyAttack(M) //
				else
					getAttackXY()
					Fight()*/
				if(M.attacking==1) Opp(M)
				var/DidCrit=0
				var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=WorldDefaultAcc)
				var/Damage=DamageFormula(src,M)
				if(M.ArmorCheck()<2) if(WeaponCheck(2)>1) if(prob(10*(SwordOn-1)))
					DidCrit=1
					Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
					M.CombatOut("[src] scored a critical hit on [M]!")
					CombatOut("[src] scored a critical hit on [M]!")
				if(!HammerOn&&!SwordOn&&!KiBlade)
					if(HasWayOfTheOpenPalm&&!KiFists) Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.1,Offense=0,DamageType="Physical",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
					else if(KiFists&&HasWayOfTheOpenPalm)
						Evasion=AccuracyFormula(src,M,KiManip=2,Chance=WorldDefaultAcc)
						Damage=DamageFormula(src,M,Strength=0.7,Force=0.3,Speed=0.1,Offense=0,DamageType="KiFist",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
					else if(KiFists)
						Evasion=AccuracyFormula(src,M,KiManip=2,Chance=WorldDefaultAcc)
						Damage=DamageFormula(src,M,Strength=0.7,Force=0.3,Speed=0,Offense=0,DamageType="KiFist",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				if(KiBlade)
					Evasion=AccuracyFormula(src,M,KiManip=1,Chance=WorldDefaultAcc)
					Damage=DamageFormula(src,M,Strength=0.2,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				if(KiHammer)
					Evasion=AccuracyFormula(src,M,KiManip=1,Chance=WorldDefaultAcc)
					Damage=DamageFormula(src,M,Strength=0.3,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				if(SpiritSword)
					Evasion=AccuracyFormula(src,M,KiManip=1,Chance=WorldDefaultAcc)
					Damage=DamageFormula(src,M,Strength=0.4,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				if(CriticalEdge&&prob(50)) Damage*=1.33
				var/didBlock=0
				var/WarpCD=0
				var/DecisiveBlow=0
				var/DBChance=Refire*0.1
				if(src.Warp)DBChance/=5
				if(HasRefuseToLose) DBChance*=1.1
				if(src.Health<30&&src.Lethality&&prob(DBChance))DecisiveBlow=1
				if(!DecisiveBlow&&BurningDesireAttacks)
					BurningDesireAttacks--
					DecisiveBlow=1
				//del(L)
				if(M.RiposteActive)
					for(var/mob/player/teleg in view(src)) teleg.CombatOut("[M] counters [src]s attack.")
					M.dir=get_dir(M,src)
					GetDisarmed(M,8)
					BlockEffect(M)
					Stun(src,0.5)
					M.RiposteActive=0
					RiposteActive=0
					spawn(Refire) attacking=0
					return 0
				if(M.CatchBladeActive) //if(SwordOn||HammerOn)
					for(var/mob/player/teleg in view(src)) teleg.CombatOut("[M] catches [src]s attack mid-swing.")
					M.dir=get_dir(M,src)
					GetDisarmed(M,8)
					BlockEffect(M)
					Stun(src,0.5)
					M.CatchBladeActive=0
					CatchBladeActive=0
					spawn(Refire) attacking=0
					return 0
				if(!prob(Evasion))
					flick(M.CustomZanzokenIcon,M)
					M.CombatOut("You dodge [usr].")
					CombatOut("[M] dodges you.")
					if(M.HasFloatLike)
						if(Warp) DrainKi("[M] Floats Like A Butterfly","Percent",0.12)
						else DrainKi("[M] Floats Like A Butterfly","Percent",0.6)
				else //Successful hit
					if(!prob(Evasion-(M.HasWayOfTheTurtle*2.5)))
						if(prob(10)) ShockwaveScale(M,BP)
						Damage = Damage * 0.5
						didBlock=1
					//if(prob(70)) ImpactDust(M,usr.dir)//
					M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
					if(M.KB>20) M.KB=20
					if(skipKB)M.KB=0
					if(Warp&&M.KB) M.KB=M.KB/2
					if(HammerOn) if(prob(max(25,SwordSkill/25))) SmallCrater(M)
					//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					if(prob(25))
						if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
						if(SwordSkill>1500&&SwordOn) DustCloud(M)
						if(SwordSkill>1500&&HammerOn) DustCloud(M)
					if(SwordOn||HammerOn)
						if(prob(50)) StabUser(src)
						else SlashUser(src)
					if(DecisiveBlow) M.KB+=2
					spawn M.KnockBack(usr)
					if(KOd==0&&prob(Zanzoken*0.1)&&Warp&&(locate(/Skill/Zanzoken) in src))
						if(Warp)
							Damage/=3
							if(Race=="Yardrat") Damage*=1.1
							if(HasZanzokenMaster) Damage*=1.2
							//src.DrainKi("Warp","Percent",1)
							DrainKi("Warp", 1, 0.75,0)
							WarpCD=1
						spawn(M.KB+1)
							flick(src.CustomZanzokenIcon,src)
							Comboz(M)
					var/Htype="physical"
					if(SwordOn)Htype="sharp"
					if(M)
						if(!isnum(M.Health)) return
						var/AttackOut="Attack"
						if(didBlock==1)AttackOut="Blocked Attack"
						else if(didBlock==2) AttackOut="(Armor) Blocked Attack"
						M.TakeDamage(src, Damage, AttackOut,Htype)
						if(M.client&&GuardBreaking&&M.GuardBreakingImmunity==0)
//							winset(M.client,"guardB","is-visible=true")
							if(!M.GuardBroken) viewers(6,M) <<"[M]'s guard has been broken by [src]."
							M.GuardBroken=4
							//GuardBreaking--
						if(M.client&&ChakraBlocking)
							winset(M.client,"ChakraB","is-visible=true")
							if(!M.ChakraBlocked) viewers(6,M) <<"[M]'s chakra has been blocked by [src]."
							M.ChakraBlocked=5
							if(Warp) M.DrainKi("[src] Chakra Blocking","Percent",0.4)
							else M.DrainKi("[src] Chakra Blocking","Percent",1.2)
							//ChakraBlocking--
						LastAttacked=M
						spawn()
							if(M.ArmorCheck()<3) if(WeaponCheck(2)>2) if(prob(10))
								if(Warp) M.DrainKi("[src] Weapon","Percent",0.4)
								else M.DrainKi("[src] Weapon","Percent",1.2)
							if(DecisiveBlow)
								for(var/mob/player/P in view(src)) P.BuffOut("[src] has dealt a decisive blow against [M]!")
								M.TakeDamage(src, M.Health*0.1, "Decisive Blow")
								src.DecisiveRegen()
							if(IceyGrip) spawn() M.GripOfIce()
							if(Element) spawn() if(prob(70)) M.BurnDamage(src,"Firey Weapon",Damage*0.1)
							if(BurningFists&&!SwordOn&&!HammerOn)if(!SpiritSword&&!KiBlade&&!KiHammer) if(prob(50)) M.BurnDamage(src,"Burning Fists",Damage*0.2)
							if(!Disarmed) if(WeaponCheck()) if(!SpiritSword&&!KiBlade&&!KiHammer)
								if(BleedingEdge) if(prob(33)) M.BleedDamage(src,"Bleeding Edge",Damage*0.125)
								if(ThunderingBlows) if(prob(50)) M.Thunderstruck(src,Damage*0.1)
							if(ManaLeech) LeechMana(M)
				if(!skiprefire)
					if(WarpCD&&Warp) spawn(Refire/3) if(attacking!=3) attacking=0
					else spawn(Refire) if(attacking!=3) attacking=0
			else
				attacking=1
				spawn(Refire) attacking=0
				Fight()
				if(!isnum(M.Life)) return
				//CombatOut("You attack [M]. ([round(3*((BP*Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
				//M.CombatOut("[usr] attacks you. ([round(3*((BP*Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
				M.Life-=3*((BP*Str)/(M.Base*M.Body*M.End))
				M.KB=round((Str/M.End)*5)
				if(M.KB>5) M.KB=5
				M.KnockBack(usr)
				////if(M&&M.Life<=0) M.Death(src)
/*
// AI_START
// Activate the AI if attacking an NPC
// If things are giving you errors just comment this part out.
		if(istype(M,/NPC_AI))
		//	world<<"Initializing AI attack code"
			var/NPC_AI/A = M
			A.target = src
		//	world<<"[A] target set to [src]."
			if(A.Health<90) A.docile = 0
			if(!A.active)
			//	world<<"Activating NPC_AI code."
				spawn A.Activate_NPC_AI()
// AI_END
*/

		return

	if(src.HomingAttack) if(src.Target&&src.Target.z==src.z) if(get_dist(src,Target<10))
		Comboz(Target)
		src.HomingAttack--
		return

	for(var/obj/Door/A in get_step(src,dir)) if(icon_state!="Meditate"&&icon_state!="Train"&&KOd==0&&!attacking) if(!istype(A,/Icon_Obj))
		attacking=1
		spawn(Refire) attacking=0
		Fight()
		if(!isnum(A.Health)) return
		if(istype(A,/obj/Door/)) A.TakeDamage(src, (Str*BP)/max(1,GunBPAssign(max(A.Level,1))), "Attack")
		else if(!istype(A,/obj/items/Power_Armor)) if(!istype(A,/obj/Ships)) A.TakeDamage(src, (Str*BP)/TrueBPCap, "Attack")
		if(A.Health<0) A.Health=0
		if(A.Health<=0)
			SmallCrater(A)
			del(A)
		return







mob/proc/FreeAttack(mob/M,skipKB=1)
	set waitfor=0
	if(!attacking) if(M.afk == 0)
		if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
			if(prob(20)&&locate(/Skill/Zanzoken) in src&&Zanzoken>=1000) Comboz(M)
			if(!Oozaru&&!Werewolf)getAttackXY()
			Fight()
			if(M.attacking==1) Opp(M)
			var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=WorldDefaultAcc)
			var/Damage=DamageFormula(src,M)
			var/DidCrit=0
			if(M.ArmorCheck()<2) if(WeaponCheck(2)>1) if(prob(10*(SwordOn-1)))
				DidCrit=1
				M.CombatOut("[src] scored a critical hit on [M]!")
				CombatOut("[src] scored a critical hit on [M]!")
			if(!HammerOn&&!SwordOn&&!KiBlade&&!KiHammer&&!SpiritSword)
				if(HasWayOfTheOpenPalm&&!KiFists) Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.1,Offense=0,DamageType="Physical",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				else if(KiFists&&HasWayOfTheOpenPalm)
					Evasion=AccuracyFormula(src,M,KiManip=2,Chance=WorldDefaultAcc)
					Damage=DamageFormula(src,M,Strength=0.7,Force=0.3,Speed=0.1,Offense=0,DamageType="KiFist",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				else if(KiFists)
					Evasion=AccuracyFormula(src,M,KiManip=2,Chance=WorldDefaultAcc)
					Damage=DamageFormula(src,M,Strength=0.7,Force=0.3,Speed=0,Offense=0,DamageType="KiFist",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
			if(KiBlade)
				Evasion=AccuracyFormula(src,M,KiManip=1,Chance=WorldDefaultAcc)
				Damage=DamageFormula(src,M,Strength=0.2,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
			if(KiHammer)
				Evasion=AccuracyFormula(src,M,KiManip=1,Chance=WorldDefaultAcc)
				Damage=DamageFormula(src,M,Strength=0.3,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
			if(SpiritSword)
				Evasion=AccuracyFormula(src,M,KiManip=1,Chance=WorldDefaultAcc)
				Damage=DamageFormula(src,M,Strength=0.4,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2+DidCrit,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
			if(CriticalEdge&&prob(50)) Damage*=1.33
			var/didBlock=0
			var/DecisiveBlow=0
			var/DBChance=Refire*0.5
			if(src.Warp)DBChance/=5
			if(HasRefuseToLose) DBChance*=1.1
			if(src.Health<30&&src.Lethality&&prob(DBChance))DecisiveBlow=1
			if(!DecisiveBlow&&BurningDesireAttacks)
				BurningDesireAttacks--
				DecisiveBlow=1
			//del(L)
			if(M.RiposteActive)
				for(var/mob/player/teleg in view(src)) teleg.CombatOut("[M] counters [src]s attack.")
				M.dir=get_dir(M,src)
				GetDisarmed(M,8)
				BlockEffect(M)
				Stun(src,0.5)
				M.RiposteActive=0
				RiposteActive=0
				spawn(Refire) attacking=0
				return 0
			if(M.CatchBladeActive) if(SwordOn||HammerOn)
				for(var/mob/player/teleg in view(src)) teleg.CombatOut("[M] catches [src]s weapon.")
				M.dir=get_dir(M,src)
				GetDisarmed(M,8)
				BlockEffect(M)
				Stun(src,0.5)
				M.CatchBladeActive=0
				CatchBladeActive=0
				spawn(Refire) attacking=0
				return 0
			if(!prob(Evasion))
				flick(M.CustomZanzokenIcon,M)
				M.CombatOut("You dodge [usr].")
				CombatOut("[M] dodges you.")
				if(M.HasFloatLike)
					if(Warp) DrainKi("[M] Floats Like A Butterfly","Percent",0.12)
					else DrainKi("[M] Floats Like A Butterfly","Percent",0.6)
			else //Successful hit
				if(!prob(Evasion+(M.HasWayOfTheTurtle*2.5)))
					if(prob(10)) ShockwaveScale(M,BP)
					Damage = Damage * 0.5
					didBlock=1
				//if(prob(70)) ImpactDust(M,usr.dir)//
				M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
				if(M.KB>20) M.KB=20
				if(skipKB)M.KB=0
				if(Warp&&M.KB) M.KB=M.KB/2
				if(HammerOn) if(prob(max(25,SwordSkill/100))) SmallCrater(M)
				//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
				if(prob(25))
					if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
					if(SwordSkill>1500&&SwordOn) DustCloud(M)
					if(SwordSkill>1500&&HammerOn) DustCloud(M)
				if(SwordOn||HammerOn)
					if(prob(50)) StabUser(src)
					else SlashUser(src)
				if(DecisiveBlow) M.KB+=2
				spawn M.KnockBack(usr)
				var/Htype="physical"
				if(SwordOn)Htype="sharp"
				if(M)
					if(!isnum(M.Health)) return
					var/AttackOut="Attack"
					if(didBlock==1)AttackOut="Blocked Attack"
					else if(didBlock==2) AttackOut="(Armor) Blocked Attack"
					M.TakeDamage(src, Damage, AttackOut,Htype)
					if(M.client&&GuardBreaking&&M.GuardBreakingImmunity==0)
//						winset(M.client,"guardB","is-visible=true")
						if(!M.GuardBroken) viewers(6,M) <<"[M]'s guard has been broken by [src]."
						M.GuardBroken=4
						//GuardBreaking=0
						//GuardBreaking--
					if(M.client&&ChakraBlocking)
						winset(M.client,"ChakraB","is-visible=true")
						if(!M.ChakraBlocked) viewers(6,M) <<"[M]'s chakra has been blocked by [src]."
						M.ChakraBlocked=5
						ChakraBlocking=0
						if(Warp) M.DrainKi("[src] Chakra Blocking","Percent",0.2)
						else M.DrainKi("[src] Chakra Blocking","Percent",1)
						//ChakraBlocking--
					LastAttacked=M
					if(M.ArmorCheck()<3) if(WeaponCheck()>2) if(prob(10))
						if(Warp) M.DrainKi("[src] Weapon","Percent",0.3)
						else M.DrainKi("[src] Weapon","Percent",1.5)
					if(DecisiveBlow)
						for(var/mob/player/P in view(src)) P.BuffOut("[src] has dealt a decisive blow against [M]!")
						M.TakeDamage(src, M.Health*0.1, "Decisive Blow")
						src.DecisiveRegen()
					if(Element) spawn()//redo me REMOVE ME FIX ME
						if(prob(70)) M.BurnDamage(src,"Firey Weapon",Damage*0.1)
					spawn()
						if(BurningFists&&!SwordOn&&!HammerOn) if(prob(66)) M.BurnDamage(src,"Burning Fists",Damage*0.2)
						if(!Disarmed) if(WeaponCheck())
							if(BleedingEdge) if(prob(33)) M.BleedDamage(src,"Bleeding Edge",Damage*0.125)
							if(ThunderingBlows) if(prob(50)) M.Thunderstruck(src,Damage*0.1)
						if(ManaLeech) LeechMana(M)
