


mob
	var
		tmp/targetoverlay//the overlay for the target you have selected
	proc
		getTarget(var/mob/M)//name of the proc
			clearTarget()//clear target before assinging, fixes perma target overlay
			//if(M != src)	//attacking yourself is bad form
			if(Target==null)//if if you have no target
				Target = M				//get the target
				if(client)//if it is a client(real person)
					targetoverlay = image('target.dmi',M,pixel_x=-4+M.HealthBar.pixel_x,pixel_y=-8+M.HealthBar.pixel_y)//calls icon from life.dmi, attaches icon to mob, icon state = flash
					usr << targetoverlay  //only allow the usr to see it
					usr<<"Target acquired. ([M])"
			else clearTarget()
		clearTarget()
			del(targetoverlay)//remove the target's overlay
			if(Target)
				Target = null//no more target
				usr<<"Target cleared."

mob/verb/Target()
	set category="Other"
	if(Target) clearTarget()
	else
		var/mob/M=input("Target...") as null|mob in view(20)
		if(M) usr.getTarget(M)

mob/verb/Set_Target(var/mob/M in oview(20)) usr.getTarget(M)
mob/verb/ClearTarget() clearTarget()

mob/verb/TargetNearby()
	var/list/CanT=list()
	for(var/mob/P in oview(7,usr)) if(P!=usr.Target) CanT+=P
	var/mob/M=pick(CanT)
	if(M) usr.getTarget(M)
	else clearTarget()
mob/proc/TargetCheck() if(ismob(Target))
	if(istype(src,/mob/NPC))
		if(Target.z!=z) clearTarget()
		if(get_dist(src,Target)>30)clearTarget()
	else
		if(!src.client.holder)
			if(Target.z!=z) clearTarget()
			if(get_dist(src,Target)>30) clearTarget()


