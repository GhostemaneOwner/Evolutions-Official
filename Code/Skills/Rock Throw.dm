



Skill/Attacks/RockThrow
	Tier=1
	Experience=1
	var/Spread=0
	icon='bouldertest2.dmi'
	pixel_x=-16
	pixel_y=-16
	desc="You throw a rock at your opponent and deal damage with your strength."
	verb/Ki_Settings()
		set category="Other"
		switch(input("Do you want your Rock Throws to be similar to blast and have lower damage but no cooldown?") in list("Yes","No"))
			if("Yes") Spread=1
			if("No") Spread=0
	verb/Rock_Throw()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<45) return
		if(!usr.CanAttack(45,src)) return
		if(!Spread)
			CDTick(usr)
			usr.DrainKi(src, 1, 50,show=1)//usr.DrainKi(src,"Percent",4)//usr.Ki=max(0,usr.Ki-75)
			usr.attacking=3
			usr.Bandages()
			spawn(usr.Refire) usr.attacking=0
			if(Experience<100) Experience+=rand(4,9)
			if(Experience>100) Experience=100
//			hearers(6,usr) << pick('Blast1.wav','Blast2.wav')
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			flick(usr,"Blast")
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-6,6)
			A.pixel_y+=rand(-6,6)
			A.icon=icon
			A.Damage=3.8*usr.BP*usr.Str*Ki_Power  //200
			A.Power=(usr.BP)*Ki_Power
			A.Offense=usr.Off
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			walk(A,A.dir)
			spawn(6) del(A)
		else
			usr.DrainKi(src, 1, 20,show=1)//usr.DrainKi(src,"Percent",1.6)//usr.Ki=max(0,usr.Ki-75)
			usr.attacking=3
			usr.Bandages()
			var/Delay = usr.Refire / 14
			Delay += 70 / Experience
			spawn(Delay) usr.attacking=0
			if(Experience<100) Experience+=rand(4,9)
			if(Experience>100) Experience=100
//			hearers(6,usr) << pick('Blast1.wav','Blast2.wav')
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			flick(usr,"Blast")
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-6,6)
			A.pixel_y+=rand(-6,6)
			A.icon=icon
			A.Damage=0.3*usr.BP*usr.Str*Ki_Power  //200
			A.Power=(usr.BP)*Ki_Power
			A.Offense=usr.Off
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			var/obj/ranged/Blast/B=unpool("Blasts")
			B.Belongs_To=usr
			B.name=src.name
			flick(usr,"Blast")
			B.pixel_x=pixel_x
			B.pixel_y=pixel_y
			B.pixel_x+=rand(-6,6)
			B.pixel_y+=rand(-6,6)
			B.icon=icon
			B.Damage=0.3*usr.BP*usr.Str*Ki_Power  //200
			B.Power=(usr.BP)*Ki_Power
			B.Offense=usr.Off
			B.Shockwave=1
			B.dir=usr.dir
			B.loc=get_step(usr,turn(usr.dir,-45))
			var/obj/ranged/Blast/C=unpool("Blasts")
			C.Belongs_To=usr
			C.name=src.name
			flick(usr,"Blast")
			C.pixel_x=pixel_x
			C.pixel_y=pixel_y
			C.pixel_x+=rand(-6,6)
			C.pixel_y+=rand(-6,6)
			C.icon=icon
			C.Damage=0.3*usr.BP*usr.Str*Ki_Power  //200
			C.Power=(usr.BP)*Ki_Power
			C.Offense=usr.Off
			C.Shockwave=1
			C.dir=usr.dir
			C.loc=get_step(usr,turn(usr.dir,45))
			walk(B,B.dir)
			walk(C,C.dir)
			spawn(7)
				del(B)
				del(C)
			walk(A,A.dir)
			spawn(6) del(A)

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")

Skill/Attacks/RockSlide
	UB1="High Tension"
	Tier=2
	Experience=1
	icon='bouldertest2.dmi'
	pixel_x=-16
	pixel_y=-16
	desc="You throw lots of rocks at your opponent and deal damage with your strength. Each projectile is slightly weaker than Rock Throw."
	verb/Rock_Slide()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<175) return
		if(!usr.CanAttack(200,src)) return
		CDTick(usr)
		usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi(src,"Percent",15)//usr.Ki=max(0,usr.Ki-200)
		usr.attacking=3
		usr.Bandages()
		spawn(usr.Refire) usr.attacking=0
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
//		hearers(6,usr) << pick('Blast1.wav','Blast2.wav')
		var/amount=7+round(Experience/10)
		if(amount>15)amount=15
		var/nextdir=0
		while(amount)
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			flick(usr,"Blast")
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-6,6)
			A.pixel_y+=rand(-6,6)
			A.icon=icon
			A.name=src.name
			A.Damage=2*usr.BP*usr.Str*Ki_Power  //200
			A.Power=(usr.BP)*Ki_Power
			A.Offense=usr.Off*1.1
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			//walk(A,A.dir)
			nextdir++
			if(nextdir>5)nextdir=1
			switch(nextdir)
				if(5)
					if(A) step(A,turn(A.dir,45))
					if(A) step(A,A.dir)
					if(A) walk(A,usr.dir)
				if(4)
					if(A) step(A,turn(A.dir,-45))
					if(A) step(A,A.dir)
					if(A) walk(A,usr.dir)
				if(3)
					if(A) step(A,turn(A.dir,pick(-45,45)))
					if(A) walk(A,usr.dir)
				if(2)
					if(A) step(A,turn(A.dir,pick(-45,45)))
					if(A) walk(A,usr.dir)
				if(1) walk(A,A.dir)
			amount-=1
			sleep(1)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")



Skill/Attacks/RockTomb
	UB1="High Tension"
	Tier=3
	Experience=1
	var/Master=0
	icon='Meteor.dmi'
	pixel_x=-15
	pixel_y=-15
	desc="You throw a rock at your opponent and deal damage with your strength. When masterd this rock explodes!"
	verb/Rock_Tomb()
		set category="Skills"
		if(Master==0)
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking||usr.Ki<125) return
			if(!usr.CanAttack(125,src)) return
			CDTick(usr)
			usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-125)
			usr.attacking=3
			usr.Bandages()
			spawn(usr.Refire) usr.attacking=0
			if(Experience<100) Experience+=rand(4,9)
			if(Experience>100) Experience=100
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			flick(usr,"Blast")
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-6,6)
			A.pixel_y+=rand(-6,6)
			A.icon=icon
			A.name=src.name
			A.Damage=9*usr.BP*usr.Str*Ki_Power  //200
			A.Power=(usr.BP)*Ki_Power
			A.Offense=usr.Off
			animate(A, transform = matrix()*2, time=3)
			A.Radius=1
			A.Explosive=2
			A.Shrapnel=1
			A.Shockwave=1
			A.dir=usr.dir
			A.loc=usr.loc
			walk(A,A.dir)
			spawn(12) del(A)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")



