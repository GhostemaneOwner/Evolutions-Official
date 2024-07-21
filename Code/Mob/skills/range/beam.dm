Skill/Attacks/Beams/Beam
	Wave=1
	icon='Beam3.dmi'
	Tier=1
	KiReq=1.1
	WaveMult=0.9
	ChargeRate=1
	MaxDistance=20 //Move delay x40
	MoveDelay=3
	Piercer=0
	luminosity=2
	Shockwave=1
	var/Master=0
	New()
		BeamDescription()
		..()	//Beams are bright...
	verb/Beam()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging||A.streaming) return
		if(Master==1) usr.Beam_Macro(src,1)
		else usr.Beam_Macro(src)
	verb/Ki_Settings()
		set category="Other"
		if(usr.HasBeamExpert) if(usr.Confirm("Toggle Beam Expert? Causes beams to be 3 tiles but deal 75% damage. (Currently [Master])"))
			Master=!Master
			usr<<"Beam Expert: [Master]"
		var/BM=input("Would you like [src] to fire immediately or to charge?") in list("Immediate","Charge")
		if(BM=="Immediate") BeamMode=0
		else BeamMode=1
		switch(input("Do you want your [src] to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

/*	verb/StruggleTest()
		set category="Testing"
		usr.BeamStruggleTest(src)*/



Skill/Attacks/proc/BeamDescription() desc="[src] drains [KiReq]x energy to use. Does [WaveMult]x \
damage. Charges higher every [ChargeRate] second(s). Has a range of [round(MaxDistance/MoveDelay)]. \
And moves at [round(100/MoveDelay)] kilometers an hour."



Skill/Buff/proc/GetDescription()
	var/returnDesc="[src] |"
	if(BP!=1)returnDesc+="[BP]x BP |"
	if(istype(src,/Skill/Buff/Bound_Weapon))
		returnDesc+="+[20+((WeaponLevel-1)*10)]% Weapon BP |"
		if(CritCan)returnDesc+="+[CritCan*10]% Crit Chance |"
	if(Str!=1)returnDesc+="[Str]x Strength |"
	if(End!=1)returnDesc+="[End]x Endurance |"
	if(Spd!=1)returnDesc+="[Spd]x Speed |"
	if(Pow!=1)returnDesc+="[Pow]x Force |"
	if(Off!=1)returnDesc+="[Off]x Offense |"
	if(Def!=1)returnDesc+="[Def]x Defense |"
	if(Regen!=1)returnDesc+="[Regen]x Regeneration |"
	if(Recov!=1)returnDesc+="[Recov]x Recovery |"
	if(Anger!=1)returnDesc+="[Anger]x Anger |"
	if(KiNeeded)returnDesc+="[KiNeeded*100]% Ki Required |"
	if(energydrain)returnDesc+="[energydrain]% Energy Drain |"
	if(healthdrain)returnDesc+="[healthdrain]x Health Drain |"
	if(istype(src,/Skill/Buff/Bound_Weapon))
		returnDesc+="0.005% Willpower Drain |"
	if(buffslot)returnDesc+=" Uses [buffslot] buffslot(s)"
	return returnDesc

Skill/Attacks/Beams/var/BeamMode=1
