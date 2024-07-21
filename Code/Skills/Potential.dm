


Skill/Support/Unlock_Potential
	var
		BPMod=1.3
		Base=1.45
	Experience=100
	RequiresApproval=1
	var/LastUse=0 //The year you may next use this.
	New()
		desc="This will grant someone [Base]x Base and [BPMod]x BPMod. This will also make their energy appear more pure."
		..()
	verb/Unlock_Potential(mob/A in oview(1))
		set category="Other"
		if(usr.RPMode) return
		if(!A.client) return
		if(A.Rank)
			usr<<"You may not use this on them."
			return
		if(A.Race=="Android")
			usr<<"Can not be used on Androids."
			return
		if(WipeDay<LastUse+2)
			usr<<"You cannot use this until day [LastUse+2]"
			return
		switch(input(A,"[usr] wants to unlock your hidden powers") in list("No","Yes"))
			if("Yes")
				if(A.PotentialUnlocked)
					usr<<"Their potential is already unlocked"
					return
				LastUse=WipeDay
				view(usr)<<"[usr] uses unlock potential on [A]"
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unlocked [key_name(A)]'s potential")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unlocked [key_name(A)]'s potential.\n")
				A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] had their potential unlocked by [key_name(usr)].\n")
				alertAdmins("[key_name(usr)] used Unlock Potential on [key_name(A)]")
				A.PotentialUnlocked=1
				A.BPMod *= BPMod
				A.Base  *= Base
				A.AlignmentNumber+=2
				A.AlignmentCalibrate()
			if("No") if(usr) usr<<"[A] declined your offer."

Skill/Support/Dark_Blessing
	var
		BPMod=1.3
		Base=1.45
	Experience=100
	RequiresApproval=1
	var/LastUse=0 //The year you may next use this.
	New()
		desc="This will grant someone [Base]x Base and [BPMod]x BPMod. This will also make their energy appear more evil."
		..()
	verb/Dark_Blessing(mob/A in oview(1))
		set category="Other"
		if(usr.RPMode) return
		if(!A.client) return
		if(A.Rank)
			usr<<"You may not use this on them."
			return
		if(A.Race=="Android")
			usr<<"Can not be used on Androids."
			return
		if(WipeDay<LastUse+2)
			usr<<"You cannot use this until day [LastUse+2]"
			return
		switch(input(A,"[usr] wants to give you a dark blessing.") in list("No","Yes"))
			if("Yes")
				if(A.PotentialUnlocked)
					usr<<"Their potential is already unlocked."
					return
				view(usr)<<"[usr] uses dark blessing on [A]"
				LastUse=WipeDay
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gave [key_name(A)] a dark blessing. ")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gave [key_name(A)] a dark blessing..\n")
				A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was given a dark blessing by [key_name(usr)].\n")
				alertAdmins("[key_name(usr)] has given [key_name(A)] a dark blessing.")
				A.AlignmentNumber-=2
				A.AlignmentCalibrate()
				A.PotentialUnlocked=2
				A.BPMod *= BPMod
				A.Base  *= Base
			if("No") if(usr) usr<<"[A] declined your offer."

