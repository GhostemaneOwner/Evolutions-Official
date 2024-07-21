

Skill/Attacks/Shockwave
	Experience=1
	Tier=1
	icon='Shockwave.dmi'
	desc="You send out a blast of air that is designed to knockback your opponent. The attack does a small amount of damage and has a small range, but will send your opponent flying."
	verb/Shockwave()
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
		var/Delay = usr.Refire / 15
		Delay += 50 / Experience
		spawn(Delay) usr.attacking=0
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
//		hearers(6,usr) << pick('Blast1.wav','Blast2.wav')



		var/obj/ranged/Blast/B=unpool("Blasts")
		B.Belongs_To=usr
		B.name=src.name
		flick(usr,"Blast")
		B.pixel_x=pixel_x
		B.pixel_y=pixel_y
		B.pixel_x+=rand(-6,6)
		B.pixel_y+=rand(-6,6)
		B.icon=icon
		B.Damage=0.15*usr.BP*usr.Pow*Ki_Power  //200
		B.Power=(usr.BP)*Ki_Power
		B.Offense=usr.Off*2
		B.Shockwave=3
		B.Stagger=1
		B.dir=usr.dir
		B.Radius=1
		B.loc=get_step(usr,turn(usr.dir,45))

		var/obj/ranged/Blast/C=unpool("Blasts")
		C.Belongs_To=usr
		C.name=src.name
		flick(usr,"Blast")
		C.pixel_x=pixel_x
		C.pixel_y=pixel_y
		C.pixel_x+=rand(-6,6)
		C.pixel_y+=rand(-6,6)
		C.icon=icon
		C.Damage=0.15*usr.BP*usr.Pow*Ki_Power  //200
		C.Power=(usr.BP)*Ki_Power
		C.Offense=usr.Off*2
		C.Shockwave=3
		C.Stagger=1
		//C.Piercer=1
		C.dir=usr.dir
		C.loc=get_step(usr,turn(usr.dir,-45))

		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		flick(usr,"Blast")
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.pixel_x+=rand(-6,6)
		A.pixel_y+=rand(-6,6)
		A.icon=icon
		A.Damage=0.15*usr.BP*usr.Pow*Ki_Power  //200
		A.Power=(usr.BP)*Ki_Power
		A.Offense=usr.Off*2
		A.Shockwave=3
		A.Stagger=1
		//A.Piercer=1
		A.dir=usr.dir
		A.loc=usr.loc
		A.name=src.name
		B.name=src.name
		C.name=src.name

		walk(A,A.dir)
		walk(B,B.dir)
		walk(C,C.dir)
		spawn(20)
			del(C)
			del(B)
			del(A)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
		