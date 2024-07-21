
Skill/Buff/Fists_Of_Fury
	buffon="begins using Fists of Fury."
	buffoff="stops using Fists of Fury."
	BP=1.65
	Off=1.55
	Def=1.55
	Spd=1.4
	//energydrain=MediumDrain
	Spd=1.25
	icon='GaoGaoFists.dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription()
		return "Using this unlocks your normally latent inner combat proticals.  You cease being anything but a killing machine until your energy depletes or your primary drive re-engages. ([BP]x BP, [Off]x Offense, and [Def]x Defense)"
		..()*/
	verb/Fists_Of_Fury()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)


Skill/Buff/Machine_Force
	buffon="begins using Machine Force"
	buffoff="stops using Machine Force."
	BP=1.4
	Off=1.35
	Def=1.35
	energydrain=MediumDrain
	Spd=1.25
	icon='GaoGaoFists.dmi'
	layer=MOB_LAYER+1
	Experience=100
	/*GetDescription()
		return "Using this unlocks your normally latent inner combat proticals.  You cease being anything but a killing machine until your energy depletes or your primary drive re-engages. ([BP]x BP, [Off]x Offense, and [Def]x Defense)"
		..()*/
	verb/Machine_Force()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
		