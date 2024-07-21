
mob/var/CanBeMagicScanned=1


obj/items/Scanner/verb/Scan()
	set category="Other"
	if(!usr.Toggled_Sense)
		usr.Toggled_Sense = 1
		winshow(usr.client,"ScanArea",1)
		usr << "You have made your scanner tab show."
		winset(usr.client,"GridSA","cells=0x0")
		usr.Sense_Update()
	else usr.Sense_Update()
obj/items/Magic_Scanner/verb/Scan()
	set category="Other"
	if(!usr.Toggled_Sense)
		usr.Toggled_Sense = 1
		winshow(usr.client,"ScanArea",1)
		usr << "You have made your scanner tab show."
		winset(usr.client,"GridSA","cells=0x0")
		usr.Sense_Update()
	else usr.Sense_Update()

mob/proc/Sense_Update()
	set background=1
	set waitfor=0
	//while(Toggled_Sense&&sense_tab_on&&src)
	var/atom/E
	if(S) E=S
	else E=src
	if(sense_tab_on)
		if(Toggled_Sense&&!afk)
			var/Scouter
			var/I=1
			if(ScouterOn)
				for(var/obj/items/Scanner/A in src) if(A.suffix)
					Scouter=1
					var/mob/Center
					if(usr.S) Center=S
					else Center=src
					src << output("Location:","ScanArea.GridSA:1,[I]")
					src << output("([E.x],[E.y],[E.z])","ScanArea.GridSA:2,[I]")
					for(var/mob/B in Mob_Range_Scanner(Center,round(A.Range)))if(!B.afk) if(B.HelmetOn<4)
						var/Scan=B.BP
						if(Scan>A.Scan) Scan="!?"
						else Scan=Commas(Scan)
						if(A.Implant)Scan=Commas(B.BP)
						if(isnull(B)||isnull(B.client)) continue
						if(B.GodKiActive) Scan="???"
						var/nameout="??? ([B.Signature])"
						for(var/obj/Contact/Z in Contacts) if(Z.Signature == B.Signature) nameout=Z.name
						if(B==src) nameout=B//.name
						I++
						src << output(nameout,"ScanArea.GridSA:1,[I]")
						src << output("[Scan], [get_dist(Center.loc,B.loc)] tiles [dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
					I++
						//Radar
					if(A.Detects)
						I++
						src << output("Radar","ScanArea.GridSA:1,[I]")
						for(var/obj/B) if(B.z==Center.z&&B.type==A.Detects) if(B.invisibility<=see_invisible) if(B.x>Center.x-A.Range&&B.x<Center.x+A.Range&&B.y>Center.y-A.Range&&B.y<Center.y+A.Range)
							if(!(B.type==/obj/Magic_Ball&&!B.icon_state))
								I++
								src << output("[dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
								src << output(B.name,"ScanArea.GridSA:1,[I]")
						for(var/mob/B in Mob_Range_Scanner(Center,round(A.Range))) for(var/obj/C in B) if(C.type==A.Detects)
							if(!(C.type==/obj/Magic_Ball&&!C.icon_state)) if(C.invisibility<=see_invisible)
								I++
								src << output("[dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
								src << output(B.name,"ScanArea.GridSA:1,[I]")
							//MagicScanner
					break
				if(!Scouter)for(var/obj/items/Magic_Scanner/A in src) if(A.suffix)
					Scouter=1
					var/mob/Center
					if(usr.S) Center=S
					else Center=src
					src << output("Location:","ScanArea.GridSA:1,[I]")
					src << output("([E.x],[E.y],[E.z])","ScanArea.GridSA:2,[I]")
					for(var/mob/B in Mob_Range_Scanner(Center,round(A.Range)))if(!B.afk)if(B.HelmetOn<4)
						var/Scan=B.BP
						var/ScanBase=B.MaxKi//B.Base*B.Body*min(2.5,1+((B.GravMastered/25)/25))*B.RPPower//B.Base
						if(Scan>A.Scan) Scan="!?"
						else Scan=Commas(Scan)
						if(ScanBase>A.Scan*0.5) ScanBase="!?"
						else ScanBase=Commas(ScanBase)
						if(B.CanBeMagicScanned==0) ScanBase="!?"
						if(isnull(B)||isnull(B.client)) continue
						if(B.GodKiActive) Scan="[Scan] (Unknown Energy Type)"
						I ++
						var/nameout="??? ([B.Signature])"
						for(var/obj/Contact/Z in Contacts) if(Z.Signature == B.Signature) nameout=B.name
						if(B==src) nameout=B//.name
						src << output(nameout,"ScanArea.GridSA:1,[I]")
						src << output("[Scan] (Ki: [ScanBase]), [get_dist(Center,B)] tiles [dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
					break
			else if(Race=="Android")
				var/mob/Center
				if(usr.S) Center=S
				else Center=src
				src << output("Location:","ScanArea.GridSA:1,[I]")
				src << output("([E.x],[E.y],[E.z])","ScanArea.GridSA:2,[I]")
				for(var/mob/B in Mob_Range_Scanner(Center,150))if(!B.afk)
					var/Scan=B.BP
					Scan=Commas(Scan)
					if(isnull(B)||isnull(B.client)) continue
					if(B.GodKiActive) Scan="???"
					var/nameout="??? ([B.Signature])"
					for(var/obj/Contact/Z in Contacts) if(Z.Signature == B.Signature) nameout=Z//.name
					if(B==src) nameout=B//.name
					I++
					src << output(nameout,"ScanArea.GridSA:1,[I]")
					src << output("[Scan], [get_dist(Center.loc,B.loc)] tiles [dir2text(get_dir(Center.loc,B.loc))]","ScanArea.GridSA:2,[I]")
				I++
			winset(client,"ScanArea.GridSA","cells=2x[I]")
//		sleep(30)



Skill/Support/Sense_Energy
	Experience=100
	Tier=1
	desc="Allows you to sense the energies within a given area."
	verb/Sense_Energy()
		set category="Other"
		for(var/mob/A in Mob_Range(usr,round(0.075*(usr.MaxKi)))) if(A.Race!="Android"&&!A.AndroidLevel)if(!A.adminDensity)if(!A.afk)
			var/s2u = "Power: "
			if(A.BP < usr.BP * 1.05 && A.BP > usr.BP * 0.95) s2u += "<font color='green'>Around your power</font>"
			else if(A.BP >= usr.BP * 10) s2u += "<font color='red'><b>Incomparably greater</b></font>"
			else if(A.BP >= usr.BP * 5) s2u += "<font color='red'><b>Immensely greater</b></font>"
			else if(A.BP >= usr.BP * 2.5) s2u += "<font color='#FF2A00'>Much greater</font>"
			else if(A.BP >= usr.BP * 2) s2u += "<font color='#FF2A00'>Roughly double</font>"
			else if(A.BP >= usr.BP * 1.5) s2u += "<font color='#FF2A00'>Greater</font>"
			else if(A.BP >= usr.BP * 1.25) s2u += "<font color='yellow'>Above</font>"
			else if(A.BP >= usr.BP * 1.05) s2u += "<font color='yellow'>A bit above</font>"
			else if(A.BP <= usr.BP * 0.1) s2u += "Nothing in comparison"
			else if(A.BP <= usr.BP * 0.2) s2u += "Severely lesser"
			else if(A.BP <= usr.BP * 0.4) s2u += "Much lesser"
			else if(A.BP <= usr.BP * 0.5) s2u += "Roughly half"
			else if(A.BP <= usr.BP * 0.66) s2u += "Lesser"
			else if(A.BP <= usr.BP * 0.8) s2u += "Below"
			else if(A.BP <= usr.BP * 0.95) s2u += "A bit below"
			else if(A.GodKiActive&&!usr.GodKiActive) s2u += "Makes you feel uneasy."
			else s2u += "Unidentifiable."
			var/nameout="??? ([A.Signature])"
			var/Manahas
			for(var/obj/Mana/Ma in A) Manahas=Ma.Value
			if(usr.Race=="Spirit Doll") nameout="[nameout] ([Manahas] Mana)"
			for(var/obj/Contact/Z in usr.Contacts) if(Z.Signature == A.Signature) nameout=A//.name
			if(A.HelmetOn<4) usr.AllOut("[nameout] [s2u] [dir2text(get_dir(usr.loc,A.loc))]")

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

/*
mob/verb/MapTextTest()
	var/image/O = new
	O.maptext="<font color=#a81202><span class=\"overs\">T</span></font>"
	O.maptext_y=-8
	O.maptext_x=13
	O.maptext_width=64
	O.layer=MOB_LAYER+EFFECTS_LAYER+10
	O.loc=usr
	usr<<O*/
mob/verb/Toggle_Scouter_Overlays()
	set category=null
	if(usr.ShowScouterOn)
		usr.ShowScouterOn = 0
		usr << "You have made Scouter Overlays hidden."
		return
	else
		usr.ShowScouterOn = 1
		usr << "You have made Scouter Overlays show."
		return

mob/verb/Toggle_Languages()
	set category=null
	if(usr.ShowLanguages)
		usr.ShowLanguages = 0
		usr << "You have made Languages hidden."
		return
	else
		usr.ShowLanguages = 1
		usr << "You have made Languages show."
		return
mob/var/ShowLanguages=0
mob/var/ShowBodyParts=0
mob/verb/Toggle_Body_Parts()
	set category=null
	if(usr.ShowBodyParts)
		usr.ShowBodyParts = 0
		usr << "You have made Body Parts hidden."
		return
	else
		usr.ShowBodyParts = 1
		usr << "You have made Body Parts show."
		return


mob/var/ShowScouterOn=1
mob/var/tmp/ScouterUpdates=0
mob/proc/addBPs()
	set waitfor=0
	if(Race=="Android")ScouterOn=1.#INF
	if(ScouterOn&&ShowScouterOn)
		ScouterUpdates++
		if(ScouterUpdates==1)
			for(var/mob/player/P in view(10)) if(P.HelmetOn<4)
				var/image/O = new
				O.maptext="<font color=#ffffff><span class=\"overs\">[ScouterDispNum(P.BP,ScouterOn)]</font>"
				O.maptext_y=34+(P.HealthBar.pixel_y-4)
				O.maptext_width=64
				O.layer=MOB_LAYER+EFFECTS_LAYER+10
				O.loc=P
				src<<O
				spawn(76) del O
		if(ScouterUpdates>=5)ScouterUpdates=0
proc/ScouterDispNum(var/Num,var/MaxP=10000)
	if(isnum(Num))
		var/NN=Num
		if(Num>MaxP) NN = "!?!?"
		else if(Num>1000000)
			NN/=1000000
			NN=round(NN,0.1)
			NN="[Commas(NN)] M"
		else if(Num>25000)
			NN/=1000
			NN=round(NN,0.1)
			NN="[Commas(NN)] K"
		else NN="[Commas(NN)]"
		return NN


