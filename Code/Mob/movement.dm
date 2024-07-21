
mob/Move(NewLoc, Direct)	//Move requirements was remvoed because it was redundant
	//var/atom/Former_Location = loc
	if(RPMode) return
	if(afk){ src.TRIGGER_AFK(1);return }
	if(KB>0 ) ..()
	if(Frozen) return
	if(move==0) return
	if(!Target && ghostDens_check(src)) return ..()
	else //if(..())
		move=0	//If move=0 you no move ok
		var/Delay=(3/SpdMod)/SpdMult
		/*var/DelayOff=(Spd/5000)
		if(DelayOff<1) DelayOff=1
		if(DelayOff>1.2) DelayOff=1.2
		Delay/=DelayOff*/
		if(Health>0&&!undelayed&&Health<60) Delay*=60/max(1,Health)
		if(Delay>10/SpdMod/SpdMult) Delay=(10/SpdMod)/SpdMult
		if(Delay < 1) Delay = 1
		if(Flying)
			density = 0
			Delay *= 0.7
			if(SuperFly) Delay*=0.5
			if(HasFlightMaster) Delay*=0.7
		for(var/Skill/Attacks/A in src) if(A.charging&&A.NoMove==0) Delay*=2
		if(Health<20) Delay*=(20/max(1,Health))
		if(Slow) Delay+=Slow
		if(Stagger)
			Delay+=15
			StaggerCheck(src)
		if(BonusSpeed) Delay-=BonusSpeed
		if(HasEpinephrine) Delay*=0.5
		if(Delay <= 1) Delay=1
		if(Delay >=50) Delay=50
		if(HasFleetOfFoot&&!Flying) Delay-=HasFleetOfFoot*0.05
		spawn(round(Delay,0.1)) move=1
		if(istype(loc, /turf/Other/Stars))
			if(Flying)
				..()
		else
			..()
		if(adminDensity) density=0
		else density=1
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
			Creating=0
			usr<<"You were interrupted."
		Save_Location()
		if(client)
			if(!KB && Target && !inertia_dir && istype(Target,/obj/Build)) Build_Lay(Target,src)
			for(var/obj/items/Transporter_Pad/A in loc) A.Transport()
		if(Shadow) Shadow_Chase(src)//Makes the Shadow follow
// AI call START
/*
/*		for(var/NPC_AI/A in oview(12) )
			if( !A.awake && !A.wander ) // If it's awake (attacking) then it's not wandering. If it's wandering then it's not attacking.
				A.target=src
				A.Activate_AI()*/
			if (A.awake && A.wander) // Sanity check?
				world.log << "DEBUG WARNING: Both 'awake' and 'wander' were at 1 ! This isn't supposed to be possible!"
				A.awake = 0
				A.wander = 0
*/
// AI call END
/*

mob/proc/Edge_Check(turf/Former_Location)
	for(var/mob/A in loc) if(A!=src&&A.Flying&&Flying)
		loc=Former_Location
		break
	for(var/obj/Door/A in loc) if(A.density)
		loc=Former_Location
		Bump(A)
		break
	for(var/obj/Blocker/A in loc) if(A.density)
		loc=Former_Location
		break
	if(!Flying)//&&!Flyer
		var/turf/T=get_step(Former_Location,dir)
		if(T)
			if(!T.Enter(src)) return
			for(var/obj/Props/Edges/A in loc)
				if(A.dir==turn(dir,180))
					loc=Former_Location
					break
			for(var/obj/Props/Edges/A in Former_Location) if(A.dir==dir)
				loc=Former_Location
				break*/
mob/proc/Save_Location() if(z&&!Regenerating)
	src.savedX=x
	src.savedY=y
	src.savedZ=z

mob/verb
	lookN()
		set category=null
		set instant=1
		set name=".lookN"
		if(AdminMode) return
		if(move==0) return
		dir=1
	lookS()
		set category=null
		set instant=1
		set name=".lookS"
		if(AdminMode) return
		if(move==0) return
		dir=2
	lookE()
		set category=null
		set instant=1
		set name=".lookE"
		if(AdminMode) return
		if(move==0) return
		dir=4
	lookW()
		set category=null
		set instant=1
		set name=".lookW"
		if(AdminMode) return
		if(move==0) return
		dir=8
	lookNE()
		set category=null
		set instant=1
		set name=".lookNE"
		if(AdminMode) return
		if(move==0) return
		dir=5
	lookNW()
		set category=null
		set instant=1
		set name=".lookNW"
		if(AdminMode) return
		if(move==0) return
		dir=9
	lookSE()
		set category=null
		set instant=1
		set name=".lookSE"
		if(AdminMode) return
		if(move==0) return
		dir=6
	lookSW()
		set category=null
		set instant=1
		set name=".lookSW"
		if(AdminMode) return
		if(move==0) return
		dir=10

client/verb
	strafeN()
		set category=null
		set instant=1
		set name=".strafeN"
		if(usr.AdminMode) return
		north = 1
		var/new_dir
		if(east)
			if(!mob.Allow_Move(NORTHEAST,1)) return
			new_dir = NORTHEAST
		else if(west)
			if(!mob.Allow_Move(NORTHWEST,1)) return
			new_dir = NORTHWEST
		else
			if(!mob.Allow_Move(NORTH,1)) return
			new_dir = NORTH
		var/turf/T = get_step(usr, new_dir)
		usr.Move(T,usr.dir)
	strafeS()
		set category=null
		set instant=1
		set name=".strafeS"
		if(usr.AdminMode) return

		south = 1
		var/new_dir
		if(east)
			if(!mob.Allow_Move(SOUTHEAST,1)) return
			new_dir = SOUTHEAST
		else if(west)
			if(!mob.Allow_Move(SOUTHWEST,1)) return
			new_dir = SOUTHWEST
		else
			if(!mob.Allow_Move(SOUTH,1)) return
			new_dir = SOUTH
		var/turf/T = get_step(usr, new_dir)
		usr.Move(T,usr.dir)
	strafeE()
		set category=null
		set instant=1
		set name=".strafeE"
		if(usr.AdminMode) return

		east = 1
		var/new_dir
		if(north)
			if(!mob.Allow_Move(NORTHEAST,1)) return
			new_dir = NORTHEAST
		else if(south)
			if(!mob.Allow_Move(SOUTHEAST,1)) return
			new_dir = SOUTHEAST
		else
			if(!mob.Allow_Move(EAST,1)) return
			new_dir = EAST
		var/turf/T = get_step(usr, new_dir)
		usr.Move(T,usr.dir)
	strafeW()
		set category=null
		set instant=1
		set name=".strafeW"
		if(usr.AdminMode) return

		west = 1
		var/new_dir
		if(north)
			if(!mob.Allow_Move(NORTHWEST,1)) return
			new_dir = NORTHWEST
		else if(south)
			if(!mob.Allow_Move(SOUTHWEST,1)) return
			new_dir = SOUTHWEST
		else
			if(!mob.Allow_Move(WEST,1)) return
			new_dir = WEST
		var/turf/T = get_step(usr, new_dir)
		usr.Move(T,usr.dir)
	strafeNE()
		set category=null
		set instant=1
		set name=".strafeNE"
		if(usr.AdminMode) return
		if(!mob.Allow_Move(NORTHEAST,1)) return
		var/turf/T = get_step(usr, NORTHEAST)
		usr.Move(T,usr.dir)
	strafeNW()
		set category=null
		set instant=1
		set name=".strafeNW"
		if(usr.AdminMode) return
		if(!mob.Allow_Move(NORTHWEST,1)) return
		var/turf/T = get_step(usr, NORTHWEST)
		usr.Move(T,usr.dir)
	strafeSE()
		set category=null
		set instant=1
		set name=".strafeSE"
		if(usr.AdminMode) return
		if(!mob.Allow_Move(SOUTHEAST,1)) return
		var/turf/T = get_step(usr, SOUTHEAST)
		usr.Move(T,usr.dir)
	strafeSW()
		set category=null
		set instant=1
		set name=".strafeSW"
		if(usr.AdminMode) return
		if(!mob.Allow_Move(SOUTHWEST,1)) return
		var/turf/T = get_step(usr, SOUTHWEST)
		usr.Move(T,usr.dir)

client/North()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(NORTH)) return ..()
client/South()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(SOUTH)) return ..()
client/East()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(EAST)) return ..()
client/West()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(WEST)) return ..()
client/Northwest()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(NORTHWEST)) return ..()
client/Northeast()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(NORTHEAST)) return ..()
client/Southwest()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(SOUTHWEST,)) return ..()
client/Southeast()
	set instant = 1
//	mob.FollowTarget=null
	if(mob.Allow_Move(SOUTHEAST)) return ..()



mob/proc/Allow_Move(D,Strafing=0)
	if(AdminMode)
		var/mob/Admin_Mode/A = src.controlled
		if(A)
			step(A,D)
			return
	if(Frozen) return
	if(KB>1) return
	if(KOd) return
	if(StunCheck(src)) return 0
	if(prob(TicksOfMerriment/50))
		step_rand(src)
		return
	if(icon_state in list("KB","Train","Meditate", "KO") || !move || Frozen) return 0
	if(CurrentAction) return 0
	if(!Strafing) dir=D
	for(var/Skill/Attacks/A in src) if(A.charging&&A.NoMove||A.streaming||A.Using) return 0
	if(grabberSTR) for(var/mob/A in view(1,usr)) if(A.GrabbedMob==usr&&A.isGrabbing==1)
		if(prob((Str*BP/grabberSTR)+5))
			for(var/mob/MV in view(usr))
				MV.CombatOut("[usr] breaks free of [A]!")
				MV.ICOut("[usr] breaks free of [A]!")
			A.isGrabbing=null
			attacking=0
			A.attacking=0
			grabberSTR=null
			A.GrabbedMob=null
		else
			for(var/mob/MV in view(usr)) MV.CombatOut("[usr] struggles against [A]")
		return 0
	else if(S&&S.Fuel>0)
		if(!S.Moving)
			S.Moving=1
			S.MoveReset()
			if(S) if(S.z!=12) S.density=0
			step(S,D)
			if(S)
				if(S.last_move) S.inertia_dir = S.last_move
				if(S.z!=12) S.density=1
				S.Fuel()
		return 0
	else if(S&&S.Fuel<=0)
		src<<"Out of fuel."
		return
	for(var/atom/A in get_step(src,D)) if(A.density)
		if(!ghostDens_check(src)&&(!Flying))
			Bump(A)
			return 0
	for(var/mob/A in get_step(src,D)) if(A.Flying&&Flying) if(!ghostDens_check(src))return 0
	for(var/obj/Door/A in get_step(src,D)) if(A.density)
		Bump(A)
		if(!ghostDens_check(src))return 0
	if(!Flying)
		var/turf/T=get_step(src,D)
		if(T)
			if(!T.Enter(src)) return
			for(var/obj/Props/Edges/A in T) if(A.dir in list(turn(D,180),turn(D,225),turn(D,-225))) if(!ghostDens_check(src)&&(!Flying))return 0
			for(var/obj/Props/Edges/A in loc) if(A.dir in list(D,turn(D,45),turn(D,-45))) if(!ghostDens_check(src)&&(!Flying))return 0
	return 1
	