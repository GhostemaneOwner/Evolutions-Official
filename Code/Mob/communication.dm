/proc/stars(n, pr)	//Use if someone can't understand what's being said
	if (pr == null)
		pr = 25
	if (pr <= 0)
		return null
	else
		if (pr >= 100)
			return n
	var/te = n
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		if ((copytext(te, p, p + 1) == " " || prob(pr)))
			t = text("[][]", t, copytext(te, p, p + 1))
		else
			t = text("[]*", t)
		p++
	return t

/proc/stutter(n)	//Returns a staggered version of input
	var/te = html_decode(n)
	var/t = ""
	n = length(n)
	var/p = null
	p = 1
	while(p <= n)
		var/n_letter = copytext(te, p, p + 1)
		if (prob(80))
			if (prob(10))
				n_letter = text("[n_letter][n_letter][n_letter][n_letter]")
			else
				if (prob(20))
					n_letter = text("[n_letter][n_letter][n_letter]")
				else
					if (prob(5))
						n_letter = null
					else
						n_letter = text("[n_letter][n_letter]")
		t = text("[t][n_letter]")
		p++
	return copytext(sanitize(t),1,MAX_MESSAGE_LEN)


mob/verb/Countdown()
	set category=null//"Other"
	if(ActionCheck) return
	ActionCheck=1
	spawn(15)ActionCheck=0
	var/Cho=input("Choose a countdown type") in list("30 seconds","60 seconds","Cancel")
	switch(Cho)
		if("30 seconds")
			for(var/mob/M in range(20,usr))
				//if(M.CDMode==1) CDers+=M
				M.BuffOut("<font color = red>[src] is waiting 30 seconds.")
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] is waiting 30 seconds.\n")
			//spawn(300) for(var/mob/M in range(20,usr)) M.AllOut("[usr] has finished their countdown.")
			//spawn(1) CountDown(30,CDers,usr)
			spawn(190)
				if(usr)
					for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
					//	M.AllOut("<font color = red>10")
						M.BuffOut("<font color = red>10")
						//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 20 seconds.\n")
					spawn(10)
						if(usr)
							for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
								//M.AllOut("<font color = red>9")
								M.BuffOut("<font color = red>9")
								//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 21 seconds.\n")
							spawn(10)
								if(usr)
									for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
										//M.AllOut("<font color = red>8")
										M.BuffOut("<font color = red>8")
										//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 22 seconds.\n")
									spawn(10)
										if(usr)
											for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
											//	M.AllOut("<font color = red>7")
												M.BuffOut("<font color = red>7")
												//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 23 seconds.\n")
											spawn(10)
												if(usr)
													for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
														//M.AllOut("<font color = red>6")
														M.BuffOut("<font color = red>6")
														//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 24 seconds.\n")
													spawn(10)
														if(usr)
															for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																//M.AllOut("<font color = red>5")
																M.BuffOut("<font color = red>5")
																//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 25 seconds.\n")
															if(RPMode)
																//for(var/obj/RPMode/O in usr) for(var/mob/M in usr.Affected) if(M.RPMode) M.RPMode(usr)
																RPMode()
															spawn(10)
																if(usr)
																	for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																		//M.AllOut("<font color = red>4")
																		M.BuffOut("<font color = red>4")
																		//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 26 seconds.\n")
																	spawn(10)
																		if(usr)
																			for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																				//M.AllOut("<font color = red>3")
																				M.BuffOut("<font color = red>3")
																				//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 27 seconds.\n")
																			spawn(10)
																				if(usr)
																					for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																						//M.AllOut("<font color = red>2")
																						M.BuffOut("<font color = red>2")
																						//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 28 seconds.\n")
																					spawn(10)
																						if(usr)
																							for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																								//M.AllOut("<font color = red>1")
																								M.BuffOut("<font color = red>1")
																								//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 29 seconds.\n")
																							spawn(10)
																								if(usr)
																									for(var/mob/M in range(20,usr))
																										//M.AllOut("<font color = red>GO!")
																										M.BuffOut("<font color = red>GO!")
																										//M.AllOut("[usr] has finished their countdown.")
																										M.BuffOut("[usr] has finished their countdown.")
																										usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 30 seconds.\n")
		if("60 seconds")
			for(var/mob/M in range(20,usr))
				M.BuffOut("<font color = red>[src] is waiting 60 seconds.")
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] is waiting 60 seconds.\n")
			spawn(300)
				if(usr)
					for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
						M.BuffOut("<font color = red>[src] is waiting 60 seconds (30).")
						//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] [src] is waiting 60 seconds (30).\n")
					spawn(150)
						if(usr)
							for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
								M.BuffOut("<font color = red>[src] is waiting 60 seconds (15).")
								//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] [src] is waiting 60 seconds (15).\n")
							spawn(150)
								if(usr)
									for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
										M.BuffOut("<font color = red>[src]. 10")
									//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 20 seconds.\n")
									spawn(10)
										if(usr)
											for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
												M.BuffOut("<font color = red>[src]. 9")
											//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 21 seconds.\n")
											spawn(10)
												if(usr)
													for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
														M.BuffOut("<font color = red>[src]. 8")
													//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 22 seconds.\n")
													spawn(10)
														if(usr)
															for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																M.BuffOut("<font color = red>[src]. 7")
															//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 23 seconds.\n")
															spawn(10)
																if(usr)
																	for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																		M.BuffOut("<font color = red>[src]. 6")
																	//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 24 seconds.\n")
																	spawn(10)
																		if(usr)
																			for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																				M.BuffOut("<font color = red>[src]. 5")
																		//		//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 25 seconds.\n")
																			spawn(10)
																				if(usr)
																					for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																						M.BuffOut("<font color = red>[src]. 4")
																					//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 26 seconds.\n")
																					spawn(10)
																						if(usr)
																							for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																								M.BuffOut("<font color = red>[src]. 3")
																							//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 27 seconds.\n")
																							spawn(10)
																								if(usr)
																									for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																										M.BuffOut("<font color = red>[src]. 2")
																									//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 28 seconds.\n")
																									spawn(10)
																										if(usr)
																											for(var/mob/M in range(20,usr)) //if(M.CDMode==0)
																												M.BuffOut("<font color = red>[src]. 1")
																											//	//M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 29 seconds.\n")
																											spawn(10)
																												if(usr)
																													for(var/mob/M in range(20,usr))
																														M.BuffOut("<font color = red>[src] has successfully waited 60 seconds.")
																													usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has successfully waited 60 seconds..\n")



/*
obj/items/Null_Magic_Zone_Generator
	icon='enchantmenticons.dmi'
	icon_state="ArcanOrb"
	desc="This item will generate a field that disables the enchantments of all "

*/

mob/var/HasBeenInfected=0
mob/var/FleeAdd=0
mob/verb/Flee()
	set category="Other"
//	usr<<"Flee rules have changed. (Essentially, all parties attempting to Flee use the flee command to get their 'speed' and then the chasers do the same.  If the chasers win, another round of combat happens, if those fleeing win, they can run away.)"
	var/Which=input("Fleeing or Chasing?") in list("Flee","Chase","Cancel")
	if(Which=="Cancel") return
	var/FromWho
	if(Which=="Chase") FromWho=input("Chase who?") as mob in oview(usr)
	var/FleeRoll=rand(1,20)
	var/RollAdd=0
	if(locate(/Skill/Misc/Fly) in usr) RollAdd++
	if(locate(/Skill/Zanzoken) in usr) RollAdd++
	if(locate(/Skill/Buff/Godspeed) in usr) RollAdd++
	if(locate(/Skill/Attacks/SolarFlare) in usr) RollAdd+=2
	if(locate(/Skill/Support/Teleport) in usr) RollAdd+=4
	else if(locate(/Skill/Support/DemonTeleport) in usr) RollAdd+=4
	else if(locate(/Skill/Support/InstantTransmission) in usr) RollAdd+=3
	else if(locate(/Skill/Spell/Create_Portal) in usr) RollAdd+=2
	else if(locate(/obj/items/Transporter_Watch) in usr) RollAdd+=2
	if(locate(/Skill/Support/Invisibility) in usr) RollAdd+=3
	else if(locate(/obj/items/Cloak_Controls) in usr) RollAdd+=2
	if(locate(/obj/items/Aspect_of_Flight) in usr) RollAdd+=3
	if(HasSwiftReflexes) RollAdd++
	if(HasDeftHands) RollAdd++
	if(HasCooldownMastery) RollAdd++
	if(HasZanzokenMaster) RollAdd++
	if(HasFlightMaster) RollAdd++
	if(Cyber_Right_Leg) RollAdd++
	if(Cyber_Left_Leg) RollAdd++
	if(Precognition) RollAdd+=3
	if(HasRapidDeployment)RollAdd+=2
	//if(HasBeastOfBurden) RollAdd--
	if(HasSturdyBuild) RollAdd--
	RollAdd+=round(SpdMod*1.5)
	if(Willpower/MaxWillpower<0.7) RollAdd--
	if(Willpower/MaxWillpower<0.5) RollAdd--
	if(Willpower/MaxWillpower<0.3) FleeRoll=max(1,FleeRoll-4)
	if(Willpower/MaxWillpower<0.2) RollAdd--
	if(Willpower/MaxWillpower<0.1) RollAdd--
	for(var/mob/M in range(20,usr))
		if(Which=="Flee") M.AllOut("<font color = red>[usr] attempted to [Which] and got [FleeRoll+RollAdd+usr.FleeAdd] ([FleeRoll] + <font color=yellow>[RollAdd+usr.FleeAdd]<font color = red>).")
		else M.AllOut("<font color = red>[usr] attempted to [Which] [FromWho] and got [FleeRoll+RollAdd+usr.FleeAdd] ([FleeRoll] + <font color=yellow>[RollAdd+usr.FleeAdd]<font color = red>).")
		M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] attempted to Flee/Chase and got [FleeRoll+RollAdd+FleeAdd] ([FleeRoll] + [RollAdd+usr.FleeAdd])\n")



mob/verb/Discord()
	set category=null
	usr<<link("https://discord.gg/h6J5CHGBg2")
mob
	var// Tab variables
		tmp/Toggled_Sense = 0
		Toggled_Timestamps=0
		tmp/Lethality=0
		SOverlayToggle=1
		BodyHUD=1
		viewStats=1

mob/verb/Toggle_BodyHUD()
	set category=null
	if(usr.BodyHUD)
		usr.BodyHUD = 0
		usr << "You have turned off the Body HUD."
	else
		usr.BodyHUD = 1
		usr << "You have turned on the Body HUD."
	BodyHUD()
mob/verb/Toggle_Timestamps()
	set category=null
	if(usr.Toggled_Timestamps)
		usr.Toggled_Timestamps = 0
		usr << "You have made OOC timestamps hidden."
		return
	else
		usr.Toggled_Timestamps = 1
		usr << "You have made OOC timestamps show."
		return

mob/verb/RNG()
	//set name = "Random Number Generator"
	//set category = "Other"
	var/L=input(usr,"Lowest number. (0 minimum)") as num
	var/H=input(usr,"Highest number. (1000 maximum)") as num
	if(L<0)L=0
	if(H>1000)H=1000
	if(L && H)
		var/N = rand(L,H)
		view(10,usr)<<"[usr] used RNG and rolled between [L] and [H] to get [N]."
mob/verb/Toggle_Status_Overlays()
	set category=null//"Other"
	if(usr.SOverlayToggle)
		usr.SOverlayToggle = 0
		usr << "Status overlays turned off."
		winset(usr.client,"LETHAL","is-visible=false")
		winset(usr.client,"INVIS","is-visible=false")
		winset(usr.client,"GLOVES","is-visible=false")
		winset(usr.client,"lethalcombat","is-visible=false")
//		winset(src.client,"guardB","is-visible=false")
		return
	else
		usr.SOverlayToggle = 1
		usr << "Status overlays on."
		if(usr.Lethality == 1) winset(usr.client,"LETHAL","is-visible=true")
		if(usr.invisibility >= 1) winset(usr.client,"INVIS","is-visible=true")
		if(usr.LethalCombatTracker) winset(usr.client,"lethalcombat","is-visible=true")
		for(var/obj/items/Boxing_Gloves/A in usr) if(A.suffix=="*Equipped*") winset(usr.client,"GLOVES","is-visible=true")
		return

mob/proc/SetStatusOverlays()
	if(usr.SOverlayToggle==0)
		//usr.SOverlayToggle = 0
		//usr << "Status overlays turned off."
		winset(usr.client,"LETHAL","is-visible=false")
		winset(usr.client,"INVIS","is-visible=false")
		winset(usr.client,"GLOVES","is-visible=false")
		winset(usr.client,"lethalcombat","is-visible=false")
//		winset(src.client,"guardB","is-visible=false")
	else
		//usr.SOverlayToggle = 1
		//usr << "Status overlays on."
		if(usr.Lethality == 1) winset(usr.client,"LETHAL","is-visible=true")
		if(usr.invisibility >= 1) winset(usr.client,"INVIS","is-visible=true")
		if(usr.LethalCombatTracker) winset(usr.client,"lethalcombat","is-visible=true")
		for(var/obj/items/Boxing_Gloves/A in usr) if(A.suffix=="*Equipped*") winset(usr.client,"GLOVES","is-visible=true")



mob/verb/Toggle_Lethality()
	set category=null//"Other"
	if(!HasCreated)
		usr<<"You must create a character first."
		return
	if(usr.Spar)
		usr.Spar = 0
		usr.Lethality = 1
		usr.overlays+='Lethal_Hud.dmi'
		usr << "You will now try to kill your opponent."
		for(var/obj/items/Boxing_Gloves/A in usr) if(A.suffix)
			A.suffix=null
			winset(usr.client,"GLOVES","is-visible=false")
			usr.overlays-=A.icon
			view(20,usr) << "[usr] removes the [A]."
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [A]\n")
		for(var/obj/items/Weights/A in usr) if(A.suffix)
			A.suffix=null
			usr.overlays-=A.icon
			view(20,usr) << "[usr] takes off the [A]."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes the [A].\n")

		for(var/obj/items/Sword/Practice_Sword/A in usr) if(A.suffix)
			usr.SwordOn=0
			var/image/_overlay = image(A.icon)
			_overlay.pixel_x = A.pixel_x
			_overlay.pixel_y = A.pixel_y
			_overlay.layer= A.layer
			usr.overlays-=_overlay
			if(usr.HasSwordsman) usr.OffMult/=(A.Off+0.08)
			else usr.OffMult/=A.Off
			usr.Equip_Magic(src,"Remove")
			for(var/Skill/Buff/Armament/SF in usr) if(SF.Using) SF.use(usr)
			for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [A].")
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [A]\n")

		oview(10,usr) << "<font color = green>[usr]'s eyes gloss over as their actions shift to lethal intent."
		winset(src.client,"LETHAL","is-visible=true")
		//UpdateStats("Lethality")
		return
	else
		usr.Spar = 1
		usr.Lethality = 0
		usr.overlays-='Lethal_Hud.dmi'
		usr << "You will no longer try to kill your opponent."
		oview(10,usr) << "<font color = green>[usr]'s eyes seem to brighten as they cease their lethal intentions."
		winset(src.client,"LETHAL","is-visible=false")
		//UpdateStats("Lethality")
		return


//	addBPs()

mob/verb/PopupChat()
	set category=null
	winshow(usr.client,"chat3",1)


mob/verb/SenseClose()
	set category=null
	winshow(usr.client,"ScanArea",0)
	usr.Toggled_Sense = 0
	usr << "You have made your scanner tab hidden."



mob/var
	TextColorOOC = "red"
	TextColor="red"
mob/verb
	Text_Size()
		set category=null
		TextSize=input("Enter a size for the text you will see on your screen, between 1 and 10, default is 2") as num
	Text_Color()
		set category=null
		TextColor=input("Choose a color for IC.") as color
		TextColorOOC=input("Choose a color for OOC.") as color

/*obj/Nitro_Booster
	verb/Font_Style()
		set category="Other"
		if(!usr.NitroBooster)
			src << "You must be a Nitro Booster to have access to this feature!"
			return
		var/PP=input("Which font would you like to use?","Font Selection") in list("Default","Abril Fatface","Acme","Amatic SC","Anton","Big Shoulders Displau","Cinzel","Crimson Text","Fjalla One","Snell Roundhand","Papyrus","Brush Script MT","New Century School Book","Courier New","Trattatello","Comic Sans MS","Times New Roman","Hepta Slab","Hind","Inconsolata","Kanit","Karla","Libre Baskerville","Lobster","Mansalva","Maven Pro","Montserrat","News Cycle","Noto Sans JP","Noto Sans KR","Open Sans","Open Sans Condensed","Oswald","PT Sans","Righteous","Roboto","Roboto Mono","Source Code Pro","Source Serif Pro","Titillium Web","Turret Road","Ubuntu","Vollkorn","Yanone Kaffeesatz", "Cancel")

*/
mob/verb/OOC_Font_Style()
	set category="Other"


	var/list/Selection=list("Default","Abril Fatface","Amatic SC","Anton","Big Shoulders Display","Cinzel","Crimson Text","Snell Roundhand","Papyrus","Brush Script MT","New Century School Book","Courier New","Times New Roman","Hepta Slab","Inconsolata","Libre Baskerville","Mansalva","Maven Pro","Montserrat","News Cycle","Noto Sans JP","Noto Sans KR","Oswald","Roboto","Source Code Pro","Source Serif Pro","Titillium Web","Turret Road","Vollkorn")
	if(NitroBooster)Selection=list("Default","Abril Fatface","Amatic SC","Anton","Big Shoulders Display","Cinzel","Crimson Text","Snell Roundhand","Papyrus","Brush Script MT","New Century School Book","Courier New","Comic Sans MS","Times New Roman","Hepta Slab","Inconsolata","Libre Baskerville","Mansalva","Maven Pro","Montserrat","News Cycle","Noto Sans JP","Noto Sans KR","Oswald","Roboto","Source Code Pro","Source Serif Pro","Titillium Web","Turret Road","Vollkorn")
	//removed after first wipe
	Selection=list("Default","Abril Fatface","Amatic SC","Anton","Big Shoulders Display","Cinzel","Crimson Text","Snell Roundhand","Papyrus","Brush Script MT","New Century School Book","Courier New","Comic Sans MS","Times New Roman","Hepta Slab","Inconsolata","Libre Baskerville","Mansalva","Maven Pro","Montserrat","News Cycle","Noto Sans JP","Noto Sans KR","Oswald","Roboto","Source Code Pro","Source Serif Pro","Titillium Web","Turret Road","Vollkorn")
	//Selection+="Cancel"

	var/PP=input("Which font would you like to use?","Font Selection") in Selection
	switch(PP)
		if("Default") usr.Font="name"
//		if("Snell Roundhand") usr.Font="snellroundhand"
		if("Abril Fatface") usr.Font="abrilfatface"
//		if("Acme") usr.Font="acme"
		if("Papyrus") usr.Font="papyrus"
		if("Amatic SC") usr.Font="amaticsc"
		if("Brush Script MT") usr.Font="brushscriptmt"
		if("Anton") usr.Font="anton"
		if("New Century School Book") usr.Font="newcenturyschoolbook"
		if("Big Shoulders Display") usr.Font="bigshouldersdisplay"
		if("Courier New") usr.Font="couriernew"
//		if("Trattatello") usr.Font="trattatello"
		if("Cinzel") usr.Font="cinzel"
		if("Crimson Text") usr.Font="crimsontext"
		if("Comic Sans MS") usr.Font="comicsansms"
//		if("Fjalla One") usr.Font="fjallaone"
		if("Times New Roman") usr.Font="timesnewroman"
		if("Hepta Slab") usr.Font="heptaslab"
//		if("Hind") usr.Font="hind"
		if("Inconsolata") usr.Font="inconsolata"
//		if("Kanit") usr.Font="kanit"
//		if("Karla") usr.Font="karla"
		if("Libre Baskerville") usr.Font="librebaskerville"
//		if("Lobster") usr.Font="lobster"
		if("Mansalva") usr.Font="mansalva"
		if("Maven Pro") usr.Font="mavenpro"
		if("Montserrat") usr.Font="montserrat"
		if("News Cycle") usr.Font="newscycle"
		if("Noto Sans JP") usr.Font="notosansjp"
		if("Noto Sans KR") usr.Font="notosanskr"
//		if("Open Sans") usr.Font="opensans"
//		if("Open Sans Condensed") usr.Font="opensanscondensed"
		if("Oswald") usr.Font="oswald"
//		if("PT Sans") usr.Font="ptsans"
	//	if("Righteous") usr.Font="righteous"
		if("Roboto") usr.Font="roboto"
//		if("Roboto Mono") usr.Font="robotomono"
		if("Source Code Pro") usr.Font="sourcecodepro"
		if("Source Serif Pro") usr.Font="sourceserifpro"
		if("Titillium Web") usr.Font="titilliumweb"
		if("Turret Road") usr.Font="turretroad"
//		if("Ubuntu") usr.Font="ubuntu"
		if("Vollkorn") usr.Font="vollkorn"
//		if("Yanone Kaffeesatz") usr.Font="yanonekaffeesatz"
	usr << "Your font has been changed to <span class=\"[Font]\">[usr.Font]!</span>"



mob/var/listen_ooc=1
/mob/verb/listen_ooc()
	set name = ".ToggleOOC"
	set hidden=1
	if(src.client)
		src.client.listen_ooc = !src.client.listen_ooc
		listen_ooc=src.client.listen_ooc
		if (src.client.listen_ooc) src << "You are now listening to messages on the OOC channel."
		else src << "You are no longer listening to messages on the OOC channel."
mob/var/listen_looc=1
/mob/verb/listen_looc()
	set name = ".ToggleLOOC"
	set hidden=1
	if(src.client)
		src.listen_looc= !src.listen_looc
		if(src.listen_looc) src << "You are now listening to messages on the Local OOC channel."
		else src << "You are no longer listening to messages on the Local OOC channel."
mob/verb/AFK()
	//set category = "Other"
	usr.TRIGGER_AFK()

 
mob/proc/AFKAdd()
		var/image/_overlay = image('afktag.dmi',layer=MOB_LAYER+EFFECTS_LAYER+1) // In order to get pixel offsets to stick to overlays we create an image
		overlays += _overlay
mob/proc/AFKRemove()
		var/image/_overlay = image('afktag.dmi',layer=MOB_LAYER+EFFECTS_LAYER+1) // not sure if the equipped thing is an icon/object so
		overlays -= _overlay
mob/proc/TRIGGER_AFK(var/A=0)
	if(src.insideTank)
		src << "Unable to go afk inside a cloning tank."
		return
	if(src.insidePhylactery)
		src << "Unable to go afk while using a Phylactery."
		return
	if(src.afk)
		/*for(var/obj/Rank/R in Rankings)
			if(R.Rank_Key)
				var/mob/M = null
				if(src.key == R.Rank_Key)
					M = src
				if(M)
					if(istext(R.Rank_AFK)) R.Rank_AFK = 0
					R.Rank_AFK_Total += R.Rank_AFK
					R.Rank_AFK = 0*/
		view(15) << "<span class=announce>[src.name] came back from AFK.</span>"
		AFKRemove()
		src.afk=0
		usr.saveToLog("[src] has returned from AFK!")
		//src.name=copytext(name,7,0)
		return
	if(src.afk==0)
		AFKAdd() // overlays the AFK image on player
		src.afk=1 // so it can effect it when they press AFK again and makes them immobile
		src.Went_Afk = 1
		spawn(100)
			if(src) src.Went_Afk = 0
		for(var/mob/player/M in view(15))
			if(M.client)
				if(A)
					M<<"<span class=announce>[src] has automatically been set to AFK!</span>"
				else
					M<<"<span class=announce>[src] has set themselves to AFK!</span>"
		if(A) saveToLog("[src] has automatically been set to AFK!")
		else saveToLog("[src] has set themselves to AFK!")

		//src.name="(AFK) [src.name]"
		return



/mob/verb/OOC(msg as text)
	set category = null//"Other"
	//set name = "OOC"
	if(IsGuestKey(usr.key))
		usr << "You are not authorized to communicate over these channels."
		return
	msg = gSpamFilter.sf_Filter(usr,msg)
	if(!msg) return
	else if(!ooc_allowed && !usr.client.holder) return
	else if(usr.client.muted) return
	if(findtext(msg, "byond://") && !usr.client.holder)
		usr << "<B>Advertising other servers is not allowed.</B>"
		alertAdmins("[key_name_admin(usr)] has attempted to advertise in OOC.")
		return
//	if(findtextEx(msg, "pickle rick")||findtextEx(msg, "Pickle Rick")||findtextEx(msg, "Pickle rick")||findtextEx(msg, "pickle Rick")||findtextEx(msg, "rickle pick")||findtextEx(msg, "Rickle pick")||findtextEx(msg, "Rickle pick")||findtextEx(msg, "pIcKlE rIcK")||findtextEx(msg, "PiCkLe RiCk")||findtextEx(msg, "RiCkLe PiCk")||findtextEx(msg, "rIcKlE PiCk")||findtextEx(msg, "picklerick")||findtextEx(msg, "PICKLERICK")||findtextEx(msg, "pikel rick")||findtextEx(msg, "pikel rik")||findtextEx(msg, "pickle rik")||findtextEx(msg, "pklrk")||findtextEx(msg, "pkle rk")||findtextEx(msg, "pkle rck")||findtextEx(msg, "rick pickle")||findtextEx(msg, "Rick Pickle")||findtextEx(msg, "rickpickle")||findtextEx(msg, "kickle pick")||findtextEx(msg, "kickle rick")||findtextEx(msg, "rick kickle")||findtextEx(msg, "p1ck13 r1ck")||findtextEx(msg, "p1ck13r1ck")||findtextEx(msg, "p1ck13 r1c4")||findtextEx(msg, "p1c413 r1c4")||findtextEx(msg, "p1c413 r1ck")||findtextEx(msg, "p1c4l3 r1ck")||findtextEx(msg, "p1ck13")||findtextEx(msg, "p1ck1e")||findtextEx(msg, "p1c41e")||findtextEx(msg, "pick1e")||findtextEx(msg, "p1c47e")||findtextEx(msg, "p1c4le")||findtextEx(msg, "pic47e")||findtextEx(msg, "pick7e")||findtextEx(msg, "pick1e")||findtextEx(msg, "p1ckle")||findtextEx(msg, "pickl3")||findtextEx(msg, "pick3l")||findtextEx(msg, "pick31")||findtextEx(msg, "p1ck31")||findtextEx(msg, "nigger")||findtextEx(msg, "nigg3r")||findtextEx(msg, "n1gger")||findtextEx(msg, "n1gg3r")||findtextEx(msg, "ni44er")||findtextEx(msg, "ni443r")||findtextEx(msg, "ni4g3r")||findtextEx(msg, "nig43r")||findtextEx(msg, "n1443r")||findtextEx(msg, "n14g3r")||findtextEx(msg, "n1g43r")||findtextEx(msg, "Nigger"))
//		alert(usr,"This joke isn't funny.")
//		msg=pick("I am a lame person.","I wish I was funny","i have low iq","i like to lick batteries","i suffer from nocturnal urination","sometimes, i dream about cheese","yes i am also retarded","one time i accidentally pooped myself")
//	log_ooc("\[[time2text(world.realtime,"Day DD hh : mm : ss")]\] [usr.name]/[usr.key] : [msg]")
	var/nameline="<span class=\"[Font]\">"
	for(var/mob/C in Players) if(C.client) if(!locate(usr.lastKnownKey) in Ignores)
		if(C.client.listen_ooc)
			if(C.client.holder) C.AllOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"adminooc\"><span class=\"prefix\">(OOC)</span>[BoosterTag][nameline] [usr.key][C.client.holder.SeeIC?"([usr.name])":""] (<A HREF='?src=\ref[C.client.holder];adminplayeropts=\ref[usr]'>X</A>)[OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")
			else C.AllOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"prefix\">(OOC)</span> [BoosterTag][nameline][usr.key][OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")
		if (C.client.holder) C.OOCOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"adminooc\"><span class=\"prefix\">(OOC)</span> [BoosterTag][nameline][usr.key]([usr.name]) (<A HREF='?src=\ref[C.client.holder];adminplayeropts=\ref[usr]'>X</A>)[OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")
		else C.OOCOut("<font size=[C.TextSize] font color=[usr.TextColorOOC]>[C.Toggled_Timestamps ? "\[[time2text(world.realtime,"Day, hh : mm")]\]":""] <span class=\"ooc\"><span class=\"prefix\">(OOC)</span> [BoosterTag][nameline][usr.key][OOCTag? " [OOCTag]":""]:</span></font> <span class=\"message\">[msg]</span></span>")



mob/var/tmp/SayCD=0
mob/var/tmp/EmoteCD=0
/mob/verb/
	Whisper(msg as text)
//		set category="Other"
		set instant=1
		//r/icon/I = usr.getIconImage()
		msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
		if(!msg) return
//		log_whisper("[usr.name]/[usr.key] : [msg]")
//		SaveToSayLog("[msg] ([usr.x], [usr.y], [usr.z])")
		var/SN=0
		if(usr.Health<=0 && prob(95)) msg=stutter(msg)
		for(var/mob/Admin_Mode/M in view(usr))
			if(M) for(var/mob/player/P in world)
				if(P.ckey == M.controllerKey)
					P.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> (Admin Mode) *[usr.name] whispers, \"[msg]\"</span>")
					P.OOCOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> (Admin Mode) *[usr.name] whispers, \"[msg]\"</span>")
		for(var/mob/player/M in view(usr)-view(1))if(!M.afk)  if(M.Critical_Hearing == 0) M.ICOut("<font size=[M.TextSize]>-[name] whispers something...")
		for(var/mob/player/M in hearers(1))
			if(M.client&&!M.HasSNj)
				if(M==usr) SN=1
				for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature) SN=1
				var/Hear = 1
				if(M.Critical_Hearing) Hear = 0
				if(M.afk)
					Hear=0
					if(prob(50)) Hear=-1
				if(Hear==1)
					if(M.client.holder)
						if(!SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *??? ([usr.name]) (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
						if(SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *[usr.name] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
					else
						if(!SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *??? whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
						if(SN) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> *[usr.name] whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
					if(M.Observer) for(var/mob/player/S in Players) if(S.key==M.Observer) S.AllOut("<span class=\"whisper\"><font size=[S.TextSize] color=[TextColor]><b>\[[lan]\]</b> *[usr.name] whispers, \"[LanguageSay(msg,lan,lan.Mastery,S)]\"</span>")
				else if(Hear==0) M.ICOut("<i>You hear a distant noise...</i>")
		for(var/mob/player/M in hearers(10,usr)) if(M.HasSNj) M.ICOut("<span class=\"whisper\"><font size=[M.TextSize] color=[TextColor]><b>\[[lan]\]</b> (Namekian Hearing) *[usr.name] whispers, \"[LanguageSay(msg,lan,lan.Mastery,M)]\"</span>")
		Say_Spark()
		usr.saveToLog("<font color=#FF00FF>\n<span class=\"whisper\">[usr]([key]): whispers [msg]  ([usr.x], [usr.y], [usr.z])</span>\n")

	Say(msg as text)
	//	set category="Other"
		if(SayCD) return
		else SayCD=1
		spawn(1) SayCD=0
//		var/icon/I = usr.getIconImage()
		msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
		if(!msg) return
		var/SQ=say_quote(msg)
		var/IC=1
		if(findtext(SQ,"OOC")) IC=0
		if(!IC&&!usr.CanOOC()) return
		if(IC&&!findtext(SQ,"thinks"))
			if(usr.KOd) if(prob(50)) msg=stutter(msg)
			if(usr.TicksOfMerriment) if(prob(usr.TicksOfMerriment/80)) msg=stutter(msg)
			if(usr.Critical_Throat) if(prob(50)) msg = "*Mumbles incoherently*..."
		var/mob/Sender=usr
		if(InFusion) for(var/mob/player/M in Players)if(M.FusionKey2==key) Sender=M
		// Create floating text effect
		var/SN="??? ([Sender])"
		for(var/mob/Admin_Mode/M in view(usr))
			if(M) for(var/mob/player/P in world)
				if(P.ckey == M.controllerKey)
					P.ICOut("<font size=[P.TextSize] color=[usr.TextColor]><b>\[[lan]\] </b>(Admin Mode) [SN] [SQ] <font color=#EAEAEA>\"[msg]\"</span>")
					P.OOCOut("<font size=[P.TextSize] color=[usr.TextColor]><b>\[[lan]\] </b>(Admin Mode) [SN] [SQ] <font color=#EAEAEA>\"[msg]\"</span>")

		if(findtext(SQ,"exclaims"))
			for(var/mob/player/M in hearers(18,Sender))
				if(M.client)
					if(M==usr) SN="[Sender]"
					if(M==Sender) SN="[Sender]"
					for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature) SN="[Sender]"
					for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature_True) SN="[Sender]"
					if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key)
						if(IC)S.AllOut("<font size=[S.TextSize] color=[TextColor]><b>\[[lan]\]</b>(Observe) [SN] [SQ] <font color=#EAEAEA>\"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,S)]\"</span>")
						else S.AllOut("<font size=[S.TextSize] color=[TextColor]>[SN] [SQ] <font color=#EAEAEA>[OOCText(msg)]</span>")
					var/Hear = 1
					if(M.Critical_Hearing)
						Hear = 0
						if(prob(60)) Hear=1
					if(M.afk)
						Hear=0
						if(prob(50)) Hear=-1
					if(Hear==1)
						if(M.client.holder) M.ICOut("<font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [SN] (<A HREF='?usr=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] <font color=#EAEAEA>\"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
						else M.ICOut("<font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [SN] [SQ] <font color=#EAEAEA>\"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
					else if(Hear==0) M.ICOut("<i>You hear a distant noise...</i>")
			Say_Spark()
			usr.saveToLog("<font color=#FF00FF>\n<font color=#EAEAEA>[usr]([key]): [msg] ([usr.x], [usr.y], [usr.z])</span>\n")
			return
		else
			usr.saveToLog("<font color=#FF00FF>\n<font color=#EAEAEA>[usr]([key]) says [msg] ([usr.x], [usr.y], [usr.z])</span>\n")
			for(var/mob/player/M in hearers(12,Sender))
				if(M.client)
					if(M==usr)SN="[Sender]"
					for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature) SN="[Sender]"
					for(var/obj/Contact/A in M.Contacts) if(A.Signature == Signature_True) SN="[Sender]"
					if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key)
						if(IC)S.AllOut("<font size=[S.TextSize] color=[TextColor]><b>\[[lan]\]</b>(Observe) [SN] [SQ] <font color=#EAEAEA>\"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,S)]\"</span>")
						else S.AllOut("<font size=[S.TextSize] color=[TextColor]>[SN] [SQ] <font color=#EAEAEA>[OOCText(msg)]</span>")
					var/Hear = 1
					if(M.Critical_Hearing)
						Hear = 0
						if(prob(25)) Hear=1
					if(M.afk)
						Hear=0
						if(prob(50)) Hear=-1
					if(!IC) if(!findtext(SQ,"thinks")) if(M.listen_looc||findtext(msg,"INF") )if(!M.afk)
						if(M.client.holder)
						//	M.ICOut("<BIG>\icon[I]</BIG><font color=#EAEAEA><font size=[M.TextSize] color=[TextColor]>[SN] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] [OOCText(msg)]</span>")
							M.AllOut("<font size=[M.TextSize] color=[TextColor]>[SN] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] <font color=#EAEAEA>[OOCText(msg)]</span>")
							M.OOCOut("<font size=[M.TextSize] color=[TextColor]>[SN] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] <font color=#EAEAEA>[OOCText(msg)]</span>")
						else
						//	M.ICOut("<BIG>\icon[I]</BIG><font color=#EAEAEA><font size=[M.TextSize] color=[TextColor]>[SN] [SQ] [OOCText(msg)]</span>")
							M.AllOut("<font size=[M.TextSize] color=[TextColor]>[SN] [SQ] [OOCText(msg)]</span>")
							M.OOCOut("<font size=[M.TextSize] color=[TextColor]>[SN] [SQ] [OOCText(msg)]</span>")
					if(findtext(SQ,"thinks"))if(!M.afk)
						if(M.client.holder) M.ICOut("<font size=[M.TextSize] color=[TextColor]>[SN] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] <font color=#EAEAEA>[ThinkText(msg)]</span>")
						else M.ICOut("<font size=[M.TextSize] color=[TextColor]>[SN] [SQ] [ThinkText(msg)]</span>")
						IC=0
					else if(Hear==1)
						if(IC)
							if(M.client.holder) M.ICOut("<font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [SN] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>) [SQ] <font color=#EAEAEA>\"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
							else M.ICOut("<font size=[M.TextSize] color=[TextColor]><b>\[[Sender.lan]\]</b> [SN] [SQ] <font color=#EAEAEA>\"[LanguageSay(msg,Sender.lan,Sender.lan.Mastery,M)]\"</span>")
					else if(Hear==0) if(IC) M.ICOut("<i>You hear a distant noise...</i>")
			Say_Spark()
			return

	Emote()
		set category="Other"
		set instant=1
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		overlays -= _overlay
		if((winget(client,"emoteW","is-visible")=="true"))
			winshow(client,"emoteW",0)
			return
		winshow(client,"emoteW",1)
	//	.winset "tabpane.tab.current-tab=chatpane;chatpane.chatinput.focus=true"
		winset(client, "emoteW.emoteinput", "focus=true")
		//winset(client, "emoteW", "emoteinput.focus=true")
		usr.saveToLog("<br> |  | ([x], [y], [z]) |<span class=\"emote\">*[usr] starts typing an emote.*</span>\n")
		overlays += _overlay
		if(SavedEmote) winset(usr.client, "emoteW.emoteinput", "text=\"[SavedEmote]\"")
		//if(!RPMode) RPMode()
//		var/msg = input("Emote") as message

	EmoteS()
		set hidden=1
		if(EmoteCD) return
		else EmoteCD=1
		spawn(5) EmoteCD=0
		var/msg=winget(usr, "emoteW.emoteinput", "text")
		msg = copytext(sanitize_n(msg), 1, MAX_MESSAGE_LEN)
		if(!msg)
			winshow(client,"emoteW",0)
			var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
			_overlay.pixel_y = 12
			_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
			overlays -= _overlay
			usr.saveToLog("<br> |  | ([x], [y], [z]) |<span class=\"emote\">*[usr] cancels their emote.*</span>\n")
			return
		//r/icon/I = usr.getIconImage()
//		log_emote("[usr.name]/[usr.key] : [msg]")
		SavedEmote=null
		var/mob/Sender=usr
		if(InFusion) for(var/mob/player/M)if(M.FusionKey2==key) Sender=M

		if(winget(usr,"emoteW.nameinclude","is-checked")=="true")
			for(var/mob/Admin_Mode/M in view(usr))
				if(M) for(var/mob/player/P in world)
					if(P.ckey == M.controllerKey)
						P.ICOut("<font color=[usr.TextColor]><font size=[P.TextSize]>(Admin Mode) *[Sender] [P.ICText(msg,usr)]*<br> (<A HREF='?src=\ref[P.client.holder];adminplayeropts=\ref[usr]'>X</A>)</span>")
						P.OOCOut("<font color=[usr.TextColor]><font size=[P.TextSize]>(Admin Mode) *[Sender] [P.ICText(msg,usr)]*<br> (<A HREF='?src=\ref[P.client.holder];adminplayeropts=\ref[usr]'>X</A>)</span>")
			for(var/mob/player/M in hearers(ViewX,Sender))
				if(M.client&&!M.afk)
					if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key) S.ICOut("<font color=[usr.TextColor]><font size=[S.TextSize]>(Observe)*[Sender] [S.ICText(msg,usr)]*<br></span>")
					if(M.client.holder) M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>*[Sender] [M.ICText(msg,usr)]*<br>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>)</span>")
					else M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>*[Sender] [M.ICText(msg,usr)]*<br></span>")
		else
			for(var/mob/Admin_Mode/M in view(usr))
				if(M) for(var/mob/player/P in world)
					if(P.ckey == M.controllerKey)
						P.ICOut("<font size=[P.TextSize]>(Admin Mode) *[P.ICText(msg,usr)]*<br>([Sender]) (<A HREF='?src=\ref[P.client.holder];adminplayeropts=\ref[usr]'>X</A>)</span>")
						P.OOCOut("<font size=[P.TextSize]>(Admin Mode) *[P.ICText(msg,usr)]*<br>([Sender]) (<A HREF='?src=\ref[P.client.holder];adminplayeropts=\ref[usr]'>X</A>)</span>")
			for(var/mob/player/M in hearers(ViewX,Sender))
				if(M.client&&!M.afk)
					if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key) S.ICOut("<font color=[usr.TextColor]><font size=[S.TextSize]>(Observe)*[S.ICText(msg,usr)]*<br>([Sender])</span>")
					if(M.client.holder) M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>*[M.ICText(msg,usr)]*<br>([Sender] (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>))</span>")
					else M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>*[M.ICText(msg,usr)]*<br>([Sender])</span>")
		usr.saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(usr)] ::<br> <span class=\"emote\">*[usr] [msg]*</span>\n")
//				for(var/Activity/A in M) if(A.Subtype=="RP") if(prob(30)) A.CheckProgress(1,usr.Signature,M)
		SaveToEmoteLog("[msg]")
		RPs += 1
		Say_Spark()
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		overlays -= _overlay
		//if(RPMode) RPMode()
		winshow(client,"emoteW",0)
		winset(usr.client, "emoteW.emoteinput", "text=")

	EmoteClose()
		set hidden=1
		var/image/_overlay = image(icon='Typing.dmi') // In order to get pixel offsets to stick to overlays we create an image
		_overlay.pixel_y = 12
		_overlay.layer= MOB_LAYER+EFFECTS_LAYER+50
		overlays -= _overlay
		EmoteCD=0
		winshow(client,"emoteW",0)


	EmoteC()
		set hidden=1
		winset(usr.client, "emoteW.emoteinput", "text=")

	ClearAhelpW()
		set hidden=1
		winset(usr.client, "AhelpW.AHELPin", "text=")
		winshow(client,"AhelpW",0)

	AdminHelp()
		set name="Admin Help"
		//set category="Other"
		winshow(client,"AhelpW",1)
		alert(usr,"Please be descriptive in your admin help.  It is important to clearly state your issue and what you need help with. If it is to get something approved, be clear with what you want approved and why you feel it should be approved.  Include a link to a pastebin of the appropriate RP. (Do not use this to complaing about development choices or thing related to game design. Use the discord instead.  Misuse of ahelp will result in punishment)","Admin Help")
		winset(client, "AhelpW.AHELPin", "focus=true")
	//	winset(usr.client, "AhelpW.AHELPin", "text=")

	/*Races()
		//set category="Other"
		var/list/Races=new
		for(var/mob/player/A in Players) if(!(A.Race in Races))
			if(usr.client.holder)
				var/Amount=0
				Races+=A.Race
				for(var/mob/player/B in Players) if(B.Race==A.Race) Amount++
				usr.AllOut("[A.Race]: [Amount]")
			else if(A.Race!="Majin")if(A.Race!="Bio-Android")
				var/Amount=0
				Races+=A.Race
				for(var/mob/player/B in Players) if(B.Race==A.Race) Amount++
				usr.AllOut("[A.Race]: [Amount]")*/


mob/var/SavedEmote
mob/proc/EmoteSaveProgress()
	if((winget(src.client,"emoteW","is-visible")=="true")) SavedEmote={"[winget(usr, "emoteW.emoteinput", "text")]"}


mob/proc/ICText(A as text,mob/M)
	var/remainingtext=A
	var/output
	loop
/*
	var/saystart=max(0,findtext(remainingtext,"&#34;")-1)
	var/thinkstart=max(0,findtext(remainingtext,"\<")-1)

	if(saystart<thinkstart) goto say
	if(thinkstart<saystart) goto think

	say*/
	if(findtext(remainingtext,"&#34;"))
		output+=copytext(remainingtext,1,findtext(remainingtext,"&#34;"))
		output+="<font color=[M.TextColor]>\[[M.lan]\] <font color=#EAEAEA>&#34;"
		remainingtext=copytext(remainingtext,findtext(remainingtext,"&#34;")+5,0)
		if(findtext(remainingtext,"&#34;"))
			output+=M.LanguageSay(copytext(remainingtext,1,findtext(remainingtext,"&#34;")),M.lan,M.lan.Mastery,src)
			if(findtext(copytext(remainingtext,1,findtext(remainingtext,"&#34;")),M.name)) src.Contacts(M.Signature)
			output+="&#34;<font color=[M.TextColor]>"
			remainingtext=copytext(remainingtext,findtext(remainingtext,"&#34;")+5,0)
			goto loop
		else
			output+=M.LanguageSay(remainingtext,M.lan,M.lan.Mastery,src)
			output+="&#34;<font color=[M.TextColor]>"
			remainingtext=null

/*	think
	if(findtext(remainingtext,"\<"))
		output+=copytext(remainingtext,1,findtext(remainingtext,"\<"))
		output+="<font color=[M.TextColor]> \<"
		remainingtext=copytext(remainingtext,findtext(remainingtext,"\<")+4,0)
		if(findtext(remainingtext,"\>"))
			output+=copytext(remainingtext,1,findtext(remainingtext,"\>"))
			output+="\><span class=\"emote\">"
			remainingtext=copytext(remainingtext,findtext(remainingtext,"\>")+4,0)
			goto loop
		else
			output+=remainingtext
			output+="\><span class=\"emote\">"
			remainingtext=null*/



	output+=remainingtext
	return output

proc/OOCText(A as text)
	var/remainingtext=A
	var/output="("
	if(findtext(remainingtext,"(")|findtext(remainingtext,"\[")|findtext(remainingtext,"{"))
		if(findtext(remainingtext,")")|findtext(remainingtext,"\]")|findtext(remainingtext,"}"))
			output+=copytext(remainingtext,2,-1)
			output+=")"
		else output+="[copytext(remainingtext,2,0)])"
	else if(findtext(remainingtext,")")|findtext(remainingtext,"\]")|findtext(remainingtext,"}"))
		output+=copytext(remainingtext,1,-1)
		output+=")"
	return output
proc/ThinkText(A as text)
	var/remainingtext=A
	var/output="<i>\<"
	if(findtext(remainingtext,"\<"))
		if(findtext(remainingtext,"\>"))
			output+=copytext(remainingtext,5,-4)
			output+="\>"
		else output+="[copytext(remainingtext,5,0)]\>"
	else if(findtext(remainingtext,"\>"))
		output+=copytext(remainingtext,1,-4)
		output+="\></i>"
	return output

Skill/Support/Telepathy
	Experience=100
	Tier=2
	desc="Allows you to communicate with someone you know the energy signature of (5+ familiarity in contacts)"
	verb/Telepathy()
		set src=usr.contents
		set category="Other"
		set instant=1
		if(usr.Critical_Head)
			usr.ICOut("Your head injury is preventing you from doing this for now.")
			return
		var/list/Tlist=list()
		for(var/obj/Contact/X in usr.Contacts) for(var/mob/AA in Players) if(AA.ckey == X.pkey&&AA.Signature==X.Signature&&X.familiarity>5)
			Tlist+=AA
		Tlist+="Cancel"
		var/mob/M = input("Telepathy who?") in Tlist
		if(M=="Cancel") return
		var/AL=0
		if(usr.z in list(8,11,10)) AL=1
		var/TAL=0
		if(M.z in list(8,11,10)) TAL=1
		if(TAL!=AL)
			if(!usr.Rank)
				usr<<"You can not reach them."
				return
			/*if(!RealmTeleport)
				usr<<"You can not reach them."
				return*/
		if(!M.HelmetOn)
			var/message=input("Say what in telepathy?") as text
			message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
			if(!message)	return
//			log_telepathy("[usr.name]/[usr.key] : [message]")
			if(M)
				if(locate(/Skill/Support/Telepathy) in M)
					usr.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>You say in telepathy to [M.name], \"[message]\"</font></span>")
					M.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[usr.TextColor]>[usr] says in telepathy, \"[message]\" (<A HREF='?src=\ref[M];telepathyrespond=\ref[usr]'>Respond</A>)</font></span>")
				else
					usr.ICOut("<span class=\"telepathy\"><font size=[usr.TextSize] color=[usr.TextColor]>You say in telepathy to [M.name], \"[message]\" (They do not have Telepathy)</font></span>")
					M.ICOut("<span class=\"telepathy\"><font size=[M.TextSize] color=[usr.TextColor]>A voice in your head says, \"[message]\" (<A HREF='?src=\ref[M];telepathyrespond=\ref[usr]'>Respond</A>)</font></span>")
			for(var/mob/player/C in view(10,usr.loc)) C.ICOut("<font color=#EAEAEA><font size=[C.TextSize] color=[usr.TextColor]><b>\[[usr.lan]\]</b> *[usr.name] says, \"[usr.LanguageSay(message,usr.lan,usr.lan.Mastery,C)]\"</span>")
			usr.saveToLog("<span class=\"telepathy\">You say in telepathy to [M.name], \"[message]\"</span>\n")
		else
			usr << "You are unable to communicate with [M.name]!"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

mob/var/HUDOn=0
mob/verb/Show_HUD()
	set category=null
	if(!HUDOn)
		spawn() winshow(usr.client,"CharaBox",1)
		HUDOn=1
	else
		spawn() winshow(usr.client,"CharaBox",0)
		HUDOn=0

mob/verb/Screen_Size()
	set category=null
	ViewX=input("Enter the width of the screen, limits are 5 - 70.") as num
	ViewY=input("Enter the height of the screen, limits are 5 - 70.") as num
	if(ViewX<5) ViewX=5
	if(ViewY<5) ViewY=5
	if(ViewX>70) ViewX=70
	if(ViewY>70) ViewY=70 
	ScreenConfigure()

mob/proc/ScreenConfigure()
	if(isnum(ViewX)&&isnum(ViewY)) client.view="[ViewX]x[ViewY]"
	winset(src.client,"mapwindow.map","icon-size=[icon_sizeSave]")
	x_view = ViewX
	y_view = ViewY
