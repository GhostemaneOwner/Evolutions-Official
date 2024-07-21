
mob/proc/
	Assign_Control_Point(mob/M as mob in Players)
		set hidden=1//set category="Admin"
		if(!usr.client.holder || usr.client.holder.level < 1)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/ControlPoints=list("Earth","Namek","Vegeta","Icer","Arconia","Dark Planet","Space Station")
		var/Choice=input("Choose a Control Point to assign") in ControlPoints
		if(usr.Confirm("Give [M] control of [Choice]?"))
			var/list/FChoices=list()
			for(var/obj/Faction/F in M) FChoices+=F
			FChoices+="Cancel"
			var/obj/Faction/CF=input("Choose a Faction to assign control to (must be a faction)") in FChoices
			if(CF=="Cancel") return
			switch(Choice)
				if("Earth")
					Z1ControllingFaction=CF.name
					Z1ControllingRuler=M.name
					Z1FactionCode=CF.factioncode
				if("Namek")
					Z2ControllingFaction=CF.name
					Z2ControllingRuler=M.name
					Z2FactionCode=CF.factioncode
				if("Vegeta")
					Z3ControllingFaction=CF.name
					Z3ControllingRuler=M.name
					Z3FactionCode=CF.factioncode
				if("Icer")
					Z4ControllingFaction=CF.name
					Z4ControllingRuler=M.name
					Z4FactionCode=CF.factioncode
				if("Arconia")
					Z5ControllingFaction=CF.name
					Z5ControllingRuler=M.name
					Z5FactionCode=CF.factioncode
				if("Dark Planet")
					Z6ControllingFaction=CF.name
					Z6ControllingRuler=M.name
					Z6FactionCode=CF.factioncode
				if("Space Station")
					Z7ControllingFaction=CF.name
					Z7ControllingRuler=M.name
					Z7FactionCode=CF.factioncode

			if(!locate(/Skill/Misc/FactionLeaderCommands) in src)
				var/Skill/Fac = new /Skill/Misc/FactionLeaderCommands
				Fac.RankKit=1
				M.contents+=Fac
				M<<"Added [Fac] to skill set"
			ControledCP++
			logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] of [CF] control of z [Choice].",2)







mob/proc/TakeCP(mob/A)
	if(locate(/Skill/Misc/FactionLeaderCommands) in A)
		var/list/CPs=list()
		if(Z1ControllingRuler==A.name||A.FactionApproved(Z1FactionCode,4)) CPs+="Earth"
		if(Z2ControllingRuler==A.name||A.FactionApproved(Z2FactionCode,4)) CPs+="Namek"
		if(Z3ControllingRuler==A.name||A.FactionApproved(Z3FactionCode,4)) CPs+="Vegeta"
		if(Z4ControllingRuler==A.name||A.FactionApproved(Z4FactionCode,4)) CPs+="Icer"
		if(Z5ControllingRuler==A.name||A.FactionApproved(Z5FactionCode,4)) CPs+="Arconia"
		if(Z6ControllingRuler==A.name||A.FactionApproved(Z6FactionCode,4)) CPs+="Dark Planet"
		if(Z7ControllingRuler==A.name||A.FactionApproved(Z7FactionCode,4)) CPs+="Space Station"
		CPs+="Cancel"
		var/CP=input("Take Which Control Point?") in CPs
		if(CP=="Cancel") return
		var/list/FChoices=list()
		for(var/obj/Faction/F in src) FChoices+=F
		FChoices+="Cancel"
		var/obj/Faction/CF=input("Choose a Faction to assign control to (must be a faction)") in FChoices
		if(CF=="Cancel") return
		switch(CP)
			if("Earth")
				Z1ControllingFaction=CF.name
				Z1ControllingRuler=src.name
				Z1FactionCode=CF.factioncode
			if("Namek")
				Z2ControllingFaction=CF.name
				Z2ControllingRuler=src.name
				Z2FactionCode=CF.factioncode
			if("Vegeta")
				Z3ControllingFaction=CF.name
				Z3ControllingRuler=src.name
				Z3FactionCode=CF.factioncode
			if("Icer")
				Z4ControllingFaction=CF.name
				Z4ControllingRuler=src.name
				Z4FactionCode=CF.factioncode
			if("Arconia")
				Z5ControllingFaction=CF.name
				Z5ControllingRuler=src.name
				Z5FactionCode=CF.factioncode
			if("Dark Planet")
				Z6ControllingFaction=CF.name
				Z6ControllingRuler=src.name
				Z6FactionCode=CF.factioncode
			if("Space Station")
				Z7ControllingFaction=CF.name
				Z7ControllingRuler=src.name
				Z7FactionCode=CF.factioncode
		view(src)<<"[src] has taken control of [CP] from [A] for [CF]!"
		var/Skill/Fac = new /Skill/Misc/FactionLeaderCommands
		Fac.RankKit=1
		src.contents+=Fac
		A<<"Removed [Fac] from skill set"
		A.contents-=Fac
		src<<"Added [Fac] to skill set"
		logAndAlertAdmins("[key_name(src)] took control of [CP] from [A]  for [CF].")
	else
		var/list/CPs=list()
		if(Z1ControllingRuler==A.name||A.FactionApproved(Z1FactionCode,4)) CPs+="Earth"
		if(Z2ControllingRuler==A.name||A.FactionApproved(Z2FactionCode,4)) CPs+="Namek"
		if(Z3ControllingRuler==A.name||A.FactionApproved(Z3FactionCode,4)) CPs+="Vegeta"
		if(Z4ControllingRuler==A.name||A.FactionApproved(Z4FactionCode,4)) CPs+="Icer"
		if(Z5ControllingRuler==A.name||A.FactionApproved(Z5FactionCode,4)) CPs+="Arconia"
		if(Z6ControllingRuler==A.name||A.FactionApproved(Z6FactionCode,4)) CPs+="Dark Planet"
		if(Z7ControllingRuler==A.name||A.FactionApproved(Z7FactionCode,4)) CPs+="Space Station"
		CPs+="Cancel"
		var/CP=input("Take Which Control Point?") in CPs
		if(CP=="Cancel") return
		var/list/FChoices=list()
		for(var/obj/Faction/F in src) FChoices+=F
		FChoices+="Plunder (Reset to Neutral)"
		FChoices+="Cancel"
		var/obj/Faction/CF=input("Choose a Faction to assign control to (must be a faction)") in FChoices
		if(CF=="Plunder (Reset to Neutral)")
			var/PTake=0
			var/MTake=0
			switch(CP)
				if("Earth")
					Z1ControllingFaction=null//CF.name
					Z1ControllingRuler=null//src.name
					Z1FactionCode=null//CF.factioncode
					Z1Tax=0
					PTake=Z1ReserveResources
					Z1ReserveResources=0
					MTake=Z1ReserveMana
					Z1ReserveMana=0
				if("Namek")
					Z2ControllingFaction=null//CF.name
					Z2ControllingRuler=null//src.name
					Z2FactionCode=null//CF.factioncode
					PTake=Z2ReserveResources
					Z2ReserveResources=0
					MTake=Z2ReserveMana
					Z2ReserveMana=0
					Z2Tax=0
				if("Vegeta")
					Z3ControllingFaction=null//CF.name
					Z3ControllingRuler=null//src.name
					Z3FactionCode=null//CF.factioncode
					Z3Tax=0
					PTake=Z3ReserveResources
					Z3ReserveResources=0
					MTake=Z3ReserveMana
					Z3ReserveMana=0
				if("Icer")
					Z4ControllingFaction=null//CF.name
					Z4ControllingRuler=null//src.name
					Z4FactionCode=null//CF.factioncode
					Z4Tax=0
					PTake=Z4ReserveResources
					Z4ReserveResources=0
					MTake=Z4ReserveMana
					Z4ReserveMana=0
				if("Arconia")
					Z5ControllingFaction=null//CF.name
					Z5ControllingRuler=null//src.name
					Z5FactionCode=null//CF.factioncode
					Z5Tax=0
					PTake=Z5ReserveResources
					Z5ReserveResources=0
					MTake=Z5ReserveMana
					Z5ReserveMana=0
				if("Dark Planet")
					Z6ControllingFaction=null//CF.name
					Z6ControllingRuler=null
					Z6FactionCode=null
					Z1Tax=0
					PTake=Z6ReserveResources
					Z6ReserveResources=0
					MTake=Z6ReserveMana
					Z6ReserveMana=0
				if("Space Station")
					Z7ControllingFaction=null
					Z7ControllingRuler=null
					Z7FactionCode=null
					Z6Tax=0
					PTake=Z7ReserveResources
					Z7ReserveResources=0
					MTake=Z7ReserveMana
					Z7ReserveMana=0
			for(var/obj/Resources/CC in src)
				CC.Value       += PTake
				usr<<"You plundered [Commas(PTake)] resources."
			for(var/obj/Mana/CC in src)
				CC.Value       += MTake
				usr<<"You plundered [Commas(MTake)] Mana."

			return
		if(CF=="Cancel") return
		switch(CP)
			if("Earth")
				Z1ControllingFaction=CF.name
			//	Z1ControllingRuler=M.name
				Z1FactionCode=CF.factioncode
			if("Namek")
				Z2ControllingFaction=CF.name
			//	Z2ControllingRuler=M.name
				Z2FactionCode=CF.factioncode
			if("Vegeta")
				Z3ControllingFaction=CF.name
			//	Z3ControllingRuler=M.name
				Z3FactionCode=CF.factioncode
			if("Icer")
				Z4ControllingFaction=CF.name
			//	Z4ControllingRuler=M.name
				Z4FactionCode=CF.factioncode
			if("Arconia")
				Z5ControllingFaction=CF.name
			//	Z5ControllingRuler=M.name
				Z5FactionCode=CF.factioncode
			if("Dark Planet")
				Z6ControllingFaction=CF.name
			//	Z6ControllingRuler=M.name
				Z6FactionCode=CF.factioncode
			if("Space Station")
				Z7ControllingFaction=CF.name
			//	Z7ControllingRuler=M.name
				Z7FactionCode=CF.factioncode
		view(src)<<"[src] has taken control of [CP] from [A]  for [CF]!"
		logAndAlertAdmins("[key_name(src)] took control of [CP] from [A]  for [CF].")


















mob/Admin1/verb/Check_Taxes()
	usr<<{"
Earth Tax =[Z1Tax]
Earth ControllingFaction=[Z1ControllingFaction]
Earth ControllingRuler=[Z1ControllingRuler]
Earth FactionCode=[Z1FactionCode]
Earth ReserveResources=[Z1ReserveResources]
Earth ReserveMana=[Z1ReserveMana]
Namek Tax=[Z2Tax]
Namek ControllingFaction=[Z2ControllingFaction]
Namek ControllingRuler=[Z2ControllingRuler]
Namek FactionCode=[Z2FactionCode]
Namek ReserveResources=[Z2ReserveResources]
Namek ReserveMana=[Z2ReserveMana]
Vegeta Tax=[Z3Tax]
Vegeta ControllingFaction=[Z3ControllingFaction]
Vegeta ControllingRuler=[Z3ControllingRuler]
Vegeta FactionCode=[Z3FactionCode]
Vegeta ReserveResources=[Z3ReserveResources]
Vegeta ReserveMana=[Z3ReserveMana]
Icer Tax=[Z4Tax]
Icer ControllingFaction=[Z4ControllingFaction]
Icer ControllingRuler=[Z4ControllingRuler]
Icer FactionCode=[Z4FactionCode]
Icer ReserveResources=[Z4ReserveResources]
Icer ReserveMana=[Z4ReserveMana]
Arconia Tax=[Z5Tax]
Arconia ControllingFaction=[Z5ControllingFaction]
Arconia ControllingRuler=[Z5ControllingRuler]
Arconia FactionCode=[Z5FactionCode]
Arconia ReserveResources=[Z5ReserveResources]
Arconia ReserveMana=[Z5ReserveMana]
Dark Planet Tax=[Z6Tax]
Dark Planet ControllingFaction=[Z6ControllingFaction]
Dark Planet ControllingRuler=[Z6ControllingRuler]
Dark Planet FactionCode=[Z6FactionCode]
Dark Planet ReserveResources=[Z6ReserveResources]
Dark Planet ReserveMana=[Z6ReserveMana]
Space Station Tax=[Z7Tax]
Space Station ControllingFaction=[Z7ControllingFaction]
Space Station ControllingRuler=[Z7ControllingRuler]
Space Station FactionCode=[Z7FactionCode]
Space Station ReserveResources=[Z7ReserveResources]
Space Station ReserveMana=[Z7ReserveMana]
"}


var/
	Z1Tax=0
	Z1ControllingFaction
	Z1ControllingRuler
	Z1FactionCode
	Z1ReserveResources=0
	Z1ReserveMana=0
	list/Z1TaxEvaders=list()
	list/Z1MTaxEvaders=list()
	Z2Tax=0
	Z2ControllingFaction
	Z2ControllingRuler
	Z2FactionCode
	Z2ReserveResources=0
	Z2ReserveMana=0
	list/Z2TaxEvaders=list()
	list/Z2MTaxEvaders=list()
	Z3Tax=0
	Z3ControllingFaction
	Z3ControllingRuler
	Z3FactionCode
	Z3ReserveResources=0
	Z3ReserveMana=0
	list/Z3TaxEvaders=list()
	list/Z3MTaxEvaders=list()
	Z4Tax=0
	Z4ControllingFaction
	Z4ControllingRuler
	Z4FactionCode
	Z4ReserveResources=0
	Z4ReserveMana=0
	list/Z4TaxEvaders=list()
	list/Z4MTaxEvaders=list()
	Z5Tax=0
	Z5ControllingFaction
	Z5ControllingRuler
	Z5FactionCode
	Z5ReserveResources=0
	Z5ReserveMana=0
	list/Z5TaxEvaders=list()
	list/Z5MTaxEvaders=list()
	Z6Tax=0
	Z6ControllingFaction
	Z6ControllingRuler
	Z6FactionCode
	Z6ReserveResources=0
	Z6ReserveMana=0
	list/Z6TaxEvaders=list()
	list/Z6MTaxEvaders=list()
	Z7Tax=0
	Z7ControllingFaction
	Z7ControllingRuler
	Z7FactionCode
	Z7ReserveResources=0
	Z7ReserveMana=0
	list/Z7TaxEvaders=list()
	list/Z7MTaxEvaders=list()

	Z1FactionTax=0
	Z2FactionTax=0
	Z3FactionTax=0
	Z4FactionTax=0
	Z5FactionTax=0
	Z6FactionTax=0
	Z7FactionTax=0


mob/var
	IgnoreTaxes=0
	BuildingPermit=0

mob/verb/Ignore_Taxes()
	set category=null
	if(usr.IgnoreTaxes)
		usr.IgnoreTaxes = 0
		usr << "You begin to pay your share of taxes again. You will no longer be reported."
		return
	else
		usr.IgnoreTaxes = 1
		usr << "You have stopped paying your share of taxes. You will be reported when you gain mana or resources on this planet."
		return

mob/proc/FactionApproved(Check, RankCheck=1)
	for(var/obj/Faction/F in src) if(F.factioncode==Check&&F.rank>=RankCheck) return 1
	return 0

Skill/Misc/FactionLeaderCommands
	UB1="Shadow King"
	Tier=3
	Experience=100
	verb/Grant_Building_Permit(mob/player/M in oview(5))
		set category="Rank"
		if(usr.Confirm("Grant [M] temporary building permission? This will last for 1 day."))
			for(var/mob/player/MM in view(10)) MM.AllOut("[usr] has granted [M] a building permit until day [WipeDay+1].")
			M.BuildingPermit=WipeDay+1
	verb/Withdraw_Resources()
		set category="Rank"
		var/list/CPs=list()
		if(Z1ControllingRuler==usr.name||usr.FactionApproved(Z1FactionCode,4)) CPs+="Earth"
		if(Z2ControllingRuler==usr.name||usr.FactionApproved(Z2FactionCode,4)) CPs+="Namek"
		if(Z3ControllingRuler==usr.name||usr.FactionApproved(Z3FactionCode,4)) CPs+="Vegeta"
		if(Z4ControllingRuler==usr.name||usr.FactionApproved(Z4FactionCode,4)) CPs+="Icer"
		if(Z5ControllingRuler==usr.name||usr.FactionApproved(Z5FactionCode,4)) CPs+="Arconia"
		if(Z6ControllingRuler==usr.name||usr.FactionApproved(Z6FactionCode,4)) CPs+="Dark Planet"
		if(Z7ControllingRuler==usr.name||usr.FactionApproved(Z7FactionCode,4)) CPs+="Space Station"
		CPs+="Cancel"
		var/CP=input("Which Control Point?") in CPs
		if(CP=="Cancel") return
		var/getRSC = input("How many reosurces would you like to withdraw from the Control Point? 0 to Cancel [CP=="Earth"?"[Z1ReserveResources]":CP=="Namek"?"[Z2ReserveResources]":CP=="Vegeta"?"[Z3ReserveResources]":CP=="Icer"?"[Z4ReserveResources]":CP=="Arconia"?"[Z5ReserveResources]":CP=="Dark Planet"?"[Z6ReserveResources]":CP=="Space Station"?"[Z7ReserveResources]":""] reserve") as num
		if(getRSC < 1) return
		getRSC=round(getRSC)
		switch(CP)
			if("Earth")
				if(getRSC > Z1ReserveResources)getRSC=round(Z1ReserveResources)
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					Z1ReserveResources -= getRSC
					usr<<"You withdraw [getRSC] resources."
			if("Namek")
				if(getRSC > Z2ReserveResources)getRSC=round(Z2ReserveResources)
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					Z2ReserveResources -= getRSC
					usr<<"You withdraw [getRSC] resources."
			if("Vegeta")
				if(getRSC > Z3ReserveResources)getRSC=round(Z3ReserveResources)
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					Z3ReserveResources -= getRSC
					usr<<"You withdraw [getRSC] resources."
			if("Icer")
				if(getRSC > Z4ReserveResources)getRSC=round(Z4ReserveResources)
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					Z4ReserveResources -= getRSC
					usr<<"You withdraw [getRSC] resources."
			if("Arconia")
				if(getRSC > Z5ReserveResources)getRSC=round(Z5ReserveResources)
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					Z5ReserveResources -= getRSC
					usr<<"You withdraw [getRSC] resources."
			if("Dark Planet")
				if(getRSC > Z6ReserveResources)getRSC=round(Z6ReserveResources)
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					Z6ReserveResources -= getRSC
					usr<<"You withdraw [getRSC] resources."
			if("Space Station")
				if(getRSC > Z7ReserveResources)getRSC=round(Z7ReserveResources)
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					Z7ReserveResources -= getRSC
					usr<<"You withdraw [getRSC] resources."


	verb/Withdraw_Mana()
		set category="Rank"
		var/list/CPs=list()
		if(Z1ControllingRuler==usr.name||usr.FactionApproved(Z1FactionCode,4)) CPs+="Earth"
		if(Z2ControllingRuler==usr.name||usr.FactionApproved(Z2FactionCode,4)) CPs+="Namek"
		if(Z3ControllingRuler==usr.name||usr.FactionApproved(Z3FactionCode,4)) CPs+="Vegeta"
		if(Z4ControllingRuler==usr.name||usr.FactionApproved(Z4FactionCode,4)) CPs+="Icer"
		if(Z5ControllingRuler==usr.name||usr.FactionApproved(Z5FactionCode,4)) CPs+="Arconia"
		if(Z6ControllingRuler==usr.name||usr.FactionApproved(Z6FactionCode,4)) CPs+="Dark Planet"
		if(Z7ControllingRuler==usr.name||usr.FactionApproved(Z7FactionCode,4)) CPs+="Space Station"
		CPs+="Cancel"
		var/CP=input("Which Control Point?") in CPs
		if(CP=="Cancel") return
		var/getRSC = input("How much mana would you like to withdraw from the Control Point? 0 to Cancel [CP=="Earth"?"[Z1ReserveMana]":CP=="Namek"?"[Z2ReserveMana]":CP=="Vegeta"?"[Z3ReserveMana]":CP=="Icer"?"[Z4ReserveMana]":CP=="Arconia"?"[Z5ReserveMana]":CP=="Dark Planet"?"[Z6ReserveMana]":CP=="Space Station"?"[Z7ReserveMana]":""] reserve") as num
		if(getRSC < 1) return
		getRSC=round(getRSC)
		switch(CP)
			if("Earth")
				if(getRSC > Z1ReserveMana)getRSC=round(Z1ReserveMana)
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					Z1ReserveMana -= getRSC
					usr<<"You withdraw [getRSC] Mana."
			if("Namek")
				if(getRSC > Z2ReserveMana)getRSC=round(Z2ReserveMana)
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					Z2ReserveMana -= getRSC
					usr<<"You withdraw [getRSC] Mana."
			if("Vegeta")
				if(getRSC > Z3ReserveMana)getRSC=round(Z3ReserveMana)
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					Z3ReserveMana -= getRSC
					usr<<"You withdraw [getRSC] Mana."
			if("Icer")
				if(getRSC > Z4ReserveMana)getRSC=round(Z4ReserveMana)
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					Z4ReserveMana -= getRSC
					usr<<"You withdraw [getRSC] Mana."
			if("Arconia")
				if(getRSC > Z5ReserveMana)getRSC=round(Z5ReserveMana)
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					Z5ReserveMana -= getRSC
					usr<<"You withdraw [getRSC] Mana."
			if("Dark Planet")
				if(getRSC > Z6ReserveMana)getRSC=round(Z6ReserveMana)
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					Z6ReserveMana -= getRSC
					usr<<"You withdraw [getRSC] Mana."
			if("Space Station")
				if(getRSC > Z7ReserveMana)getRSC=round(Z7ReserveMana)
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					Z7ReserveMana -= getRSC
					usr<<"You withdraw [getRSC] Mana."

	verb/Set_Tax_Rate()
		set category="Rank"
		var/list/CPs=list()
		if(Z1ControllingRuler==usr.name||usr.FactionApproved(Z1FactionCode,4)) CPs+="Earth"
		if(Z2ControllingRuler==usr.name||usr.FactionApproved(Z2FactionCode,4)) CPs+="Namek"
		if(Z3ControllingRuler==usr.name||usr.FactionApproved(Z3FactionCode,4)) CPs+="Vegeta"
		if(Z4ControllingRuler==usr.name||usr.FactionApproved(Z4FactionCode,4)) CPs+="Icer"
		if(Z5ControllingRuler==usr.name||usr.FactionApproved(Z5FactionCode,4)) CPs+="Arconia"
		if(Z6ControllingRuler==usr.name||usr.FactionApproved(Z6FactionCode,4)) CPs+="Dark Planet"
		if(Z7ControllingRuler==usr.name||usr.FactionApproved(Z7FactionCode,4)) CPs+="Space Station"
		CPs+="Cancel"
		var/CP=input("Which Control Point?") in CPs
		if(CP=="Cancel") return
		var/TaxRate = input("What percentage of mana and resources gains from this planet do you want to tax? (0 - 50%)") as num
		if(TaxRate < 0) TaxRate=0
		if(TaxRate > 50) TaxRate=50
		TaxRate=round(TaxRate)
		var/FT= input("Which rank of your faction and higher would you like immune to taxes? If you do not want anyone immune, set it to 0") as num
		switch(CP)
			if("Earth")
				Z1FactionTax=FT
				Z1Tax=TaxRate
			if("Namek")
				Z2FactionTax=FT
				Z2Tax=TaxRate
			if("Vegeta")
				Z3FactionTax=FT
				Z3Tax=TaxRate
			if("Icer")
				Z4FactionTax=FT
				Z4Tax=TaxRate
			if("Arconia")
				Z5FactionTax=FT
				Z5Tax=TaxRate
			if("Dark Planet")
				Z6FactionTax=FT
				Z6Tax=TaxRate
			if("Space Station")
				Z7FactionTax=FT
				Z7Tax=TaxRate
		usr << "You have set the Taxation Rate for z [CP] to [TaxRate] Percent."





	verb/Clear_Tax_Evaders()
		set category="Rank"
		var/list/CPs=list()
		if(Z1ControllingRuler==usr.name||usr.FactionApproved(Z1FactionCode,4)) CPs+="Earth"
		if(Z2ControllingRuler==usr.name||usr.FactionApproved(Z2FactionCode,4)) CPs+="Namek"
		if(Z3ControllingRuler==usr.name||usr.FactionApproved(Z3FactionCode,4)) CPs+="Vegeta"
		if(Z4ControllingRuler==usr.name||usr.FactionApproved(Z4FactionCode,4)) CPs+="Icer"
		if(Z5ControllingRuler==usr.name||usr.FactionApproved(Z5FactionCode,4)) CPs+="Arconia"
		if(Z6ControllingRuler==usr.name||usr.FactionApproved(Z6FactionCode,4)) CPs+="Dark Planet"
		if(Z7ControllingRuler==usr.name||usr.FactionApproved(Z7FactionCode,4)) CPs+="Space Station"
		CPs+="All"
		CPs+="Cancel"
		var/CP=input("Which Control Point?") in CPs
		if(CP=="Cancel") return
		switch(CP)
			if("All")
				if(Z1ControllingRuler==usr.name||usr.FactionApproved(Z1FactionCode,4))
					Z1MTaxEvaders=list()
					Z1TaxEvaders=list()
				if(Z2ControllingRuler==usr.name||usr.FactionApproved(Z2FactionCode,4))
					Z2MTaxEvaders=list()
					Z2TaxEvaders=list()
				if(Z3ControllingRuler==usr.name||usr.FactionApproved(Z3FactionCode,4))
					Z3MTaxEvaders=list()
					Z3TaxEvaders=list()
				if(Z4ControllingRuler==usr.name||usr.FactionApproved(Z4FactionCode,4))
					Z4MTaxEvaders=list()
					Z4TaxEvaders=list()
				if(Z5ControllingRuler==usr.name||usr.FactionApproved(Z5FactionCode,4))
					Z5MTaxEvaders=list()
					Z5TaxEvaders=list()
				if(Z6ControllingRuler==usr.name||usr.FactionApproved(Z6FactionCode,4))
					Z6MTaxEvaders=list()
					Z6TaxEvaders=list()
				if(Z7ControllingRuler==usr.name||usr.FactionApproved(Z7FactionCode,4))
					Z7MTaxEvaders=list()
					Z7TaxEvaders=list()
				usr<<"Reset all tax offenders on all controlled planets."
			if("Earth")
				var/T=input("Resources or Mana Tax Evaders?") in list("Resources","Mana")
				switch(T)
					if("Mana")
						var/C=input("Remove which offender?") in Z1MTaxEvaders
						Z1MTaxEvaders-=C
					if("Resources")
						var/C=input("Remove which offender?") in Z1TaxEvaders
						Z1TaxEvaders-=C
//				Z1TaxEvaders=new
//				Z1MTaxEvaders=new
			if("Namek")
				var/T=input("Resources or Mana Tax Evaders?") in list("Resources","Mana")
				switch(T)
					if("Mana")
						var/C=input("Remove which offender?") in Z2MTaxEvaders
						Z2MTaxEvaders-=C
					if("Resources")
						var/C=input("Remove which offender?") in Z2TaxEvaders
						Z2TaxEvaders-=C
//				Z2TaxEvaders=new
//				Z2MTaxEvaders=new
			if("Vegeta")
				var/T=input("Resources or Mana Tax Evaders?") in list("Resources","Mana")
				switch(T)
					if("Mana")
						var/C=input("Remove which offender?") in Z3MTaxEvaders
						Z3MTaxEvaders-=C
					if("Resources")
						var/C=input("Remove which offender?") in Z3TaxEvaders
						Z3TaxEvaders-=C
//				Z3TaxEvaders=new
//				Z3MTaxEvaders=new
			if("Icer")
				var/T=input("Resources or Mana Tax Evaders?") in list("Resources","Mana")
				switch(T)
					if("Mana")
						var/C=input("Remove which offender?") in Z4MTaxEvaders
						Z4MTaxEvaders-=C
					if("Resources")
						var/C=input("Remove which offender?") in Z4TaxEvaders
						Z4TaxEvaders-=C
//				Z4TaxEvaders=new
//				Z4MTaxEvaders=new
			if("Arconia")
				var/T=input("Resources or Mana Tax Evaders?") in list("Resources","Mana")
				switch(T)
					if("Mana")
						var/C=input("Remove which offender?") in Z5MTaxEvaders
						Z5TaxEvaders-=C
					if("Resources")
						var/C=input("Remove which offender?") in Z5TaxEvaders
						Z5TaxEvaders-=C
//				Z5TaxEvaders=new
//				Z5MTaxEvaders=new
			if("Dark Planet")
				var/T=input("Resources or Mana Tax Evaders?") in list("Resources","Mana")
				switch(T)
					if("Mana")
						var/C=input("Remove which offender?") in Z6MTaxEvaders
						Z6MTaxEvaders-=C
					if("Resources")
						var/C=input("Remove which offender?") in Z6TaxEvaders
						Z6TaxEvaders-=C
//				Z6TaxEvaders=new
//				Z6MTaxEvaders=new
			if("Space Station")
				var/T=input("Resources or Mana Tax Evaders?") in list("Resources","Mana")
				switch(T)
					if("Mana")
						var/C=input("Remove which offender?") in Z7MTaxEvaders
						Z7MTaxEvaders-=C
					if("Resources")
						var/C=input("Remove which offender?") in Z7TaxEvaders
						Z7TaxEvaders-=C
//				Z7TaxEvaders=new
//				Z7MTaxEvaders=new
	verb/Check_Control_Point()
		set category="Rank"
		var/list/CPs=list()
		if(Z1ControllingRuler==usr.name||usr.FactionApproved(Z1FactionCode,4)) CPs+="Earth"
		if(Z2ControllingRuler==usr.name||usr.FactionApproved(Z2FactionCode,4)) CPs+="Namek"
		if(Z3ControllingRuler==usr.name||usr.FactionApproved(Z3FactionCode,4)) CPs+="Vegeta"
		if(Z4ControllingRuler==usr.name||usr.FactionApproved(Z4FactionCode,4)) CPs+="Icer"
		if(Z5ControllingRuler==usr.name||usr.FactionApproved(Z5FactionCode,4)) CPs+="Arconia"
		if(Z6ControllingRuler==usr.name||usr.FactionApproved(Z6FactionCode,4)) CPs+="Dark Planet"
		if(Z7ControllingRuler==usr.name||usr.FactionApproved(Z7FactionCode,4)) CPs+="Space Station"
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
				