var/list/DragonBalls = new

obj/Dragons
	layer=MOB_LAYER+1
	Health=1.#INF
	Grabbable=0
	density = 0
	var
		Wishes
		WishPower
		Creator
	Shenron
		icon = 'DSShenron.dmi'
		icon_state = "Animated"
		pixel_x = -190
		pixel_y = 16
	Porunga
		icon = 'DSPorunga.dmi'
		icon_state = "Animated"
		pixel_x = -160
		pixel_y = 32

	verb/Wish()
		set category="Other"
		set src in oview(1)
		if(usr.RPMode) return
		var/list/Choices=new
		Choices+="Power For Someone"
		if(WishPower>2000) Choices+="Immortality"
		if(WishPower>2000) Choices+="Revive"
		if(!Earth|!Namek|!Vegeta|!Arconia|!Ice)
			if(WishPower>10000) Choices+="Restore Planet"
			if(WishPower>70000) Choices+="Restore Galaxy"
		Choices+="Nothing"
		while(Wishes > 0)
			Wishes-=1
			view(src)<<"[usr] is making a wish!"
			switch(input("What is your wish?") in Choices)
				if("Nothing")
					if(Wishes<0) return
					view(usr)<<"[usr] cancelled their wish"
					Wishes++
					return
				if("Restore Planet")
					if(Wishes<0) return
					var/list/Planets=new
					if(!Earth) Planets+="Earth"
					if(!Namek) Planets+="Namek"
					if(!Vegeta) Planets+="Vegeta"
					if(!Arconia) Planets+="Arconia"
					if(!Ice) Planets+="Ice"
					if(!Planets)
						view(usr)<<"There are no planets destroyed, please make another wish."
						return
					switch(input("Which planet?") in Planets)
						if("Earth")
							spawn Planet_Restore(1)
							view(usr)<<"[usr] wishes to restore Earth!"
							logAndAlertAdmins("[key_name(usr)] has wished to restore Earth with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Earth with the Magic Balls.\n")
						if("Namek")
							spawn Planet_Restore(2)
							view(usr)<<"[usr] wishes to restore Namek!"
							logAndAlertAdmins("[key_name(usr)] has wished to restore Namek with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Namek with the Magic Balls.\n")
						if("Vegeta")
							spawn Planet_Restore(3)
							view(usr)<<"[usr] wishes to restore Vegeta!"
							logAndAlertAdmins("[key_name(usr)] has wished to restore Vegeta with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Vegeta with the Magic Balls.\n")
						if("Ice")
							spawn Planet_Restore(4)
							view(usr)<<"[usr] wishes to restore Icer!"
							logAndAlertAdmins("[key_name(usr)] has wished to restore Icer with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Icer with the Magic Balls.\n")
						if("Arconia")
							spawn Planet_Restore(5)
							view(usr)<<"[usr] wishes to restore Arconia!"
							logAndAlertAdmins("[key_name(usr)] has wished to restore Arconia with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored planet Arconia with the Magic Balls.\n")
				if("Restore Galaxy")
					if(Wishes<0) return
					spawn if(src)
						if(!Earth) Planet_Restore(1)
						if(!Namek) Planet_Restore(2)
						if(!Vegeta) Planet_Restore(3)
						if(!Ice) Planet_Restore(4)
						if(!Arconia) Planet_Restore(5)
					view(usr)<<"[usr] wishes for the Galaxy to be restored"
					logAndAlertAdmins("[key_name(usr)] has wished to restore the Galaxy with the Magic Balls")
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] restored the Galaxy with the Magic Balls.\n")
				if("Power For Someone")
					if(Wishes<0) return
					var/mob/A=input(usr,"Choose the person you want to give power to") in Players
					if(!A.PotentialUnlocked)
						A.PotentialUnlocked = 4
						A.BPMod *= 1.05
						A.Base *= 1.2
					else usr<<"It cannot be done."
					view(usr) << "[usr] wishes to give [A] more power!"
					logAndAlertAdmins("[key_name(usr)] has wished to give [key_name(A)] more power with the Magic Balls")
					usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has wished to give [key_name(A)] more power with the Magic Balls.\n")
				if("Immortality")
					if(Wishes<0) return
					if(!usr.Immortal)
						usr.Immortal=1
						usr.Regenerate+=1
						view(usr)<<"[usr] wishes for immortality!"
						logAndAlertAdmins("[key_name(usr)] has wished for immortality with the Magic Balls")
						usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has wished for immortality with the Magic Balls.\n")
					else
						usr.Immortal=0
						usr.Regenerate-=1
						view(usr)<<"[usr] wishes to be mortal!"
						logAndAlertAdmins("[key_name(usr)] has wished to be mortal with the Magic Balls")
						usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has wished to be mortal with the Magic Balls.\n")
				if("Revive")
					if(Wishes<0) return
					var/Revives=round(WishPower/500)
					while(Revives)
						var/list/Peoples=new
						for(var/mob/player/A in Players) if(A.Dead) Peoples+=A
						Peoples+="I'm Done Reviving"
						var/mob/B=input("Choose who to revive. You can revive [Revives] more people.") in Peoples
						if(B=="I'm Done Reviving") break
						else
							logAndAlertAdmins("[key_name(usr)] has revived [key_name(B)] with the Magic Balls")
							usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has revived [key_name(B)] with the Magic Balls.\n")
							B.Revive()
							B.loc=usr.loc
							Revives-=1
		for(var/obj/Magic_Ball/A in world)
			if(A.Creator==Creator)
				A.NegativeEnergy += 10
				A.Scatter()
				A.Inert()
		view(src)<<"The Magic Balls scatter randomly across their home world"
		logAndAlertAdmins("The Magic Balls scatter after granting [key_name(usr)]'s wish")
		usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | The Magic Balls scatter after granting [key_name(usr)]'s wish.\n")
		if(usr.z == 2)
			for(var/obj/Dragons/Porunga/S in world) if(S.Creator==Creator) del(S)
		else
			for(var/obj/Dragons/Shenron/S in world) if(S.Creator==Creator) del(S)

Skill/Support/Make_Magic_Balls
	Experience=100
	desc="Scatter will allow you to automatically scatter any Magic balls in your inventory across \
	the planet you are on. Magic Balls command will create any missing Magic Balls from your set \
	and update all existing Magic Balls to your current wishing power."
	verb/Scatter_Balls()
		set category="Other"
		if(usr.RPMode) return
		for(var/obj/Magic_Ball/A in view(usr)) spawn A.Scatter()
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] scattered the magic balls on z[usr.z]")
		logAndAlertAdmins("[key_name(usr)] scattered the magic balls on z[usr.z]")
	verb/Magic_Balls()
		set category="Other"
		if(usr.RPMode) return
		var/DB1
		var/DB2
		var/DB3
		var/DB4
		var/DB5
		var/DB6
		var/DB7
		for(var/obj/Magic_Ball/A in DragonBalls) if(A.Creator==usr.key)
			if(A.name=="Earth Orb") DB1=1
			if(A.name=="Namek Orb") DB2=1
			if(A.name=="Vegeta Orb") DB3=1
			if(A.name=="Icer Orb") DB4=1
			if(A.name=="Arconia Orb") DB5=1
			if(A.name=="Alien Orb") DB6=1
			if(A.name=="Afterlife Orb") DB7=1
		if(!DB1)
			var/obj/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Earth Orb"
			A.BallNumber=1
			A.Creator=usr.key
			A.BallsAreInert=0
			DragonBalls+=A
		if(!DB2)
			var/obj/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Namek Orb"
			A.BallNumber=2
			A.Creator=usr.key
			A.BallsAreInert=0
			DragonBalls+=A
		if(!DB3)
			var/obj/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Vegeta Orb"
			A.BallNumber=3
			A.Creator=usr.key
			A.BallsAreInert=0
			DragonBalls+=A
		if(!DB4)
			var/obj/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Icer Orb"
			A.BallNumber=4
			A.Creator=usr.key
			A.BallsAreInert=0
			DragonBalls+=A
		if(!DB5)
			var/obj/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Arconia Orb"
			A.BallNumber=5
			A.Creator=usr.key
			A.BallsAreInert=0
			DragonBalls+=A
		if(!DB6)
			var/obj/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Alien Orb"
			A.BallNumber=6
			A.Creator=usr.key
			DragonBalls+=A
			A.BallsAreInert=0
		if(!DB7)
			var/obj/Magic_Ball/A=new(locate(usr.x,usr.y,usr.z))
			A.name="Afterlife Orb"
			A.BallNumber=7
			A.Creator=usr.key
			DragonBalls+=A
			A.BallsAreInert=0
		var/DB_Icon
		for(var/obj/Magic_Ball/A in DragonBalls) if(A.Creator==usr.key)
			if(A.icon!=initial(A.icon)) DB_Icon=A.icon
			if(DB_Icon) A.icon=DB_Icon
			A.WishPower=usr.MaxKi/usr.KiMod
			spawn A.Inert()

obj/Magic_Ball
	icon='New DBalls.dmi'
	desc="An orb resembling a planet, or a marble.  You feel a strange energy coming from it."
	Health=1.#INF
	Savable=1

	var/Creator
	var/BallNumber
	var/BallsAreInert=1
	var/WishPower=0
	var/Wishes
	var/NegativeEnergy=0 //the start

	New()
		..()
		if(!BallsAreInert) spawn(10) Active()

	Del()
		DragonBalls-=src
		..()
	proc/Scatter()
		overlays+='Dragon Ball Aura.dmi'
		walk_rand(src)
//		spawn(100) z=Home
		spawn(3000)
			walk(src,0)
			overlays-='Dragon Ball Aura.dmi'
	proc/Inert()
		Grabbable=1
		icon_state=null
		BallsAreInert=1
		alpha = 0
		spawn(100000) Active()
	proc/Active()
		Wishes=1+(round(WishPower/10000))
		Wishes = min(Wishes,1)
		overlays-='Dragon Ball Aura.dmi'
		alpha = 255
		if(BallNumber==1)
			name="Earth Orb"
			icon_state="1"
			pixel_x=0
			pixel_y=0
		if(BallNumber==2)
			name="Namek Orb"
			icon_state="2"
			pixel_x=-16
			pixel_y=0
		if(BallNumber==3)
			name="Vegeta Orb"
			icon_state="3"
			pixel_x=16
			pixel_y=0
		if(BallNumber==4)
			name="Icer Orb"
			icon_state="4"
			pixel_x=-8
			pixel_y=16
		if(BallNumber==5)
			name="Arconia Orb"
			icon_state="5"
			pixel_x=8
			pixel_y=16
		if(BallNumber==6)
			name="Alien Orb"
			icon_state="6"
			pixel_x=-8
			pixel_y=-16
		if(BallNumber==7)
			name="Afterlife Orb"
			icon_state="7"
			pixel_x=8
			pixel_y=-16
	verb/SummonEDragon()
		set name = "Summon Dragon"
		set category="Other"
		set src in oview(1)
		var/Magic_Balls=0
		if(BallsAreInert)
			usr<<"THE ORBS ARE INERT!"
			return
		if(usr.RPMode) return
		for(var/obj/Magic_Ball/A in range(0,src)) if(A.Creator==Creator) Magic_Balls++
		if(Magic_Balls<7)
			usr<<"All 7 Planetary Orbs are not gathered here."
			return
		if(!icon_state)
			usr<<"THE ORBS ARE INERT!"
			return
		var/Dragon=0
		for(var/obj/Dragons/S in view(src)) if(S) Dragon++
		if(!Dragon)
			var/where
			switch(usr.z)
				if(1)where="Earth"
				if(2)where="Namek"
				if(3)where="Vegeta"
				if(4)where="Icer"
				if(5)where="Arconia"
				if(6)where="Dark Planet"
				if(7)where="Space Station"
				if(14)where="Alien Planet"
				if(8||10||11)where="Afterlife"
			if(where=="Namek")
				var/obj/Dragons/D = new /obj/Dragons/Porunga
				D.Wishes = src.Wishes
				D.WishPower = src.WishPower
				D.Creator = src.Creator
				D.loc=src.loc
			else
				var/obj/Dragons/D = new /obj/Dragons/Shenron
				D.Wishes = src.Wishes
				D.WishPower = src.WishPower
				D.Creator = src.Creator
				D.loc=src.loc
			for(var/mob/player/M in range(0,src))
				if(isobj(M.GrabbedMob))
					view()<<"[M] is forced to release [M.GrabbedMob]!"
					M.saveToLog("|| ([M.x], [M.y], [M.z]) | [key_name(M)] is forced to release [M.GrabbedMob]\n")
					M.attacking=0
					M.isGrabbing=null
					M.GrabbedMob=null
			for(var/obj/Magic_Ball/A in range(0,src))
				if(A.Creator==Creator)
					A.Grabbable=0
			world << "<font color=red>The clouds over [where] darken as the eternal dragon is summoned!</font>"
			logAndAlertAdmins("[key_name(usr)] has summoned the Eternal Dragon to [where] with the Magic Balls")
			usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has summoned the Eternal Dragon to [where] with the Magic Balls.\n")



