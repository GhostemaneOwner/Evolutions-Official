
mob/var/tmp/KBStr=0
mob/var/tmp/AerialRecovery=1
mob/proc/AerialRecovery() if(AerialRecovery)
	var/ProbMult=1
	if(KBStr) ProbMult=BP/KBStr
	if(prob(50*ProbMult))
		KB=0
		AerialRecovery=0
		for(var/mob/player/P in view(src)) P.BuffOut("[src] has endured the hit!")
		spawn(rand(400,600))
			src<<"You feel you can resist another knockback."
			AerialRecovery=1
//When Flying and knocked back you have a chance to resist KB - SR Team