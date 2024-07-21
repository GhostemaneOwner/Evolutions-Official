

Skill/Buff/Channel
	BP=1.4
	Pow=1.5
	Spd=1.25
	Experience=100
	//energydrain=MediumDrain
	buffon="begins channeling ki in their body."
	buffoff="stops channeling ki in their body."
	var/tmp/Clicks=0
	icon='ChannelIcon.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Force by [Pow]x and Speed by [Spd]x."
		..()*/
	verb/Channel()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/BlueCloak)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)


Skill/Buff/High_Tension
	BP=1.4
	Str=1.4
	End=1.4
	Experience=100
	energydrain=MediumDrain
	buffon="puts their body under considerable tension and powers up."
	buffoff="releases the tension in their body."
	var/tmp/Clicks=0
	layer=MOB_LAYER+1
//	pixel_x = -32
//	pixel_y = -32
	//icon = 'Pink Cloak.dmi'
	icon='Judgement_fitted.dmi'
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Strength by [Str]x and Endurance by [End]x."
		..()*/
	verb/High_Tension()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/PinkCloak)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)





Skill/Buff/Godspeed
	BP=1.4
	Spd=1.5
	Off=1.25
	Def=1.25
	energydrain=MediumDrain
	buffon="begins using their God-like speed."
	buffoff="refrains from using their God-like speed."
	Experience=100
	var/tmp/Clicks=0
	icon='SSj3ElectricTobiUchiha.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, increases Speed by [Spd]x, Offense by [Off]x, and Defense by [Def]x."
		..()*/
	verb/Godspeed()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/PurpleCloak)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)


Skill/Buff/Demonic_Fury
	RequiresApproval = 0
	Tier=4
	BP=1.5
	Anger=1.2
	energydrain=MediumDrain
	buffon="allows their rage to boil over!"
	buffoff="calms their fury."
	Experience=100
	icon='Halo Custom 2.dmi'
	layer=MOB_LAYER+1
	energydrain=MediumDrain
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x, Speed by [Spd]x and Anger by [Anger]x."
		..()*/
	verb/Demonic_Fury()
		set category="Skills"
		set src = usr.contents
		use(usr)
		usr.FirstTransWPRestore(usr,3)






Skill/Buff/Angelic_Grace
	RequiresApproval = 0
	Tier=4
	BP=1.5
	Recov=1.25
	energydrain=MediumDrain
	Experience=100
	buffon="begins emitting a radiant energy."
	buffoff="stops releasing radiant energy."
	var/tmp/Clicks=0
	icon='Halo Custom.dmi'
	layer=MOB_LAYER+1
	New()
		icon+=rgb(50,50,50)
		..()
	GetDescription()
		return "Using this ability will increase your BP by [BP]x, Speed by [Spd]x, and Recovery by [Recov]x."
		..()
	verb/Angelic_Grace()
		set category="Skills"
		set src = usr.contents
		use(usr)
		usr.FirstTransWPRestore(usr,3)

