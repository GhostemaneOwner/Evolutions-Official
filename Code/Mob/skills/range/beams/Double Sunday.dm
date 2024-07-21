Skill/Attacks/Beams/Double_Sunday
	UB1="Arcane Power"
//	UB2=
	Wave=1
	icon='CorkScrew.dmi'
	KiReq=1.5
	WaveMult=2.5
	ChargeRate=2
	MaxDistance=30
	MoveDelay=3
	Piercer=0
	luminosity=3
	NoMove=1
	Tier=4
	Shockwave=1
	New()
		BeamDescription()
		..()
	verb/Double_Sunday()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		/*for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return*/
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src,2,0)
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

Skill/Attacks/Beams/Photon_Flash
	UB1="Godspeed"
	UB2="Arcane Power"
	Wave=1
	icon='CorkScrew.dmi'
	KiReq=2.5
	WaveMult=1.5
	ChargeRate=4
	MaxDistance=15
	MoveDelay=1.5
	Piercer=0
	luminosity=3
	NoMove=1
	Tier=4
	New()
		BeamDescription()
		..()
	verb/Photon_Flash()
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

Skill/Attacks/Beams/Tyrant_Lancer
	UB1="Shadow King"
	UB2="Death"
	Wave=1
	icon='CorkScrew.dmi'
	KiReq=1.3
	WaveMult=1.4
	ChargeRate=1.4
	MaxDistance=25
	MoveDelay=1.8
	Piercer=0
	Shockwave=1
	luminosity=3
	NoMove=1
	Tier=4
	New()
		BeamDescription()
		..()
	verb/Tyrant_Lancer()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.icon_state in list("Meditate","Train","KO","KB")) return
		if(usr.Ki<KiReq||usr.Frozen) return
		/*for(var/mob/M in range(0,usr))
			if(M != usr) if(M.GrabbedMob == usr)
				usr << "Can't charge a beam while being held!"
				return*/
		for(var/Skill/Attacks/A in usr) if(A!=src) if(A.charging|A.streaming) return
		usr.Beam_Macro(src,0,1)
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



Skill/Attacks/Beams/Buster_Cannon
	UB1="War"
	UB2="Fungal Plague"
	Wave=1
	icon='CorkScrew.dmi'
	KiReq=1
	WaveMult=1.5
	ChargeRate=0.5
	MaxDistance=30
	Shockwave=1
	MoveDelay=2.5
	Piercer=0
	luminosity=3
	NoMove=1
	Tier=4
	New()
		BeamDescription()
		..()
	verb/Buster_Cannon()
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
		