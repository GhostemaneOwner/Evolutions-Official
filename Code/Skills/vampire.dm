Skill/Support/Vampire_Infect
	Experience=100
	var/LastUse=-1
	desc="You can use this ability to give someone vampiric abilities, and causes low HP to only reduce BP to 70% instead of 30% but will reduce their Regeneration ticks by 20%. They will also get one charge of Death Regen and some skills and stats. Each infection will drain you of 1000 of your max energy and 10% of your current stats. 1 Year CD."
	verb/Vampire_Infect()
		set category="Skills"
		if(usr.RPMode) return
		if(LastUse+1>WipeDay)
			usr<<"You need to wait until day [LastUse+1]."
			return
		if(usr.BaseMaxKi >= 1500)
			for(var/mob/P in get_step(usr,usr.dir)) if(P.client)
				if(P.KOd==0) switch(input(P,"Do you want [usr] to turn you into a vampire? (1 charge of Death Regen, and causes low HP to only reduce BP to 70% instead of 20% but will reduce their Regeneration ticks by 30%)") in list("No","Yes"))
					if("No") return
				if(P.Vampire)
					usr<<"They are already a vampire"
					return
				if(P.Regenerate||P.Race=="Android"||P.Race=="Majin"||P.AndroidLevel)
					usr<<"They seem to be immune to vampirism."
					return
				usr.BaseMaxKi -= 1000
				view(usr)<<"[usr] bites [P] and turns them into a vampire!"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turns [P] into a vampire \n")
				alertAdmins("[key_name_admin(usr)] has turned [P] into a vampire.")
				usr.BaseStr/= 1.1
				usr.BaseSpd/= 1.1
				usr.BaseEnd/= 1.1
				usr.BaseDef/= 1.1
				usr.BaseOff/= 1.1
				LastUse=WipeDay
				P.Vampire=1
				P.Sterile=1
				P.Vampire_Skills()
				return

Skill/Support/Vampire_Telepathy
	Experience=100
	verb/Vampire_Telepathy()
		set src=usr.contents
		set category="Other"
		set instant=1
		var/message=input("Say what in Vampire Telepathy?") as text
		usr << "<span class=\"telepathy\"><font size=[usr.TextSize]>You say in Vampire Telepathy \"[message]\"</font></span>"
		usr.saveToLog("<span class=\"telepathy\">You say in Vampire Telepathy \"[message]\"</span>\n")
		for(var/mob/player/M in Players)
			if(M.Vampire)
				if(M.seetelepathy) if(M != usr)
					message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
					if(!message)	return
//					log_telepathy("[usr.name]/[usr.key] : [message]\n")
					if(M)  M<< "<span class=\"telepathy\"><font size=[M.TextSize]>[usr] says in Vampire Telepathy, \"[message]\"</font></span>"
				else
					usr << "You are unable to communicate with [M.name]!"

Skill/Support/Drain_Blood
	Experience=100
	var/LastUse = 0
	desc="You may use this in place of an injure when you win a round of combat. This will steal 15% of their max ki and 10% of their decline age to add to your own. It also fully quenches your thirst."
	verb/Drain_Blood(mob/M in get_step(usr,usr.dir))
		set src=usr.contents
		set category="Skills"
		if(usr.RPMode) return
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd)return
		if(M.KOd==0)
			if(WipeDay<LastUse+1)
				usr<<"You cannot use this until day [LastUse+1]"
				return
			if(M.HasWerewolf||M.Vampire||M.Race == "Majin"||M.Race == "Android"||M.Race == "Bio-Android"||M.AndroidLevel)
				usr<<"This doesn't seem to work on them."
				return
			switch(input(M,"[usr] is trying to drain your blood.") in list("Deny","Allow"))
				if("Allow")
					view(usr)<<"[usr] drinks some of [M]'s blood!"
					M << "You feel weaker, as some years off your life are suddenly consumed..."
					var/AbsorbNRG = M.MaxKi*0.15
					var/AbsorbD = M.Decline/10
					usr.Thirst = 0
					usr.BaseMaxKi+=AbsorbNRG
					usr.Decline+=AbsorbD
					M.BaseMaxKi-=AbsorbNRG
					M.Decline-=AbsorbD
					usr.Ki=usr.BaseMaxKi
					alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has drained [key_name(M)]'s blood.")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has drained some of [key_name(M)]'s blood!.\n")
					LastUse=WipeDay
					return
				if("Deny") return
		else if(M.KOd==1)
			if(M.Willpower>30)
				usr<<"They must be at 30 Willpower or below."
				return
			if(WipeDay<LastUse+1)
				usr<<"You cannot use this until day [LastUse+1]"
				return
			if(M.HasWerewolf||M.Vampire||M.Race == "Majin"||M.Race == "Android"||M.Race == "Bio-Android"||M.AndroidLevel)
				usr<<"This doesn't seem to work on them."
				return
			view(usr)<<"[usr] drinks some of [M]'s blood!"
			M << "You feel weaker, as some years off your life are suddenly consumed..."
			var/AbsorbNRG = M.MaxKi*0.15
			var/AbsorbD = M.Decline/10
			usr.Thirst = 0
			usr.BaseMaxKi+=AbsorbNRG
			usr.Decline+=AbsorbD
			M.BaseMaxKi-=AbsorbNRG
			M.Decline-=AbsorbD
			usr.Ki=usr.BaseMaxKi
			alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has drained [key_name(M)]'s blood.")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has drained some of [key_name(M)]'s blood!.\n")
			LastUse=WipeDay
			return

mob/proc/RemoveVampire_Skills()
	if(Vampire>=1)
		if(Vampire==2)
			for(var/X in OGVampireSkills)
				if((X = locate(X) in src))
					src.contents-=X
		for(var/X in VampireSkills)
			if((X = locate(X) in src))
				src.contents-=X
		Vampire=0
		StrMod/= 1.1
		SpdMod/= 1.1
		EndMod/= 1.1
		DefMod/= 1.1
		OffMod/= 1.1
		if(Regenerate) Regenerate=0
		TK = 0

mob/proc/Vampire_Skills()
	if(Vampire==2)
		for(var/X in OGVampireSkills)
			if(!locate(X) in src)
				src.contents+=new X
	for(var/X in VampireSkills)
		if(!locate(X) in src)
			src.contents+=new X
	TK = 1
	Hunger=0
	Fatigue=0
	StrMod*= 1.1
	SpdMod*= 1.1
	EndMod*= 1.1
	DefMod*= 1.1
	OffMod*= 1.1
	Regenerate=1
	Sterile=1
	Remove_Duplicate_Moves()
	