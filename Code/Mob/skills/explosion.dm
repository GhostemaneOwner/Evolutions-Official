Skill/Attacks
	Explosion
		var/tmp/On=0
		UB1="War"
		var/tmp/Using_Explosion=0
		desc="This attack causes an explosion on the ground, the more you use it the bigger the explosion"
		Tier=3
		Experience=0
		Level=0
		verb/Ki_Settings()
			set category="Other"
			var/Max=round(Experience/25)
			if(Max>4) Max=4
			usr<<"This will increase the explosion radius. Current is [Level]. Minimum is 0. Max is [Max]"
			Level=input("Explosion Size") as num
			if(Level<0) Level=0
			if(Level>Max) Level=Max
		verb/Explosion()
			set category="Skills"
			if(!On)
				usr<<"Explosion activated, click the ground to trigger."
				On=1
			else
				usr<<"Explosion deactivated."
				On=0
		verb/Teach(mob/player/A in view(usr))
			set category="Other"
			Teachify(usr,A,"Ki")
			