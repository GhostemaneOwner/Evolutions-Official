
//Tier2Drain

Skill/Buff/Super_Namekian
	RequiresApproval=0
	Tier=4
	BP=1.5
	Spd=1.25
	Off=1.4
	Def=1.4
	var/IsAncient=0
	var/snj = 1
	energydrain=MediumDrain
	buffon="begins to harness the power of a Super Namekian."
	buffoff="stops harnessing the power of a Super Namekian."
	Experience=100
	icon='SNj Elec.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Super_Namekian()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)


Skill/Buff/Super_Namekian_2
	RequiresApproval=0
	Tier=4
	BP=1.75
	Spd=1.45
	Off=1.6
	Def=1.6
	var/IsAncient=0
	var/snj = 1
	energydrain=MediumDrain
	buffslot = 0
	buffon="begins to harness the power of a Super Namekian 2."
	buffoff="stops harnessing the power of a Super Namekian 2."
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Super_Namekian_2()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)

Skill/Buff/Ancient_Slug
	RequiresApproval=0
	Tier=4
	BP=2.75
	Spd=1.85
	Off=1.8
	Def=1.8
	var/IsAncient=0
	var/snj = 1
	energydrain=MediumDrain
	buffslot = 0
	buffon="begins to harness the power of a Ancient Slug!"
	buffoff="stops harnessing the power of a Ancient Slug!"
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Ancient_Slug()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)



Skill/Buff/Omega_Form
	RequiresApproval=0
	Tier=4
	BP=2
	Spd=1.45
	Off=1.85
	Def=1.6
	energydrain=MediumDrain
	buffslot = 1
	buffon="begins to harness the power of Omega Form"
	buffoff="stops harnessing the power of Omega Form"
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Omega_Form()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)

Skill/Buff/Omega_Form_2
	RequiresApproval=0
	Tier=4
	BP=2.55
	Spd=1.65
	Off=2
	Def=2
	//energydrain=MediumDrain
	buffslot = 2
	buffon="begins to harness the power of Omega Form 2"
	buffoff="stops harnessing the power of Omega Form 2"
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Omega_Form_2()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)

Skill/Buff/Godly_Ascenison
	RequiresApproval=0
	Tier=4
	BP=2
	Spd=1.45
	Off=1.85
	Def=1.6
	//energydrain=MediumDrain
	buffslot = 2
	buffon="begins to harness the power of Godly Ascension"
	buffoff="stops harnessing the power of Ascension"
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Godly_Ascenison()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)

Skill/Buff/Grand_Kaioshin
	RequiresApproval=0
	Tier=4
	BP=1.85
	Spd=1.45
	Off=1.85
	Def=1.6
	//energydrain=MediumDrain
	buffslot = 1
	buffon="begins to harness the power of Grand Kaioshin"
	buffoff="stops harnessing the power of Grand Kaioshin"
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Grand_Kaioshin()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)

Skill/Buff/Supreme_Overseer
	RequiresApproval=0
	Tier=4
	BP=2
	Spd=1.45
	Off=1.85
	Def=1.6
	//energydrain=MediumDrain
	buffslot = 1
	buffon="begins to harness the power of the Supreme Overseer"
	buffoff="stops harnessing the power of the Supreme Overseer"
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Supreme_Overseer()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)


Skill/Buff/Hakaishin_Form
	RequiresApproval=0
	Tier=4
	BP=3
	Spd=1.85
	Off=1.85
	Str=1.65
	//energydrain=MediumDrain
	buffslot = 1
	buffon="begins to harness the power of the Hakaishin"
	buffoff="stops harnessing the power of the Hakaishin"
	Experience=100
	icon='SNJ.dmi'
	/*GetDescription(mob/Getter)
		return "Using this will increase the users BP by [BP]x, Speed by [Spd]x, Off by [Off]x, Def by [Def]x."
		..()*/
	verb/Hakaishin_Form()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,1)
