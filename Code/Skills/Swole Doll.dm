/*Skill/Buff/Super_Saiyan_5
	BP=3.55
	Spd=2.45
	Off=2.35
	Experience=100
//energydrain=MediumDrain
	buffon="screams with pure rage as there power boils over transforming into a Super Saiyan 5."
	buffoff="chuckles as they close there eye's as there fur from there transformation sheds to the ground."
	icon='PaleAura.dmi'
	pixel_x=-48
	pixel_y=-10
	alpha=175
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x. Also causes you to ignore limb damage."
		..()*/
	verb/Super_Saiyan_5()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,1)*/
//	verb/Teach(mob/player/A in view(usr))
//		set category="Other"
//		Teachify(usr,A)


Skill/Buff/SSj5
	RequiresApproval = 0
	BP=3.55
	Spd=2.45
	Off=2.35
	Experience=100
	buffon="screams with pure rage as there power boils over transforming into a Super Saiyan 5."
	buffoff="'s energy returns to normal."
	var/tmp/Clicks=0
	icon='Burst.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "You have awakened to the true power of the Doll. You have survived through hardship and have EARNED true power.([BP]x BP, [Str]x Strength, [End]x Endurance, [Spd]x Speed)"
		..()*/
	verb/SSj5_Revert()
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0)


Skill/Buff/Soul_Doll
	RequiresApproval = 0
	Tier=4
	BP=1.5
	Pow=1.3
	Str=1.3
	Off=1.2
	Def=1.2
	Experience=100
	energydrain=MediumDrain
	buffon="begins to harness the power of a Soul Spirit Doll."
	buffoff="'s energy returns to normal."
	var/tmp/Clicks=0
	icon='Burst.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "You have awakened to the true power of the Doll. You have survived through hardship and have EARNED true power.([BP]x BP, [Pow]x Force, [Off]x Offense, [Def]x Defense)"
		..()*/
	verb/Soul()
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0)

