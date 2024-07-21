
atom/Topic(href,href_list[])
	..()
	switch(href_list["action"])
		if("examine")
			var/showstuff="[src.desc]"
		//	usr<<"href is [href]"
		//	usr<<"src is [src] [src.type]"
			if(istype(src,/obj/items))
				var/obj/items/O=src
				showstuff="[showstuff]\n[usr.Display_Magic(src)]\nIt seems to have a serial number of [O.Serial].\nIt seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."
				if(O.CustomDesc) showstuff="[O.CustomDesc]\n[showstuff]\n[usr.Display_Magic(src)]\nIt seems to have a serial number of [O.Serial].\nIt seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."
			winshow(usr.client,"tooltip",1)
			winset(usr.client,"tooltip","title=\"[src]\"")
			winset(usr.client,"tooltipholder","text=\"[src]\n[showstuff]\"")

			//src.GetExamine(usr)


atom/proc/GetExamine(mob/user)
	if(ismob(src)&&istype(src,/mob/player))user.Check_Profile(src)
	else
		var/showstuff="[src.desc]"
		if(istype(src,/obj/items))
			var/obj/items/O=src
			showstuff="[showstuff]\n[usr.Display_Magic(src)]\nIt seems to have a serial number of [O.Serial].\nIt seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."
			if(O.CustomDesc) showstuff="[O.CustomDesc]\n[showstuff]\n[usr.Display_Magic(src)]\nIt seems to have a serial number of [O.Serial].\nIt seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."
	/*	if(ismob(src))
			var/mob/SS=src
			//if(SS.Imitating) showstuff="[SS.FakeProfilePicture][SS.FakeProfile]"
			//else showstuff="[SS.Profile]"
			showstuff="[SS.Profile]"*/
		if(istype(src,/Skill/Buff))
			var/Skill/Buff/S=src
			showstuff="[S.GetDescription(user)]"
		winshow(user.client,"tooltip",1)
		winset(user.client,"tooltip","title=\"[src]\"")
		winset(user.client,"tooltipholder","text=\"[src]\n[showstuff]\"")



atom/DblClick()
	if(!isturf(src))if(!usr.Lethality) src.GetExamine(usr)





/atom/verb/examine(obj/A as obj|mob in view(10,usr))
	set name = "Examine"
//	set category = "Other"
	var/CanPing=1
	if(CanPing)
		if(A) src = A
		if(!usr) return
		if(ismob(usr) && get_dist(usr,src)>10)
			usr << "That's too far away to examine."
			return
		var/icon/I = src.getIconImage()
		usr << "This is \icon[I] \an [src.name]."
		if(usr.client.holder)
			usr<<"Builder: [src.Builder]"
		if(istype(A,/obj))
			var/obj/O=A
			if(O.Serial) usr << "It seems to have a serial number of [O.Serial]."
		if(istype(A,/obj/items))
			var/obj/items/O=A
			usr << "It seems to have [round(O.Durability/O.MaxDurability*100)]% durability remaining."
		if(istype(A,/Skill/Buff))
			var/Skill/Buff/S=A
			usr<<"[S.GetDescription(usr)]"
		else usr << src.desc
		if(isobj(src)) if(istype(src,/obj/items)) usr<<"[usr.Display_Magic(src)]"
		if(src in usr.contents)if(istype(src,/obj/items)) if(usr.Confirm("Reveal this item to those nearby?")) for(var/mob/player/PP in view(usr)) PP.ICOut("[usr] reveals their [src]. [src.desc]")
		CanPing=0
		if(ismob(src)&&istype(src,/mob/player))usr.Check_Profile(src)
		spawn(15) CanPing=1
