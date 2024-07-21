



obj/EarthPortal
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
		spawn EarthPortal()

obj/proc/EarthPortal() while(src)
/*	for(var/obj/A in view(10,src)) if(A!=src) if(A.Bolted != 1)
		A.loc=get_step_towards(A,src)
		if(A in range(0,src)) A.loc=locate(417,279,9)*/
	for(var/mob/A in view(10,src))
		A.loc=get_step_towards(A,src)
		if(A in range(0,src))
			A.loc=locate(60,370,1)
	sleep(2)



Skill/Spell/DeadZone
	icon='DeadZone.dmi'
	desc="Opens a portal to the dead zone, sucking anyone nearby in. (Has a 2 year CD.  After 10 minutes, those sucked in will be teleported back.)"
	var/tmp/using
	var/LastUse=0
	verb/Open_Dead_Zone_Portal()
		set category="Other"
		if(!using)
			if(LastUse+2>=WipeDay)
				usr<<"You can't use this until day [LastUse+2]."
				return
			if(usr.RPMode) return
			if(usr.z!=11)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has opened a portal to the DeadZone.\n")
				using=1
				LastUse=WipeDay
				view(1)<<"[usr] opens a portal to the Dead Zone!"
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
				return
			else
				LastUse=WipeDay
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has opened a portal to Earth.\n")
				using=1
				view(1)<<"[usr] opens a portal to Earth!"
				var/obj/EarthPortal/DZ=new
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

