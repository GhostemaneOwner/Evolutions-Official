
obj/var/AntiHack=0
obj
	Door
		density = 1
		opacity = 0
		var/oldOpacity=1
		Bolted = 1
		icon = 'Door2.dmi'
		icon_state = "Closed"
		Shockwaveable = 0
		var/Magic_Secure = 0
		Savable = 1
		Rusted_Door
			density=1
			icon='RustedDoor.dmi'
			icon_state="Closed"
		Namekian_Door
			density=1
			icon='NamekDoor.dmi'
			icon_state="Closed"
		Tech_Door_1
			density=1
			icon='Techie Door 1.dmi'
			icon_state="Closed"
		Glass_Door
			density=1
			oldOpacity=0
			icon='GlassDoors.dmi'
			icon_state="Closed"
		Modern_Door_Large_1
			density=1
			icon='Modern Door 1.dmi'
			icon_state="Closed"
		Door2
			icon='Doors.dmi'
			icon_state="Closed2"
			density=1
		TransparentDoor
			icon='Doors.dmi'
			icon_state="Closed3"
			oldOpacity=0
			density=1
			opacity=0
		Lockable
			Buildable = 0
			Reinforced_Vault
				density=1
				icon='Prison Door.dmi'
				icon_state="Closed"
				desc = "A solid door. Upgrading walls near by will automatically assign it the same tech lvl, making it vastly stronger.You can store passwords on Door Passes/Keys to avoid having to type in the password manually."
				verb
					Upgrade()
						set src in range(1,usr)
						if(usr.Int_Level<Tech)
							usr<<"This is too advanced for you to mess with."
							return
						var/obj/Resources/A
						for(var/obj/Resources/B in usr) A=B
						var/Cost=40000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
						var/Max_Upgrade=(A.Value/Cost)+Tech
						if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
						var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
						if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
						if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
						if(Upgrade<Tech)
							usr << "Unable to downgrade doors."
							return
						Upgrade=round(Upgrade)
						if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
							if("No") return
						Cost*=Upgrade-Tech
						if(Cost<0) Cost=0
						if(Cost>A.Value)
							usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
							return
						view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
						A.Value-=Cost
						src.cost += Cost
						Tech=Upgrade
						desc="Level [Tech] [src]"
						var/Y = 1 + Year
						Y = Y / 20
						src.Level=Tech
						src.Health=(Tech**4)*Wall_Strength*200*Y
				verb/Enchant()
					set src in range(1,usr)
					if(src.Builder=="[usr.real_name]")
						switch(input("Are you sure you want to enchance this door with your magic? In doing so, it will cost [Commas(100000000*(1-(0.15*usr.HasDeepPockets)))] mana, but protect this door from being hacked by a tech console.") in list("No","Yes"))
							if("Yes")
								if(usr in range(1,src))
									for(var/obj/Mana/M in usr)
										if(M.Value >= 100000000)
											M.Value -= 100000000*(1-(0.15*usr.HasDeepPockets))
											range(20,src) << "[usr] enchances their [src]."
											src.Magic_Secure = 1
			Reinforced_Door
				density=1
				icon='Door.dmi'
				icon_state="Closed"
				desc = "A solid door. Upgrading walls near by will automatically assign it the same tech lvl, making it vastly stronger.You can store passwords on Door Passes/Keys to avoid having to type in the password manually."
				verb
					Upgrade()
						set src in range(1,usr)
						if(usr.Int_Level<Tech)
							usr<<"This is too advanced for you to mess with."
							return
						var/obj/Resources/A
						for(var/obj/Resources/B in usr) A=B
						var/Cost=40000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
						var/Max_Upgrade=(A.Value/Cost)+Tech
						if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
						var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
						if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
						if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
						if(Upgrade<Tech)
							usr << "Unable to downgrade doors."
							return
						Upgrade=round(Upgrade)
						if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
							if("No") return
						Cost*=Upgrade-Tech
						if(Cost<0) Cost=0
						if(Cost>A.Value)
							usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
							return
						view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
						A.Value-=Cost
						src.cost += Cost
						Tech=Upgrade
						desc="Level [Tech] [src]"
						var/Y = 1 + Year
						Y = Y / 20
						src.Level=Tech
						src.Health=(Tech**4)*Wall_Strength*200*Y
				verb/Enchant()
					set src in range(1,usr)
					if(src.Builder=="[usr.real_name]")
						switch(input("Are you sure you want to enchance this door with your magic? In doing so, it will cost [Commas(100000000*(1-(0.15*usr.HasDeepPockets)))] mana, but protect this door from being hacked by a tech console.") in list("No","Yes"))
							if("Yes")
								if(usr in range(1,src))
									for(var/obj/Mana/M in usr)
										if(M.Value >= 100000000)
											M.Value -= 100000000*(1-(0.15*usr.HasDeepPockets))
											range(20,src) << "[usr] enchances their [src]."
											src.Magic_Secure = 1
			Magic_Door
				density=1
				opacity = 1
				icon='door magic.dmi'
				icon_state="Closed"
				desc = "A sturdy magical door. It still makes use of tech to reinforce, unless you use mana while upgrading walls near by.You can store passwords on Door Passes/Keys to avoid having to type in the password manually. These can also be enhanced to prevent hacking by a tech user for a large sum of mana."
				New()
					src.pixel_x = -11
				verb/Enhance()
					set src in oview(1)
					if(usr.Magic_Level<Tech)
						usr<<"This is too advanced for you to mess with."
						return
					var/obj/Resources/A
					for(var/obj/Mana/B in usr) A=B
					var/Cost=40000/usr.Magic_Potential
					var/Max_Upgrade=(A.Value/Cost)+usr.Magic_Level
					if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
					var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can enchance is determined by your magical skill (Max Upgrade cannot exceed Magic Skill), and how much mana you have. So if the maximum is less than your magical skill then it is instead due to not having enough mana to enhance it higher than the said maximum.") as num
					if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
					if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
					if(Upgrade<Tech)
						usr << "Unable to downgrade doors."
						return
					Upgrade=round(Upgrade)
					if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
						if("No") return
					Cost*=Upgrade-Tech
					if(Cost<0) Cost=0
					if(Cost>A.Value)
						usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
						return
					view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
					A.Value-=Cost
					src.cost += Cost
					Tech=Upgrade
					desc="Level [Tech] [src]"
					var/Y = 1 + Year
					Y = Y / 20
					src.Level=Tech
					src.Health=(Tech**4)*Wall_Strength*200*Y
				verb/Enchant()
					set src in range(1,usr)
					if(src.Builder=="[usr.real_name]")
						switch(input("Are you sure you want to enchance this door with your magic? In doing so, it will cost [Commas(100000000*(1-(0.15*usr.HasDeepPockets)))] mana, but protect this door from being hacked by a tech console.") in list("No","Yes"))
							if("Yes")
								if(usr in range(1,src))
									for(var/obj/Mana/M in usr)
										if(M.Value >= 100000000)
											M.Value -= 100000000*(1-(0.15*usr.HasDeepPockets))
											range(20,src) << "[usr] enchances their [src]."
											src.Magic_Secure = 1
		New()
			for(var/obj/Controls/C in view(1,src))
				del(src)
			for(var/obj/Controls/PodControls/C in view(1,src))
				del(src)
			for(var/turf/Special/Teleporter/R in view(1,src))
				del(src)
			Close()
		verb
			Remove()
				set src in range(1,usr)
				if(src.Builder=="[usr.real_name]")
					switch(input("Are you sure you want to remove this door?") in list("No","Yes"))
						if("Yes")
							if(usr in range(1,src))
								range(20,src) << "[usr] removes their [src]."
								del(src)
		proc
			Open()
				flick("Opening",src)	//Wait until door opens to let people through
				icon_state = "Open"
				density = 0
				opacity = 0
				//src.sd_SetOpacity(0)
				//sd_ObjSpillLight(src)
				spawn(50)
					if(src)
						Close()
			Close()
				flick("Closing",src)	//Wait until door closes to actually be dense
				icon_state="Closed"
				//src.sd_SetOpacity(1)
				//sd_ObjUnSpillLight(src)
				opacity = oldOpacity
				density = 1
			check_access(var/obj/items/Door_Pass/D)
				if(src.Password == D.Password) return 1
				else return 0
		Click()
			if(usr.client.mob in range(1,src)) if(!usr.client.mob.ActionCheck)
				usr.client.mob.ActionCheck=1
				spawn(10) usr.client.mob.ActionCheck=0
				range(10,src) << "<font color=#FFFF00>There is a knock at the door!"

