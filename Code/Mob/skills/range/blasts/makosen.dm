Skill/Attacks/ExplosiveDemonWave
//	Fatal=1
	Tier=4
	UB1="Arcane Power"
	UB2="Channel"
	Experience=1
	icon='27.dmi'
	desc="This attack will charge up for a short while and then release a rain of short range ki blasts. These blasts have increased accuracy."
	verb/Explosive_Demon_Wave()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<400) return
		if(!usr.CanAttack(400,src)) return
		if(Experience<100) Experience+=rand(6,12)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",20)//usr.Ki=max(0,usr.Ki-400)
		usr.DrainKi(src, 1, 200,show=1)
		CDTick(usr)
		usr.attacking=3
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*1.4
		Delay +=  300 / Experience
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")

		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		usr.overlays-=ChargeOver
		var/Amount=60*max(0.5,Experience/100)
		while(Amount>0&&!usr.KOd)
			Amount-=1
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.icon=icon
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=2.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*1.15
			if(prob(Experience/100)) A.Explosive=1
			A.dir=usr.dir
			A.pixel_x+=rand(-16,16)
			A.HeatSeeking=1
			A.pixel_y+=rand(-16,16)
			if(prob(30)) A.loc=get_step(usr,turn(usr.dir,45))
			else if(prob(30)) A.loc=get_step(usr,turn(usr.dir,45))
			else A.loc=usr.loc
			if(A)
				walk(A,usr.dir,1)
				spawn(5) if(A&&prob(50)) step(A,pick(A.dir+90,A.dir-90))
				spawn(10) if(A&&prob(50)) step(A,pick(A.dir+90,A.dir-90))
			spawn(15) if(A) del(A)
			sleep(1)
		usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

