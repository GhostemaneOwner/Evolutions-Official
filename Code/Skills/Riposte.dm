


mob/proc/GetDisarmed(mob/M,length)
	if(!HasEOMA)
		for(var/mob/player/P in oview(M)) P.CombatOut("[src] is disarmed by [M]!")
		Disarmed=length
	else for(var/mob/player/P in oview(M)) P.CombatOut("[M] tries to disarm [src] but their weapon is like a part of their arm!")

mob/var/tmp/Disarmed=0
mob/var/tmp/RiposteActive=0
mob/var/tmp/CatchBladeActive=0
Skill/Weapon/Riposte//adds stagger to attacks for next 20 seconds
	Experience=100
	UB1="Armament"
	UB2="Fists of Fury"
	Tier=2
	desc="Causes you to automatically counter-attack and disarm your opponent if they attack you within the next 6 seconds. (Disarm lasts about 8 seconds, only usable while wearing a weapon)"
	verb/Riposte()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		usr.RiposteActive=4
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr] prepares to parry their opponent's attack.")
		CDTick(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")


Skill/Unarmed/CatchTheBlade//adds stagger to attacks for next 20 seconds
	Experience=100
	Tier=2
	desc="Causes you to disarm your opponent for 16 seconds on their next attack against you. This will also cause a short stun on any attacker and cancel their attack. If you are wearing gauntlets, it also causes you to negate the attacks damage. (Only usable without a weapon.)"
	verb/Catch_the_Swing()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		usr.CatchBladeActive=4
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr] prepares to catch their opponent's swing.")
		CDTick(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")
