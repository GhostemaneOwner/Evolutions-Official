


mob/proc/Thunderstruck(whoer,dmg)
	var/obj/Lightning_Strike/S = new
	S.loc = locate(x,y + 3,z)
	S.Power = dmg
	S.Dest = loc
	var/image/AA=image('StatusEffects.dmi',icon_state="Shock", layer =MOB_LAYER+EFFECTS_LAYER+1)
	src.overlays+=AA
	if(prob(50))
		TakeDamage(whoer, dmg, "(Thundering Blows)")
		Stagger(src,2)
	else Stun(src,0.5)
	sleep(10)
	src.overlays-=AA


mob/var/tmp/BurnTicks=0
mob/var/tmp/Burns=0
mob/proc/BurnDamage(mob/Damager,Source,Damage) if(Burns<3)
	BurnTicks+=3
	Burns++
	while(src&&BurnTicks>0)
		var/image/AA=image('StatusEffects.dmi',icon_state="Burning", layer =MOB_LAYER+EFFECTS_LAYER+1)
		src.overlays+=AA
		TakeDamage(Damager, Damage, "[Source] (Burning)")
		BurnTicks--
		sleep(10)
		src.overlays-=AA
	Burns--


mob/var/tmp/BleedTicks=0
mob/var/tmp/Bleeds=0
mob/proc/BleedDamage(mob/Damager,Source,Damage) if(Bleeds<3)
	BleedTicks+=3
	Bleeds++
	while(src&&BleedTicks>0)
		TakeDamage(Damager, Damage, "[Source] (Bleeding)")
		if(prob(50))
			if(Race=="Android"||AndroidLevel&&prob(50)) OilTrail(src)
			else BloodTrail(src)
		BleedTicks--
		sleep(10)
	Bleeds--



mob/proc/HealDamage(Source, Amount)
	Health+=Amount
	if(Health>=MaxHealth) Health=MaxHealth
	CombatOut("(Heal) [(Amount)] health healed by [Source].")

mob/var/tmp/Smoldering=0
mob/proc/SmolderDamage()
	if(locate(/obj/Hazard/Burning_Embers) in range(src,0))
		Smoldering=1
		src.TakeDamage("Burning Embers", rand(50,100)/100, "Burning Embers")
		sleep(10)
		.()
	else Smoldering=0


mob/var/tmp/Drowning=0
mob/proc/DrownWater()
	if(locate(/obj/Hazard/Drowning_Water) in range(src,0))
		Drowning=1
		src.DrainKi(src,"Percent",rand(100,200)/100)
		sleep(10)
		.()
	else Drowning=0
obj/Hazard/Drowning_Water
	icon='DrowningWater.dmi'
	Savable=0
	density=0
	New()
		spawn(200) del(src)
		..()
	Crossed(mob/M)
		if(ismob(M))  // If they're a mob
			if(M.Flying|!M.density)  return ..() // And they're flying or not dense, let them go through water.
			else if(ismob(M)) if(M.Drowning==0) M.DrownWater()
		//M<<"Are you on fire yet?"
		..()

obj/Hazard/Burning_Embers
	icon='Debris.dmi'
	Savable=0
	density=0
	icon_state="D_Fire_Big"
	New()
		spawn(150) del(src)
		..()
	Crossed(mob/M)
		if(ismob(M))  // If they're a mob
			if(M.Flying|!M.density)  return ..() // And they're flying or not dense, let them go through water.
			else if(ismob(M)) if(M.Smoldering==0)M.SmolderDamage()
		//M<<"Are you on fire yet?"
		..()
		