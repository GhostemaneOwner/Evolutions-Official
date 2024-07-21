mob/verb
	Grab()
		set category="Skills"
		if(RPMode) return
		InventoryCheck()
		if(global.rebooting)
			usr << "Unable to pick up or drop items while a reboot is in progress."
			return
		for(var/area/Void/V in range(0,usr))
			usr<<"You may not grab here."
			return
		if(GrabbedMob && isGrabbing==1)
			if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] releases [GrabbedMob]\n")
			src.GrabbedMob = null
			src.isGrabbing = null
			return
		if(KOd==0)
			var/Amount=0
			var/list/Choices=new
			for(var/obj/A in get_step(src,dir)) if(A.Grabbable)
				Choices+=A
				Amount++
			for(var/mob/A in get_step(src,dir))
				if(ghostDens_check(A)&&A.client) continue
				if(A.attacking!=3)
					if(!A.afk)
						Choices+=A
						Amount++
					else for(var/obj/Contact/C in A.Contacts) if(C.Signature==usr.Signature) if(C.familiarity>10&&C.positiverelation)
						Choices+=A
						Amount++
			var/obj/Resources/B
			for(var/atom/X in Choices)
				for(var/mob/Z in range(1,X))
					if(Z != src) if(Z.GrabbedMob == X)
						Choices -= X
			if(Amount==1) for(var/atom/A in Choices) B=A
			else B=input("Choose") in Choices
			if(!(locate(B) in view(1,usr))) return
			if(get_dist(usr,B) >1) return
			if(B&&isobj(B)&&B.Bolted)
				src<<"It is bolted. You cannot get it."
				return
			if(B)if(B.Burning)
				src << "It's on fire!"
				return
			if(istype(B,/obj/Ships/)) if(src.z == 12)
				src << "Unable to move that while in space."
				return
			if(istype(B,/obj/Resources))
				for(var/obj/Resources/C in src) if((locate(B) in view(1,usr)))
					view(src)<<"[src] picks up [B]"
					usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)]  picks up [B]\n")
					C.Value+=B.Value
					del(B)
					break
				return
			if(istype(B,/obj/Mana))
				for(var/obj/Mana/C in src) if((locate(B) in view(1,usr)))
					view(src)<<"[src] picks up [B]"
					usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)]  picks up [B]\n")
					C.Value+=B.Value
					del(B)
					break
				return
			if(istype(B,/obj/Ships)) if((locate(B) in view(1,usr)))
				var/obj/Ships/ZZ=B
				if(ZZ.CapsuleTech&&!ZZ.Launching)
					if(ZZ.Password&&!ZZ.Pilot)
						var/passwd = input("What is this ship's password?")
						if(passwd != ZZ.Password)
							usr << "Incorrect Password"
							return
						contents+=B
						view(src)<<"[src] picks up [B]"
//						InventoryCheck()
						usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] picks up [B]\n")
						if(ZZ.Ship) for(var/mob/player/M in Players) if(M.InShip==ZZ.Ship) M.loc=src.loc
						return
			if(istype(B,/obj/items)) if((locate(B) in view(1,usr)))
				var/obj/items/ZZ=B
				if(!istype(ZZ,/obj/items/Android_Chassis)) if(!istype(ZZ,/obj/items/Recycler)||ZZ.CapsuleTech) if(!istype(ZZ,/obj/items/Power_Armor)||ZZ.CapsuleTech) if(!istype(ZZ,/obj/items/Regenerator)||ZZ.CapsuleTech)
					if(istype(B,/obj/items/Gravity))
						var/obj/items/Gravity/C=B
						C.Deactivate()
					if(istype(B,/obj/items/Force_Field)) for(var/obj/items/Force_Field/FF in usr) return 0
					contents+=B
					view(src)<<"[src] picks up [B]"
//					InventoryCheck()
					usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] picks up [B]\n")
					return
			if(!attacking) if((locate(B) in view(1,usr)))
				if(isobj(B)&&!B.Grabbable) return
				GrabbedMob=B
				src.isGrabbing=1 //Check if failure occurs
				if(ismob(B))
					if(B in range(1,src)) //Make sure they're at most 1 tile away.
						var/mob/M=B
						if(M.digging_event)
							src << "[M] is digging. You cannot grab them."
							return
						M.grabberSTR=Str*BP
						if(usr.invisibility)
							usr.invisibility=0
							usr.see_invisible=0
							usr << "As you try to grab [B], you feel your body become tense and you turn visible again!"
							for(var/Skill/Support/Invisibility/A in usr) if(A.Using) spawn(45){A.Using=0;usr<<"You feel your body relax again."}
				usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] grabs [B]\n")
				spawn grab()
			usr.Save()
//			usr.InventoryCheck()


mob/proc/grab()
	while(GrabbedMob && src.isGrabbing==1)
		//step_towards(GrabbedMob,loc)	//:v
		GrabbedMob.loc = loc	//double :v
		if(ismob(GrabbedMob))
			GrabbedMob.grabberSTR=Str*BP
			GrabbedMob.Flight_Land()
			if(GrabbedMob.GrabbedMob)
				GrabbedMob.isGrabbing=null
				GrabbedMob.GrabbedMob.grabberSTR=null
				GrabbedMob.GrabbedMob=null
				view()<<"[GrabbedMob] is forced to release [GrabbedMob.GrabbedMob]!"
			if(GrabbedMob.IsFishing)
				GrabbedMob.IsFishing=0
				GrabbedMob<<"You stopped fishing."
			if(GrabbedMob.IsMining)
				GrabbedMob.IsMining=0
				GrabbedMob<<"You stopped mining."
			if(GrabbedMob.IsCooking)
				GrabbedMob.IsCooking=0
				GrabbedMob<<"You were interrupted."
		//	if(HasGrabMaster) GrabbedMob.grabberSTR*=1.5
			GrabbedMob.dir=turn(dir,180)
		if(KOd)
			view()<<"[usr] is forced to release [GrabbedMob]!"
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] [key_name(usr)] is forced to release [GrabbedMob]\n")
			if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
			attacking=0
			src.isGrabbing=null
		sleep(1)
