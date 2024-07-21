




Skill/Buff/Overdrive
	RequiresApproval = 0
	Tier=4
	buffon="begins using Overdrive."
	buffoff="stops using Overdrive."
	Str=1.35
	Pow=1.35
	BP=1.5
	energydrain=MediumDrain
	var/tmp/Clicks=0
	pixel_x = -22
//	pixel_y = -32
	icon = 'BuuAura.dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Str by [Str]x and Force by [Pow]x"
		..()*/
	verb/Overdrive()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)

Skill/Buff/Super_Overdrive
	RequiresApproval = 0
	Tier=4
	buffon="begins using Super Overdrive."
	buffoff="stops using Super Overdrive."
	Str=1.55
	Pow=1.55
	BP=1.75
	energydrain=MediumDrain
	var/tmp/Clicks=0
	pixel_x = -22
//	pixel_y = -32
	icon = 'Dark Red Aura.dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Str by [Str]x and Force by [Pow]x"
		..()*/
	verb/Super_Overdrive()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)

