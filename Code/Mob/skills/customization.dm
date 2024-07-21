/*
Changeling forms customization procs
*/
mob/var/KiColor=null
mob/proc/Customize_Form_1() switch(input("Customize 1st form icon?") in list("No","Yes"))
	if("Yes")
		var/ICO=input("Select an icon to use.","Custom Form Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			usr << "Icon accepted!"
			Form1Icon=ICO
mob/proc/Customize_Form_2() switch(input("Customize 2nd form icon?") in list("No","Yes"))
	if("Yes")
		var/ICO=input("Select an icon to use.","Custom Form Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			usr << "Icon accepted!"
			Form2Icon=ICO
mob/proc/Customize_Form_3() switch(input("Customize 3rd form icon?") in list("No","Yes"))
	if("Yes")
		var/ICO=input("Select an icon to use.","Custom Form Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			usr << "Icon accepted!"
			Form3Icon=ICO
mob/proc/Customize_Form_4() switch(input("Customize 4th form icon?") in list("No","Yes"))
	if("Yes")
		var/ICO=input("Select an icon to use.","Custom Form Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			usr << "Icon accepted!"
			Form4Icon=ICO
mob/proc/Customize_Form_5() switch(input("Customize 5th form icon?") in list("No","Yes"))
	if("Yes")
		var/ICO=input("Select an icon to use.","Custom Form Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			usr << "Icon accepted!"
			Form5Icon=ICO
mob/proc/Customize_Form_6() switch(input("Customize golden form icon?") in list("No","Yes"))
	if("Yes")
		var/ICO=input("Select an icon to use.","Custom Form Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			usr << "Icon accepted!"
			Form6Icon=ICO
mob/proc/Customize_Form_7() switch(input("Customize Destroyer form icon?") in list("No","Yes"))
	if("Yes")
		var/ICO=input("Select an icon to use.","Custom Form Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			usr << "Icon accepted!"
			Form7Icon=ICO
mob/verb/Customize()
	set category=null
	if(GodKi>0)
		var/P=input("Change God Ki Aura") in list("Custom","Default")
		switch(P)
			if("Custom")
				usr.overlays-=usr.GodKiAura
				var/ICO=input("Select an icon to use.","Custom God Ki Aura Icon") as null|icon
				if(!ICO)
					return 0
				var/size = length(ICO)
				Size(size)
				if(length(ICO) > iconsize)
					alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
					return 0
				else
					var/X_Offset=input("Choose pixel_x offset, each tile is 32 pixels.") as num
					var/Y_Offset=input("Choose pixel_y offset") as num
					usr << "Icon accepted!"
					usr.GodKiAura.icon=ICO
					usr.GodKiAura.pixel_x = X_Offset
					usr.GodKiAura.pixel_y = Y_Offset
			if("Default")
				usr.overlays-=usr.GodKiAura
				usr.GodKiAura=new/Icon_Obj/Cloak/GodAura


	alert("For custom Power Control icons, change Power Controls icon, for attacks change the attack iteself. (Megaburst can not/should not be changed)")
	overlays.Remove(BlastCharge,/Icon_Obj/Cloak/SSJ1,/Icon_Obj/Cloak/LSSJ,/Icon_Obj/Cloak/SSG2,/Icon_Obj/Cloak/SN,/Icon_Obj/Cloak/SSR,/Icon_Obj/Cloak/SSGSS,/Icon_Obj/Cloak/SSGFP,/Icon_Obj/Cloak/SSRFP,'Aura SSj3.dmi','Sparks LSSj.dmi','SNj Elec.dmi',\
	'Electric_Mystic.dmi','Mutant Aura.dmi','Void Aura.dmi')
	underlays-=/Icon_Obj/Cloak/SSj4
	for(var/Skill/Buff/Power_Control/A in usr) overlays-=A
	//underlays-=SSj4Aura
	usr.Grid("Blasts","Auras","Charges")

mob/proc/CustomizeBlastRefresh()
	var/Row=0
	for(var/A in Blast_List)
		Row++
		src<<output(A,"GridX:1,[Row]")
	for(var/A in Aura_List)
		Row++
		src<<output(A,"GridX:1,[Row]")
	for(var/A in Charge_List)
		Row++
		src<<output(A,"GridX:1,[Row]")

Icon_Obj/Customization/Blasts
	icon_state="head"

	Click()
		var/list/C=new
		for(var/Skill/Attacks/D in usr) if(D.type!=/Skill/Attacks/Time_Freeze) if(D.type!=/Skill/Attacks/MegaBurst) C+=D
		//usr.Tabs=1
		var/Skill/Attacks/A=input("Give this icon to which attack?") in C
		if(A)
			A.icon=image(icon=icon,icon_state=icon_state)
			A.pixel_x=0
			A.pixel_y=0
			if(pixel_x) if(A) A.pixel_x=src.pixel_x
			if(pixel_y) if(A) A.pixel_x=src.pixel_y
		usr<<"[src] Chosen"

	verb/Adjust_Color()
		set src in world
		var/A=input("Choose a color") as color|null
		if(A) icon+=A
		usr.CustomizeBlastRefresh()
	verb/Default_Color()
		set src in world
		icon=initial(icon)
		usr.CustomizeBlastRefresh()
	Blast1 icon='1.dmi'
	Blast2 icon='2.dmi'
	Blast3 icon='3.dmi'
	Blast4 icon='4.dmi'
	Blast5 icon='5.dmi'
	Blast6 icon='6.dmi'
	Blast7 icon='7.dmi'
	Blast8 icon='8.dmi'
	Blast9 icon='9.dmi'
	Blast10 icon='10.dmi'
	Blast11 icon='11.dmi'
	Blast12 icon='12.dmi'
	Blast13 icon='13.dmi'
	Blast14 icon='14.dmi'
	Blast15 icon='15.dmi'
	Blast16 icon='16.dmi'
	Blast17 icon='17.dmi'
	Blast18 icon='18.dmi'
	Blast19 icon='19.dmi'
	Blast20 icon='20.dmi'
	Blast21 icon='21.dmi'
	Blast22 icon='22.dmi'
	Blast23 icon='23.dmi'
	Blast24 icon='24.dmi'
	Blast25 icon='25.dmi'
	Blast26 icon='26.dmi'
	Blast27 icon='27.dmi'
	Blast28 icon='28.dmi'
	Blast29 icon='29.dmi'
	Blast30 icon='30.dmi'
	Blast31 icon='31.dmi'
	Blast32 icon='32.dmi'
	Blast33 icon='33.dmi'
	Blast34 icon='34.dmi'
	Blast35 icon='35.dmi'
	Blast36 icon='36.dmi'
	Blast37 icon='37.dmi'
	Blast38 icon='Blast - Destructo Disk.dmi'
	Blast39 icon='Blast - Dual Fire Blast.dmi'
	Blast40 icon='Blast - Ki Shuriken.dmi'
	Blast41 icon='holybolt.dmi'
	Blast42 icon='Blast0.dmi'
	Blast43 icon='Blast1.dmi'
	Blast44 icon='Blast2.dmi'
	Blast45 icon='Blast3.dmi'
	Blast46 icon='Blast4.dmi'
	Blast47 icon='Blast5.dmi'
	Blast48 icon='Blast6.dmi'
	Blast49 icon='Blast7.dmi'
	Blast50 icon='Blast8.dmi'
	Blast51 icon='Blast9.dmi'
	Blast52 icon='Blast10.dmi'
	Blast53 icon='Blast11.dmi'
	Blast54 icon='Blast12.dmi'
	Blast55 icon='Blast13.dmi'
	Blast56 icon='Blast14.dmi'
	Blast57 icon='Blast15.dmi'
	Blast58 icon='Blast16.dmi'
	Blast59 icon='Blast17.dmi'
	Blast60 icon='Blast18.dmi'
	Blast61 icon='Blast19.dmi'
	Blast62 icon='Blast20.dmi'
	Blast63 icon='Blast21.dmi'
	Blast64 icon='Blast22.dmi'
	Blast65 icon='Blast23.dmi'
	Blast66 icon='Blast24.dmi'
	Blast67 icon='Blast25.dmi'
	Blast68 icon='Blast26.dmi'
	Blast69 icon='Blast27.dmi'
	Blast70 icon='Blast28.dmi'
	Blast71 icon='Blast29.dmi'
	Blast72 icon='Blast30.dmi'

	NBlast1 icon='NBlast1.dmi'
	NBlast2 icon='NBlast2.dmi'
	NBlast3 icon='NBlast3.dmi'
	NBlast4 icon='NBlast4.dmi'
	NBlast5 icon='NBlast5.dmi'
	NBlast6 icon='NBlast6.dmi'
	NBlast7 icon='NBlast7.dmi'
	NBlast8 icon='NBlast8.dmi'
	NBlast9 icon='NBlast9.dmi'
	NBlast10 icon='NBlast10.dmi'
	NBlast11 icon='Blast0.dmi'
	NBlast12 icon='Blast1.dmi'
	NBlast13 icon='Blast2.dmi'
	NBlast14 icon='Blast8.dmi'
	NBlast15 icon='Blast9.dmi'
	NBlast16 icon='Blast10.dmi'
	NBlast17 icon='Blast11.dmi'
	NBlast18 icon='Blast13.dmi'
	NBlast19 icon='Blast15.dmi'
	NBlast20 icon='Blast25.dmi'
	NBlast21 icon='Blast26.dmi'
	NBlast22 icon='InterceptorBlast.dmi'

	FevBlast1 icon='fevBlast.dmi'
	FevBlast2 icon='fevHomingFinisher.dmi'



	Beam1 icon='Beam1.dmi'
	Beam2 icon='Beam2.dmi'
	Beam3 icon='Beam3.dmi'
	Beam4 icon='Beam4.dmi'
	Beam5 icon='Beam5.dmi'
	Beam6 icon='Beam6.dmi'
	Beam8 icon='Beam8.dmi'
	Beam9 icon='Beam9.dmi'
	Beam10 icon='Beam10.dmi'
	Beam11 icon='Beam11.dmi'
	Beam12 icon='Beam12.dmi'
	Beam13 icon='Beam - Kamehameha.dmi'
	Beam14 icon='Beam - Static Beam.dmi'
	Beam15 icon='Beam - Multi-Beam.dmi'
	Beam17 icon='Galic gun.dmi'
	Beam21 icon='Candyray.dmi'
	Beam22 icon='NB1.dmi'
	Beam28 icon='NB6.dmi'
	Beam29 icon='NB7.dmi'
	Beam31 icon='NB9.dmi'
	Beam32 icon='CorkScrew.dmi'
	Beam34 icon='BeamMasenko.dmi'
	Beam35 icon='BeamStaticBeam.dmi'
	Beam36 icon='Beam14.dmi'
	Beam37 icon='BeamBeam1.dmi'
	Beam38 icon='BeamBigFire.dmi'
	Beam39 icon='BeamBlastDragon.dmi'
	Beam40 icon='BeamKamehameha.dmi'
	Beam41 icon='BeamMasenko.dmi'
	Beam42 icon='BeamMultiBeam.dmi'
	Beam43 icon='BeamStaticBeam.dmi'
	Beam44 icon='BlackDragonBeam.dmi'
	Beam45 icon='LightningBeam2014.dmi'
	Beam46 icon='PoisonBeam2014.dmi'
	Beam47 icon='SnakeBeam2014.dmi'

Icon_Obj
	Cloak
		layer=MOB_LAYER+1
		pixel_x = -32
		pixel_y = -32
		alpha=200
		War
			icon = 'War.dmi'
			pixel_y = 0
		RedCloak
			icon = 'The Red Cloak.dmi'
		SSJCloak
			icon = 'SSJ Cloak.dmi'
		BlackCloak
			icon = 'Black Cloak.dmi'
		LSSJCloak
			icon = 'LSSJ CLOAK.dmi'
		LSSJGCloak
			icon = 'LSSJG CLOAK.dmi'
		WhiteCloak
			icon = 'White Cloak.dmi'
		BlueCloak
			icon = 'Blue Cloak.dmi'
		PurpleCloak
			icon = 'Purple Cloak.dmi'
		PinkCloak
			icon = 'Pink Cloak.dmi'
		SSGCloak
			icon='SSGGlow.dmi'
		SSBCloak
			icon='SSjBlueIdleAura.dmi'
		PowerCloak
			icon='Power Cloak.dmi'
		DefaultCloak
			icon='SSBGlow.dmi'
		SSJ1
			icon = 'AurasBig.dmi'
			icon_state = "SSJ"
			pixel_x = -32
			pixel_y = 0
		SSJ2FP
			icon='SSj.dmi'
			pixel_x = 0
			pixel_y = 0
		SSJ2
			icon='SSj2UM.dmi'
			pixel_x=-80
			pixel_y = 0
		LSSJ
			icon = 'AurasBig.dmi'
			icon_state = "LSSJ"
			pixel_x = -32
			pixel_y = 0
		SN
			icon = 'SNJ.dmi'
			pixel_x = -32
			pixel_y = 0
		SSGSS
			icon='SSGSS.dmi'
			icon_state="SSB"
			pixel_x=-16
			pixel_y=-2
		SSj4
			icon='Aura SSj4.dmi'
			alpha=150
			pixel_x = 0
			pixel_y = 0
		SSGFP
			icon='SSBAura.dmi'
			pixel_x=-48
			pixel_y=-10
			alpha=175
		RedAura
			icon='SSRAura1.dmi'
			pixel_x=-48
			pixel_y=-10
			alpha=175
		SSRFP
			icon='SSR2.dmi'
			pixel_x=-48
			pixel_y=-10
			alpha=130
		PaleAura
			icon='PaleAura.dmi'
			pixel_x=-48
			pixel_y=-10
			alpha=175
		DarkAura
			icon='Death.dmi'
			pixel_x=-48
			pixel_y=-10
			alpha=175
		SSR
			icon='SSGSS.dmi'
			icon_state="SSR"
			pixel_x=-16
			pixel_y=-2
		Bojack
			icon = 'AurasBig.dmi'
			icon_state = "Heran"
			pixel_x = -32
			pixel_y = 0
		UIAura
			icon = 'Ultra_Instinct.dmi'
			pixel_x = 0
			pixel_y = 0
		GodAura
			icon = 'AurasBig.dmi'
			icon_state = "Toji"
			pixel_x = -32
			pixel_y = 0
		SSG2
			icon='SSGAura.dmi'
			pixel_x = -32
			pixel_y = -32
			alpha=175
		SuperAlien
			icon = 'Blue Aura.dmi'
			pixel_x = -32
		BurningShot
			icon='Burning_Shot.dmi'
			pixel_x = -32
			pixel_y = -2

	Customization/Auras
		alpha=220
		Click()
			for(var/Skill/Buff/Power_Control/A in usr)
				A.icon=image(icon=icon,icon_state=icon_state)
				if(src.pixel_x) A.pixel_x=src.pixel_x
				else A.pixel_x=0
				if(src.pixel_y) A.pixel_x=src.pixel_y
				else A.pixel_y=0
				A.layer=MOB_LAYER+1
				usr<<"[src] Chosen"
		verb/Adjust_Color()
			set src in world
			var/A=input("Choose a color") as color|null
			if(A) icon+=A
			usr.KiColor=A
			usr.FlightAura='Aura Fly.dmi'
			if(A) usr.FlightAura+=A
			if(usr.Confirm("Adjust Alpha? 0-255"))
				var/Aalpha=input("Alpha 0 - 255") as num
				if(Aalpha<1)Aalpha=1
				if(Aalpha>255)Aalpha=255
				alpha=Aalpha
			usr.CustomizeBlastRefresh()

		verb/Default_Color()
			set src in world
			icon=initial(icon)
			alpha=initial(alpha)
			usr.CustomizeBlastRefresh()

		None
		Sparks icon='AbsorbSparks.dmi'
		Electric icon='Aura, Bloo.dmi'
		Electric_2 icon='Aura Electric.dmi'
		Default icon='Aura.dmi'
		Flowing icon='Aura Normal.dmi'
		Demon_Flame icon='Black Demonflame.dmi'
		Vampire_Aura icon='Aura 2.dmi'
		Electric_3 icon='ElecAura3.dmi'
		Electric_4 icon='Elec Aura1.dmi'
		BlackSmoke icon='BlackSmoke.dmi'
		Dark_Red
			icon='Dark Red Aura.dmi'
			pixel_x=-24
		Green_and_Red
			icon='Green and Red.dmi'
			pixel_x=-32
		Hyper_Aura
			icon='Hyper Aura.dmi'
			pixel_x=-32
		Large_Purple
			icon='Purple Large.dmi'
			pixel_x=-24
		Sparkles icon='Sparkle aura.dmi'
		Large_Blue
			icon='SuperBlueAura.dmi'
			pixel_x=-24
		Blue_Flame
			icon='Flame Aura.dmi'
			pixel_x=-32
			pixel_y=-12
		MutantAura
			icon='Mutant Aura.dmi'
			//pixel_x=32
		BigAura
			icon='AurasBig.dmi'
			pixel_x=-32
		DashmahAura
			icon='Dashmah Aura.dmi'
			pixel_x=-12
		DasmahAura2
			icon='dasmahaura2.dmi'
			pixel_x=-32


Icon_Obj/Customization/Charges
	icon='BlastCharges.dmi'

	Click()
		usr.BlastCharge=image(icon=icon,icon_state=icon_state)
		usr<<"[src] Chosen"
		..()
	verb/Adjust_Color()
		set src in world
		var/A=input("Choose a color") as color|null
		if(A) icon+=A
		usr.KiHitEffect='fevExplosion.dmi'
		if(A) usr.KiHitEffect+=A
		usr.CustomizeBlastRefresh()

	verb/Default_Color()
		set src in world
		icon=initial(icon)
		usr.CustomizeBlastRefresh()
	Charge1 icon_state="1"
	Charge2 icon_state="2"
	Charge3 icon_state="3"
	Charge4 icon_state="4"
	Charge5 icon_state="5"
	Charge6 icon_state="6"
	Charge7 icon_state="7"
	Charge8 icon_state="8"
	Charge9 icon_state="9"
	CustomChargeIcon
		icon_state="1"
		Click()
			..()
			if(usr.Confirm("Use a custom charge icon?"))
				var/ICO=input("Select an icon to use. (Blank or stealth icons for charge are illegal and against the rules)","Custom Charge Icon") as null|icon
				if(!ICO) return 0
				var/size = length(ICO)
				Size(size)
				if(length(ICO) > iconsize)
					alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
					return 0
				else
					src.icon=ICO
					usr << "Icon accepted!"
					usr.BlastCharge=ICO
