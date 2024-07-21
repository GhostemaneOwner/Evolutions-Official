//Prayers can gain XP now
proc/isclient(client/c)
	return istype(c, /client)

mob/var
	PrayerPoints
	HasPrayerTPd
	LastPrayerTPDrain

	//using this method because I am not too familiar with the Topic() proc and href usage. Plan to improve later
	PrayerAnsweredBy//refreshes on month tick
	PrayerAnsweredDate

mob/verb/Pray()
	set category="Other"
	set instant=1
	set desc="Allows you to pray to other worldly beings for support."
	if(Race=="Android"||Race=="Shinjin"||Race=="Demon"||z==11||z==18)
		usr<<"Your prayers are unheard."
		return

	var/message=input("Say what in prayer?") as text
	if(length(message) < MIN_MESSAGE_LEN)
		return

	message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
	if(!message) return

	for(var/mob/player/M in Players)
		if(M == src)
			continue
		if(M.z==11 || M.z==10 || M.z==18) 
			if(M.Race=="Shinjin"||M.Race=="Demon"||M.Race=="Demigod"||M.Race=="Oni")
			//if(M.z==11||M.z==10)
				M.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[usr.TextColor]>[usr.name] prays, \"[message]\" (<A HREF='?src=\ref[M];prayerrespond=\ref[usr]'>Respond</A>)</font></span>")
				if(findtext(message,name)) M.MakeContact(usr,1)

	for(var/mob/player/C in hearers(12,usr))
		var/SN=0
		if(C==usr)SN=1
		for(var/obj/Contact/A in C.Contacts) if(A.Signature == usr.Signature) SN=1
		if(!SN) C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[src.TextColor]><b>\[[usr.lan]\]</b> ??? says, <span class=\"say\">\"[src.LanguageSay(message,usr.lan,usr.lan.Mastery,C)]\"</span>")
		if(SN) C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[src.TextColor]><b>\[[usr.lan]\]</b> [usr.name] says, <span class=\"say\">\"[src.LanguageSay(message,usr.lan,usr.lan.Mastery,C)]\"</span>")
		if(isclient(C.client))
			C.ICOut("<span class=\"say\"><font size=[C.TextSize] color=[usr.TextColor]><b>\[[usr.lan]\]</b>(Observe) [usr.name] says, <span class=\"say\">\"[LanguageSay(message,usr.lan,usr.lan.Mastery,C)]\"</span>")

	usr.saveToLog("<span class=\"telepathy\">You say in prayer \"[message]\"</span>\n")




mob/proc
	PrayerYoink()//sends Shinjin/Demon that have pray TPd back to the AL
		for(var/mob/player/C in hearers(12,src)) C.ICOut("[src] has suddenly disappeared, perhaps returning to whence they came.")
		if(HasPrayerTPd) Location()
		for(var/Skill/Support/Teleport/T in src) T.LastUse=WipeDay
		for(var/Skill/Support/DemonTeleport/T in src) T.LastUse=WipeDay
		HasPrayerTPd=0
		src.saveToLog("[src] was sent back to the AL (Prayer ran out)")
	PrayerTPDrain()
		if(LastPrayerTPDrain!=Year+(Month/100)&&HasPrayerTPd&&z!=11)
			if(PrayerPoints>50)
				PrayerPoints-=rand(50,75)
			else PrayerPoints=max(0,PrayerPoints-50)
			if(PrayerPoints<=0)
				PrayerPoints=0
				PrayerYoink()
			else LastPrayerTPDrain = Year+(Month/100)
	PrayerTPOption(var/mob/GoTo)
		if(GoTo.z!=11)
			if(src.Confirm("Would you like to use [GoTo]'s devotion to you to enter their realm?")) 
				if(src.isGrabbing)
					GrabRelease()
				src.loc = get_turf(GoTo)
				for(var/mob/player/C in hearers(12,src)) C.ICOut("[src] has suddenly appeared.")
				src.HasPrayerTPd=1
				src.saveToLog("[src] has Prayer TPd to [GoTo]")

