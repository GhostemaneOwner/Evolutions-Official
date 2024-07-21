

atom/proc/TakeDamage(mob/damager, damage, source, Htype="physical")//A.TakeDamage(src, (Damage)/(A.BP*A.End), "Blast","energy")
	if(!isnum(src.Health)) return
	var/OldHP=src.Health

	if(isturf(src)||isobj(src))if(ImmuneYear)
		if(ImmuneYear>Year) damage=0
		else damage+=(Health*0.75)+1
	if(ismob(damager))
		if(damager.HasBuildingPermit&&isturf(src)) damage*=2
		if(damager.HasBuildingPermit&&isobj(src)) damage*=2

	if(ismob(src))
		var/mob/M=src
		if(M.AdminMode)return
		if(M.RPMode) return
		if(M.afk) return
		if(M.invisibility)
			M.invisibility=0
			M.see_invisible=0
			M << "The attack causes you to lose your focus and slip out of invisibility!"
			for(var/Skill/Support/Invisibility/A in M) if(A.Using) spawn(45){A.Using=0;M<<"You feel your body relax again."}
			winset(usr.client,"INVIS","is-visible=false")
		if(M.Blocking)damage*=0.7
		if(ismob(damager))
			if(damager.HasFriendOrFoe)
				if(M.Team==damager.Team) damage*=0.9
				else damage*=1.05
			else if(M.Team==damager.Team) damage*=0.7
			if(damager.HasConcentratedFire)
				if(damager.Target==M)damage*=1.1
				else damage*=0.95
			if(damager.HemoChecks) damage*=(1+damager.HemoChecks)
			if(M.HemoChecks) damage*=(1-M.HemoChecks)
			if(damager.WaterChecks) damage*=(1+damager.WaterChecks)
			if(M.WaterChecks) damage*=(1-M.WaterChecks)
			if(damager.FireChecks) damage*=(1+damager.FireChecks)
			if(M.FireChecks) damage*=(1-M.FireChecks)
			if(damager.SpaceChecks) damage*=(1+damager.SpaceChecks)
			if(M.SpaceChecks) damage*=(1-M.SpaceChecks)
			if(damager.StanceCore==2) damage*=1.05
			if(M.HasChallengersMark&&M.Target!=damager)damage*=1.05
			if(M.HasChallengersMark&&M.Target==damager)damage*=0.85
			if(M.Smashing) M.SmashCheck(damage)
			if(M.HasXenophobia&&M.Race!=damager.Race) damage*=1.03
			if(damager.HasXenophobia&&M.Race!=damager.Race)damage*=1.1

			if(damager.HasMidasPunch)
				var/Riches=0
				for(var/obj/Mana/MM in damager) Riches+=MM.Value
				for(var/obj/Resources/MM in damager) Riches+=MM.Value
				if(Riches>100000000)damage*=1.05
			if(damager.HasEatTheRich)
				var/Riches=0
				for(var/obj/Mana/MM in M) Riches+=MM.Value
				for(var/obj/Resources/MM in M) Riches+=MM.Value
				if(Riches>100000000)damage*=1.05

			if(damager.HeartAiming&&damager.Lethality)
				damage*=0.1
				M.Willpower-=damage
				damager.CombatOut("(Damaged [M]) [round(damage,0.01)] willpower damage [damager.Lethality?"(Lethal)":""]")
				M.CombatOut("([damager]) You took [round(damage,0.01)] willpower damage")
				return
			if(damager.HasGrimeReaper)
				var/KillAdd=1+(min(2,damager.Kills)*0.05)
				damage*=KillAdd
			if(damager.HasCleanseWicked)
				var/KillAdd=1+(min(2,M.Kills)*0.05)
				damage*=KillAdd
			if(M.HasFastMetabolism&&M.HasFoodRegen) damage*=0.9
			if(damager.HasKeepYourEnemies)
				for(var/obj/Contact/A in damager.Contacts) if(A.Signature == M.Signature)
					var/DM=(A.familiarity/10)
					if(DM>5)DM=5
					damage*=1+(DM/100)
			if(damager.HasLoneWolf)if(damager.Team.Members.len<=1&&!locate(/obj/Faction) in damager)damage*=1.05
			if(M.HasLoneWolf) if(M.Team.Members.len<=1&&!locate(/obj/Faction) in M)damage*=0.95

			if(M.HasThornsOn&&ismob(damager)&&source!="Thorns Aura"&&source!=src&&damager!=src)
				var/mob/MP=damager
				MP.TakeDamage(M, min(max(0.005,damage*0.15),5), "Thorns Aura")
			if(damager.Total_Stats_Strength)
				var/MightDamage=1
				if(damager.Race=="Alien") MightDamage=(damager.Total_Stats_Strength*0.0024)+1
				else MightDamage=(damager.Total_Stats_Strength*0.01)+1
				damage*=MightDamage
		if(M.HasBerserking&&M!=damager) damage*=1.15
		if(M.StanceCore==3) damage*=0.95
		if(M.BestDefenseRate)
			var/DR=M.BestDefenseRate/100
			damage-=damage*DR
			M.BestDefenseRate=0
		if(ismob(src)&&damager!=src&&ismob(damager)) src.HitOverlay(Htype,damager)
	//Might damage boost
	//Total_Stats_Strength


		if(M.Total_Stats_Endurance)
			var/EndDR=1
			if(M.Race=="Alien") EndDR=(M.Total_Stats_Endurance*0.0024)+1
			else EndDR=(M.Total_Stats_Endurance*0.01)+1
			damage/=EndDR

	src.Health-=damage
	if(istype(src,/obj/TrainingEq/Punchometer)) view(src,10)<<"[damager] dealt [damage]!"
	/*if(ismob(src))
		var/mob/SWguy=src
		SWguy.FollowTarget=null*/
//	if(istype(src,/obj/TrainingEq/Punchometer)) view(src,10)<<"[damager] dealt [damage]!"
	if(ismob(src))
		var/mob/SWguy=src
		if(OldHP>=50&&SWguy.Health<50)
			SWguy.SecondWind()
			SWguy.Anger()
		if(SWguy.Health<=0) SWguy.KO(damager)
		if(source)SWguy.CombatOut("([damager]) You took [round(damage,0.01)] damage ([source])")
		else SWguy.CombatOut("([damager]) You took [round(damage,0.01)] damage")
	if(ismob(damager)&&ismob(src))
		var/mob/S=src
		if(prob(3*damage)&&damager!=src) ShockwaveScale(S,damager.BP,damage/3)
		if(!source) damager.CombatOut("(Damaged [src]) [round(damage,0.01)] damage [damager.Lethality?"(Lethal)":""]")
		else damager.CombatOut("(Damaged [src]) [round(damage,0.01)] damage ([source]) [damager.Lethality?"(Lethal)":""]")
		if(ismob(src)&&damager!=src)
			S.Add_Anger(damage)
			if(damage>=1)
				if(S.Willpower<30&&prob(0.3+(1*S.HasRefuseToLose))&&S.LethalCombatTracker) S.RefuseToDie()
				if(S.Willpower<50&&prob(1.5+(5*S.HasRefuseToLose))&&S.LethalCombatTracker&&S.Lethality) S.BurningDesireForVictory()
			if(S.client&&damager.Lethality)
				if(S.Willpower>70) S.LethalCombatTracker=400
				else if(S.Willpower>40) S.LethalCombatTracker=700
				else S.LethalCombatTracker=1200
				if(prob(30))
					if(S.Race=="Android"||S.AndroidLevel&&prob(50)) OilTrail(S)
					else BloodTrail(S)
				else if(S.HasHemophilia) if(prob(30)&&S.Race!="Android") BloodTrail(S)
				var/RateMult=max(0.5,damage*(rand(50,150)/100))
				if(damager.HasSurgicalStrikes) damage*=(damager.HasSurgicalStrikes*0.05)+1
				damage=damage*(rand(2,7)/10)
				S.BPDamage(damager,damage,RateMult)
				if(damager.HasBestDefense) damager.BestDefenseRate=min(20,damager.BestDefenseRate+damage)
			if(S.Flying&&S.SuperFly)Stagger(S,1)
		else S.BPDamage(damager,damage)
		if(istype(S,/mob/NPC)&&!S.Target) S.Target=damager
		if(damage>3&&prob(damage*3)) S.Flight_Land()
mob/var/tmp/BestDefenseRate=0


mob/proc/HemoCheck()
	set waitfor=0
	HemoChecks=0
	if(HasHemophilia&&Race!="Android")
		var/BPs=0
		for(var/Icon_Obj/Effects/BloodTrail/BT in range(src,10)) BPs++
		HemoChecks=BPs*0.01
		if(HemoChecks>0.1)HemoChecks=0.1
mob/var/tmp/HemoChecks=0
mob/var/tmp/WaterChecks=0
mob/proc/WaterCheck()
	set waitfor=0
	WaterChecks=0
	if(HasKingOfTheSea)
		var/BPs=0
		for(var/turf/Terrain/Water/BT in range(src,10)) BPs++
		for(var/obj/Hazard/Drowning_Water/BT in range(src,10)) BPs++
		WaterChecks=BPs*0.01
		if(WaterChecks>0.1)WaterChecks=0.1
mob/var/tmp/FireChecks=0
mob/proc/FireCheck()
	set waitfor=0
	FireChecks=0
	if(HasFireLord)
		var/BPs=0
		for(var/obj/O in range(src,10)) if(O.Burning) BPs++
		for(var/obj/Hazard/Burning_Embers/BE in range(src,10)) BPs++
		for(var/mob/player/P in range(src,10)) if(P.Burns) BPs++
		FireChecks=BPs*0.01
		if(FireChecks>0.1)FireChecks=0.1
mob/var/tmp/SpaceChecks=0
mob/proc/SpaceCheck()
	set waitfor=0
	SpaceChecks=0
	if(HasNewType)
		var/BPs=0
		for(var/turf/Other/Stars/S in range(src,10)) BPs++
		SpaceChecks=BPs*0.01
		if(SpaceChecks>0.1)SpaceChecks=0.1

atom/proc/GetThrowResistance() return 1

atom/proc/SetThrownDamage(var/mob/other )
	throwForce = (other.Str*(other.BP))*rand(2,5)
	throwDamage = throwForce
//	if(ismob(src)) src<<"Throw Damage [throwDamage]"
//	if(ismob(other)) other<<"Throw Damage [throwDamage]"
	//..()
atom/proc/BeforeThrow()
	isThrown = 1
	//oldDensity = density
	density = 1
	hasHitAnything = 0
	if(isSpinning) Spin()
	spawn() Spin()
atom/proc/GetThrown(var/mob/other)
	var/const/t = 1
	var/throw_dir = dir
	var/prev_loc = loc
	if(isThrown) return
	thrower = other
	SetThrownDamage(other)
	var/dist = min( 2*throwDamage, 50 )
	var/oldDensity=density
	BeforeThrow()
	if(prob(50)) DustCloud(src)
	for( var/i = 0; i < dist; i++ )
		step( src, throw_dir )
		if(prev_loc == loc) break
		prev_loc = loc
		if(prob(10)) DustCloud(src)
		sleep(t)
	spawn() Spin()
	AfterThrow(other)
	density=oldDensity
atom/proc/AfterThrow(mob/thrower)
	isThrown = 0
	lastBumped = null
	if(hasHitAnything&&ismob(src))
		var/mob/M=src
		M.TakeDamage(thrower, throwDamage, "Throw")
	//density = oldDensity
	if(icon_state == "KB") icon_state = ""
mob
	SetThrownDamage(mob/other)
		..()
		Flight_Land()
		throwDamage /= GetThrowResistance()
	GetThrowResistance() return (src.End*src.BP)
	BeforeThrow( )
		KB = 1
		if(KOd==0) icon_state = _KB
		..()
	AfterThrow()
		KB = 0
		..()
		density = 1

mob/proc/CanAttackMob(mob/M, mod, bias=0)
	var/const/zanzo_max = 1000
	var/Evasion=(BP*(Off+(Spd*0.17)))/(M.BP*(M.Def+(M.Spd*0.15))) * mod
	if(M.icon_state=="Meditate") Evasion*=1.5
	var/Your_Zanzoken=min(Zanzoken, zanzo_max)
	var/Their_Zanzoken=min(M.Zanzoken, zanzo_max)
	var/Zanzoken_Boost=min(Their_Zanzoken/Your_Zanzoken, 2)
	return prob(Evasion*55/Zanzoken_Boost + bias)


mob/verb/MakeSpin()
//	usr<<"Long ago. .. there existed a form of knockback that used the KB icon state.  Then Ryu found out about the animate proc and the power it possessed to make things look nicer.  He added a testing verb called MakeSpin, which would allow him to view the animation in the single player version of RT that he hosted on his desktop to test.  The verb was great and helped him find the proper timing, however Ryu forgot to remove the verb.  Long did MakeSpin slumber before being discovered by several crafty individuals. It was a cool 1337 way of showing you were a true RT pro.  It was basically teabagging someone in RT. Then,  one of the weebs, Shumba, popularized the use of the technique in combat.  This lead to large groups of people all spamming MakeSpin, way outside of its original intended use.  As such, Ryu was forced to remove the ability due to the stress animating 10+ mobs on repeat without proper delays and staggering would put on weaker PCs.  Now we can only dream of when MakeSpin may one day rejoin the ranks of RT."

	animate(usr, transform = turn(matrix(), 90), time = 0.5)
	animate( transform = turn(matrix(), 180), time = 0.5)
	animate( transform = turn(matrix(), 270), time = 0.5)
	animate( transform = null, time = 0.5)


atom/proc/Spin(DirD)
	if(src)//istype(src,/mob/))
		if(isSpinning)
			animate(src, transform = null, time = 1)
			isSpinning=0
		else
			isSpinning=1
			while(isSpinning)
				animate(src, transform = turn(matrix(), 90), time = 1)
				sleep(1)
				animate(src,  transform = turn(matrix(), 180), time = 1)
				sleep(1)
				animate(src,  transform = turn(matrix(), 270), time = 1)
				sleep(1)
				animate(src,  transform = null, time = 1)
				sleep(1)


atom/var/tmp/grabberSTR

mob/verb
	Throw()
		set category="Skills"
		if(!CanAttack(MaxKi*0.05/StrMod)) return
	//	if(GrabbedMob && src.isGrabbing==1 && !onThrowCD)
		if(!onThrowCD)
			if(!usr.GrabbedMob) usr.Grab()
			if(usr.GrabbedMob)
				onThrowCD = 1
				spawn(usr.Refire*6) onThrowCD = 0
				usr.DrainKi(src, 1, 50,show=1)//src.DrainKi("Throw","Percent",5)
				var/atom/other = GrabbedMob
				var/mob/as_mob = other
				var/will_throw = ( istype(other, /mob) ) ? CanAttackMob(as_mob, 1) : 1
				if(other)
					other.grabberSTR=null
					if(will_throw)
						other.dir = dir
						spawn(1) other.GetThrown( src )
						//DustCloudOrigin(usr)
					else
						src.CombatOut("You failed to throw [other].")
						if(ismob(other))
							var/mob/MM=other
							MM.CombatOut("[src] failed to throw you.")
					usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] threw [GrabbedMob]\n")
					src.GrabbedMob = null
					src.isGrabbing = null
			else src.CombatOut("You have no target!")
		else src.CombatOut("Your throw is on cooldown.")
