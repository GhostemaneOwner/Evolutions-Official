mob/proc/Mod_Variance(forced=0)
	if(!forced)
		Mutations=new/list()
		MutationNumber=0
//		FBMAt=1000000
		GeneticDecline=Decline
		GeneticMagic_Potential=Magic_Potential
		GeneticInt_Mod=Int_Mod
		GeneticBPMod=BPMod
		GeneticFBMMult=FBMMult
		GeneticMaxAnger=BaseMaxAnger
		GeneticKiMod=KiMod
		GeneticStrMod=StrMod
		GeneticEndMod=EndMod
		GeneticSpdMod=SpdMod
		GeneticOffMod=OffMod
		GeneticDefMod=DefMod
		GeneticRegeneration=BaseRegeneration
		GeneticRecovery=BaseRecovery
		GeneticDeathRegen=Regenerate
	if(Offspring) if(Racial_Stats<2) Racial_Stats=2
	if(Offspring) while(Racial_Stats>0)
		var/rr=rand(1,9)
		switch(rr)
			if(1) if(!UniqueMutation)
				BPMod*=1.05
				Racial_Stats--
				Mutations+="BP Mod"
				MutationNumber++
				UniqueMutation=1
			if(2) if(!UniqueMutation)
				if(Race!="Android"&&BaseMaxAnger>100)
					BaseMaxAnger*=1.05
					Racial_Stats--
					Mutations+="Max Anger"
					MutationNumber++
					UniqueMutation=1
			if(3) if(StrMod>1.5)
				StrMod*=1.1
				Racial_Stats--
				Mutations+="Strength Mod"
				MutationNumber++
			if(4) if(EndMod>1.5)
				EndMod*=1.1
				Racial_Stats--
				Mutations+="Endurance Mod"
				MutationNumber++
			if(5) if(SpdMod>1.5)
				SpdMod*=1.1
				Racial_Stats--
				Mutations+="Speed Mod"
				MutationNumber++
			if(6) if(StrMod>1.5)
				StrMod*=1.1
				Racial_Stats--
				Mutations+="Strength Mod"
				MutationNumber++
			if(7) if(OffMod>1.5)
				OffMod*=1.1
				Racial_Stats--
				Mutations+="Offense Mod"
				MutationNumber++
			if(8) if(DefMod>1.5)
				DefMod*=1.1
				Racial_Stats--
				Mutations+="Defense Mod"
				MutationNumber++
			if(9) if(!UniqueMutation)
				BaseRecovery*=1.05
				Racial_Stats--
				Mutations+="Recovery"
				MutationNumber++
				UniqueMutation=1
mob/proc/GetMutation()
	var/GotIt=1
	while(GotIt)
		var/rr=rand(1,9)
		switch(rr)
			if(1) if(!UniqueMutation)
				BPMod*=1.05
				GotIt--
				Mutations+="BP Mod"
				MutationNumber++
				UniqueMutation=1
			if(2) if(!UniqueMutation)
				if(Race!="Android"&&BaseMaxAnger>100)
					BaseMaxAnger*=1.05
					GotIt--
					Racial_Stats--
					Mutations+="Max Anger"
					MutationNumber++
					UniqueMutation=1
			/*if(3)
				KiMod*=1.1
				GotIt--
				Mutations+="Ki Mod"
				MutationNumber++*/
			if(3) if(StrMod>1.5)
				StrMod*=1.1
				GotIt--
				Mutations+="Strength Mod"
				MutationNumber++
			if(4) if(EndMod>1.5)
				EndMod*=1.1
				GotIt--
				Mutations+="Endurance Mod"
				MutationNumber++
			if(5) if(SpdMod>1.5)
				SpdMod*=1.1
				GotIt--
				Mutations+="Speed Mod"
				MutationNumber++
			if(6) if(StrMod>1.5)
				StrMod*=1.1
				GotIt--
				Mutations+="Strength Mod"
				MutationNumber++
			if(7) if(OffMod>1.5)
				OffMod*=1.1
				GotIt--
				Mutations+="Offense Mod"
				MutationNumber++
			if(8) if(DefMod>1.5)
				DefMod*=1.1
				GotIt--
				Mutations+="Defense Mod"
				MutationNumber++
			if(9) if(!UniqueMutation)
				BaseRecovery*=1.05
				GotIt--
				Mutations+="Recovery"
				MutationNumber++
				UniqueMutation=1

mob/proc/AssignMutation(var/mob/player/A in world)
	var/list/mutations_list = list(
		"Cancel",
		"Remove All Mutations",
		"BP Mod",
		"Max Anger",
		"Strength Mod",
		"Endurance Mod",
		"Speed Mod",
		"Offense Mod",
		"Defense Mod",
		"Recovery"
	)
	var/mutationType = input(usr, "Choose the mutation you'd like to give, remove all mutations or cancel:", "Assign Mutation", "") as null|anything in mutations_list
	if(!mutationType || mutationType == "Cancel") return // The user canceled the selection or chose 'Cancel'

	if(mutationType == "Remove All Mutations")
		for(var/mutation in A.Mutations)
			switch(mutation)
				if("BP Mod")
					A.BPMod /= 1.05
				if("Max Anger")
					A.BaseMaxAnger /= 1.05
				if("Strength Mod")
					A.StrMod /= 1.1
				if("Endurance Mod")
					A.EndMod /= 1.1
				if("Speed Mod")
					A.SpdMod /= 1.1
				if("Offense Mod")
					A.OffMod /= 1.1
				if("Defense Mod")
					A.DefMod /= 1.1
				if("Recovery")
					A.BaseRecovery /= 1.05
		A.Mutations = list()
		A.MutationNumber = 0
		A.UniqueMutation = 0
		alertAdmins("[key_name(usr)] removed all mutations from [key_name(A)].", 1)
		log_admin("[key_name(usr)] removed all mutations from [key_name(A)].", 1)
	else
		if(A.MutationNumber >= 2)
			usr << "No more than 2 mutations can be assigned."
			return

		switch(mutationType)
			if("BP Mod")
				if(A.UniqueMutation)
					usr << "Only one unique mutation can be assigned."
					return
				A.BPMod*=1.05
				A.Mutations+="BP Mod"
				A.UniqueMutation++
			if("Max Anger")
				if(A.Race!="Android"&&A.BaseMaxAnger>100)
					if(UniqueMutation)
						usr << "Only one unique mutation can be assigned."
						return
					A.BaseMaxAnger*=1.05
					A.Racial_Stats--
					A.Mutations+="Max Anger"
					A.UniqueMutation++
			if("Strength Mod") if(StrMod > 1.5)
				A.StrMod *= 1.1
				A.Mutations += "Strength Mod"
			if("Endurance Mod") if(EndMod > 1.5)
				A.EndMod *= 1.1
				A.Mutations += "Endurance Mod"
			if("Speed Mod") if(SpdMod > 1.5)
				A.SpdMod *= 1.1
				A.Mutations += "Speed Mod"
			if("Offense Mod") if(OffMod > 1.5)
				A.OffMod *= 1.1
				A.Mutations += "Offense Mod"
			if("Defense Mod") if(DefMod > 1.5)
				A.DefMod *= 1.1
				A.Mutations += "Defense Mod"
			if("Recovery")
				if(UniqueMutation)
					usr << "Only one unique mutation can be assigned."
					return
				A.BaseRecovery *= 1.05
				A.Mutations += "Recovery"
				A.UniqueMutation++

		A.MutationNumber++
		log_admin("[key_name(usr)] assigned [key_name(A)] the [mutationType] mutation.", 1)
		alertAdmins("[key_name(usr)] assigned [key_name(A)] the [mutationType] mutation.", 1)
