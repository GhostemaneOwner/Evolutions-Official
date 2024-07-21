mob/var/BurningShotOn=0
Skill/Unarmed/BurningShot
	UB1="Kaioken"
	UB2="High Tension"
	Tier=4
	desc="Warp to your target and then combo them if you land a melee attack. Grants an aura that gives you +10% BP for 8 seconds."
	verb/Burning_Shot()
		set category="Skills"
		if(usr.GrabbedMob) return
		if(!usr.CanAttack(150,src)) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		if(usr.KiBlade||usr.KiHammer||usr.SpiritSword)
			usr<<"You must be unarmed to use this skill."
			return
		var/mob/hitter
		if(usr.Target&& ismob(usr.Target)) if(usr.Target.z==usr.z) if(get_dist(usr,usr.Target)<=10) if(usr.Target in oviewers(5,usr))  hitter=usr.Target
		if(!hitter) return
		if(hitter==usr) return
		if(hitter.afk||hitter.KOd||!hitter.attackable||hitter.RPMode||hitter.adminDensity) return
		if(!locate(hitter) in viewers(usr)) return
		if(hitter.RPMode) return
		//if(hitter.Flying!=usr.Flying) return
		if(Using) return
		//usr.DrainKi(src,"Percent",15)
		usr.DrainKi(src, 1, 150,show=1)
		if(hitter.attacking==1) usr.Opp(hitter)
		if(hitter&&hitter.Health>0)
			CDTick(usr)
			usr.attacking=1
			var/didBlock=0
			usr.BurningShotBuff()
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] glows with a heightened power!")
			flick(usr.CustomZanzokenIcon,usr)
			var/list/Locs=new
			for(var/turf/A in oview(1,hitter)) if(!A.density&&!(locate(/mob) in A)&&A.Enter(src)&&!(locate(/obj/Props/Edges) in A)) Locs+=A
			for(var/turf/T in Locs)
				if(locate(/obj/Door) in T) Locs-=T
				if(locate(/mob) in T) Locs-=T
			if(locate(/turf) in Locs)
				var/turf/B=pick(Locs)
				if(B&&!B.density)
					flick(usr.CustomZanzokenIcon,usr)
					usr.loc=locate(B.x,B.y,B.z)
					if(B.x==x&&B.y==y) step_away(B,src)
					if(B.x==x&&B.y==y) step_away(src,B)
					if(B.x==x&&B.y==y) step_away(B,src)
					usr.dir=get_dir(usr,hitter)
					hitter.dir=get_dir(hitter,usr)
					usr.Fight()
					var/Evasion=AccuracyFormula(usr,hitter,KiManip=0,Chance=WorldDefaultAcc)
					var/Damage=DamageFormula(usr,hitter,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
					if(!prob(Evasion))
						flick(hitter.CustomZanzokenIcon,hitter)
						hitter.CombatOut("You dodge [usr].")
						usr.CombatOut("[hitter] dodges you.")
					else //Successful hit
						if(!prob(Evasion+(hitter.HasWayOfTheTurtle*2.5)))
							ShockwaveScale(hitter,usr.BP,1)
							Damage = Damage * 0.5
							didBlock=1
						if(prob(25)) ImpactDust(hitter,usr.dir)//ShockwaveIcon(null,"Impact",hitter.loc)
						ASSERT(hitter)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						if(hitter)
							if(!isnum(hitter.Health)) return
							var/AttackOut=""
							if(didBlock==1)AttackOut="Blocked"
							else if(didBlock==2) AttackOut="(Armor) Blocked"
							hitter.TakeDamage(usr, Damage, "[AttackOut] [src]")
							spawn() usr.BurningShoot(hitter)

			if(Experience<100) Experience+=rand(6,15)
			if(Experience>100) Experience=100
			spawn(usr.Refire) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")

mob/proc/BurningShotBuff() if(!BurningShotOn)for(var/Skill/Unarmed/BurningShot/A in src) if(!A.Using)
	BurningShotOn=5
	A.Using=1
	overlays+=/Icon_Obj/Cloak/BurningShot
	BPMult*=1.10
	spawn(450) BurningShotBuffRemove()
mob/proc/BurningShotBuffRemove() if(src) for(var/Skill/Unarmed/BurningShot/A in src) if(A.Using)
	A.Using=0
	overlays-=/Icon_Obj/Cloak/BurningShot
	BPMult/=1.10
	for(var/mob/player/M in view(src)) M.BuffOut("[src]s glowing power fades")

mob/proc/BurningShoot(mob/M)
	M.Frozen=1
	Frozen=1
	DoNotUnfreeze=1
	M.DoNotUnfreeze=1
	M.attacking=3
	var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=WorldDefaultAcc)
	var/Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
	var/MPX=M.pixel_x
	var/MPY=M.pixel_y
	var/PX=pixel_x
	var/PY=pixel_y
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			DoNotUnfreeze=0
			M.DoNotUnfreeze=0
			M.attacking=0
			Frozen=0
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					M.attacking=0
					DoNotUnfreeze=0
					M.DoNotUnfreeze=0
					Frozen=0
					return
				UppercutUser(src)
				VerticalDust(M)
				M.TakeDamage(src, Damage, "Burning Shot")
	else
		src.Fight()
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		M.attacking=0
		DoNotUnfreeze=0
		M.DoNotUnfreeze=0
		Frozen=0
		return
	underlays+='Shadow.dmi'
	M.underlays+='Shadow.dmi'
	spawn()
		var/i
		while(i <8)
			M.pixel_y+=12
			i++
			sleep(1)
	sleep(2)
	spawn()
		var/i
		while(i <6)
			pixel_y+=16
			i++
			sleep(1)
	sleep(6)
	dir=get_dir(loc,M.loc)
	Evasion=AccuracyFormula(src,M,KiManip=0,Chance=WorldDefaultAcc)
	Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			M.attacking=0
			DoNotUnfreeze=0
			M.DoNotUnfreeze=0
			Frozen=0
			M.pixel_x=MPX
			M.pixel_y=MPY
			pixel_x=PX
			pixel_y=PY
			ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			underlays-='Shadow.dmi'
			M.underlays-='Shadow.dmi'
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					M.attacking=0
					DoNotUnfreeze=0
					M.DoNotUnfreeze=0
					Frozen=0
					M.pixel_x=MPX
					M.pixel_y=MPY
					pixel_x=PX
					pixel_y=PY
					ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
					underlays-='Shadow.dmi'
					M.underlays-='Shadow.dmi'
					return
				M.TakeDamage(src, Damage, "Burning Shot")
	else
		src.Fight()
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		M.attacking=0
		DoNotUnfreeze=0
		M.DoNotUnfreeze=0
		Frozen=0
		M.pixel_x=MPX
		M.pixel_y=MPY
		pixel_x=PX
		pixel_y=PY
		underlays-='Shadow.dmi'
		M.underlays-='Shadow.dmi'
		ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
		underlays-='Shadow.dmi'
		M.underlays-='Shadow.dmi'
		return
	spawn()
		var/i
		while(i <6)
			if(M) M.pixel_x+=16
			i++
			sleep(1)
	sleep(2)
	spawn()
		var/i
		while(i <4)
			if(src) pixel_x+=24
			i++
			sleep(1)
	sleep(4)
	dir=get_dir(loc,M.loc)
	Evasion=AccuracyFormula(src,M,KiManip=0,Chance=WorldDefaultAcc)
	Damage=DamageFormula(src,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//	didBlock=0
	if((M.KOd==0&&M.client)&&KOd==0)
		if(M.attacking==1) src.Opp(M)
		if(!prob(Evasion))
			flick(M.CustomZanzokenIcon,M)
//			hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
			M.CombatOut("You dodge [src].")
			CombatOut("[M] dodges you.")
			M.Frozen=0
			M.attacking=0
			Frozen=0
			DoNotUnfreeze=0
			M.DoNotUnfreeze=0
			M.pixel_x=MPX
			M.pixel_y=MPY
			pixel_x=PX
			pixel_y=PY
			ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			underlays-='Shadow.dmi'
			M.underlays-='Shadow.dmi'
			return
		else //Successful hit
			if(!prob(Evasion)) Damage = Damage * 0.5
			if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
			ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
			if(M)
				if(!isnum(M.Health))
					M.Frozen=0
					M.attacking=0
					Frozen=0
					DoNotUnfreeze=0
					M.DoNotUnfreeze=0
					M.pixel_x=MPX
					M.pixel_y=MPY
					pixel_x=PX
					pixel_y=PY
					ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
					underlays-='Shadow.dmi'
					M.underlays-='Shadow.dmi'
					return
				M.TakeDamage(src, Damage, "Burning Shot")
				UppercutUser2(src)
				VerticalDust2(M)
	else
		src.Fight()
//		M.BPDamage(src,Damage,2)
		M.KB=round((src.Str/M.End)*5)
		if(M.KB>5) M.KB=5
		M.KnockBack(src)
		M.Frozen=0
		M.attacking=0
		Frozen=0
		DoNotUnfreeze=0
		M.DoNotUnfreeze=0
		M.pixel_x=MPX
		M.pixel_y=MPY
		pixel_x=PX
		pixel_y=PY
		ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
		underlays-='Shadow.dmi'
		M.underlays-='Shadow.dmi'


		return

	spawn()
		var/i
		while(i <3)
			M.pixel_y-=32
			M.pixel_x-=32
			i++
			sleep(1)
	spawn()
		var/i
		while(i <3)
			pixel_y-=32
			pixel_x-=32
			i++
			sleep(1)
	sleep(3)
	M.pixel_x=MPX
	M.pixel_y=MPY
	pixel_x=PX
	pixel_y=PY
	underlays-='Shadow.dmi'
	M.underlays-='Shadow.dmi'
	M.attacking=0
	DoNotUnfreeze=0
	M.DoNotUnfreeze=0
	Frozen=0
	M.Frozen=0



