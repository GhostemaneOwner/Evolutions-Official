Skill/Attacks/Barrage
//	Fatal=0
	UB1="Channel"
//	UB2=
	Tier=2
	Experience=1
	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops, and shoots in multiple directions easily. Fires seven volleys before going on CD."
	verb/Ki_Settings()
		set category="Other"
		switch(input("Do you want your blasts to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Barrage()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<1) return
		if(!usr.CanAttack(15+Shockwave*5,src)) return
		if(Experience<100) Experience+=rand(2,6)
		if(Experience>100) Experience=100
		//usr.Ki=max(0,usr.Ki-25+Shockwave*5)
		CDTick(usr)

		usr.attacking=3
		var/Delay = usr.Refire / 15
		Delay += 1
		var/Charges=7//number of volleys fired
		var/MaskDamage=0
		var/MaxSwordPercent=100

		if(usr.HasWeaponizedKi)
			for(var/obj/items/Sword/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Hammer/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			for(var/obj/items/Gauntlets/S in usr) if(S.suffix&&S.Durability>0)
				MaskDamage=S.Health
				MaxSwordPercent=S.MaxBPAdd
				S.DurabilityCheck(usr)
				break
			if(usr.BoundWeaponOn) MaskDamage=usr.BP*(0.4+(usr.BoundWeaponOn*0.1))
			if(usr.KiBlade)
				if(usr.HasBladeOfLight) MaskDamage=usr.BP*0.4
				else MaskDamage=usr.BP*0.3
			if(usr.KiHammer)
				MaskDamage=usr.BP*0.6
			if(usr.SpiritSword)
				MaskDamage=usr.BP*0.7
			if(usr.KiFists) if(MaskDamage<=usr.BP*0.18)
				MaskDamage=usr.BP*0.18


			if(usr.MaskOn)
				for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
					MaskDamage=MM.Health
					MM.DurabilityCheck(usr)
					break
				if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			if(MaskDamage>(MaxSwordPercent/100)*usr.BP) MaskDamage=(MaxSwordPercent/100)*usr.BP

		while(usr.attacking==3&&usr.KOd==0&&usr.Ki>50&&Charges)

			Charges--

			//usr.DrainKi(src,"Percent",(15+(4.5+Shockwave*5))/10)
			usr.DrainKi(src, 1, 15+(Shockwave*5),show=1)
			var/obj/ranged/Blast/B=unpool("Blasts")
			B.Belongs_To=usr
			B.name=src.name
			B.pixel_x=pixel_x
			B.pixel_y=pixel_y
			B.pixel_x+=rand(-16,16)
			B.pixel_y+=rand(-16,16)
			B.icon=icon
			//B.HeatSeeking=1
			B.Damage=1.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			B.Power=(usr.BP+MaskDamage)*Ki_Power
			B.Offense=usr.Off
			if(prob(10)) B.Shockwave=Shockwave
			B.dir=usr.dir
			B.loc=get_step(usr,turn(usr.dir,45))
			var/obj/ranged/Blast/C=unpool("Blasts")
			C.Belongs_To=usr
			C.name=src.name
			C.pixel_x=pixel_x
			C.pixel_y=pixel_y
			C.pixel_x+=rand(-16,16)
			C.pixel_y+=rand(-16,16)
			C.icon=icon
			//C.HeatSeeking=1
			C.Damage=1.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			C.Power=(usr.BP+MaskDamage)*Ki_Power
			C.Offense=usr.Off
			if(prob(10)) C.Shockwave=Shockwave
			C.dir=usr.dir
			C.loc=get_step(usr,turn(usr.dir,-45))
			var/obj/ranged/Blast/D=unpool("Blasts")
			D.Belongs_To=usr
			D.name=src.name
			D.pixel_x=pixel_x
			D.pixel_y=pixel_y
			D.pixel_x+=rand(-16,16)
			D.pixel_y+=rand(-16,16)
			D.icon=icon
			//D.HeatSeeking=1
			D.Damage=1.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			D.Power=(usr.BP+MaskDamage)*Ki_Power
			D.Offense=usr.Off
			if(prob(10)) D.Shockwave=Shockwave
			D.dir=usr.dir
			D.loc=get_step(get_step(usr,turn(usr.dir,-45)),turn(usr.dir,-90))
			var/obj/ranged/Blast/E=unpool("Blasts")
			E.Belongs_To=usr
			E.name=src.name
			E.Belongs_To=usr
			E.pixel_x=pixel_x
			E.pixel_y=pixel_y
			E.pixel_x+=rand(-16,16)
			E.pixel_y+=rand(-16,16)
			E.icon=icon
			//E.HeatSeeking=1
			E.Damage=1.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			E.Power=(usr.BP+MaskDamage)*Ki_Power
			E.Offense=usr.Off
			if(prob(10)) D.Shockwave=Shockwave
			E.dir=usr.dir
			E.loc=get_step(get_step(usr,turn(usr.dir,45)),turn(usr.dir,90))
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			flick(usr,"Blast")
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-16,16)
			A.pixel_y+=rand(-16,16)
			A.icon=icon
			//A.HeatSeeking=1
			A.Damage=1.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off
			if(prob(10)) A.Shockwave=Shockwave
			A.dir=usr.dir
			A.loc=usr.loc
			if(usr.HasSmolder)
				A.CausesBurns=1
				B.CausesBurns=1
				C.CausesBurns=1
				D.CausesBurns=1
				E.CausesBurns=1
			walk(A,A.dir)
			walk(B,B.dir)
			walk(C,C.dir)
			walk(D,D.dir)
			walk(E,E.dir)
			sleep(Delay)
		spawn(Delay) usr.attacking=0


	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")



Skill/Attacks/Block_The_Sky
//	Fatal=0
	UB1="War"
	UB2="Fists of Fury"
	Tier=3
	Experience=1
	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops, and shoots arrows in multiple directions easily. Fires seven volleys before going on CD."
	verb/Ki_Settings()
		set category="Other"
		switch(input("Do you want your blasts to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Block_The_Sky()
		set category="Skills"
		if(usr.RPMode) return
		if(!usr.KiBow)
			usr<<"This requires Ki Bow."
			return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<1) return
		if(!usr.CanAttack(15+Shockwave*5,src)) return
		if(Experience<100) Experience+=rand(2,6)
		if(Experience>100) Experience=100
		//usr.Ki=max(0,usr.Ki-25+Shockwave*5)
		CDTick(usr)

		usr.attacking=3
		var/Delay = usr.Refire / 15
		Delay += 1
		var/Charges=7//number of volleys fired

		//t1 30% Strength and 80% Force
		//t2 40% Strength and 90% Force
		//t3 50% Strength and 100% Force

		while(usr.attacking==3&&usr.KOd==0&&usr.Ki>50&&Charges)

			Charges--
			//usr.DrainKi(src,"Percent",(15+(4.5+Shockwave*5))/10)
			usr.DrainKi(src, 1, 15+(Shockwave*5),show=1)

			var/obj/ranged/Blast/B=unpool("Blasts")
			flick("Blast",usr)
			B.Belongs_To=usr
			B.pixel_x=pixel_x
			B.pixel_y=pixel_y
			B.pixel_x+=rand(-16,16)
			B.pixel_y+=rand(-16,16)
			B.name="Ki Arrow [usr.KiBow]"
			B.icon='Quincy Arrow.dmi'
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			switch(usr.KiBow)
				if(1)
					B.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.8)+(usr.Str*0.3))*Ki_Power  //200
					B.Power=(usr.BP+MaskDamage)*Ki_Power
				if(2)
					B.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.9)+(usr.Str*0.4))*Ki_Power  //200
					B.Power=(usr.BP+MaskDamage)*Ki_Power
				if(3)
					B.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow)+(usr.Str*0.5))*Ki_Power  //200
					B.Power=(usr.BP+MaskDamage)*Ki_Power
			B.Offense=usr.Off
			if(prob(30)) B.Shockwave=Shockwave
			B.dir=usr.dir
			B.loc=get_step(usr,turn(usr.dir,45))

			var/obj/ranged/Blast/C=unpool("Blasts")
			flick("Blast",usr)
			C.Belongs_To=usr
			C.pixel_x=pixel_x
			C.pixel_y=pixel_y
			C.pixel_x+=rand(-16,16)
			C.pixel_y+=rand(-16,16)
			C.name="Ki Arrow [usr.KiBow]"
			C.icon='Quincy Arrow.dmi'
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			switch(usr.KiBow)
				if(1)
					C.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.8)+(usr.Str*0.3))*Ki_Power  //200
					C.Power=(usr.BP+MaskDamage)*Ki_Power
				if(2)
					C.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.9)+(usr.Str*0.4))*Ki_Power  //200
					C.Power=(usr.BP+MaskDamage)*Ki_Power
				if(3)
					C.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow)+(usr.Str*0.5))*Ki_Power  //200
					C.Power=(usr.BP+MaskDamage)*Ki_Power
			C.Offense=usr.Off
			if(prob(30)) C.Shockwave=Shockwave
			C.dir=usr.dir
			C.loc=get_step(usr,turn(usr.dir,-45))

			var/obj/ranged/Blast/D=unpool("Blasts")
			flick("Blast",usr)
			D.Belongs_To=usr
			D.pixel_x=pixel_x
			D.pixel_y=pixel_y
			D.pixel_x+=rand(-16,16)
			D.pixel_y+=rand(-16,16)
			D.name="Ki Arrow [usr.KiBow]"
			D.icon='Quincy Arrow.dmi'
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			switch(usr.KiBow)
				if(1)
					D.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.8)+(usr.Str*0.3))*Ki_Power  //200
					D.Power=(usr.BP+MaskDamage)*Ki_Power
				if(2)
					D.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.9)+(usr.Str*0.4))*Ki_Power  //200
					D.Power=(usr.BP+MaskDamage)*Ki_Power
				if(3)
					D.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow)+(usr.Str*0.5))*Ki_Power  //200
					D.Power=(usr.BP+MaskDamage)*Ki_Power
			D.Offense=usr.Off
			if(prob(30)) D.Shockwave=Shockwave
			D.dir=usr.dir
			D.loc=get_step(get_step(usr,turn(usr.dir,-45)),turn(usr.dir,-90))

			var/obj/ranged/Blast/E=unpool("Blasts")
			flick("Blast",usr)
			E.Belongs_To=usr
			E.pixel_x=pixel_x
			E.pixel_y=pixel_y
			E.pixel_x+=rand(-16,16)
			E.pixel_y+=rand(-16,16)
			E.name="Ki Arrow [usr.KiBow]"
			E.icon='Quincy Arrow.dmi'
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			switch(usr.KiBow)
				if(1)
					E.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.8)+(usr.Str*0.3))*Ki_Power  //200
					E.Power=(usr.BP+MaskDamage)*Ki_Power
				if(2)
					E.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow*0.9)+(usr.Str*0.4))*Ki_Power  //200
					E.Power=(usr.BP+MaskDamage)*Ki_Power
				if(3)
					E.Damage=1.5*(usr.BP+MaskDamage)*((usr.Pow)+(usr.Str*0.5))*Ki_Power  //200
					E.Power=(usr.BP+MaskDamage)*Ki_Power
			E.Offense=usr.Off
			if(prob(30)) E.Shockwave=Shockwave
			E.dir=usr.dir
			E.loc=get_step(get_step(usr,turn(usr.dir,45)),turn(usr.dir,90))

			var/obj/ranged/Blast/A=unpool("Blasts")
			flick("Blast",usr)
			A.Belongs_To=usr
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-16,16)
			A.pixel_y+=rand(-16,16)
			A.name="Ki Arrow [usr.KiBow]"
			A.icon='Quincy Arrow.dmi'
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
			A.Offense=usr.Off
			if(prob(30)) A.Shockwave=Shockwave
			A.dir=usr.dir
			A.loc=usr.loc


			if(usr.HasSmolder)
				A.CausesBurns=1
				B.CausesBurns=1
				C.CausesBurns=1
				D.CausesBurns=1
				E.CausesBurns=1
				A.icon='Arrow Charge.dmi'
				B.icon='Arrow Charge.dmi'
				C.icon='Arrow Charge.dmi'
				D.icon='Arrow Charge.dmi'
				E.icon='Arrow Charge.dmi'

			if(usr.CriticalEdge&&prob(50))
				A.icon='Quincy Arrow 2.dmi'
				if(A.CausesBurns) A.icon='Arrow Barrage.dmi'
				A.Damage*=1.33
				B.icon='Quincy Arrow 2.dmi'
				if(B.CausesBurns) B.icon='Arrow Barrage.dmi'
				B.Damage*=1.33
				C.icon='Quincy Arrow 2.dmi'
				if(C.CausesBurns) C.icon='Arrow Barrage.dmi'
				C.Damage*=1.33
				D.icon='Quincy Arrow 2.dmi'
				if(D.CausesBurns) D.icon='Arrow Barrage.dmi'
				D.Damage*=1.33
				E.icon='Quincy Arrow 2.dmi'
				if(E.CausesBurns) E.icon='Arrow Barrage.dmi'
				E.Damage*=1.33


			walk(A,A.dir)
			walk(B,B.dir)
			walk(C,C.dir)
			walk(D,D.dir)
			walk(E,E.dir)


			sleep(Delay)
		spawn(Delay) usr.attacking=0


	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

