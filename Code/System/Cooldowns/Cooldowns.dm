



mob
	var
		list/cooldowns=list()
		lastUpdateTime
	proc
		getCooldown(id)
			if(!cooldowns) return -1#INF
			return cooldowns[id]||-1#INF

		setCooldown(id,duration)
			if(!cooldowns) cooldowns = list()
			cooldowns[id] = (world.time+duration)

		CDUpdate()
			if(!cooldowns) cooldowns = list()
			var/list/cdl = cooldowns
			var/currentTime = world.time
			var/downtime = currentTime - lastUpdateTime
			for(var/id in cdl)
				// Adjust the cooldown time based on downtime
				if(downtime < 0)
					cdl[id] += downtime
				if(cdl[id]<world.time) cdl -= id
			lastUpdateTime = currentTime
			if(!cdl.len) cooldowns = null
/*
		onCooldown()
			if(!cooldowns) return 0
			. = -1#INF
			for(var/id in args)
				. = max(cooldowns[id],.)
			return .>world.time

		getCooldowns()
			if(!cooldowns) return -1#INF
			. = -1#INF
			for(var/id in args)
				. = max(cooldowns[id]||-1#INF,.)
			return .

// Fixed the Cooldowns.dm
*/

mob/proc/CD_Tick()
	if(!src.RPMode)
		if(BurningShotOn)
			BurningShotOn--
			if(BurningShotOn<=0)BurningShotBuffRemove()
	if(BurningDesireCD>0) BurningDesireCD--//1500 minutes
	if(RefuseToDieCD>0) RefuseToDieCD--//150 minutes
	if(SecondWindCD>0) SecondWindCD--//15 minutes
	if(LBCD>0) LBCD--// Lightning bolt, iirc
	if(TargetWarpCD>0)TargetWarpCD-- // auto warping from attack verb + zanzoken
	//CDUpdate()


//Skill/var/tmp/InCD=0 obsolete

Skill/proc/CDTick(mob/M)
	var/div=10// 1 second base
	//var/CDs=max(1,Tier)*5//5 seconds per tier with a minimum CD of 5 seconds
	var/SpeedOffset=15/M.SpdMod
	var/CDs=((1.5 + SpeedOffset)*max(1,Tier)) // minimum 1x div + Tier x SpeedOffset CD
	if(CDOverride) CDs=CDOverride // sets the CD to CDOverride x div ticks
	if(M.HasCooldownMastery) div=7//30% reduction for cooldownmastery
	OriginalCD=(CDs*div)
	M.setCooldown("[src]",CDs*div)
	//M.setCooldown("Global Cooldown",10) //GCD is disabled currently

mob/proc/CanAttack(drain,checker)
	Invisibility_Check()
	CDUpdate()
	for(var/Skill/Attacks/A in src) if(A.charging||A.streaming||A.Using) // each of charging/streaming/using used to have &&A.NoMove attached, but removed to avoid certain skills allowing combos
		CombatOut("You can not do that while using [A].")
		return 0
	if(RPMode)
		CombatOut("You can not do that in RP mode.")
		return 0
	/*if(GrabbedMob)
		CombatOut("You can not do that while grabbing [GrabbedMob].")
		return 0*/
	if(CurrentAction||KOd||KB>0)
		CombatOut("You can not do that in your current state.")
		return 0
	if(DashAttacking||attacking) return 0
	if(Ki<drain)
		CombatOut("You need [drain] energy to use [checker].")
		return 0
	if(StunCheck(src)||Frozen)
		CombatOut("You can not do that while stunned.")
		return 0
	if(istype(checker,/Skill/Weapon))
		if(!WeaponCheck())
			CombatOut("[src] requires a weapon.")
			return 0
	for(var/obj/items/Regenerator/R in range(0,src)) if(R.z)
		CombatOut("You can not do that inside a Regenerator.")
		return 0
	/*if(checker)if(getCooldown("Global Cooldown")>world.time)//Global Cooldown
		SystemOut("<font color=#ffb300>[round((getCooldown("Global Cooldown")-world.time)/10,0.1)] seconds cooldown remaining. (Global Cooldown)</font>")
		return 0*/
	if(getCooldown("[checker]")>world.time)
		if(getCooldown("[checker]")-world.time>2000) CombatOut("<font color=#ffb300>[round((getCooldown("[checker]")-world.time)/600,0.1)] minutes cooldown remaining. ([checker])</font>")
		else CombatOut("<font color=#ffb300>[round((getCooldown("[checker]")-world.time)/10,0.1)] seconds cooldown remaining. ([checker])</font>")
		return 0
	return 1
	