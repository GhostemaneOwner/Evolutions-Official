

Skill/Melee/TelekineticPull
	desc="Summons your target into the tile in front of you, or the nearest available, and launches a melee attack."
	Tier=2
	UB1="Shadow King"
	UB2="Arcane Power"
	//var/HasCharge=1
	//var/MaxCharge=2
	verb/Telekinetic_Pull()
		set category="Skills"
		if(usr.GrabbedMob) return
		if(!usr.CanAttack(30,src)) return
		usr.DrainKi(src, 1, 50,show=1)//usr.DrainKi(src,"Percent",3)
		var/mob/hitter
		if(usr.Target&& ismob(usr.Target)) if(usr.Target.z==usr.z) if(get_dist(usr,usr.Target)<=10) if(usr.Target in oviewers(10,usr))  hitter=usr.Target
		if(!hitter) return
		if(hitter==usr) return
		if(hitter.afk||hitter.KOd||!hitter.attackable||hitter.RPMode||hitter.adminDensity) return
		if(!locate(hitter) in viewers(usr)) return
		if(hitter.RPMode) return
		if(hitter.Flying!=usr.Flying) return
		//if(hitter.attacking==1) usr.Opp(hitter)
		if(hitter&&hitter.Health>0)
			CDTick(usr)
			usr.attacking=1
			var/didBlock=0
			flick(hitter.CustomZanzokenIcon,hitter)
			ZanzoDust(hitter)
			hitter.Comboz(usr)
			flick("Attack",usr)
			var/Evasion=AccuracyFormula(usr,hitter,KiManip=0,Chance=WorldDefaultAcc)
			var/Damage=DamageFormula(usr,hitter,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
			if(!prob(Evasion))
				flick(hitter.CustomZanzokenIcon,hitter)
//				hearers(6,hitter) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
				hitter.CombatOut("You dodge [usr].")
				usr.CombatOut("[hitter] dodges you.")
			else //Successful hit
				if(!prob(Evasion+(hitter.HasWayOfTheTurtle*2.5)))
					Damage = Damage * 0.5
//					hearers(6,hitter)<<pick('Melee_Block1.wav','Melee_Block2.wav')
					didBlock=1
				if(prob(25)) ImpactDust(hitter,usr.dir)//ShockwaveIcon(null,"Impact",hitter.loc)
				ASSERT(hitter)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
				if(hitter)
					Damage=Damage
					if(!isnum(hitter.Health)) return
					var/AttackOut=""
					if(didBlock==1)AttackOut="Blocked"
					else if(didBlock==2) AttackOut="(Armor) Blocked"
					hitter.TakeDamage(usr, Damage, "[AttackOut] [src]")
			if(Experience<100) Experience+=rand(1,5)
			if(Experience>100) Experience=100
			//Learnable=1
			//spawn(60) Learnable=0
			spawn(usr.Refire*0.5)if(usr.attacking!=3) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")
