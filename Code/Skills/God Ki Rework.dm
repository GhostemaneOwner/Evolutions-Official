


mob/var
	GodKiActive=0
	GodKi=0
	MaxGodKi=0
	SparGodKi=0

obj/God_Ki
	verb/Toggle_God_Ki()
		set category="Other"
		if(!usr.MaxGodKi) return
		if(usr.HasSSj4) return
		if(usr.HasSSj6) return
		if(usr.GodKiActive) usr.GodKiDeactivate()
		else usr.GodKiActivate()



mob/proc/GodKiActivate()
	if(GodKi>0&&MaxGodKi)
		winset(client,"GODKI","is-visible=true")
		BuffOut("You will now utilize your God Ki.")
		GodKiActive=1
		if(Class!="Legendary")
			overlays+=/Icon_Obj/Cloak/WhiteCloak
			overlays+=GodKiAura
		else
			HairRemove()
			overlays+=/Icon_Obj/Cloak/SSG2
			overlays+=/Icon_Obj/Cloak/LSSJGCloak
			HairAdd()
		if(Race=="Saiyan")
			Revert()
			SSG()
		if(Class=="Legendary") view(8,src) << "[src] harnesses the power of a Super Saiyan God!"

		if(Race=="Namekian")
			Revert()
			Gold_Namek()

mob/proc/GodKiDeactivate()
	if(GodKiActive)
		winset(client,"GODKI","is-visible=false")
		BuffOut("You will now hide your God Ki from others.")
		HairRemove()
		if(Class!="Legendary")
			overlays-=/Icon_Obj/Cloak/WhiteCloak
			overlays-=GodKiAura
		else
			overlays-=/Icon_Obj/Cloak/SSG2
			overlays-=/Icon_Obj/Cloak/LSSJGCloak
			for(var/Skill/Buff/S in src)
				if(istype(S,/Skill/Buff/BestialWrath))
					if(S.Using)
						S.use(src,0,0,0,1)
			view(8,src) << "[src] stops harnessing the power of a Super Saiyan God!"
		GodKiActive=0
		HairAdd()
		if(Race=="Saiyan")
			Revert()
			SSG()
		if(Race=="Namekian")
			Revert()
			Gold_Namek()

mob/proc/DrainGodKi()
	if(GodKiActive)
		GodKi=max(0,GodKi-1)
		if(GodKi<=0)
			GodKi=0
			HairRemove()
			if(Class!="Legendary")
				overlays-=/Icon_Obj/Cloak/WhiteCloak
				overlays-=GodKiAura
			else
				overlays-=/Icon_Obj/Cloak/SSG2
				overlays-=/Icon_Obj/Cloak/LSSJGCloak
				for(var/Skill/Buff/S in src)
					if(istype(S,/Skill/Buff/BestialWrath))
						if(S.Using)
							S.use(src,0,0,0,1)
				view(8,src) << "[src] stops harnessing the power of a Super Saiyan God!"
			GodKiActive=0
			HairAdd()
			winset(client,"GODKI","is-visible=false")
			BuffOut("You have run out of available God Ki.")
			if(Race=="Saiyan") SSG()
			if(ssj&&ssj!=4)
				Revert()
				SSj()
				SSj2()
				SSj3()

			if(Race=="Namekian") Gold_Namek()
			if(snj)
				Revert()
			//	Super_Namkian()

mob/proc/SSG() if(Race=="Saiyan" && Class!="Legendary")
	//if(usr.HasSSJ4) return
	//	src << "Can't use SSJ4 and God Ki at the same time!"
	overlays.Remove(hair,SSjHair,USSjHair,SSjFPHair,SSj2Hair,SSj3Hair,SSj4Hair,SSGFPHair,SSGSSHair,SSRHair,SSGHair)
	overlays-=/Icon_Obj/Cloak/SSG2
	overlays-=/Icon_Obj/Cloak/SSGCloak
	overlays-=/Icon_Obj/Cloak/WhiteCloak
	overlays-=GodKiAura
	if(GodKiActive)
		overlays+=/Icon_Obj/Cloak/SSG2
		overlays+=/Icon_Obj/Cloak/SSGCloak
		HairAdd()
		view(8,src) << "[src] harnesses the power of a Super Saiyan God!"
	else
		HairAdd()
		view(8,src) << "[src] stops harnessing the power of a Super Saiyan God."


mob/proc/Gold_Namek() if(Race=="Namekian" && Class != "Ancient")
	overlays.Remove(hair)
	overlays-=/Icon_Obj/Cloak/SSGCloak
	overlays-=/Icon_Obj/Cloak/WhiteCloak
	overlays-=GodKiAura
	icon-=rgb(245, 229, 2, 220)
	if(GodKiActive)
		overlays+=/Icon_Obj/Cloak/SSGCloak
		icon+=rgb(245, 229, 2, 220)
		view(8,src) << "[src] harnesses the ancient power of the Namekians!"

	else
		view(8,src) << "[src] stops harnessing the ancient power of Namekians.."
