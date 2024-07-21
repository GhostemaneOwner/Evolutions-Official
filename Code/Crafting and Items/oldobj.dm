
proc/SpawnAndroidShip()
	set waitfor=0
	var/totalcount=0
	for(var/obj/AndroidShip/A in world)
		totalcount++
		if(Android==0) del(A)
	if(Android==0) return
	if(totalcount==1) return
	else if(totalcount<1)
		var/obj/AndroidShip/A = new
		A.loc = locate(164,322,12)
		A.Ship = 50
		log_errors("Found no androidships, added a new one.")
		src << "Found no androidships, added a new one."
	else if(totalcount>=1)
		for(var/obj/AndroidShip/A in world)
			del(A)
			break
		log_errors("Deleted a duplicate Androidship. [totalcount-1] ships remaining.")
		world << "Deleted a duplicate Androidship. [totalcount-1] ships remaining."

proc/SpawnArdent()
	var/totalcount=0
	for(var/obj/Ships/Ship/Ardent/B in world) totalcount++
	if(totalcount==1) return
	else if(totalcount<1)
		var/obj/Ships/Ship/Ardent/B = new
		B.loc = locate(190,222,12)
		log_errors("Found no Ardent, added a new one.")
		src << "Found no Ardent, added a new one."
	else if(totalcount>=1)
		for(var/obj/Ships/Ship/Ardent/B in world)
			del(B)
			break
		log_errors("Deleted duplicate Ardent. [totalcount-1] ships remaining.")
		src << "Deleted duplicate Ardent. [totalcount-1] ships remaining."

proc/SpawnIcebreaker()
	var/totalcount=0
	for(var/obj/Ships/Ship/Icebreaker/B in world) totalcount++
	if(totalcount==1) return
	else if(totalcount<1)
		var/obj/Ships/Ship/Icebreaker/B = new
		B.loc = locate(175,225,12)
		log_errors("Found no Icebreaker, added a new one.")
		src << "Found no Icebreaker, added a new one."
	else if(totalcount>=1)
		for(var/obj/Ships/Ship/Icebreaker/B in world)
			del(B)
			break
		log_errors("Deleted duplicate Icebreaker. [totalcount-1] ships remaining.")
		src << "Deleted duplicate Icebreaker. [totalcount-1] ships remaining."




obj
	TrainingEq
		density =1
		Flammable = 1
		var
			BP
			End
			P_BagG=1
			Leech_On=0

		Punchometer
			BP=100
			Health=10000
			End=500
			P_BagG=2
			icon='Punchometer.dmi'
			verb/Upgrade()
				set src in oview(1)
				for(var/obj/Resources/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value*(1-(0.15*usr.HasDeepPockets)))])") as num
					if(Amount>round(A.Value*(1-(0.15*usr.HasDeepPockets)))) Amount=round(A.Value*(1-(0.15*usr.HasDeepPockets)))
					if(Amount<0) Amount=0
					A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
					Amount*=usr.Int_Mod
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
					End=SoftStatCap
					BP=TrueBPCap*1.5
				desc="Health: [Health]"




		Dummy
			name="Log"
			icon='NEW DUMMY.dmi'
			icon_state="Off"
			desc = "You can strike this dummy, it will blink yellow in one of four different sides. Strike the correct side time after time to use this training tool effectively. Hitting the wrong side will incur the inability to gain stats for a time."
			BP=100
			Health=100
			End=250000
			P_BagG=8

			New()
				Health=100
				icon_state="Off"



			verb/Upgrade()
				set src in oview(1)
				var/R=input("Intelligence or Magic?") in list("Intelligence","Magic","Cancel")
				if(R=="Intelligence")
					for(var/obj/Resources/A in usr)
						var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value*(1-(0.15*usr.HasDeepPockets)))])") as num
						if(Amount>round(A.Value)) Amount=round(A.Value)
						if(Amount<0) Amount=0
						A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
						Amount*=usr.Int_Mod
						//Un_KO()
						Health+=Amount
						view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
					desc="Health: [Health]"
					icon_state="Off"
				if(R=="Magic")
					set src in oview(1)
					for(var/obj/Mana/A in usr)
						var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
						if(Amount>round(A.Value)) Amount=round(A.Value)
						if(Amount<0) Amount=0
						A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
						Amount*=usr.Magic_Potential
						//Un_KO()
						Health+=Amount
						view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
					desc="Health: [Health]"
					icon_state="Off"



		Magic_Goo
			icon='Magic Punching Bag.dmi'
			BP=100
			Health=100
			End=250000
			P_BagG=1.5
			New()
				Health=100
				icon_state=""

			verb/Enhance()
				set src in oview(1)
				for(var/obj/Mana/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value)])") as num
					if(Amount>round(A.Value)) Amount=round(A.Value)
					if(Amount<0) Amount=0
					A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
					Amount*=usr.Magic_Potential
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
				desc="Health: [Health]"
				icon_state=""
				if(P_BagG<usr.Magic_Potential*0.5) P_BagG=usr.Magic_Potential*0.5
				if(usr.Magic_Potential>=3)
					name="Tier 2 [initial(src.name)]"
					icon='MPB2.dmi'
				if(usr.Magic_Potential>=4)
					name="Tier 3 [initial(src.name)]"
					icon='MPB3.dmi'
				if(usr.Magic_Potential>=6)
					name="Tier 4 [initial(src.name)]"
					icon='MPB4.dmi'

		Punching_Bag
			icon='Punching Bag.dmi'
			BP=100
			Health=100
			End=250000
			P_BagG=1.5
			New()
				Health=100
				icon_state=""

			verb/Upgrade()
				set src in oview(1)
				for(var/obj/Resources/A in usr)
					var/Amount=input("How much endurance do you want to add? (Up to [Commas(A.Value*(1-(0.15*usr.HasDeepPockets)))])") as num
					if(Amount>round(A.Value*(1-(0.15*usr.HasDeepPockets)))) Amount=round(A.Value*(1-(0.15*usr.HasDeepPockets)))
					if(Amount<0) Amount=0
					A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
					Amount*=usr.Int_Mod
					//Un_KO()
					Health+=Amount
					view(usr)<<"[usr] added [Commas(Amount)] to the [src]'s armor"
				desc="Health: [Health]"
				icon_state=""
				if(P_BagG<usr.Int_Mod*0.5) P_BagG=usr.Int_Mod*0.5
				if(usr.Int_Mod>=2)
					name="Tier 2 [initial(src.name)]"
					icon='Punching Bag2.dmi'
				if(usr.Int_Mod>=3)
					name="Tier 3 [initial(src.name)]"
					icon='Punching Bag3.dmi'
				if(usr.Int_Mod>=4)
					name="Tier 4 [initial(src.name)]"
					icon='Punching Bag4.dmi'
				if(usr.Int_Mod>=5)
					name="Tier 5 [initial(src.name)]"
					icon='Punching Bag5.dmi'
				if(usr.Int_Mod>=6)
					name="Tier 6 [initial(src.name)]"
					icon='Punching Bag6.dmi'
