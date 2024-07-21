
mob/var/tmp/PSand=0
Skill/Unarmed/PocketSand
	UB1="Fungal Plague"
	UB2="Death"
	Tier=4
	Experience=100
	desc="Launch a cheap attack against an opponent's eyes by throwing sand at them. Reduces their Offense and Defense by 10% if it hits for 15 seconds as well as staggering them. (Bonus damage based on offense)"
	verb/Pocket_Sand()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<75) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		flick("Attack",usr)
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				if(Experience<100) Experience+=rand(5,12)
				if(Experience>100) Experience=100
				CDTick(usr)
				//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
				usr.DrainKi(src, 1, 75,show=1)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0.3,DamageType="Physical",BaselineDamage=2,FlatDamage=1.5,UsesWeapon=0,IgnoresEnd=0)
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//						hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.5
//							hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
							M.Injure_Hurt(Damage,"Eyes",usr)
							M.TakeDamage(usr, Damage, "[src]")
						//	winset(M.client,"Wing_Clipd","is-visible=true")
							M.PSand=10
							Stun(M,0.5)
							Stagger(M,4)
							hearers(6,M) << "[usr] throws sand at [M]'s eyes."
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,3)
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


Skill/Unarmed/Exploding_Heart_Strike
	UB1="Death"
	UB2="Fists of Fury"
	Tier=4
	Experience=100
	desc="Launch an attack against an opponent that deals delayed damage but has bonus offense damage, staggers and damages their chest. (3s delay)"
	verb/Exploding_Heart_Strike()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<175) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		flick("Attack",usr)
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				if(Experience<100) Experience+=rand(5,12)
				if(Experience>100) Experience=100
				CDTick(usr)
				//usr.DrainKi(src,"Percent",17.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
				usr.DrainKi(src, 1, 175,show=1)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0.5,DamageType="Physical",BaselineDamage=3,FlatDamage=3,UsesWeapon=0,IgnoresEnd=0)
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
//						hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.5
//							hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(25))
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
							spawn(30)
								M.Injure_Hurt(Damage,"Body",usr)
								M.TakeDamage(usr, Damage, "[src]")
							Stagger(M,2)
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,3)
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
Skill/Unarmed/MegatonThrow
	UB1="High Tension"
	Experience=100
	Tier=2
	desc="While grabbing an opponent, leap into the air and then throw them to the ground, causing good damage. You can't use this with a weapon."
	verb/Megaton_Throw()
		set category="Skills"
		if(!usr.CanAttack(50,src)) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		if(!usr.GrabbedMob)
			usr.Grab()
			//return
		if(usr.GrabbedMob && usr.isGrabbing==1)
			if(usr.GrabbedMob)if(ismob(usr.GrabbedMob))
				CDTick(usr)
				//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-50)
				usr.DrainKi(src, 1, 75,show=1)
				usr.MegatonToss(usr.GrabbedMob)
			usr.GrabbedMob = null
			usr.isGrabbing = null
		//	return
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")

mob/proc/MegatonToss(mob/M)
	M.Frozen=1
	M.attacking=1
	attacking=1
	Frozen=1
	DoNotUnfreeze=1
	M.DoNotUnfreeze=1
	var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=WorldDefaultAcc)
	var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=2,UsesWeapon=0,IgnoresEnd=0)
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
//			hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
			M.CombatOut("[src] failed to throw you.")
			CombatOut("You failed to throw [GrabbedMob].")
			M.Frozen=0
			M.attacking=0
			attacking=0
			Frozen=0
			DoNotUnfreeze=0
			M.DoNotUnfreeze=0
			return
		else //Successful hit
			ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					M.attacking=0
					Frozen=0
					attacking=0
					DoNotUnfreeze=0
					M.DoNotUnfreeze=0
					return
				M.TakeDamage(src, Damage, "Megaton Throw")
			//	CombatOut("You throw [M]. ([round(Damage,0.1)] Damage)")
			//	M.CombatOut("[src] throws you. ([round(Damage,0.1)] Damage)")
	else
		Fight()
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		M.attacking=0
		attacking=0
		DoNotUnfreeze=0
		M.DoNotUnfreeze=0
		Frozen=0
		return
	underlays+='Shadow.dmi'
	M.underlays+='Shadow.dmi'
	spawn()
		var/i
		while(i <16)
			M.pixel_y+=6
			pixel_y+=6
			i++
			sleep(1)
	sleep(1)
	Fight()
	spawn()
		var/i
		while(i <12)
			M.pixel_y-=8
			i++
			sleep(1)
	sleep(8)
	spawn()
		var/i
		while(i <12)
			pixel_y-=8
			i++
			sleep(1)
	sleep(1)
	underlays-='Shadow.dmi'
	M.underlays-='Shadow.dmi'
	M.Frozen=0
	M.attacking=0
	attacking=0
	Frozen=0
	DoNotUnfreeze=0
	M.DoNotUnfreeze=0
	M.KB=rand(1,3)
	M.KnockBack(src)

