


mob/proc/Shockwave_Knockback(Amount,turf/A) spawn if(src)
	KB+=Amount
	KnockBack(A)


obj/proc/Shockwave_Knockback(Amount,turf/A) spawn if(src)
	while(Amount)
		Amount-=1
		step_away(src,A,20)
		sleep(1)

mob/proc/Blast_Absorb_Graphics()
	overlays+='Black Hole.dmi'
	spawn(6) overlays-='Black Hole.dmi'
