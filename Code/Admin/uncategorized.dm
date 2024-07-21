

/*
/client/proc/Unactivate_Server()
	set name = "Deactivate Server"
	set category = "Admin Other"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input(usr, "Are you sure you want to prevent this server from being able to host?") in list("No", "Yes"))
		if("Yes")
			world << "<font color = yellow><font size = 6>[src.key] un-activated the server, disallowing connections from the hosts location."
			Server_Activated = 0
			SaveActivation()
*/
/client/proc/Set_Spawns()
	set category="Gains"
	set name = "Set Spawns"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/list/Choices=new
	Choices.Add("Human","Yardrat","Saiyan","Changeling","Oni","Makyo","Namek","Tuffle","Demigod","Dead People","Heran","Alien","Puar","Kanassan","Konatsian","Shinjin","Demon","Cerealian","Heeter","Greys","Dragon","Primal","GODS-Chosen", "Cancel")

	switch(input("Choose a spawn to set") in Choices)
		if("Cancel")
			return
		if("Dead People")
			var/X = input(usr,"Enter the X location for the dead people spawn.") as num
			var/Y = input(usr,"Enter the Y location for the dead people spawn.") as num
			var/Z = input(usr,"Enter the Z location for the dead people spawn.") as num
			if(!usr.Confirm("Set the Dead People spawn to [X], [Y], [Z]?")) return
			DEADX=X
			DEADY=Y
			DEADZ=Z
			Save_Spawns()
			logAndAlertAdmins("[key_name(usr)] set the Souls spawn to be [X],[Y],[Z].")
		if("Human")
			var/X = input(usr,"Enter the X location for the Human spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Human spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Human spawn.") as num
			HumanSpawn="[X],[Y],[Z]"
		if("Yardrat")
			var/X = input(usr,"Enter the X location for the Yardrat spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Yardrat spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Yardrat spawn.") as num
			YardratSpawn="[X],[Y],[Z]"
		if("Demigod")
			var/X = input(usr,"Enter the X location for the Demigod spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Demigod spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Demigod spawn.") as num
			DemigodSpawn="[X],[Y],[Z]"
		if("Oni")
			var/X = input(usr,"Enter the X location for the Oni spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Oni spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Oni spawn.") as num
			OniSpawn="[X],[Y],[Z]"
		if("Alien")
			var/X = input(usr,"Enter the X location for the Alien spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Alien spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Alien spawn.") as num
			AlienSpawn="[X],[Y],[Z]"
		if("Tuffle")
			var/X = input(usr,"Enter the X location for the Tuffle spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Tuffle spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Tuffle spawn.") as num
			TuffleSpawn="[X],[Y],[Z]"
		if("Namek")
			var/X = input(usr,"Enter the X location for the Namek spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Namek spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Namek spawn.") as num
			NamekianSpawn="[X],[Y],[Z]"
		if("Saiyan")
			var/X = input(usr,"Enter the X location for the Saiyan spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Saiyan spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Saiyan spawn.") as num
			SaiyanSpawn="[X],[Y],[Z]"
		if("Changeling")
			var/X = input(usr,"Enter the X location for the Icer spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Icer spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Icer spawn.") as num
			IcerSpawn="[X],[Y],[Z]"
		if("Heran")
			var/X = input(usr,"Enter the X location for the Heran spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Heran spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Heran spawn.") as num
			HeranSpawn="[X],[Y],[Z]"
		if("Makyo")
			var/X = input(usr,"Enter the X location for the Makyo spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Makyo spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Makyo spawn.") as num
			MakyoSpawn="[X],[Y],[Z]"
		if("Puar")
			var/X = input(usr,"Enter the X location for the Puar spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Puar spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Puar spawn.") as num
			PuarSpawn="[X],[Y],[Z]"
		if("Kanassan")
			var/X = input(usr,"Enter the X location for the Kanassan spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Kanassan spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Kanassan spawn.") as num
			KanassanSpawn="[X],[Y],[Z]"
		if("Konatsian")
			var/X = input(usr,"Enter the X location for the Konats spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Konats spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Konats spawn.") as num
			KonatsianSpawn="[X],[Y],[Z]"
		if("Shinjin")
			var/X = input(usr,"Enter the X location for the Shinjin spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Shinjin spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Shinjin spawn.") as num
			ShinjinSpawn="[X],[Y],[Z]"
		if("Demon")
			var/X = input(usr,"Enter the X location for the Demon spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Demon spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Demon spawn.") as num
			DemonSpawn="[X],[Y],[Z]"
		if("Cerealian")
			var/X = input(usr,"Enter the X location for the Cerealian spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Cerealian spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Cerealian spawn.") as num
			CerealianSpawn="[X],[Y],[Z]"
		if("Heeter")
			var/X = input(usr,"Enter the X location for the Heeter spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Heeter spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Heeter spawn.") as num
			HeeterSpawn="[X],[Y],[Z]"
		if("Greys")
			var/X = input(usr,"Enter the X location for the Greys spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Greys spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Greys spawn.") as num
			GreysSpawn="[X],[Y],[Z]"
		if("Dragon")
			var/X = input(usr,"Enter the X location for the Dragon spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Dragon spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Dragon spawn.") as num
			DragonSpawn="[X],[Y],[Z]"

		if("Primal")
			var/X = input(usr,"Enter the X location for the Primal spawn.") as num
			var/Y = input(usr,"Enter the Y location for the Primal spawn.") as num
			var/Z = input(usr,"Enter the Z location for the Primal spawn.") as num
			PrimalSpawn="[X],[Y],[Z]"
	Save_Spawns()

/*
/client/proc/Wipe_Admin_Logs()
	set category="Admin"
	set name = "Wipe Admin Logs"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	switch(input(usr, "Are you sure you want to wipe all the admin logs?") in list("No", "Yes"))
		if("Yes")
			fdel("AdminLog.log")
			logAndAlertAdmins("[key_name(usr)] has wiped the admin logs.")
*/

/client/proc/Toggle_Global_Rares()
	set name = "Toggle Global Rares"
	set category = "Admin Other"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "Global Rares are currently [Allow_Rares]."
	switch(input("Toggling this off will no longer allow players the chance to roll a rare race.") in list("Off","On"))
		if("On")
			Allow_Rares = "On"
			log_admin({"[key_name(src)] allowed global rares on for all players."})
			alertAdmins("[key_name(src)]  allowed global rares on for all players.")
			return
		if("Off")
			Allow_Rares = "Off"
			log_admin({"[key_name(src)] turned global rares off for all players."})
			alertAdmins("[key_name(src)] turned global rares off for all players.")
			return
/*
/client/proc/Toggle_Global_Reincarnations()
	set name = "Toggle Global Reincarnations"
	set category = "Admin Other"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	usr << "Global reincarnations are currently [Reincarnation_Status]."
	switch(input("Toggling this on will allow players to reincarnate upon death.") in list("Off","On"))
		if("On")
			Reincarnation_Status = "On"
			log_admin({"[key_name(src)] allowed global reincarnations after death for all players.</div>"})
			alertAdmins("[key_name(src)] allowed global reincarnations after death for all players.")
			return
		if("Off")
			Reincarnation_Status = "Off"
			log_admin({"[key_name(src)] prevented global reincarnations after death for all players.</div>"})
			alertAdmins("[key_name(src)] prevented global reincarnations after death for all players.")
			return
*/
/client/proc/narrate(var/message as message)
	set category = "Admin"
	set name = "Narrate"
	set desc = "Narrate to those within 55 tiles of you"
	if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
		message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
	if (message)
		if(usr.client.holder.rank != "Owner") message = adminscrub(message,MAX_MESSAGE_LEN)
		for(var/mob/M in view(usr,55))
			M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
		alertAdmins("[key_name(usr)] used narrate.")

/client/proc/Update_So_Far(var/message as message)
	set category = "Admin"
	set name = "Update So Far"
	set desc = "Narrate to everyone in the game world"
	if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
		message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
	if(message)
		if(usr.client.holder.rank != "Owner") message = adminscrub(message,MAX_MESSAGE_LEN)
		for(var/mob/M in world)
			M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
	alertAdmins("[key_name(usr)] used narrate world to World.")

/client/proc/Narrate_World(var/message as message)
	set category = "Admin"
	set name = "Narrate World"
	set desc = "Narrate to everyone in the game world"
	if(!message)	//Lets you do narrate "stuff" OR narrate -> "bla bla"
		message = input("Narrative message to send:", "Admin Narrate", null, null)  as message
	if(message)
		if(usr.client.holder.rank != "Owner") message = adminscrub(message,MAX_MESSAGE_LEN)
		var/TargetAudience=input("Choose where to Narrate") in list("World","Earth","Alien Planets","Arconia","Changeling","Afterlife","Namek","Vegeta","Dark Planet","Android Planet","Space Station and Space")
		switch(TargetAudience)
			if("World")
				for(var/mob/M in world)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Earth")
				for(var/mob/M in world) if(M.z==1)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Alien Planets")
				for(var/mob/M in world) if(M.z==14)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Arconia")
				for(var/mob/M in world) if(M.z==5)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Changeling")
				for(var/mob/M in world) if(M.z==4)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Afterlife")
				for(var/mob/M in world) if(M.z==8||M.z==10||M.z==11)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Namek")
				for(var/mob/M in world) if(M.z==2)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Vegeta")
				for(var/mob/M in world) if(M.z==3)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Dark Planet")
				for(var/mob/M in world) if(M.z==6)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Android Planet")
				for(var/mob/M in world) if(M.z==9)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
			if("Space Station and Space")
				for(var/mob/M in world) if(M.z==7||M.z==12)
					M.ICOut("<span class=\"narrate\"><font size=[M.TextSize]>[message]</font></span>")
		if(usr.Confirm("Would you like to send the Narration to the Discord?"))
			for(var/part in splittext_limit(message,1750))
				usr.client.HttpPost("https://discordapp.com/api/webhooks/1205047446300786738/3LozBaGGPBQjRTvQJeVZjhk8jAchewwan_ZeNQYhmTJ9-_KiF_gkcpm2wSqNLfX5cjcc",list(content = "**[TargetAudience]:** \n  ```[message] \n``` \n",username = "The Monitor"))
				sleep(10)
		alertAdmins("[key_name(usr)] used narrate world to [TargetAudience].")


	//	log_admin({"[key_name(usr)] turned global rares off for all players.</div>"})



/client/proc/Hubtext()
	set name = "Edit Hubtext"
	set category = "Admin"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	global.HubText=input("Input a message to be displayed on the hub.") as text
	if(!HubText)
		return
	else alertAdmins("[key_name(src)] set the HubText to [global.HubText]")

/client/proc/Knockout(mob/M in world)
	set category = "Admin"
	set name = "Admin KO"
	if (!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/reason = input(src,"Reason") as text
	reason = copytext(sanitize(reason), 1, MAX_MESSAGE_LEN)
	if(!reason)
		reason = "admin"	//fallback
	if(!usr.Confirm("Knockout [M] with reason [reason]?")) return
	M.KO(reason)
	log_admin({"[key_name(src)] knocked out [key_name(M)] with reason \'[reason]\'"})
	alertAdmins("[key_name(src)] knocked out [key_name(M)] with reason \'[reason]\'")

/client/proc/Kill(mob/M in world)
	//set category = "Admin"
	set name = "Admin Kill"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/reason = input(src,"Reason") as text
	reason = copytext(sanitize(reason), 1, MAX_MESSAGE_LEN)
	if(!reason)
		reason = "admin"	//fallback
	if(!usr.Confirm("Kill [M] with reason [reason]?")) return
	M.Death(reason,1)
	log_admin({"[key_name(src)] killed [key_name(M)] with reason \'[reason]\'"})
	alertAdmins("[key_name(src)] killed [key_name(M)] with reason \'[reason]\'")


/client/proc/Delete(atom/A in world)
	set category = "Admin"
	set name = "Delete"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	//Deleting areas fucks stuff up but i guess owners and stuff can do it if they want
	if(isarea(A) && !(src.holder.level >= 5))
		alert("You cannot delete areas! You must be of a higher administrative rank!")
		return
	//Don't let us boot a higher level admin
	if(ismob(A))
		var/mob/M = A
		if (M.client && M.client.holder && (M.client.holder.level >= src.holder.level) && !(M==src))
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return
	if(A)
		switch(input("Are you sure you want to delete [A]?") in list("No","Yes"))
			if("Yes")
				log_admin({"[key_name(src)] deleted [A]"})
				alertAdmins("[key_name(src)] deleted [A]")
				del(A)
			else
				return
	else
		alert("Object doesn't exist anymore!")
		return


/client/proc/Delete_Player_save()
	//set category = "Admin"
	set name = "Del Player Save"
	if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/list/PsDs=list()
	for(var/mob/C in Players) PsDs+=C
	PsDs+="Cancel"
	var/mob/A=input("Delete whose save?") in PsDs
	if(A=="Cancel") return
	if (A.client && A.client.holder && (A.client.holder.level >= src.holder.level) && A != src)
		alert("You cannot delete the save of a higher level admin.", null, null, null, null, null)
		return
	switch(input("Really delete [key_name(A)]'s savefile?") in list("No","Yes"))
		if("Yes")
			log_admin({"[key_name(src)] deleted [key_name(A)]'s savefile"})
			alertAdmins("[key_name(src)] deleted [key_name(A)]'s savefile")
			var/charname = A.real_name
			var/lastkey = A.lastKnownKey
			del(A)
			if(fexists("Data/Players/[lastkey]/Characters/[charname].sav"))
				fcopy("Data/Players/[lastkey]/Characters/[charname].sav","Data/Players/[lastkey]/[charname].deleted")
				fdel("Data/Players/[lastkey]/Characters/[charname].sav")
		if("No")
			alert("Aborted deleting [key_name(A)]'s savefile!")
			return


