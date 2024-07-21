


Skill/Attacks/KillDriver
	UB1="Death"
	UB2="War"
	Tier=4
	Experience=1
	pixel_x=-15
	pixel_y=-15
	icon='Kill_Driver_21.dmi'
	desc="A blast that homes towards your target and stuns then as well as applying 5 ticks of stagger."
	verb/Kill_Driver()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<100) return
		if(!usr.CanAttack(100,src)) return
		CDTick(usr)
		//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-100)
		usr.DrainKi(src, 1, 100,show=1)
		usr.attacking=3
		usr.Bandages()
		var/Delay = 30 / Experience
		spawn(Delay) usr.attacking=0
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		flick(usr,"Blast")
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-6,6)
		A.pixel_y+=rand(-6,6)
		A.icon=icon
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=7.5*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
		A.Power=(usr.BP)*Ki_Power
		A.Offense=usr.Off*1.75
		A.Stagger=5
		A.HeatSeeking=1
		A.Paralysis=5
		A.dir=usr.dir
		A.loc=usr.loc
		walk(A,A.dir)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")


Skill/Attacks/IceArrow
	UB1="War"
	UB2="Arcane Power"
	Tier=4
	Experience=1
	icon='Kill_Driver_21.dmi'
	desc="An arrow show that homes towards your target and applies a slow with a chance for a 1 tick stun. Short Range."
	verb/Ice_Arrow()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<100) return
		if(!usr.CanAttack(100,src)) return
		if(!usr.KiBow)
			usr<<"This requires Ki Bow."
			return
		CDTick(usr)
		//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-100)
		usr.DrainKi(src, 1, 100,show=1)
		usr.attacking=3
		usr.Bandages()
		var/Delay = 30 / Experience
		spawn(Delay) usr.attacking=0
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100


		var/obj/ranged/Blast/A=unpool("Blasts")
		flick("Blast",usr)
		A.Belongs_To=usr
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-16,16)
		A.pixel_y+=rand(-16,16)
		A.name="Ice Arrow [usr.KiBow]"
		A.icon='Ice Arrow.dmi'
		var/MaskDamage
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		switch(usr.KiBow)
			if(1)
				A.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.8)+(usr.Str*0.3))*Ki_Power  //200
				A.Power=(usr.BP+MaskDamage)*Ki_Power
			if(2)
				A.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.9)+(usr.Str*0.4))*Ki_Power  //200
				A.Power=(usr.BP+MaskDamage)*Ki_Power
			if(3)
				A.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow)+(usr.Str*0.5))*Ki_Power  //200
				A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off*1.33
		if(prob(30)) A.Paralysis=1
		A.HeatSeeking=1
		A.Slowing=30
		A.loc=usr.loc
		walk(A,A.dir)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")




