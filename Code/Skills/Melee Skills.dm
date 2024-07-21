



mob/proc/GetCleave(direction,times=0)
	switch(direction)
		if(1.0)
			if(!times)return 9
			if(times==1)return 5
			return 1
			return "North"
		if(2.0)
			if(!times)return 6
			if(times==1)return 10
			return 2
			return "South"
		if(4.0)
			if(!times)return 5
			if(times==1)return 6
			return 4
			return "East"
		if(8.0)
			if(!times)return 10
			if(times==1)return 9
			return 8
			return "West"
		if(5.0)
			if(!times)return 1
			if(times==1)return 4
			return 5
			return "NorthEast"
		if(6.0)
			if(!times)return 4
			if(times==1)return 2
			return 6
			return "SouthEast"
		if(9.0)
			if(!times)return 8
			if(times==1)return 1
			return 9
			return "NorthWest"
		if(10.0)
			if(!times)return 2
			if(times==1)return 8
			return 10
			return "SouthWest"


mob/proc/Comboz(var/mob/M,var/forced)
	if(M==1)return
	if(M)
		mark1
		var/turf/W=locate(M.x+rand(-1,1),M.y+rand(-1,1),usr.z)
		if(W)
			if(istype(W,/turf/Special/Blank))
				goto mark1
			if(!W.density)
				for(var/atom/x in W) if(x.density) goto mark1
				if(usr.Zanzoken>999) src.AfterImage()
				src.loc=W
				src.dir=get_dir(src,M)
				M.dir=get_dir(M,src)


mob/var/tmp/KiWeapon=null
mob/var/tmp/KiBow
Skill/Misc/KiBow
	UB2="War"
	UB1="Arcane Power"
	icon='Quincy Bow 1.dmi'
	layer=MOB_LAYER+1
	Experience=100
	Tier=2
	desc="Makes your melee attacks fire arrows that deal damage with Force.(30% Strength and 80% Force. Doesn't work with other ki-weapon moves.)"
	New()
		icon+=rgb(rand(35,200),rand(35,200),rand(35,200))
		..()
	verb/Toggle_Ki_Bow()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.SpiritSword) //Beefing things up
			usr<<"This can not be used with Spirit Sword"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
			return
		if(usr.KiBow==1)
			usr.KiBow = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1&&!usr.KiBow)
			usr.KiBow = Tier-1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] forms a bow of weaponized ki around their hand!")
			return
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
Skill/Misc/KiBow2
	UB2="War"
	UB1="Arcane Power"
	icon='Quincy Bow 2.dmi'
	layer=MOB_LAYER+1
	Experience=100
	Tier=3
	desc="Makes your melee attacks fire arrows that deal danage with Force.(40% Strength and 90% Force. Doesn't work with other ki-weapon moves.)"
	New()
		icon+=rgb(rand(35,200),rand(35,200),rand(35,200))
		..()
	verb/Toggle_Ki_Bow_2()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.SpiritSword)
			usr<<"This can not be used with Spirit Sword"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
			return
		if(usr.KiBow==2)
			usr.KiBow = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1&&!usr.KiBow)
			usr.KiBow = Tier-1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] forms a bow of weaponized ki around their hand!")
			return
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
Skill/Misc/KiBow3
	UB1="War"
	UB2="Arcane Power"
	icon='Quincy Bow 3.dmi'
	layer=MOB_LAYER+1
	Experience=100
	Tier=4
	desc="Makes your melee attacks fire arrows that deal danage with Force.(50% Strength and 100% Force. Doesn't work with other ki-weapon moves.)"
	New()
		icon+=rgb(rand(35,200),rand(35,200),rand(35,200))
		..()
	verb/Toggle_Ki_Bow_3()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.SpiritSword)
			usr<<"This can not be used with Spirit Sword"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
			return
		if(usr.KiBow==3)
			usr.KiBow = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1&&!usr.KiBow)
			usr.KiBow = Tier-1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] forms a bow of weaponized ki around their hand!")
			return
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
mob/var/tmp/KiBlade = 0
Skill/Misc/KiBlade
	UB1="Armament"
	UB2="Arcane Power"
	icon='KiSword.dmi'
	layer=MOB_LAYER+1
	Experience=100
	Tier=2
	desc="Makes your melee attacks damage with Force.(20% Strength and 80% Force. Counts as +30% BP. Doesn't work with other ki-weapon moves.)"
	New()
		icon+=rgb(rand(35,200),rand(35,200),rand(35,200))
		..()
	verb/Toggle_Ki_Blade()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.KiBow)
			usr<<"This can not be used with Ki Bow"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.SpiritSword)
			usr<<"This can not be used with Spirit Sword"
			return
		if(usr.KiBlade)
			usr.KiBlade = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1)
			usr.KiBlade = 1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] forms a blade of weaponized ki around their hand!")
			return
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
mob/var/tmp/KiHammer = 0
Skill/Misc/KiHammer
	UB1="Armament"
	UB2="Arcane Power"
	icon='KiSword.dmi'
	layer=MOB_LAYER+1
	Experience=100
	Tier=3
	desc="Makes your melee attacks damage with Force.(30% Strength and 80% Force. Counts as +60% BP, but reduces Speed and Offense by 20%. Doesn't work with other ki-weapon moves.)"
	New()
		icon+=rgb(rand(35,200),rand(35,200),rand(35,200))
		..()
	verb/Toggle_Ki_Hammer()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.KiBow)
			usr<<"This can not be used with Ki Bow"
			return
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
			return
		if(usr.SpiritSword)
			usr<<"This can not be used with Spirit Sword"
			return
		if(usr.KiHammer)
			usr.KiHammer = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1)
			usr.KiHammer = 1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] forms a massive hammer of weaponized ki around their hand!")
			return
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
mob/var/tmp/SpiritSword = 0
Skill/Misc/SpiritSword
	icon='Spirit Sword.dmi'
	layer=MOB_LAYER+1
	Experience=100
	Tier=3
	desc="Makes your melee attacks damage with Force.(40% Strength and 80% Force. Counts as a +50% BP weapon, but reduces Speed by 30% and Offense by 10%. Doesn't work with other ki-weapon moves.)"
	New()
		icon=pick('Spirit Sword.dmi','Soul Eater.dmi','Kingdom Key.dmi','Sam Sword.dmi','Sagefire Sword.dmi','DualScim.dmi','Double Helix Sword.dmi')
		if(prob(80)) icon+=rgb(rand(0,95),rand(0,95),rand(0,95))
		..()
	verb/Toggle_Spirit_Sword()
		set category="Other"
		if(usr.RPMode) return
		if(usr.KiFists)
			usr<<"This can not be used with Ki Fists"
			return
		if(usr.KiBow)
			usr<<"This can not be used with Ki Bow"
			return
		if(usr.KiBlade)
			usr<<"This can not be used with Ki Blade"
			return
		if(usr.KiHammer)
			usr<<"This can not be used with Ki Hammer"
			return
		if(usr.SpiritSword)
			usr.SpiritSword = 0
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] allows their weaponized ki to fade...")
			usr.overlays-=src
			return
		else if(usr.Ki>usr.MaxKi*0.1)
			usr.SpiritSword = 1
			usr.Ki*=0.99
			usr.overlays+=src
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] turns their ki into a weapon made of life energy!")
			return
mob/var/tmp/AttackXY
/*
mob/verb/UltraLightBeam()
	filters += filter(type = "rays",size=48,density=32,factor=0.2,threshold=0,offset=100)
	while(src)
		animate(filters[filters.len], size = (48+rand(-8,8)),factor=(rand(10,30)/10),offset=rand(75,125), time = 10)
		sleep(10)
*/
/*
    x
        Horiztonal position of ray center, relative to image center (defaults to 0)
    y
        Vertical position of ray center, relative to image center (defaults to 0)
    size
        Maximum length of rays (defaults to 1/2 tile width)
    color
        Ray color (defaults to white)
    offset
        "Time" offset of rays (defaults to 0, repeats after 1000)
    density
        Higher values mean more, narrower rays (defaults to 10, must be whole number)
    threshold
        Low-end cutoff for ray strength (defaults to 0.5, can be 0 to 1)
    factor
        How much ray strength is related to ray length (defaults to 0, can be 0 to 1)
    flags
        Defaults to FILTER_OVERLAY | FILTER_UNDERLAY (see below)*/

mob/proc/getAttackXY()if(!AttackXY)
	filters += filter(type = "blur", size = 1)
	spawn(2) filters -= filter(type = "blur", size = 1)
	AttackXY=1
	switch(dir)
		if(EAST)
			pixel_x+=8
		if(NORTHEAST)
			pixel_x+=4
			pixel_y+=4
		if(SOUTHEAST)
			pixel_x+=4
			pixel_y-=4
		if(WEST)
			pixel_x-=8
		if(NORTHWEST)
			pixel_x-=4
			pixel_y+=4
		if(SOUTHWEST)
			pixel_x-=4
			pixel_y-=4
		if(NORTH)
			pixel_y+=8
		if(SOUTH)
			pixel_y-=8
	spawn(2)
		pixel_x=adjustedX
		pixel_y=adjustedY
		spawn() AttackXY=0





Skill/Melee/Torrential_Strike
	Experience=100
	Tier=4
	desc="Launches an attack that drowns your opponent in a torrent of water and creates water tiles that last for 20 seconds. Drains energy equal to half the damage dealt."
	verb/Torrential_Strike()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<150) return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				flick("Attack",usr)
				if(Experience<100) Experience+=rand(5,12)
				if(Experience>100) Experience=100
				CDTick(usr)
				//usr.DrainKi(src,"Percent",15)//usr.Ki=max(0,usr.Ki-rand(50,75))
				usr.DrainKi(src, 1, 150,show=1)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=1,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.5
						if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
							M.TakeDamage(usr, Damage, "[src]")
							M.DrainKi(src,"Percent",Damage*0.5)
							M.Torrential()
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
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


mob/proc/Torrential()
	DrownWaterOver(src)
	for(var/turf/T in view(src,4)) new/obj/Hazard/Drowning_Water(T)



/*

						var/startx=usr.x-5
						var/starty=usr.y-5
						var/endx=usr.x+5
						var/endy=usr.y+5
						if(startx<1) startx=1
						if(starty<1) starty=1
						if(endx>world.maxx) endx=world.maxx
						if(endy>world.maxy) endy=world.maxy
						var/placer=startx
						var/placery=starty
						spawn()
							while(placery<endy+1)
								var/turf/C=new /obj/Blocker/EarthPrison(locate(placer,placery,usr.z))
								C.Builder="[usr.real_name]"
								C.Health=(usr.Magic_Level**3)*500
								spawn(200) del(C)
								if(placer>=endx)
									placer=startx
									placery++
								else placer++
								sleep(0)

*/










mob/var/tmp/HeartAiming=0
Skill/Misc/AimForTheHeart//adds stagger to attacks for next 20 seconds
	Experience=100
	Tier=5
	desc="Causes all of your attacks for the next 8 seconds to deal 10% damage, but it is dealt as pure WP damage instead of HP."
	verb/Aim_For_The_Heart()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		usr.HeartAiming=5
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s stance adapts as they aim for the heart.")
		CDTick(usr)
mob/var/tmp/IceyGrip=0
Skill/Misc/Icey_Grip//adds stagger to attacks for next 20 seconds
	Experience=100
	Tier=5
	icon='Ice Wing.dmi'
	pixel_x=-32
	layer=EFFECTS_LAYER+5
	desc="Causes all of your attacks for the next 10 seconds to slow and have a chance to stun. Only affects attack verb."
	verb/Icey_Grip()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		usr.IceyGrip=7
		usr.overlays+=src
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr] sprouts wings of ice as they empower their attacks with frost.")
		CDTick(usr)
mob/proc/GripOfIce()
	set waitfor=0
	Slow(src,5,25)
	if(prob(20)) Stun(src,1)
	IceyGrip(src)
mob/var/tmp/CriticalEdge=0
Skill/Melee/CriticalEdge//adds stagger to attacks for next 20 seconds
	Experience=100
	UB1="Armament"
	UB2="Bestial Wrath"
	Tier=4
	desc="Causes all of your melee attacks that land for the next 14 seconds to have a 50% chance to be a critical strike for +33% damage."
	verb/Critical_Edge()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		usr.CriticalEdge=14
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s stance adapts as they aim to land a critical blow.")
		CDTick(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")

//mob/proc/Dodge()
mob/var/GuardBroken=0
mob/var/tmp/GuardBreaking=0
mob/var/tmp/GuardBreakingImmunity=0//grants immunity for 20 seconds after being Guard Broken
Skill/Melee/Guard_Break//adds stagger to attacks for next 20 seconds
	Experience=100
	UB1="War"
	UB2="Fists of Fury"
	Tier=3
	desc="Causes all of your melee attacks that land for the next 20 seconds to reduce the opponent's endurance and defense by 10% for 5 seconds."
	verb/Guard_Break()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		usr.GuardBreaking=14
		for(var/mob/player/M in view(usr)) M.BuffOut("[usr]'s stance adapts as they try to disrupt their opponent's guard.")
		CDTick(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")
/*
mob/var/SandInEyes=0
Skill/Melee/Guard_Break//adds stagger to attacks for next 20 seconds
	Experience=100
	desc="Causes all of your melee attacks that land for the next 15 seconds to reduce the opponent's endurance and defense by 10% for 5 seconds."
	verb/Guard_Break()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		CDTick(usr)



	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,750)
*/

mob/var/ChakraBlocked=0
mob/var/tmp/ChakraBlocking=0
Skill/Melee/Chakra_Blocking//adds stagger to attacks for next 20 seconds
	Tier=4
	Experience=100
	desc="Launches an attack that drains your opponents energy and reduces their recovery by 50% for 5 seconds."
	verb/Block_Chakra_Points()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<75) return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				flick("Attack",usr)
				if(Experience<100) Experience+=rand(5,12)
				if(Experience>100) Experience=100
				CDTick(usr)
				//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
				usr.DrainKi(src, 1, 75,show=1)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
				var/Damage=DamageFormula(usr,M,Strength=0.75,Force=0.75,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.2
						if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.2)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
							M.TakeDamage(usr, Damage, "[src]")
							M.DrainKi(src,"Percent",Damage*1.1)
							for(var/mob/player/MM in view(usr)) MM.BuffOut("[usr] has sealed [M]s chakra points.")
							M.ChakraBlocked=5
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*3)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)

Skill/Weapon/Wind_Howl//AoE for Swords that uses a circle effect that just expands outward to look pretty
	desc="Unleash a devastating slicing attack that hits all of those around you."
	Tier=3
	verb/Wind_Howl() //hits everyone around you //can use with sword but no bonus damage
		set category="Skills"
		UB1="Armament"
		UB2="Bestial Wrath"
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		var/hashit=0
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<150) return
		for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
		CDTick(usr)
		var/Hit=0
		for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) Hit=1
		if(Hit)
			flick("Attack",usr)
			//usr.DrainKi(src,"Percent",15)//usr.Ki=max(0,usr.Ki-100)
			usr.DrainKi(src, 1, 150,show=1)
			ShockwaveScale(usr,usr.BP,1)
			LargeDust(usr)
			for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
				if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
					//usr.DrainKi(src,"Percent",5)
					usr.DrainKi(src, 1, 25,show=1)
					var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
					var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						hashit=1
						flick("Attack",usr)
						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage * 0.5
							if(prob(25))
								ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							M.KB=round(Damage*0.5)
							if(M.KB>10) M.KB=10
							if(prob(50)) M.KB++
							if(prob(50)) M.KB++
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							spawn M.KnockBack(usr)
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(usr, Damage, "[src]")
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
						//if(M&&M.Life<=0) M.Death(usr)
			DustCloud(usr)
			if(hashit)
				if(Experience<100) Experience+=rand(5,22)
				if(Experience>100) Experience=100
				usr.attacking=1
				spawn(usr.Refire) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")

Skill/Melee/WarpAttack
	desc="Automatically warp to your target and attack them."
	Tier=1
	verb/Warp_Attack()
		set category="Skills"
		if(usr.GrabbedMob) return
		if(!usr.CanAttack(10,src)) return
		var/mob/hitter
		if(usr.Target&& ismob(usr.Target)) if(usr.Target.z==usr.z) if(get_dist(usr,usr.Target)<=10) if(usr.Target in oviewers(10,usr))  hitter=usr.Target
		if(!hitter) return
		if(hitter==usr) return
		if(hitter.afk||hitter.KOd||!hitter.attackable||hitter.RPMode||hitter.adminDensity) return
		if(!locate(hitter) in viewers(usr)) return
		if(!locate(usr) in viewers(hitter)) return
		if(hitter.RPMode) return
		if(hitter&&hitter.Health>0)
			//usr.DrainKi(src,"Percent",1)//usr.Ki=max(0,usr.Ki-10)
			usr.DrainKi(src, 1, 10,show=1)
			CDTick(usr)
			usr.attacking=1
			//spawn(usr.Refire*0.2)if(usr.attacking!=3) usr.attacking=0
			var/didBlock=0
			flick(usr.CustomZanzokenIcon,usr)
			ZanzoDust(usr)
			usr.Comboz(hitter)
			flick("Attack",usr)
			var/Evasion=AccuracyFormula(usr,hitter,KiManip=0,Chance=WorldDefaultAcc)
			var/Damage=DamageFormula(usr,hitter,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)

			if(!usr.HammerOn&&!usr.SwordOn&&!usr.KiBlade)
				if(usr.HasWayOfTheOpenPalm&&!usr.KiFists) Damage=DamageFormula(usr,hitter,Strength=1,Force=0,Speed=0.1,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				else if(usr.KiFists&&usr.HasWayOfTheOpenPalm)
					Evasion=AccuracyFormula(usr,hitter,KiManip=2,Chance=WorldDefaultAcc)
					Damage=DamageFormula(usr,hitter,Strength=0.7,Force=0.3,Speed=0.1,Offense=0,DamageType="KiFist",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				else if(usr.KiFists)
					Evasion=AccuracyFormula(usr,hitter,KiManip=2,Chance=WorldDefaultAcc)
					Damage=DamageFormula(usr,hitter,Strength=0.7,Force=0.3,Speed=0,Offense=0,DamageType="KiFist",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
			if(usr.KiBlade)
				Evasion=AccuracyFormula(usr,hitter,KiManip=1,Chance=WorldDefaultAcc)
				Damage=DamageFormula(usr,hitter,Strength=0.2,Force=0.8,Speed=0,Offense=0,DamageType="Ki",BaselineDamage=2,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)


			if(!prob(Evasion))
				flick(hitter.CustomZanzokenIcon,hitter)
				hitter.CombatOut("You dodge [usr].")
				usr.CombatOut("[hitter] dodges you.")
			else //Successful hit
				if(usr.Race=="Yardrat")
					Damage*=1.1
				if(!prob(Evasion+(hitter.HasWayOfTheTurtle*2.5)))
					ShockwaveScale(hitter,usr.BP,1)
					Damage = Damage * 0.5
					didBlock=1
				if(prob(25))
					ImpactDust(hitter,usr.dir)//ShockwaveIcon(null,"Impact",hitter.loc)
				ASSERT(hitter)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
				if(hitter)
					Damage=Damage
					if(usr.HasZanzokenMaster) Damage*=1.2
					if(!isnum(hitter.Health)) return
					var/AttackOut=""
					if(didBlock==1)AttackOut="Blocked"
					else if(didBlock==2) AttackOut="(Armor) Blocked"
					hitter.TakeDamage(usr, Damage, "[AttackOut] [src]")
					usr.Comboz(hitter)
			if(Experience<100) Experience+=rand(1,5)
			if(Experience>100) Experience=100
			spawn(usr.Refire/5)if(usr.attacking!=3) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")



mob/var/tmp/DashAttacking=0
Skill/Melee/DashAttack
	Tier=1
	desc="Use your impressive speed to rush at your opponent and strike them as you advance. Adds 20% of your speed to your attack damage."
	verb/Dash_Attack()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<50) return
		if(!usr.CanDashAttack) return
		var/Distance=8
		CDTick(usr)
		if(usr.Ki>usr.MaxKi*0.05)
			usr.DashAttacking=1
			usr.attacking=1
			if(Experience<100) Experience+=rand(5,12)
			if(Experience>100) Experience=100
			usr.DrainKi(src, 1, 50,show=1)
			while(src&&usr&&Distance&&usr.Health>0)
				if(usr.Ki<20) break
				//usr.DrainKi(src,"Percent",2.5)//usr.Ki=max(0,usr.Ki-20)

				if(usr.Flying) usr.Flight_Land()
				step(usr,usr.dir)
				Distance--
				usr.AfterImage("Dash Attack")
				usr.AfterImage("Dash Attack")
				for(var/mob/M in get_step(usr,usr.dir)) if(M!=usr)if(!M.adminDensity&&M.attackable)
					if(M.afk==0&&!M.RPMode)
						if(M.Blocking)
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] blocks [usr]s [src]!")
							ShockwaveScale(usr,usr.BP,1)
							BlockEffect(M)
							Crater(M)
							Distance=0
						else
							flick("Attack",usr)
							var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=WorldDefaultAcc)
							var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0.2,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
							if(prob(50) && Distance>1) Distance--
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
										ShockwaveScale(M,usr.BP,1)
										Damage = Damage * 0.5
										if(prob(65))
											M.dir=turn(M.dir,pick(-45,45))
											step(M,M.dir)
									if(prob(25))
										ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
									M.KB=round(Damage*0.5)
									if(M.KB>3) M.KB=3
									ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
									if(prob(65))
										M.dir=turn(M.dir,pick(-45,45))
										step(M,M.dir)
									M.KnockBack(usr)
									if(M)
										if(!isnum(M.Health)) return
										M.TakeDamage(usr, Damage, "[src]")
							else
								flick("Attack",usr)
	//							M.BPDamage(usr,Damage,5)
								M.KB=round((usr.Str/M.End)*5)
								if(M.KB>5) M.KB=5
								M.KnockBack(usr)
				if(Distance<=0) break
				sleep(rand(1,2/max(1,Experience/50)))
			usr.DashAttacking=0
			spawn(usr.Refire) usr.attacking=0

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")
Skill/Weapon/Iai_Slash
	Tier=3
	UB1="Armament"
	UB2="Godspeed"
	desc="Use your impressive speed to rush at your opponent and strike them as you pass dealing bonus damage with 30% of your speed and an increased baseline damage. This technique is like dash attack except you will phase through your opponents and damage them at the end of the travel."
	verb/Iai_Slash()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		if(usr.Ki<50) return
		if(!usr.CanDashAttack) return
		var/Distance=6
		Distance+=round(usr.SpdMod)
		CDTick(usr)
		var/list/HitMobs=list()
		animate(usr, alpha = 155, time = 2)
		if(usr.Ki>usr.MaxKi*0.05)
			usr.DashAttacking=1
			usr.attacking=1
			if(Experience<100) Experience+=rand(5,12)
			if(Experience>100) Experience=100
			usr.DrainKi(src, 1, 100,show=1)
			while(src&&usr&&Distance&&usr.Health>0)
				if(usr.Ki<20) break
				for(var/mob/M in get_step(usr,usr.dir)) if(M!=usr)if(!M.adminDensity&&M.attackable)
					if(M.afk==0&&!M.RPMode)
						if(M.Blocking)
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] blocks [usr]s [src]!")
							ShockwaveScale(usr,usr.BP,1)
							BlockEffect(M)
							Crater(M)
						else
							flick("Attack",usr)
							var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=WorldDefaultAcc)
							if((M.KOd==0&&M.client))
								if(M.attacking==1) usr.Opp(M)
								if(!prob(Evasion))
									flick(M.CustomZanzokenIcon,M)
									M.CombatOut("You dodge [usr].")
									usr.CombatOut("[M] dodges you.")
								else //Successful hit
									if(!(M in HitMobs)) HitMobs+=M
				if(Distance<=0) break
				sleep(min(3,100/Experience))
				//usr.DrainKi(src,"Percent",2.5)//usr.Ki=max(0,usr.Ki-20)
				//usr.DrainKi("Iai Slash", 1, 25,show=1)
				step(usr,usr.dir)
				Distance--
				//usr.density=0
			for(var/mob/M in HitMobs)
				if((M.KOd==0&&M.client))
					var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0.3,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
					ShockwaveScale(M,usr.BP,1)
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
					M.KB=round(Damage*0.5)
					if(M.KB>3) M.KB=3
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					M.KnockBack(usr)
					if(M)
						if(!isnum(M.Health)) return
						M.TakeDamage(usr, Damage, "[src]")
				else
					flick("Attack",usr)
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
			animate(usr, alpha = 255, time = 2)
			spawn(usr.Refire)
				usr.attacking=0
				usr.DashAttacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")


mob/var/Wing_Clipped=0
Skill/Melee/Wing_Clip
	Tier=3
	UB1="Bestial Wrath"
	UB2="Fists of Fury"
	desc="Launch a cheap attack against an opponent's joints in order to reduce their speed by 40% for 8 seconds if it lands. This will also stagger their movement."
	verb/Wing_Clip()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<75) return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				flick("Attack",usr)
				if(Experience<100) Experience+=rand(5,12)
				if(Experience>100) Experience=100
				CDTick(usr)
				//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
				usr.DrainKi(src, 1, 100,show=1)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=1,UsesWeapon=1,IgnoresEnd=0)
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
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
							M.Injure_Hurt(rand(15,20)/10*Damage,"Legs",usr)
							M.TakeDamage(usr, Damage, "[src]")
							winset(M.client,"Wing_Clipd","is-visible=true")
							M.Wing_Clipped=5
							Stagger(M,5)
							hearers(6,M) << "[usr] has weakened [M]s joints with a cheap attack."
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

Skill/Melee/AxeKick
	UB2="High Tension"
	UB1="Fists of Fury"
	Tier=4
	desc="Launch a powerful kick that deals bonus damage based on strength and speed."
	verb/Axe_Kick()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<125) return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				flick("Attack",usr)
				if(Experience<100) Experience+=rand(5,12)
				if(Experience>100) Experience=100
				CDTick(usr)
				//usr.DrainKi(src,"Percent",12.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
				usr.DrainKi(src, 1, 150,show=1)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=70)
				var/Damage=DamageFormula(usr,M,Strength=1.25,Force=0,Speed=0.25,Offense=0,DamageType="Physical",BaselineDamage=2.5,FlatDamage=1,UsesWeapon=0,IgnoresEnd=0)
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
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
							M.TakeDamage(usr, Damage, "[src]")
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
Skill/Melee/Kickback_Combo
	Tier=3
	UB1="High Tension"
	UB2="Fists of Fury"
	desc="Launch a two part attack, the first part hits with guaranteed knockback and the second one warps to your opponent for a follow up attack. The follow up attack will be cancelled if the opponent is blocking."
	verb/Kickback_Combo()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<150) return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			flick("Attack",usr)
			if(Experience<100) Experience+=rand(5,12)
			if(Experience>100) Experience=100
			CDTick(usr)
			//usr.DrainKi(src,"Percent",15)//usr.Ki=max(0,usr.Ki-rand(50,75))
			usr.DrainKi(src, 1, 150,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=0,UsesWeapon=0,IgnoresEnd=0)
				if((M.KOd==0&&M.client))
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						ShockwaveScale(M,usr.BP,1)
						Damage = Damage * 0.5
					if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
					M.KB=max(3,Damage*5)
					if(M.KB>20) M.KB=20
					ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
					spawn() M.KnockBack(usr)
					if(M)
						if(!isnum(M.Health)) return
						M.TakeDamage(usr, Damage, "[src]")
						ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
						spawn(M.KB)
							usr.AfterImage("Dash Attack")
							usr.AfterImage("Dash Attack")
							usr.Comboz(M)
							if(M.Blocking)
								for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] blocks [usr]s [src]!")
								ShockwaveScale(usr,usr.BP,1)
								Crater(M)
							else
								Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
								Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=2,UsesWeapon=0,IgnoresEnd=0)
								if(!prob(Evasion))
									flick(M.CustomZanzokenIcon,M)
			//						hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
									M.CombatOut("You dodge [usr].")
									usr.CombatOut("[M] dodges you.")
								else //Successful hit
									if(!prob(Evasion))
										ShockwaveScale(M,usr.BP,1)
										Damage = Damage * 0.5
									if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
									M.KB=round(Damage*0.5)
									if(M.KB>5) M.KB=5
									ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
									spawn() M.KnockBack(usr)
									if(M)
										if(!isnum(M.Health)) return
										M.TakeDamage(usr, Damage, "[src]")
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


Skill/Weapon/CleaveAttack
	Tier=2
	UB1="Armament"
	desc="Use a sword or hammer to attack the three tiles in front of your character. This attack has increased accuracy and damage compared to a normal attack."
	verb/Cleave_Attack()
		set category="Skills"
		var/hashit=0
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<75) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
		CDTick(usr)
		flick("Attack",usr)
		SlashUser(usr)
		for(var/mob/M in get_step(usr,usr.GetCleave(usr.dir,0))) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			SweepingBlade(usr)
			//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
			usr.DrainKi(src, 1, 75,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)  //
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
//				var/didBlock=0
				if((M.KOd==0&&M.client))
					hashit=1
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
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
//							hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')'
							M.Injure_Hurt(rand(10,20)/10*Damage,"Body",usr)
							M.TakeDamage(usr, Damage, "[src]")
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

		for(var/mob/M in get_step(usr,usr.GetCleave(usr.dir,1))) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(usr.client&&!usr.attacking)
				if(usr.Ki<1) return
				//usr.DrainKi(src,"Percent",1)
				usr.DrainKi(src, 1, 10,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					hashit=1
					//attacking=1
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
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
//							hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.TakeDamage(usr, Damage, "[src]")
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,2)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
		for(var/mob/M in get_step(usr,usr.GetCleave(usr.dir,2))) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			if(usr.client&&!usr.attacking)
				if(usr.Ki<1) return
				//usr.DrainKi(src,"Percent",1)
				usr.DrainKi(src, 1, 10,show=1)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					hashit=1
					//attacking=1
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
						if(prob(25))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						M.KB=round(Damage*0.5)
						if(M.KB>5) M.KB=5

						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						spawn() M.KnockBack(usr)
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage,3)
////							hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.TakeDamage(usr, Damage, "[src]")
							ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage,2)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					M.KB=round((usr.Str/M.End)*5)
					if(M.KB>5) M.KB=5
					M.KnockBack(usr)
					//if(M&&M.Life<=0) M.Death(usr)
		if(hashit)
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			usr.attacking=1
			spawn(usr.Refire) usr.attacking=0

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")



//Implement cooldown however you are currently with a base cooldown of 30 seconds, training it will bring it to(Or use zanzoken mastery instead) 10-12 and then divided by speed mod
//drain 3x as much as a normal attack
//zanzo combos the primary target

Skill/Melee/RoundhouseKick
	desc="Unleash a devastating roundhouse kick that hits everyone around you. This attack has reduced knockback but 150% damage."
	verb/Roundhouse_Kick() //hits everyone around you //can use with sword but no bonus damage
		set category="Skills"
		Tier=1
		var/hashit=0
		if(usr.Critical_Left_Leg&&usr.Critical_Right_Leg)
			usr<<"Both your legs are injured, you may not use this."
			return
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<150) return
		for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
		var/Hit=0
		for(var/mob/M in oview(usr,1)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) Hit=1
		if(Hit)
			SweepingKick(usr)
			CDTick(usr)
			flick("Attack",usr)
			spawn(1) usr.RHK()
			usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi(src,"Percent",15)//usr.Ki=max(0,usr.Ki-100)
			LargeDust(usr)
			for(var/mob/M in oview(usr,1)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
				if(!usr.attacking) if(M.afk == 0&&!M.RPMode)//
					usr.DrainKi(src, 1, 10,show=1)//usr.DrainKi(src,"Percent",0.5)
					var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=WorldDefaultAcc)
					var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=4,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						hashit=1
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
//								didBlock=1
							if(prob(25))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							M.KB=round(Damage*0.5)
							if(M.KB>10) M.KB=10
							if(prob(50)) M.KB++
							if(prob(50)) M.KB++
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							spawn M.KnockBack(usr)
							if(M)
								if(!isnum(M.Health)) return
//								M.BPDamage(usr,Damage,5)
//								hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
								M.Injure_Hurt(rand(5,15)/10*Damage,"Arms",usr)
								M.TakeDamage(usr, Damage, "[src]")
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
//						M.BPDamage(usr,Damage,10)
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
						//if(M&&M.Life<=0) M.Death(usr)
			DustCloud(usr)
			if(hashit)
				if(Experience<100) Experience+=rand(5,12)
				if(Experience>100) Experience=100
				usr.attacking=1
				spawn(usr.Refire) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")

Skill/Weapon/SwordStab
	desc="Use your sword to stab your enemy and the tile behind them. Scaling bonus damage with strength mod and increased damage to armor, with a higher chance power armor to hit than normal."
	Tier=2
	UB1="Armament"
	UB2="War"
	verb/Sword_Stab()//hits directly in front of you, piercing two tiles, and with bonus damage
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<120) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		CDTick(usr)
		for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[usr] prepares to [usr.SwordOn?"stab with their sword":"swing with their hammer"].")
		sleep(usr.Refire)
		var/Pen=0
		var/didHit=0
		flick("Attack",usr)
		StabUser(usr)
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable)
			if(M.CatchBladeActive)
				for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] catches [usr]s weapon.")
				M.dir=get_dir(M,src)
				usr.GetDisarmed(M,8)
				Stun(usr,0.5)
				M.CatchBladeActive=0
				return
			if(usr.client)
				if(usr.Ki<100) return
				usr.DrainKi(src, 1, 100,show=1)//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-100)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode) //
				didHit=1
				flick("Attack",usr)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=WorldDefaultAcc)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=5,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
				if(Experience<100) Experience+=rand(3,6)
				if(Experience>100) Experience=100
//				var/didBlock=0
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					usr.attacking=1
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
							Damage = Damage * 0.35
//							hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
//							didBlock=1
						if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						if(M)
							if(!isnum(M.Health)) return
//							M.BPDamage(usr,Damage*2,5)
//							hearers(6,M) << pick('Melee_Strike1.wav','Melee_Strike2.wav','Melee_Strike3.wav')
							M.Injure_Hurt(rand(10,20)/10*Damage,"Body",usr)
							M.TakeDamage(usr, Damage, "[src]")
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
//					M.BPDamage(usr,Damage*2,2)
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//if(M&&M.Life<=0) M.Death(usr)
		for(var/turf/T in view(0,get_step(usr,usr.dir))) if(!T.density) Pen=1
		if(Pen)
			for(var/mob/M in get_step(get_step(usr,usr.dir),usr.dir)) if(!M.adminDensity&&M.attackable)
				if(M.CatchBladeActive)
					for(var/mob/player/teleg in view(usr)) teleg.CombatOut("[M] catches [usr]s weapon.")
					M.dir=get_dir(M,src)
					usr.GetDisarmed(M,8)
					Stun(usr,0.75)
					M.CatchBladeActive=0
					return
				if(usr.client)
					if(usr.Ki<20) return
					usr.DrainKi(src, 1, 20,show=1)//usr.DrainKi(src,"Percent",2)
				if(M.afk == 0&&!M.RPMode) //
					didHit=1
					var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=WorldDefaultAcc)
					var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=4,UsesWeapon=1,IgnoresEnd=0)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						flick("Attack",usr)
						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage * 0.35
							if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(usr, Damage, "[src]")
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//if(M&&M.Life<=0) M.Death(usr)
		if(didHit) spawn(usr.Refire) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")
mob/proc/SmashHole()
	for(var/turf/T in get_step(usr,usr.dir)) if(!T.density)
		KBHole2(T,usr.dir,1)
	for(var/turf/T in get_step(get_step(usr,usr.dir),usr.dir)) if(!T.density)
		KBHole2(T,usr.dir)
	for(var/turf/T in get_step(get_step(get_step(usr,usr.dir),usr.dir),usr.dir)) if(!T.density)
		KBHole2(T,usr.dir,2)
Skill/Weapon/Overhead_Smash
	Tier=3
	UB2="High Tension"
	UB1="Armament"
	desc="Use your weapon to smash the three tiles in front of your character. This attack has good damage but lower than normal accuracy."
	verb/Overhead_Smash()//hits directly in front of you, piercing two tiles, and with bonus damage
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<175) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable)
			if(usr.client)
				if(usr.Ki<100) return
				usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-100)
				CDTick(usr)
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode) //
				flick("Attack",usr)
				var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
				var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=1,UsesWeapon=1,IgnoresEnd=0)
				if(Experience<100) Experience+=rand(8,16)
				if(Experience>100) Experience=100
//				var/didBlock=0
				if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
					usr.attacking=1
					flick("Attack",usr)
					if(M.attacking==1) usr.Opp(M)
					if(!prob(Evasion))
						flick(M.CustomZanzokenIcon,M)
						M.CombatOut("You dodge [usr].")
						usr.CombatOut("[M] dodges you.")
					else //Successful hit
						if(!prob(Evasion))
							ShockwaveScale(M,usr.BP,1)
							Damage = Damage * 0.35
						if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
						ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
						if(M)
							if(!isnum(M.Health)) return
							M.Injure_Hurt(rand(10,20)/10*Damage,"Head",usr)
							M.TakeDamage(usr, Damage, "[src]")
				else
					flick("Attack",usr)
					if(!isnum(M.Life)) return
					M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
					//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
					//if(M&&M.Life<=0) M.Death(usr)
		for(var/turf/T in view(0,get_step(usr,usr.dir))) if(!T.density)
			for(var/mob/M in get_step(get_step(usr,usr.dir),usr.dir)) if(!M.adminDensity&&M.attackable)
				if(usr.client)
					if(usr.Ki<20) return
					usr.DrainKi(src, 1, 100,show=1)//usr.DrainKi(src,"Percent",10)
					CDTick(usr)
				if(M.afk == 0&&!M.RPMode) //
					var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
					var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=1,UsesWeapon=1,IgnoresEnd=0)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						flick("Attack",usr)

						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage * 0.35
							if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(usr, Damage, "[src]")
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//if(M&&M.Life<=0) M.Death(usr)
		for(var/turf/T in view(0,get_step(get_step(usr,usr.dir),usr.dir))) if(!T.density)
			for(var/mob/M in get_step(get_step(get_step(usr,usr.dir),usr.dir),usr.dir)) if(!M.adminDensity&&M.attackable)
				if(usr.client)
					if(usr.Ki<20) return
					usr.DrainKi(src, 1, 100,show=1)//usr.DrainKi(src,"Percent",10)
					CDTick(usr)
				if(M.afk == 0&&!M.RPMode) //
					var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
					var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=1,UsesWeapon=1,IgnoresEnd=0)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						flick("Attack",usr)

						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage * 0.35
							if(prob(75))ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(usr, Damage, "[src]")
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//if(M&&M.Life<=0) M.Death(usr)
		usr.SmashHole()
		if(Experience<100) Experience+=rand(1,5)
		if(Experience>100) Experience=100
		spawn(usr.Refire) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")
mob/var/tmp/Smashing=0
Skill/Unarmed/Texas_Smash
	UB1="High Tension"
	UB2="Shadow King"
	Tier=4
	desc="This attack is a two cast attack. The first cast has you begin to charge the attack, it takes a minimum time but it becomes more powerful the more damage you take. The second cast will actually fire the attack. This attack has +50% extra strength added to the damage."
	verb/Texas_Smash()//hits directly in front of you, piercing two tiles, and with bonus damage
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05)) return
		if(usr.Ki<175) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return

		if(!usr.Smashing)
			if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
			usr.DrainKi(src, 1, 200,show=1)//usr.DrainKi(src,"Percent",20)
			CDTick(usr)
			for(var/mob/M in range(20,usr))M.CombatOut("[usr] begins to charge a [src]!")
			usr.Smashing=1
			if(Experience<100) Experience+=rand(5,21)
			if(Experience>100) Experience=100
		if(usr.Smashing>=5) usr.TexasSmash()

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")
Skill/Weapon/Colossal_Impact
	Tier=3
	UB2="High Tension"
	UB1="Armament"
	desc="Use your weapon to unleash a gigantic shockwave underneath you."
	verb/Colossal_Impact() //hits everyone around you //can use with sword but no bonus damage
		set category="Skills"
		var/hashit=0
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<200) return
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		for(var/obj/items/Regenerator/R in range(0,usr)) if(R.z) return
		var/Hit=0
		usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi(src,"Percent",20)//usr.Ki=max(0,usr.Ki-100)
		CDTick(usr)
		flick("Attack",usr)
		Crater(usr)
		DustCloud(usr)
		for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0) Hit=1
		if(Hit)
			spawn(1) usr.RHK()
			for(var/mob/M in oview(usr,2)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
				if(!usr.attacking) if(M.afk == 0&&!M.RPMode)
					var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
					var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=2,UsesWeapon=1,IgnoresEnd=0)
					SmallCrater(M)
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						hashit=1
						flick("Attack",usr)
						if(M.attacking==1) usr.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [usr].")
							usr.CombatOut("[M] dodges you.")
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,usr.BP,1)
								Damage = Damage * 0.5
							if(prob(25)) ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							//spawn M.KnockBack(usr)
							spawn M.Shockwave_Knockback(3,usr.loc)
							DustCloud(M)
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(usr, Damage, "[src]")
					else
						flick("Attack",usr)
						if(!isnum(M.Life)) return
						M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
						//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						M.KB=round((usr.Str/M.End)*5)
						if(M.KB>5) M.KB=5
						M.KnockBack(usr)
						//if(M&&M.Life<=0) M.Death(usr)
					sleep(-1)
			if(hashit)
				if(Experience<100) Experience+=rand(8,18)
				if(Experience>100) Experience=100
				usr.attacking=1
				spawn(usr.Refire) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")
		