

Skill/Buff/Armament
	BP=1.4
	Spd=1.25
	Str=1.2
	Off=1.25
//	energydrain=MediumDrain
	Experience=100
	buffon="begins to harness the power of a true swordsman."
	buffoff="stops using Armament."
	var/tmp/Clicks=0
	icon='SatsuiAura2.dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription(mob/Getter)
		return "While using this your Strength is multiplied by [Str]x, your BP by [BP]x, Speed by [Spd]x and Offense by [Off]x."
		..()*/
	New()
		src.icon+=rgb(rand(1,115),rand(1,115),rand(1,115))
		..()
	verb/Armament()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,1)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
