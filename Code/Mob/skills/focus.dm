

Skill
	layer=MOB_LAYER+1
Skill/Buff/Focus
	BP=1.3
	Spd=1.3
	Regen=1.25
	Tier=2
	//energydrain=LowDrain ///
	staticenergydrain=LowStaticDrain
	buffon="begins focusing their energy."
	buffoff="stops focusing."
	Experience=100
	icon='blue elec.dmi'
	/*GetDescription()
		return "Using this ability drains a constant amount of energy, the drain will be less depending on \
	your max energy and recovery. While using this your BP increases by [BP]x, Speed by [Spd]x and Regeneration by [Regen]x for as long as your energy holds out or you stop using the form."
		..()*/
	verb/Focus()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)




