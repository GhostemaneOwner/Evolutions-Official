
Skill/Buff/Spell_Force
	buffon="begins using Spell Force."
	buffoff="stops using Spell Force."
	Tier=4
	BP=1.5
	Spd=1.2
	Pow=1.15
	Def=1.35
	//energydrain=MediumDrain
	var/tmp/Clicks=0
	icon='blackflameaura.dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription(mob/Getter)
		return "Using this ability drains a constant amount of energy. While using this your BP increase by [BP]x, Force will increase by [Pow]x, but decrease your Strength by [Str]x."
		..()*/
	New()
		src.icon+=rgb(rand(1,225),rand(1,225),rand(1,225))
		..()
	verb/Spell_Force()
		set name = "Spell Force"
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,0)
		