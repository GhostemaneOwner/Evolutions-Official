

Skill/Buff/Death
	//Death
	BP=1.4
	Spd=1.3
	Off=1.25
	Experience=100
	energydrain=MediumDrain
	buffon="uses the Aura of Death."
	buffoff="stops using the Aura of Death."
	icon='PaleAura.dmi'
	pixel_x=-48
	pixel_y=-10
	alpha=175
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x. Also causes you to ignore limb damage."
		..()*/
	verb/Death()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,1)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

Skill/Buff/War
	//War
	BP=1.4
	Str=1.3
	Pow=1.3
	Off=1.25
	Experience=100
	energydrain=MediumDrain
	buffon="uses the Aura of War."
	buffoff="stops using the Aura of War."
	icon='SSRAura1.dmi'
	pixel_x=-48
	pixel_y=-10
	alpha=175
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Strength by [Str]x, Force by [Pow]x, and Offense by [Off]x. Also causes you to ignore limb damage."
		..()*/
	verb/War()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/War,0,0,1)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

Skill/Buff/Famine
	//Famine
	BP=1.4
	Regen=1.3
	Recov=1.4
	energydrain=MediumDrain
	Experience=100
	buffon="takes on a guant appearance and has a foul odor."
	buffoff="loses aura of pestilence."
//	icon='Death.dmi'
//	pixel_x=-48
//	pixel_y=-10
	alpha=175
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	icon='Pest.dmi'
	pixel_x=-32
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Speed by [Spd]x, Regeneration by [Regen]x, and Recovery by [Recov]x. Also causes you to ignore limb damage."
		..()*/
	verb/Famine()
		set category="Skills"
		set src = usr.contents
		use(usr,null)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)


Skill/Buff/FungalPlague
	//Pestilence
	BP=1.4
	End=1.4
	Def=1.4
	Experience=100
	energydrain=0.5
	buffon="bathes themselves in the Aura of Pestilence!"
	buffoff="stops channeling the Aura of Pestilence."
	icon='Death.dmi'
	pixel_x=-48
	pixel_y=-10
	alpha=175
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	New()
		..()
		icon+=rgb(10,75,0)
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Endurance by [End]x, and Defense by [Def]x. Also causes you to ignore limb damage."
		..()*/
	verb/Pestilence()
		set category="Skills"
		set src = usr.contents
		use(usr,'Flies.dmi')
		