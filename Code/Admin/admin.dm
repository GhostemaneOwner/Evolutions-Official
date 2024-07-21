
/*
var/all_tab_on = 1
var/status_tab_on = 1
var/server_tab_on = 1
var/navigation_tab_on = 1
var/body_tab_on = 1
var/items_tab_on = 1

var/target_tab_on = 1
var/security_tab_on = 1
var/radar_tab_on = 1
var/minimalist_sense_tab_on = 0
var/sense_icons_on = 1
*/

var/sense_tab_on = 1
/obj/admins
	name = "admins"
	var/rank = null
	var/owner = null
	var/level = null
	var/state = 1
	var/listen_Chat = 1
	var/listen_Alerts = 1
	var/listen_Logins = 1
	var/SeeAllPMs=1
	var/SeeIC=0
	//state = 1 for playing : default
	//state = 2 for observing

/client/proc/unban_panel()
	set name = "Unban Panel"
	set category = "Admin"
	if (src.holder)
		src.holder.unbanpanel()
	return
proc/Replace_List()
	var/list/L=new
	for(var/turf/A in view(src)) L+=A
	for(var/obj/O) L+=O
	return L


obj/admins/proc/Replace(atom/A in Replace_List())
	set category="Admin"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/Type=A.type
	var/list/B=new
	B+="Cancel"
	if(isturf(A)) B+=typesof(/turf)
	else B+=typesof(/obj)
	var/atom/C=input("Replace with what?") in B
	if(C=="Cancel") return
	var/Save
	switch(input("Make it save?") in list("No","Yes"))
		if("Yes") Save=1
	for(var/turf/D in block(locate(1,1,usr.z),locate(world.maxx,world.maxy,usr.z)))
		if(D.type==Type)
			if(prob(0.2)) sleep(1)
			var/turf/Q=new C(locate(D.x,D.y,D.z))
			if(Save) Turfs+=Q
		else for(var/obj/E in D)
			if(prob(1)) sleep(1)
			if(E.type==Type)
				var/obj/Q=new C(locate(E.x,E.y,E.z))
				Q.Savable=0
				if(Save) Turfs+=Q
				del(E)
//	file("AdminLog.log")<<"[usr]([usr.key]) replaced turfs at [time2text(world.realtime,"Day DD hh:mm")]\n"

	logAndAlertAdmins("[key_name(usr)] replaced [Type] with [C] and save=[Save] at ([usr.x],[usr.y],[usr.z])",3)


/obj/admins/proc/immreboot(var/reason as text)
	set category = "Admin Other"
	set desc="Reboots the server"
	set name="Reboot"
	if(!reason) reason = "No reason specified!"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(usr.client.holder.level<3)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if( alert("Reboot server?",,"Yes","No") == "No")
		return
	world << "<span class=\"announce\"> <b>Rebooting world!</b> Initiated by Administrator with reason: [reason]</span>"
	log_admin("[key_name(usr)] initiated a reboot.")
	global.rebooting = 1
	SaveWorld()
	world << "<span class=\"announce\">World saved. Rebooting in 5 seconds.</span>"
	sleep(50) // Wait 5 seconds just to be safe
	world.Reboot("Initiated by [usr.key] with reason: [reason]")
	//usr.Save()
	//del(usr)

/obj/admins/proc/Shutdown(var/reason as text)
	set category = "Admin Other"
	set desc="Shut down the server"
	set name="Shutdown"
	if(!reason)
		reason = "No reason specified!"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if( alert("Shut down server?",,"Yes","No") == "No")
		return
	global.rebooting = 1
	world << "<span class=\"announce\"> <b>Shutting down world!</b> Initiated by Administrator with reason: [reason]!</span>"
	log_admin("[key_name(usr)] initiated a shutdown.")
	//file("AdminLog.log")<<"[usr]([usr.key]) initiated a shutdown at [time2text(world.realtime,"Day DD hh:mm")]\n"
	sleep(100)
	SaveWorld()

	//global.ItemsLoaded=0
	//global.MapsLoaded=0
	world << "<span class=\"announce\"> Shutdown in 20 seconds.</span>"
	sleep(100)
	world << "<span class=\"announce\"> Shutdown in 10 seconds.</span>"
	sleep(100)
	//Shutdown()
	world.Del()

/client/proc/EmoteAudit(mob/player/M as mob in world)
	M.LastEmoteAudit=Year
	var/addedMemory = "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key]) audited logs and approved them.<br><hr>"
	M.mind.store_memory(addedMemory)

/client/proc/cmd_admin_subtle_message(mob/player/M as mob in world)
	set category = "Admin"
	set name = "Subtle Message"

	if (!src.holder)
		src << "Only administrators may use this command."
		return

	var/msg = input("Message:", text("IC message to [M.key]")) as text

	if (!msg)
		return
	if (usr.client && usr.client.holder)
		M << "(IC) <span class=\"subtle_message\">[msg]<span>"

	log_admin("SubtlePM: [key_name(usr)] -> [key_name(M)] : [msg]")
	alertAdmins("SubtleMessage: [key_name_admin(usr)] -> [key_name_admin(M)] : [msg]", 1)


/obj/admins/proc/Saveserver()
	set category = "Admin Other"
	set desc="Save the server"
	set name="Save Server"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	world << "<span class=\"announce\"> <b>Saving world!</b> </span>"
	log_admin("[key_name(usr)] initiated a world save.")
	SaveWorld()

/obj/admins/Topic(href, href_list)
	..()
	//Don't allow people to enter html from cmd line
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if (usr.client != src.owner)
		world << "\red [usr.key] has attempted to override the admin panel!"
		log_admin("[key_name(usr)] tried to use the admin panel without authorization.")
		return

	//Mute a player
	if (href_list["mute2"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator"  )))
			var/mob/M = locate(href_list["mute2"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return

				if(M.client.muted || usr.sfIsMuted(M))

					M << "You have been unmuted."
					log_admin("[key_name(usr)] has voiced [key_name(M)].")
					alertAdmins("[key_name_admin(usr)] has unmuted [key_name_admin(M)].", 1)
					//file("AdminLog.log")<<"[usr]([usr.key] voiced [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
					global.MutedList-="[M.client]"
					global.MutedList-="[usr.sfID(M)]"
					M.client.muted = 0
					//MutedList-="[ckey(M.key)]"
					//usr.sfUnMute(M)
					//world << "<font color=red><b>DEBUG1 :: </font>[M] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"

				else

					var/time = input("Select an amount of time to mute [M.name] (1 = 1 second)","Mute") as num|null
					if( !(time) || time == null)
						src << "You can't have a null time!"
						return
					var/reason = input("Why are you muting [M.name] ? (This may be left blank.)","Reason") as text|null
					if( !(reason) || reason == "" || reason == null)
						reason = "Unknown."
					global.MutedList["[M.client]"] = (world.realtime)+(time*10)

					M << "You have been muted for [time] seconds for the following reason: \"[reason]\"."
					log_admin("[key_name(usr)] has muted [key_name(M)] for [time] seconds for the following reason: \"[reason]\".")
					alertAdmins("[key_name_admin(usr)] has muted [key_name_admin(M)] for [time] seconds for the following reason: \"[reason]\".", 1)
					for (var/client/C)
						if(C.listen_ooc && C != M) C << "<span class=\"announce\">[usr.key] muted [M.key] for [time] seconds for the following reason: \"[reason]\".</span>"
					//file("AdminLog.log")<<"[usr]([usr.key] muted [M] at [time2text(world.realtime,"Day DD hh:mm")] for [time] seconds for the following reason: \"[reason]\"\n"
					spawn() M.client.MutedCheck()
					M.client.muted = 1

				//M.client.muted = !M.client.muted

	//Force a player to say something
	if (href_list["forcespeech"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator"  )))
			var/mob/M = locate(href_list["forcespeech"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return
				var/speech = input("What will [key_name(M)] say?.", "Force speech", "")
				speech = copytext(sanitize(speech), 1, MAX_MESSAGE_LEN)
				if(!speech)
					return
				M.Say(speech)
				log_admin("[key_name(usr)] forced [key_name(M)] to say: [speech]")
				alertAdmins("[key_name_admin(usr)] forced [key_name_admin(M)] to say: [speech]")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if (href_list["jumpto"])
		if((src.rank in list("Owner", , "SeniorAdministrator", "Administrator", "Moderator") ))
			var/mob/M = locate(href_list["jumpto"])
			usr.client.jumptomob(M)
			//file("AdminLog.log")<<"[usr]([usr.key] teleported to [M] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You are not a high enough administrator or you aren't observing!")
			return

	if (href_list["summon"])
		if((src.rank in list("Owner", , "SeniorAdministrator", "Administrator", "Moderator")))
			var/mob/M = locate(href_list["summon"])
			usr.client.Getmob(M)
			//file("AdminLog.log")<<"[usr]([usr.key] summoned [M] [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You are not a high enough administrator or you aren't observing!")
			return

	if (href_list["prom_demot"])
		if((src.rank in list("Owner", , "SeniorAdministrator", "Administrator"  )))
			var/client/C = locate(href_list["prom_demot"])
			if(src != C && C.holder && (C.holder.level >= src.level))
				alert("This cannot be done as [C] is a [C.holder.rank]")
				return
			var/dat = "[C] is a [C.holder ? "[C.holder.rank]" : "non-admin"]<br><br>Change [C]'s rank?<br>"
			if(src.level == 5)
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Owner;client4ad=\ref[C]'>Owner</A><BR>
				<A href='?src=\ref[src];chgadlvl=ProjectManager;client4ad=\ref[C]'>Project Manager</A><BR>
				<A href='?src=\ref[src];chgadlvl=HeadAdministrator;client4ad=\ref[C]'>Head Admin</A><BR>
				<A href='?src=\ref[src];chgadlvl=SeniorAdministrator;client4ad=\ref[C]'>Senior Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 3)
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Administrator;client4ad=\ref[C]'>Administrator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else if(src.level == 2)
				dat += {"
				<A href='?src=\ref[src];chgadlvl=Moderator;client4ad=\ref[C]'>Moderator</A><BR>
				<A href='?src=\ref[src];chgadlvl=Remove;client4ad=\ref[C]'>Remove Admin</A><BR>"}
			else
				alert("This can not be done.")
				return
			usr << browse(dat, "window=prom_demot;size=480x300")
	if (href_list["chgadlvl"])
	//change admin level
		var/rank = href_list["chgadlvl"]
		var/client/C = locate(href_list["client4ad"])
		if(src!=src||!src.rank)
			alert("You are not an admin")
			log_admin("[key_name(usr)] tried to Give or Remove [C]'s adminship")
			alertAdmins("[key_name_admin(usr)] tried to Give or Remove [C]'s adminship", 1)
			return
		if(rank == "Remove")
			C.clear_admin_verbs()
			C.update_admins(null)
			log_admin("[key_name(usr)] has removed [C]'s adminship")
			alertAdmins("[key_name_admin(usr)] has removed [C]'s adminship", 1)
			admins.Remove(C.ckey)
			save_admins()
		else
			C.clear_admin_verbs()
			C.update_admins(rank)
			log_admin("key_name(usr)] has made [C] a [rank]")
			alertAdmins("[key_name_admin(usr)] has made [C] a [rank]", 1)
			admins[C.ckey] = rank
			save_admins()

	//Boot
	if (href_list["boot2"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator"  )))
			var/mob/M = locate(href_list["boot2"])
			if (ismob(M))
				if ((M.client && M.client.holder && (M.client.holder.level >= src.level)))
					alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
					return
				var/reason = input("Why are you booting them?") as text
				if(!reason){usr << "You need a reason to boot someone.";return}
				log_admin("[key_name(usr)] booted [key_name(M)] with reason: \"[reason]\".")
				alertAdmins("[key_name_admin(usr)] booted [key_name_admin(M)] with reason: \"[reason]\".", 1)
				var/punter = M.client.key
				if(M.client){M<<"[usr.key] has booted you with reason: \"[reason]\".";del(M.client)}
				if(M)		{M<<"[usr.key] has booted you with reason: \"[reason]\".";del(M)}
				//file("AdminLog.log")<<"[usr]([usr.key] booted [M] [time2text(world.realtime,"Day DD hh:mm")]"

				for (var/client/C)
					if(C.listen_ooc) C << "<span class=\"announce\">SERVER: [usr.client.key] booted [punter] for the following reason: \"[reason]\".</span>"

	//Bans
	if (href_list["newban"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator","Moderator")))
			var/mob/M = locate(href_list["newban"])
			if(!ismob(M)) return
			if((M.client && M.client.holder && (M.client.holder.level >= src.level)))
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			switch(alert("Temporary Ban?",,"Yes","No"))
				if("Yes")
					var/mins = input(usr,"How long (in hours)?","Ban time",1) as num
					if(!mins)
						return
					if(mins >= 500) mins = 500
					var/reason = input(usr,"Reason?","reason","Griefer") as text
					if(!reason)
						return
					AddBan(M.ckey, M.computer_id, reason, usr.ckey, 1, mins*60)
					M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
					M << "\red This is a temporary ban, it will be removed in [mins] hours."
					//M << "\red To try to resolve this matter head to http://dbzphoenix.proboards.com/index.cgi"
					log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] hours.")
					alertAdmins("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis will be removed in [mins] hours.")
					//file("AdminLog.log")<<"[usr]([usr.key] has temporarily banned [M] for [reason] for [mins] minutes at [time2text(world.realtime,"Day DD hh:mm")]\n"
					usr.client.HttpPost(
						// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
						"https://discordapp.com/api/webhooks/1205050010052329482/FvhR6cCTtborFZ0BVi82fnIUaoq4Yz30TgMnwHQ_03c_n9ynqFdMN6BoqAHVKgQmB3HA",

						list(content = "``` [usr.client.ckey] has banned [M.name]([M.ckey]). \n\n Reason: [reason] \n\n Duration: [mins] hours.```",username = "[usr.client.ckey]"))

					var/punter = M.client.key
					del(M.client)
					del(M)

					for (var/client/C)
						if(C.listen_ooc) C << "<span class=\"announce\">SERVER: [usr.client.key] banned [punter] for [mins] hours for the following reason: \"[reason]\".</span>"

				if("No")
					var/reason = input(usr,"Reason?","reason","Griefer") as text
					if(!reason)
						return
					AddBan(M.ckey, M.computer_id, reason, usr.ckey, 0, 0)
					M << "\red<BIG><B>You have been banned by [usr.client.ckey].\nReason: [reason].</B></BIG>"
					M << "\red This is a permanent ban."
					//M << "\red To try to resolve this matter head to http://dbzphoenix.proboards.com/index.cgi"
					log_admin("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
					alertAdmins("[usr.client.ckey] has banned [M.ckey].\nReason: [reason]\nThis is a permanent ban.")
					//file("AdminLog.log")<<"[usr]([usr.key] has permanently banned [M] for [reason] at [time2text(world.realtime,"Day DD hh:mm")]\n"
					usr.client.HttpPost(
						// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
						"https://discordapp.com/api/webhooks/1205050010052329482/FvhR6cCTtborFZ0BVi82fnIUaoq4Yz30TgMnwHQ_03c_n9ynqFdMN6BoqAHVKgQmB3HA",

						list(
							content = "``` [usr.client.ckey] has banned [M.name]([M.ckey]). \n\n Reason: [reason] \n\n Duration: Permanent. ```",
							username = "[usr.client.ckey]"
						)
					)
					//var/punter = M.client.key
					del(M.client)
					del(M)

	if(href_list["unbanf"])
		var/banfolder = href_list["unbanf"]
		Banlist.cd = "/base/[banfolder]"
		var/key = Banlist["key"]
		if(alert(usr, "Are you sure you want to unban [key]?", "Confirmation", "Yes", "No") == "Yes")
			if (RemoveBan(banfolder))
				unbanpanel()
			else
				alert(usr,"This ban has already been lifted / does not exist.","Error","Ok")
				unbanpanel()

	if(href_list["unbane"])
		UpdateTime()
		var/reason
		var/mins = 0
		var/banfolder = href_list["unbane"]
		Banlist.cd = "/base/[banfolder]"
		var/reason2 = Banlist["reason"]
		var/temp = Banlist["temp"]
		var/minutes = (Banlist["minutes"] - CMinutes)
		if(!minutes || minutes < 0) minutes = 0
		var/banned_key = Banlist["key"]
		Banlist.cd = "/base"

		switch(alert("Temporary Ban?",,"Yes","No"))
			if("Yes")
				temp = 1
				mins = input(usr,"How long (in minutes)? (Default: 1440)","Ban time",minutes ? minutes : 1440) as num
				if(!mins||mins==0||mins<0)
					return
				if(mins >= 525600) mins = 525599
				reason = input(usr,"Reason?","reason",reason2) as text
				if(!reason)
					return
			if("No")
				temp = 0
				reason = input(usr,"Reason?","reason",reason2) as text
				if(!reason)
					return

		log_admin("[key_name(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [GetExp(mins)]")
		alertAdmins("[key_name_admin(usr)] edited [banned_key]'s ban. Reason: [reason] Duration: [GetExp(mins)]", 1)
		Banlist.cd = "/base/[banfolder]"
		Banlist["reason"] << reason
		Banlist["temp"] << temp
		Banlist["minutes"] << (mins + CMinutes)
		Banlist["bannedby"] << usr.ckey
		Banlist.cd = "/base"
		unbanpanel()

	if(href_list["readmind"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator" )))
			var/mob/M = locate(href_list["readmind"])
			if(!M.mind)
				alert("[key_name(M)] has no mind! That is a problem!")
				return
			M.mind.show_memory(usr)
			log_admin("[key_name(usr)] read the player journal of [key_name(M)]")
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if(href_list["heal"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator" )))
			var/mob/M = locate(href_list["heal"])
			if(usr.Confirm("Heal Injuries?"))  for(var/BodyPart/P in M) if(P.Health<=P.MaxHealth) M.Injure_Heal(200,P,1)
			if(M.KOd) M.Un_KO()
			M.Health = M.MaxHealth
			M.Ki = M.MaxKi
			log_admin("[key_name(usr)] healed [key_name(M)]")
			alertAdmins("[key_name(usr)] healed [key_name(M)]")
			//file("AdminLog.log")<<"[usr]([usr.key] healed[M] at [time2text(world.realtime,"Day DD hh:mm")]\n"

		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

	if(href_list["revive"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator" )))
			var/mob/M = locate(href_list["revive"])
			if(M.Dead)
				M.Revive()
				log_admin("[key_name(usr)] revived [key_name(M)]")
				alertAdmins("[key_name(usr)] revived [key_name(M)]")
				//file("AdminLog.log")<<"[usr]([usr.key] revived [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
			else
				alert("[M.name] is not dead!")
				return
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return

//observe
	if(href_list["observe"])
		if ((src.rank in list( "Owner", , "SeniorAdministrator", "Administrator", "Moderator")))
			var/mob/M = locate(href_list["observe"])
			log_admin("[key_name(usr)] has observed [key_name(M)].")
			alertAdmins("[key_name(usr)] has observed [key_name(M)].", 1)
			usr.Get_Observe(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//subtlemessage
	if(href_list["subtlemessage"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["subtlemessage"])
			usr.client.cmd_admin_subtle_message(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//emoteaudit
	if(href_list["emoteaudit"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["emoteaudit"])
			usr.client.EmoteAudit(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return



	if(href_list["givemenu"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["givemenu"])
			usr.client.Give_Other(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//privatemessage
	if(href_list["privatemessage"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["privatemessage"])
			usr.client.cmd_admin_pm(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//giveobj
	if(href_list["giveobj"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["giveobj"])
			usr.client.Give_Object_Menu(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//assess
	if(href_list["assess"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["assess"])
			usr.client.mob.Get_Assess(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//kill
	if(href_list["kill"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["kill"])
			usr.client.Kill(M)
			//file("AdminLog.log")<<"[usr]([usr.key] admin killed [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//knockout
	if(href_list["knockout"])
		var/mob/M = locate(href_list["knockout"])
		usr.client.Knockout(M)
			//file("AdminLog.log")<<"[usr]([usr.key] admin KOed [M] at [time2text(world.realtime,"Day DD hh:mm")]\n"

//send to spawn
	if(href_list["sendToSpawn"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["sendToSpawn"])
			usr.client.sendToSpawn(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//starter boost
	if(href_list["starterboost"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["starterboost"])
			M.GetStarterBoost()
			logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] the [M.Race] [M.Class] a starter boost.",2)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//Ranks tab
	if(href_list["rankstab"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["rankstab"])
			M.RanksTab()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return


//Server tab
	if(href_list["servertab"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["servertab"])
			M.ServerTab()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
/*
//Rewards tab
	if(href_list["rewardstab"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["rewardstab"])
			M.RewardsTab()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
*/
//redo stats
	if(href_list["statredo"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["statredo"])
			M.contents+=new/obj/Redo_Stats
			logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] the [M.Race] [M.Class] Redo Stats.",2)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//Cap Stats
	if(href_list["CapStats"])
		if(src.level >=2)
			var/mob/M = locate(href_list["CapStats"])
			M.CapStats()
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

//alter stats
	if(href_list["alterstats"])
		if(src.level >= 1)
			var/mob/M = locate(href_list["alterstats"])
			usr.client.Reward(M)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return

	if(href_list["XYZTele"])
		if(src.level >=1)
			var/mob/M = locate(href_list["XYZTele"])
			usr<<"This will send the mob you choose to a specific XYZ location."
			var/xx=input("X Location? Current is [M.x]") as num
			var/yy=input("Y Location? Current is [M.y]") as num
			var/zz=input("Z Location? Current is [M.z]") as num
			switch(input(usr, "Are you sure?") in list ("Yes", "No",))
				if("Yes")
					M.loc=locate(xx,yy,zz)
					logAndAlertAdmins("[key_name_admin(usr)] used XYZTeleport on [M] to ([M.x],[M.y],[M.z])",2)
		else
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
//XYZ Playerfor(var/Admin_Help_Object/O in AdminHelps) if(O.UniqueID == "[inID]") AdminHelps.Remove(O)
	if(href_list["adminhelpresolve"])
		if(src.level >=1)
			var/UID = locate(href_list["adminhelpresolve"])
			for(var/Admin_Help_Object/O in AdminHelps) if(O.UniqueID == "[UID]") AdminHelps.Remove(O)
			usr.client.HttpPost(
				// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
				"https://discordapp.com/api/webhooks/1205043469614317578/XLJpoNx_OGxnrC7RBllh5hr3HbCr_1RdfpCUgRKtBmwZM4AQCheAw9tVlBbRdCY3Flkx",

				/*
				[content] is required and can't be blank.
					It's the message posted by the webhook.

				[avatar_url] and [username] are optional.
					They're taken from your key.
					They override the webhook's name and avatar for the post.
				*/
				list(
					content = "``RESOLVED``",
					username = "[UID]"
				)
			)
//Player options
	if (href_list["adminplayeropts"])
		var/mob/M = locate(href_list["adminplayeropts"])
		if(!ismob(M))
			return
		var/dat = "<html><head><title>Options for [M.key]</title></head>"
		var/foo = "\[ "
		if(M.client)
			if(level>=3) foo += text("<A HREF='?src=\ref[src];prom_demot=\ref[M.client]'>Promote/Demote</A> | ")
			//foo += text("<A href='?src=\ref[src];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.client.sfIsMuted(M.client ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[src];mute2=\ref[M]'>Mute: [M.client.muted ? "Muted" : usr.sfIsMuted(M.client) ? "Muted" : "Voiced"]</A> | ")
			foo += text("<A href='?src=\ref[src];givemenu=\ref[M]'>Give Menu</A> | ")
			foo += text("<A href='?src=\ref[src];privatemessage=\ref[M]'>Private Message</A> | ")
			if (Players.Find(M))
				foo += text("<A HREF='?src=\ref[src];observe=\ref[M]'>Watch</A> | ")
				foo += text("<A HREF='?src=\ref[src];sendToSpawn=\ref[M]'>Send to Spawn</A> | ")
				foo += text("<A HREF='?src=\ref[src];assess=\ref[M]'>Assess</A> | ")
				foo += text("<A HREF='?src=\ref[src];giveobj=\ref[M]'>Give Obj</A> | ")
				foo += text("<A HREF='?src=\ref[src];kill=\ref[M]'>Kill</A> | ")
				foo += text("<A HREF='?src=\ref[src];knockout=\ref[M]'>Knockout</A> | ")
//				if(level>=2) foo += text("<A HREF='?src=\ref[src];CapStats=\ref[M]'>Cap Stats</A> | ")
				foo += text("<A HREF='?src=\ref[src];heal=\ref[M]'>Heal</A> | ")
				foo += text("<A HREF='?src=\ref[src];revive=\ref[M]'>Revive</A> | ")
				foo += text("<A HREF='?src=\ref[src];readmind=\ref[M]'>Player Journal</A> | ")
				foo += text("<A HREF='?src=\ref[src];getlog=[M.lastKnownKey];portion=0'>Check Logs</A> | ")
				foo += text("<A HREF='?src=\ref[src];emoteaudit=\ref[M]'>Mark Emote Audit</A> | ")
				foo += text("<A href='?src=\ref[src];subtlemessage=\ref[M]'>IC Message</A> | ")
				foo += text("<A href='?src=\ref[src];summon=\ref[M]'>Summon</A> | ")
				foo += text("<A href='?src=\ref[src];jumpto=\ref[M]'>Jump to</A> | ")
				foo += text("<A href='?src=\ref[src];XYZTele=\ref[M];'>XYZ Teleport</A> | ")
				if(level>=2) foo += text("<A href='?src=\ref[src];command=edit;target=\ref[M];type=view;'>Edit</A> | ")
				//foo += text("<A HREF='?src=\ref[src];starterboost=\ref[M]'>Starter Boost</A> | ")
				//foo += text("<A HREF='?src=\ref[src];statredo=\ref[M]'>Give Redo Stats</A> | ")
				//foo += text("<A HREF='?src=\ref[src];alterstats=\ref[M]'>Alter Stats</A> | ")
		foo += text("<A href='?src=\ref[src];boot2=\ref[M]'>Boot</A> | ")
		foo += text("<A href='?src=\ref[src];newban=\ref[M]'>Ban</A> \]")
		dat += text("<body>[foo]</body></html>")
		usr << browse(dat, "window=adminplayeropts;size=500x130")

/mob/proc/sfIsMuted(var/M)

	//call(/sf_SpamFilter/proc/sf_IsMuted)(M)
	//gSpamFilter.sf_IsMuted(M)
	//if(src==null) src = usr
	if(!M) return FALSE
	M							= src.sfID(M)
	if (!(M in global.MutedList))	return FALSE
	return (global.MutedList[M] > world.realtime)
	return TRUE

/mob/proc/sfID(var/Chatter)
	if ( istype(Chatter,/client) )
		var/client/C	= Chatter
		return ckey(C.key)
	if ( ismob(Chatter) )
		var/mob/M	= Chatter
		return ckey(M.key)
	return null

/mob/proc/sfUnMute(var/M)

//	gSpamFilter.sf_UnMute(M)

	var/id	= src.sfID(M)
	if (id in global.MutedList)
		global.MutedList	-= id
		//world << "<font color=red><b>DEBUG71 :: </font>[M] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b><br>called by [src]"
		M << "<font color=yellow><b>SYSTEM :: </font>You have been unmuted.</b>"
		return TRUE
	//call(/sf_SpamFilter/proc/sf_Unmute)(M)
//	return TRUE


/client/proc/get_admin_state()
	set category = "Admin Other"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	for(var/mob/M in world)
		if(M.client && M.client.holder)
			if(M.client.holder.state == 1)
				src << "[M.key] is playing - [M.client.holder.state]"
			else if(M.client.holder.state == 2)
				src << "[M.key] is observing - [M.client.holder.state]"
			else
				src << "[M.key] is undefined - [M.client.holder.state]"

mob/AdminToggles/verb


	Toggle_LOOC()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/Planets=new
		Planets.Add("Cancel")
		Planets+="Earth"
		Planets+="Namek"
		Planets+="Vegeta"
		Planets+="Arconia"
		Planets+="Ice"
		Planets+="Alien"
		Planets+="DarkPlanet"
		Planets+="Space Station"
		Planets+="The Final Realm"
		Planets+="Android Ship"
		Planets+="Alternate Earth"
		Planets+="EG Tower & Caves"
		Planets+="Space"
		Planets+="Empty Space"
		Planets+="Moons"
		Planets+="HBTC"
		Planets+="Ships/Realms/Majin"
		Planets+="Checkpoint"
		Planets+="Hell"
		Planets+="KS Planet"
		var/Pc=input("Toggle LOOC for what planet?") in Planets
		switch(Pc)
			if("Cancel") return
			if("Earth") looc_1=!looc_1
			if("Namek") looc_2=!looc_2
			if("Vegeta") looc_3=!looc_3
			if("Ice") looc_4=!looc_4
			if("Arconia") looc_5=!looc_5
			if("Dark Planet") looc_6=!looc_6
			if("Space Station") looc_7=!looc_7
			if("The Final Realm") looc_8=!looc_8
			if("Android Ship") looc_9=!looc_9
			if("Alternate Earth") looc_10=!looc_10
			if("EG Tower & Caves") looc_11=!looc_11
			if("Space") looc_12=!looc_12
			if("Empty Space") looc_13=!looc_13
			if("Alien") looc_14=!looc_14
			if("Moons") looc_15=!looc_15
			if("HBTC") looc_16=!looc_16
			if("Ships/Realms/Majin") looc_17=!looc_17
			if("Hell") looc_18=!looc_18
		logAndAlertAdmins("[usr.key] has toggled LOOC for [Pc].",2)
	See_IC_Names()
		set category = "Admin Other"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.SeeIC = !(usr.client.holder.SeeIC)
		if(usr.client.holder.SeeIC)
			src << "You are now viewing IC names in OOC."
		else src << "You are no longer viewing IC names in OOC."
	listen_admin_alerts()
		set category = "Admin Other"
		set name = "(Un)Mute Admin Alerts"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.listen_Alerts = !(usr.client.holder.listen_Alerts)
		if (usr.client.holder.listen_Alerts)
			src << "You are now listening to admin alerts."
		else src << "You are no longer listening to admin alerts."
	ListenAllPMs()
		set category = "Admin Other"
		set name = "(Un)Mute Admin PMs"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.SeeAllPMs = !(usr.client.holder.SeeAllPMs)
		if (usr.client.holder.listen_Alerts)
			src << "You are now listening to Admin PMs."
		else src << "You are no longer listening to Admin PMs."
	listen_admin_logins()
		set category = "Admin Other"
		set name = "(Un)Mute Player Logins"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.listen_Logins = !(usr.client.holder.listen_Logins)
		if (usr.client.holder.listen_Logins)
			src << "You are now listening to player logins."
		else src << "You are no longer listening to player logins."
	listen_admin_chat()
		set category = "Admin Other"
		set name = "(Un)Mute Admin Chat"
		if (!usr.client.holder)
			src << "Only administrators may use this command."
			return
		usr.client.holder.listen_Chat = !(usr.client.holder.listen_Chat)
		if (usr.client.holder.listen_Chat)
			src << "You are now listening to admin chat."
		else src << "You are no longer listening to admin chat but you probably should be."
	/*Show_Rewards_Tab()
		set category = "Admin Other"
		src=usr
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		RewardsTab()*/

	Show_Ranks_Tab()
		set category = "Admin Other"
		src=usr
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		RanksTab()
	Show_Server_Tab()
		set category = "Admin Other"
		src=usr
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		ServerTab()
	Show_Admin_Sense()
		set category="Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.AdminSenseToggle)
			usr.AdminSenseToggle = 0
			usr << "You have made your Admin Sense tab hidden."
			return
		else
			usr.AdminSenseToggle = 1
			usr << "You have made your Admin Sense tab shown."
			return

mob/proc

	RanksTab() if(src.client.holder)
		winclone(src, "GenericSheet", "Ranks")
		winshow(client,"Ranks",1)
		winset(src.client,"Ranks","title=\"Rank Insight\"")
		sleep()
		winset(client,"Ranks.Grid","cells=0x0")
		winset(client,"Ranks.RefreshG","cells=0x0")
		var/Row=0
		Row++
		src << output("Player", "Ranks.Grid:1,[Row]")
		src << output("Name", "Ranks.Grid:2,[Row]")
		src << output("Activity", "Ranks.Grid:3,[Row]")
		//src << output("Online", "Ranks.Grid:4,[Row]")
		src << output("RPs", "Ranks.Grid:4,[Row]")
		for(var/obj/Rank/R in Rankings)
			Row++
			src << output(R, "Ranks.Grid:1,[Row]")
			src << output("[R.Rank_Player_Name] ([R.Rank_Key])", "Ranks.Grid:2,[Row]")
			//src << output("Inactivity - [R.Rank_AFK_Total] seconds", "Ranks.Grid:3,[Row]")
			src << output("[R.Rank_Online=="Yes" ? "Online - [R.Rank_Online]" : "Last Online - [R.Rank_Activity]"]", "Ranks.Grid:3,[Row]")
			src << output("RPs - [R.Rank_RP]", "Ranks.Grid:4,[Row]")
		//Row++
		src<<output("<A HREF='?src=\ref[src.client.holder];rankstab=\ref[src]'>Refresh</A>","Ranks.RefreshG:1,1")
	ServerTab() if(src.client.holder)
		winclone(src, "GenericSheet", "Server")
		winshow(client,"Server",1)
		winset(src.client,"Server","title=\"Server Insight\"")
		sleep()
		winset(client,"Server.Grid","cells=0x0")
		var/Row=0
		Row++
		src << output("Server Information", "Server.Grid:1,[Row]")

		Row++
		var/TP
		for(var/mob/M in Players) TP++
		var/AP
		for(var/mob/M in Players) if(M.afk) AP++
		src << output("Total Players: [TP]", "Server.Grid:1,[Row]")
		src << output("Active Players: [TP-AP]", "Server.Grid:2,[Row]")
		src << output("AFK Players: [AP]", "Server.Grid:3,[Row]")

		Row++
		var/ABP
		var/CC
		var/AB
		for(var/mob/player/M in Players) if(isnum(M.Base)) if(isnum(M.BPMod))
			CC++
			ABP+=M.Base/M.BPMod
			AB+=M.Base
		if(CC)
			ABP/=CC
			AB/=CC
		src << output("Average Base:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(AB))]", "Server.Grid:2,[Row]")
		src << output("[Commas(round(ABP))] x BPMod", "Server.Grid:3,[Row]")
		Row++
		var/BPPer
		var/HBP
		for(var/mob/player/M in Players) if(M.Base>HBP)
			HBP=M.Base
			BPPer=M
		src << output("Highest Base:", "Server.Grid:1,[Row]")
		src << output(BPPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HBP))]", "Server.Grid:2,[Row]")
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		CC=0
		var/ACBP
		for(var/mob/player/M in Players) if(isnum(M.BP))
			CC++
			ACBP+=M.BP
		if(CC) ACBP/=CC
		src << output("Average BP:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(ACBP))]" , "Server.Grid:2,[Row]")
		Row++
		var/CBPPer
		var/HCBP
		for(var/mob/player/M in Players) if(M.BP>HCBP)
			HCBP=M.BP
			CBPPer=M
		src << output("Highest BP:", "Server.Grid:1,[Row]")
		src << output(CBPPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HCBP))]", "Server.Grid:2,[Row]")
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		CC=0
		var/AEN
		var/AE
		for(var/mob/player/M in Players) if(isnum(M.MaxKi))if(isnum(M.KiMod))
			CC++
			AE+=M.BaseMaxKi
			AEN+=M.BaseMaxKi/M.KiMod
		if(CC)
			AEN/=CC
			AE/=CC
		src << output("Average Energy:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(AE))]", "Server.Grid:2,[Row]")
		src << output("[Commas(round(AEN))] x KiMod", "Server.Grid:3,[Row]")
		Row++
		CC=0
		var/ENPer
		var/HEN
		for(var/mob/player/M in Players) if(M.BaseMaxKi>HEN)
			HEN=M.BaseMaxKi
			ENPer=M
		src << output("Highest Energy:", "Server.Grid:1,[Row]")
		src << output(ENPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HEN))]", "Server.Grid:2,[Row]")
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		var/AWS
		for(var/mob/player/M in Players) if(isnum(M.WeightedStats))
			CC++
			AWS+=M.WeightedStats
		if(CC) AWS/=CC
		src << output("Average Weighted Stats:", "Server.Grid:1,[Row]")
		src << output("[Commas(round(AWS))]" , "Server.Grid:2,[Row]")
		Row++
		var/WSPer
		var/HWS
		for(var/mob/player/M in Players) if(M.WeightedStats>HWS)
			HWS=M.WeightedStats
			WSPer=M
		src << output("Highest Weighted Stats:", "Server.Grid:1,[Row]")
		src << output(WSPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HWS))]", "Server.Grid:2,[Row]")
		var/HInt
		var/IPer
		for(var/mob/player/M in Players) if(M.Int_Level>HInt)
			HInt=M.Int_Level
			IPer=M
		var/HMag
		var/MPer
		for(var/mob/player/M in Players) if(M.Magic_Level>HMag)
			HMag=M.Magic_Level
			MPer=M
		CC=0
		var/AveInt
		for(var/mob/player/M in Players) if(M.Int_Level>=20)
			AveInt+=M.Int_Level
			CC++
		if(CC) AveInt/=CC
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		src << output("Average Intelligence:", "Server.Grid:1,[Row]")
		src << output("[round(AveInt,0.5)]" , "Server.Grid:2,[Row]")
		Row++
		src << output("Highest Intelligence:", "Server.Grid:1,[Row]")
		src << output(IPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HInt))]", "Server.Grid:2,[Row]")
		CC=0
		AveInt=0
		for(var/mob/player/M in Players) if(M.Magic_Level>=20)
			AveInt+=M.Magic_Level
			CC++
		if(CC) AveInt/=CC
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		src << output("Average Magic Level:", "Server.Grid:1,[Row]")
		src << output("[round(AveInt,0.5)]" , "Server.Grid:2,[Row]")
		Row++
		src << output("Highest Magic Level:", "Server.Grid:1,[Row]")
		src << output(MPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HMag))]", "Server.Grid:2,[Row]")
		var/HG
		var/GPer
		for(var/mob/player/M in Players) if(M.GainMultiplier>HG)
			HG=M.GainMultiplier
			GPer=M
		CC=0
		var/AGG
		for(var/mob/player/M in world) if(isnum(M.GainMultiplier))
			CC++
			AGG+=M.GainMultiplier
		if(CC) AGG/=CC
		Row++
		src << output("---------------------------------------------------------------------------------------", "Server.Grid:1,[Row]")
		Row++
		src << output("Average Gain Multiplier:", "Server.Grid:1,[Row]")
		src << output("[round(AGG,0.5)]" , "Server.Grid:2,[Row]")
		Row++
		src << output("Highest Gain Multiplier:", "Server.Grid:1,[Row]")
		src << output(GPer , "Server.Grid:3,[Row]")
		src << output("[Commas(round(HG))]", "Server.Grid:2,[Row]")
		//Row++
		src<<output("<A HREF='?src=\ref[src.client.holder];servertab=\ref[src]'>Refresh</A>","Server.RefreshG:1,1")

/client/proc/cmd_admin_pm(mob/player/M as mob in world, t as text)
	set category = "Admin"
	set name = "Admin PM"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(M)
		var/X = M.key
		if(src.muted)
			src << "You are muted have a nice day"
			return
		if (!( ismob(M) ))
			return
		if(!t)t = input("Message:", text("Private message to [X]"))  as text
		if(src.holder.rank != "Owner")
			t = strip_html(t,500)
		if (!( t ))
			return
		if(usr.client && usr.client.holder)
			if(M)
				M.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM from-<b>[key_name(usr, M, 0)]:</b> [t]</span>")
				usr.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM to-<b>[key_name(M, usr, 1)]:</b> [t]</span>")
		else
			if(M)
				if(M.client && M.client.holder)
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(usr, M, 1)]:</b> [t]</span>")
				else
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(usr, M, 0)]:</b> [t]</span>")
				usr.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM to-<b>[key_name(M, usr, 0)]:</b> [t]</span>")

		log_admin("PM: [key_name(usr)]->[key_name(M)] : [t]")
		for(var/mob/K in Players)	//we don't use alertAdmins here because the sender/receiver might get it too
			if(K && K.client && K.client.holder && K.client.holder.listen_Chat && K.key != usr.key && K.key != M.key)
				if(K.client.holder.SeeAllPMs) K.AdminOut("<font color = #0080FF><span class=\"admin\"><B>PM: [key_name(usr, K)]-&gt;[key_name(M, K)]:</B> [t]</span>")
				else K.HelpOut("<font color = #0080FF><span class=\"admin\"><B>PM: [key_name(usr, K)]-&gt;[key_name(M, K)]:</B> [t]</span>")

/client/proc/cmd_admin_mute(mob/player/C as mob in world)
	set category = "Admin"
	set popup_menu = 0
	set name = "Mute"
	if(!src.holder)
		alert("Only administrators may use this command.")
		return

	if(!ismob(C))
		alert("[C] has no mob!")
		return

	if (C.client && C.client.holder && (C.client.holder.level >= src.holder.level))
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return


	if(C.client.muted || usr.sfIsMuted(C))

		C << "You have been unmuted."
		log_admin("[key_name(usr)] has voiced [key_name(C)].")
		alertAdmins("[key_name_admin(usr)] has voiced [key_name_admin(C)].", 1)
		//file("AdminLog.log")<<"[usr]([usr.key] voiced [C] at [time2text(world.realtime,"Day DD hh:mm")]\n"
		global.MutedList-="[C.client]"
		global.MutedList-="[usr.sfID(C)]"
		C.client.muted = 0
		//usr.sfUnMute(C)
		//world << "<font color=red><b>DEBUG2 :: </font>[C] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"

	else
		var/time = input("Select an amount of time to mute [C.name] (1 = 1 second)","Mute") as num|null
		var/reason = input("Why are you muting [C.name] ? (This may be left blank.)","Reason") as text|null

		if( !(time) || time == null)
			src << "You can't have a null time!"
			return
		if( !(reason) || reason == "" || reason == null)
			reason = "Unknown."
		global.MutedList["[C.client]"] = (world.realtime)+(time*10)

		C << "You have been muted for [time] seconds for the following reason: \"[reason]\"."
		log_admin("[key_name(usr)] has muted [key_name(C)] for [time] seconds for the following reason: \"[reason]\".")
		alertAdmins("[key_name_admin(usr)] has muted [key_name_admin(C)] for [time] seconds for the following reason: \"[reason]\".", 1)
		for (var/client/P)
			if(P.listen_ooc && P != C) P << "<span class=\"announce\">[usr.client.key] muted [C.client.key] for [time] seconds for the following reason: \"[reason]\".</span>"
		//file("AdminLog.log")<<"[usr]([usr.key] muted [C] at [time2text(world.realtime,"Day DD hh:mm")] for [time] seconds for the following reason: \"[reason]\"\n"
		spawn() C.client.MutedCheck()
		C.client.muted = 1

	//C.client.muted = !C.client.muted

/client/proc/allow_rares(var/client/C as mob in world) // Yes. WORLD. Incase they havn't made a character yet.
	set category = "Admin"
	set name = "Allow Rares"
	set popup_menu = 0
	set desc = "Allow this particulair player to chose a rare race."
	if(!ismob(C))
		return
	if(!src.holder)
		alert("Only administrators may use this command.")
		return
	if(src.holder.level < 2)
		alert("Only administrators may use this command.")
		return
	if(!AllowRares)AllowRares=new
	if(C.ckey in AllowRares)
		AllowRares-=C.ckey
		if(!AllowRares|!AllowRares.len) AllowRares=null
		log_admin("[key_name(usr)] has removed the ability to create any race from [key_name(C)].")
		alertAdmins("[key_name_admin(usr)] has removed the ability to create any race from [key_name(C)].", 1)
		C << "An admin has removed your ability to make all races."
		return
	else AllowRares+=C.ckey
	log_admin("[key_name(usr)] has granted the ability to create any race to [key_name(C)].")
	alertAdmins("[key_name_admin(usr)] has granted the ability to create any race to [key_name(C)].", 1)
	C << "An admin has granted you the ability to make all races. It's assumed you know how to handle this responsibly."

proc/ghostDens_check(atom/A)
	if(istype(A,/mob/player))
		var/mob/player/_player=A
		if(_player.adminDensity) return TRUE
		else return FALSE


mob/proc/VillainCap()
	if(VillainTrain)
		if(Base<TrueBPCap*BPMod*1.05) Base=TrueBPCap*BPMod*1.05
//		if(BaseMaxKi<EnergyHardCap*KiMod) BaseMaxKi=EnergyHardCap*KiMod
		CapStats(1.2)

var
	StarterBoostEnergy
//
mob/proc/GetStarterBoost() if(!GotStarterBoost)
	if(Base<StarterBoostBP*BPMod&&StarterBoostBP*BPMod>FBMAt)
//		FBMAt=1
		FBMCheck()
		Base=StarterBoostBP*BPMod
		usr<<"Starter boost FBM offset applied."
		XP=2500
		TotalXP = 2500
	else if(Base<StarterBoostBP*BPMod) Base=StarterBoostBP*BPMod
	if(BaseMaxKi<StarterBoostEnergy*KiMod) BaseMaxKi=StarterBoostEnergy*KiMod
	CapStats(0.8)
	src<<"You have been granted the starter boost for Year [round(Year)]."
	GotStarterBoost=1


mob/Admin2/verb
	Mass_Revive()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		switch(input("Are you sure you want to mass revive everyone on the server?") in list("No","Yes"))
			if("Yes")
				for(var/mob/player/P in Players)
					if(P.Dead) P.Revive()
					sleep(1)
				logAndAlertAdmins("[src.key] revived everyone.",2)
	Mass_Summon()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		switch(input("Are you sure you want to mass summon everyone on the server?") in list("No","Yes"))
			if("Yes")
				for(var/mob/player/P in Players)
					P.unSummonX = P.x
					P.unSummonY = P.y
					P.unSummonZ = P.z
					P.loc = get_turf(usr)
				logAndAlertAdmins("[src.key] summoned everyone.",2)
/*	Assign_Builder(mob/M in Players)
		set category = "Admin"
		var/turf/T=input("Choose which turf to assign to [M]") as turf in view(M)
		if(usr.Confirm("Are you sure you want to set [T] and all turf sharing the same builder to be owned by [M]?"))
			for(var/turf/TT in Turfs) if(TT.Builder==T.Builder&&TT!=T)
				TT.Builder="[ckey(M.key)]"
			T.Builder="[ckey(M.key)]"
*/
	Enlarge(atom/A as mob|obj in world)
		set category = "Admin"
		set name = "Enlarge Icon"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!A.icon)
			alert("They don't have an icon to enlarge!")
			return
		var/scale=input(usr,"Scale their icon by what?","Enlarge",1) as num
		A.Enlarge_Icon(scale)
	//	log_admin("[key_name(usr)] used Enlarge Icon on [key_name(A)]")
		alertAdmins("[key_name(usr)] used Enlarge Icon on [key_name(A)]")


	/*Edit_Ranks()
		set category="Admin"
		if(!usr.client.holder || usr.client.holder.level < 2)	//Admin and above
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!WritingRanks)
			WritingRanks = usr
			alertAdmins("[key_name(usr)] is editting the ranks")
			Ranks=input(usr,"Edit!","Edit Ranks",Ranks) as message
			log_admin("[key_name(usr)] is finished editting the ranks")
			alertAdmins("[key_name(usr)] is finished editting the ranks")
			WritingRanks = 0
			SaveRanks()
		else
			alert("[key_name(WritingRanks)] is already editting the ranks!")
			return*/
	Edit_Login_Notes()
		set category="Admin"
		if(!usr.client.holder || (usr.client.holder.level < 2))	//LeadAdmin and above
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!WritingUpdates)
			WritingUpdates = usr
			alertAdmins("[key_name(usr)] is editting the login notes")
			Version_Notes=input(usr,"Edit!","Edit",Version_Notes) as message
			log_admin("[key_name(usr)] is finished editting the login notes")
			alertAdmins("[key_name(usr)] is finished editting the login notes")
			WritingUpdates = 0
			SaveLogin()
		else
			alert("[key_name(WritingUpdates)] is already editting the login notes!")
			return
	Restore_Planet()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/Planets=new
		Planets.Add("Cancel")
		if(!Earth) Planets+="Earth"
		if(!Namek) Planets+="Namek"
		if(!Vegeta) Planets+="Vegeta"
		if(!Arconia) Planets+="Arconia"
		if(!Ice) Planets+="Ice"
		if(!Jungle) Planets+="Jungle"
		if(!Ocean) Planets+="Ocean"
		if(!Desert) Planets+="Desert"
		if(!Alien) Planets+="Alien"
		if(!DarkPlanet) Planets+="DarkPlanet"
		if(!SpaceStation) Planets+="Space Station"
		if(!EarthMoon)Planets+="EarthMoon"
		if(!VegetaMoon)Planets+="VegetaMoon"
		if(!ArconiaMoon)Planets+="ArconiaMoon"
		if(!AlienMoon)Planets+="AlienMoon"
		var/Pc=input("Restore what planet?") in Planets
		switch(Pc)
			if("Cancel") return
			if("Earth") Planet_Restore(1)
			if("Namek") Planet_Restore(2)
			if("Vegeta") Planet_Restore(3)
			if("Arconia") Planet_Restore(5)
			if("Ice") Planet_Restore(4)
			if("Dark Planet") Planet_Restore(6)
			if("Space Station") Planet_Restore(7)
			if("Jungle") Jungle=1
			if("Ocean") Ocean=1
			if("Desert") Desert=1
			if("Alien") Alien=1
			if("EarthMoon")EarthMoon=1
			if("VegetaMoon")VegetaMoon=1
			if("ArconiaMoon")ArconiaMoon=1
			if("AlienMoon")AlienMoon=1
		logAndAlertAdmins("[usr.key] has restored [Pc].",2)
	Destroy_Planet()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/PlanetCs=list()
		if(Alien)PlanetCs+="Alien"
		if(Desert)PlanetCs+="Desert"
		if(Jungle)PlanetCs+="Jungle"
		if(Ocean)PlanetCs+="Ocean"
		if(DarkPlanet) PlanetCs+="DarkPlanet"
		if(Earth) PlanetCs+="Earth"
		if(Namek) PlanetCs+="Namek"
		if(Vegeta) PlanetCs+="Vegeta"
		if(Arconia) PlanetCs+="Arconia"
		if(Ice) PlanetCs+="Ice"
		if(SpaceStation) PlanetCs+="Space Station"
		if(AlienMoon)PlanetCs+="AlienMoon"
		if(EarthMoon)PlanetCs+="EarthMoon"
		if(ArconiaMoon)PlanetCs+="ArconiaMoon"
		if(IceMoon)PlanetCs+="IceMoon"
		if(VegetaMoon)PlanetCs+="VegetaMoon"
		PlanetCs+="Cancel"
		var/Planet=input("Destroy which alien planet or moon?") in PlanetCs
		if(!Confirm("Destroy [Planet]?")) return
		switch(Planet)
			if("Earth")
				Earth=0
				for(var/obj/Planets/Earth/A) del(A)
			if("Namek")
				Namek=0
				for(var/obj/Planets/Namek/A) del(A)
			if("Vegeta")
				Vegeta=0
				for(var/obj/Planets/Vegeta/A) del(A)
			if("Arconia")
				Arconia=0
				for(var/obj/Planets/Arconia/A) del(A)
			if("Ice")
				Ice=0
				for(var/obj/Planets/Ice/A) del(A)
			if("Dark Planet")
				DarkPlanet=0
				for(var/obj/Planets/DarkPlanet/A) del(A)
			if("Space Station")
				SpaceStation=0
				for(var/obj/Planets/SpaceStation/A) del(A)
			if("Alien")
				Alien=0
				for(var/obj/Planets/Alien/A) del(A)
			if("Desert")
				Desert=0
				for(var/obj/Planets/Desert/A) del(A)
			if("Jungle")
				Jungle=0
				for(var/obj/Planets/Jungle/A) del(A)
			if("Ocean")
				Ocean=0
				for(var/obj/Planets/Ocean/A) del(A)
			if("AlienMoon")
				AlienMoon=0
				for(var/obj/Planets/AlienMoon/A) del(A)
			if("EarthMoon")
				EarthMoon=0
				for(var/obj/Planets/EarthMoon/A) del(A)
			if("ArconiaMoon")
				ArconiaMoon=0
				for(var/obj/Planets/ArconiaMoon/A) del(A)
			if("IceMoon")
				IceMoon=0
				for(var/obj/Planets/IceMoon/A) del(A)
			if("VegetaMoon")
				VegetaMoon=0
				for(var/obj/Planets/VegetaMoon/A) del(A)
		log_admin("[key_name(usr)] destroyed [Planet]. (Only deletes planet obj in space)")
		alertAdmins("[key_name_admin(usr)] destroyed [Planet]. (Only deletes planet obj in space)", 1)
	Toggle_Realm_Teleport()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!usr.Confirm("Toggle Global Realm Teleport? Current is [RealmTeleport ? "On" : "Off"]")) return
		else RealmTeleport=!RealmTeleport
		logAndAlertAdmins("[src.key] set Global Realm Teleport to [RealmTeleport ? "On" : "Off"]",2)
	Toggle_Space_Travel()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!usr.Confirm("Toggle Global Space Travel? Current is [SpaceTravel ? "On" : "Off"]")) return
		else SpaceTravel=!SpaceTravel
		logAndAlertAdmins("[src.key] set Global Space Travel to [SpaceTravel ? "On" : "Off"]",2)
/*	SetEnergySoftCap()
		set category = "Gains"
		set name = "Set Energy Soft Cap"
		var/newNRGSoft as num
		if(!newNRGSoft)	//so you can just type int gain NUMBER if you want
			newNRGSoft = input(src,"Set soft cap for Energy. The number you enter will be multplied by the wipe day +500. Current is [(EnergySoft*WipeDay)+500]","Energy Soft Cap",EnergySoft) as num
		if(!newNRGSoft)
			alert("Aborted editting Energy Soft Cap!")
			return
		else
			EnergySoft = newNRGSoft
			alertAdmins("[key_name(usr)] editted the Energy Soft Cap multiplier to [EnergySoft]")
			log_admin("[key_name(usr)] editted the Energy Soft Cap multiplier to [EnergySoft]")
		EnergySoftCap=(EnergySoft*WipeDay)+500
		Save_Gain()
	SetEnergyHardCap()
		set category = "Gains"
		set name = "Set Energy Hard Cap"
		var/newNRGHard as num
		if(!newNRGHard)	//so you can just type int gain NUMBER if you want
			newNRGHard = input(src,"Set hard cap for Energy. The number you enter will be multplied by the wipe day +500. Current is [(EnergyHard*WipeDay)+500]","Energy Hard Cap",EnergyHard) as num
		if(!newNRGHard)
			alert("Aborted editting Energy Hard Cap!")
			return
		else
			EnergyHard = newNRGHard
			alertAdmins("[key_name(usr)] editted the Energy Hard Cap multiplier to [EnergyHard]")
			log_admin("[key_name(usr)] editted the Energy Hard Cap multiplier to [EnergyHard]")
		EnergyHardCap=(EnergyHard*WipeDay)+500
		Save_Gain()*/
/*
	SetStatSoftCap()
		set category = "Gains"
		set name = "Set Stat Soft Cap"
		var/newStatSoft as num
		if(!newStatSoft)	//so you can just type int gain NUMBER if you want
			newStatSoft = input(src,"Set soft cap for Stats. The number you enter will be multplied by the wipe day +400. Current is [400+(StatSoft*round(WipeDay))]","Stat Soft Cap",StatSoft) as num
		if(!newStatSoft)
			alert("Aborted editting Stat Soft Cap!")
			return
		else
			StatSoft = newStatSoft
			alertAdmins("[key_name(usr)] editted the Stat Soft Cap multiplier to [StatSoft]")
			log_admin("[key_name(usr)] editted the Stat Soft Cap multiplier to [StatSoft]")
		SoftStatCap=400+(StatSoft*round(WipeDay,5))
		Save_Gain()*/
/*
	Debug_Soft_Cap()
		set category = "Gains"
		usr << "DEBUG: [SoftStatCap]"*/

	Auto_Announce()
		set category = "Admin"
		set desc="Announce your desires to the world... automatically!"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(autoannounce) if(usr.Confirm("Would you like to cancel the current auto announce?"))
			autoannounce=null
			return
		var/message= input(usr,"Global message to send:", "Auto Announce", autoannounce)  as message
		if(message)
			if(usr.client.holder.rank != "Owner" ) message = adminscrub(message,MAX_MESSAGE_LEN)
			autoannounce=message
			autoannouncedelay=input("How often, in minutes, would you like this to be announced? (30 minutes minimum, 180 minutes maximum)") as num
			autoannouncedelay=round(autoannouncedelay)
			if(autoannouncedelay<30) autoannouncedelay=30
			if(autoannouncedelay>180) autoannouncedelay=180
	Remove_Rares()
		set category= "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		src << "[AllowRares] list is [global.AllowRares.len] long."
		src << "[AllowRares] contains:"
		var/list/rarelist = new
		for(var/I in AllowRares)
			src << "[I]"
			rarelist+=I
		rarelist+="Cancel"
		var/choice = input("Remove who from the rares list?","Rare removal") in rarelist
		switch(choice)
			if("Cancel")
				return
			else
				for(var/i in AllowRares)
					AllowRares-=choice
					src << "You removed; [choice]"
	Force_Liftoff()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/A=input("Choose something to forcibly launch into space!") as mob|obj in view(usr)
		Liftoff(A)

	Scatter_Dragonballs()
		set category="Admin Other"
		if(usr.RPMode) return
		var/Inert=0
		if(usr.Confirm("Would you like them to be inert too?"))Inert=1
		if(usr.z==1|usr.z==2)
			for(var/obj/Magic_Ball/A in DragonBalls) if(A.z)
				spawn
					if(Inert)A.Inert()
					A.Scatter()
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] ADMIN scattered the magic balls on z[usr.z]")
			logAndAlertAdmins("[key_name(usr)] scattered the magic balls on z[usr.z]")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] scatters the magic balls.\n")
		else src<<"You cannot scatter them in here."



var/list/tmp/DEBUGLIST=new // Temporary list

sf_SpamFilter/Phoenix

mob/proc/CapStats(RateOfCap=1)
	if(BaseMaxKi<SoftStatCap*KiMod*RateOfCap) BaseMaxKi=SoftStatCap*KiMod*RateOfCap
	if(BaseStr<SoftStatCap*StrMod*RateOfCap) BaseStr=SoftStatCap*StrMod*RateOfCap
	if(BaseEnd<SoftStatCap*EndMod*RateOfCap) BaseEnd=SoftStatCap*EndMod*RateOfCap
	if(BaseSpd<SoftStatCap*SpdMod*RateOfCap) BaseSpd=SoftStatCap*SpdMod*RateOfCap
	if(BaseOff<SoftStatCap*OffMod*RateOfCap) BaseOff=SoftStatCap*OffMod*RateOfCap
	if(BaseDef<SoftStatCap*DefMod*RateOfCap) BaseDef=SoftStatCap*DefMod*RateOfCap
//	UpdateStats("All")

mob/Admin3/verb
/*	MakeRingOutSensor()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		new/turf/Special/RingOutSensor(usr.loc)*/

	Pop_Up_Alert()
		set category = "Admin Other"
		set waitfor=0
		var/II = input("Pop Up Alert what?") as text
		for(var/mob/player/M in Players) alert(M,"[II]")


	Set_Global_Objective()
		set category = "Admin Other"
		GlobalObjective = input("Please set what you want the global objective to display as.") as text
		alertAdmins("[key_name(usr)] editted the GlobalObjective to [GlobalObjective]")
		log_admin("[key_name(usr)] editted the GlobalObjective to [GlobalObjective]")
		Save_Gain()

	Global_Reset_Cooldowns()
		set category = "Admin"
		if(!usr.Confirm("Really reset all cooldowns?")) return
		for(var/mob/M in Players)
			M.cooldowns = null
		alertAdmins("[key_name(usr)] reset all cooldowns.")
		log_admin("[key_name(usr)] reset all cooldowns.")

	Purge_Drops()
		set category = "Admin"
		if(!usr.Confirm("Really delete every Drop?")) return
		CleanDrops()
		alertAdmins("[key_name(usr)] deleted all drops.")
		log_admin("[key_name(usr)] deleted all drops.")
	Respawn_Ore()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/turf/Terrain/Ground/G in world) if(G.z&&prob(10)) G.OreGenerate()
		log_admin("[key_name(usr)] respawned Ore.")
		alertAdmins("[key_name(usr)] respawned Ore.")
	Respawn_Fish()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		for(var/turf/Terrain/Water/G in world) if(G.z&&prob(50)) G.GenerateFish()
		log_admin("[key_name(usr)] respawned Fish.")
		alertAdmins("[key_name(usr)] respawned Fish.")
	Respawn_NPCs()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		SpawnNPCs()
		log_admin("[key_name(usr)] respawned NPCs.")
		alertAdmins("[key_name(usr)] respawned NPCs.")





	Restrict_Races()
		set category = "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/Choice=input(usr,"Which race would you like to toggle?") in list("Saiyan","Human","Tuffle","Makyo","Spirit Doll","Namekian","Changeling","Android","Oni","Demon","Shinjin","Demigod","Alien","Elite","Heran","Puar","Konatsian","Saibaman","Cerealian","Heeter","Greys","Dragon","Primal","Cancel")
		if(Choice=="Cancel") return
		var/result=5
		switch(Choice)
			if("Saiyan") if(usr.Confirm("Toggle [Choice]? (Currently [AllowSaiyan])"))
				AllowSaiyan=!AllowSaiyan
				result=AllowSaiyan
			if("Tuffle") if(usr.Confirm("Toggle [Choice]? (Currently [AllowTuffle])"))
				AllowTuffle=!AllowTuffle
				result=AllowTuffle
			if("Makyo") if(usr.Confirm("Toggle [Choice]? (Currently [AllowMakyo])"))
				AllowMakyo=!AllowMakyo
				result=AllowMakyo
			if("Spirit Doll") if(usr.Confirm("Toggle [Choice]? (Currently [AllowSD])"))
				AllowSD=!AllowSD
				result=AllowSD
			if("Namekian") if(usr.Confirm("Toggle [Choice]? (Currently [AllowNamek])"))
				AllowNamek=!AllowNamek
				result=AllowNamek
			if("Changeling") if(usr.Confirm("Toggle [Choice]? (Currently [AllowChangeling])"))
				AllowChangeling=!AllowChangeling
				result=AllowChangeling
			if("Android") if(usr.Confirm("Toggle [Choice]? (Currently [AllowAndroid])"))
				AllowAndroid=!AllowAndroid
				result=AllowAndroid
			if("Oni") if(usr.Confirm("Toggle [Choice]? (Currently [AllowOni])"))
				AllowOni=!AllowOni
				result=AllowOni
			if("Demon") if(usr.Confirm("Toggle [Choice]? (Currently [AllowDemon])"))
				AllowDemon=!AllowDemon
				result=AllowDemon
			if("Shinjin") if(usr.Confirm("Toggle [Choice]? (Currently [AllowShinjin])"))
				AllowShinjin=!AllowShinjin
				result=AllowShinjin
			if("Demigod") if(usr.Confirm("Toggle [Choice]? (Currently [AllowDemigod])"))
				AllowDemigod=!AllowDemigod
				result=AllowDemigod
			if("Alien") if(usr.Confirm("Toggle [Choice]? (Currently [AllowAlien])"))
				AllowAlien=!AllowAlien
				result=AllowAlien
			if("Elite") if(usr.Confirm("Toggle [Choice]? (Currently [AllowElite])"))
				AllowElite=!AllowElite
				result=AllowElite
			if("Human") if(usr.Confirm("Toggle [Choice]? (Currently [AllowHuman])"))
				AllowHuman=!AllowHuman
				result=AllowHuman
			if("Heran") if(usr.Confirm("Toggle [Choice]? (Currently [AllowHeran])"))
				AllowHeran=!AllowHeran
				result=AllowHeran
			if("Puar") if(usr.Confirm("Toggle [Choice]? (Currently [AllowPuar])"))
				AllowPuar=!AllowPuar
				result=AllowPuar
			if("Konatsian") if(usr.Confirm("Toggle [Choice]? (Currently [AllowKonatsian])"))
				AllowKonatsian=!AllowKonatsian
				result=AllowKonatsian
			if("Saibaman") if(usr.Confirm("Toggle [Choice]? (Currently [AllowSaibaman])"))
				AllowSaibaman=!AllowSaibaman
				result=AllowSaibaman
			if("Cerealian") if(usr.Confirm("Toggle [Choice]? (Currently [AllowCerealian])"))
				AllowCerealian=!AllowCerealian
				result=AllowCerealian
			if("Heeter") if(usr.Confirm("Toggle [Choice]? (Currently [AllowHeeter])"))
				AllowHeeter=!AllowHeeter
				result=AllowHeeter
			if("Greys") if(usr.Confirm("Toggle [Choice]? (Currently [AllowGreys])"))
				AllowGreys=!AllowGreys
				result=AllowGreys
			if("Dragon") if(usr.Confirm("Toggle [Choice]? (Currently [AllowDragon])"))
				AllowDragon=!AllowDragon
				result=AllowDragon
			if("Primal") if(usr.Confirm("Toggle [Choice]? (Currently [AllowPrimal])"))
				AllowPrimal=!AllowPrimal
				result=AllowPrimal
		if(result!=5) logAndAlertAdmins("[src.key] Toggled [Choice] spawning to [result]",2)




	Toggle_World_OOC()
		set category = "Admin Other"
		set desc="Toggle OOC on and off"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		ooc_allowed = !( ooc_allowed )
		if (ooc_allowed)
			world << "<B>The OOC channel has been globally enabled!</B>"
		else
			world << "<B>The OOC channel has been globally disabled!</B>"
		log_admin("[key_name(usr)] toggled OOC.")
		alertAdmins("[key_name_admin(usr)] toggled OOC.", 1)

	Gain_Mult_Cap()
		set category = "Gains"
		set name = "Set Gain Multiplier Cap"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/newIntGain //as num
		if(!newIntGain)	//so you can just type int gain NUMBER if you want
			newIntGain = input(usr,"Set cap for gain multiplier. Current is [Gain_Mult_Cap]","Gain Multitplier Cap",Gain_Mult_Cap) as num
		if(!newIntGain)
			alert("Aborted editting Gain_Mult_Cap!")
			return
		else
			Gain_Mult_Cap = newIntGain
			alertAdmins("[key_name(usr)] editted the Gain_Mult_Cap to [Gain_Mult_Cap]")
			log_admin("[key_name(usr)] editted the Gain_Mult_Cap to [Gain_Mult_Cap]")

	Strip_Admin()
		set category= "Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/adminlist = new
		var/choicelevel
		src << "adminlist is [admins.len] long"
		for(var/i in admins)
			if(i=="blackclaw185") continue
			if(i=="saizetsu") continue
			if(i=="srteam") continue
			adminlist+=i
			src << "ADMIN: [i] = [admins[i]]"
		adminlist+="Cancel"
		var/choice = input("Remove which Admin?","Admin Removal") in adminlist
		switch(choice)
			if("Cancel")
				return
			else
				for(var/i in admins)
					if(i=="blackclaw185") continue
					if(i=="saizetsu") continue
					if(i=="srteam") continue
					if(i=="[choice]")
						switch(admins[i])
							if("Owner") choicelevel = 5
							if("SeniorAdministrator") choicelevel = 3
							if("Administrator") choicelevel = 2
							if("Moderator") choicelevel = 1
						break
				if(usr.client.holder.level > choicelevel)
					src << "You removed; [choice]"
					admins-=choice
				else
					src << "Their admin level exceeds or equals yours."

proc/AutoAnnounce()
	set waitfor =0
	set background=1
	while(1)
		if(autoannounce) world << "<span class=\"announce\"><b>Evolution (Auto) Announces:</b><br>[autoannounce]</center></span>"
		sleep(600*autoannouncedelay)



mob/Admin3/verb
	/*Change_Base_Refire()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/N = input(usr,"Choose the base refire dividend.  This number is then divided by speed mod, speed mult and other stuff.") as num
		if(N <= 1)
			N = 1
		BaseRefireDiv = N
		log_admin("[key_name(usr)] set the BaseRefireDiv to [BaseRefireDiv].")
		alertAdmins("[key_name(usr)] set the BaseRefireDiv to [BaseRefireDiv].")*/



	Set_Dead_Time()
		set name = "Set Minimum Dead Time"
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr << "Global death times are set for [Dead_Time]."
		var/N = input(usr,"Choose in days how long someone must remain dead before they can be revived. Current is [Dead_Time].") as num
		if(N <= 0)
			N = 1
		Dead_Time = N
		log_admin("[key_name(usr)] set the global death times to [Dead_Time].")
		alertAdmins("[key_name(usr)] set the global death times to [Dead_Time].")
	Toggle_Makyo_Star()
		set category="Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		if(!usr.Confirm("Are you sure you want to toggle the Makyo Star? [MakyoStar ? "On" : "Off"]")) return
		else
			MakyoStar=!MakyoStar
			for(var/mob/M in Players)
				if(M.Race=="Makyojin")
					M.MakyoStar()
			logAndAlertAdmins("[src.key] set Makyo Star to [MakyoStar ? "On" : "Off"]",2)

	Change_Year()
		set category="Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		var/NYear=input("Enter a year. The current is [Year]") as num
		if(!usr.Confirm("Are you sure?")) return
		Year=round(NYear)
		var/Mn=input("Enter a month. 1-12") as num
		if(Mn<2) Mn=1
		if(Mn>12) Mn=12
		Mn=round(Mn)
		Month=Mn
		MonthCycle=1
		logAndAlertAdmins("[src.key] set the year to [YearOutput()]",2)
	Change_Month()
		set category="Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		var/NMonth=input("Enter a month. 1-12") as num
		NMonth=round(NMonth)
		if(NMonth<1) NMonth=1
		if(NMonth>12) NMonth=12
		Month=NMonth
		MonthCycle=1
		logAndAlertAdmins("[src.key] set the month to [Month]",2)
/*	Change_Required_Emotes()
		set category="Gains"
		if(!usr.client.holder||usr.client.holder.level<4) return
		var/NYear=input("Enter a Server Emotes Needed for RP Rewards. The current is [MaxXPReward]") as num
		if(!usr.Confirm("Are you sure?")) return
		MaxXPReward=round(NYear)
		logAndAlertAdmins("[src.key] set the Server Emotes Needed for RP Rewards to [MaxXPReward]",2)*/
	Change_Wipe_Day()
		set category="Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		var/NYear=input("Enter a WipeDay. The current is [WipeDay]") as num
		if(!usr.Confirm("Are you sure?")) return
		WipeDay=round(NYear)
		logAndAlertAdmins("[src.key] set the WipeDay to [WipeDay]",2)
	Change_Power_Control_Cap()
		set category="Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		var/NYear=input("New Power Up cap. (X times Recovery = Max PU) The current is [PowerControlCap]") as num
		if(!usr.Confirm("Are you sure?")) return
		PowerControlCap=NYear
		Save_Gain()
		logAndAlertAdmins("[src.key] set the PowerControlCap to [PowerControlCap]",2)
/*	Set_Energy_Gains()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/newEG=input(usr,"Set Gain Rate for Energy as a percent. Current is [EnergyGainSpeed*100]%","Energy Gain Speed",EnergyGainSpeed*100) as num
		if(!newEG)
			alert("Aborted editting Energy Gain Rate!")
			return
		else
			EnergyGainSpeed = newEG/100
			alertAdmins("[key_name(usr)] editted the Energy Gain Rate to [EnergyGainSpeed*100]%")
			log_admin("[key_name(usr)] editted the Energy Gain Rate to [EnergyGainSpeed*100]%")*/
	Delete_Dragon_Balls()
		set category = "Admin Other"
		if(usr.Confirm("Delete all Dragon Balls?"))
			for(var/obj/Magic_Ball/G in DragonBalls)
				del(G)
			alertAdmins("[key_name_admin(usr)] deleted all Dragon Balls.", 1)
	Respawn_Resources()
		set name = "Respawn Resources"
		set category = "Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		//	alert("You cannot perform this action. You must be of a higher administrative rank!")
		//	return
		switch(input("Are you sure you want to respawn all the resources on all planets?") in list("No","Yes"))
			if("Yes")
				Resources()
				Mana()
				log_admin("[key_name(usr)] respawned all the servers resources on each planet.")
				alertAdmins("[key_name(usr)] respawned all the servers resources on each planet.")
	Set_Planet_Grav()
		set category = "Gains"

		var/list/Planets=list("Earth","Namek","Arconia","Vegeta","Dark Planet","Ice","Hell")
		var/PP=input("Change which planet's gravity?") in Planets
		if(usr.Confirm("Change [PP]s gravity?"))
			var/PN=input("Change [PP]s gravity to what? (1-100)") as num
			if(PN<1) PN=1
			if(PN>100)PN=100
			PN=round(PN)
			if(usr.Confirm("Change [PP]s gravity to [PN]?"))
				if(PP=="Earth")EarthGrav=PN
				if(PP=="Namek")NamekGrav=PN
				if(PP=="Arconia")ArconiaGrav=PN
				if(PP=="Vegeta")VegetaGrav=PN
				if(PP=="Dark Planet")DarkPlanetGrav=PN
				if(PP=="Ice")IceGrav=PN
				if(PP=="Hell")HellGrav=PN
				Save_Gain()
				alertAdmins("[key_name(usr)] editted [PP]s gravity to [PN]")
				log_admin("[key_name(usr)] editted [PP]s gravity to [PN]")
	Toggle_Global_God_Ki_Leeching()
		set category = "Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		//	alert("You cannot perform this action. You must be of a higher administrative rank!")
		//	return
		if(!usr.Confirm("Toggle Global God Ki Leeching? Current is [Global_GodKi]")) return
		else Global_GodKi=!Global_GodKi
		if(Global_GodKi==1) for(var/mob/player/M in Players)
		//	M<<"A deep sensation of power resonates within the bowels of your soul... You feel as though you are leaving the threshold of mortality behind and are ascending into the pinnacle of strength."
			M<<'300OST_30SEC.wav'
		logAndAlertAdmins("[src.key] set Global God Ki Leeching to [Global_GodKi]",2)
	Toggle_Global_God_Ki_Training()
		set category = "Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		//	alert("You cannot perform this action. You must be of a higher administrative rank!")
		//	return
		if(!usr.Confirm("Toggle Global God Ki Training? Current is [Global_GodKiTrain]")) return
		else Global_GodKiTrain=!Global_GodKiTrain
		logAndAlertAdmins("[src.key] set Global God Ki Training to [Global_GodKiTrain]",2)
	Toggle_Global_SSj()
		set category = "Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		//	alert("You cannot perform this action. You must be of a higher administrative rank!")
		//	return
		switch(input("Toggle Which Global SSJ?") in list("Cancel","SSJ 1","SSJ 2","SSJ 3"))
			if("SSJ 1")
				if(!usr.Confirm("Toggle Global SSj? Current is [Global_SSJ]")) return
				else Global_SSJ=!Global_SSJ
				logAndAlertAdmins("[src.key] set Global SSj to [Global_SSJ]",2)
			if("SSJ 2")
				if(!usr.Confirm("Toggle Global SSj 2? Current is [Global_SSJ2]")) return
				else Global_SSJ2=!Global_SSJ2
				logAndAlertAdmins("[src.key] set Global SSj 2 to [Global_SSJ2]",2)
			if("SSJ 3")
				if(!usr.Confirm("Toggle Global SSj 3? Current is [Global_SSJ3]")) return
				else Global_SSJ3=!Global_SSJ3
				logAndAlertAdmins("[src.key] set Global SSj 3 to [Global_SSJ3]",2)
	Toggle_Global_Trans()
		set category = "Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		//	alert("You cannot perform this action. You must be of a higher administrative rank!")
		//	return
		switch(input("Toggle Global Trans? Currently [Global_Trans]") in list("Cancel","Yes"))
			if("Yes")
				if(!usr.Confirm("Toggle Global Trans? Current is [Global_Trans]")) return
				else Global_Trans=!Global_Trans
				logAndAlertAdmins("[src.key] set Global Trans to [Global_Trans]",2)
	Toggle_Global_Ascension()
		set category = "Gains"
		if(!usr.client.holder||usr.client.holder.level<3) return
		//	alert("You cannot perform this action. You must be of a higher administrative rank!")
		//	return
		if(!usr.Confirm("Toggle Global Ascension? Current is [Global_Ascension]")) return
		else Global_Ascension=!Global_Ascension
		logAndAlertAdmins("[src.key] set Global SSGSS to [Global_Ascension]",2)
	SetGlobal_GodKiCap()
		set category = "Gains"
		set name = "Set God Ki Cap"
		var/newGlobal_GodKiCap
		if(!newGlobal_GodKiCap)	//so you can just type int gain NUMBER if you want
			newGlobal_GodKiCap = input(src,"Set the cap for God Ki","God Ki Cap",Global_GodKiCap) as num
		if(!newGlobal_GodKiCap)
			alert("Aborted editting God Ki Cap!")
			return
		else
			Global_GodKiCap = newGlobal_GodKiCap
			alertAdmins("[key_name(usr)] editted the God Ki Cap to [Global_GodKiCap]")
			log_admin("[key_name(usr)] editted the God Ki Cap to [Global_GodKiCap]")

	Set_Resource_Rate()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/YS = input(usr,"Current is [GlobalResourceRate]. The number must be greater than 500'000 and less than 50'000'000. Default is 5'000'000","Resource Gain Rate",GlobalResourceRate) as num
		if(YS<500000) YS=500000
		if(YS>50000000) YS=50000000
		GlobalResourceRate=YS
		log_admin("[key_name(usr)] set GlobalResourceRate to [GlobalResourceRate]")
		alertAdmins("[key_name(usr)] set GlobalResourceRate to [GlobalResourceRate]")
	Set_Year_Speed()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/YS = input(usr,"Current is [Year_Speed]. 1:1 Ratio for minutes in a week of the month. 4 weeks to a month","Year Speed",Year_Speed) as num
		if(YS<1)YS=1
		if(YS>1000)YS=1000
		Year_Speed=YS
		log_admin("[key_name(usr)] set Year Speed to [Year_Speed] minutes per week")
		alertAdmins("[key_name(usr)] set Year Speed to [Year_Speed] minutes per week")
	Int_Gain()
		set category = "Gains"
		set name = "Set Intelligence Gain Multiplier"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/newIntGain
		if(!newIntGain)	//so you can just type int gain NUMBER if you want
			newIntGain = input(usr,"Set a multiplier as a percentage for how fast int_xp is gained. Current is [Admin_Int_Setting*100]%","Intelligence Gain Multiplier",Admin_Int_Setting*100) as num
		if(!newIntGain)
			alert("Aborted editting Int Gain!")
			return
		else
			Admin_Int_Setting = newIntGain/100
			alertAdmins("[key_name(usr)] editted the Int Gain to [Admin_Int_Setting*100]%")
			log_admin("[key_name(usr)] editted the Int Gain to [Admin_Int_Setting*100]%")
	Set_BP_Gain_Multiplier()
		set category = "Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr << "Current BP Gain: [GG/Gain_Divider]%"
		var/New_Gain = input(usr, "Enter the new BP gain multiplier for this server as a percent.","Gain Multiplier",GG/Gain_Divider) as num
		New_Gain = New_Gain*Gain_Divider
		if(!New_Gain)
			alert("Canceled changing gain multiplier!")
			return
		else GG = New_Gain
		log_admin("[key_name(usr)] set the BP Gains Multiplier to [New_Gain/Gain_Divider]%")
		alertAdmins("[key_name(usr)] set the BP Gains Multiplier to [New_Gain/Gain_Divider]%")
	SetStatGains()
		set category = "Gains"
		set name = "Set Stat Gains Multiplier"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr << "Current Stat Gain: [StatGain/Stat_Gain_Divider]%"
		var/New_Gain = input(usr, "Enter the new stat gain multiplier for this server as a percent.","Stat Gain Multiplier",StatGain/Stat_Gain_Divider) as num
		New_Gain=New_Gain*Stat_Gain_Divider
		if(!New_Gain)
			alert("Canceled changing gain multiplier!")
			return
		else StatGain = New_Gain
		log_admin("[key_name(usr)] set the Stat Gains Multiplier to [New_Gain/Stat_Gain_Divider]%")
		alertAdmins("[key_name(usr)] set the Stat Gains Multiplier to [New_Gain/Stat_Gain_Divider]%")
	Set_World_FPS()
		set category = "Admin Other"
		var/NewStatLag = input("Please set your requested FPS") as num
		if(!NewStatLag)
			alert("You did not change FPS")
			return
		else
			world.fps = NewStatLag
			alertAdmins("[key_name(usr)] editted the FPS to [world.fps]")
			log_admin("[key_name(usr)] editted the FPS to [world.fps]")

	Set_Custom_XP_Options()
		set category = "Admin Other"
		CustomXPOptions = input("Please set what you want the XP window to display.") as message
		alertAdmins("[key_name(usr)] editted the CustomXPOptions to [CustomXPOptions]")
		log_admin("[key_name(usr)] editted the CustomXPOptions to [CustomXPOptions]")
		Save_Gain()

	Set_Stat_Lag()
		set category = "Admin Other"
		var/NewStatLag = input("Please set your requested stat lag") as num
		if(!NewStatLag)
			alert("You did not change Stat Lag")
			return
		else
			Stat_Lag = NewStatLag
			alertAdmins("[key_name(usr)] editted the Stat Lag to [Stat_Lag]")
			log_admin("[key_name(usr)] editted the Stat Lag to [Stat_Lag]")
/*	Steal_Icon(atom/A in world)
		set category = "Admin"
		set name = "Steal Icon"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		usr <<ftp(A:icon)
	Satisfaction_Survey()
		set category = "Admin Other"
		var/message = {"Dragon Saga staff value your feedback, please take a moment to fill out this survey and let us know how we are doing so that we can improve! <br><br><a href="https://goo.gl/forms/ZlTn7tFswqCI65Qf2"> Satisfaction Survey </a>"}
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.client.holder.rank != "Owner") message = adminscrub(message,MAX_MESSAGE_LEN)
		world << "<span class=\"announce\"><b>[usr.client.stealth ? "[usr]" : usr.key] Announces:</b><br>[message]</center></span>"
		log_admin("Announce: [key_name(usr)] : [message]")*/

	Set_Ki_Power()
		set category = "Gains"
		var/NewKiPower = input(usr,"Please set your requested Ki Power...Current is (Default is 1)","Ki Power",Ki_Power) as num
		if(!NewKiPower)
			alert("You did not change Ki Power")
			return
		else
			Ki_Power = NewKiPower
			alertAdmins("[key_name(usr)] editted Ki Power to [Ki_Power]")
			log_admin("[key_name(usr)] editted the Ki Power to [Ki_Power]")
/*
	Server_Lock()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action.  You must be of a higher administrative rank!")
		if(usr.Confirm("Do you wish to toggle the Server Lock?")) global.rebooting=!global.rebooting
		if(ckey!="blackclaw185") if(ckey!="saizetsu") return
*/

/*	Live_Patch()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Are you sure?"))
			//PrepareWorld()
		//	world << "<span class=\"announce\"> <b>Saving world!</b> </span>"
		//	log_admin("[key_name(usr)] initiated a world save.")
			//SaveWorld()
			src<<"<b>Live Patch beginning!</b>"
			usr.client.holder.listen_Logins = 1
			src<<"<b>Player login notifications enabled</b>"
			var/NewPort=world.port
			src<<"<b>Current Port is [NewPort]!"
			if(NewPort==25857) NewPort=26482
			else if(NewPort==26482) NewPort=25857
			else if(NewPort==2292) NewPort=8261
			else if(NewPort==8261) NewPort=2292
			else NewPort=""
			var/ServerAddress="byond://[world.internet_address]:[NewPort]" as text
			var/WOR = input(usr,"Choose the BYOND address","Server Address",ServerAddress) as text
			if(usr.Confirm("Are you sure you want to transfer the entire playerbase to [ServerAddress]?")) TransferClients(WOR)
*/
	Terraform()
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/list1=new
		list1+=typesof(/turf)
		var/turf/Choice=input("Replace all turfs with what?") in list1
		for(var/turf/T in block(locate(1,1,z),locate(world.maxx,world.maxy,z)))
			if(prob(1)) sleep(1)
			if(!T.Savable) new Choice(T)
		logAndAlertAdmins("[src.key] used Terraform and replaced with [Choice]",2)
	Open_Server()
		set category="Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Open server?"))
			global.ItemsLoaded=1
			global.MapsLoaded=1
			logAndAlertAdmins("[src.key] has manually OPENED the server. (DEBUG: [global.MapsLoaded]:[global.ItemsLoaded])",2)
	Close_Server()
		set category="Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Close server?"))
			global.ItemsLoaded=0
			global.MapsLoaded=0
			logAndAlertAdmins("[src.key] has manually CLOSED the server. (DEBUG: [global.MapsLoaded]:[global.ItemsLoaded])",2)

	Trigger_God_Ki()
		set category="Gains"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Trigger God Ki?"))
			logAndAlertAdmins("[usr] has triggered God Ki.",2)
			var/The5=5
			Start
			for(var/mob/M in Players) if(!locate(/obj/God_Ki) in M) if(!M.afk) if(prob(2))if(The5) if(M.Race!="Android")
				M<<"You feel an unfamiliar energy within your body... It's hard to describe, but it is unlike anything you have ever felt before.  The only thing you know for certain is that it is powerful..."
				M.MaxGodKi++
				M.contents+=new/obj/God_Ki
				for(var/mob/player/MM in view(15,M)) MM<<'Carl_Orff_35_SEC.wav'
				logAndAlertAdmins("[M] was chosen for God Ki. [The5] remaining",2)
				The5--
			sleep(1)
			if(The5) goto Start
			logAndAlertAdmins("[usr] has finished triggering God Ki.",2)

mob/Admin4/verb/Change_Generic_Requirements()
	set category = "Gains"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/N = input(usr,"Choose the generic requirements.") as num
	if(N <= 1)
		N = 1
	//GenericReq = N
	log_admin("[key_name(usr)] set the GenericReq to [GenericReq].")
	alertAdmins("[key_name(usr)] set the GenericReq to [GenericReq].")
