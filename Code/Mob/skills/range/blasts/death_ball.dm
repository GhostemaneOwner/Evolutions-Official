Skill/Attacks/Death_Ball
	desc="Calculates damage using Force. Cast it to begin charging and when done charging clicking with the mouse will cause it to move continuosly towards the mouse click."
	var/IsCharged
	UB1="Death"
	UB2="Shadow King"
	KiReq=300
	NoMove=1
	Experience=10
	Tier=4
//	Fatal=1
	verb/Death_Ball()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<KiReq|charging) return
		if(!usr.Target||usr.Target.z!=usr.z)
			usr<<"You must have a target on the same plane."
			return
		if(!usr.CanAttack(KiReq,src)) return
		CDTick(usr)
		if(usr)
			//usr.DrainKi(src,"Percent",30)
			usr.DrainKi(src, 1, KiReq,show=1)
			var/obj/ranged/Blast/SpiritBall/Genki_Dama/A=unpool("Genki_Dama")
			A.Belongs_To=usr
			A.loc=usr.loc
			A.name=src.name
			A.y+=3
			if(!A||!A.z) return
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=25*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off
			A.Size=1
			A.Explosive=2
			A.Large('Death Ball.dmi',0,0,0,180)
			A.DoNotTrack=1
			A.Health=1000000000000
			usr.attacking=3
			charging=1
			for(var/mob/M in range(20,usr))
				M.CombatOut("[usr] begins to charge a [src]!")
			if(Experience<100) Experience+=rand(11,20)
			if(Experience>100) Experience=100
			var/Delay = usr.Refire * 2
			Delay += 180/Experience
			//usr.overlays+=usr.BlastCharge
			usr.overlays+='SBombGivePower.dmi'
			sleep(Delay)
			usr.overlays-='SBombGivePower.dmi'
			//usr.overlays-=usr.BlastCharge
			//sleep(50/usr.SpdMod/(Experience/100))
			charging=0
			for(var/Skill/Zanzoken/Z in usr)if(Z.Zon)
				Z.Zon = 0
				usr.BuffOut("Zanzoken toggled off.")
			IsCharged=1
//			A.SpiritBall=1
			walk_towards(A,usr.Target)
			A.maxSteps*=2
			usr.attacking=0

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
		