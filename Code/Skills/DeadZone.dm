
obj/DeadZone
	icon='Portal.dmi'
	icon_state="center"
	Grabbable=0
	Health=1e31
	New()
		var/image/A=image(icon='Portal.dmi',icon_state="1",pixel_x=-32,pixel_y=-32,layer=EFFECTS_LAYER)
		var/image/B=image(icon='Portal.dmi',icon_state="2",pixel_x=0,pixel_y=-32,layer=EFFECTS_LAYER)
		var/image/C=image(icon='Portal.dmi',icon_state="3",pixel_x=32,pixel_y=-32,layer=EFFECTS_LAYER)
		var/image/D=image(icon='Portal.dmi',icon_state="4",pixel_x=-32,pixel_y=0,layer=EFFECTS_LAYER)
		var/image/E=image(icon='Portal.dmi',icon_state="5",pixel_x=0,pixel_y=0,layer=EFFECTS_LAYER)
		var/image/F=image(icon='Portal.dmi',icon_state="6",pixel_x=32,pixel_y=0,layer=EFFECTS_LAYER)
		var/image/G=image(icon='Portal.dmi',icon_state="7",pixel_x=-32,pixel_y=32,layer=EFFECTS_LAYER)
		var/image/H=image(icon='Portal.dmi',icon_state="8",pixel_x=0,pixel_y=32,layer=EFFECTS_LAYER)
		var/image/I=image(icon='Portal.dmi',icon_state="9",pixel_x=32,pixel_y=32,layer=EFFECTS_LAYER)
		overlays.Add(A,B,C,D,E,F,G,H,I)
		spawn(300) if(src) del(src)
		spawn Dead_Zone()

obj/proc/Dead_Zone() while(src)
	for(var/mob/A in view(10,src)) if(!A.afk)
		A.loc=get_step_towards(A,src)
		if(A in range(0,src))
			A.DZUndo(A)
			A.loc=locate(DEADX,DEADY,DEADZ)
			A.DeadZoneBeen++
	sleep(3)
mob/proc/DZUndo(mob/A)
	A.unSummonX = A.x
	A.unSummonY = A.y
	A.unSummonZ = A.z
	spawn(6000)
		A.loc=locate(A.unSummonX,A.unSummonY,A.unSummonZ)


Skill/Support/MakeAmulet
	Experience=100
	var/LastUse=0
	desc="You can make an amulet, that when used, will open a portal to the deadzone, sucking anything \
	nearby into it. Very, very dangerous."
	verb/Make_Amulet()
		set category="Skills"
		if(LastUse+5<Year)
			usr<<"You must wait until year [LastUse+5]."
			return
		var/obj/items/Amulet/A=new
		usr.contents+=A
		LastUse=Year
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has created an amulet to the DeadZone")
		logAndAlertAdmins("[key_name(usr)] has created an amulet to the DeadZone")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has created an amulet to the DeadZone.\n")


obj/items/Amulet
	icon='DeadZone.dmi'
	desc="Opens a portal to the dead zone, sucking anything nearby in"

	var/tmp/using
	verb/Open() if(!using)
		if(usr.RPMode) return
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has opened a portal to the DeadZone with an Amulet")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has opened a portal to the DeadZone with an Amulet.\n")
		for(var/mob/A in view(usr)) if(A.client) A.saveToLog("[key_name(src)] ([src.x], [src.y], [src.z]) | [key_name(src)] opens the Dead Zone!\n")
		using=1
		view(1)<<"[usr] opens the amulet and a portal to the Dead zone appears!!"
		var/obj/DeadZone/DZ=new
		DZ.loc=(locate(usr.x,usr.y+5,usr.z))
		var/image/A=image(icon='Portal.dmi',icon_state="1",pixel_x=-32,pixel_y=-32)
		var/image/B=image(icon='Portal.dmi',icon_state="2",pixel_x=0,pixel_y=-32)
		var/image/C=image(icon='Portal.dmi',icon_state="3",pixel_x=32,pixel_y=-32)
		var/image/D=image(icon='Portal.dmi',icon_state="4",pixel_x=-32,pixel_y=0)
		var/image/E=image(icon='Portal.dmi',icon_state="5",pixel_x=0,pixel_y=0)
		var/image/F=image(icon='Portal.dmi',icon_state="6",pixel_x=32,pixel_y=0)
		var/image/G=image(icon='Portal.dmi',icon_state="7",pixel_x=-32,pixel_y=32)
		var/image/H=image(icon='Portal.dmi',icon_state="8",pixel_x=0,pixel_y=32)
		var/image/I=image(icon='Portal.dmi',icon_state="9",pixel_x=32,pixel_y=32)
		DZ.overlays.Add(A,B,C,D,E,F,G,H,I)
		spawn(300) using=0

obj/items/Teleportation_Watch
	name="Teleportation Watch (Altered)"
	icon='Helleporter Watch.dmi'
	desc="A mobile teleportation device that has had it's coordinate system altered.  If it doesn't kill you outright it will probably send you to somewhere very unpleasant."

	Savable = 1
	var/tmp/using
	verb/Activate()
		if(usr.RPMode) return
		if(!using)
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has opened a portal with a Helleporter")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has opened a portal with a Helleporter.\n")
			for(var/mob/A in view(usr)) if(A.client) A.saveToLog("[key_name(src)] ([src.x], [src.y], [src.z]) | [key_name(src)] opens a hole in reality!\n")
			using=1
			view(10,src)<<"[usr]'s teleportation watch begins to emit a high pitched buzzing noise!"
			sleep(50)
			view(10,src)<<"[usr]'s teleportation watch begins to crackle with energy!"
			sleep(50)
			view(10,src)<<"[usr]'s teleportation watch is about to activate!"
			sleep(50)
			/*for (var/area/Inside/D)
				if (usr in D)
					view(10,src)<<"The energy around the teleportation watch suddenly dissipates at it's absorbed into [usr]'s surroundings!"
					sleep(300)
					using=0
					return*/
			sleep(1)
			if(usr.z==5||usr.z==6)
				view(10,src)<<"The energy around the device is suddenly sucked away, vanishing as it drifts upwards into the sky!"
					//view(10,src)
				sleep(300)
				using=00
				return
			view(10,src)<<"[usr] discharges the built up energy in the watch with a deafening clap of noise!"
			sleep(3)
			view(10,src)<<"[usr]'s teleportation watch has ripped a hole in reality!"
			new/obj/Hell_Rift(locate(usr.x,usr.y+5,usr.z))
			spawn(300) using=0
		else
			usr<<"This device hasn't finished recharging yet."


obj/Hell_Rift
	icon='Black Hole.dmi'
//	icon_state="center"
	Grabbable=0
	Health=1.#INF
	New()
		spawn(300) if(src) del(src)
		spawn for(var/area/A in view(src)) A.Hell_Weather()
		spawn Enlarge_Icon()
		spawn Hell_Lightning()
		spawn Hell_Rift_Active()

obj/proc/Hell_Lightning()
	var/Amount=10
	var/list/Locs=new
	for(var/turf/B in range(20,src)) Locs+=B
	while(Amount)
		Amount-=1
		var/obj/Lightning_Strike/A=new
		A.loc=pick(Locs)
		sleep(rand(1,50))

area/proc/Hell_Weather()
	var/A=icon
	icon='Weather.dmi'
	icon_state="Flash"
	sleep(8)
	icon_state="Blood Rain"
	spawn(600) if(src)
		icon=A
		icon_state=null




obj/proc/Hell_Rift_Active() while(src)
	var/Coord1
	var/Coord2
//	icon='Black Hole.dmi'
	for(var/mob/player/A in view(12,src))
		A.loc=get_step_towards(A,src)
		if(A in range(0,src))
			if(z==7)
				Coord1=rand(195,217)
				Coord2=rand(133,149)
				A.loc=locate(Coord1,Coord2,1)
			else
				Coord1=rand(249,260)
				Coord2=rand(244,254)
				A.loc=locate(Coord1,Coord2,6)
	sleep(4)


obj/Final_Realm_Portal
	icon='Portal.dmi'
	icon_state="center"
	Grabbable=0
	Health=1e31
	Savable=0
	density=1
	New()
		var/image/A=image(icon='Portal.dmi',icon_state="1",pixel_x=-32,pixel_y=-32)
		var/image/B=image(icon='Portal.dmi',icon_state="2",pixel_x=0,pixel_y=-32)
		var/image/C=image(icon='Portal.dmi',icon_state="3",pixel_x=32,pixel_y=-32)
		var/image/D=image(icon='Portal.dmi',icon_state="4",pixel_x=-32,pixel_y=0)
		var/image/E=image(icon='Portal.dmi',icon_state="5",pixel_x=0,pixel_y=0)
		var/image/F=image(icon='Portal.dmi',icon_state="6",pixel_x=32,pixel_y=0)
		var/image/G=image(icon='Portal.dmi',icon_state="7",pixel_x=-32,pixel_y=32)
		var/image/H=image(icon='Portal.dmi',icon_state="8",pixel_x=0,pixel_y=32)
		var/image/I=image(icon='Portal.dmi',icon_state="9",pixel_x=32,pixel_y=32)
		overlays.Remove(A,B,C,D,E,F,G,H,I)
		overlays.Add(A,B,C,D,E,F,G,H,I)
		spawn Final_Realm_Portal()
	proc/Final_Realm_Portal() while(src)
		loc=locate(rand(1,world.maxx),rand(1,world.maxy),15)
		sleep(300)
