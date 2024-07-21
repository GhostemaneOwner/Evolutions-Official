
//var/list/AugmentedMortals=new


Skill/Buff/Thugged_Rage
	BP=1.5
	Str=1.5
	Recov=1.3
	//energydrain=LowDrain
	buffon="'s power suddenly increases greatly!"
	buffoff="'s power returns to normal."
	icon='SSBGlow.dmi'
	pixel_x=-32
	pixel_y=-32
	alpha=200
	layer=MOB_LAYER+1
	/*GetDescription()
		return"[BP]x BP at the cost of 30% of your recovery ticks. Also reduces the impact low energy has on your BP. (100-70% instead of 100-0% scaling based on current energy)"
		..()*/
	verb/Thugged_Rage()
		set category="Skills"
		use(usr,null,2)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A) //Teachable - By a Rank
		