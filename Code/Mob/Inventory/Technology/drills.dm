#define DRILLS

var/list/DrillList = new()

proc/loopThroughDrills()
	set background=1
	set waitfor=0
	var/count = 0
	if(!global.DrillList.len || !global.DrillList)
		spawn(600) // Pause 1 minute
			.() // Then call itself again

	for(var/obj/Drill/drillObj in global.DrillList)
		count++
		sleep(0)
		if(drillObj.Resources<(2800*drillObj.DrillRate))
			var/Taxes=0
			switch(drillObj.z)
				if(1)Taxes=(Z1Tax/100)*10*drillObj.DrillRate
				if(2)Taxes=(Z2Tax/100)*10*drillObj.DrillRate
				if(3)Taxes=(Z3Tax/100)*10*drillObj.DrillRate
				if(4)Taxes=(Z4Tax/100)*10*drillObj.DrillRate
				if(5)Taxes=(Z5Tax/100)*10*drillObj.DrillRate
				if(6)Taxes=(Z6Tax/100)*10*drillObj.DrillRate
				if(7)Taxes=(Z7Tax/100)*10*drillObj.DrillRate
			Taxes=round(Taxes)
			switch(drillObj.z)
				if(1)Z1ReserveResources+=Taxes
				if(2)Z2ReserveResources+=Taxes
				if(3)Z3ReserveResources+=Taxes
				if(4)Z4ReserveResources+=Taxes
				if(5)Z5ReserveResources+=Taxes
				if(6)Z6ReserveResources+=Taxes
				if(7)Z7ReserveResources+=Taxes
			drillObj.Resources+=(10*drillObj.DrillRate)-Taxes

		if(count >= 500) // pause every 500 drills
			count=0
			sleep(10) // for a full minute
	for(var/obj/Mana_Pylon/drillObj in global.DrillList)
		count++
		sleep(0)

		if(drillObj.Resources<(2800*drillObj.DrillRate))
			var/Taxes=0
			switch(drillObj.z)
				if(1)Taxes=(Z1Tax/100)*10*drillObj.DrillRate
				if(2)Taxes=(Z2Tax/100)*10*drillObj.DrillRate
				if(3)Taxes=(Z3Tax/100)*10*drillObj.DrillRate
				if(4)Taxes=(Z4Tax/100)*10*drillObj.DrillRate
				if(5)Taxes=(Z5Tax/100)*10*drillObj.DrillRate
				if(6)Taxes=(Z6Tax/100)*10*drillObj.DrillRate
				if(7)Taxes=(Z7Tax/100)*10*drillObj.DrillRate
			Taxes=round(Taxes)
			switch(drillObj.z)
				if(1)Z1ReserveMana+=Taxes
				if(2)Z2ReserveMana+=Taxes
				if(3)Z3ReserveMana+=Taxes
				if(4)Z4ReserveMana+=Taxes
				if(5)Z5ReserveMana+=Taxes
				if(6)Z6ReserveMana+=Taxes
				if(7)Z7ReserveMana+=Taxes
			drillObj.Resources+=(10*drillObj.DrillRate)-Taxes


		if(count >= 500) // pause every 500 drills
			count=0
			sleep(10) // for a full minute
	spawn(3000) // Pause 5 minutes
		.() // Then call itself again


obj/Magical_Portal
	Bolted = 1
	Savable=1
	Health = 1.#INF
	desc="Click to travel. This is a magicial portal, it could lead anywhere..."
	icon = 'MagicPortal.dmi'
	pixel_x=-80
	pixel_y=-80
	var/timer=9000
	var/gotRE=0
	var/Portal_Number
	New()
		global.worldObjectList+=src
		// for(var/obj/Magical_Portal/B in world)
		// 	for(var/obj/Magical_Portal/other in B.loc)
		// 		if(other != B)
		// 			del other
		var/image/B=image(icon='MagicPortal.dmi',icon_state="")
		overlays.Remove(B)
		overlays.Add(B)
		spawn(10)
			if(src.tag == "Special" || src.tag == "Admin")
				if(timer > 0)
					while(timer > 0)
						timer--
						sleep(1)
				if(timer == 0)
					if(src)
						view(8,src) << "[src] closes shut!"
						del(src)
						return
		..()
	//		if(src) src.pixel_x = -37

	Click()
		if(src in range(2,usr))
			for(var/obj/Magical_Portal/P in world)
				if(P != src) if(P.Portal_Number) if(P.Portal_Number == src.Portal_Number)
					view(8,usr) << "[usr] enters the portal."
					if(ismob(P.loc))
						var/mob/PP=P.loc
						usr.loc = PP
					else usr.loc = P.loc
					view(8,usr) << "[usr] exits the portal."
					return
	verb
		Remove()
			set src in range(1,usr)
			if(z==17)
				usr<<"You can not remove this portal."
				return
			switch(input("Are you sure you want to close this portal permanently?") in list("No","Yes"))
				if("Yes")
					if(src.Builder=="[usr.real_name]")
						if(src.tag == "Admin" || src.tag == "Special")
							for(var/obj/Magical_Portal/P in world)
								if(P != src) if(P.Portal_Number) if(P.Portal_Number == src.Portal_Number)
									spawn(5) 
										if(P)
											view(8,P) << "[P] closes shut!"
											del(P)
						spawn(5)
							if(src)
								view(8,src) << "[src] closes shut!"
								del(src)

	verb
		Harness_Radiant_Energy()
			set src in range(1,usr)
			if(usr.Magic_Potential<3)
				usr<<"You do not understand the art of magic enough to fully utilize it here."
				return
			if(src.tag=="Special"||src.tag=="Admin") return
			if(gotRE==Year)
				usr<<"You have already gathered Radiant Energy this year."
				return
			if(usr.GotRE==Year)
				usr<<"You have already gathered Radiant Energy this year."
				return
			if(RadiantEnergy==src.z)
				view(usr) <<"[usr] begins to gather Radiant Energy using [src]!"
				gotRE=Year
				//usr.GotRE=Year
				sleep(36000)//1 hr
				if(src)
					view(src)<<"[src] has finished gathering Radiant Energy."
					gotRE=Year
					//usr.GotRE=Year
					new/obj/Mana/Radiant_Mana_Crystal(src.loc)


obj
	var
		link_used = 0
	proc
		Move_Resources(var/turf/t,var/mob/M)
			if(src.loc == t)
				for(var/obj/Mana/Y in view(0,src))
					if(Y == src)
						for(var/mob/X in range(1,src))
							if(M) if(X == M)
								for(var/obj/Mana/magic in M)
									magic.Value += Y.Value
									del(src)
				for(var/obj/Resources/Y in view(0,src))
					if(Y == src)
						for(var/mob/X in range(1,src))
							if(M) if(X == M)
								for(var/obj/Resources/magic in M)
									magic.Value += Y.Value
									del(src)
				return
			if(t) if(M) if(src.loc != t)
				step_towards(src,t)
				spawn(5)
					if(t) if(M) src.Move_Resources(t,M)
		Pylon_Link(var/mob/clicker)
			for(var/obj/Mana_Pylon/X in view(0,src))
				if(X == src)
					if(X.Resources > 0)
						var/obj/Mana/A = new
						A.Value+=X.Resources
						A.loc = X.loc
						A.name = "[Commas(X.Resources)] Mana"
						var/turf/t = clicker.loc
						A.Move_Resources(t,clicker)
					view(src)<<"[clicker] withdraws [Commas(X.Resources)] mana from [src]"
					clicker<<"This is a level [X.DrillRate] mana pylon."
					usr.saveToLog("([clicker.x], [clicker.y], [clicker.z]) | [key_name(clicker)] withdraws [Commas(X.Resources)] mana from [src] (built by: [src.Builder]).\n")
					src.link_used = 1
					spawn(33)
						if(src) src.link_used = 0
					for(var/obj/Mana_Pylon/P in oview(2,src))
						if(P.Builder == src.Builder) if(P.link_used == 0)
							P.Pylon_Link(clicker)
						var/Step = get_step_towards(X,P)
						var/Dir = get_dir(X,P)
						if(Dir == SOUTH || Dir == EAST || Dir == WEST || Dir == NORTH)
							var/Icon_Obj/Customization/Auras/Sparks/E = new
							E.loc = Step
							E.pixel_y = 14
							E.icon = 'blue elec.dmi'
							E.layer = 100
							spawn(20)
								if(E) del(E)
					X.Resources=0
		Drill_Link(var/mob/clicker)
			for(var/obj/Drill/X in view(0,src))
				if(X == src)
					if(X.Resources > 0)
						var/obj/Resources/A = new
						A.Value+=X.Resources
						A.loc = X.loc
						A.name = "[Commas(X.Resources)] Resources"
						var/turf/t = clicker.loc
						A.Move_Resources(t,clicker)
					view(src)<<"[clicker] withdraws [Commas(X.Resources)] resources from [src]"
					clicker<<"This is a level [X.DrillRate] drill."
					usr.saveToLog("([clicker.x], [clicker.y], [clicker.z]) | [key_name(clicker)] withdraws [Commas(X.Resources)] Resources from [src] (built by: [src.Builder]).\n")
					src.link_used = 1
					spawn(33)
						if(src) src.link_used = 0
					for(var/obj/Drill/P in oview(2,src))
						if(P.Builder == src.Builder) if(P.link_used == 0)
							P.Drill_Link(clicker)
						var/Step = get_step_towards(X,P)
						var/Dir = get_dir(X,P)
						if(Dir == SOUTH || Dir == EAST || Dir == WEST || Dir == NORTH)
							var/Icon_Obj/Customization/Auras/Sparks/E = new
							E.loc = Step
							E.pixel_y = 14
							E.icon = 'blue elec.dmi'
							E.layer = 100
							spawn(20)
								if(E) del(E)
					X.Resources=0

obj/Mana_Pylon
	density=1
	var/Resources=0
	var/DrillRate=1
	Savable = 1
	desc="This is a Mana Pylon. It will slowly absorb ambient energy."
	icon = 'Mana_Pylon.dmi'
	New()
		global.DrillList += src // add them to the global list
	Click()
		if(!(usr in range(1,src))) return
		if(usr.client.eye!=usr) return
		src.Pylon_Link(usr)

	verb/Enhance()
		set src in oview(1)
		if(usr.Magic_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Mana/A
		for(var/obj/Mana/B in usr) A=B
		var/Cost=1000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Magic_Level*10) Max_Upgrade=usr.Magic_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magical skill (Max Upgrade cannot exceed magical skill), and how much mana you have. So if the maximum is less than your magic skill then it is instead due to not having enough mana to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Magic_Level*10) Upgrade=usr.Magic_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		DrillRate=Upgrade




	verb/Mass_Enhance()
		set src in oview(1)
		if(usr.Magic_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Mana/A
		for(var/obj/Mana/B in usr) A=B
		var/Cost=1000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Magic_Level*10) Max_Upgrade=usr.Magic_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magical skill (Max Upgrade cannot exceed magical skill), and how much mana you have. So if the maximum is less than your magic skill then it is instead due to not having enough mana to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Magic_Level*10) Upgrade=usr.Magic_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		for(var/obj/Mana_Pylon/MP in view(10))
			Cost=1000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough mana to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [MP] to level [Upgrade]"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [MP] to level [Upgrade]. \n")
			A.Value-=Cost
			MP.Tech=Upgrade
			MP.desc="Level [MP.Tech] [MP]"
			MP.DrillRate=Upgrade
/*


	verb/Mass_Upgrade()
		set src in view(1)
		if(usr.Int_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return

		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=1000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level*10) Max_Upgrade=usr.Int_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level*10) Upgrade=usr.Int_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) return
		for(var/obj/Drill/D in oview(10))
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
			A.Value-=Cost
			src.cost += Cost
			Tech=Upgrade
			desc="Level [Tech] [src]"
			DrillRate=Upgrade
*/
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."

			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1

			return

obj/Drill
	density=1
	var/Resources=0
	var/DrillRate=1
	Savable = 1
	desc="This is an automated drill.  While it has a slow extraction rate, it is always on."

	New()
		var/image/A=image(icon='Space.dmi',icon_state="d1",pixel_y=16,pixel_x=-16)
		var/image/Z=image(icon='Space.dmi',icon_state="d2",pixel_y=16,pixel_x=16)
		var/image/C=image(icon='Space.dmi',icon_state="d3",pixel_y=-16,pixel_x=-16)
		var/image/D=image(icon='Space.dmi',icon_state="d4",pixel_y=-16,pixel_x=16)
		overlays.Remove(A,Z,C,D)
		overlays.Add(A,Z,C,D)
		global.DrillList += src // add them to the global list


	Click()
		if(!(usr in range(1,src))) return
		if(usr.client.eye!=usr) return
		view(src)<<"[usr] withdraws [Commas(Resources)] resources from [src]"
		usr<<"This is a level [DrillRate] drill."
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] withdraws [Commas(Resources)] resources from [src] (built by: [src.Builder]).\n")
		src.Drill_Link(usr)
		/*for(var/obj/Resources/A in usr)
			A.Value+=Resources
			Resources=0*/

	verb/Upgrade()
		set src in view(1)
		if(usr.Int_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=1000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level*10) Max_Upgrade=usr.Int_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level*10) Upgrade=usr.Int_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		DrillRate=Upgrade


	verb/Mass_Upgrade()
		set src in view(1)
		if(usr.Int_Level*10<Tech)
			usr<<"This is too advanced for you to mess with."
			return

		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=1000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level*10) Max_Upgrade=usr.Int_Level*10
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level*10) Upgrade=usr.Int_Level*10
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) return
		for(var/obj/Drill/D in view(10))
			Cost=1000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [D] to level [Upgrade]"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [D] to level [Upgrade]. \n")
			A.Value-=Cost
			D.cost += Cost
			D.Tech=Upgrade
			D.desc="Level [D.Tech] [D]"
			D.DrillRate=Upgrade

	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."

			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1

			return


