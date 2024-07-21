




Skill/Misc/Jump_Backwards
	CDOverride=10
	Experience=100
	desc="This will allow you to leap backwards and attempt to evade attacks."
	verb/Jump_Backwards()
		set category="Skills"
		set instant=1
		if(usr.RPMode) return
		if(usr.KOd) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if((usr.getCooldown("[src]")>world.time))
			return
		if(usr.move&&!usr.KB&&usr.KOd==0&&usr.icon_state!="Meditate"&&usr.icon_state!="Train")
			var/turf/X=get_step(usr,usr.dir)
			var/OldDir=usr.dir
			var/Leaps=rand(1,3)+usr.SpdMod
			usr.DrainKi(src,"Percent",1)
			Leaps+=usr.HasEvasion
			CDTick(usr)
			animate(usr,pixel_z=12,time=3)
			Create_Shadow(usr)
			var/matrix/State1=matrix()
			State1.Scale(0.9,0.45)
			animate(usr.Shadow,alpha=190,transform=State1,time=3)
			while(Leaps>0&&src)
				if(usr&&X) step_away(usr,X,5)
				usr.dir=OldDir
				Leaps--
				sleep(1)
			animate(usr,pixel_z=0,time=3)
			var/matrix/LandingState=matrix()
			LandingState.Scale(1,0.5)
			animate(usr.Shadow,alpha=255,transform=LandingState,time=3)
			RemoveShadow(usr)

Skill/Misc/Resist
	Tier=2
	Experience=100
	UB1="Kaioken"
	UB2="Shadow King"
	desc="This will allow you to break any existing crowd control at the cost of 10% energy. Grants the default period of immunity. Removes bleeds, burns and any other debuffs."
	verb/Resist()
		set category="Skills"
		set instant=1
		if(usr.RPMode) return
		if(usr.KOd) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.getCooldown("[src]")>world.time)
			return
		if(!usr.HasWillUnbroken)
			usr.DrainKi(src,"Percent",10)
			CDTick(usr)
		else usr.DrainKi(src,"Percent",3)
		for(var/mob/player/teleg in view(usr)) teleg.BuffOut("[usr] resists their restraints and breaks free!")
		usr.SlowDuration=0
		usr.Slow=0
		usr.SlowImmune=world.time+20+usr.KBResist
		usr.Stagger=0
		var/image/_overlay = image('Stun.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay
		var/image/_overlay2 = image('Slow Overlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay2
		usr.StaggerImmune=world.time+20+usr.KBResist
		var/image/_overlay3 = image('TimeFreeze.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay3
		var/image/_overlay4 = image('stunoverlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
		usr.overlays -= _overlay4
		usr.Stunned=0
		usr.StunImmune=world.time+20+usr.KBResist
		usr.Wing_Clipped=0
		usr.GuardBroken=0
		usr.Bleeds=0
		usr.BleedTicks=0
		usr.Burns=0
		usr.BurnTicks=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

mob/proc/KnockBack(mob/P)
	set waitfor=0
	if(Frozen) return
	var/Old_State=""
	var/OldDir=dir
	var/turf/X=P
	KBStr=0
	if(ismob(P))
		KBStr=P.BP
		X=P.loc
	if(!KBStr||KBStr==0)KBStr=100
	if(istype(src,/mob/NPC)) Old_State=icon_state
	if(KB>20) KB=20
	if(!KB) return
	if(prob(KB*3)) if(Flying) Flight_Land()
	if(src.KOd==1) if(!istype(src,/mob/NPC)) Old_State="KO"
	if(src.Flying) Old_State="Fly"
	var/crater=0
	if(LethalCombatTracker&&prob(30)) crater=1
	if(KB>4) crater=1
	if(KB>9) crater=2
	//DustCloudOrigin(P)
	if(prob(50)) ShockwaveScale(src,KBStr,1)
	if(prob(20)) crater=0
	if(locate(/Icon_Obj/Effects/KBHole1) in loc) crater=0
	if(locate(/Icon_Obj/Effects/KBHole2) in loc) crater=0
	if(crater==1) KBHole1(src,get_dir(X,src),SE=1)
	if(crater==2) KBHole2(src,get_dir(X,src),SE=1)
	while(src&&src.KB>0)
		if(!src) break // Sanity check
		if(KBResist) if(prob(KBResist*5+(HasSturdyBuild*5)))
			src.CombatOut("You resist some knockback.")
			src<<"You resist some knockback."
			src.KB-=KBResist
		if(KB>1) for(var/Skill/Attacks/A in src) if(A.streaming) BeamStop(A)
		if(prob(10*KB)) DustCloud(src)
		if(!istype(src,/mob/NPC)) animate(src, icon_state="KB", time = 3)//src.icon_state="KB"
		src.Knockback()
		if(LethalCombatTracker) if(prob(30))
			if(Race=="Android"||AndroidLevel&&prob(50)) OilTrail(src)
			else BloodTrail(src)
		if(prob(30)) Quake_Effect(3)
		OldDir=dir
		if(src&&X) step_away(src,X,20)
		dir=OldDir
		if(crater==1) KBHole1(src,get_dir(X,src))
		if(crater==2) KBHole2(src,get_dir(X,src))
		src.KB--
		sleep(1)
		if(src) animate(src, icon_state=Old_State)
		if(!KB) break
	if(src) animate(src, icon_state=Old_State)
	if(KOd)if(!istype(src,/mob/NPC))  icon_state="KO"
	KB=0
	KBStr=0
	if(crater==1) KBHole1(src,get_dir(X,src),SE=2)
	if(crater==2) KBHole2(src,get_dir(X,src),SE=2)
	if(crater==2&&prob(60)) Crater(src)



