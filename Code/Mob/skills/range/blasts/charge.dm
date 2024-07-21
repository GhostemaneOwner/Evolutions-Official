Skill/Attacks/Charge
//	Fatal=1
	Tier=1
	Experience=10
	icon='20.dmi'
	desc="An explosive one-shot energy attack that takes a few seconds to charge. With training its explosiveness and refire speed can increase."
	verb/Charge()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<50) return
		if(!usr.CanAttack(50,src)) return
		//if(!Learnable)
		//	Learnable=1
		//	spawn(100) Learnable=0
		if(Experience<100) Experience+=rand(2,4)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",5)//usr.Ki=max(0,usr.Ki-75)
		usr.DrainKi(src, 1, 50,show=1)
		CDTick(usr)
		usr.attacking=3
		charging=1
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.3
		Delay += 300 / Experience
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
//		hearers(6,usr) << 'Charge_Fire.wav'
		usr.overlays-=ChargeOver
		flick(usr,"Blast")
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		var/MaskDamage=0
		var/MaxSwordPercent=100

		if(usr.HasWeaponizedKi)
			for(var/obj/items/Sword/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Hammer/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Gauntlets/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			if(usr.BoundWeaponOn) MaskDamage=usr.BP*(0.4+(usr.BoundWeaponOn*0.1))
			if(usr.KiBlade)
				if(usr.HasBladeOfLight) MaskDamage=usr.BP*0.4
				else MaskDamage=usr.BP*0.3
			if(usr.KiHammer)
				MaskDamage=usr.BP*0.6
			if(usr.SpiritSword)
				MaskDamage=usr.BP*0.7
			if(usr.KiFists) if(MaskDamage<=usr.BP*0.18)
				MaskDamage=usr.BP*0.18

			if(MaskDamage>(MaxSwordPercent/100)*usr.BP) MaskDamage=(MaxSwordPercent/100)*usr.BP

		if(usr.MaskOn)
			for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=3.5*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
		A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off
		A.Explosive=0
		if(Experience>33) A.Explosive=1
		A.dir=usr.dir
		A.loc=usr.loc
		step(A,A.dir)
		if(A) walk(A,A.dir,1)
		usr.attacking=0
		charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

Skill/Attacks/Mortar_Charge
	UB1="War"
	UB2="Channel"
//	Fatal=1
	Tier=2
	Experience=10
	icon='16.dmi'
	desc="An explosive one-shot energy attack that takes a few seconds to charge, creates shrapnel on impact. With training its explosiveness and refire speed can increase."
	verb/Mortar()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<75) return
		if(!usr.CanAttack(75,src)) return
		if(Experience<100) Experience+=rand(2,5)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",7.5)
		//usr.Ki=max(0,usr.Ki-75)
		usr.DrainKi(src, 1, 75,show=1)
		CDTick(usr)
		usr.attacking=3
		charging=1
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.5
		Delay += 200 / Experience
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")

		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		usr.overlays-=ChargeOver
		flick(usr,"Blast")
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.Explosive=1
		A.Shrapnel=1
		A.density=1
		A.Radius=1
		if(prob(10)) A.Explosive=2
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.loc=usr.loc
		A.dir=usr.dir
		A.Belongs_To=usr
		A.name=src.name
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=5.5*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
		A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off*1.1
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")




Skill/Attacks/Exploding_Bolt
	UB1="War"
	UB2="Arcane Power"
//	Fatal=1
	Tier=3
	Experience=10
	icon='16.dmi'
	desc="An explosive one-shot ki bow shot that takes a few seconds to charge, creates shrapnel on impact. With training its explosiveness and refire speed can increase."
	verb/Exploding_Bolt()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<75) return
		if(!usr.CanAttack(75,src)) return
		if(!usr.KiBow)
			usr<<"This requires Ki Bow."
			return
		if(Experience<100) Experience+=rand(2,5)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",7.5)
		//usr.Ki=max(0,usr.Ki-75)
		usr.DrainKi(src, 1, 75,show=1)
		CDTick(usr)
		usr.attacking=3
		charging=1
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.5
		Delay += 200 / Experience
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		usr.overlays-=ChargeOver
		flick(usr,"Blast")
		var/obj/ranged/Blast/A=unpool("Blasts")
		flick("Blast",usr)
		A.Belongs_To=usr
		A.Explosive=1
		A.Shrapnel=1
		A.density=1
		if(prob(10)) A.Explosive=2
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-16,16)
		A.pixel_y+=rand(-16,16)
		A.name="Explosive Ki Arrow [usr.KiBow]"
		A.icon='Quincy Arrow.dmi'
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		switch(usr.KiBow)
			if(1)
				A.Damage=2.5*(usr.BP+MaskDamage)*((usr.Pow*0.8)+(usr.Str*0.3))*Ki_Power  //200
				A.Power=(usr.BP+MaskDamage)*Ki_Power
			if(2)
				A.Damage=2.5*(usr.BP+MaskDamage)*((usr.Pow*0.9)+(usr.Str*0.4))*Ki_Power  //200
				A.Power=(usr.BP+MaskDamage)*Ki_Power
			if(3)
				A.Damage=2.5*(usr.BP+MaskDamage)*((usr.Pow)+(usr.Str*0.5))*Ki_Power  //200
				A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off*1.1
		if(prob(30)) A.Shockwave=Shockwave
		A.dir=usr.dir
		A.loc=usr.loc
		if(usr.HasSmolder)
			A.CausesBurns=1
			A.icon='Arrow Charge.dmi'
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

