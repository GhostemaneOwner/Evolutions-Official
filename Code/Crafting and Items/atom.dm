

atom/var
	tmp
		isSpinning
		isThrown
		mob/thrower
		//onThrowCD = 0
		debugThrowing
		throwDamage
		throwForce
		//oldDensity
		hasHitAnything
		lastBumped
	const
		_KB = "KB"

atom/proc/GetPronoun() 
	switch(gender)
		if("male")
			return "he"
		if("female")
			return "she"
		if("Male")
			return "he"
		if("Female")
			return "she"
		else
			return "it"
atom/movable
	Bump(atom/other)
		lastBumped = other
		if(isThrown) //OnThrownInto(other)
			var/mob/as_mob = other
			var/will_hit = 1
			if(thrower && istype(other, /mob) ) will_hit = thrower.CanAttackMob(as_mob, 1)
			if(will_hit)
				src << "You were thrown into [other.name]!"
				spawn(10) if(src) lastBumped = null
				other << "[src] was just thrown into you!"
				spawn(10) if(other) other.lastBumped = null
				if(!hasHitAnything) hasHitAnything = 1
			else
//				flick(other.CustomZanzokenIcon,other)
				src.x = other.x
				src.y = other.y
				src.z = other.z

/atom/movable/var/
	tmp/inertia_dir		//Which direction we're floating through space
	tmp/moved_recently
	tmp/last_move	//dir we moved last
	tmp/m_flag
	tmp/l_move_time	//last world.timeofday we moved
	tmp/move_speed	//How often we're moving
				//Gonna use it for proximity checks, move slow enough and you can get past shit
//	savedX	//Self explanatory?
//	savedY
//	savedZ
	anchored = 0	//Whether or not it'll float through space, or if it can be pushed (not coded yet)

/atom/movable/overlay/New()
	for(var/x in src.verbs)
		src.verbs -= x
	return

/atom/movable/Move()
	var/atom/A = src.loc
	. = ..()
	src.move_speed = world.timeofday - src.l_move_time
	src.l_move_time = world.timeofday
	src.m_flag = 1
	if ((A != src.loc && A && A.z == src.z))
		src.last_move = get_dir(A, src.loc)
		src.moved_recently = 1
	return

