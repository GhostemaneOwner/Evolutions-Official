
mob/var/HasThornsOn=0

Skill/Buff/BestialWrath
	BP=2.1
	Str=1.2
	Pow=1.2
	End=1.2
	Off=1.32
	Def=1.32
	Regen=1.2
	Experience=100
	buffon="unleashes their Bestial Wrath."
	buffoff="tames their Wrath."
	energydrain=MediumDrain
	layer=MOB_LAYER+1
	var/tmp/Clicks=0
	icon='Sparks LSSjG.dmi'
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x. Also causes your damager to take 35% of the damage they cause you but no more than 5 per tick and no less than 0.05 per tick."
		..()*/
	verb/Bestial_Wrath()
		set category="Skills"
		set src = usr.contents
		if(usr.GodKiActive)
			if(!usr.FBMAchieved) energydrain=MediumDrain
			else energydrain=LowDrain
			use(usr,0,0,0,1)
		else usr<<"You need to have God Ki enabled to use this!"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

