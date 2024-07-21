


Skill/Melee/PressurePunch
	Tier=2
	UB2="High Tension"
	UB1="Fists of Fury"
	Experience=1
	icon='Shockwave.dmi'
	desc="You strike the air in front of you with an open palm and send a burst of air at your opponent. The attack does a small amount of damage and has a small range, but will stun them for a moment."
	verb/Pressure_Punch()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<100) return
		if(!usr.CanAttack(100,src)) return
		CDTick(usr)


		usr.DrainKi(src, 1, 100,show=1)//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-100)
		usr.attacking=3
		usr.Bandages()
		var/Delay = usr.Refire / 15
		Delay += 150 / Experience
		spawn(Delay) usr.attacking=0
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
//		hearers(6,usr) << pick('Blast1.wav','Blast2.wav')
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		flick(usr,"Blast")
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-6,6)
		A.pixel_y+=rand(-6,6)
		A.icon=icon
		A.Damage=0.2*usr.BP*usr.Str*Ki_Power  //200
		A.Power=(usr.BP)*Ki_Power
		A.Offense=usr.Off*1.5
		A.Paralysis=1+round(Experience/50)

		A.dir=usr.dir
		A.loc=usr.loc
		walk(A,A.dir)
		spawn(6) del(A)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")


