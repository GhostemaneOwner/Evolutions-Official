/mob/proc/reset_view(atom/A) if(!usr.SolarFlared)
	if(src.client)
		if(S)
			if(PilotLocation) usr.loc=PilotLocation
			else loc=S.loc
			S.Pilot=null
			S=null
		if(istype(A, /atom/movable))
			src.client.perspective = EYE_PERSPECTIVE
			src.client.eye = A
		else
			if(isturf(src.loc))
				src.client.eye = src.client.mob
				src.client.perspective = MOB_PERSPECTIVE
			else
				src.client.perspective = EYE_PERSPECTIVE
				src.client.eye = src.loc
	return

/mob/verb/cancel_camera()
	set name = "Reset View"
	set category = null
	//Observee=null
	for(var/mob/player/M in Players) if(M.Observer==usr.key) M.Observer=null
	src.reset_view(null)

/client/proc/Watch(var/mob/M in Players)	//This is what admin.. observing is now, so to speak
	set name = "Watch"
	set category = "Admin"

	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(src.mob)
		usr.Get_Observe(M)
	else
		alert("You've got no mob guy! That isn't good!")
		return
		