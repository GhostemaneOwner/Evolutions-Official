
/*

Upgrade loops through all turfs owned by the player and upgrades them accordingly.

*/


turf/Upgradeable/verb/Upgrade()
	set src in oview(1)
	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] upgrade()"
	if(usr.CanPing) if(src.Builder=="[usr.real_name]")
		var/Setting=1
		usr.CanPing=0
		switch(input("Make walls able to be flown over?") in list("Yes","No"))
			if("No") Setting=0
		spawn for(var/turf/A in Turfs)
			if(prob(0.1)) sleep(1)
			if(src.Builder==A.Builder) A.FlyOverAble=Setting
		spawn for(var/turf/A in CustomTurfs)
			if(prob(0.1)) sleep(1)
			if(src.Builder==A.Builder) A.FlyOverAble=Setting
		spawn(3000) usr.CanPing=1
	else usr<<"You must wait before toggling fly over."
	var/Amount_R = 0
	var/Amount_M = 0
//	var/obj/Arcane = null
//	var/Remove_Arcane = 0
	switch(input("Do you want to add resources to the walls, enhancing their strength further?") in list("Yes","No"))
		if("Yes")
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			Amount_R=round(input("Add how much resources to this walls durability?") as num)
			if(Amount_R>A.Value) Amount_R=A.Value
			if(Amount_R<0) Amount_R=0
			A.Value-=Amount_R
			view(usr)<<"[usr] upgraded the wall's armor with [Commas(Amount_R*(1+(usr.HasBuildingPermit*2)))] resources."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgraded [Builder]'s wall armor with [Commas(Amount_R)] resources.\n")
	if(usr.Magic_Level >= 20)
		switch(input("Do you want to add mana to the walls, enhancing their strength further?") in list("Yes","No"))
			if("Yes")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				Amount_M=round(input("Add how much mana to this walls durability?") as num)
				if(Amount_M>A.Value) Amount_M=A.Value
				if(Amount_M<0) Amount_M=0
				A.Value-=Amount_M
				view(usr)<<"[usr] upgraded the wall's armor with [Commas(Amount_M*(1+(usr.HasBuildingPermit*2)))] mana."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgraded [Builder]'s wall armor with [Commas(Amount_M)] mana.\n")
	if(src.Builder)
		var/Ch=input("Use your Intelligence or your Magical Ability?") in list("Intelligence","Magic")
		if(Ch=="Intelligence")
			if(Level>usr.Int_Level)
				usr<<"It is already beyond your upgrading capabilities."
				return
			view(usr)<<"[usr] upgraded the wall's armor to level [usr.Int_Level]"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgraded [Builder]'s wall armor to level [usr.Int_Level].\n")
			var/Y = 1 + (Year / 20)
			for(var/turf/B in Turfs)
				if(prob(0.1)) sleep(1)
				if(usr) if(src.Builder==B.Builder)
					if(B.Level<usr.Int_Level)
						B.Level=usr.Int_Level
						B.Health=(usr.Int_Level**3.5)*Wall_Strength*350*Y*(1+(usr.HasBuildingPermit))
			for(var/obj/B in global.worldObjectList)
				if(prob(0.1)) sleep(1)
				if(usr) if(src.Builder==B.Builder)
					if(B.Level<usr.Int_Level)
						B.Level=usr.Int_Level
						B.Health=(usr.Int_Level**3.5)*Wall_Strength*350*Y*(1+(usr.HasBuildingPermit))
		if(Ch=="Magic")
			if(Level>usr.Magic_Level)
				usr<<"It is already beyond your upgrading capabilities."
				return
			view(usr)<<"[usr] upgraded the wall's armor to level [usr.Magic_Level]"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgraded [Builder]'s wall armor to level [usr.Magic_Level].\n")
			var/Y = 1 + (Year / 20)
			for(var/turf/B in Turfs)
				if(prob(0.1)) sleep(1)
				if(usr) if(src.Builder==B.Builder)
					if(B.Level<usr.Magic_Level)
						B.Level=usr.Magic_Level
						B.Health=(usr.Magic_Level**3.5)*Wall_Strength*350*Y*(1+(usr.HasBuildingPermit*2))
			for(var/obj/B in global.worldObjectList)
				if(prob(0.1)) sleep(1)
				if(usr) if(src.Builder==B.Builder)
					if(B.Level<usr.Magic_Level)
						B.Level=usr.Magic_Level
						B.Health=(usr.Magic_Level**3.5)*Wall_Strength*350*Y*(1+(usr.HasBuildingPermit*2))
		for(var/turf/B in Turfs)
			if(prob(0.1)) sleep(1)
			if(usr) if(src.Builder==B.Builder)
				B.overlays = null
				if(Amount_R) B.Health += Amount_R*700*(1+(usr.HasBuildingPermit*3))
				if(Amount_M) B.Health += Amount_M*700*(1+(usr.HasBuildingPermit*3))
		for(var/obj/B in global.worldObjectList)
			if(prob(0.1)) sleep(1)
			if(usr) if(src.Builder==B.Builder)
				if(Amount_R) B.Health += Amount_R*700*(1+(usr.HasBuildingPermit*3))
				if(Amount_M) B.Health += Amount_M*700*(1+(usr.HasBuildingPermit*3))
