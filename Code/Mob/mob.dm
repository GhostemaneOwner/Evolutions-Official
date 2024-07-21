
mob/animate_movement=2
mob/player //The player mob
mob/var/MultikeyApproved=1
var/first_player = FALSE

mob/Login()
	//src << 'title.ogg'
//	if(client.byond_version<world.byond_version)
//		src<<"You are not on the same version as the server. You must change to BYOND version [client.byond_version] to connect. http://www.byond.com/download/"
//		del(src)
//	else src<<"You are on the same version as the server."
//	if(client.byond_build!=world.byond_build) src<<"You are not on the same build as the server. You should update to [client.byond_build]. http://www.byond.com/download/"
//	else src<<"You are on the same build as the server."
	if(src.type==/mob)
		logAndAlertAdmins("[key_name(src)] logged in with the wrong mob type! They have been kicked off. This error has been logged.")
		log_errors("[key_name(src)] LOGGED IN WITH WRONG MOBTYPE IN mob/Login() !")
		alert("Something went wrong and you have the wrong mob type. Please relog or remake.")
		del(src)
		return


	if(src)
		if(src.client)
			if(!src.client.holder)
				if(!global.ItemsLoaded||!global.MapsLoaded)
					src << "This server has not yet finished loading its files. Please wait patiently for a few minutes."
					src << "You have been disconnected."
					del(src)
					return

	while(src && client && !src.HasCreated)	//We sit here until they select a file in load_character
			//winset(src.client,"mapwindow.map1","focus=true")
		sleep(10)


	if(src.HasCreated)
	/*
		if(!src.icon)
			Choose_Login()
			while(src && client && !src.icon)	//We sit here until they select a file in load_character
				//winset(src.client,"mapwindow.map1","focus=true")
				sleep(10)*/
		if(!src)
			return
		if(!real_name&&HasCreated)
			alert("A new 'realname' system has been implemented, please retype your PERMANENT name!")
			Name()
		//Allows storing of memories on a per mob basis

		if(!src.mind)
			src.mind = new /datum/mind
			src.mind.key = src.key
			src.mind.current = src
		src << sound(null)
		src.mind.current = src	//You might say this is backwards :3
//		luminosity = 0
		if(src) if(src.client)
			src.lastKnownIP = src.client.address
			src.computer_id = src.client.computer_id
			src.lastKnownKey = src.key
		if(!Players.Find(src))
				//So when an admin goes back to their body it doesn't log
			if(src==null) return  //If this breaks the stuff below, alter the position of where it occurs in the code.  Added during the Deviant/Xirre/Arch code jam thing.
			if(!src.client) return
				//log_access("[key_name(src)] | [src.client.address ? src.client.address : "localhost"] | [src.client.computer_id ? src.client.computer_id : "unknown" ]", type="LOGIN")	//Don't need to spam log with admins observing
			//No duplicates
			Players += src
		var/list/AG=list()
		var/altsIDd=0
		for(var/mob/player/M in Players) if(M&&M.client&&M!=src)
			if(!locate(M) in AG) if(src.client)
				if(M == src) continue
				if(M.client && M.client.address == src.client.address&&M.client.computer_id!=src.client.computer_id) //if(!M.MultikeyApproved&&!src.MultikeyApproved)
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>IP address</B> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
					altsIDd++
				//	src<<"You are not authorized to use a multikey."
				//	del(src)
				//	return
				else if (M.lastKnownIP && M.lastKnownIP == src.client.address && M.ckey != src.ckey && M.key)
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>IP address</B> as [key_name_admin(M)] did ([key_name_admin(M)] is no longer logged in).", 1)
				if(M.client && M.client.computer_id == src.client.computer_id) if(M.MultikeyApproved!=2&&src.MultikeyApproved!=2)
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
					spawn() alert("You have logged in already with another key, please be sure to read/ask about the server rules regarding the use of multiple keys!")
					if(M.Rank||src.Rank)
						alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has logged in with an alt but currently has a rank. <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
						spawn() alert("Ranks may not have an alt.")
						del(src)
						return
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B> as <A href='?src=\ref[src];priv_msg=\ref[M]'>[key_name_admin(M)]</A>", 1)
				//	src<<"You can not login to multikeys on the same computer."
				//	del(src)
				//	return
					altsIDd++
				else if (M.computer_id && M.computer_id == src.client.computer_id && M.ckey != src.ckey && M.key)
					alertAdminsLogin("<font color='red'><B>Notice:</B> <A href='?src=\ref[src];priv_msg=\ref[src]'>[key_name_admin(src)]</A> has the same <font color='red'><B>computer ID</B> as [key_name_admin(M)] did ([key_name_admin(M)] is no longer logged in).", 1)
				AG+=M

		if(altsIDd>=2) 
			alertAdminsLogin("<font color='red'><B>Notice:</B> [key_name_admin(src)] tried to log in with a third client and was DCd.", 1)
			alert("You may only have one alt.")
			del(src)
			return

		if(src.client) src.client.show_verb_panel=1 // We want them to see the verb panel Skills and Other after they're logged in. Herp Derp.
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		src.overlays -= _overlay
		src.overlays -= 'tk.dmi'
		src.Update_Player()

//		if(global.TestServerOn)
//			src<<"<span class=\"announce\">You have Give Rank</span>"
//			src.client.verbs += /client/proc/Give_Rank
//			src.client.verbs += /mob/verb/Grant_CappedStats
//			src.client.verbs += /mob/verb/Grant_AllSkill_Mastery
		src<<"<span class=\"announce\"><b>If you find bugs, report them. There's a link to the discord in the top left under Help.</b></span>"
	//	log_access("[key_name(src)] || [src.client.computer_id ? src.client.computer_id : "unknown" ]", type="LOGIN")
		src.saveToLog("| ([src.x], [src.y], [src.z]) || [key_name(src)] logs in\n")
		Cancel_Sched_OnLogout(src)
		adminObserve = 0
		RemoveWaterOverlay()
		src.checkSwimming()
	//verbs -= /mob/verb/Skill_Points

/*
mob/observer/Logout()
	Players -= src
	..()*/

mob/Logout()
	RemoveWaterOverlay()
	if(adminDensity)
		adminDensity=0
		density=1
		immortal=0
		invisibility = 0
		icon=last_icon
		client.mob.see_invisible=client.mob.Old_Sight
	reset_view(src)
	LogOffWipeTimer=WipeUpTimer
	RevertAll()
	RemoveWaterOverlay()
	Flight_Land()
	RemoveShadow(src)
	if(RPMode)
		RPMode=0
		overlays-='RPMode.dmi'
	var/image/AA=image('RPMode.dmi',layer=25)
	src.overlays-=AA
	AFKRemove()
	var/image/AAA=image('StatusEffects.dmi',icon_state="Burning", layer =5)
	src.overlays-=AAA
	src.overlays-='Shield, Legendary.dmi'
	for(var/Skill/Misc/Icey_Grip/IG in src) overlays-=IG
	verbs -= /mob/proc/donec
	verbs -= /mob/proc/bodyc
	if(adminObserve||InFusion==1||IsFusion||DontDisconnect)
		Save()	//Just save, don't do anything else
		return

	else
		if(key)
			for(var/Skill/Attacks/SuperExplosiveWave/SEW in src) if(SEW.Using)
				src.move=1
				SEW.Using=0
			for(var/Skill/Attacks/Self_Destruct/SD in src) if(SD.Using)
				src.move=1
				SD.Using=0
			Cancel_Sched_OnLogout(src)
			Players-=src
			orange(12,src) << "[src.name] has logged out."
//			log_access("[key_name(src)]", type="LOGOUT")
			saveToLog("| [key_name(src)] logs out\n")
			for(var/obj/items/I in src)
				if(I.detections)
					I.detections = null
					I.detections = list()
			for(var/Skill/Misc/KiBlade/KB in src) overlays-=KB
			for(var/obj/Magic_Ball/A in src)	//Remove dragonballs from their person
				if(isobj(src.loc))
					var/obj/O = src.loc
					A.loc=O.loc
				else A.loc=loc
			for(var/obj/items/Phylactery/A in src)	//Remove dragonballs from their person
				if(isobj(src.loc))
					var/obj/O = src.loc
					A.loc=O.loc
				else A.loc=loc
			//for(var/obj/Reward_Instance/R in Reward_List) if(R.Reward_Key == src.key) R.IsOnline="No"
			Save()
			if(KOd)
				view(src) << "Their body will disappear in 1 minute."
				alertAdmins("[key_name(src)] logged out while koed.")
				Logged_Out_Body=1
				spawn(600)
					if(src)
						Save()
						if(!client) del(src)
				return
		del(src)
	..()

/mob/Topic(href, href_list)


	if(href_list["prayerrespond"])
		var/mob/M = locate(href_list["prayerrespond"])
		if(M)
			if(!( ismob(M) )) return
			var/t = input("Message:", text("Prayer response"))  as text
			if(!( t )) return
			if(M&&src)
				if(!M.PrayerAnsweredBy&&M.z!=11) if(src.z==11||src.z==10||src.z==9)
					M.PrayerAnsweredBy=src.Signature
					M.PrayerAnsweredDate=Year+(Month/100)
					src.PrayerPoints++

				if(M.PrayerAnsweredBy==src.Signature&&src.z==11&&M.z!=11)
					for(var/obj/Contact/A in src.Contacts) if(A.Signature == M.Signature) if(A.familiarity>=10)
						if(WipeDay>4)
							if(src.PrayerPoints>=50)
								src.ICOut("You feel [M]'s devotion to you has become strong enough to invite yourself into their realm.")
								src.PrayerTPOption(M)
						else src<<"You feel [M]'s devotion to you has become strong enough to eventually invite yourself into their realm. ([5-WipeDay])"
				if(src.z==11||src.z==10||src.z==9) if(M.PrayerAnsweredBy!=src.Signature)
					src.ICOut("Their prayer has already been answered by another.")
					return
				if(src.z==11||src.z==10||src.z==9)
					M.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[src.TextColor]>??? says in prayer, \"[t]\" (<A HREF='?src=\ref[M];prayerrespond=\ref[usr]'>Respond</A>)</span>")
					src.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[src.TextColor]>You say in prayer, \"[t]\" (<A HREF='?src=\ref[M];prayerrespond=\ref[usr]'>Respond</A>)</span>")

				else if(src.z!=11&&src.z!=10&&src.z!=9)
					M.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[src.TextColor]>[src] says in prayer, \"[t]\" (<A HREF='?src=\ref[M];prayerrespond=\ref[usr]'>Respond</A>)</span>")
					//src.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>You say in prayer, \"[t]\"</span>")

					for(var/mob/player/C in hearers(12,src))
						var/SN=0
						if(C==src)SN=1
						for(var/obj/Contact/A in C.Contacts) if(A.Signature == C.Signature) SN=1
						if(!SN) C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[src.TextColor]><b>\[[src.lan]\]</b> ??? says, \"[src.LanguageSay(t,src.lan,src.lan.Mastery,C)]\"</span>")
						if(SN) C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[src.TextColor]><b>\[[src.lan]\]</b> [src.name] says, \"[src.LanguageSay(t,src.lan,src.lan.Mastery,C)]\"</span>")
						if(C.Observer) for(var/mob/player/S in Players) if(C.Observer==S.key)
							S.ICOut("<span class=\"say\"><font size=[S.TextSize] color=[src.TextColor]><b>\[[src.lan]\]</b>(Observe) [src.name] says, \"[src.LanguageSay(t,src.lan,src.lan.Mastery,S)]\"</span>")

					for(var/obj/Contact/A in M.Contacts) if(A.Signature == src.Signature) if(A.familiarity<20) A.familiarity+= pick(0.05,0.1)

				if(findtext(t,src.name)) M.MakeContact(src,1)

				src.saveToLog("<span class=\"telepathy\">You say in prayer to [M], \"[t]\"</span>\n")
				M.saveToLog("<span class=\"telepathy\">[key_name(usr)] prayer: \"[t]\"</span>\n")


	if(href_list["telepathyrespond"])
		var/mob/M = locate(href_list["telepathyrespond"])
		if(M)
			if(!( ismob(M) )) return
			var/t = input("Message:", text("Telepathy response to [M]"))  as text
			if(!( t )) return
			if(M&&src)
				M.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>[usr] says in telepathy, \"[t]\" (<A HREF='?src=\ref[M];telepathyrespond=\ref[usr]'>Respond</A>)</span>")
				src.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>You say in telepathy, \"[t]\"</span>")
				for(var/mob/player/C in view(10,src.loc)) C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[src.TextColor]><b>\[[src.lan]\]</b> *??? [src.name] says, \"[src.LanguageSay(t,src.lan,src.lan.Mastery,C)]\"</span>")
				src.saveToLog("<span class=\"telepathy\">You say in telepathy to [M], \"[t]\"</span>\n")
				M.saveToLog("<span class=\"telepathy\">[key_name(usr)] telepathy: \"[t]\"</span>\n")
	if(href_list["priv_msg"])
		var/mob/M = locate(href_list["priv_msg"])
		if(M)
			if(src)if(src.client.muted)
				src << "You are muted have a nice day"
				return
			if(!( ismob(M) ))
				return
			var/t = input("Message:", text("Private message to [M.key]"))  as text
			if(!( t ))
				return
			if(src.client && src.client.holder)
				M.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM from-<b>[key_name(src, M, 0)]</b>: [t]</span>")
				src.AdminOut("<font color = #0080FF><span class=\"admin\">Admin PM to-<b>[key_name(M, src, 1)]</b>: [t]</span>")
			else
				if(M.client && M.client.holder)
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(src, M, 1)]</b>: [t]</span>")
				else
					M.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM from-<b>[key_name(src, M, 0)]</b>: [t]</span>")
				src.AdminOut("<font color = #0080FF><span class=\"admin\">Reply PM to-<b>[key_name(M, src, 0)]</b>: [t]</span>")
			log_admin("PM: [key_name(src)]->[key_name(M)] : [t]")
			for(var/mob/player/K in world) if(K && K.client && K.client.holder && K.key != src.key && K.key != M.key)
				if(K) K.AdminOut("<font color = #0080FF><b><span class=\"admin\">PM: [key_name(src, K)]->[key_name(M, K)]:</b> [t]</span>")
				else K.HelpOut("<font color = #0080FF><b><span class=\"admin\">PM: [key_name(src, K)]->[key_name(M, K)]:</b> [t]</span>")
	..()
	return





mob/proc/Remove_Duplicate_Moves()
	var/list/Moves=new
	for(var/Skill/O in src) if(!istype(O,/Skill))
		for(var/Skill/Oo in src) if(Oo!=O) if(Oo.type==O.type) del(Oo)
		if(O.type in Moves) del(O)
		else if(O in Moves) del(O)
		else Moves+=O.type
	var/list/Langs=new
	for(var/Language/L in src)
		for(var/Language/Oo in src) if(Oo!=L) if(Oo.type==L.type) if(Oo.ID==L.ID) del(Oo)
		if(L.type in Langs) del(L)
		else if(L in Langs) del(L)
		else Langs+=L.type






mob/proc/Update_Player() // Only called for a new character and a returning character logging in.
	set waitfor=0
	set background=1
	ASSERT(src)
	if(world.realtime-LogTime>80000&&RestedTime<world.realtime)
		if(Race=="Makyo")
			RestedTime=world.realtime+((world.realtime-LogTime)/2.5)
			if(RestedTime>world.realtime+280000)RestedTime=world.realtime+360000
		else
			RestedTime=world.realtime+((world.realtime-LogTime)/4)
			if(RestedTime>world.realtime+280000)RestedTime=world.realtime+280000
	if(InspiredTime-LogTime>0) InspiredTime=world.realtime+(InspiredTime-LogTime)
	if(NewVersion>LastVersionPlayed)src << browse(New_Stuff,"window=updates;size=700x600")
	GiveBodyParts()
	MakyoStar()
	StatRank()
//	Check_Milestones()
	if(LogOffWipeTimer>0) getOfflineMinutes()
//	CatchUpXPCheck()
	Status()
	Contacts()
	Learn()
	if(Race=="Android") ScouterOn=1.#INF
	Age_Update()
	BodyHUD()
//	UpdateStats("All")
	SetStatusOverlays()
	LastVersionPlayed=NewVersion

//	if(Year<1) CapStats(0.5)

	if(src.KOd==0&&src.BPpcnt>100) if(client) spawn(1) PC_Drain()
	if(RoidPower>Base*0.3) RoidPower=Base*0.3
	if(KOd)
		Un_KO()
		KO("(logged in KO'd)")
	if(!lan) for(var/Language/L in src)
		lan=L
		break
	//Tabs = 1
	if(client)
		client.view="[ViewX]x[ViewY]"
		client.show_verb_panel=1
		client.show_map=1
		ScreenConfigure()
	if(Oozaru)
		Oozaru_Revert()
		Oozaru()
	if(Werewolf)
		Werewolf_Revert()
		Werewolf()
	if(BindPower) spawn Bind_Return()
	if(HasPrayerTPd&&z!=11) PrayerTPDrain()
	if(EditingHTML)
		EditingHTML = 0
	AlignmentCalibrate()
	if(Reincarnated) for(var/obj/ReincarnationObj/R in Reincarnations) if(R.name==key) del(R)
	if(src.Lethality == 1) winset(src.client,"LETHAL","is-visible=true")
	if(src.invisibility == 1) winset(src.client,"INVIS","is-visible=true")
	for(var/obj/items/Boxing_Gloves/BG in src) if(BG.suffix=="*Equipped*") winset(src.client,"GLOVES","is-visible=true")
	//for(var/Skill/S in src) S.CDTick(src) obsolete
	CDUpdate()
	overlays+=HealthBar
	overlays+=EnergyBar
	if(!first_player)
		first_player = TRUE
		src << "<b>You are the first player to log in! Congrats!</b>"
		world.log << "Updating world..."
		sleep(150)
		LoadUpdates()
		//NewPortHook()


	spawn(100)
		if(src)
			checkNullTanks()
			checkNullPhylactery()
			if(insideTank) // If they're still being revived
				if(insideTank in glob_ClonTanks) // If the tank they should be revived at still exists
					Clone_Awaken(src,insideTank) // Retrigger the activation
				else
					insideTank=null // FIRST set this to null and THEN trigger death, incase they have another tank.
					if(!Dead)
						src << "Your cloning tank is destroyed!"
						Death(src)
			if(insidePhylactery) // If they're still being revived
				if(insidePhylactery in glob_Phylactery) // If the tank they should be revived at still exists
					Phylactery_Awaken(src,insidePhylactery) // Retrigger the activation
				else
					insidePhylactery=null // FIRST set this to null and THEN trigger death, incase they have another tank.
					if(!Dead)
						src << "Your phylactery is destroyed!"
						Death(src)


/*
* Status_Event creation moved from the Status() proc
* Perhaps this will solve the odd issues we seem to have with double updates.
*/
/*
	if(isnull(src.status_event))
		src.status_event = new(status_scheduler, src)
		status_scheduler.schedule(src.status_event, 12)
*/
/*
Icon_Obj/HaloVP
	icon='HaloVP.dmi'
	layer=MOB_LAYER+1
Icon_Obj/HaloP//evil
	icon='HaloP.dmi'
	layer=MOB_LAYER+1
Icon_Obj/HaloVC//neutral
	icon='HaloVC.dmi'
	layer=MOB_LAYER+1
Icon_Obj/HaloC//neutral
	icon='HaloC.dmi'
	layer=MOB_LAYER+1
Icon_Obj/HaloN//neutral
	icon='HaloN.dmi'
	layer=MOB_LAYER+1

*/
mob/verb/ResetXY()
	set category = null
	usr.pixel_x = 0
	usr.pixel_y = 0
	usr.adjustedX=0
	usr.adjustedY=0
	filters = null

mob/verb/Overlays()
	set category=null//"Other"
	overlays  = null
	underlays = null
	src.alpha=initial(src.alpha)
	if(Dead)
		switch(Alignment)
			if("Very Pure") overlays += image('HaloVP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
			if("Pure") overlays += image('HaloP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
			if("Very Chaotic") overlays += image('HaloVC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
			if("Chaotic")overlays += image('HaloC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
			if("Neutral") overlays += image('HaloN.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
		if(!KeepsBody)
			//if(last_icon) icon = last_icon
			icon='Soul.dmi'
			//src.alpha=180
			/*var/icon/I=new(icon)
			I.Blend(rgb(0,0,0,195),ICON_ADD)
			icon=I*/
		else if(last_icon) icon=last_icon
	else if(last_icon) icon=last_icon
	overlays-=HealthBar
	overlays-=EnergyBar
	overlays+=HealthBar
	overlays+=EnergyBar

mob/verb/Fix_Hair()
	//set category="Other"
	if(!hair) return
	HairAdd()

/*	if(Dead)
		switch(Alignment)
			if("Very Pure") overlays += 'HaloVP.dmi'
			if("Pure") overlays += 'HaloP.dmi'
			if("Very Chaotic") overlays += 'HaloVC.dmi'
			if("Chaotic") overlays += 'HaloC.dmi'
			if("Neutral") overlays += 'HaloN.dmi'
*/

//mob/proc/Percent(A) return "[round(100*(A/(Str+End+Pow+Off+Def+Spd)),0.1)]%"

mob/proc/Knockback(damage as num)
	ASSERT(src)
	Stop_TrainDig_Schedulers()
	for(var/obj/Props/A in view(1,src)) if(A.z) //if(A.type!=/obj/Dust)
		var/Knock_Range=0
		if(BP>=5000000) Knock_Range=1
		if(Knock_Range||get_dir(src,A)==dir)
			if(isnum(A.Health)) A.TakeDamage(src, BP*0.1, "Knockback")//A.Health-=BP*0.1
			if(A.Health<=0)
				SmallCrater(A)
				del(A)
	for(var/turf/A in view(1,src)) if(!A.Water)
		var/Knock_Range=0
		if(BP>=5000000) Knock_Range=1
		if(Knock_Range||get_dir(src,A)==dir) //if(A.density)
			var/Damage=BP*0.1
			if(!A.density) Damage*=0.1
			if(isnum(A.Health)) A.TakeDamage(src, Damage, "Knockback")//A.Health-=Damage
			if(A.Health<=0)
				if(A.density)
					if(src!=0) A.Destroy(src,src.key)
					else A.Destroy("Unknown","Unknown")
					if(damage) return 1
				else if(prob(50)) if(!(icon_state in list("Flight"))) FightingDirt(A)

mob/var/tmp/OpeningDoor=0
mob/Bump(mob/A)
	if(ghostDens_check(src))
		A.density=0
		spawn(5) A.density=1
		return
	if(istype(A,/obj/Warper))
		src<<"Bumped a warper."
		var/obj/Warper/B=A
		loc=locate(B.gotox,B.gotoy,B.gotoz)
		if(B.giveGravity)
			spawn(1)
				BeenGivenStartingGrav=0
				Gravity()
				StartingGrav()
	if(client&&istype(A,/obj/Door)&&!OpeningDoor)
		var/obj/Door/B=A
		for(var/obj/items/Door_Pass/D in src) if(D.Password==B.Password)
			B.Open()
			return
		for(var/obj/items/Advanced_Door_Pass/D in src) if(D.Password==B.Password||D.Password2==B.Password||D.Password3==B.Password)
			B.Open()
			return
		if(B.Password)
			OpeningDoor=1
			var/Guess=input(src,"You must know the password to enter here") as text
			if(B) if(Guess!=B.Password)
				OpeningDoor=0
				return 0
		if(B) B.Open()
		OpeningDoor=0
		return
	if(istype(A,/obj/Ships/Ship))
		var/obj/Ships/Ship/B=A
		if(B.Password)
			var/PA=input(src,"What is this ship's password?") as text
			if(PA!=B.Password)
				src<<"Wrong!"
				return
		if(B.Ship=="Ardent"||B.Ship=="Icebreaker")
			for(var/obj/Airlock/C in world) if(C.Ship==B.Ship)
				if(src.inertia_dir)
					src.inertia_dir=0	//If they entered from space
					src.last_move=null
				loc=locate(C.x,C.y-1,C.z)
		else for(var/obj/Controls/MKIControls/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/Ships/ShipMKII))
		var/obj/Ships/Ship/B=A
		if(B.Password)
			var/PA=input(src,"What is this ship's password?") as text
			if(PA!=B.Password)
				src<<"Wrong!"
				return
		for(var/obj/Controls/MKIIControls/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/Ships/ShipMKIII))
		var/obj/Ships/Ship/B=A
		if(B.Password)
			var/PA=input(src,"What is this ship's password?") as text
			if(PA!=B.Password)
				src<<"Wrong!"
				return
		for(var/obj/Controls/MKIIIControls/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(istype(A,/obj/AndroidShip))
		var/obj/AndroidShip/B=A
		for(var/obj/AndroidAirlock/C in world) if(C.Ship==B.Ship)
			view(src)<<"[src] enters the ship"
			if(src.inertia_dir)
				src.inertia_dir=0	//If they entered from space
				src.last_move=null
			loc=locate(C.x,C.y-1,C.z)
			break
	if(ismob(A)) if(!client|Oozaru)
		MeleeAttack()
		if(sim&&A.Health<=20)
			A<<"Simulator: Simulation cancelled due to safety protocols."
			del(src)
		return
		//if(A&&istype(src,/NPC_AI)&&A.KOd&&prob(1)) spawn A.Death(src)
	if(istype(A,/obj/Planets))
		Bump_Planet(A,src)
		//src.Heart_Virus()
	if(istype(A,/obj/items/Soccer_Ball))
		if(!Flying) step_away(A,src)
	if(istype(A,/obj/Turfs/Glass))
		if(ghostDens_check(src)) return ..()
		else return
	/*if(istype(A,/obj/Door)) if(A.density)
		Bump(A)
		return 0*/
	if(istype(A,/obj/Blocker))
		return
	..()

