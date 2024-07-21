
Skill/Buff/Weapon_Force
	buffon="weaponizes their soul."
	buffoff="expels their power, and reverts."
	Tier=4
	BP=1.55
	Spd=1.2
	Str=1.15
	Off=1.35
	energydrain=MediumDrain
	var/tmp/Clicks=0
	icon='Fierce Aura(Blue).dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription(mob/Getter)
		return "While using this your Strength is multiplied by [Str]x, your BP by [BP]x, Speed by [Spd]x and Offense by [Off]x."
		..()*/
	New()
		src.icon+=rgb(rand(1,115),rand(1,115),rand(1,115))
		..()
	verb/Weapon_Force()
		set name = "Weapon Force"
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0)

Skill/Buff/Foresight
	buffon="begins to peer deeper into the future."
	buffoff="relaxes their grasp on the future."
	Tier=4
	BP=1.4
	Spd=1.3
	Def=1.35
	energydrain=MediumDrain
	var/tmp/Clicks=0
	icon='SSBSparks.dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription(mob/Getter)
		return "While using this your Strength is multiplied by [Str]x, your BP by [BP]x, Speed by [Spd]x and Offense by [Off]x."
		..()*/
	New()
		src.icon+=rgb(rand(1,115),rand(1,115),rand(1,115))
		..()
	verb/Foresight()
		set name = "Foresight"
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0)
		