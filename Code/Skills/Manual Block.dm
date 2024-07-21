

mob/var/tmp/Blocking=0
Skill/Misc/Block//adds stagger to attacks for next 20 seconds
	Experience=100
	Tier=1
	desc="Reduces your Speed and Defense by 20% for 5 seconds in exchange for +40% Endurance. This will also increase chance to deflect projectiles by 30% and give 30% flat damage reduction for the duration."
	verb/Block()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<350) return
		if(!usr.CanAttack(350,src)) return
		usr.Blocking=3
		if(usr.SwordOn||usr.HammerOn||usr.KiBlade) for(var/mob/player/P in view(usr)) P.BuffOut("[usr] raises their weapon to block an attack.")
		else  for(var/mob/player/P in view(usr)) P.BuffOut("[usr] raises their hands to block an attack.")
		CDTick(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

