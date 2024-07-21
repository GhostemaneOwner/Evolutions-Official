
Skill/Spell/Seance
	Experience=100
	desc="Allows you to summon the spirit of a deceased person to this realm for one year. (5+ familiarity in contacts)"
	verb/Seance()
		set src=usr.contents
		set category="Skills"
		if(usr.z in list(8,11,10,17,16,13,9))
			usr<<"You can't use this here."
			return
		var/list/Tlist=list()
		for(var/mob/AA in Players) if(AA.Dead&&AA.z==11) Tlist+=AA
		Tlist+="Cancel"
		var/mob/M = input("Whose spirit would you like to summon?") in Tlist
		if(M=="Cancel") return
		var/TAL=0
		if(M.z in list(8,11,10,17,16)) TAL=1
		if(!TAL)
			usr<<"You can not find their spirit..."
			return
		else
			usr<<"You locate their spirit..."
			var/Cost = 50000000
			var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
			usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
			if(usr.Confirm("Would you like to summon [M]s spirit to the mortal realm for three months? It will cost [Commas(Actual)] mana."))
				for(var/obj/Mana/MM in usr)
					if(MM.Value > Actual)
						M.loc=usr.loc
						logAndAlertAdmins("[usr] used seance on [M].",1)
						for(var/mob/player/MMM in view(usr)) MMM.BuffOut("[usr] has summoned [M]s spirit!")
						M.SeanceYear=Year+1
						MM.Value -= Actual
					else
						usr<<"Not enough mana."
						return

Skill/Spell/Alter_Perception
	Experience=100
	desc="Allows someone to choose a new name, gender and base icon.  It will also give them a new energy signature. (Gives StatRedo)(This will 'break' other people's contacts with them)"
	verb/Alter_Perception()
		set src=usr.contents
		set category="Skills"
		var/list/Whoers=list()
		for(var/mob/player/P in view(usr)) Whoers+=P
		var/mob/Choice=input("Cast [src] on who?") in Whoers
		var/Cost = 50000000
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
		if(usr.Confirm("Would you like to cast [src] on [Choice]?"))
			switch(alert(Choice,"[usr] wants to cast [src] on you. Allow it?","New Identity","Yes","No"))
				if("Yes")
					for(var/obj/Mana/MM in usr)
						if(MM.Value > Actual)
							logAndAlertAdmins("[usr] used [src] on [Choice].",1)
							for(var/mob/player/MMM in view(usr)) MMM.BuffOut("[usr] has cast [src] on [Choice]!")
							Choice.ChangeIdentity()
							//Choice.contents+=new/obj/Redo_Stats
							MM.Value -= Actual
						else
							usr<<"Not enough mana."
							return

Skill/Technology/Cosmetic_Surgery
	Experience=100
	desc="Allows someone to choose a new name, gender and base icon.  It will also give them a new energy signature. (Gives Stat Redo)(This will 'break' other people's contacts with them)"
	verb/Cosmetic_Surgery()
		set src=usr.contents
		set category="Skills"
		var/list/Whoers=list()
		for(var/mob/player/P in view(usr)) Whoers+=P
		var/mob/Choice=input("Cast [src] on who?") in Whoers
		var/Cost = 50000000
		var/Actual = round(initial(Cost)/usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] resources. Your Int mod means it costs [Commas(Actual)] res for you."
		if(usr.Confirm("Would you like to cast [src] on [Choice]?"))
			switch(alert(Choice,"[usr] wants to cast [src] on you. Allow it?","New Identity","Yes","No"))
				if("Yes")
					for(var/obj/Resources/MM in usr)
						if(MM.Value > Actual)
							logAndAlertAdmins("[usr] used [src] on [Choice].",1)
							for(var/mob/player/MMM in view(usr)) MMM.BuffOut("[usr] has used [src] on [Choice]!")
							Choice.ChangeIdentity()
							//Choice.contents+=new/obj/Redo_Stats
							MM.Value -= Actual
						else
							usr<<"Not enough resources."
							return



Skill/Spell/Advanced_Seance
	Experience=100
	desc="Allows you to summon the spirit of a deceased person to this realm for 2 years and grants them 85% of their power. (20+ familiarity in contacts)"
	verb/Advanced_Seance()
		set src=usr.contents
		set category="Skills"
		if(usr.z in list(8,11,10,17,16,13,9))
			usr<<"You can't use this here."
			return
		var/list/Tlist=list()
		for(var/obj/Contact/X in usr.Contacts) for(var/mob/AA in Players) if(AA.z==11&&AA.ckey == X.pkey&&AA.Signature==X.Signature&&AA.Dead&&X.familiarity>20) Tlist+=AA
		Tlist+="Cancel"
		var/mob/M = input("Whose spirit would you like to summon?") in Tlist
		if(M=="Cancel") return
		var/TAL=0
		if(M.z in list(8,11,10,17,16)) TAL=1
		if(!TAL)
			usr<<"You can not find their spirit..."
			return
		else
			usr<<"You locate their spirit..."
			var/Cost = 250000000
			var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
			usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
			if(usr.Confirm("Would you like to summon [M]s spirit to the mortal realm for 1 year? It will cost [Commas(Actual)] mana."))
				for(var/obj/Mana/MM in usr)
					if(MM.Value > Actual)
						M.loc=usr.loc
						logAndAlertAdmins("[usr] used advanced seance on [M].",1)
						for(var/mob/player/MMM in view(usr)) MMM.BuffOut("[usr] has summoned [M]s spirit!")
						M.SeanceYear=Year+2
						M.KeepsBody=1
						MM.Value -= Actual
					else
						usr<<"Not enough mana."
						return
