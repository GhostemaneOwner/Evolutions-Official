
Skill
	layer=MOB_LAYER+1
Skill/Buff/Super_MakyoForm
	RequiresApproval = 0
	Tier=4
	buffon="transforms into a Super Makyo."
	buffoff="reverts from their transformation."
	BP=1.75
	End=1.55
	Off=1.4
	Experience=100
	energydrain=LowDrain
	icon='Judgement_fitted.dmi'
	New()
		icon-=rgb(rand(1,100),rand(1,100),rand(1,100))
		..()
	/*GetDescription()
		return "Super Makyo Transformation: [BP]x BP [End]x End [Off]x Off"
		..()*/
	verb/Super_MakyoForm()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)


Skill
	layer=MOB_LAYER+1
Skill/Buff/Makyo_Form
	RequiresApproval = 0
	Tier=4
	buffon="transforms into a giant accessing there Transformation."
	buffoff="reverts from their transformation."
	BP=1.5
	End=1.3
	Off=1.2
	Experience=100
	energydrain=LowDrain
	icon='Judgement_fitted.dmi'
	New()
		icon-=rgb(rand(1,100),rand(1,100),rand(1,100))
		..()
	/*GetDescription()
		return "Makyo Transformation: [BP]x BP [End]x End [Off]x Off"
		..()*/
	verb/Makyo_Transform()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
		usr.FirstTransWPRestore(usr)

