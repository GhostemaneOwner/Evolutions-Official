




/*

Fight or Flight: For 20 seconds, gain +10% defense, +10% regeneration. Costs a small amount of ki upon activation but does not drain over time. 120 second cooldown.

Mach Speed: For 20 seconds gain +10% Speed, and increase movement speed (maybe randomly leave after images during movement?) . Costs a small amount of ki upon activation but does not drain over time. 120 second cooldown.
*/
mob/var/ExtraOvers

Skill/Buff/Experience=100
Skill/Buff/Adaptive
	RequiresApproval=0
	Tier=4
	buffslot=0
	Def=1.25
	End=1.25
	Regen=1.25
	Experience=100
	TimedBuff=300
	CDOverride=240
	buffon="shifts their stance as they adapt to the situation."
	buffoff="stops adapting to the situation."
	/*GetDescription()
		return "This technique will draw upon your natural adaptability. You will enter a defensive posture and improvise to gain the upper hand. ([End]x Endurance, [Def]x Defense and [Regen]x Regen for 30 seconds. Cost to activate, but no drain. 240 second cooldown.)"
		..()*/
	verb/Adaptive()
		set category="Skills"
		if(!Using)
			if(!usr.CanAttack(100,src)) return
			usr.DrainKi(src, 1, 100,show=1)//usr.DrainKi(src,"Percent",10)
			use(usr)


Skill/Buff/Combat_Mathematics
	RequiresApproval=0
	buffslot=0
	Tier=4
	Off=1.2
	Str=1.2
	Pow=1.2
	TimedBuff=300
	Experience=100
	CDOverride=240
	staticenergydrain=LowStaticDrain
	buffon="shifts their stance as they seem to be calculating their next moves."
	buffoff="stops calculating their next moves."
	/*GetDescription()
		return "This technique will draw upon your natural intellect and calculate the precise movements to make in order to land a critical blow. ([Off]x Offense and [Str]x Strength for 30 seconds. Cost to activate, but no drain. 240 second cooldown.)"
		..()*/
	verb/Combat_Mathematics()
		set category="Skills"
		if(!Using)
			if(!usr.CanAttack(100,src)) return
			usr.DrainKi(src, 1, 100,show=1)//usr.DrainKi(src,"Percent",10)
			use(usr)

Skill/Buff/Physics_Simulation
	RequiresApproval=0
	Tier=4
	BP=1.5
	Spd=1.25
	Off=1.25
	Def=1.25
	energydrain=MediumDrain
	buffon="begins to process the battlefield and all of its potential outcomes in their powerful mind."
	buffoff="stops processing the battlefield."
	Experience=100
	icon='Power Cloak.dmi'
	pixel_x=-32
	pixel_y=-32
	alpha=200
	layer=MOB_LAYER+1
	/*GetDescription()
		return "This technique is a display of the truly awesome power of the Tuffle mind. This technique is the natural evoltion of combat mathematics, as your are using your intellect to power your combat. While using this technique, your brain is working like a complex computer, calculating all possible outcomes of any given combat like a sandbox physics simulator.( [BP]x BP Mult, [Spd]x Spd, [Off]x Offense, and [Def]x Defense)"
		..()*/
	verb/Physics_Simulation()
		set category="Skills"
		usr.FirstTransWPRestore(usr)
		use(usr,null,0,0,0,0,0,0)


