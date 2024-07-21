/client/proc/stealth()
	set category = "Admin"
	set name = "Admin Mode"
	if(src.mob.AdminMode==0)
		src.mob.AdminMode = 1
		src.mob.Old_Sight = src.mob.see_invisible
		src.mob.see_invisible = 5000
		var/mob/Admin_Mode/A = new/mob/Admin_Mode
		A.controllerKey = src.mob.ckey
		A.loc = src.mob.loc
		src.mob.controlled = A
		src.perspective = EYE_PERSPECTIVE
		src.eye = A
		src << "You toggled Admin Mode on. (They're automatically invisible)"
	else
		src.mob.AdminMode = 0
		src.mob.see_invisible = src.mob.Old_Sight
		src.mob.controlled = null
		src.eye = src.mob
		for(var/mob/Admin_Mode/A in world)
			if(A.controllerKey == src.mob.ckey)
				del(A)
		src << "You toggled Admin Mode off."
	log_admin("[key_name(src.mob)] has turned admin mode [src.mob.AdminMode ? "ON" : "OFF"]")
	alertAdmins("[key_name_admin(src.mob)] has turned admin mode [src.mob.AdminMode ? "ON" : "OFF"]", 1)

mob/var
	AdminMode=0
	controlled
	controllerKey

mob/Admin_Mode
	icon = 'GhostPink.dmi'
	name = "Admin"
	adminDensity = 1
	invisibility = 100
	attackable = 0
	SpdMod = 5
	layer = MOB_LAYER+1
	proc
		jumptomob()
			var/mob/M=input("Jump to Mob") as mob in Players
			if(M)
				src.unSummonX = src.x
				src.unSummonY = src.y
				src.unSummonZ = src.z
				src.loc = get_turf(M)
				log_admin("([src.controllerKey]) Admin jumped to [key_name(M)]")
				alertAdmins("([src.controllerKey]) Admin jumped to [key_name_admin(M)]", 1)
		jumptoturf()
			var/turf/T=input("Jump to Turf") as turf in world
			if(T)
				src.unSummonX = src.x
				src.unSummonY = src.y
				src.unSummonZ = src.z
				src.loc = T
				log_admin("([src.controllerKey]) Admin jumped to [T.x],[T.y],[T.z] in [T.loc]")
				alertAdmins("([src.controllerKey]) Admin jumped to [T.x],[T.y],[T.z] in [T.loc]", 1)
		jumptokey()
			var/list/keys = list()
			for(var/client/C)
				keys += C
			var/selection = input("Please select a player!", "Admin Jumping") as null|anything in keys
			if(selection)
				var/mob/M = selection:mob
				src.unSummonX = src.x
				src.unSummonY = src.y
				src.unSummonZ = src.z
				src.loc = M.loc
				log_admin("([src.controllerKey]) Admin jumped to [key_name(M)]")
				alertAdmins("([src.controllerKey]) Admin jumped to [key_name_admin(M)]", 1)
		jumptoobj()
			var/obj/M=input("Jump to Obj") as obj in world
			if(M.z)
				src.unSummonX = src.x
				src.unSummonY = src.y
				src.unSummonZ = src.z
				src.loc = get_turf(M)
				log_admin("([src.controllerKey]) Admin jumped to [M]")
				alertAdmins("([src.controllerKey]) Admin jumped to [M]", 1)
	New()
		overlays += image('admintag.dmi', layer=MOB_LAYER+EFFECTS_LAYER+1, pixel_x=-16, pixel_y=-16)
		TextColor = pick("red", "blue", "yellow", "green")
	Click()
		if(usr.ckey != src.controllerKey)
			return
		else
			switch(input("What command would you like to perform?") in list("Say", "Toggle Visibility", "Jump", "Return", "Summon", "Unsummon", "Cancel"))
				if("Say")
					var/msg = input(usr,"What do you wish to say?","Admin Say","") as text
					msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
					if(!msg) return
					for(var/mob/player/M in view(src))
						if(M.client)
							if(M == usr)
								continue
							else
								M.ICOut("<span class=\"say\"><font size=[M.TextSize] color=[src.TextColor]>Admin says \"[msg]\"</span>")
								M.OOCOut("<span class=\"say\"><font size=[M.TextSize] color=[src.TextColor]>Admin says \"[msg]\"</span>")
					usr.ICOut("<span class=\"say\"><font size=[usr.TextSize] color=[src.TextColor]>You Admin say \"[msg]\"</span>")
					usr.OOCOut("<span class=\"say\"><font size=[usr.TextSize] color=[src.TextColor]>You Admin say \"[msg]\"</span>")

				if("Toggle Visibility")
					if(src.invisibility)
						usr << "Your Admin Mode can now be seen by everyone."
						src.invisibility = 0
						return
					else
						usr << "Your Admin Mode can no longer be seen by everyone."
						src.invisibility = 100
						return
				if("Jump")
					var/PP=input(usr,"Jump...", "Jump") in list("Jump to Mob", "Jump to Turf", "Jump to Key", "Jump to Obj", "Cancel")
					switch(PP)
						if("Jump to Mob") src.jumptomob()
						if("Jump to Turf") src.jumptoturf()
						if("Jump to Key") src.jumptokey()
						if("Jump to Obj") src.jumptoobj()
						if("Cancel")
							return
				if("Return")
					switch(input("Are you sure you want to return to your previous location?") in list("Yes", "No"))
						if("Yes")
							if(!src.unSummonX||!src.unSummonY||!src.unSummonZ)
								src.loc = usr.loc
							else
								src.loc = locate(src.unSummonX, src.unSummonY, src.unSummonZ)
							return
						if("No")
							return
				if("Summon")
					var/mob/M=input("Summon") as mob in Players
					if(M)
						switch(input("Are you sure you want to summon [M]?") in list("Yes", "No"))
							if("Yes")
								M.unSummonX = M.x
								M.unSummonY = M.y
								M.unSummonZ = M.z
								M.loc = src.loc
								log_admin("([usr.key]) Admin summoned [key_name_admin(M)]")
								alertAdmins("([usr.key]) Admin summoned [key_name_admin(M)]", 1)
								return
							if("No")
								return
				if("Unsummon")
					var/mob/M=input("Unsummon") as mob in Players
					if(M)
						switch(input("Are you sure you want to unsummon [M]?") in list("Yes", "No"))
							if("Yes")
								if(M.unSummonX && M.unSummonY && M.unSummonZ)
									M.loc = locate(M.unSummonX, M.unSummonY, M.unSummonZ)
								else
									return
							if("No")
								return
				if("Cancel")
					return
					