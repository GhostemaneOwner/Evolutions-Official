
/client/proc/jumptomob(mob/M in Players)
	set category = null
	set name = "Jump to"
	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!M) M=input("Jump to Mob") as mob in Players
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = get_turf(M)
	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	alertAdmins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)


/client/proc/Jump()
	set category = "Admin"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/PP=input(usr,"Jump...","Jump") in list("Jump to Mob", "Jump to Turf", "Jump to Key", "Jump to Obj","Cancel")
	switch(PP)
		if("Jump to Area") usr.client.Jumptoarea()
		if("Jump to Mob") usr.client.jumptomob()
		if("Jump to Turf") usr.client.jumptoturf()
		if("Jump to Key") usr.client.jumptokey()
		if("Jump to Obj") usr.client.jumptoobj()

/client/proc/Jumptoarea()//var/area/A in world)
	set desc = "Area to jump to"
	set category = "Admin"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/area/A=input("Jump to Area") as area in world
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = pick(get_area_turfs(A))
	log_admin({"[key_name(usr)] jumped to [A]"})
	alertAdmins("[key_name_admin(usr)] jumped to [A]", 1)

/client/proc/jumptoturf()//var/turf/T in world)
	set category = "Admin"
	set name = "Jump to turf"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/turf/T=input("Jump to Turf") as turf in world
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = T
	log_admin({"[key_name(usr)] jumped to [T.x],[T.y],[T.z] in [T.loc]"})
	alertAdmins("[key_name_admin(usr)] jumped to [T.x],[T.y],[T.z] in [T.loc]", 1)


/client/proc/jumptoobj()//var/obj/M in world)
	set category = "Admin"
	set name = "Jump to Obj"

	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/obj/M=input("Jump to Obj") as obj in world
	if(!M.z) return
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = get_turf(M)
	log_admin({"[key_name(usr)] jumped to [M]"})
	alertAdmins("[key_name_admin(usr)] jumped to [M]", 1)


/client/proc/jumptokey()
	set category = "Admin"
	set name = "Jump to Key"

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	var/list/keys = list()
	for(var/client/C)
		keys += C
	var/selection = input("Please, select a player!", "Admin Jumping") as null|anything in keys
	if(!selection)
		return
	var/mob/M = selection:mob

	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	usr.loc = M.loc
	log_admin({"[key_name(usr)] jumped to [key_name(M)]"})
	alertAdmins("[key_name_admin(usr)] jumped to [key_name_admin(M)]", 1)


/client/proc/Getmob(var/mob/M in Players)
	set category = "Admin"
	set name = "Summon"
	set desc = "Summon a mob"
	if(!src.holder)
		src << "Only administrators may use this command."
		return

	if(!M) M=input("Summon Mob") as mob in Players
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = get_turf(usr)
	log_admin({"[key_name(usr)] summon [key_name(M)]"})
	alertAdmins("[key_name_admin(usr)] summon [key_name_admin(M)]", 1)


/client/proc/returnmob(mob/M in Players)
	set category = "Admin"
	set name = "UnSummon"
	set desc = "Return a mob to its previous location"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(!M) M=input("Unsummon Mob") as mob in Players
	if(!M.unSummonX||!M.unSummonY||!M.unSummonZ){src << "This mob does not have coordinates to return to."; return}
	M.loc = locate(M.unSummonX,M.unSummonY,M.unSummonZ)
	M.unSummonX = null
	M.unSummonY = null
	M.unSummonZ = null
	log_admin({"[key_name(usr)] teleported [key_name(M)] to their old location."})
	alertAdmins("[key_name_admin(usr)] teleported [key_name_admin(M)] to their old location.", 1)


mob/proc/XYZTeleport(mob/M in Players)
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!usr.client.holder) return
	usr<<"This will send the mob you choose to a specific xyz location."
	var/xx=input("X Location? Current is [M.x]") as num
	var/yy=input("Y Location? Current is [M.y]") as num
	var/zz=input("Z Location? Current is [M.z]") as num
	switch(input("Are you sure?") in list ("Yes", "No",))
		if("Yes")
			M.unSummonX = M.x
			M.unSummonY = M.y
			M.unSummonZ = M.z
			M.loc=locate(xx,yy,zz)
			logAndAlertAdmins("[key_name_admin(src)] used XYZTeleport on [M] to ([M.x],[M.y],[M.z])",2)


mob/Admin1/verb/SendMob(mob/M in Players)
	set category = "Admin"
	set name ="Send Mob To"
	if(!usr.client.holder)
		src << "Only administrators may use this command."
		return
	var/PP=input("Send [M]...","Send Mob") in list("Send to Spawn", "Send to Player","Send to XYZ","Send to Corpse","Summon","Unsummon","Cancel")
	switch(PP)
		if("Send to Spawn") usr.client.sendToSpawn(M)
		if("Send to Player") usr.client.sendmob(M)
		if("Send to XYZ") usr.XYZTeleport(M)
		if("Send to Area") usr.client.Sendtoarea(M)
		if("Send to Corpse") usr.client.Sendtoobj(M)
		if("Summon") usr.client.Getmob(M)
		if("Unsummon") usr.client.returnmob(M)


/client/proc/Sendtoarea(var/mob/M in Players)//var/area/A in world)
	set desc = "Area to jump to"
	set category = "Admin"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/area/A=input("Send to Area") as area in world
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = pick(get_area_turfs(A))
	log_admin({"[key_name(usr)] sent [M] to [A]"})
	alertAdmins("[key_name_admin(usr)] sent [M] to [A]", 1)


/client/proc/Sendtoobj(var/mob/M in Players)//var/obj/M in world)
	set category = "Admin"
	set name = "Jump to Obj"

	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/list/WList=list()
	for(var/obj/Cookable/B in world) WList+=B
	var/obj/O=input("Send to Corpse") as mob in WList
	if(!O.z) return
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = O.loc
	log_admin({"[key_name(usr)] sent [M] to [O]"})
	alertAdmins("[key_name_admin(usr)] sent [M] to [O]", 1)



/client/proc/sendToSpawn(mob/A in Players)
	set name = "Send to Spawn"
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	A.z = 0
	usr.unSummonX = usr.x
	usr.unSummonY = usr.y
	usr.unSummonZ = usr.z
	A.Location()
	log_admin({"[key_name(src)] sent [key_name(A)] to spawn"})
	alertAdmins("[key_name(src)] sent [key_name(A)] to spawn")

/client/proc/sendmob(var/mob/M in Players)
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	var/mob/A=input("Send to Player") in Players
	M.unSummonX = M.x
	M.unSummonY = M.y
	M.unSummonZ = M.z
	M.loc = A.loc
	log_admin({"[key_name(usr)] teleported [key_name(M)] to [A]"})
	alertAdmins("[key_name_admin(usr)] teleported [key_name_admin(M)] to [A]", 1)
	