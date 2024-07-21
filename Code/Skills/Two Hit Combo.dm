
mob/proc/Combo1(mob/M)
	M.Frozen=1
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.15,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=WorldDefaultAcc)


	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				M.TakeDamage(src, Damage, "Uppercut Punch 2")
	else
		src.Fight()
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	animate(src,pixel_z=9,time=3)
	animate(M,pixel_z=9,time=3)
	src.Combo2(M)
	spawn(6)
		animate(src,pixel_z=0,time=3)
		animate(M,pixel_z=0,time=3)
mob/proc/Combo2(mob/M)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0.3,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=WorldDefaultAcc)
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				M.TakeDamage(src, Damage, "Uppercut Punch 3")
	else
		src.Fight()
//		M.BPDamage(src,Damage,5)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	M.Frozen=0

Skill/Unarmed/UppercutCombo
	UB1="Godspeed"
	UB2="Fists of Fury"
	Tier=2
	desc="Launches a 3 hit combo attack. (Second hit gets +15% Speed added to your Strength, third gets +30% Speed added to Strength)"
	verb/Uppercut_Combo()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<100) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			CDTick(usr)
			//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-rand(50,75))
			usr.DrainKi(src, 1, 100,show=1)
			usr.DashAttacking=1
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				UppercutUser(usr)
				usr.Fight()
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=WorldDefaultAcc)
				if(!prob(Evasion))
					flick(M.CustomZanzokenIcon,M)
					M.CombatOut("You dodge [usr].")
					usr.CombatOut("[M] dodges you.")
					if(prob(65))
						M.dir=turn(M.dir,pick(-45,45))
						step(M,M.dir)
				else //Successful hit
					if(!prob(Evasion))
						ShockwaveScale(M,usr.BP,1)
						Damage = Damage * 0.5
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",loc)
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					if(!M.KOd)
						if(!isnum(M.Health)) return
						M.TakeDamage(src, Damage, "[src] 1")
						VerticalDust(M)
						usr.Combo1(M)
					else
						usr.Fight()
//						M.BPDamage(usr,Damage,5)
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
			spawn(usr.Refire*2) usr.attacking=0
			usr.DashAttacking=0
			if(Experience<100) Experience+=rand(1,5)
			if(Experience>100) Experience=100
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")

mob/proc/WCombo1(mob/M,Skill/S)
	M.Frozen=1
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=65)


	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				M.TakeDamage(src, Damage, "Burning Slash 2")
	else
		src.Fight()
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	animate(src,pixel_z=9,time=3)
	animate(M,pixel_z=9,time=3)
	src.WCombo2(M)
	spawn(6)
		animate(src,pixel_z=0,time=3)
		animate(M,pixel_z=0,time=3)

mob/proc/WCombo2(mob/M,Skill/S)
	sleep(5)
	loc=M.loc
	step_away(src,M)
	dir=get_dir(loc,M.loc)
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=65)
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					return
				M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
				M.TakeDamage(src, Damage, "Burning Slash 3")
				src.BurningBlast(S)
	else
		src.Fight()
//		M.BPDamage(src,Damage,5)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		return
	M.Frozen=0

mob/proc/BurningBlast(Skill/S)
	flick(usr,"Blast")
	var/obj/ranged/Blast/A=unpool("Blasts")
	A.Belongs_To=src
	A.name=S.name
	A.icon=S.icon
	A.pixel_x=S.pixel_x
	A.pixel_y=S.pixel_y
	var/MaskDamage=0
	var/MaxSwordPercent
	for(var/obj/items/Sword/SS in usr) if(SS.suffix&&SS.Durability>0)
		MaskDamage=SS.Health
		MaxSwordPercent=SS.MaxBPAdd
		SS.DurabilityCheck(usr)
		break
	for(var/obj/items/Hammer/SS in usr) if(SS.suffix&&SS.Durability>0)
		MaskDamage=SS.Health
		MaxSwordPercent=SS.MaxBPAdd
		SS.DurabilityCheck(usr)
		break
	for(var/obj/items/Gauntlets/SS in usr) if(SS.suffix&&SS.Durability>0)
		MaskDamage=SS.Health
		MaxSwordPercent=SS.MaxBPAdd
		SS.DurabilityCheck(usr)
		break
	if(MaskDamage>(MaxSwordPercent/100)*usr.BP) MaskDamage=(MaxSwordPercent/100)*usr.BP
	A.Damage=2*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
	A.Power=(usr.BP+MaskDamage)*Ki_Power
	A.Offense=usr.Off
	A.Explosive=0
	A.dir=usr.dir
	A.loc=usr.loc
	step(A,A.dir)
	if(A) walk(A,A.dir,1)


Skill/Weapon/BurningSlash
	Tier=4
	UB1="Armament"
	UB2="War"
	desc="Launches a 3 hit combo attack followed by a blast. (The blast deals bonus weapon damage.)"
	verb/Burning_Slash()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<300) return
		if(!usr.WeaponCheck())
			usr<<"You must be wielding a weapon to use this skill."
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			CDTick(usr)
			usr.DashAttacking=1
			//usr.DrainKi(src,"Percent",30)//usr.Ki=max(0,usr.Ki-rand(50,75))
			usr.DrainKi(src, 1, 300,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				UppercutUser(usr)
				usr.Fight()
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				if(!prob(Evasion))
					flick(M.CustomZanzokenIcon,M)
					M.CombatOut("You dodge [usr].")
					usr.CombatOut("[M] dodges you.")
					if(prob(65))
						M.dir=turn(M.dir,pick(-45,45))
						step(M,M.dir)
				else //Successful hit
					if(!prob(Evasion))
						ShockwaveScale(M,usr.BP,1)
						Damage = Damage * 0.5
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",loc)
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					if(!M.KOd)
						if(!isnum(M.Health)) return
						M.TakeDamage(src, Damage, "[src] 1")
						VerticalDust(M)
						usr.WCombo1(M,src)
					else
						usr.Fight()
//						M.BPDamage(usr,Damage,5)
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
			spawn(usr.Refire*2) usr.attacking=0
			usr.DashAttacking=0
			if(Experience<100) Experience+=rand(1,5)
			if(Experience>100) Experience=100
			
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")


