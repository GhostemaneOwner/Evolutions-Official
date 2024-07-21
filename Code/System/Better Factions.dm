mob/verb/Create_Faction()
	//set category="Other"
	var/Fs=0
	for(var/obj/Faction/F in usr)  Fs++
	if(Fs>=2)
		usr<<"You are already a member of too many factions."
	usr<<"Faction created!"
	var/obj/Faction/A=new
	A.name="New Faction"
	A.factioncode=rand(1,1000000000)
	A.leader=1
	contents+=A
	var/obj/Faction/B=new
	B.factioncode=A.factioncode
	WorldFactionList+=B
//	Show_Factions()

obj/Faction
	proc/MembersUpdate()
		set waitfor=0
		var/list/members=list()
		for(var/mob/player/M in Players) for(var/obj/Faction/A in M) if(factioncode==A.factioncode) members+=M
		return members
	var/tmp/list/members=list()
	var/LastPaid=0
	var/version=0
	var/rank=1
	var/list/PayGrades=list(1 = 0, 2 = 5000, 3 = 25000, 4 = 100000)
	var/list/MPayGrades=list(1 = 0, 2 = 5000, 3 = 25000, 4 = 100000)
	var/factioncode=0
	var/leader=0
	var/notes={"<body bgcolor="#000000"><font color="#CCCCCC">

	Messages here. HTML.

	</body><html>"}
	suffix="Rank 1"
	Click()
		//MembersUpdate()
		var/list/Choices=new
		Choices.Add("Cancel")
		Choices.Add("Members Online")
		if(rank>1|leader) Choices.Add("Recruit")
		if(leader|rank>=4) Choices.Add("Change Member Rank")
		if(leader|rank>=4) Choices.Add("Change Pay Grades")
		if(rank>=4|leader) Choices.Add("Boot Member")
		if(leader) Choices.Add("Faction Name")
		if(leader) Choices.Add("Faction Icon")
		if(leader|rank>=4) Choices.Add("Change Faction Notes")
		Choices.Add("View Faction Notes")
		Choices.Add("View Faction Pay Grades")
		Choices.Add("Check Control Points")
		Choices.Add("Leave Faction")
		if(leader) Choices.Add("Switch Leaders")
		switch(input("Choose Option") in Choices)
			if("Faction Name")
				name=input("Renaming [src]") as text
				version++
			if("Change Pay Grades")
				PayGrades[1]=input("Choose the resource pay for rank 1") as num
				MPayGrades[1]=input("Choose the mana pay for rank 1") as num
				PayGrades[2]=input("Choose the resource pay for rank 2") as num
				MPayGrades[2]=input("Choose the mana pay for rank 2") as num
				PayGrades[3]=input("Choose the resource pay for rank 3") as num
				MPayGrades[3]=input("Choose the mana pay for rank 3") as num
				PayGrades[4]=input("Choose the resource pay for rank 4") as num
				MPayGrades[4]=input("Choose the mana pay for rank 4") as num
				//for(var/X in PayGrades) PayGrades[X]=input("Choose the resource pay for rank [X]") as num
				//for(var/X in MPayGrades) MPayGrades[X]=input("Choose the mana pay for rank [X]") as num
				version++
			if("Switch Leaders")
				var/list/Members=new
				Members+="Cancel"
				for(var/mob/player/A in Players) for(var/obj/Faction/B in A) if(B.factioncode==factioncode) Members+=A
				var/mob/A=input("Give leader status to who?") in Members
				if(A=="Cancel") return
				leader=0
				for(var/obj/Faction/B in A) if(B.factioncode==factioncode) B.leader=1
				A<<"[usr] has just made you the leader of the faction"
				usr<<"You are no longer the leader. You have made [A] the leader"
			if("View Faction Pay Grades")
				usr<<"Resource Pay: [PayGrades.Join(", ")]"
				usr<<"Mana Pay: [MPayGrades.Join(", ")]"
			if("Boot Member")
				var/list/Members=new
				Members+="Cancel"
				for(var/mob/player/A in Players) for(var/obj/Faction/B in A) if(B.factioncode==factioncode) Members+=A
				var/mob/A=input("Boot which member?") in Members
				if(A=="Cancel") return
				A<<"[usr] has taken you out of [src]"
				for(var/obj/Faction/B in A) if(B.factioncode==factioncode) del(B)
			if("Change Member Rank")
				var/list/Members=new
				Members+="Cancel"
				for(var/mob/player/A in Players) for(var/obj/Faction/B in A) if(B.factioncode==factioncode) Members+=A
				var/mob/A=input("Which member?") in Members
				if(A=="Cancel") return
				for(var/obj/Faction/B in A) if(B.factioncode==factioncode)
					if(B.rank<rank|leader)
						B.rank=input("Input a new rank. Current is [B.rank]. 1 will have only basic commands. \
						2 will be able to recruit. 3 will be able to boot those with lower ranks than them. 4 has everything the leader has.") as num
						B.suffix="Rank [B.rank]"
					else usr<<"Their rank is higher than yours, you cannot change it."
			if("Faction Icon")
				icon=input("") as icon
				icon_state=input("Enter the appropriate icon state, if any.") as text
				version++
			if("Change Faction Notes")
				notes=input(usr,"Faction Notes","Faction Notes",notes) as message
				version++
			if("Recruit")
				Choices=new
				Choices+="Cancel"
				for(var/mob/A in view(usr)) if(A.client)
					var/Found
					for(var/obj/Faction/Q in A) if(Q.factioncode==factioncode) Found=1
					if(!Found) Choices+=A
				var/mob/M=input("Who?") as null | anything in Choices
				if(M=="Cancel") return
				switch(input(M,"Join [name]?") in list("Yes","No"))
					if("Yes")
						var/obj/Faction/A=new
						A.factioncode=factioncode
						M.contents+=A
						M.FactionUpdate()
						view(M)<<"[M] is now a member of the [name]"
					else view(M)<<"Has declined to join the [name]"
			if("Leave Faction") del(src)
			if("View Faction Notes") usr<<browse(notes,"window= ;size=700x600")
			if("Members Online") usr<<"[MembersUpdate().Join("\n")]"
			if("Check Control Points")
				var/list/CPs=list()
				if(Z1ControllingRuler==usr.name||usr.FactionApproved(Z1FactionCode,1)) CPs+="Earth"
				if(Z2ControllingRuler==usr.name||usr.FactionApproved(Z2FactionCode,1)) CPs+="Namek"
				if(Z3ControllingRuler==usr.name||usr.FactionApproved(Z3FactionCode,1)) CPs+="Vegeta"
				if(Z4ControllingRuler==usr.name||usr.FactionApproved(Z4FactionCode,1)) CPs+="Icer"
				if(Z5ControllingRuler==usr.name||usr.FactionApproved(Z5FactionCode,1)) CPs+="Arconia"
				if(Z6ControllingRuler==usr.name||usr.FactionApproved(Z6FactionCode,1)) CPs+="Dark Planet"
				if(Z7ControllingRuler==usr.name||usr.FactionApproved(Z7FactionCode,1)) CPs+="Space Station"
				CPs+="Cancel"
				var/CP=input("Which Control Point?") in CPs
				if(CP=="Cancel") return
				switch(CP)
					if("Earth")
						usr<<"This is controlled by [Z1ControllingFaction]. This planet has a current Tax Rate of [Z1Tax]%"
						usr <<"Tax Evaders:"
						for(var/P in Z1TaxEvaders)
							usr<<"[P] = [Z1TaxEvaders[P]]"
						usr <<"Mana Tax Evaders:"
						for(var/P in Z1MTaxEvaders)
							usr<<"[P] owes [Z1MTaxEvaders[P]] mana"
						usr << "[Commas(Z1ReserveResources)] Reserve Resources and [Commas(Z1ReserveMana)] Reserve Mana in the Control Point."
					if("Namek")
						usr<<"This is controlled by [Z2ControllingFaction]. This planet has a current Tax Rate of [Z2Tax]%"
						usr <<"Tax Evaders:"
						for(var/P in Z2TaxEvaders)
							usr<<"[P] owes [Z2TaxEvaders[P]] resources"
						usr <<"Mana Tax Evaders:"
						for(var/P in Z2MTaxEvaders)
							usr<<"[P] owes [Z2MTaxEvaders[P]] mana"
						usr << "[Commas(Z2ReserveResources)] Reserve Resources and [Commas(Z2ReserveMana)] Reserve Mana in the Control Point."
					if("Vegeta")
						usr<<"This is controlled by [Z3ControllingFaction]. This planet has a current Tax Rate of [Z3Tax]%"
						usr <<"Tax Evaders:"
						for(var/P in Z3TaxEvaders)
							usr<<"[P] owes [Z3TaxEvaders[P]] resources"
						usr <<"Mana Tax Evaders:"
						for(var/P in Z3MTaxEvaders)
							usr<<"[P] owes [Z3MTaxEvaders[P]] mana"
						usr << "[Commas(Z3ReserveResources)] Reserve Resources and [Commas(Z3ReserveMana)] Reserve Mana in the Control Point."
					if("Icer")
						usr<<"This is controlled by [Z4ControllingFaction]. This planet has a current Tax Rate of [Z4Tax]%"
						usr <<"Tax Evaders:"
						for(var/P in Z4TaxEvaders)
							usr<<"[P] owes [Z4TaxEvaders[P]] resources"
						usr <<"Mana Tax Evaders:"
						for(var/P in Z4MTaxEvaders)
							usr<<"[P] owes [Z4MTaxEvaders[P]] mana"
						usr << "[Commas(Z4ReserveResources)] Reserve Resources and [Commas(Z4ReserveMana)] Reserve Mana in the Control Point."
					if("Arconia")
						usr<<"This is controlled by [Z5ControllingFaction]. This planet has a current Tax Rate of [Z5Tax]%"
						usr <<"Tax Evaders:"
						for(var/P in Z5TaxEvaders)
							usr<<"[P] owes [Z5TaxEvaders[P]] resources"
						usr <<"Mana Tax Evaders:"
						for(var/P in Z5MTaxEvaders)
							usr<<"[P] owes [Z5MTaxEvaders[P]] mana"
						usr << "[Commas(Z5ReserveResources)] Reserve Resources and [Commas(Z5ReserveMana)] Reserve Mana in the Control Point."
					if("Dark Planet")
						usr<<"This is controlled by [Z6ControllingFaction]. This planet has a current Tax Rate of [Z6Tax]%"
						usr <<"Tax Evaders:"
						for(var/P in Z6TaxEvaders)
							usr<<"[P] owes [Z6TaxEvaders[P]] resources"
						usr <<"Mana Tax Evaders:"
						for(var/P in Z7MTaxEvaders)
							usr<<"[P] owes [Z6MTaxEvaders[P]] mana"
						usr << "[Commas(Z6ReserveResources)] Reserve Resources and [Commas(Z6ReserveMana)] Reserve Mana in the Control Point."
					if("Space Station")
						usr<<"This is controlled by [Z7ControllingFaction]. This planet has a current Tax Rate of [Z7Tax]%"
						usr <<"Tax Evaders:"
						for(var/P in Z7TaxEvaders)
							usr<<"[P] owes [Z7TaxEvaders[P]] resources"
						usr <<"Mana Tax Evaders:"
						for(var/P in Z7MTaxEvaders)
							usr<<"[P] owes [Z7MTaxEvaders[P]] mana"
						usr << "[Commas(Z7ReserveResources)] Reserve Resources and [Commas(Z7ReserveMana)] Reserve Mana in the Control Point."





		if(leader|rank>=4) FactionUpdateServer(src)
//		del(Choices)

var/list/WorldFactionList = new

proc/FactionUpdateServer(obj/Faction/A)
	set waitfor=0
	for(var/obj/Faction/F in WorldFactionList) if(F.factioncode==A.factioncode) if(A.version>F.version)
		F.name=A.name
		F.icon=A.icon
		F.version=A.version
		F.notes=A.notes
		F.PayGrades=A.PayGrades
		F.MPayGrades=A.MPayGrades
mob/proc/FactionUpdate()
	set background=1
	set waitfor=0
	for(var/obj/Faction/F in src) for(var/obj/Faction/A in WorldFactionList) if(F.factioncode==A.factioncode) if(A.version>F.version)
		F.name=A.name
		F.icon=A.icon
		F.version=A.version
		F.notes=A.notes
		F.PayGrades=A.PayGrades
		F.MPayGrades=A.MPayGrades
		src<<"[F] faction was updated."

mob/proc/FactionIncome(faction,bank)
	FactionUpdate()
	sleep(5)
	for(var/obj/Faction/CP in src) if(CP.factioncode==faction&&CP.LastPaid<=Year+(Month*0.01))
		var/Pay=CP.PayGrades[CP.rank]
		var/MPay=CP.MPayGrades[CP.rank]
		var/GetR=0
		var/GetM=0

		switch(bank)
			if(1)
				if(Z1ReserveResources>=Pay)
					GetR=1
					Z1ReserveResources-=Pay
				if(Z1ReserveMana>=MPay)
					GetM=1
					Z1ReserveMana-=MPay
			if(2)
				if(Z2ReserveResources>=Pay)
					GetR=1
					Z2ReserveResources-=Pay
				if(Z2ReserveMana>=MPay)
					GetM=1
					Z2ReserveMana-=MPay
			if(3)
				if(Z3ReserveResources>=Pay)
					GetR=1
					Z3ReserveResources-=Pay
				if(Z3ReserveMana>=MPay)
					GetM=1
					Z3ReserveMana-=MPay
			if(4)
				if(Z4ReserveResources>=Pay)
					GetR=1
					Z4ReserveResources-=Pay
				if(Z4ReserveMana>=MPay)
					GetM=1
					Z4ReserveMana-=MPay
			if(5)
				if(Z5ReserveResources>=Pay)
					GetR=1
					Z5ReserveResources-=Pay
				if(Z5ReserveMana>=MPay)
					GetM=1
					Z5ReserveMana-=MPay
			if(6)
				if(Z6ReserveResources>=Pay)
					GetR=1
					Z6ReserveResources-=Pay
				if(Z6ReserveMana>=MPay)
					GetM=1
					Z6ReserveMana-=MPay
			if(7)
				if(Z7ReserveResources>=Pay)
					GetR=1
					Z7ReserveResources-=Pay
				if(Z7ReserveMana>=MPay)
					GetM=1
					Z7ReserveMana-=MPay


		if(GetR)
			src.AllOut("[CP] salary of [Pay] resources added.")
			for(var/obj/Resources/R in src) R.Value+=Pay
		else
			src.AllOut("[CP] could not afford to pay you resources this month.")
		if(GetM)
			src.AllOut("[CP] salary of [MPay] mana added.")
			for(var/obj/Mana/R in src) R.Value+=MPay
		else
			src.AllOut("[CP] could not afford to pay you mana this month.")
		CP.LastPaid=Year+(Month*0.01)
