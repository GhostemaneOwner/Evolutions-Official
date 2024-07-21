
mob/var/tmp/FirstTransDrainless=0
mob/proc/Cancel_Transformation()src.Revert()
	/*
	* Revert should be called regardless of wether or not
	* It has a transformation_event as Revert() also deals with changelings and I can't be bothered sorting
	* that out. -- Vale
	*/


mob/proc/Revert()
	if(IsFusion||Race=="Changeling"||Race=="Half-Changeling") Changeling_Revert()
	else if(IsFusion||Race=="Alien"||Race=="Heran"||Race=="Half-Alien"||Race=="Half-Heran") Alien_Revert()
	else if(ssj>0&&!transing)
		if(ssj==1)
			BPMult/=SSjMult
			StrMult/=1.2
			PowMult/=1.2
			OffMult/=1.2
			DefMult/=1.2
		else if(ssj==2)
			BPMult/=SSjMult*SSj2Mult
			StrMult/=1.2
			PowMult/=1.2
			OffMult/=1.2
			DefMult/=1.2
			if(Class=="Legendary")
				EndMult/=1.2
				OffMult/=1.1
				DefMult/=1.1
		else if(ssj==3)
			BPMult/=SSjMult*SSj2Mult*SSj3Mult
			StrMult/=1.2
			PowMult/=1.2
			OffMult/=1.2
			DefMult/=1.2
		else if(ssj==4)
			BPMult/=2.5
			RegenMult/=1.3
			IgnoresGodKi=0
		else if(ssj==5)
			BPMult/=2.1
			StrMult/=1.2
			PowMult/=1.2
			OffMult/=1.2
			DefMult/=1.2
		else if(ssj==6)
			BPMult/=2.1
			StrMult/=1.2
			PowMult/=1.2
			OffMult/=1.2
			DefMult/=1.2
			IgnoresGodKi=0
		BuffNumber--
		Buffs-="Super Saiyan"
		underlays-=/Icon_Obj/Cloak/SSJCloak
		underlays-=/Icon_Obj/Cloak/LSSJCloak
		overlays-=/Icon_Obj/Cloak/RedCloak
		overlays-=/Icon_Obj/Cloak/BlueCloak
		overlays-=/Icon_Obj/Cloak/SSBCloak
		HairRemove()
		ssj=0
		Super_Sparks()
		HairAdd()
		AuraOverlays()
		for(var/mob/player/M in view(src)) M.BuffOut("[src] reverts to their base form.")
		overlays-='SSj4 Overlay.dmi'
	FirstTransDrainless=0
	transenergydraining=0
	transstaticenergydraining=0

mob/proc/Super_Sparks()
	overlays.Remove('Elec.dmi','Electric_Blue.dmi','Electric_Yellow.dmi','SSj4 Overlay.dmi','Elec.dmi','SSj2_Sparks.dmi','SSBSparkle.dmi','SSBSparks.dmi')
	if(Bojack==1) overlays+='Elec.dmi'
	if(ssj==2) overlays+='SSj2_Sparks.dmi'
	if(ssj==3) overlays+='Electric_Blue.dmi'
	if(ssj==5)
		overlays+='SSBSparks.dmi'
		overlays+='SSBSparkle.dmi'
		//overlays+=Glow
	if(ssj==6) overlays+='Electric_Blue.dmi'



mob/proc/Super_Hair()
	var/bighair=0
	for(var/Skill/Buff/Expand/E in src) if (E.Using) bighair=1
	overlays.Remove(hair,SSjHair,USSjHair,SSjFPHair,SSj2Hair,SSj3Hair,SSj4Hair,SSGFPHair,SSGSSHair,SSRHair,SSGHair)
	if(!ssj&&GodKiActive&&Race=="Saiyan") overlays+=SSGHair
	else if(!ssj|ismystic&&ssj<3) overlays+=hair
	else if(ssj&&ssj<3&&bighair) overlays+=USSjHair
	else if(ssj==1&&SSjDrain<300) overlays+=SSjHair
	else if(ssj==1) overlays+=SSjFPHair
	else if(ssj==2) overlays+=SSj2Hair
	else if(ssj==3) overlays+=SSj3Hair
	else if(ssj==4) overlays+=SSj4Hair
	else if(ssj==5)
		if(SSGSSColor=="Rose") overlays+=SSRHair
		else if(ssj==5&&SSGSSDrain<300) overlays+=SSGSSHair
		else if(ssj==5) overlays+=SSGFPHair
	else if(ssj==6) overlays+=SSj3Hair


mob/proc/BojackSSj()
	//if(!BojackAt) return
	if(Race!="Heran") if(Race!="Half-Heran") return
	if(src.RoidPower) return
	if(BuffNumber>=BuffLimit)
		src.BuffOut("You are already using too many buffs.")
		return
	/*if(Age<5)
		src<<"You must be atleast 5 years old."
		return*/
	if(!transing&&!Bojack)
		if(!HasBojack) return
		//if(!SparSSj&&!HasBojack&&!Global_SSJ) return
		if(!HasBojack) HasBojack=1
		//if(!locate(/Skill/Buff/Bojack) in src) contents+=new/Skill/Buff/Bojack
		transing=1
		HairRemove()
		src.BuffNumber++
		src.Buffs+="Transformation"
		FirstTransWPRestore(src)
		Bojack=1
		HairAdd()
		BPMult*=BojackMult
		StrMult*=1.1
		PowMult*=1.1
		OffMult*=1.1
		Super_Sparks()
		transing=0
		oicon=icon
		for(var/mob/player/M in view(src)) M.BuffOut("[src] uses their Bojack transformation!")
		if(src.Form2Icon) src.icon=Form2Icon
		if(SSjDrain<200) Crater(src)
		if(SSjDrain<300)
			if(!FirstTransDrainless)transenergydraining=MediumDrain
		else if(!FBMAchieved) transenergydraining=LowDrain

mob/proc/BojackSSj2()
	if(Bojack!=1) return
	if(src.RoidPower) return
	/*if(Age<8)
		src<<"You must be atleast 8 years old."
		return*/
	if(HasBojack!=2) return
	if(!transing&&Bojack!=2)
		//if(!locate(/Skill/Buff/Bojack) in src) contents+=new/Skill/Buff/Bojack//given by the learn system
		transing=1
		FirstTransWPRestore(src,2)
		HairRemove()
		Bojack=2
		//Super_Saiyan_Effects()
		HairAdd()
		BPMult*=SuperBojackMult
		EndMult*=1.1
		DefMult*=1.1
		Super_Sparks()
		transing=0
		//oicon=icon
		for(var/mob/player/M in view(src)) M.BuffOut("[src] pushes their Bojack transformation even further!")
		if(src.Form3Icon) src.icon=Form3Icon
		Crater(src)
		if(SSj2Drain<300)
			if(!FirstTransDrainless)transenergydraining=MediumDrain
		else if(FBMAchieved==2) transstaticenergydraining=MediumStaticDrain
		else transenergydraining=LowDrain


Skill/Buff/AlienTransformation
	desc="Alien Transformation"
	verb/Transform()
		set category="Skills"
		set src = usr.contents
		if(!usr.AlienTrans&&!usr.Bojack)
			if(usr.KOd==0)
				usr<<"You awaken your race's transformation!"
				if(usr.Race=="Heran"||usr.Race=="Half-Heran")
					if(usr.Bojack==1) usr.BojackSSj2()
					usr.BojackSSj()
				else usr.Bojack()
		else if(usr.HasBojack==2&&usr.Bojack<2)
	//		usr<<"You awaken your race's second transformation!"
			usr.BojackSSj2()
	verb/Revert()
		set category="Skills"
		set src = usr.contents
		usr<<"You force yourself to revert."
		usr.Cancel_Transformation()
		sleep(1)
		usr.Cancel_Transformation()
		usr.AuraOverlays()
	verb/Customize_Transformation_Icon()
		set category="Other"
		if(usr.Confirm("Do you want to have custom icon for your transformation?")) usr.Customize_Form_2()
		if(usr.HasBojack==2) if(usr.Confirm("Do you want to have custom icon for your Super Bojack?")) usr.Customize_Form_3()

Skill/Buff/Super_Bojack
	desc="Super Bojack"
	verb/Transform()
		set category="Skills"
		set src = usr.contents
		if(!usr.Bojack)
			if(usr.KOd==0)
				if(usr.Race=="Heran"||usr.Race=="Half-Heran")
					if(usr.Bojack==1) usr.BojackSSj2()
					usr.BojackSSj()
//		else if(usr.HasBojack==2&&usr.Bojack<2) usr.BojackSSj2()
	verb/Revert()
		set category="Skills"
		set src = usr.contents
		usr<<"You force yourself to revert."
		usr.Cancel_Transformation()
		sleep(1)
		usr.Cancel_Transformation()
		usr.AuraOverlays()
	verb/Customize_Transformation_Icon()
		set category="Other"
		if(usr.Confirm("Do you want to have custom icon for your transformation?")) usr.Customize_Form_2()
		if(usr.HasBojack==2) if(usr.Confirm("Do you want to have custom icon for your Super Bojack?")) usr.Customize_Form_3()


mob/proc/Bojack()
	if(src.RoidPower) return
	if(BuffNumber>=BuffLimit)
		src.BuffOut("You are already using too many buffs.")
		return
	/*if(Age<5)
		src<<"You must be atleast 5 years old."
		return*/
	if(!src.transing&&!src.AlienTrans) if(HasAlienTrans)
		//if(src.Melee_Build==1) src.Melee_Build=2
		src.transing=1
		if(!locate(/Skill/Buff/AlienTransformation) in src) contents+=new/Skill/Buff/AlienTransformation
		src.AlienTrans=1
		src.BPMult*=1.55
		src.SpdMult*=1.2
		src.StrMult*=1.3
		src.PowMult*=1.3
		src.BuffNumber++
		FirstTransWPRestore(src)
		src.Buffs+="Transformation"
		src.oicon=src.icon
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms!")
		if(src.Form2Icon) src.icon=Form2Icon
		else
			src.Overlays=list()
			src.Overlays+=src.overlays
			src.overlays-=src.overlays
			if(src.gender=="male"||"Asexual") src.icon='Bojack Expand.dmi'
			if(src.gender=="female") src.icon='Bojack Expand Female.dmi'
		if(TransDrain<300)
			if(!FirstTransDrainless)transenergydraining=MediumDrain
		else if(!FBMAchieved) transstaticenergydraining=MediumStaticDrain

mob/proc/Alien_Revert()

	if(Bojack==1) //if(AlienTrans)
		src.Bojack=0
		overlays-=SSGHair
		overlays.Remove(hair,SSjHair,USSjHair,SSjFPHair,SSj2Hair,SSj3Hair,SSj4Hair,SSGFPHair,SSGSSHair,SSGHair)
		overlays+=hair
		src.icon=src.oicon
		src.BPMult/=BojackMult
		src.StrMult/=1.1
		src.PowMult/=1.1
		src.OffMult/=1.1
		src.Super_Sparks()
//		src.SSjPower=0
		BuffNumber--
		Buffs-="Transformation"
		for(var/mob/player/M in view(src)) M.BuffOut("[src] reverts to their base form.")
	else if(Bojack==2) //if(AlienTrans)
		src.Bojack=0
		overlays-=SSGHair
		overlays.Remove(hair,SSjHair,USSjHair,SSjFPHair,SSj2Hair,SSj3Hair,SSj4Hair,SSGFPHair,SSGSSHair,SSGHair)
		overlays+=hair
		src.icon=src.oicon
		src.BPMult/=BojackMult*SuperBojackMult
		src.StrMult/=1.1
		src.PowMult/=1.1
		src.OffMult/=1.1
		src.EndMult/=1.1
		src.DefMult/=1.1
		src.Super_Sparks()
//		src.SSjPower=0
		BuffNumber--
		for(var/mob/player/M in view(src)) M.BuffOut("[src] reverts to their base form.")
		Buffs-="Transformation"
	else if(AlienTrans)
		src.BPMult/=1.55
		src.StrMult/=1.3
		src.PowMult/=1.3
		src.SpdMult/=1.2
		src.transing=0
		if(src.Form2Icon)
			src.overlays+=src.Overlays
			src.Overlays=list()
		src.icon=src.oicon
		src.AlienTrans=0
		BuffNumber--
		for(var/mob/player/M in view(src)) M.BuffOut("[src] reverts to their base form.")
		Buffs-="Transformation"

/*	verb/Change_God_Ki_Aura()
		set category="Other"
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
				usr.GodKiAura=new/Icon_Obj/Cloak/GodAura*/

Skill/Buff/SSj
	RequiresApproval=0
	name="Super Saiyan"
	desc="You possess the ability to transform into an ascended Saiyan!"
	verb/Super_Saiyan(num=1 as num)
		set category="Skills"
		set src = usr.contents
		set desc ="Choose your level of Super Saiyan"
		if(num) num=round(num)
		if(usr.client)
			if(usr.KOd==0)
				if(usr.GodKiActive)
					usr.SSGSS()
					return
				if(usr.HasSSj==1)
					usr.Cancel_Transformation()
					usr.SSj()
					return
				if(num>usr.HasSSj) num=usr.HasSSj
				if(num<1) num=1
				switch(num)
					if(1) if(usr.ssj!=1&&usr.HasSSj)
						if(usr.ssj>1) usr.Cancel_Transformation()
						usr.SSj()
					if(2) if(usr.HasSSj>=2&&usr.SSjDrain>=300) if(usr.ssj!=2)
						if(usr.ssj>2) usr.Cancel_Transformation()
						if(usr.ssj!=1) usr.SSj()
						usr.SSj2()
					if(3) if(usr.HasSSj>=3&&usr.SSj2Drain>=300) if(usr.ssj!=3)
						if(usr.ssj>3) usr.Cancel_Transformation()
						if(usr.ssj!=1) usr.SSj()
						if(usr.ssj!=2) usr.SSj2()
						usr.SSj3()
					if(4) if(usr.HasSSj4&&usr.ssj!=4)
						if(usr.ssj) usr.Cancel_Transformation()
						usr.SSj4()
					if(6) if(usr.HasSSj6&&usr.ssj!=6)
						if(usr.ssj) usr.Cancel_Transformation()
						usr.SSj6()
	verb/Revert()
		set category="Skills"
		set src = usr.contents
		if(usr.ssj)
			usr.Cancel_Transformation()
			sleep(1)
			usr.Cancel_Transformation()
			usr.AuraOverlays()



mob/proc/SSGSS()
	if(RoidPower) return
	if(Race!="Saiyan"&&!IsFusion) return
	if(Class=="Legendary") return
	if(Oozaru) return
	if(!GodKiActive)
		src.BuffOut("You may only use SSGSS while utilizing God Ki.")
		return
	if(BuffNumber>=BuffLimit)
		src.BuffOut("You are already using too many buffs.")
		return
	if(HasSSj4)
		src.BuffOut("You may not use SSGSS while possessing SSj4.")
		return
	if(!transing&&!ssj)
		if(!GodKi) return
		if(!SparGodKi) return
		Cancel_Transformation()
		if(!SSGSSColor)
			if(prob(10)) SSGSSColor="Rose"
			else SSGSSColor="Blue"
		HairRemove()
		transing=1
		ssj=5
		FirstTransWPRestore(src,5)
		Super_Saiyan_God_Effects()
		HairAdd()
		Super_Sparks()
		BPMult*=2.1
		StrMult*=1.2
		PowMult*=1.2
		OffMult*=1.2
		DefMult*=1.2
		overlays+=/Icon_Obj/Cloak/SSBCloak
		transing=0
		BuffNumber++
		Buffs+="Super Saiyan"
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into a Super Saiyan God Super Saiyan!")
		if(SSGSSDrain<300)
			if(!FirstTransDrainless)transenergydraining=MediumDrain
		else transenergydraining=LowDrain

mob/proc/SSj()
	if(RoidPower) return
	if(!IsFusion&&Race!="Saiyan"&&Race!="Half-Saiyan"&&Race!="Part-Saiyan") return
	if(BuffNumber>=BuffLimit)
		src.BuffOut("You are already using too many buffs.")
		return
	if(GodKiActive&&Race=="Saiyan")
		SSGSS()
		return
	if(Oozaru) return
	if(!HasSSj) return
	if(!SparSSj&&!HasSSj) return
	if(!transing&&!ssj)
		if(!HasSSj) HasSSj=1
		if(!locate(/Skill/Buff/SSj) in src) contents+=new/Skill/Buff/SSj
		HairRemove()
		transing=1
		ssj=1
		if(Race=="Half-Saiyan") SSjDrain=300
		if(!ismystic) Super_Saiyan_Effects()
		if(GodKiActive)overlays+=/Icon_Obj/Cloak/BlueCloak
		HairAdd()
		BPMult*=SSjMult
		StrMult*=1.2
		PowMult*=1.2
		OffMult*=1.2
		DefMult*=1.2
		transing=0
		BuffNumber++
		FirstTransWPRestore(src)
		Buffs+="Super Saiyan"
		if(Class=="Legendary")
			underlays+=/Icon_Obj/Cloak/LSSJCloak
			//EndMult*=1.3
			SSjDrain=300
		else underlays+=/Icon_Obj/Cloak/SSJCloak
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into a Super Saiyan!")
		if(Class!="Legendary")
			if(SSjDrain<300)
				if(!FirstTransDrainless)transenergydraining=MediumDrain
			else if(!FBMAchieved) transenergydraining=LowDrain


mob/proc/SSj2() if(!transing&&ssj==1)
	if(src.RoidPower) return
	if(!IsFusion)if(Race!="Saiyan") if(Race!="Half-Saiyan") if(Race!="Part-Saiyan") return
	if(Oozaru) return
	if(GodKiActive&&Race=="Saiyan")
		src.BuffOut("You may only use SSGSS while utilizing God Ki.")
		return
	if(SSjDrain<290) return
	if(HasSSj<2) return
	HairRemove()
	FirstTransWPRestore(src,2)
	transing=1
	ssj=2
	if(HasSSj<2) HasSSj=2
	if(!ismystic) Super_Saiyan_2_Effects()
	HairAdd()
	Super_Sparks()
	BPMult*=SSj2Mult

	if(Class=="Legendary")
		underlays+=/Icon_Obj/Cloak/LSSJCloak
		EndMult*=1.2
		OffMult*=1.1
		DefMult*=1.1
	transing=0
	for(var/mob/player/M in view(src)) M.BuffOut("[src] ascends past the power of a Super Saiyan!")
	if(Class!="Legendary")
		if(SSj2Drain<300)
			if(!FirstTransDrainless)transenergydraining=MediumDrain
		else transenergydraining=LowDrain

mob/proc/SSj3() if(!transing&&ssj==2)
	if(src.RoidPower) return
	if(!IsFusion)if(Race!="Saiyan") if(Race!="Half-Saiyan") if(Race!="Part-Saiyan") return
	if(Oozaru) return
	if(GodKiActive&&Race=="Saiyan")
		src.BuffOut("You may only use SSGSS while utilizing God Ki.")
		return
	if(SSj2Drain<290) return
	if(HasSSj<3) return
	HairRemove()
	FirstTransWPRestore(src,3)
	transing=1
	ssj=3
	if(HasSSj<3) HasSSj=3
	if(!ismystic) Super_Saiyan_3_Effects()
	HairAdd()
	Super_Sparks()
	BPMult*=SSj3Mult
	transing=0
	for(var/mob/player/M in view(src)) M.BuffOut("[src] ascends even further beyond the power of a Super Saiyan!")
	if(SSj3Drain<300)
		if(!FirstTransDrainless)
			transenergydraining=HighDrain
	else
		transenergydraining=MediumDrain
	transstaticenergydraining=MediumStaticDrain

mob/proc/SSj4() if(!transing&&!ssj) if(HasSSj4)
	if(src.RoidPower) return
	if(BuffNumber>=BuffLimit)
		src.BuffOut("You are already using too many buffs.")
		return
	if(Oozaru) Oozaru_Revert()
	if(GodKiActive)
		src.BuffOut("You may only use SSGSS while utilizing God Ki.")
		return
	if(SSj3Drain<300)
		src.BuffOut("You can feel your body trying to tap into a great power, but just before you can harness it, it slips away. You need to master Super Saiyan 3 first.")
		return
	transing=1
	FirstTransWPRestore(src,4)
	HairRemove()
	BuffNumber++
	Buffs+="Super Saiyan"
	ssj=4
	Super_Saiyan_4_Effects()
	Super_Sparks()
	BPMult*=2.5
	RegenMult*=1.3
	IgnoresGodKi=1
	transing=0
	var/list/Old_Overlays=new
	overlays-=hair
	Old_Overlays.Add(overlays)
	overlays-=overlays
	overlays+='SSj4 Overlay.dmi'
	overlays+=Old_Overlays
	HairAdd()
	for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into a Super Saiyan 4!")

mob/proc/SSj6() if(!transing&&ssj==4) if(Class=="Primal")
	if(src.Class=="Legendary" || Class=="Low") return
	if(src.RoidPower) return
	if(!IsFusion)if(Race!="Saiyan") if(Race!="Half-Saiyan") if(Race!="Part-Saiyan") return
	if(Oozaru) return
	if(GodKiActive&&Race=="Saiyan")
		src.BuffOut("You may only use SSGSS while utilizing God Ki.")
		return
	if(SSj3Drain<290) return
	if(HasSSj<6) return
	HairRemove()
	FirstTransWPRestore(src,3)
	transing=1
	ssj=6
	if(HasSSj<6) HasSSj=6
	if(!ismystic) Super_Saiyan_3_Effects()
	HairAdd()
	Super_Sparks()
	BPMult*=SSj6Mult
	transing=0
	for(var/mob/player/M in view(src)) M.BuffOut("[src] ascends even further beyond the power of a Super Saiyan!")
	if(SSj3Drain<300)
		if(!FirstTransDrainless)
			transenergydraining=HighDrain
	else
		transenergydraining=MediumDrain
	transstaticenergydraining=MediumStaticDrain

Skill/Buff/ChangelingTransformation
	RequiresApproval=0
	name="Changeling Transformation"
	GetDescription()
		return "You possess the ability to transform into another form!"
		..()
	verb/Transform()
		set category="Skills"
		set src = usr.contents
		if(usr.client) if(usr.KOd==0) usr.Changeling_Forms()
	verb/Revert()
		set category="Skills"
		set src = usr.contents
		if(usr.Form)
			while(usr.Form)
				usr.Cancel_Transformation()
				sleep(1)
	verb/Customize_Transformation_Icon()
		set category="Other"
		if(usr.Confirm("Do you want to have custom icons for your changeling forms?"))
			usr.Customize_Form_1()
			usr.Customize_Form_2()
			usr.Customize_Form_3()
			usr.Customize_Form_4()
			if(usr.Class=="Cooler") usr.Customize_Form_5()
			usr.Customize_Form_6()
			if(usr.Class=="Frieza") usr.Customize_Form_7()


mob/proc/Changeling_Forms() if(IsFusion||Race=="Changeling"||Race=="Half-Changeling")//if(!AndroidLevel)
	if(Form==3&&Class=="Frieza"&&HasForm>=5)//black frieza form
		if(src.RoidPower) return
		if(Form6Icon)icon=Form7Icon
		overlays-=overlays
		Form=7
		FirstTransWPRestore(src,5)
		//Form6Mult=1.25//max(1.25,round((GodKi/1.5),0.1))
		BPMult *= Form7Mult
		ZenkaiPower*=Form7Mult
		IgnoresGodKi = 1
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their Destroyer form!")
		overlays+=/Icon_Obj/Cloak/SSBCloak
		if(Form7Drain<300)
			if(!FirstTransDrainless)transenergydraining=HighDrain
		else transenergydraining=MediumDrain
	if(Form==1&&Class=="King Kold"&&HasForm>=5)
		if(src.RoidPower) return
		if(Form6Icon)icon=Form6Icon
		overlays-=overlays
		Form=5
		FirstTransWPRestore(src,5)
		//Form6Mult=1.25//max(1.25,round((GodKi/1.5),0.1))
		BPMult *= Form6Mult
		ZenkaiPower*=Form6Mult
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their ultimate form!")
		overlays+=/Icon_Obj/Cloak/SSBCloak
		if(Form6Drain<300)
			if(!FirstTransDrainless)transenergydraining=HighDrain
		else transenergydraining=MediumDrain
	if(Form==4&&Class=="Cooler"&&HasForm>=5)
		if(src.RoidPower) return
		if(Form6Icon)icon=Form6Icon
		overlays-=overlays
		Form=5
		FirstTransWPRestore(src,5)
		//Form6Mult=1.25//max(1.25,round((GodKi/1.5),0.1))
		BPMult *= Form6Mult
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their ultimate form!")
		overlays+=/Icon_Obj/Cloak/SSBCloak
		if(Form6Drain<300)
			if(!FirstTransDrainless)transenergydraining=HighDrain
		else transenergydraining=MediumDrain
	if(Form==3&&Class!="Cooler"&&Class!="King Kold"&&HasForm>=5)
		if(src.RoidPower) return
		if(Form6Icon)icon=Form6Icon
		overlays-=overlays
		Form=5
		FirstTransWPRestore(src,5)
		//Form6Mult=1.25//max(1.25,round((GodKi/1.5),0.1))
		BPMult *= Form6Mult
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their ultimate form!")
		overlays+=/Icon_Obj/Cloak/SSBCloak
		if(Form6Drain<300)
			if(!FirstTransDrainless)transenergydraining=HighDrain
		else transenergydraining=MediumDrain
//Cooler 5th form template, to be activated once everything else is ready.
	if(Form==3&&Class=="Cooler"&&HasForm>=4)
		Form=4
		FirstTransWPRestore(src,4)
		BPMult *= Form5Mult
		if(Form5Icon)icon=Form5Icon
		overlays-=overlays
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into a form beyond their final form!")
	if(Form==2&&Class=="Cooler"&&HasForm>=3)
		Form=3
		FirstTransWPRestore(src,3)
		BPMult *= Form4Mult
		if(Form4Icon)icon=Form4Icon
		overlays-=overlays
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their final form... Or is it?!")
	if(Form==2&&Class!="Cooler"&&Class!="King Kold"&&HasForm>=3)
		Form=3
		FirstTransWPRestore(src,3)
		BPMult *= Form4Mult
		if(Form4Icon)icon=Form4Icon
		overlays-=overlays
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their final form!")
	if(Form==1&&Class!="King Kold"&&HasForm>=2)
		Form=2
		FirstTransWPRestore(src,2)
		BPMult *= Form3Mult
		if(Form3Icon)icon=Form3Icon
		overlays-=overlays
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their third form!")
	if(!Form&&Class!="King Kold"&&HasForm>=1)
		if(BuffNumber>=BuffLimit)
			src.BuffOut("You are already using too many buffs.")
			return
		BuffNumber++
		Buffs+="Transformation"
		FirstTransWPRestore(src)
		Form=1
		BPMult *= Form2Mult
		if(Form2Icon)icon=Form2Icon
		overlays-=overlays
		if(!locate(/Skill/Buff/ChangelingTransformation) in usr) contents+=new/Skill/Buff/ChangelingTransformation
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their second form!")
	if(!Form&&Class=="King Kold"&&HasForm>=1)
		if(BuffNumber>=BuffLimit)
			src.BuffOut("You are already using too many buffs.")
			return
		BuffNumber++
		Buffs+="Transformation"
		FirstTransWPRestore(src)
		Form=1
		BPMult *= Form2Mult
		if(Form2Icon)icon=Form2Icon
		overlays-=overlays
		if(!locate(/Skill/Buff/ChangelingTransformation) in usr) contents+=new/Skill/Buff/ChangelingTransformation
		for(var/mob/player/M in view(src)) M.BuffOut("[src] transforms into their true form!")




mob/proc/Changeling_Revert()
	overlays-=/Icon_Obj/Cloak/SSBCloak
	switch(Form)
		if(1)
			if(Form1Icon)icon=Form1Icon
			Form=0
			BPMult /= Form2Mult
			BuffNumber--
			Buffs-="Transformation"
		if(2)
			if(Form2Icon)icon=Form2Icon
			Form=1
			BPMult /= Form3Mult
		if(3)
			if(Form3Icon)icon=Form3Icon
			Form=2
			BPMult /= Form4Mult
		if(4)
			if(Form4Icon)icon=Form4Icon
			Form=3
			BPMult /= Form5Mult
		if(5)
			if(Class=="King Kold")
				if(Form2Icon)icon=Form2Icon
				Form=1
				BPMult /= Form6Mult
			if(Class=="Cooler")
				if(Form5Icon)icon=Form5Icon
				Form=4
				BPMult /= Form6Mult
			if(Class=="Undefined Class")
				if(Form4Icon)icon=Form4Icon
				Form=3
				BPMult /= Form6Mult
			if(Class=="Frieza")
				if(Form5Icon)icon=Form5Icon
				Form=3
				BPMult /= Form6Mult
		if(6)
			if(Form6Icon)icon=Form6Icon
			Form=5
			BPMult /= Form7Mult
			IgnoresGodKi = 0


mob/proc/Quake()
	var/duration=rand(10,30)
	if(client) while(duration)
		duration-=1
		for(var/mob/player/M in view(src)) if(M.client)
			M.client.pixel_x+=rand(-8,8)
			M.client.pixel_y+=rand(-8,8)
			if(!duration)
				M.client.pixel_x=0
				M.client.pixel_y=0
		sleep(1)

mob/proc/Super_Saiyan_Effects()
//	set waitfor = 0
	if(!Global_SSJ) if(SSjDrain<160) spawn for(var/area/A in view(20,src)) A.Super_Darkness()
	if(!Global_SSJ) if(SSjDrain<220) spawn for(var/turf/A in view(10,src)) if(prob(10))
		A.Rising_Rocks()
		sleep(10)
	var/Quakes=5
	if(SSjDrain>160) Quakes=3
	if(SSjDrain>180) Quakes=2
	if(SSjDrain>200) Quakes=1
	if(SSjDrain>220) Quakes=0
	if(!Global_SSJ) spawn while(Quakes)
		sleep(rand(30,100))
		Quakes-=1
		for(var/mob/A in view(20,src)) if(A.client) spawn A.Quake()
	if(!Global_SSJ)
		if(SSjDrain<160) spawn Super_Lightning()
		if(SSjDrain<200) spawn New_Lightning()
	var/Amount=10
	if(SSjDrain>160) Amount=5
	if(SSjDrain>180) Amount=3
	if(SSjDrain>200) Amount=2
	if(SSjDrain>220) Amount=1
	if(SSjDrain>240) Amount=0
	while(Amount)
		Amount-=1
		overlays-=hair
		overlays+=SSjHair
		sleep(rand(1,3))
		overlays-=SSjHair
		overlays+=hair
		sleep(rand(1,40))
	if(Class=="Heran") overlays+=/Icon_Obj/Cloak/Bojack
	else overlays+=/Icon_Obj/Cloak/SSJ1
	if(SSjDrain<200) Crater(src)
	if(Race=="Saiyan"||Race=="Half-Saiyan") for(var/mob/A in view(15,src)) if(A.client) A.SparSSj+=50

mob/proc/Super_Saiyan_2_Effects()
//	set waitfor=0
	overlays-=/Icon_Obj/Cloak/SSJ1
	overlays-=/Icon_Obj/Cloak/SSJ1
	var/Amount=10
	if(SSj2Drain>160) Amount=5
	if(SSj2Drain>180) Amount=3
	if(SSj2Drain>200) Amount=2
	if(SSj2Drain>220) Amount=1
	if(SSj2Drain>240) Amount=0
	while(Amount)
		Amount-=1
		overlays-=SSjHair
		overlays+=SSj2Hair
		sleep(rand(1,3))
		overlays-=SSj2Hair
		overlays+=SSjHair
		sleep(rand(1,30))
	if(SSj2Drain<280) overlays+=/Icon_Obj/Cloak/SSJ2
	else overlays+=/Icon_Obj/Cloak/SSJ2FP
	if(SSj2Drain<200) Crater(src)
	if(SSj2Drain<240) spawn for(var/turf/A in view(10,src)) if(prob(20)) A.Rising_Rocks()
	for(var/mob/A in view(15,src)) if(A.client) A.SparSSj+=100


mob/proc/Super_Saiyan_3_Effects()
//	set waitfor=0
	overlays-=/Icon_Obj/Cloak/SSJ1
	overlays-=/Icon_Obj/Cloak/SSJ1
	var/Amount=10
	if(SSj3Drain>160) Amount=5
	if(SSj3Drain>180) Amount=3
	if(SSj3Drain>200) Amount=2
	if(SSj3Drain>220) Amount=1
	if(SSj3Drain>240) Amount=0
	while(Amount)
		Amount-=1
		overlays-=SSj2Hair
		overlays+=SSj3Hair
		sleep(rand(1,3))
		overlays-=SSj3Hair
		overlays+=SSj2Hair
		sleep(rand(1,30))
	overlays+=/Icon_Obj/Cloak/SSJ1
	if(SSj3Drain<200) Crater(src)
	if(SSj3Drain<240) spawn for(var/turf/A in view(5,src)) if(prob(20)) A.Rising_Rocks()
	for(var/mob/A in view(15,src)) if(A.client) A.SparSSj+=100


mob/proc/Super_Saiyan_4_Effects() Super_Saiyan_Effects()

mob/proc/Super_Saiyan_6_Effects()
//	set waitfor=0
	overlays-=/Icon_Obj/Cloak/SSJ1
	overlays-=/Icon_Obj/Cloak/SSJ1
	var/Amount=10
	if(SSj3Drain>160) Amount=5
	if(SSj3Drain>180) Amount=3
	if(SSj3Drain>200) Amount=2
	if(SSj3Drain>220) Amount=1
	if(SSj3Drain>240) Amount=0
	while(Amount)
		Amount-=1
		overlays-=SSj2Hair
		overlays+=SSj3Hair
		sleep(rand(1,3))
		overlays-=SSj3Hair
		overlays+=SSj2Hair  // I have waitied
		sleep(rand(1,30))
	overlays+=/Icon_Obj/Cloak/SSJ1
	if(SSj3Drain<200) Crater(src)
	if(SSj3Drain<240) spawn for(var/turf/A in view(5,src)) if(prob(20)) A.Rising_Rocks()
	for(var/mob/A in view(15,src)) if(A.client) A.SparSSj+=100

mob/proc/Super_Saiyan_God_Effects()
	switch(SSGSSColor)
		if("Blue") SSBEffects()
		if("Rose") SSREffects()

mob/proc
	SSBEffects()
//		set waitfor=0
		Shockwave()
		overlays-=/Icon_Obj/Cloak/SSG2
		if(SSGSSDrain<220) spawn for(var/turf/A in view(10,src)) if(prob(10))
			A.Rising_Rocks()
			sleep(10)
		if(SSGSSDrain<200) spawn Super_Lightning()
		if(SSGSSDrain<200) spawn New_Lightning()
		var/Amount=6
		if(SSGSSDrain>160) Amount=5
		if(SSGSSDrain>180) Amount=3
		if(SSGSSDrain>200) Amount=2
		if(SSGSSDrain>220) Amount=1
		if(SSGSSDrain>240) Amount=0
		while(Amount)
			Amount-=1
			overlays-=SSGHair
			overlays-=hair
			overlays-='SSGAura.dmi'
			overlays+=SSGSSHair
			overlays+=/Icon_Obj/Cloak/SSGSS
			sleep(rand(1,3))
			overlays-=SSGSSHair
			overlays-=/Icon_Obj/Cloak/SSGSS
			Super_Sparks()
			overlays+=SSGHair
			sleep(rand(1,30))
		if(SSGSSDrain<=290)
			overlays+=/Icon_Obj/Cloak/SSGSS
		if(SSGSSDrain>290)
			overlays+=/Icon_Obj/Cloak/SSGFP
		if(SSGSSDrain<200) Crater(src)
		if(SSGSSDrain<240) spawn for(var/turf/A in view(10,src)) if(prob(20)) A.Rising_Rocks()
		for(var/mob/A in view(15,src)) if(A.client) A.SparGodKi++


	SSREffects()
//		set waitfor=0
		if(SSGSSDrain<220) spawn for(var/turf/A in view(10,src)) if(prob(10))
			A.Rising_Rocks()
			sleep(10)
		if(SSGSSDrain<200) spawn Super_Lightning()
		if(SSGSSDrain<200) spawn New_Lightning()
		var/Amount=6
		if(SSGSSDrain>160) Amount=5
		if(SSGSSDrain>180) Amount=3
		if(SSGSSDrain>200) Amount=2
		if(SSGSSDrain>220) Amount=1
		if(SSGSSDrain>240) Amount=0
		while(Amount)
			Amount-=1
			overlays-=SSGHair
			overlays-=hair
			overlays+=SSRHair
			overlays+=/Icon_Obj/Cloak/SSR
			sleep(rand(1,3))
			overlays-=SSRHair
			overlays-=/Icon_Obj/Cloak/SSR
			overlays+=SSGHair
			sleep(rand(1,30))
		if(SSGSSDrain<=290) overlays+=/Icon_Obj/Cloak/SSR
		if(SSGSSDrain<200) Crater(src)
		if(SSGSSDrain<240) spawn for(var/turf/A in view(10,src)) if(prob(20)) A.Rising_Rocks()
		for(var/mob/A in view(15,src)) if(A.client) A.SparGodKi++
		//spawn(rand(600,900)) overlays-=/Icon_Obj/Cloak/SSR



area/proc/Super_Darkness()
	var/image/A=image(icon='Weather.dmi', icon_state="Super Darkness")
	overlays+=A
	spawn(400) if(src)
		overlays-=A
		overlays=null
mob/proc/Super_Lightning()
	var/Amount=7
	var/list/Locs=new
	for(var/turf/B in range(20,src)) Locs+=B
	while(Amount)
		Amount-=1
		var/obj/Lightning_Strike/A=new
		A.loc=pick(Locs)
		sleep(rand(1,40))


mob/proc/New_Lightning()
	var/Amount=4
	var/list/Locs=new
	for(var/turf/B in range(5,src)) Locs+=B
	while(Amount)
		Amount-=1
		var/obj/LightningStrike/A=new
		A.loc=pick(Locs)
		sleep(rand(1,40))
	var/obj/LightningStrike/A=new
	A.loc=src.loc



mob/proc/FirstTimeTransformationEffects(var/OverlayFlicker,var/iconFlicker)
	spawn for(var/area/A in view(20,src)) A.Super_Darkness()
	spawn for(var/turf/A in view(10,src)) if(prob(10))
		A.Rising_Rocks()
		sleep(10)
	var/Quakes=5
	spawn while(Quakes)
		sleep(rand(30,100))
		Quakes-=1
		for(var/mob/A in view(20,src)) if(A.client) spawn A.Quake()
	spawn Super_Lightning()
	spawn New_Lightning()
	var/Amount=10
	while(Amount)
		Amount-=1
		if(OverlayFlicker)//flicks overlay on and off if it was passed to the proc
			overlays-=OverlayFlicker//precents doubled overlays
			overlays+=OverlayFlicker
		if(iconFlicker)//flicks new base icon on and off if it was passed to the proc
			oicon=icon
			icon=iconFlicker
		sleep(rand(1,3))
		if(OverlayFlicker)
			overlays-=OverlayFlicker
		if(iconFlicker)
			icon=oicon
		sleep(rand(1,40))
	Shockwave()
	Crater(src)
