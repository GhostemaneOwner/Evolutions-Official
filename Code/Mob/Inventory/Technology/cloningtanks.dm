var/list/glob_ClonTanks




mob/var
	BeenCloned
	WasCloned
obj/items/Cloning_Tank
// BYOND works by way of inheritence. Because I've defined New() for Cloning_Tank and
// all other cloning tanks fall under this one, they'll trigger the New() here, which works
// excellently because the variables defined here, and the calls required are the same for
// reach cloning tank.
// Only when something differs will you have to adjust them within that specific cloning tanks.
	icon = 'New cloning tank.dmi'
	layer=4
	density=1
	Bolted=1
//
	Savable = 1
	var/dura_take = 100
	var/dura = 100
	var/reviveTime
	var/show_name
	var/nerfMult=0.6 // Default value, just in case.
	var/mob/player/playerRevival // The player being revived
	New()
		..()
		src.pixel_x -= 32
		src.pixel_y -= 16
		//var/image/A=image(icon='Lab.dmi',icon_state="Tube2",layer=layer+1,pixel_y=-12,pixel_x=0)
		//var/image/B=image(icon='Lab.dmi',icon_state="Tube2Top",layer=layer+1,pixel_y=20,pixel_x=0)
		//var/image/C=image(icon='Lab.dmi',icon_state="Lab2",layer=layer,pixel_y=0,pixel_x=28)
		//overlays.Add(A,B,C)
		if(!glob_ClonTanks) glob_ClonTanks=new // If the list hasn't been created yet, create a new one.
		//if(z!=0)
		glob_ClonTanks+=src // glob_ClonTanks is the global list which is looked through
							// upon a players death, to see if they should be revived.
	Del()

		if(glob_ClonTanks)
			src.Password=null
			glob_ClonTanks-=src // And when a cloning tank is destroyed, we want it to be removed from the list
			if(!glob_ClonTanks|!glob_ClonTanks.len) glob_ClonTanks=null // If the list is empty, let the garbage handler delete the list.

		if(playerRevival)
			playerRevival.Death("the destruction of their cloning tank") // If there's a player in there, kill them.
			//playerRevival.insideTank=null // FIRST erase the tank they should be revived at and THEN trigger death, incase they have another tank.

		..() // and then continue on with the default behavior, like removing the actual object and creating a crater and such.

proc/Has_Tank(var/mob/player/P)
	checkNullTanks()
	for(var/obj/items/Cloning_Tank/tank in glob_ClonTanks)
		if(tank.Password=="[P.real_name] ([P.key])"&&P.Dead)
			return tank
			break

proc/checkNullTanks()
	for(var/obj/items/Cloning_Tank/tank in glob_ClonTanks)
		if(tank.z==0) // sanity check procedure. This should never happen though.
			tank.Password=null
			glob_ClonTanks-=tank
			del tank

proc/Clone_Detection(var/mob/player/P)

	var/obj/items/Cloning_Tank/chosentank = Has_Tank(P)
	if(chosentank)
		P.loc=chosentank.loc
		P.saveToLog("|  | ([P.x], [P.y], [P.z]) | [key_name(usr)] has been revived by their [chosentank] cloning tank.\n")
	if(chosentank) Clone_Awaken(P,chosentank)

proc/Clone_Awaken(var/mob/player/P,var/obj/items/Cloning_Tank/chosentank)

	P << "<span class=announce>SYSTEM: Death of registrant detected. Activating new body... This process will take [chosentank.reviveTime/600] minutes. You are unable to move during this process...</span>"

	//P.y=chosentank.y+1 // Move em one square  up so it looks like they're inside the tank, using the tank as reference so they dont move up each relog.
	chosentank.playerRevival=P
	P.TotalDeaths--
	chosentank.underlays = null
	P.insideTank=chosentank
	if(P.KOd) P.Un_KO(1) // They need to be up.
	P.move=0 // Dont want them to move until the tank is 'done'
	P.overlays -= 'HaloVP.dmi'
	P.overlays -= 'HaloP.dmi'
	P.overlays -= 'HaloVC.dmi'
	P.overlays -= 'HaloC.dmi'
	P.overlays -= 'HaloN.dmi'
	P.overlays -= image('HaloVP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	P.overlays -= image('HaloP.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	P.overlays -= image('HaloVC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	P.overlays -= image('HaloC.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	P.overlays -= image('HaloN.dmi',layer=MOB_LAYER+EFFECTS_LAYER)
	P.Dead=0
	P.Base*=chosentank.nerfMult
	P.dir=SOUTH
	P.Health = P.MaxHealth
	P.Ki = P.MaxKi
	sleep(chosentank.reviveTime)
	if(!P||!chosentank){return}
	chosentank.playerRevival = null // make sure that they dont get killed once the tank gets blown up and they're already out.
	P << "<span class=announce>SYSTEM: Clone awakened. Welcome back [P.name].</span>"
	P.insideTank=null
	step(P,SOUTH)
	P.move=1
	P.BeenCloned++
	chosentank.dura -= chosentank.dura_take
	//chosentank.icon_state = "ez"
	chosentank.Password = null
	if(P.Race!="Android")
		if(P.BeenCloned>2)P.Willpower=30
		else if(P.BeenCloned>2) P.Willpower=40
		else P.Willpower=50
		P.WasCloned=P.Age
		for(var/BodyPart/L in P) P.Injure_Hurt(100,L,"Cloning Tank")
		P << "<font color = red>You feel very weak from cloning sickness."
		if(P.BeenCloned>=2)P << "<font color = red>This body's power is limited due to the repeated cloning. (-5% BP per successful clone after the first, currently [(P.BeenCloned-1)*7.5] % Loss)"



obj/items/Cloning_Tank/Android_Uplink_Mainframe
	icon = 'Technology64x64.dmi'
	icon_state = "LargeConsole1"
	nerfMult=0.7
	reviveTime=3000 // 5 minutes.
	desc="This will reconstruct an android if they are killed and it is still intact. It will take about five minutes to be reconstructed. Each time you are revived and the mainframe is activated, you lose 30% of your Base BP."

	Click()
		usr<<"This machine is set to rebuild [show_name]"
		..()
	verb/Repair()
		set src in oview(1)
		if(src.dura <= 0)
			if(usr.Confirm("Repair this? It will cost [Commas(src.cost/1.5*(1-(0.15*usr.HasDeepPockets)))] resources"))
				for(var/obj/Resources/R in usr)
					if(R.Value >= src.cost/1.5*(1-(0.15*usr.HasDeepPockets)))
						R.Value -= src.cost/1.5*(1-(0.15*usr.HasDeepPockets))
						usr << "You repair the cloning machine, it cost you [Commas(src.cost/1.5*(1-(0.15*usr.HasDeepPockets)))]."
						src.dura = 100
						//src.icon_state = ""
						return
	verb/Set_Revive()
		set src in oview(1)
		if(usr.Dead)
			usr<<"Dead people cannot use this"
			return
		if(usr.Race!="Android")
			usr<<"You cannot use this machine."
			return
		if(src.dura <= 0)
			usr << "This cloning tank needs to be repaired first."
			return
		var/pass=input("What is this [src]'s password?")
		if(pass!=Password)
			usr<<"Incorrect password.  Disengaging user interface."
			return
		if(pass==Password)
			usr<<"[src] has been set to rebuild [usr] if they die."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has set [src] to rebuild themselves.\n")
			Password="[usr.real_name] ([usr.key])"
			show_name="[usr.name]"
	verb/Set_Password()
		set src in oview(1)
		if(!Password)
			Password=input("Enter a password to keep this [src] from being stolen from you.") as text
			usr<<"Password set!"
		else
			usr<<"Password already set."
			return
obj/items/Cloning_Tank/Modernized_Cloning_Tank

	nerfMult=0.7
	reviveTime=3000 // 5 minutes.
	desc="This will revive you if you are killed and it is still intact. It will take about five minutes to be revived. Each time you are cloned and the cloner is activated, you lose 30% of your Base BP and need to age up to full body over 4 years. Cloning attempts after the first will cause you to lose 7.5% BP, stacking, until you die a natural death."

	Click()
		usr<<"This machine is set to clone [show_name]"
		..()
	verb/Repair()
		set src in oview(1)
		if(src.dura <= 0)
			if(usr.Confirm("Repair this? It will cost [Commas(src.cost/1.5*(1-(0.15*usr.HasDeepPockets)))] resources"))
				for(var/obj/Resources/R in usr)
					if(R.Value >= src.cost/1.5*(1-(0.15*usr.HasDeepPockets)))
						R.Value -= src.cost/1.5*(1-(0.15*usr.HasDeepPockets))
						usr << "You repair the cloning machine, it cost you [Commas(src.cost/1.5*(1-(0.15*usr.HasDeepPockets)))]."
						src.dura = 100
						src.icon_state = ""
						return
	verb/Set_Clone()
		set src in oview(1)
		if(usr.Dead)
			usr<<"Dead people cannot use this"
			return
		if(usr.Race=="Android"||usr.Race=="Majin"||usr.Regenerate)
			usr<<"You cannot use this machine."
			return
		if(src.dura <= 0)
			usr << "This cloning tank needs to be repaired first."
			return
		var/pass=input("What is this [src]'s password?")
		if(pass!=Password)
			usr<<"Incorrect password.  Disengaging user interface."
			return
		if(pass==Password)
			usr<<"[src] has been set to clone [usr] if they die."
			src.underlays = null
			var/image/A=new(usr.icon)
			A.pixel_x = 32
			A.pixel_y = 16
			src.underlays += A
			if(usr.hair)
				var/image/H=new(usr.hair)
				H.pixel_x = 32
				H.pixel_y = 16
				src.underlays += H
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has set [src] to clone themselves.\n")
			Password="[usr.real_name] ([usr.key])"
			show_name="[usr.name]"
	verb/Set_Password()
		set src in oview(1)
		if(!Password)
			Password=input("Enter a password to keep this cloning tank from being stolen from you.") as text
			usr<<"Password set!"
		else
			usr<<"Password already set."
			return

var/list/glob_Phylactery
proc/Phylactery_Awaken(var/mob/player/P,var/obj/items/Phylactery/chosenPhylactery)

	P << "<span class=announce>Your soul finds its way back to its Phylactery by which it is tethered. Through magic, a new body begins to form around the arcane device where your heart should be. This process will take [chosenPhylactery.reviveTime/600] minutes.</span>"
	chosenPhylactery.playerRevival=P
	chosenPhylactery.underlays = null
	P.insidePhylactery=chosenPhylactery
	chosenPhylactery.Bolted = 1
	P.move=0 // Dont want them to move until the tank is 'done'
	if(P.KOd) P.Un_KO(1) // They need to be up.
	//P.overlays-=/Icon_Obj/Halo
	P.Dead=0
	P.dir=SOUTH
	P.Health = 100
	P.Ki = P.MaxKi
	sleep(chosenPhylactery.reviveTime)
	if(!P||!chosenPhylactery){return}
	chosenPhylactery.playerRevival = null // make sure that they dont get killed once the tank gets blown up and they're already out.
	chosenPhylactery.Bolted = 0
	P << "<span class=announce>The process is complete and the Phylactery falls out of an open cavity in your chest where your heart should of been. The wound quickly seals. You are whole again!</span>"
	P.insidePhylactery=null
	step(P,SOUTH)
	P.move=1
	//P.Heart_Virus_Cure()
	for(var/BodyPart/L in P) P.Injure_Hurt(100,L,"Phylactery")
	P << "<font color = red>You feel very weak from the process."
proc/Phylactery_Detection(var/mob/player/P)

	var/obj/items/Phylactery/chosenPhylactery = Has_Phylactery(P)

	if(chosenPhylactery)
		P.loc=chosenPhylactery.loc
		P.saveToLog("|  | ([P.x], [P.y], [P.z]) | [key_name(src)] has been revived by their [chosenPhylactery] Phylactery.\n")
	if(chosenPhylactery) Phylactery_Awaken(P,chosenPhylactery)
proc/checkNullPhylactery(var/mob/player/P)
	for(var/obj/items/Phylactery/phy in glob_Phylactery)
		if(ismob(phy.loc)) if(ismob(P))
			if(phy.Password=="[P.real_name] ([P.key])")
				var/mob/m = phy.loc
				m << "You are forced to drop the [phy]."
				phy.loc = m.loc
		else if(isobj(phy.loc))
			var/obj/o = phy.loc
			phy.loc = o.loc
		else if(phy.z == 0)
			glob_Phylactery-=phy
			del phy
proc/Has_Phylactery(var/mob/player/P)
	checkNullPhylactery(P)
	for(var/obj/items/Phylactery/phy in glob_Phylactery)
		if(phy.Password=="[P.real_name] ([P.key])"&&P.Dead)
			return phy
			break
obj/items/Phylactery
	icon = 'Magic Items.dmi'
	icon_state = "soul stone"
	name = "Phylactery"

	density = 1
	Health = 1000
	var/mob/player/playerRevival
	var/reviveTime=6000 // 10 minutes.
	desc="This will revive you each time you are killed. \
	This is the most efficient model of cloner, \
	taking the least amount of decline per death and requiring the least amount of time to activate your body.  \
	Each time you are cloned and the cloner is activated, you lose decline."

	verb/Use()
		set src in oview(1)
		if(usr.Phylactery)
			usr << "You already have a Phylactery which stores your soul."
			return
		if(src.Password)
			usr << "A soul has already been set for this Phylactery."
			return
		if(usr.Dead)
			usr<<"Dead people cannot use this"
			return
		usr<<""
		src.icon_state = "soul stone active"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has set [src] to clone themselves.\n")
		Password="[usr.real_name] ([usr.key])"
	New()
		..()
		if(!glob_Phylactery) glob_Phylactery=new // If the list hasn't been created yet, create a new one.
		//if(z!=0)
		glob_Phylactery+=src
	Del()

		if(glob_Phylactery)
			//src.Password=null
			glob_Phylactery-=src
			if(!glob_Phylactery|!glob_Phylactery.len) glob_Phylactery=null

		for(var/mob/M in Players)
			if(src.Password=="[M.real_name] ([M.key])")
				var/turf/T = src.loc
				T.Explosion(M)
				M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)]'s Phylactery was destroyed at [src.x],[src.y],[src.z].\n")
				alertAdmins(" | ([M.x], [M.y], [M.z]) | [key_name(M)] 's Phylactery was destroyed at [src.x],[src.y],[src.z].\n")
				M.Death(M)
		..()
