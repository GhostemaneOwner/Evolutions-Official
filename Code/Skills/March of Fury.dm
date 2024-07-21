Skill/Melee/Headbutt
	UB1="High Tension"
	UB2="Fists of Fury"
	Tier=2
	Experience=100
	desc="Bash your opponent in the face with the crown of your head. This will stun them for 2 ticks if it lands but if you miss, you will be stunned for 2 ticks. Does damage to your head and your opponents head if it lands."
	verb/Headbutt()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<75) return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			CDTick(usr)
			//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
			usr.DrainKi(src, 1, 75,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0.5,UsesWeapon=0,IgnoresEnd=0)
//				var/didBlock=0
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//							hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						Stun(usr,0.5)
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.5
//								hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//								M.BPDamage(usr,Damage,3)
//								hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
							usr.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
							M.TakeDamage(usr, Damage, "[src]")
							Stun(M,2)
							M.BuffOut("[usr] bashes [M] with their headbutt.")
							usr.BuffOut("[usr] bashes [M] with their headbutt.")
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//						M.BPDamage(usr,Damage,3)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")
Skill/Weapon/Flourish
	UB1="Armament"
	UB2="Godspeed"
	Tier=4
	desc="Swing at your opponent with an elaborate strike. After a half second delay you will attack using 40% of your speed as extra damage."
	verb/Flourish()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<125) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		for(var/mob/M in view(usr)) M.BuffOut("[usr] flourishes their weapon.")
		sleep(5)
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			CDTick(usr)
			//usr.DrainKi(src,"Percent",12.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
			usr.DrainKi(src, 1, 125,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0.4,Offense=0,DamageType="Physical",BaselineDamage=3.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//				var/didBlock=0
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//							hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.5
//								hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//								M.BPDamage(usr,Damage,3)
//								hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.TakeDamage(usr, Damage, "[src]")
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//						M.BPDamage(usr,Damage,3)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
			if(Experience<100) Experience+=rand(5,15)
			if(Experience>100) Experience=100
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")
Skill/Weapon/Bash
	Tier=1
	desc="Bash your opponent with your hammer or the pommel of your sword. This will stun them for 1 second."
	verb/Bash()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<75) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			CDTick(usr)
			//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
			usr.DrainKi(src, 1, 75,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=1.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//				var/didBlock=0
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//							hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.5
//								hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//								M.BPDamage(usr,Damage,3)
//								hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.TakeDamage(usr, Damage, "[src]")
							Stun(M,1)
							M.BuffOut("[usr] bashes [M] with their weapon.")
							usr.BuffOut("[usr] bashes [M] with their weapon.")
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//						M.BPDamage(usr,Damage,3)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
			if(Experience<100) Experience+=rand(4,9)
			if(Experience>100) Experience=100


	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")
Skill/Weapon/Slice
	Experience=100
	desc="You slash at your opponent with your sword or swing with your hammer in a fast attack. (Regular attack damage, but doesnt trigger attack CD. Short cooldown.)"
	Tier=1
	verb/Slice()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.RPMode) return 0
		if(usr.Ki<5) return 0
		if(StunCheck(usr)) return 0
		if(usr.getCooldown("[src]")>world.time) return 0
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		var/mob/M=null
		for(var/mob/MN in oview(src,1)) if(MN==usr.LastAttacked&&usr.Warp) M=MN
		if(!M)
			for(var/mob/MM in get_step(usr,usr.dir))
				M=MM
				//break
		if(M)
			CDTick(usr)
			if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) //if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
				if(M.RPMode) return
				for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
				if(usr)
					if(usr.Ki<1+(usr.KiBlade+usr.KiFists+usr.BurningFists)) return
					//usr.DrainKi("Slice","Percent",1+(usr.KiBlade*2)+(usr.KiFists*1.5)+(usr.BurningFists*1.5))
					usr.DrainKi(src, 1, 1+(usr.KiBlade*3)+(usr.KiFists*2)+(usr.BurningFists*2),show=1)
					usr.FreeAttack(M)
				if(Experience<100) Experience+=rand(1,5)
				if(Experience>100) Experience=100
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")
mob/var/tmp/CanDashAttack=1
Skill/Melee/MarchOfFury
	UB2="High Tension"
	UB1="Fists of Fury"
	Tier=4
	Experience=1
	desc="You charge towards your target, rushing towards them no matter the obstacle. You will launch 4-8 melee attacks on your path, one every half second. (If you have Combo Toggle turned on, it will launch 8 attack instead. Two every half second. This is a 'smart homing' move that will avoid dense objects on the way.)"

	verb/March_of_Fury()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<200) return
		if(!usr.CanAttack(200,src)) return
		if(usr.Target==usr)return
		var/mob/B
		if(usr.Target) B =usr.Target
		else
			usr<<"This requires a target."
			return
		CDTick(usr)
		//usr.attacking=3
		if(Experience<100) Experience+=rand(9,21)
		if(Experience>100) Experience=100
		//usr.Ki=max(0,)
		//usr.DrainKi(src,"Percent",20)
		usr.DrainKi(src, 1, 200,show=1)
		walk_to(usr,B,0,1)
		usr.CanDashAttack=0
		usr.DashAttacking=1
		spawn(4)
			usr.MeleeAttack(1)
			spawn(4)
				usr.MeleeAttack(1)
				spawn(4)
					usr.MeleeAttack(1)
					spawn(4)
						usr.MeleeAttack(1)
						usr.CanDashAttack=1
						usr.DashAttacking=0
		spawn(18)walk(usr,0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")


Skill/Unarmed/ConsecutiveNormalPunches
	UB2="Godspeed"
	UB1="Fists of Fury"
	Tier=4
	Experience=1
	desc="You will launch six attacks simultaneously after a 0.5 second delay."

	verb/Simultaneous_Normal_Punches()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<200) return
		if(!usr.CanAttack(175,src)) return
		if(usr.Target==usr)return
		CDTick(usr)
		if(Experience<100) Experience+=rand(9,21)
		if(Experience>100) Experience=100
		for(var/mob/P in view(usr)) P.BuffOut("[usr] prepares a powerful attack.")
		//usr.DrainKi(src,"Percent",17.5)
		usr.DrainKi(src, 1, 175,show=1)
		spawn(5)
			var/mob/M=null
			for(var/mob/MN in oview(src,1)) if(MN==usr.LastAttacked&&usr.Warp) M=MN
			if(!M)
				for(var/mob/MM in get_step(usr,usr.dir))
					M=MM
			if(M)
				if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) //if(!ghostDens_check(M)&&M.attackable&&icon_state!="Meditate"&&icon_state!="Train"&&KOd==0)
					if(M.RPMode) return
					if(usr)
						usr.CanDashAttack=0
						usr.FreeAttack(M)
						usr.FreeAttack(M)
						usr.FreeAttack(M)
						usr.FreeAttack(M)
						usr.FreeAttack(M)
						usr.FreeAttack(M,0)
						usr.CanDashAttack=1
			else
				usr.BuffOut("You missed the target with [src].")
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")




