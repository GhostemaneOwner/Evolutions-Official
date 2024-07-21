Skill/Attacks/Beams/Kamehameha
	UB1="Kaioken"
	Wave=1
	icon='BeamKamehameha.dmi'
	KiReq=1.5
	WaveMult=2
	ChargeRate=1.5
	MaxDistance=25
	MoveDelay=2
	Piercer=0
	luminosity=3
	Tier=4
	NoMove=1
	Shockwave=1
	var/Super=0
	New()
		BeamDescription()
		..()
	verb/Kamehameha()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		/*for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return*/
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src,Super,1)
	verb/Ki_Settings()
		set category="Other"
		var/BM=input("Would you like [src] to fire immediately or to charge?") in list("Immediate","Charge")
		if(BM=="Immediate") BeamMode=0
		else BeamMode=1
	/*	if(Experience>=100)
			if(usr.Confirm("Would you like to fire a Super [src] instead?")) Super=1
			else Super=0*/
		switch(input("Do you want your [src] to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
	verb/Super_Kamehameha()
		set category="Skills"
		if(Experience<100)
			usr<<"You must master [src] first."
			return
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src,1)
