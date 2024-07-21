
//Perhaps temporary placeholder merely to increase cybernetic power.
Skill/Technology/Cyberize
	Experience=100
	verb/Cyberize()
		set category="Other"
		if(usr.PowerArmorOn) return
		var/list/mob/Choices=new
		Choices+=usr
		if(usr.HasWeHaveTheTechnology)
			for(var/mob/player/P in oview(usr))
				Choices+=P
		var/mob/A=input("Choose a target") as null | anything in Choices
		if(!ismob(A)) return
		if(A.Dead)
			usr<<"Dead people cannot get cybernetic implants."
			return
		var/Max=round(usr.HasIntMiles)
		if(A.HasIntMiles<2)
			usr<<"They can not be enhanced."
			return
		var/Amount=input(usr,"Choose which level to Cyberize them to. 0(0 will remove Cyberize) - 1. (Changes the reduction from Int MPs from 7.5% per level to 0% but disables power armor and gundams.)") as num
		if(Amount>Max) Amount=Max
		if(Amount>1)Amount=1
		if(usr.PowerArmorOn) return
		if(Amount==0) if(usr.Confirm("Do you want to remove their cyberization?"))
			switch(alert(A,"[usr] wants to remove your cyberization. Accept?","Cyberize Remove","Yes","No"))
				if("Yes")
					A.AndroidLevel = 0
					view(usr) << "[A] accepts the offer from [usr] to have their cyberization removed."
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has removed [A]'s cyberization.")
					alertAdmins("[key_name(usr)] has removed [key_name(A)] cyberization which was granting [Amount] BP")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has removed [A]'s cyberization.\n")
					return
				if("No")
					view(usr)<<"[A] declines the offer from [usr] to have their cyberization removed."
					return
		if(Amount<A.AndroidLevel) return
		if(usr.PowerArmorOn) return
		var/Cost=((((Amount-A.AndroidLevel)*25000000))+2500000)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(Cost<0) Cost=0
		for(var/obj/Resources/R in usr)
			if(R.Value<Cost)
				usr<<"You need [Commas(Cost)]$ to do this."
				return
			switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
				if("No") return
			if(usr.PowerArmorOn) return
//cost used to be here

			var/confirmation = alert(A,"[usr] wants to upgrade you to level [Amount], do you accept? (Changes the reduction from Int MPs from 7.5% per level to 0% but disables power armor and gundams.)","Cyberize","Yes","No")
			switch(confirmation)

				if("Yes")
					A.AndroidLevel = 1
					R.Value-=Cost
					if(usr.HasWeHaveTheTechnology)
						for(var/BodyPart/BP in A)
							BP.Cybernetic=1
							if(BP.MaxHealth<usr.Int_Level) BP.MaxHealth=usr.Int_Level
							A.CyberLimb(BP)
							A.Injure_Heal(200,BP,1)
							A.Injure_Heal(200,BP,1)
							view(usr)<<"[usr] has successfully replaced [A]'s [BP] with a cybernetic version."
					view(usr) << "[A] accepts the offer from [usr] to be Cyberized to level [A.AndroidLevel]."
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Cyberized [A] to level [A.AndroidLevel]")
					alertAdmins("[key_name(usr)] has cyberized [key_name(A)] to level [Amount] BP")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Cyberized [A] to level [A.AndroidLevel].\n")
				if("No") view(usr)<<"[A] declines the offer from [usr] to be Cyberized."

Skill/Technology/Upgrade_Android
	Experience=100
	verb/Upgrade_Android()
		set category="Other"
		if(usr.RPMode) return
		var/list/mob/Choices=new
		//Choices+=usr
		for(var/mob/A in get_step(usr,usr.dir))
			if(A.Race=="Android")
				Choices+=A
		if(usr.Race=="Android")
			Choices+=usr
		var/mob/A=input("Choose a target") as null | anything in Choices
		if(!A) return
		var/Max=round(usr.Int_Level)
		if(A.AndroidLevel>=Max)
			usr<<"They are already too advanced."
			return
		var/Amount=input(usr,"Choose which level to upgrade them to. [A.AndroidLevel] - [Max]. Each level grants 0.25% passive BP.") as num
		if(Amount>Max) Amount=Max
		if(Amount<A.AndroidLevel) return
		var/Cost=((((Amount-A.AndroidLevel)*1250000))+5000000)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(Cost<0) Cost=0
		for(var/obj/Resources/R in usr)
			if(R.Value<Cost)
				usr<<"You need [Commas(Cost)]$ to do this."
				return
			switch(input("This will cost [Commas(Cost)]$. Are you sure you want to do this?") in list("Yes","No"))
				if("No") return
//cost used to be here
			var/confirmation = alert(A,"[usr] wants to upgrade you to level [Amount], do you accept? Each level grants 0.25% passive BP.","Android Upgrade","Yes","No")

			switch(confirmation)
				if("Yes")
					A.AndroidLevel = Amount
					R.Value-=Cost
					view(usr) << "[A] accepts the offer from [usr] to be upgraded to level [A.AndroidLevel]."
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has upgraded [A] to level [A.AndroidLevel]")
					alertAdmins("[key_name(usr)] has upgraded [key_name(A)] to level [Amount]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has upgraded [A] to level [A.AndroidLevel].\n")
				if("No") view(usr)<<"[A] declines the offer from [usr] to be upgraded."

