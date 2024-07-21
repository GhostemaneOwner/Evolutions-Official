


Skill/Buff/Giant_Mode
	RequiresApproval = 0
	Tier=4
	BP=1.3
	End=1.3
	Str=1.3
	Pow=1.3
	Anger=1.3
	Experience=100
	energydrain=LowDrain
	var/tmp/Clicks=0
	buffon="becomes a Giant!"
	buffoff="shrinks to normal size."
	icon='Judgement_fitted.dmi'
	layer=MOB_LAYER+1
	verb/Giant_Mode()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)

//2.7-2.8


Skill/Buff/Ancient_Form
	RequiresApproval = 0
	Tier=5
	BP=1.65
	Anger=1.3
	Experience=100
//	staticenergydrain=MediumStaticDrain
	var/tmp/Clicks=0
	buffon="becomes a Giant!"
	buffoff="shrinks to normal size."
	layer=MOB_LAYER+1
	verb/Ancient_Form()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)


