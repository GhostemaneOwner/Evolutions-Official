



Skill/Buff/Limit_Breaker
	Tier=4
	buffon="begins to exceed their limit!"
	buffoff="'s limitations return to normal."
	Regen=1.2
	Spd=1.25
	BP=1.45
	//healthdrain=0.6
	Experience=100
	energydrain=0.5
	
	/*GetDescription(mob/Getter)
		return "This will give you [Regen]x Regen, [Spd]x Spd and [BP]x BP."
		..()*/
	icon='Flame Aura.dmi'
	pixel_x=-32
	pixel_y=-8
	layer=MOB_LAYER+3
	verb/Limit_Breaker()
		set category="Skills"
		use(usr,null,0,0,0,0,0,0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

