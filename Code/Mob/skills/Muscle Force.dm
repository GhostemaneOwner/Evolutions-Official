

Skill
	layer=MOB_LAYER+1
Skill/Buff/Muscle_Force
	buffon="begins focusing their energy into their muscles."
	buffoff="stops focusing their energy into their muscles."
	BP=1.3
	Str=1.45
	Pow=0.8
	Experience=100
	Tier=2
	DoesNotStackWith="Ki Force"
//	energydrain=LowDrain
	icon='Judgement_fitted.dmi'
	New()
		icon-=rgb(rand(1,100),rand(1,100),rand(1,100))
		..()
	/*GetDescription()
		return "Muscle Force: [BP]x BP [Str]x Str [Pow]x Force"
		..()*/
	verb/Muscle_Force()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)




