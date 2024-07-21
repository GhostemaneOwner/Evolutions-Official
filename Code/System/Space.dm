
proc
	Bump_Planet(var/A,var/Q)
		if(istype(Q,/obj/Ships)||istype(Q,/mob)||istype(Q,/obj/AndroidShip))
			if(istype(A,/obj/Planets)) if(!istype(Q,/obj/Planets))
				if(istype(A,/obj/Planets/Earth))
					Q:loc=locate(rand(1,350),rand(1,350),1)
				if(istype(A,/obj/Planets/Namek))
					Q:loc=locate(rand(1,350),rand(1,350),2)
				if(istype(A,/obj/Planets/Vegeta))
					Q:loc=locate(rand(1,350),rand(1,350),3)
				if(istype(A,/obj/Planets/Ice))
					Q:loc=locate(rand(1,240),rand(1,240),4)
				if(istype(A,/obj/Planets/Desert))
					Q:loc=locate(116,109,14)
				if(istype(A,/obj/Planets/Jungle))
					Q:loc=locate(120,350,14)
				if(istype(A,/obj/Planets/Arconia))
					Q:loc=locate(rand(1,350),rand(1,350),5)
				if(istype(A,/obj/Planets/Alien))
					Q:loc=locate(380,414,14)
				if(istype(A,/obj/Planets/SpaceStation))
					Q:loc=locate(250,250,7)
				if(istype(A,/obj/Planets/Ocean))
					Q:loc=locate(370,80,14)
				if(istype(A,/obj/Planets/DarkPlanet))
					Q:loc=locate(rand(1,350),rand(1,350),6)
				if(istype(A,/obj/Planets/VegetaMoon))
					Q:loc=locate(425,100,15)
				if(istype(A,/obj/Planets/AlienMoon))
					Q:loc=locate(250,100,15)
				if(istype(A,/obj/Planets/ArconiaMoon))
					Q:loc=locate(250,375,15)
				if(istype(A,/obj/Planets/EarthMoon))
					Q:loc=locate(75,375,15)
				if(istype(A,/obj/Planets/IceMoon))
					Q:loc=locate(425,375,15)
				var/obj/QQ=Q
				SmallCrater(QQ)
			else //..()



obj/Bump(obj/A)
	if(istype(A,/obj/Planets))
		Bump_Planet(A,src)
mob/var/tmp/PilotLocation
obj/items/Spacesuit
	icon='Mask.dmi'
	name="Air Mask"
	density=0
	desc="You can survive in space if you equip this"

	Click() if(src in usr)
		if(!suffix)
			for(var/obj/items/Spacesuit/A in usr) if(A!=src&&A.suffix) return
			suffix="*Equipped*"
			usr.overlays+=icon
			usr<<"You put on the [src] and can breath through it."
			usr.BreathInSpace++
		else
			suffix=null
			usr.overlays-=icon
			usr<<"You take off the [src]."
			usr.BreathInSpace-=1
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "removes" : "equips"] the [src].\n")
mob/var/InShip
obj/Controls
	icon='PilotControls.dmi'
	density=1
	Savable=1
	Health=1.#INF
	Grabbable=0
	Shockwaveable=0
	var/LastLaunch=0
	var/Ship
	var/IsBroken=0
	proc/Ship_Interior_Reset() if(!istype(src,/obj/Controls/PodControls))
		for(var/turf/A in block(locate(src.x-1,src.y-15,src.z),locate(src.x+16,src.y+1,src.z)))
			for(var/mob/P in A)
				for(var/obj/Ships/S in world)
					if(S.Ship==src.Ship)
						P.loc=locate(S.x+1,S.y+1,S.z)
			for(var/obj/O in A)
				if(O!=src) if(O.type != /obj/Airlock)
					del(O)
			if(A.InitialType) new A.InitialType(A)
	New()
		global.worldObjectList+=src
		// for(var/obj/Controls/B in world)
		// 	for(var/obj/Controls/other in B.loc)
		// 		if(other != B)
		// 			del other
	MKIControls
		verb/Toggle_Stabilizers()
			set src in oview(1)
			for(var/obj/Ships/Ship/A) if(A.Ship==Ship)
				if(A.StabilizeInertia())
					usr << "Stabilizers are now engaged."
				else
					usr << "Stabilizers are now disengaged."
				return
		verb/View_Ship()
			set src in oview(1)
			for(var/obj/Ships/Ship/A) if(A.Ship==Ship)
				usr<<"Click the ship to stop observing"
				usr.reset_view(A)
				return
		verb/Pilot()
			set src in oview(1)
			if(IsBroken)
				usr<<"The controls are broken."
				return
			if(usr.Int_Mod<2&&!usr.HasPilotSkill)
				usr<<"You must have 2 or more Int Mod or have the Piloting MP."
				return
			for(var/obj/Ships/Ship/A) if(A.Ship==Ship)
				if(A.Pilot)
					usr<<"[A.Pilot] is already piloting the ship"
					return
				A.Pilot=usr
				usr.PilotLocation=usr.loc
				usr.reset_view(A)
				usr.S=A
				usr<<"Click the ship to stop piloting"
				view(usr)<<"[usr] is now piloting the ship"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is piloting the ship.\n")
				return
		verb/Launch()
			set src in oview(1)
			if(IsBroken)
				usr<<"The controls are broken."
				return
			if(LastLaunch>world.time)
				usr<<"You must wait [(LastLaunch-world.time)/600] more minutes to relaunch."
				return
			for(var/obj/Ships/Ship/A) if(A.Ship==Ship) if(A.z!=12&&!A.Launching)
				A.Launching=1
				LastLaunch=world.time+120000
				usr<<"Launching in [1800*A.Speed/64/10] seconds..."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
				spawn(1800*A.Speed/64) if(src&&A)
					A.Launching=0
					Liftoff(A)
		verb/Leave()
			set src in oview(1)
			var/Found = 0
			for(var/obj/Ships/Ship/A in world) if(A.Ship==Ship&&A)
				if(A.z)
					usr.loc=A.loc
					Found = 1
					if(A.Pilot==usr) A.Pilot=null
					if(usr.S==A) usr.S=null
					usr.reset_view()
					usr.InShip=null
					return
				else
					var/mob/M=A.loc
					usr.loc=M.loc
					Found = 1
					if(A.Pilot==usr) A.Pilot=null
					if(usr.S==A) usr.S=null
					usr.reset_view()
					usr.InShip=null
			if(Found == 0) usr.client.sendToSpawn(usr)

	MKIIControls
		verb/Toggle_Stabilizers()
			set src in oview(1)
			for(var/obj/Ships/ShipMKII/A) if(A.Ship==Ship)
				if(A.StabilizeInertia())
					usr << "Stabilizers are now engaged."
				else
					usr << "Stabilizers are now disengaged."
				return
		verb/View_Ship()
			set src in oview(1)
			for(var/obj/Ships/ShipMKII/A) if(A.Ship==Ship)
				usr<<"Click the ship to stop observing"
				usr.reset_view(A)
				return
		verb/Pilot()
			set src in oview(1)
			if(usr.Int_Mod<2&&!usr.HasPilotSkill)
				usr<<"You must have 2 or more Int Mod or have the Piloting MP."
				return
			for(var/obj/Ships/ShipMKII/A) if(A.Ship==Ship)
				if(A.Pilot)
					usr<<"[A.Pilot] is already piloting the ship"
					return
				A.Pilot=usr
				usr.PilotLocation=usr.loc
				usr.reset_view(A)
				usr.S=A
				usr<<"Click the ship to stop piloting"
				view(usr)<<"[usr] is now piloting the ship"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is piloting the ship.\n")
				return
		verb/Launch()
			set src in oview(1)
			if(LastLaunch>world.time)
				usr<<"You must wait [(LastLaunch-world.time)/600] more minutes to relaunch."
				return
			for(var/obj/Ships/ShipMKII/A) if(A.Ship==Ship) if(A.z!=12&&!A.Launching)
				A.Launching=1
				LastLaunch=world.time+60000
				usr<<"Launching in [1800*A.Speed/64/10] seconds..."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
				spawn(1800*A.Speed/64) if(src&&A)
					A.Launching=0
					Liftoff(A)
		verb/Leave()
			set src in oview(1)
			var/Found = 0
			for(var/obj/Ships/ShipMKII/A in world) if(A.Ship==Ship&&A)
				if(A.z)
					usr.loc=A.loc
					Found = 1
					if(A.Pilot==usr) A.Pilot=null
					if(usr.S==A) usr.S=null
					usr.reset_view()
					usr.InShip=null
					return
				else
					var/mob/M=A.loc
					usr.loc=M.loc
					Found = 1
					if(A.Pilot==usr) A.Pilot=null
					if(usr.S==A) usr.S=null
					usr.reset_view()
					usr.InShip=null
			if(Found == 0) usr.client.sendToSpawn(usr)
	MKIIIControls
		verb/Toggle_Stabilizers()
			set src in oview(1)
			for(var/obj/Ships/ShipMKIII/A) if(A.Ship==Ship)
				if(A.StabilizeInertia())
					usr << "Stabilizers are now engaged."
				else
					usr << "Stabilizers are now disengaged."
				return
		verb/View_Ship()
			set src in oview(1)
			for(var/obj/Ships/ShipMKIII/A) if(A.Ship==Ship)
				usr<<"Click the ship to stop observing"
				usr.reset_view(A)
				return
		verb/Pilot()
			set src in oview(1)
			if(usr.Int_Mod<2&&!usr.HasPilotSkill)
				usr<<"You must have 2 or more Int Mod or have the Piloting MP."
				return
			for(var/obj/Ships/ShipMKIII/A) if(A.Ship==Ship)
				if(A.Pilot)
					usr<<"[A.Pilot] is already piloting the ship"
					return
				A.Pilot=usr
				usr.PilotLocation=usr.loc
				usr.reset_view(A)
				usr.S=A
				usr<<"Click the ship to stop piloting"
				view(usr)<<"[usr] is now piloting the ship"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is piloting the ship.\n")
				return
		verb/Launch()
			set src in oview(1)
			if(LastLaunch>world.time)
				usr<<"You must wait [(LastLaunch-world.time)/600] more minutes to relaunch."
				return
			for(var/obj/Ships/ShipMKIII/A) if(A.Ship==Ship) if(A.z!=12&&!A.Launching)
				A.Launching=1
				LastLaunch=world.time+40000
				usr<<"Launching in [1800*A.Speed/64/10] seconds..."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
				spawn(1800*A.Speed/64) if(src&&A)
					A.Launching=0
					Liftoff(A)
		verb/Leave()
			set src in oview(1)
			var/Found = 0
			for(var/obj/Ships/ShipMKIII/A in world) if(A.Ship==Ship&&A)
				if(A.z)
					usr.loc=A.loc
					Found = 1
					if(A.Pilot==usr) A.Pilot=null
					if(usr.S==A) usr.S=null
					usr.reset_view()
					usr.InShip=null
					return
				else
					var/mob/M=A.loc
					usr.loc=M.loc
					Found = 1
					if(A.Pilot==usr) A.Pilot=null
					if(usr.S==A) usr.S=null
					usr.reset_view()
					usr.InShip=null
			if(Found == 0) usr.client.sendToSpawn(usr)

	PodControls
		//var/Launching
		//var/Ship
		Health=1.#INF
		Grabbable=0
		Savable=0
		Shockwaveable=0
		icon='Tech.dmi'
		icon_state="ShipConsole"
		verb/Use()
			set src in oview(1)
			for(var/obj/Ships/SpacepodMKIII/A in world)
				if(A.z) if(A.Ship==src.Ship)
					if(!A.Pilot)
						A.Pilot=usr
						usr.reset_view(A)
						usr.S=A
						usr<<"Reset view to stop piloting."
						view(usr)<<"[usr] is now piloting the pod"
					else
						usr<<"Someone else is driving!"
		verb/Leave()
			set src in oview(1)
			for(var/obj/Ships/SpacepodMKIII/Q in world)
				if(Q.z)
					if(Q.Ship==src.Ship)
						view(10,usr)<<"[usr] leaves the pod."
						usr.loc=Q.loc
						//Q.Peoples--
						return
			usr.client.sendToSpawn(usr)
		verb/View()
			set src in oview(1)
			for(var/obj/Ships/SpacepodMKIII/Q in world)
				if(Q.z) if(Q.Ship==src.Ship)
					usr.reset_view(Q)
		verb/Launch()
			set src in oview(1)
			if(usr.z==12)return
			if(LastLaunch>world.time)
				usr<<"You must wait [(LastLaunch-world.time)/600] more minutes to relaunch."
				return
			for(var/obj/Ships/SpacepodMKIII/A in world) if(A.Ship==Ship) if(A.z!=12&&!A.Launching)
				A.Launching=1
				LastLaunch=world.time+40000
				usr<<"Launching in [1800*A.Speed/64/10] seconds..."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
				spawn(1800*A.Speed/64) if(src&&A)
					A.Launching=0
					Liftoff(A)

obj/Airlock
	icon='Lab.dmi'
	icon_state="doorshut"
	density=1
	Savable=1
	Health=1.#INF
//	Spawn_Timer=3000
	Grabbable=0
	Shockwaveable=0
	var/Ship=0
	verb/Leave()
		set src in oview(1)
		var/Found = 0
		for(var/obj/Ships/A in world) if(A.Ship==Ship&&A)
			if(A.z)
				usr.loc=A.loc
				Found = 1
				if(A.Pilot==usr) A.Pilot=null
				if(usr.S==A) usr.S=null
				usr.reset_view()
				usr.InShip=null
				return
			else
				var/mob/M=A.loc
				usr.loc=M.loc
				Found = 1
				if(A.Pilot==usr) A.Pilot=null
				if(usr.S==A) usr.S=null
				usr.reset_view()
				usr.InShip=null
		if(Found == 0) usr.client.sendToSpawn(usr)
obj/AndroidAirlock
	icon='Lab.dmi'
	icon_state="doorshut"
	density=1
	Savable=1
	Health=1.#INF
//	Spawn_Timer=3000
	Grabbable=0
	Shockwaveable=0
	var/Ship=0
	verb/Leave()
		set src in oview(1)
		var/Found = 0
		for(var/obj/AndroidShip/A)  if(A.Ship==Ship&&A)
			usr.loc=A.loc
			Found = 1
			if(A.Pilot==usr) A.Pilot=null
			if(usr.S==A) usr.S=null
			usr.reset_view()
			//usr.Heart_Virus()
			return
		if(Found == 0)
			usr.client.sendToSpawn(usr)
			//usr.Heart_Virus()
	proc/Ship_Interior_Reset()
		for(var/turf/A in block(locate(src.x-1,src.y-15,src.z),locate(src.x+16,src.y+1,src.z)))
			for(var/mob/P in A) for(var/obj/Ships/S in world) if(S.Ship==Ship) P.loc=locate(S.x+1,S.y+1,S.z)
			for(var/obj/O in A) if(O!=src) if(O.type != /obj/Airlock) del(O)
			if(A.InitialType) new A.InitialType(A)
		usr.z=0
		usr.Location()
//Only thing left is to finish the cloaking system
obj/AndroidControls
	icon='control_new.dmi'
	density=1
	Savable=1
	Health=1.#INF
//	Spawn_Timer=3000
	Grabbable=0
	Shockwaveable=0
	pixel_x = -88
	pixel_y = -60
	var/Ship=0
	proc/Ship_Interior_Reset()
		for(var/turf/A in block(locate(src.x-1,src.y-15,src.z),locate(src.x+16,src.y+1,src.z)))
			for(var/mob/P in A)
				for(var/obj/Ships/S in world)
					if(S.Ship==src.Ship)
						P.loc=locate(S.x+1,S.y+1,S.z)
			for(var/obj/O in A)
				if(O!=src) if(O.type != /obj/Airlock)
					del(O)
			if(A.InitialType)
				new A.InitialType(A)
	verb/Toggle_Stabilizers()
		set src in oview(1)
		for(var/obj/AndroidShip/A) if(A.Ship==Ship)
			if(A.StabilizeInertia())
				usr << "Stabilizers are now engaged."
			else
				usr << "Stabilizers are now disengaged."
			return
	verb/View_Ship()
		set src in oview(1)
		for(var/obj/AndroidShip/A) if(A.Ship==Ship)
			usr<<"Click the ship to stop observing"
			usr.reset_view(A)
			return
	verb/Pilot()
		set src in oview(1)
		if(!usr.CanPilotAS)
			usr <<"You are not authorized to operate the ship!"
			return
		if(Year<1) usr<<"The ship is still recharging its engines. Try again later. (Year 1+)"
		for(var/obj/AndroidShip/A) if(A.Ship==Ship)
			if(A.Pilot)
				usr<<"[A.Pilot] is already piloting the ship"
				return
			A.Pilot=usr
			usr.PilotLocation=usr.loc
			usr.reset_view(A)
			usr.S=A
			usr<<"Click the ship to stop piloting"
			view(usr)<<"[usr] is now piloting the ship"
			A.Tech=2
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is piloting the ship.\n")
			return
	verb/Launch()
		set src in oview(1)
		if(!usr.CanPilotAS)
			usr << "You are not authorized to operate the ship!"
			return
		for(var/obj/AndroidShip/A) if(A.Ship==Ship) if(A.z!=12&&!A.Launching)
			A.Launching=1
			usr<<"Launching in 3 minutes..."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has initiated the launch for their ship.\n")
			spawn(1800) if(src&&A)
				A.Launching=0
				Liftoff(A)

obj/items/Rocket_Booster
	pixel_x=-10
	desc="You can use this one time use item to launch into space!"
	icon='Rocket_Booster.dmi'
	verb/Launch()
		set src in usr.contents
		if(!(locate(usr.client.mob) in range(1,src))) return
		//if(usr.z==12) return
		var/list/al = list(8,9,10,11,12,13,16,17)
		if(usr.z in al)
			usr<<"Can't use this here."
			return
		var/turf/T=usr.loc
		if(T.Inside){usr<<"Launch failed. You are inside a building."; return}
		usr<<"Launching in 1 minute..."
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is launching [src].\n")
		spawn(600) if(src)
			Liftoff(usr)
			del(src)


obj/Ships
	density=1
	Savable=1
	layer=MOB_LAYER+1
	var/tmp/mob/Pilot
	var/tmp/Launching
	Health=1.#INF
	var/Fuel=100
	var/Armor=10
	var/Speed=64
	var/Efficiency=1
	var/Refire=64
	var/Cloak=0
	var/Nav
	var/list/Planets=new
	var/tmp/Moving
	var/Small
	var/Ship
	var/gotRE
	var/CapsuleTech=0
	Move()
		var/Former_Location=loc
		..()
		Door_Check(Former_Location)
	proc/Door_Check(turf/Former_Location) for(var/obj/Door/A in loc) if(A.density)
		loc=Former_Location
		if(Pilot) Pilot.Bump(A)
		break
	proc/Fuel()
		Fuel-=1/Efficiency
		if(Fuel<0)
			usr<<"Your ship is out of fuel"
			Fuel=0
	proc/StabilizeInertia()
		anchored = !(anchored)
		return anchored
	verb/Upgrade()
		set src in view(1)
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/CostA=25000000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(usr.Int_Level>80&&!CapsuleTech) if(usr.Confirm("Add capsule tech for [CostA]?"))
			if(CostA>A.Value)
				usr<<"You do not have enough resources to add capsule tech."
				return
			A.Value-=CostA
			src.cost += CostA
			CapsuleTech=1
			Grabbable=1
			if(!Password) Password=input("You must put a password to enable capsule tech. Choose that password.")
			usr<<"Capsule Tech added! You may now add this item to your inventory! (Password: [Password])"
			return
		var/list/Choices=new
		if(A.Value>=100000*Tech/usr.Int_Mod&&Speed>1) Choices.Add("Speed ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
		if(A.Value>=100000*Tech/usr.Int_Mod) Choices.Add("Fuel Efficiency ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
		if(A.Value>=100000*Tech/usr.Int_Mod) Choices.Add("Armor + Repair ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
		//if(A.Value>=100000*Tech/usr.Int_Mod&&Refire>1) Choices.Add("Laser Defense ([100000*Tech/usr.Int_Mod])")
		if(A.Value>=100000*Tech/usr.Int_Mod&&!Nav) Choices.Add("Navigation Computer ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
		if(Fuel<100) Choices.Add("Refuel (Up to 5000)")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice!="Refuel (Up to 5000)") if(usr.Int_Level<Tech)
			usr<<"This ship is far beyond your technical capabilities!"
			return
		if(Choice=="Refuel (Up to 5000)")
			var/Cost=round((100-Fuel)*50*(1-(0.15*usr.HasDeepPockets)))
			if(A.Value<Cost) return
			usr<<"Refueling cost you [Cost]"
			Fuel=100
			A.Value-=Cost
			return
		if(Choice=="Speed ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
			if(A.Value<50000*Tech/usr.Int_Mod) return
			A.Value-=50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			src.cost += 50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			Speed*=0.5
			Tech++
		if(Choice=="Fuel Efficiency ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
			if(A.Value<50000*Tech/usr.Int_Mod) return
			A.Value-=50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			src.cost += 50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			Efficiency*=2
			Tech++
		if(Choice=="Armor + Repair ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
			if(A.Value<50000*Tech/usr.Int_Mod) return
			A.Value-=50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			src.cost += 50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			Armor*=5
			Health=100000*Armor
		if(Choice=="Navigation Computer ([100000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))])")
			if(A.Value<50000*Tech/usr.Int_Mod) return
			A.Value-=50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			src.cost += 50000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			Nav=1
		Tech++
		desc=null
		desc+="<br>Speed: [64/Speed]"
		desc+="<br>Fuel Efficiency: [Efficiency] ([round(Fuel)]% Fuel)"
		desc+="<br>Armor: [Armor] ([round((Health/(5000*Armor))*100)]% Remaining)"
		//if(HasLasers) desc+="<br>Laser Defense: [64/Refire]"
		if(Cloak) desc+="<br>Cloak: [Cloak]"
		if(Nav)
			desc+="<br>Nav Computer Installed"
			for(var/P in Planets) desc+="<br>*[P]"
	verb/Set_Password()
		set src in oview(1)
		if(!Password)
			Password=input("Enter a password to keep this spacepod from being stolen from you.") as text
			usr<<"Password set!"
		else
			usr<<"You are not the owner of this pod.  Have control transferred to you to set the password."
			return
	proc/MoveReset() spawn(Speed) Moving=0
	verb
		Harness_Radiant_Energy()
			set src in range(1,usr)
			if(usr.Int_Mod < 3&&usr.Race!="Heran")
				usr<<"You do not understand this technology enough to fully utilize it here."
				return
			if(Small)
				usr<<"You may not use this to gather energy, it must be a full ship."
				return
			if(gotRE==Year)
				usr<<"You have already gathered Radiant Energy this year."
				return
			if(usr.GotRE==Year)
				usr<<"You have already gathered Radiant Energy this year."
				return
			if(RadiantEnergy==src.z)
				view(usr) <<"[usr] begins to gather Radiant Energy using [src]!"
				gotRE=Year
				//usr.GotRE=Year
				sleep(36000)//1 hr
				if(src)
					gotRE=Year
					//usr.GotRE=Year
					view(src)<<"[src] has finished gathering Radiant Energy."
					new/obj/Resources/Radiant_Treasure(src.loc)
	Del()
		if(Pilot)
			Pilot.loc=locate(src.x+1,src.y+1,src.z)
			Pilot.dir=SOUTH
			Pilot.reset_view()
			Pilot=null
		if(!istype(src,/obj/Ships/SpacepodMKIII))if(!istype(src,/obj/Ships/Spacepod))
			for(var/obj/Controls/A in world)
				if(A.Ship==src.Ship)
					A.Ship_Interior_Reset()
		for(var/turf/A in view(2,src))ExplosionEffect(A)
		Crater(src)
		..()
	Bump(mob/A)
		if(istype(A,/obj/Planets)) Bump_Planet(A,src)
		if(Pilot&&istype(A,/obj/Door)) Pilot.Bump(A)
	Ship
		icon='Huge Ship Red Dark.dmi'
		icon_state="1 1"
		pixel_x=-42
		pixel_y=-48
		layer=MOB_LAYER
		Health=1.#INF
		Speed=64
		Armor = 500
		Efficiency=1
		Grabbable=0
		New()
			if(!Ship)
				var/FoundShip = 1
				for(var/obj/Controls/MKIControls/B in world)
					if(B.Ship) FoundShip++
					else
						src.Ship=FoundShip
						B.Ship=FoundShip
						break
				if(!Ship)
					view(src)<<"An available interior could not be found. Ahelp."
					Ship="Missing Interior"

		Click()
			if(Pilot==usr)
				Pilot=null
				usr.S=null
			if(usr.client.eye==src) usr.reset_view()
		verb/Enter_Ship()
			set category=null
			set src in view(2)
			if(!z) return
			if(Password)
				var/PA=input(usr,"What is this ship's password?") as text
				if(PA!=Password)
					usr<<"Wrong!"
					return
			if(Ship=="Ardent"||Ship=="Icebreaker")
				for(var/obj/Airlock/C in world) if(C.Ship==src.Ship)
					view(usr)<<"[usr] enters the ship"
					usr.loc=locate(C.x,C.y-1,C.z)
					usr.InShip=Ship
			else for(var/obj/Controls/MKIControls/C in world) if(C.Ship==src.Ship)
				view(usr)<<"[usr] enters the ship"
				usr.loc=locate(C.x,C.y-1,C.z)
				usr.InShip=Ship
		Ardent
			Health=1.#INF
			Speed=1
			Efficiency=1
			Grabbable=0
			icon='AndroidShip.dmi'
			pixel_y=-32
			pixel_x=-32
			Fuel=50000
			Armor=100
			Nav=1
			Ship="Ardent"
		Icebreaker
			Health=1.#INF
			Speed=1
			Efficiency=1
			Grabbable=0
			icon='AndroidShip.dmi'
			pixel_y=-32
			pixel_x=-32
			Fuel=50000
			Armor=100
			Nav=1
			Ship="Icebreaker"
			New()
				icon+=rgb(50,0,0)
				icon-=rgb(0,80,80)
				..()
	ShipMKII
		icon = 'mothership.dmi'
		Health=1.#INF
		Speed=1
		Efficiency=1
		Grabbable=0
		Armor = 1000
		pixel_x = -115
		pixel_y = -128
		Nav=1
		New()
			if(!Ship)
				var/FoundShip = 1
				for(var/obj/Controls/MKIIControls/B in world)
					if(B.Ship) FoundShip++
					else
						src.Ship=FoundShip
						B.Ship=FoundShip
						break
				if(!Ship) view(src)<<"An available interior could not be found. Ahelp or recycle me."

		Click()
			if(Pilot==usr)
				Pilot=null
				usr.S=null
			if(usr.client.eye==src) usr.reset_view()
		verb/Enter_Ship()
			set category=null
			set src in view(2)
			if(!z) return
			if(Password)
				var/PA=input(usr,"What is this ship's password?") as text
				if(PA!=Password)
					usr<<"Wrong!"
					return
			for(var/obj/Controls/MKIIControls/C in world) if(C.Ship==src.Ship)
				view(usr)<<"[usr] enters the ship"
				usr.loc=locate(C.x,C.y-1,C.z)

	ShipMKIII
		icon = 'mothership.dmi'
		Health=1.#INF
		Speed=1
		Efficiency=1
		Grabbable=0
		Armor = 5000
		pixel_x = -115
		pixel_y = -128
		Nav=1
		New()
			if(!Ship)
				var/FoundShip = 1
				for(var/obj/Controls/MKIIIControls/B in world)
					if(B.Ship) FoundShip++
					else
						src.Ship=FoundShip
						B.Ship=FoundShip
						break
				if(!Ship) view(src)<<"An available interior could not be found. Ahelp or recycle me."

		Click()
			if(Pilot==usr)
				Pilot=null
				usr.S=null
			if(usr.client.eye==src) usr.reset_view()
		verb/Enter_Ship()
			set category=null
			set src in view(2)
			if(!z) return
			if(Password)
				var/PA=input(usr,"What is this ship's password?") as text
				if(PA!=Password)
					usr<<"Wrong!"
					return
			for(var/obj/Controls/MKIIIControls/C in world) if(C.Ship==src.Ship)
				view(usr)<<"[usr] enters the ship"
				usr.loc=locate(C.x,C.y-1,C.z)


	Spacepod
		icon='Spacepod.dmi'
		desc="This is a basic space vessel. It will allow you to launch into space, navigate to planets and then land. (Works for 1 person)"
		Small=1
		Health=5000
		Speed=64
		Efficiency=3
		Grabbable=1
		var/LastLaunch=0
		verb/Use()
			set src in world
			if(Pilot)
				if(Pilot!=usr)
					usr<<"The pod is already in use by [Pilot]"
					return
				else
					usr.isGrabbing = null
					usr.loc=loc
					usr.dir=SOUTH
					usr.reset_view()
					usr.S=null
					Pilot=null
					return
			else if(((locate(usr.client.mob) in range(1,src))&&usr.z==z))
				if(usr.client.eye!=usr&&usr.client.eye!=src) return
				var/pass=input("What is this pod's password?")
				if(pass!=Password)
					usr<<"Incorrect password.  Disengaging user interface."
					return
				if(pass==Password)
					if(!Pilot)
						usr.isGrabbing = null
						Pilot=usr
						usr.reset_view(src)
						usr.S=src
						usr.loc=src.contents//locate(0,0,0)
		verb/Launch()
			set src in world
			if(!(locate(usr.client.mob) in range(1,src))&&Pilot!=usr) return
			if(z==12) return
			if(LastLaunch>world.time)
				usr<<"You must wait [(LastLaunch-world.time)/600] more minutes to relaunch."
				return
			if(Pilot!=usr)
				usr<<"You are not the pilot"
				return
			else if(!Launching)
				icon_state="Launching"
				Launching=1
				LastLaunch=world.time+60000
				usr<<"Launching in 1 minute..."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is launching [src].\n")
				spawn(600) if(src)
					icon_state=""
					Launching=0
					Liftoff(src)
		/*verb/Set_Password()
			set src in oview(1)
			if(!Password)
				Password=input("Enter a password to keep this spacepod from being stolen from you.") as text
				usr<<"Password set!"
			else
				usr<<"You are not the owner of this pod.  Have control transferred to you to set the password."
				return*/
/*	SpacepodMKII
		icon='NewSpacePod.dmi'
		icon_state = "idle"
		Small=1
		Health=50000
		Speed=1
		Nav = 1
		Efficiency=30
		Armor = 500
		//HasLasers = 1
		pixel_x = -32
		pixel_y = -32
		Grabbable=1
		var/LastLaunch=0
		verb/Use()
			set src in world
			if(Pilot)
				if(Pilot!=usr)
					usr<<"The pod is already in use by [Pilot]"
					return
				else
					usr.isGrabbing = null
					usr.loc=loc
					usr.dir=SOUTH
					usr.reset_view()
					usr.S=null
					Pilot=null
					return
			else if(((locate(usr.client.mob) in range(1,src))&&usr.z==z))
				if(usr.client.eye!=usr&&usr.client.eye!=src) return
				var/pass=input("What is this pod's password?")
				if(pass!=Password)
					usr<<"Incorrect password.  Disengaging user interface."
					return
				if(pass==Password)
					if(!Pilot)
						usr.isGrabbing = null
						src.icon_state = ""
						Pilot=usr
						usr.loc=src.contents//locate(0,0,0)
						usr.reset_view(src)
						usr.S=src
		verb/Launch()
			set src in world
			if(LastLaunch+0.1>Year)
				usr<<"You may not launch again until year [LastLaunch+0.1]."
				return
			if(!(locate(usr.client.mob) in range(1,src))&&Pilot!=usr) return
			if(z==12) return
			if(Pilot!=usr)
				usr<<"You are not the pilot"
				return
			else if(!Launching)
				icon_state="Launching"
				Launching=1
				LastLaunch=Year
				usr<<"Launching in 30 seconds..."
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] is launching [src].\n")
				spawn(300) if(src) if(src.icon_state == "Launching")
					icon_state=""
					Launching=0
					Liftoff(src)
		verb/Set_Password()
			set src in oview(1)
			if(!Password)
				Password=input("Enter a password to keep this spacepod from being stolen from you.") as text
				usr<<"Password set!"
			else
				usr<<"You are not the owner of this pod.  Have control transferred to you to set the password."
				return
/*		verb/Claim_Pod()
			set src in oview(1)
			var/Claim_Pod=input("What is this spacepod's password?")
			if (Claim_Pod!=password)
				usr<<"Incorrect password."
				return
			if (Claim_Pod==password)
			//	password=" "
				usr<<"You have claimed this pod!"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has claimed [src].\n")
*/
*/
	SpacepodMKIII
		desc="This is a slightl advanced space vessel. It will allow you to launch into space, navigate to planets and then land. This is 3x3 and can carry multiple people."
		icon='Spacepod.dmi'
		icon_state = "idle"
		//icon='Tech.dmi'
		//icon_state="PodRegular"
		Small=1
		Health=250000
		Speed=1
		Nav = 1
		Efficiency=30
		Armor = 2500
		//HasLasers = 1
		//pixel_x = -32
		//pixel_y = -32
		Grabbable=0
		Health=25000
		Speed=64
		Efficiency=1
		Grabbable=0
		Level=40
		Fuel=100
		density=1
		Click()
			if(Pilot==usr)
				Pilot=null
				usr.S=null
			if(usr.client.eye==src) usr.reset_view()
		//Password=" "
		verb/EnterPod()
			set src in view(1)
			if(!z) return
			if(usr.GrabbedMob==src)
				usr<<"You can't enter a pod while grabbing it! That would be silly!"
				return
			if(Password)
				var/PA=input(usr,"What is this pod's password?") as text
				if(PA!=Password)
					usr<<"Wrong!"
					return
			for(var/obj/Controls/PodControls/Q in world)
				if(Q.Ship==src.Ship)
					usr.loc=locate(Q.x,Q.y-1,Q.z)
					return
		/*verb/Set_Password()
			set src in oview(1)
			if(!Password)
				Password=input("Enter a password to keep this spacepod from being stolen from you.") as text
				usr<<"Password set!"
			else
				usr<<"You are not the owner of this pod.  Have control transferred to you to set the password."
				return*/
		New()
			if(!Ship)
				var/FoundShip = 1
				for(var/obj/Controls/PodControls/B in world)
					if(B.Ship) FoundShip++
					else
						src.Ship=FoundShip
						B.Ship=FoundShip
						break
				if(!Ship) view(src)<<"An available interior could not be found. Ahelp or recycle me."

obj/AndroidShip
	icon='Android Ship.dmi'
	density=1
	Savable=1
	Grabbable=0
	layer=MOB_LAYER+1
	var/tmp/mob/Pilot
	var/tmp/Launching
	Health=1.#INF
	var/Fuel=1.#INF
	var/Armor=1.#INF
	var/Speed=2
	var/Efficiency=1
	var/Refire=64
	var/Cloak=0
	var/Nav=1
	var/list/Planets=new
	var/HasLasers
	var/tmp/Moving
	var/Small
	var/Ship = 50
	var/tmp/Firing
	Click()
		if(usr.client.eye==src) usr.reset_view()
		if(Pilot==usr)
			Pilot=null
			usr.S=null
	Move()
		var/Former_Location=loc
		..()
		Door_Check(Former_Location)
	proc/Door_Check(turf/Former_Location) for(var/obj/Door/A in loc) if(A.density)
		loc=Former_Location
		if(Pilot) Pilot.Bump(A)
		break
	proc/Fuel()
		return
		/*Fuel-=1/Efficiency
		if(Fuel<0)
			usr<<"Your ship is out of fuel"
			Fuel=0*/
	proc/Lasers()
		if(!HasLasers||Firing) return
		Firing=1
		spawn(Refire) Firing=0
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.pixel_x=rand(-16,16)
		A.pixel_y=rand(-16,16)
		A.icon='13.dmi'
		A.icon+=rgb(200,0,0)
		A.Damage=2000*1000 //2000 bp, 1000 force
		A.Power=2000
		A.Offense=500
		A.Shockwave=1
		A.Explosive=1
		A.dir=dir
		A.loc=loc
		walk(A,A.dir)
	proc/StabilizeInertia()
		//Heh we toggle in this shit
		anchored = !(anchored)
		return anchored
	proc/MoveReset() spawn(Speed) Moving=0
	New() //spawn if(src) Ship_Loop()
	proc/Ship_Loop() /*while(src)
		if(HasLasers) for(var/OBJ_AI/SpaceDebris/A in view(src))
			missile('Laser.dmi',src,A)
			A.TakeDamage(usr, 5000, "Lasers")
			//A.Health-=5000
			if(A.Health<=0) spawn(3) if(A) del(A)
		sleep(Refire)*/
	Del()
		if(Pilot)
			Pilot.loc=loc
			Pilot.dir=SOUTH
			Pilot.reset_view()
			Pilot=null
		for(var/obj/Controls/A)
			if(A.Ship==src.Ship)
				A.Ship_Interior_Reset()
		for(var/turf/A in view(2,src))ExplosionEffect(A)
		Crater(src)
		..()
	Bump(obj/A)
		if(Small&&istype(A,/obj/AndroidShip))
			var/obj/AndroidShip/B=A
			for(var/obj/AndroidAirlock/C in world) if(C.Ship==B.Ship)
				view(src)<<"[src] enters the ship"
				loc=locate(C.x,C.y-1,C.z)
		if(istype(A,/obj/Planets)) Bump_Planet(A,src)
		if(Pilot&&istype(A,/obj/Door)) Pilot.Bump(A)
	verb/Enter_Ship()
		set category=null
		set src in view(2)
		for(var/obj/Airlock/C in world) if(C.Ship==src.Ship)
			view(usr)<<"[usr] enters the ship"
			usr.loc=locate(C.x,C.y-1,C.z)



proc/Liftoff(obj/Ships/O)
	var/turf/T=O.loc
	if(T.Inside){O.Pilot<<"Launch failed. You are inside a building."; return}
	var/ll=0
	if(istype(O,/mob))
		var/mob/M=O
		if(!M.Check_Dead_Location()) return
	var/obj/Planets/A = (O.z==1 ? locate(/obj/Planets/Earth) : O.z==3 ? locate(/obj/Planets/Vegeta) : \
	O.z==2 ? locate(/obj/Planets/Namek) : O.z==5 ? locate(/obj/Planets/Arconia) : O.z==6 ? locate(/obj/Planets/DarkPlanet) : \
	O.z==4 ? locate(/obj/Planets/Ice) : O.z==7 ? locate(/obj/Planets/SpaceStation) : O.z==14&&O.x<=241&&O.y<=241 ? locate(/obj/Planets/Desert) : \
	O.z==14&&O.x<=239&&O.y>=251 ? locate(/obj/Planets/Jungle) : O.z==14&&O.x>=251&&O.y>=240 ? locate(/obj/Planets/Alien) : O.z==14&&O.x>=250&&O.y<=240 ? locate(/obj/Planets/Ocean) : O.z==15? "Moon": null)
	if(O.z==14) O.loc=(locate(O.x,O.y,12))
	if(!A){O.Pilot<<"Launch failed. This is not a planet's surface."; return}
	if(A&&A!="Moon")
		O.loc=(locate(A.x,A.y-2,A.z))
		ll=1
	if(!ll) O.loc=(locate(O.x,O.y,12))
obj/Planets
	Bump(atom/A)
		Bump_Planet(src,A)
		..()
	icon='DSPlanets.dmi'
	density=1
	pixel_x=-54
	pixel_y=-44
	var/Planet_X=100
	var/Planet_Y=100
	var/Planet_Z
	//var/Ship
	Savable=1
	Grabbable=0
	Health=1.#INF
	Earth
		icon_state="Earth"
		Planet_Z=1
		New()

			if(!Earth) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,50)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Namek
		icon_state="Namek"
		Planet_Z=2
		New()

			if(!Namek) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Vegeta
		icon_state="Vegeta"
		Planet_Z=3
		New()

			if(!Vegeta) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Alien
		icon_state="LavaPlanet"
		Planet_Z=14
		Planet_X=364
		Planet_Y=84
		New()

			if(!Alien) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Arconia
		icon='New Planets.dmi'
		icon_state="Arconia"
		pixel_x=-32
		pixel_y=-32
		Planet_Z=5
		New()

			if(!Arconia) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Ice
		icon_state="Icer"
		Planet_Z=4
		New()

			if(!Ice) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Desert
		icon_state="DesertPlanet"
		Planet_X=116
		Planet_Y=109
		Planet_Z=14
		New()

			if(!Desert) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Jungle
		icon='New Planets.dmi'
		icon_state="Jungle"
		pixel_x=-32
		pixel_y=-32
		Planet_X=120
		Planet_Y=350
		Planet_Z=14
		New()

			if(!Jungle) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	Ocean
		icon='New Planets.dmi'
		icon_state="Ocean"
		pixel_x=-32
		pixel_y=-32
		Planet_X=370
		Planet_Y=80
		Planet_Z=14
		New()

			if(!Ocean) del(src)
			global.worldObjectList+=src
			//else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	SpaceStation
		icon='Asteroid 2.dmi'
		icon_state="Asteroid"
		pixel_x=-32
		pixel_y=-32
		Planet_X=250
		Planet_Y=250
		Planet_Z=7
		New()
			if(!SpaceStation) del(src)
			global.worldObjectList+=src
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	DarkPlanet
		icon='New Planets.dmi'
		icon_state="Dark Planet"
		pixel_x=-32
		pixel_y=-32
		Planet_Z=6
		New()
			if(!DarkPlanet) del(src)
			global.worldObjectList+=src
		//	else walk_rand(src,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	EarthMoon
		icon_state="VampaWhite"
		Planet_X=75
		Planet_Y=375
		Planet_Z=15
		New()
			if(!EarthMoon) del(src)
			global.worldObjectList+=src
		//	for(var/obj/Planets/Earth/E) walk_towards(src,E,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	VegetaMoon
		icon_state="VampaRed"
		Planet_X=425
		Planet_Y=100
		Planet_Z=15
		New()
			if(!VegetaMoon) del(src)
			global.worldObjectList+=src
		//	for(var/obj/Planets/Vegeta/E) walk_towards(src,E,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	AlienMoon
		icon_state="Vampa"
		Planet_X=250
		Planet_Y=100
		Planet_Z=15
		New()
			if(!AlienMoon) del(src)
			global.worldObjectList+=src
		//	for(var/obj/Planets/DarkPlanet/E) walk_towards(src,E,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	ArconiaMoon
		icon_state="VampaPurple"
		Planet_X=250
		Planet_Y=375
		Planet_Z=15
		New()
			if(!ArconiaMoon) del(src)
			global.worldObjectList+=src
		//	for(var/obj/Planets/Arconia/E) walk_towards(src,E,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
	IceMoon
		icon_state="VampaBlue"
		Planet_X=425
		Planet_Y=375
		Planet_Z=15
		New()
			if(!IceMoon) del(src)
			global.worldObjectList+=src
		//	for(var/obj/Planets/Ice/E) walk_towards(src,E,100)
			for(var/obj/A) if(A.type==type) if(A!=src) del(A)
			