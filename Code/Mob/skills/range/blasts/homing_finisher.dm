
Skill/Attacks/Homing_Finisher
	UB1="Channel"
	icon='17.dmi'
	desc="This will create multiple low damage homing ki blasts that seek towards your target after a slight delay."
	var/Setting=10
	Experience=30
	Tier=3
	NoMove=1
	verb/Ki_Settings()
		set category="Other"
		Setting=input("Input the amount of blasts you want created when you use this attack. Default is [initial(Setting)]. You can fire [round(Experience/3)] max") as num
		if(Setting<1) Setting=1
		if(Setting>Experience/3) Setting=Experience/3
		if(Setting>33) Setting=33

	verb/Homing_Finisher()
		set category="Skills"
		if(usr.RPMode) return
		if(Setting>Experience/3) Setting=round(Experience/3)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<15*Setting) return
		if(!usr.CanAttack(12*Setting,src)) return
		var/Targs=list()
		for(var/mob/M in orange(usr,20)) Targs+=M
		Targs+="Cancel"
		var/mob/B=null
		if(usr.Target&&!usr.Target.KOd)B=usr.Target
		if(!B) B=input("Choose a target") in Targs
		if(B=="Cancel")
			return
		CDTick(usr)
		if(Setting>30) Setting=30
		usr.attacking=3
		if(Experience<100) Experience+=rand(4,11)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",1.5*Setting)//usr.Ki=max(0,usr.Ki-15*Setting)
		usr.DrainKi(src, 1, 15*Setting,show=1)
		var/amount=Setting
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/list/spawnArea = oview(usr,8)
		if(!length(spawnArea))
			usr.attacking=0
			return
		while(usr&&B)
			if(!amount||usr.KOd||(B.z!=usr.z)) break
			sleep(1)
			spawnArea = oview(usr,8)
			for(var/i=0, i<5, i++)
				if(!amount)
					break
				amount-=1
				flick("Blast",usr)
				var/obj/ranged/Blast/A=unpool("Blasts")
				A.Belongs_To=usr
				A.name=src.name
				A.pixel_x=pixel_x
				A.pixel_y=pixel_y
				A.pixel_x+=rand(-16,16)
				A.pixel_y+=rand(-16,16)
				A.density=0
				A.Belongs_To=usr
				A.icon=icon
				var/turf/pick = pick(spawnArea)
				A.loc = pick
				spawnArea -= pick
				A.Shockwave=1
				var/MaskDamage=0
				if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
					MaskDamage=MM.Health
					MM.DurabilityCheck(usr)
					break
				if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
				A.Damage=(usr.BP+MaskDamage)*usr.Pow*1.2*Ki_Power
				A.Power=(usr.BP+MaskDamage)*Ki_Power
				A.Offense=usr.Off
				if(A) A.dir=pick(alldirs)
				//spawn(50) A.density=1
				spawn(rand(10,60)/(Experience/50))
					A.density=1
					if((usr.icon_state in list("KO"))||usr.Frozen) return
					if(A) if(B) walk_towards(A,B)
		usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")


Skill/Attacks/Hellzone_Grenade
	UB1="Arcane Power"
	UB2="Channel"
	icon='15.dmi'
	Tier=4
	desc="This ki attack is a high damage shot that upon impact causes a double wave of explosions."
	Experience=10
	verb/Hellzone_Grenade()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<150) return
		if(!usr.CanAttack(150,src)) return
		CDTick(usr)
		//usr.DrainKi(src,"Percent",15)//usr.Ki=max(0,usr.Ki-75)
		usr.DrainKi(src, 1, 150,show=1)
		usr.attacking=3
		charging=1
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.3
		Delay += 400 / Experience
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")

		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
//		hearers(6,usr) << 'Charge_Fire.wav'
		usr.overlays-=ChargeOver
		flick(usr,"Blast")
		var/obj/ranged/Blast/A=unpool("Blasts")//HellzoneGrenade
		//A.Hellzone=1
		A.name=src.name
		A.Belongs_To=usr
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=6.6*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
		A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off
		A.Explosive=1
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

