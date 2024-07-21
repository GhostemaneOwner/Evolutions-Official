


mob/proc/WFF(mob/M)
	M.Frozen=1
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=70)
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.2,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
//			hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion))
				Damage = Damage * 0.5
//				hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//				didBlock=1
			if(prob(25))ImpactDust(M,dir)//
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
//				M.BPDamage(src,Damage,2)
//				hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
				M.TakeDamage(src, Damage, "Wolf Fang Fist")
				WolfFangFist(src)
				for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Wolf!")
	else
		src.Fight()
//		M.BPDamage(src,Damage,2)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	src.WFF2(M)

mob/proc/WFF2(mob/M)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=70)
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.2,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//	var/didBlock=0
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
//			hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25))ImpactDust(M,dir)//
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.TakeDamage(src, Damage, "Wolf Fang Fist")
				WolfFangFist(src)
				for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Fang!")
	else
		src.Fight()
//		M.BPDamage(src,Damage,3)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	src.WFF3(M)

mob/proc/WFF3(mob/M)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=70)
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.3,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//	var/didBlock=0
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
//			hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25))ImpactDust(M,dir)//
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.TakeDamage(src, Damage, "Wolf Fang Fist")
				WolfFangFist(src)
				for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Fist!")
	else
		src.Fight()
//		M.BPDamage(src,Damage,5)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	M.Frozen=0



Skill/Unarmed/WolfFangFist
	UB1="Bestial Wrath"
	UB2="Fists of Fury"
	Tier=4
	desc="Dashes three tiles and attempts to attack anyone you collide with. If you hit someone you will begin a three hit combo against them. First two attacks get +20% speed towards damage and the final attack gets 30% while the dash gets +50% from speed."
	verb/Wolf_Fang_Fist()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<150) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		CDTick(usr)
		var/Distance=3
		if(usr.Ki>usr.MaxKi*0.05)
			usr.DashAttacking=1
			usr.attacking=1
			if(Experience<100) Experience+=rand(5,12)
			if(Experience>100) Experience=100
			while(src&&usr&&Distance&&usr.Health>0)
				if(usr.Ki<50) break
				for(var/mob/M in get_step(usr,usr.dir)) if(M!=usr) if(!M.adminDensity&&M.attackable)
					if(M.afk==0&&!M.RPMode)
						usr.Fight()
						var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
						var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0.5,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//						var/didBlock=0
						if((M.KOd==0&&M.client))
							if(M.attacking==1) usr.Opp(M)
							Distance--
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
//								hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
								M.CombatOut("You dodge [usr].")
								usr.CombatOut("[M] dodges you.")
								if(prob(65))
									M.dir=turn(M.dir,pick(-45,45))
									step(M,M.dir)
							else //Successful hit
								if(!prob(Evasion))
									Damage = Damage * 0.5
//									hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//									didBlock=1
									if(prob(65))
										M.dir=turn(M.dir,pick(-45,45))
										step(M,M.dir)
								if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
//									M.BPDamage(usr,Damage,3)
//									hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
									M.TakeDamage(src, Damage, "Wolf Fang Fist")
									usr.WFF(M)
									Distance=0
						else
							usr.Fight()
//							M.BPDamage(usr,Damage,5)
							M.KB=round((usr.Str/M.End)*5)
							if(M.KB>5) M.KB=5
							M.KnockBack(usr)
				usr.DrainKi(src, 1, 50,show=1)//usr.DrainKi(src,"Percent",5)//usr.Ki=max(0,usr.Ki-50)
				step(usr,usr.dir)
				Distance--
				if(Distance<=0) break
				sleep(rand(1,2/max(1,Experience/50)))
			spawn(usr.Refire*3)
				usr.attacking=0
				usr.DashAttacking=0
			if(Distance<=0)
				usr.DashAttacking=0
				usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")



mob/proc/FireLionsRoar(Skill/S)
	var/obj/ranged/Blast/A=unpool("Blasts")
	A.Belongs_To=src
	A.icon=S.icon
	A.Explosive=1
	A.density=1
	//A.Radius=1
	A.pixel_x=S.pixel_x
	A.pixel_y=S.pixel_y
	A.name=S.name
	A.Damage=4*(src.BP)*(src.Pow+src.Str)*Ki_Power
	A.Power=(src.BP)*Ki_Power
	A.Offense=src.Off
	A.loc=src.loc
	walk(A,src.dir,1)

Skill/Unarmed/Lions_Roar
	UB1="Bestial Wrath"
	UB2="High Tension"
	Tier=4
	icon='16.dmi'
	desc="Dashes three tiles and launch an energy blast that deals strength and force damage. The dash gets bonus damage from force."
	verb/Lions_Roar()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<150) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		CDTick(usr)
		var/Distance=3
		if(usr.Ki>usr.MaxKi*0.05)
			usr.DashAttacking=1
			usr.attacking=1
			if(Experience<100) Experience+=rand(5,12)
			if(Experience>100) Experience=100
			while(src&&usr&&Distance&&usr.Health>0)
				if(usr.Ki<50) break
				for(var/mob/M in get_step(usr,usr.dir)) if(M!=usr) if(!M.adminDensity&&M.attackable)
					if(M.afk==0&&!M.RPMode)
						usr.Fight()
						var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
						var/Damage=DamageFormula(usr,M,Strength=1,Force=0.75,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
						if((M.KOd==0&&M.client))
							if(M.attacking==1) usr.Opp(M)
							Distance--
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
								M.CombatOut("You dodge [usr].")
								usr.CombatOut("[M] dodges you.")
								if(prob(65))
									M.dir=turn(M.dir,pick(-45,45))
									step(M,M.dir)
							else //Successful hit
								if(!prob(Evasion))
									Damage = Damage * 0.5
									if(prob(65))
										M.dir=turn(M.dir,pick(-45,45))
										step(M,M.dir)
								if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(src, Damage, "[src]")
									spawn(1) usr.FireLionsRoar(src)
									Distance=0
						else
							usr.Fight()
							M.KB=round((usr.Str/M.End)*5)
							if(M.KB>5) M.KB=5
							M.KnockBack(usr)
				usr.DrainKi(src, 1, 50,show=1)//usr.DrainKi(src,"Percent",5)//usr.Ki=max(0,usr.Ki-50)
				step(usr,usr.dir)
				Distance--
				if(Distance<=0)
					usr.FireLionsRoar(src)
					break
				sleep(rand(1,2/max(1,Experience/50)))
			spawn(usr.Refire*2)
				usr.attacking=0
				usr.DashAttacking=0
			if(Distance<=0)
				usr.DashAttacking=0
				usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")



