Skill/Attacks/Genocide
	UB1="Death"
	UB2="Fungal Plague"
	Tier=4
	NoMove=0
	Experience=100
	icon='18.dmi'
	var/Charges=20
	desc="This attack lasts for 20 blasts.  Turning it on will cause you to start firing blasts towards your selected target until you run out of charges. These blasts will home."
	verb/Genocide()
		set category="Skills"
		if(usr.RPMode) return
		if(!usr.CanAttack(15,src)) return
		if(!charging)
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<10) return
			var/mob/Targ=usr.Target
			if(!usr.Target)
				return
			CDTick(usr)
			if(Targ.z==usr.z)
				charging=1
				usr.overlays+='SBombGivePower.dmi'
				usr.attacking=4
				Charges=20
				for(var/mob/M in range(20,usr))
					M.CombatOut("[usr] begins to charge a [src]!")
				sleep(150/usr.Refire)
				while(charging&&usr.KOd==0&&usr.Ki>15&&Targ&&Charges)
					Charges--
					var/obj/ranged/Blast/A=unpool("Blasts")
					A.Belongs_To=usr
					A.name=src.name
					A.pixel_x=pixel_x
					A.pixel_y=pixel_y
					A.pixel_x+=rand(-16,16)
					A.pixel_y+=rand(-16,16)
					A.icon=icon
					var/MaskDamage=0
					if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
						MaskDamage=MM.Health
						MM.DurabilityCheck(usr)
						break
					if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
					A.Damage=5*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
					A.Power=(usr.BP+MaskDamage)*Ki_Power
					A.HeatSeeking=1
					A.Offense=usr.Off*1.1
					A.loc=usr.loc
					A.dir=NORTH
					walk(A,get_dir(src,Targ),1)
					//usr.DrainKi(src,"Percent",1.5)//usr.Ki=max(0,usr.Ki-5)
					usr.DrainKi(src, 1, 50,show=1)
					sleep(rand(2,8))
				usr.overlays-='SBombGivePower.dmi'
				usr.attacking=0
				charging=0
		else charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
		