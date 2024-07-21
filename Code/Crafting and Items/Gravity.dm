
turf/var/Gravity=1
var
	EarthGrav=1
	NamekGrav=2 //z=2
	ArconiaGrav=5 //z=5
	VegetaGrav=10 //z=3
	DarkPlanetGrav=1 //z=6
	IceGrav=20 //z=4
	HellGrav=15 //z=19


mob/proc/Gravity()
	set waitfor=0
	if(src)
		Gravity=1
		var/turf/A=loc
		if(A&&isturf(A))
			if(A.Gravity<1) A.Gravity=1
			if(A.Gravity>PlanetGravity()) Gravity=A.Gravity
			else Gravity=PlanetGravity()

mob/proc/PlanetGravity()
	if(z==1&&Gravity<=EarthGrav) return EarthGrav
	else if(z==2&&Gravity<=NamekGrav) return NamekGrav
	else if(z==3&&Gravity<=VegetaGrav) return VegetaGrav
	else if(z==19&&Gravity<=HellGrav) return HellGrav
	else if(z==6&&Gravity<=DarkPlanetGrav) return DarkPlanetGrav
	else if(z==5&&Gravity<=ArconiaGrav) return ArconiaGrav
	else if(z==4&&Gravity<=IceGrav) return IceGrav
	else return 1

mob/proc/StartingGrav()
	if(!BeenGivenStartingGrav&&GravMastered<Gravity)
		GravMastered=Gravity
		BeenGivenStartingGrav=1

mob/proc/Gravity_Gain() if(!RPMode&&!afk)
	if(adminDensity) return
	var/DMG = 1.5*((((Gravity*2)/GravMastered)-2)**2)
	//DMG/=2
	//Health-=DMG
	//if(DMG/5 > 0.05) src.Injure_Hurt(DMG/5,"Random","Gravity")
	if(Gravity>GravMastered)
		if(Gravity>GravMastered*1.5) Increase_GainMultiplier(10)
		else Increase_GainMultiplier(5)
		if(attacking) GravMastered+=(0.095)*(Gravity/GravMastered)
		else if(icon_state=="Train") GravMastered+=(0.010)*(Gravity/GravMastered)       //Enable this to turn on gravity mastery gains when standing in gravity.
		else if(KOd==0)  GravMastered+=(0.030)*(Gravity/GravMastered)
		if(Gravity>PlanetGravity()) GravMastered+=(0.010)*(Gravity/GravMastered)
		TakeDamage("Gravity", DMG)
		if(Gravity>2*GravMastered)
			BPDamage("gravity",rand(1,DMG))
			view(src)<<"[src] is being crushed by the gravity!"
			src.Willpower -= rand(1,5) // make it guaranteed
			if(src.Willpower <=0) src.Death("crushed by gravity!",1)
	if(Gravity>25&&Health<=-200) if(Gravity>GravMastered*1.6) if(KOd) if(DMG > 15) if(prob(20)) src.Death("Gravity")
obj/items/Gravity
	Health=5000
	proc/GravityGen()
		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER-1)
		icon_state="on"
		for(var/turf/G in view(RangeSet,src))
			G.overlays.Remove(I,'Gravity Field.dmi',I)
			if(Grav_Setting>1&&Battery>=1) G.overlays+=I
		if(!IsOn&&Battery>=1&&Grav_Setting>1)
			IsOn=1
			while(Battery>0&&IsOn&&Grav_Setting>1)
				Battery--
				for(var/turf/G in view(RangeSet,src))
					G.Gravity=Grav_Setting
				for(var/obj/items/Regenerator/R in view(RangeSet,src))
					view(src)<<"You hear glass begin to crack..."
					sleep(1)
					del(R)
				if(prob(2)) view(src)<<"The Gravity Machine vibrates... ([round(Battery/MaxBattery*100)]% Battery)"
				if(Grav_Setting<=1) Deactivate()
				else if(Battery<=0)
					Battery=0
					Deactivate()
				else if(!IsOn) Deactivate()
				sleep(540)
	Move()
		Deactivate()
		..()
	Del()
		Deactivate()
		..()
	layer=MOB_LAYER+5

	density=1
	desc="Place this anywhere on the ground to use it, it will affect anything within its radius."
	var/Max=1
	var/Range=1
	var/RangeSet=1
	var/Battery=100
	var/MaxBattery=100
	var/tmp/IsOn=0
	var/tmp/Grav_Setting = 0
	icon='gravmach.dmi'

	proc/Deactivate()
		var/image/I=image(icon='Gravity Field.dmi',layer=MOB_LAYER-1)
		for(var/turf/G in range(RangeSet,src))
			G.overlays.Remove(I,'Gravity Field.dmi',I)
			G.Gravity=0
		Grav_Setting=0
		IsOn=0
		icon_state=""

	Click() if(usr in range(1,src))
		if(src.Grav_Setting>1)
			Deactivate()
			view(src)<<"[usr] sets the Gravity multiplier set to normal."
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets the gravity to normal. \n")
			return
		var/Grav=input("Gravity Multiplier: Machine Maximum output is [Max]x ([round(Battery/MaxBattery*100)]% Battery remaining)") as num
		if(Grav>Max) Grav=Max
//		if(Grav>GravLimit) Grav=GravLimit
		if(Grav<0) Grav=0
		if(!Grav) Grav=1
		view(src)<<"[usr] sets the Gravity multiplier set to [Grav]x"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] sets the gravity to [Grav]x \n")
		Grav_Setting = Grav
		GravityGen()
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."
			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1
			return

	verb/Set_Field_Size()if(Range>1)
		set src in view(1)
		Deactivate()
		var/FStrength=input("What would you like to set the field size to ([Range] Max)") as num
		if(FStrength<=1) FStrength=1
		if(FStrength>=Range) FStrength=Range
		RangeSet=FStrength
		range(20,src)<<"[usr] sets [src]'s field to range [RangeSet]."

	verb/Upgrade()
		set src in view(1)
		var/obj/Resources/A =locate(/obj/Resources) in usr
		var/list/Choices=new
		if(Max<1000) if(Max<(usr.Int_Level-50)*6) Choices.Add("Field Limit ([round((100000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
		if(Range<5) if(A.Value>=1000*Tech/usr.Int_Mod)if(usr.Int_Level>=50) Choices.Add("Field Range ([round((75000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))])")
		if(MaxBattery<1000) if(usr.Int_Mod>=2)if(usr.Int_Level>=20) Choices.Add("Max Battery ([round((3000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
		if(Battery<MaxBattery) Choices.Add("Refuel (5000 x Unit)")
		Choices.Add("Cancel")
		if(!Choices)
			usr<<"You have reached the limit of this machine or do not have enough resources."
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Cancel") return
		if(Choice=="Refuel (5000 x Unit)")
			var/MaxF=round(MaxBattery-Battery)
			var/AM=input(usr,"How many units? (0-[MaxF])","Refueling") as num
			if(AM<=0) return
			if(AM>MaxF) AM=MaxF
			AM=round(AM)
			var/Cost=AM*5000*(1-(0.15*usr.HasDeepPockets))
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost
			Battery+=AM
			if(Battery>MaxBattery)Battery=MaxBattery
			view(usr)<<"[usr] refuels the [src] to [Battery] Units."
			return
		if(Choice=="Field Limit ([round((100000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
			var/UPG=input("Increase the maximum field limit to what number? ([Max] - [(usr.Int_Level-50)*6])") as num
			UPG=round(UPG)
			if(UPG<=Max) return
			if(UPG>(usr.Int_Level-50)*6) UPG=(usr.Int_Level-50)*6
			var/Cost=round((100000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))*(UPG-Max)
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost //Upgrade
			cost+=Cost
			Max=UPG //Upgrade
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Limit level [Max].\n")
			view(usr)<<"[usr] upgrades the [src] to Field Limit level [Max]."
		if(Choice=="Field Range ([round((75000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))])")
			var/Cost=round((75000*(0.8*Range))/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost //Upgrade
			cost+=Cost
			Range++ //Upgrade
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Range [Range].\n")
			view(usr)<<"[usr] upgrades the [src] to Field Range [Range]."
		if(Choice=="Max Battery ([round((3000)/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]x)")
			var/UPG=input("Increase the battery to what number? ([MaxBattery] - 1000)") as num
			UPG=round(UPG)
			if(UPG<=MaxBattery) return
			if(UPG>1000) UPG=1000
			var/Cost=round((30000*(0.1*MaxBattery))/(usr.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))*(UPG-MaxBattery)
			if(A.Value<Cost){usr << "You do not have enough resources.";return}
			A.Value-=Cost //Upgrade
			cost+=Cost
			MaxBattery=UPG //Upgrade
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to Field Range [Range].\n")
			view(usr)<<"[usr] upgrades the [src] to [MaxBattery] Max Battery."
//		Tech++
		desc=null
		if(Max==1000) desc+="<br>Field Max: [Max] ([Max]x) <font color=red>MAXED</font>"
		else desc+="<br>Field Max: [Max] ([Max]x)"
		if(Range==5) desc+="<br>Field Range: [Range] <font color=red>MAXED</font>"
		else desc+="<br>Field Range: [Range]"
		if(MaxBattery==1000) desc+="<br>Maximum Battery: [MaxBattery] <font color=red>MAXED</font>"
		else desc+="<br>Maximum Battery: [MaxBattery]"
	verb/Info()
		set category=null
		set src in oview(1)
		usr<<"[desc]"

