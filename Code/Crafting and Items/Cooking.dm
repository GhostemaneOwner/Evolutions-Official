

obj/Cookable
	var/Cooked
	Savable = 1
	density=1
	var/KilledName
	var/HasHead
	Level=0.2 //How much it boosts your healing if you eat this.
	Del()
		if(!Cooked) Body_Parts()
		..()
	verb/Eat()
		set src in oview(1,usr)
		view(usr)<<"[usr] eats the [src]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] | [key_name(usr)] eats [src].\n")
		usr.AteCorpse++
		if(!Level)
			usr.AteRottenCorpse++
			view(usr)<<"[usr] becomes sick throwing up."
		Cooked=1
		del(src)
	verb/Cook()
		set src in oview(1,usr)
		if(!Cooked)
			for(var/obj/Props/Heatsources/H in range(1,src))
			Cooked=1
			view(usr)<<"[usr] cooked [src]."
	Body
		verb/Remove_Head()
			set src in oview(1,usr)
			if(HasHead)
				view(usr)<<"[usr] removed the head from [src]."
				var/obj/Cookable/Removed_Head/RH = new
				HeadBlood(src)
				RH.KilledName=KilledName
				HasHead=0
				RH.name="[KilledName]'s Head"
				RH.loc=usr.contents
	New()
		spawn(6000) if(src) overlays+='Flies.dmi'
		..()
	Removed_Head

