Skill/Attacks/TriBeam
//	Fatal=1
	UB1="Channel"
	UB2="Fungal Plague"
	Tier=4
	Experience=10
	icon='16.dmi'
	desc="This is a very high power blast attack with a short delay that is explosive and is three tiles, but causes damage to the user."
	verb/Kikoho()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<60) return
		if(!usr.CanAttack(60)) return
		if(Experience<100) Experience+=rand(2,5)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-60)
		usr.DrainKi(src, 1, 75,show=1)
		usr.TakeDamage(usr, (rand(10,15)-round(Experience/50)), "Firing TriBeam")
		usr.Injure_Hurt(rand(10,15)-round(Experience/50),"Random",src)
		usr.attacking=3
		charging=1
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*0.2
		Delay += 50 / Experience
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
		A.density=1
		A.Radius=1
		A.name=src.name
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.loc=usr.loc
		A.dir=usr.dir
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=10*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
		A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Explosive=1
		A.Offense=usr.Off*1.2
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
		spawn(100) if(usr.Health<0&&prob(15)) usr.Death(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
