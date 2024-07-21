

Skill/Attacks/Blaster_Meteor
	UB1="Channel"
	UB2="War"
	icon='17.dmi'
	desc="This attack fires off several homing blasts that track towards your target and cause shrapnel."
	var/Setting=4
	Experience=10
	Tier=4
	NoMove=1
	verb/Ki_Settings()
		set category="Other"
		Setting=input("Input the amount of blasts you want created when you use this attack. Default is [initial(Setting)]. You can fire [round(Experience/10)] max") as num
		if(Setting<2) Setting=2
		if(Setting>Experience/10) Setting=round(Experience/10)
		if(Setting>10)Setting=10
	verb/Blaster_Meteor()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<25*Setting) return
		if(!usr.CanAttack(25*Setting,src)) return
		var/mob/B
		if(usr.Target) B =usr.Target
		else
			usr<<"This requires a target."
			return
		CDTick(usr)
		usr.attacking=3
		if(Experience<100) Experience+=rand(4,11)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",2.5*Setting)
		usr.DrainKi(src, 1, 25*Setting,show=1)
		var/amount=Setting
		usr.overlays+='Shield, Legendary.dmi'
		while(usr&&B)
			if(!amount||usr.KOd||(B.z!=usr.z)) break
			sleep(1)
			for(var/i=0, i<10, i++)
				if(!amount) break
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
				A.icon=icon
				A.Shrapnel=1
				A.loc = usr.loc
				A.dir=usr.dir-45
				while(prob(10*(Experience/20))) A.Explosive++
				var/MaskDamage=0
				if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
					MaskDamage=MM.Health
					MM.DurabilityCheck(usr)
					break
				if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
				A.Damage=(usr.BP+MaskDamage)*usr.Pow*3.3*Ki_Power
				A.Power=(usr.BP+MaskDamage)*Ki_Power
				A.Offense=usr.Off
				spawn(rand(1,2))
					if(A)
						A.density=1
						if(A&&B) walk_towards(A,B)
				sleep(2)
		usr.attacking=0
		usr.overlays-='Shield, Legendary.dmi'
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

