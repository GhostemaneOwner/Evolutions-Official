//obj/vars/wave=0
Skill/Attacks/Beams/Ray
	Wave=1
	UB1="Channel"
	icon='Beam8.dmi'
	KiReq=1.5
	WaveMult=0.7
	ChargeRate=1
	MaxDistance=10 //Move delay x40
	MoveDelay=1
	Piercer=0
	luminosity=2
	BeamMode=0
	Tier=3
	NoMove=1
	New()
		BeamDescription()
		..()	//Beams are bright
	verb/Ray()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		/*for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return*/
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src)
	verb/Ki_Settings()
		set category="Other"
		switch(input("Do you want your [src] to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
		