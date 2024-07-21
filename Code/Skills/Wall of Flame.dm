





Skill/Attacks/WallofFlame
	UB1="War"
	UB2="Kaioken"
	Experience=1
	Tier=5
	icon='a fire blast.dmi'
	desc="Creates 3 to 9 tiles, based on experience, of flame in front of you. These tiles will last for 30 seconds and damage and stun anyone that bumps them."
	verb/Wall_of_Flame()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking) return
		if(usr.Ki<300)
			usr << "You do not have the energy to use this technique!"
			return
		if(!usr.CanAttack(300,src)) return
		CDTick(usr)
		if(Experience<100) Experience+=rand(6,12)
		if(Experience>100) Experience=100
		usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-300)
		usr.attacking=3
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.5
		Delay +=  50 / Experience
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		usr.attacking=0
		usr.overlays-=ChargeOver
		var/Amount=1+max(2,round(Experience/12.5))
		while(Amount)
			Amount-=1
			var/obj/ranged/Blast/A=unpool("Blasts")
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
			A.Damage=5.5*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*1.2
			A.dir=usr.dir
			if(Amount<=2) A.loc=get_step(usr,usr.GetCleave(usr.dir,Amount))
			else if(Amount<=5)A.loc=get_step(get_step(get_step(get_step(usr,turn(usr.dir,-90)),turn(usr.dir,-90)),turn(usr.dir,-90)),usr.GetCleave(usr.dir,Amount-3))
			else if(Amount<=8)A.loc=get_step(get_step(get_step(get_step(usr,turn(usr.dir,90)),turn(usr.dir,90)),turn(usr.dir,90)),usr.GetCleave(usr.dir,Amount-6))
			A.Paralysis=6
			A.density=0
			spawn() while(A)
				A.density=0
				for(var/mob/M in view(0,A))
					if(M!=A.Belongs_To)
						A.density=1
						A.Bump(M)
				sleep(2)
			spawn(250) if(A) del(A)
			sleep(-1)
		usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")







