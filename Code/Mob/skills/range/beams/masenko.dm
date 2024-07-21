Skill/Attacks/Beams/Masenko
	UB1="Shadow King"
	Wave=1
	icon='Beam5.dmi'
	KiReq=1.5
	WaveMult=1
	ChargeRate=1
	MaxDistance=15
	MoveDelay=1.5
	Piercer=0
	luminosity=2
	Tier=4
	NoMove=1
	New()
		BeamDescription()
		..()
	verb/Masenko()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		/*for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return*/
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src,0,0)
	verb/Ki_Settings()
		set category="Other"
		var/BM=input("Would you like [src] to fire immediately or to charge?") in list("Immediate","Charge")
		if(BM=="Immediate") BeamMode=0
		else BeamMode=1
		switch(input("Do you want your [src] to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
		