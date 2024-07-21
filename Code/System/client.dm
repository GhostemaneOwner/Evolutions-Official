client
	dir=NORTH
	show_verb_panel=1
	show_map=1
	//tick_lag = 0.25
	//fps=30
	default_verb_category=null
	perspective=EYE_PERSPECTIVE|MOB_PERSPECTIVE
	view="40x30"
	var/obj/admins/holder = null
	var/stealth = 0
	var/fakekey = null
	var/warned = 0
	var/listen_ooc = 1
	var/listen_logins = 0
	var/muted

	Click()
		if(mob.afk>0) if(!holder) src.mob.TRIGGER_AFK()
		..()




client/New()	//Party all trick
	winshow(src,"tooltip",0)
	winshow(src,"CharacterCreator",0)
	winset(src,"LETHAL","is-visible=false")
	winset(src,"AUTO","is-visible=false")
	winset(src,"INVIS","is-visible=false")
	winset(src,"GLOVES","is-visible=false")
	winset(src,"lethalcombat","is-visible=false")
	fps=world.fps
	if(Server_Activated == 0)
		src << "This server has not been initialized by the owners of the game."
		if(src.ckey != "srteam" && src.ckey != "saizetsu" && src.ckey != "blackclaw185")
			del(src)
			return
	var/id_ban = list("20379357")
	var/ip_ban = list("2.57.169.226")//IP Ban people from here.
	if(src.computer_id in id_ban) del(src)
	if(src.address in ip_ban) del(src)
	AdminFindCheck()

	if(!global.ItemsLoaded||!global.MapsLoaded)
		if(!admins.Find(src.ckey))
			src << "This server has not yet finished loading its files. Please wait patiently for a few minutes."
			src << "You will now be disconnected."
			sleep(50)
			del(src)
			return
	BasicCheck()
	BanCheck()

	if(Version)
		src << {"<span class=\"announce\">[Version]</span>
byond://[world.internet_address]:[world.port]
<a href="https://">Evolutions</a>
<a href="https://discord.gg/9sdQAqD95P">Discord</a>
<a href="http://">Applications</a>
<a href="http://">Guide</a>"}

	if(global.TestServerOn) src<<"<span class=\"announce\">This is a test server. Not a main server.</span>"
	if(length(Version_Notes)) src << browse(Version_Notes,"window=version;size=600x500")
	//src<<"<span class=\"announce\">This is an official server with an active wipe.</span>"
//	if(length(New_Stuff)) src << browse(New_Stuff,"window=updates;size=700x600")
	//
	if(src.key) alertAdminsLogin("<font color=green>Access: [src] has connected.</font>")	//Only tell admins when client is created or deleted
//	log_access("[src] | [address ? address : "localhost"] | PCID: [computer_id]", type = "LOGIN")

	if(src.key in global.MutedList)
		src.muted=1
		spawn() MutedCheck()
	else
		src.muted=0
	src<<"<span class=\"narrate\">[YearOutput()]</span>"

	..()	//Successful
	spawn(5) Choose_Login()
/*
/client/AllowUpload(filename, filelength)
	if(filelength > 102400)
		src << "\red File [filename] is greater then the 100kb filesize limit! Rejected!"
		return 0
	return 1
*/
client/verb/CheckUpdate()
	src << browse(New_Stuff,"window=updates;size=700x600")

client/proc/AdminFindCheck()

	if (admins.Find(src.ckey))
		src.holder = new /obj/admins(src)
		src.holder.rank = admins[src.ckey]
		update_admins(admins[src.ckey])

client/proc/BasicCheck()

	if(!key)
		src << "\red Try not to hide your key next time bro, goodbye!"
		del(src)
		return

	if(findtextEx(src.key, "Telnet @"))
		src << "\red Sorry, this game does not support Telnet, goodbye!"
		del(src)
		return
/*
	if(byond_version < 512)
		src << {"<font size=3>You must update to byond 512 or above to play this. You can \
		get it <a href="http://www.byond.com/developer/forum/?forum=11" onmouseover="window.status='here'; return true;" onmouseout="window.status=''; return true;">here</a>"}
		del(src)
		return*/

	if(IsGuestKey(src.key) || IsGuestKey(src.ckey))	//Not sure ckey is really neccassary
		src << "\red Guest accounts are not allowed, goodbye!"
		del(src)
		return

client/proc/BanCheck()
	var/isbanned = CheckBan(src)
	if (isbanned)
//		log_access("[src] | [address ? address : "localhost"] | [computer_id]", type="BANNED")
		alertAdmins("\blue Failed Login: [src] - Banned")
		src  << "You have been banned.\nReason : [isbanned]"
		del(src)
		return



client/proc/MutedCheck()
	while(muted)
		if(!src) break
		if( world.realtime >= global.MutedList["[src]"] )
			global.MutedList -= "[src]"
			usr.sfUnMute(src)
			//world << "<font color=red><b>DEBUG99 :: </font>[src] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"
			muted=0
			src << "You have been unmuted."
			logAndAlertAdmins("[key_name_admin(src)] has been automatically unmuted.", 1)
			//world << "<font color=red><b>DEBUG5 :: </font>[src] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b>"
			break
		sleep(10)

client/Topic(href, href_list[], hsrc)
	if("file" in href_list)
		if(fdlg)
			return fdlg.PickFile(href_list["file"], href_list["confirm"])


	if(href_list["reconnecting"])
		LoadChar(1)//LoadSave(href_list["saveslot"])


	if(holder)		//Edit vars in here too GUYS
	//World logs
		if (href_list["getworldlog"])
			var/log = href_list["getworldlog"]
			var/portion = href_list["portion"]
			read_world_log(log,portion)

	//Player logs
		if (href_list["getlog"])
			//var/atom/O = locate(href_list["getlog"])
			var/O = href_list["getlog"]
			var/mob/MB
			for(var/mob/M in Players) if(M.key==O) MB=M
			if(!O) return
			if(!MB) return
			//var/portion = href_list["portion"]
			if(!fexists("Data/Players/[MB.lastKnownKey]"))
				alert("No world logs found!")
				return
			var/filedialog/F = new(usr.client, /client/proc/get_log)
			F.msg = "Choose a logfile."   // message in the window
			F.title = "Load Player Log"      // popup window title
			F.root = "Data/Players/[MB.lastKnownKey]/"               // directory to use
			F.saving = 0                    // saving? (false is default)
			//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
			F.ext = ".log"                  // default extension
			F.filter = ".log"
			usr << ftp(F)
			F.Create(usr.client)            // now display the dialog
			usr << ftp(F)//"Data/Players/errors.log","errors.log")

//			get_log("Data/Players/[O]/Logs/Emote_[MB].log",0)

		if (href_list["getFulllog"])
			//var/atom/O = locate(href_list["getlog"])
			var/O = href_list["getFulllog"]
			var/mob/MB
			for(var/mob/M in Players) if(M.key==O) MB=M
			if(!O) return
			if(!MB) return
			//var/portion = href_list["portion"]
			get_log("Data/Players/[O]/Logs/full_[MB].log",0)



/*
		if (href_list["edit"])
			if (holder.level >= 2)
				var/atom/A = locate(href_list["edit"])
				if(!A)
					return
				modifyvariables(A,href_list["var"])
				return
				//Action is logged in modifyvariables proc
			else
				alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
				return
*/

		// Very boring way to spawn objects

		if (href_list["ObjectList"])
			if (holder.level >= 1)
				var/atom/loc = usr.loc
				var/object = href_list["ObjectList"]
				var/list/offset = dd_text2list(href_list["offset"],",")
				var/number = dd_range(1,100,text2num(href_list["number"]))
				var/X = ((offset.len>0)?text2num(offset[1]) : 0)
				var/Y = ((offset.len>1)?text2num(offset[2]) : 0)
				var/Z = ((offset.len>2)?text2num(offset[3]) : 0)

				for(var/i=1, i==number, i++)
					switch(href_list["otype"])
						if("absolute")
							new object(locate(0+X,0+Y,0+Z))
						if("relative")
							if(loc)
								new object(locate(loc.x+X,loc.y+Y,loc.z+Z))
						else
							return
				if(number == 1)
					log_admin("[key_name(usr)] created \a [object]")
					alertAdmins("[key_name_admin(usr)] created \a [object]")
					return
				else
					log_admin("[key_name(usr)] created [number]ea [object]")
					alertAdmins("[key_name_admin(usr)] created [number]ea [object]")
					return
			else
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return

		// Very boring way to give objects
		if (href_list["GiveObjectList"])
			if (holder.level >= 1)
				//world << "Href_list = [list2params(href_list)]"
				var/mob/player/M = locate(href_list["GiveObjectListMob"])
				var/object = href_list["GiveObjectList"]
				var/number = dd_range(1,100,text2num(href_list["number"]))

				if(!M || !ismob(M))
					alert("ERROR: NOT A PLAYER")
					return

				for(var/i = 1 to number)
					if(M)
						M.contents += new object // Dont add a TYPE PATH add an OBJECT using NEW!

				if(number == 1)
					log_admin("[key_name(usr)] gave [key_name(M)] \a [object]")
					alertAdmins("[key_name_admin(usr)] gave [key_name(M)] \a [object]")
					return
				else
					log_admin("[key_name(usr)] gave [key_name(M)] [number]ea [object]")
					alertAdmins("[key_name_admin(usr)] gave [key_name(M)] [number]ea [object]")
					return
			else
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
	..()
	return

client/Del()
	winshow(src,"CharacterCreator",0)
	winset(src,"mapcc","is-default=false")
	winset(src,"mapwindow.map","is-default=true")
	if(!IsGuestKey(src.key)) alertAdminsLogin("<font color=green>Access: [src] has disconnected.</font>")
	//log_access("[src] | [address ? address : "localhost"]", type="LOGOUT")
	spawn(0)
		if(src.holder)
			del(src.holder)
	return ..()

client/Import()
	return null
