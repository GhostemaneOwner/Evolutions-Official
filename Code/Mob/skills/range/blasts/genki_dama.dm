

obj/ranged/Blast/SpiritBall/Genki_Dama
//	Explosive=1
	density=1
	var/Size
	New()
		spawn if(src) Health=Damage
	proc/Medium(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-16,pixel_y=-16,layer=EFFECTS_LAYER)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=16,pixel_y=-16,layer=EFFECTS_LAYER)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=-16,pixel_y=16,layer=EFFECTS_LAYER)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=16,pixel_y=16,layer=EFFECTS_LAYER)
		overlays.Add(A,B,C,D)
	proc/Large(Icon,X,Y,Z,T)
		Icon+=rgb(X,Y,Z,T)
		var/image/A=image(icon=Icon,icon_state="1",pixel_x=-32,pixel_y=-32,layer=EFFECTS_LAYER)
		var/image/B=image(icon=Icon,icon_state="2",pixel_x=0,pixel_y=-32,layer=EFFECTS_LAYER)
		var/image/C=image(icon=Icon,icon_state="3",pixel_x=32,pixel_y=-32,layer=EFFECTS_LAYER)
		var/image/D=image(icon=Icon,icon_state="4",pixel_x=-32,pixel_y=0,layer=EFFECTS_LAYER)
		var/image/E=image(icon=Icon,icon_state="5",pixel_x=0,pixel_y=0,layer=EFFECTS_LAYER)
		var/image/F=image(icon=Icon,icon_state="6",pixel_x=32,pixel_y=0,layer=EFFECTS_LAYER)
		var/image/G=image(icon=Icon,icon_state="7",pixel_x=-32,pixel_y=32,layer=EFFECTS_LAYER)
		var/image/H=image(icon=Icon,icon_state="8",pixel_x=0,pixel_y=32,layer=EFFECTS_LAYER)
		var/image/I=image(icon=Icon,icon_state="9",pixel_x=32,pixel_y=32,layer=EFFECTS_LAYER)
		overlays.Add(A,B,C,D,E,F,G,H,I)
	/*Move()
		var/Distance=0
		if(Size) Distance=Size
		for(var/atom/A in orange(Distance,src)) if(A!=src&&A.density&&!isarea(A)) Bump(A)
		if(src) ..()*/
Skill/Attacks/SpiritBomb
	desc="Calculates damage using Offense. Cast it to begin charging and when done charging clicking with the mouse will cause it to move continuosly towards the mouse click."
	UB1="Kaioken"
	UB2="Arcane Power"
	var/IsCharged
	var/Mode="Small"
	NoMove=1
	KiReq=200
	Experience=10
	Tier=4
	verb/Ki_Settings()
		set category="Other"
		switch(input("Choose a size. It will affect the power and speed in different ways.") in \
		list("Small","Medium","Large"))
			if("Small")
				KiReq=250
				Mode="Small"
			if("Medium")
				KiReq=400
				Mode="Medium"
			if("Large")
				KiReq=600
				Mode="Large"
	verb/Spirit_Bomb()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<KiReq|charging) return
		if(!usr.CanAttack(KiReq,src)) return
		if(!usr.Target||usr.Target.z!=usr.z)
			usr<<"You must have a target on the same plane."
			return
		CDTick(usr)
		if(usr)
			//usr.DrainKi(src,"Percent",20)
			usr.DrainKi(src, 1, KiReq,show=1)
			var/obj/ranged/Blast/SpiritBall/Genki_Dama/A=unpool("Genki_Dama")
			A.Belongs_To=usr
			A.loc=usr.loc
			A.y+=7
			if(!A||!A.z) return
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=18*(usr.BP+MaskDamage)*usr.Off*Ki_Power
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Health=1000000000000
			A.Offense=usr.Off*1.1
			A.Explosive=1
			A.DoNotTrack=1
			if(Mode=="Small") A.icon='SBomb.dmi'
			if(Mode=="Medium")
				A.Size=1
				A.Damage*=1.5
				A.Power*=1.5
				A.Offense*=1.2
				A.Explosive=2
				A.Medium('deathball.dmi',100,200,250,180)
			if(Mode=="Large")
				A.Size=1
				A.Damage*=2
				A.Power*=2
				A.Explosive=2
				A.Offense*=1.2
				A.Large('Spirit Bomb.dmi',0,0,0,180)
			usr.attacking=3
			charging=1
			if(Experience<100) Experience+=rand(11,20)
			if(Experience>100) Experience=100
			usr.overlays+='SBombGivePower.dmi'
			var/Delay = usr.Refire * 2
			if(Mode=="Small") Delay += 100/Experience
			if(Mode=="Medium") Delay += 200/Experience
			if(Mode=="Large") Delay += 300/Experience
			for(var/mob/M in range(20,usr))
				M.CombatOut("[usr] begins to charge a [src]!")
			sleep(Delay)
			charging=0
			usr.overlays-='SBombGivePower.dmi'
			usr.attacking=0
			for(var/Skill/Zanzoken/Z in usr)if(Z.Zon)
				Z.Zon = 0
				usr.BuffOut("Zanzoken toggled off.")
			if(A)
				IsCharged=1
				//A.SpiritBall=1
				A.maxSteps*=2
				walk_towards(A,usr.Target)
				//usr.overlays+=usr.BlastCharge

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
