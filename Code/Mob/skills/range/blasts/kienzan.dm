Skill/Attacks/DestructoDisc
//	Fatal=1
	Tier=2
	Experience=10
	NoMove=1
	icon='Blast - Destructo Disk.dmi'
	desc="This attack is much like Charge at its core with some differences. Destructo_Disc takes longer to charge, is completely undeflectable, has a higher velocity, it is slightly more powerful than Charge, it also drains much more energy to use."
	UB1="Channel"
	verb/Destructo_Disc()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<80) return
		if(!usr.CanAttack(80,src)) return
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
		CDTick(usr)
		//usr.DrainKi(src,"Percent",8)//usr.Ki=max(0,usr.Ki-160)
		usr.DrainKi(src, 1, 80,show=1)
		usr.attacking=3
		charging=1
		var/image/O=image(icon=icon,pixel_y=24)
		usr.overlays+=O
//		hearers(6,usr) << 'Destructo_Disc_Charge.wav'
		var/Delay = usr.Refire
		Delay += 300 / Experience
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen)
			usr.attacking=0
			charging=0
			return
		usr.overlays-=O
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		flick(usr,"Blast")
		A.Deflectable=0
		A.icon=icon
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=6.5*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
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
