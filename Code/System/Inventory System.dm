

var/const/InventorySpace=16


mob/var
	tmp/InventoryUsed=0
	HasBelt=0

mob/player
	Entered()
		..()
		InventoryCheck()
	Exited()
		..()
		InventoryCheck()


mob/proc/InventoryCheck()
	var/hasBag=0
	if(locate(/obj/items/Cooking_Bag) in src) hasBag=1
	var/hasMBag=0
	if(locate(/obj/items/Mining_Bag) in src) hasMBag=1
	var/InvUsed=0
	for(var/obj/items/A in src) if(istype(A,/obj/items)) if(!istype(A,/obj/items/Clothes))
		if(istype(A,/obj/items/Door_Pass)&&src.HasKeyRing) continue
		if(istype(A,/obj/items/Advanced_Door_Pass)&&src.HasKeyRing) continue
		if(istype(A,/obj/items/Blood_Vial))if(hasBag) if(hasBag<51)
			hasBag++
			continue
		if(istype(A,/obj/items/Salt_Water))if(hasBag) if(hasBag<51)
			hasBag++
			continue
		if(istype(A,/obj/items/Fresh_Water))if(hasBag) if(hasBag<51)
			hasBag++
			continue
		if(istype(A,/obj/items/rawfood))if(hasBag) if(hasBag<51)
			hasBag++
			continue
		if(istype(A,/obj/items/cookedfood))if(hasBag) if(hasBag<51)
			hasBag++
			continue
		if(istype(A,/obj/items/rawmetal))if(hasMBag) if(hasMBag<51)
			hasMBag++
			continue
		if(istype(A,/obj/items/rawore))if(hasMBag) if(hasMBag<51)
			hasMBag++
			continue
		if(istype(A,/obj/items/FriendshipBracelet)) continue
		if(istype(A,/obj/items/Hammer)) if(HasEOMA) continue
		if(istype(A,/obj/items/Sword)) if(HasEOMA) continue
		if(istype(A,/obj/items/Power_Armor)) continue
		if(istype(A,/obj/items/gifts)) continue
		var/Extra=HasBelt
		if(Race=="Tuffle"|Race=="Demon") Extra+=5
		if(InvUsed<InventorySpace+(HasBeastOfBurden*10)+Extra) InvUsed++
		else if(!A.suffix||A.Can_Drop_With_Suffix)  if(isturf(src.loc))
			for(var/mob/player/P in view(usr)) if(P.see_invisible>=src.invisibility)
				P<<"[src] has no more room to carry [A]."
			saveToLog("| | ([src.x], [src.y], [src.z]) | [key_name(src)] drops [A].\n")
			overlays-=A.icon
			A.loc=usr.loc
			step_to(A,dir)
			A.dir=SOUTH
			Save()
		InventoryUsed=InvUsed
