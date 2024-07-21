Skill/Buff/Demonic_Ascension
	BP=1.85
	RequiresApproval=0
	Tier=4
	Str=1.45
	End=1.45
	Def=1.4
	energydrain=MediumDrain
	buffon="screams in essance of Rage as they Unlock Demonic Ascension."
	buffoff="stops using Demonic Ascension"
	Experience=100
	var/tmp/Clicks=0
	icon='Judgement_fitted.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Strength by [Str]x, Force by [Pow]x while increasing Offense by [Off]x, Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	verb/Demonic_Ascension()
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)


Skill/Buff/Infected_Tuffle_State
	BP=1.55
	RequiresApproval=0
	Tier=4
	Str=1.2
	Pow=1.2
	End=1.2
	Spd=1.1
	Off=1.2
	Def=1.2
	//energydrain=MediumDrain
	buffon="reaches up and grips there forehead as they begin to enter Infected State"
	buffoff="stops using Infected State"
	Experience=100
	var/tmp/Clicks=0
	icon='Judgement_fitted.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Strength by [Str]x, Force by [Pow]x while increasing Offense by [Off]x, Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	verb/Infected_Tuffle_State()
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)


Skill/Buff/Drunken_Tai_Form
	BP=1.3
	RequiresApproval=0
	Tier=4
	Str=1.2
	Pow=1.2
	End=1.2
	Spd=1.1
	Off=1.2
	Def=1.2
	//energydrain=MediumDrain
	buffon="begins using Drunken Tai Form."
	buffoff="stops using Drunken Tai Form."
	Experience=100
	var/tmp/Clicks=0
	icon='Judgement_fitted.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Strength by [Str]x, Force by [Pow]x while increasing Offense by [Off]x, Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	verb/Drunken_Tai_Form()
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)





Skill/Buff/Super_Perfect_Form
	BP=1.3
	RequiresApproval=0
	Tier=4
	Str=1.2
	Pow=1.2
	End=1.2
	Spd=1.1
	Off=1.2
	Def=1.2
	energydrain=MediumDrain
	buffon="begins using Super Perfect Form."
	buffoff="stops using Super Perfect Form."
	Experience=100
	var/tmp/Clicks=0
	icon='Judgement_fitted.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "Using this ability will increase your BP by [BP]x and increases Strength by [Str]x, Force by [Pow]x while increasing Offense by [Off]x, Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	verb/Super_Perfect_Form()
		set category="Skills"
		set src = usr.contents
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)






mob/proc/Bio_Forms()
	if(!Semiperfect_Form)
		Semiperfect_Form=1
		Base*=1.2
		StrMod*=1.2
		Decline+=5
		if(icon=='Bio Android 1.dmi') icon='Bio Android 2.dmi'
		if(icon=='Bio1.dmi') icon='Bio2.dmi'
		if(icon=='Bio Android 1yellow.dmi') icon='Bio Android 2 yellow.dmi'
		if(icon=='BioAndroid1(Spore).dmi') icon='BioAndroid2(Spore).dmi'
		if(icon=='BioAndroid1r.dmi') icon='BioAndroid2r.dmi'


	else if(!Perfect_Form)
		Perfect_Form=1
		Base*=1.2
		SpdMod*=1.2
		OffMod*=1.1
		DefMod*=1.1
		BaseRegeneration*=1.2
		BaseRecovery*=1.2
		Decline+=5
		HasSNj=1
		if(icon=='Bio Android 2.dmi') icon='Bio Android 3.dmi'
		if(icon=='Bio2.dmi') icon='Bio3.dmi'
		if(icon=='Bio Android 2 yellow.dmi') icon='Bio Android 3yellow.dmi'
		if(icon=='BioAndroid2(Spore).dmi') icon='BioAndroid3(Spore).dmi'
		if(icon=='BioAndroid2r.dmi') icon='BioAndroid3r.dmi'
		spawn() for(var/Skill/Misc/Absorb_Bio/B in src) del(B)


