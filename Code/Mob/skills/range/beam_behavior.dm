obj/ranged/Beam

	var/tmp/Skill/Attacks/origin
	var/tmp/kiDrain=1
//		DrainMult=1
//		Special=0
		//mob/owner

	Move()

		.=..() //call the parent (overriden by /obj/ranged/Move() ), store the return value
		if(!.) return //if it returned false, (movement failed), return false too (and stop this proc)
		 //otherwise, if movement succeeded...
		if(!origin) del(src)
//		if(Belongs_To.attacking==2) Belongs_To.DrainKi(src,1,(((kiDrain*DrainMult)*0.5)/maxSteps),0) // Drain their energy
		if(Belongs_To.Ki<=0) Belongs_To.BeamStop(origin) // If they don't have enough energy, prevent them from continuing the attack.
		//if(prob(10)&&locate(/obj/ranged) in get_step(src,turn(dir,180))) Explode()
		src.shoot()
		beam_appearance()
		if(Damage>2500000&!locate(/Icon_Obj/Effects/KBHole1) in loc)KBHole1(src,src.dir)

	Bump(atom/Z)
		.=..() //call the parent (/obj/ranged/Bump() ), store the return value
		if(!.) return //if it returned false, (movement failed), return false too (and stop this proc)
		if(Damage>2500000&!locate(/Icon_Obj/Effects/KBHole1) in loc)KBHole1(src,src.dir,2)
		if(isobj(Z))
			if(istype(Z,/obj/ranged))
				var/obj/ranged/ZZ=Z
				if(ZZ.Deflectable==0) del(ZZ)
				if(istype(Z,/obj/ranged/Beam))
					var/obj/ranged/Beam/R=Z
					if(R.Belongs_To!=Belongs_To)
						if(prob(30))
							for(var/mob/player/P in view(10)) P.Quake_Effect(5)
							if(prob(80)) ShockwaveScale(Z,Belongs_To.BP)
						if(R)
							if(R.dir!=dir)
								icon_state="struggle"
								if(R) R.icon_state="struggle"
								layer=MOB_LAYER+2
								if(R) R.layer=MOB_LAYER+2
								if(R.Damage) if(R.Damage<Damage&&prob(70))
									walk(src,dir,10)
									for(var/obj/ranged/Beam/B in get_step(R,turn(R.dir,180)))
										B.icon_state="struggle"
										break
									del(R)
									Belongs_To.Blast_Gain()
									return
							if(R.dir==dir&&R.icon_state=="struggle")
								if(R.Damage<Damage)
									del(R)
									return
				if(istype(Z,/obj/ranged/Blast)&&Special) del(Z)
			else  if(!istype(Z,/Icon_Obj))//if(isobj(A)&&!istype(A,/obj/ranged))
				if(isnum(Z.Health))if(isnum(Power))if(isnum(Damage))
					if(istype(Z,/obj/TrainingEq/Punchometer))
						if(ismob(Belongs_To))
							var/obj/TrainingEq/PM=Z
							PM.TakeDamage(src, (Damage)/(PM.BP*PM.End), "Beam","energy")//A.Health-=Damage/Belongs_To.Pow
					else
						Z.TakeDamage(src, (Damage)/GunBPAssign(Z.Level,5), "Beam","energy")
						if(Z.Health<=0)
							SmallCrater(Z)
							del(Z)
							return
						if(Z)
							if(!Piercer&&Z.density)
								del(src)
								return FALSE

		else if(ismob(Z)/*||istype(Z,/NPC_AI)*/)
			var/mob/A=Z // This -seems- entirely redundant, but if not done, the GrabbedMob check will not function.
			if(A.afk)
				del(src)
				return FALSE
			if(A.RPMode)
				del(src)
				return FALSE
			if(A.GrabbedMob && A.isGrabbing==1) A=A.GrabbedMob // If the mob the beam is hitting is holding someone, destroy them first.
			if(A.immortal) return FALSE // if they're not supposed to die, do no damage.
			for(var/obj/items/Force_Field/S in A)
				if(S.Level>0)
					if(S.Level>500000000) S.Level=500000000
					S.Level = max(0, (S.Level - 20*(Damage/(A.BP*A.End))) ) // damage
					S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
					Damage*=0.7
					A.Force_Field()
					if(S.Level<=0)
						S.Level=0
						S.suffix=null
						view(src)<<"[A]'s force field is drained!"
			//var/Shielding=0
			if(A.Shielding)
				//A.DrainKi("Shield","Percent",0.5)
				A.DrainKi("Shield", "Percept", 1,1)
				Damage*=0.7
			if(isnum(A.Health))
				if(A.immortal) return FALSE // if they're not supposed to die, do no damage.
				var/EMPBP=0
				if(A.ArmorOn) for(var/obj/items/Armor/AA in src) if(AA.suffix&&AA.Durability>0) if(AA.KineticBarrier) EMPBP=A.BP*(AA.KineticBarrier/100)
				if(A.EmpoweredDefenseTicks) EMPBP=A.BP*0.5
				var/EndRed=0
				if(Belongs_To) EndRed=((Belongs_To.HasThisDrill*0.1)*A.End)
				var/DMG = Damage/((A.BP+EMPBP)*(A.End-EndRed))
				A.TakeDamage(Belongs_To, DMG, "[src]","energy")
				if(CausesBurns&&prob(20)) A.BurnDamage(Belongs_To,"Smolder Burn",DMG*0.165)
				if(prob(10)) Stagger(A,1)
			if(A.KOd&&A.client)
				if(A.immortal) return FALSE // if they're not supposed to die, do no damage.
				A.Life-=1*(Damage/(A.Base*A.Body*A.End))
				if(A.Life<=2)
					if(A.Regenerate) if(A.BP*20*A.Regenerate<Power) if(Belongs_To.Lethality) A.Absorbed=1
					if(Belongs_To.Lethality) A.Death(Belongs_To)
					A.immortality(time=3) // make them immortal for 3 seconds
					return FALSE
			else if(!A.client&&A.Frozen)
				if(A.immortal) return // if they're not supposed to die, do no damage.
				var/RES = A.End * 1.25
				A.Life-=1*(Damage/(A.Base*A.Body*RES))
				if(A.Life<=0)
					if(A.Regenerate) if(A.BP*20*A.Regenerate<Power) if(Belongs_To.Lethality) A.Absorbed=1
					if(Belongs_To.Lethality) A.Death(Belongs_To)
					return FALSE
			if(Shockwave)
				var/EMPBP=0
				if(A.ArmorOn) for(var/obj/items/Armor/AA in src) if(AA.suffix&&AA.Durability>0) if(AA.KineticBarrier) EMPBP=A.BP*(AA.KineticBarrier/100)
				if(A.EmpoweredDefenseTicks) EMPBP=A.BP*0.5
				var/KBChance = 5*(Damage/((A.BP+EMPBP)*A.End))
				if(prob(KBChance))
					A.Shockwave_Knockback(Shockwave,Belongs_To.loc)
					Shockwave=0
					return TRUE
			if(!Piercer)
				if(src)
					del(src)
					return FALSE
		else if(isturf(Z)&&Z.density)
			if(isnum(Z.Health))
				if(Power < 2)
					del(src)
					return FALSE
				Z.TakeDamage(src, (Power*(Damage/Power))/TrueBPCap, "Beam","energy")
				if(Z.Health<=0)
					var/turf/B=Z
					if(usr!=0)
						B.Destroy(usr,usr.key)
						return
					else
						B.Destroy("Unknown","Unknown")
						return
				if(Z) if(Z.density)
					del(src)
					return FALSE



	proc/beam_appearance()
		//var/d = turn(src.dir,180)
		if(icon_state!="struggle")
			if(!(locate(/obj/ranged/Beam) in get_step(src,dir))) icon_state="head" //If the next step doesn't have a Beam object in it, then the current object should be the 'head' of the beam
			else icon_state="tail" //The others are its tail
		for(var/obj/ranged/Beam/B in get_step(src,dir))
			if(B.Belongs_To!=src.Belongs_To)
				B.icon_state="struggle"
		for(var/obj/ranged/Beam/C in get_step(src,dir))
			if(C.dir==dir)
				icon_state="tail"
				layer=MOB_LAYER+1
		for(var/obj/ranged/Beam/C in get_step(src,turn(dir,180)))
			if(C.dir==dir&&C.icon_state=="struggle")
				C.icon_state="tail"
				C.layer=MOB_LAYER+1
		if(Radius) animate(src, transform = matrix()*2.7, time = 0)


	proc/shoot()
		var/dense[0]
		for(var/atom/a in src.loc)
			if(istype(a,/obj/ranged)&&a.dir==dir) continue
			else if(a.density && a != src) dense+=a
		for(var/turf/a in range(0,src)) if(a.density && a != src) dense+=a
		for(var/obj/ranged/a in range(0,src)) if(a.dir != src.dir) dense+=a
		if(dense.len) for(var/atom/a in dense) src.Bump(a)


	proc/beamVariables(Skill/Attacks/A,mob/P,Spread,Special=0)
		luminosity=(A.luminosity)
		animate_movement=0
		layer=MOB_LAYER+1
		density=0 // original at 0
		Piercer=A.Piercer
		var/MaskDamage=0
		if(P.MaskOn) for(var/obj/items/Magic_Mask/MM in P) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(P)
			MM.DurabilityCheck(P)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		Damage=P.BP*P.Pow*(1+(A.chargelvl*0.3))*A.WaveMult*global.Ki_Power
		if(Special)Damage=P.BP*P.Off*A.WaveMult*(1+(A.chargelvl*0.3))*global.Ki_Power
		if(Spread)
			Damage*=0.75
			animate(src, transform = matrix()*2.7, time = 0)
		maxSteps=A.MaxDistance
		origin=A
		Belongs_To=P
		Experience=A.Experience
		kiDrain=A.KiReq
		Shockwave=A.Shockwave
		CausesBurns=usr.HasSmolder

	pooled()
//		DrainMult=1
		kiDrain=1
		..()

mob/proc

	Beam_Macro(Skill/Attacks/Beams/Beam/O,var/Spread=0,var/Special=0)
		if(icon_state in list("Meditate","Train","KO","KB")) return
		if(GrabbedMob||isGrabbing) return
		if(StunCheck(usr)) return
		if(src.Ki<O.KiReq) return
		if(getCooldown("[O]")>world.time)
			usr.CombatOut("([(getCooldown("[O]")-world.time)/10]) Cooldown remaining. ([O])")
			return
		for(var/Skill/Attacks/A in src) if(A!=O) if(A.charging||A.streaming||A.Using) return
		if(!O.charging&&!attacking&&O.BeamMode==1)
			usr.BeamCharge(O,Special)
			saveToLog("[key_name(usr)] begins to charge a beam! - ([usr.x],[usr.y],[usr.z])\n")
		else if(!O.streaming&&O.charging&&src.attacking||O.BeamMode==0&&!O.streaming)
			usr.BeamStream(O,Spread,Special)
			saveToLog("[key_name(usr)] fires their beam! - ([usr.x],[usr.y],[usr.z])\n")
		else if(O.streaming) usr.BeamStop(O)

	BeamCharge(Skill/Attacks/A,Special)
		if(Beam_Refire_Delay_Active) return
		A.charging=1
		attacking=3
		var/image/ChargeOver = image(BlastCharge,layer=EFFECTS_LAYER+10)
		overlays-=ChargeOver
		overlays+=ChargeOver
		var/LoopsCompleted=0
		for(var/mob/M in range(20,src))
			M.BuffOut("[src] begins to charge a [A]!")
		spawn(10) while(A.charging||A.streaming||attacking)
			sleep(1)
			if(KOd||Ki<A.KiReq||Stunned||Frozen||KB&&prob(25))
				A.charging=0
				A.streaming=0
				attacking=0
				A.chargelvl=0
				spawn(10) if(KOd==0) move=1
				src.CombatOut("You lose the energy you were charging.")
				if(KOd==0) src.icon_state=""
				overlays-=ChargeOver
		spawn while(A.charging&&!A.streaming)
			if(!A.chargelvl||A.chargelvl<1) A.chargelvl=1
			else if(A.chargelvl<20)
				A.chargelvl+=A.ChargeRate
				src.CombatOut("<b>[A] charge at [round(A.chargelvl,0.01)]x</b>")
			if(A.Experience<100) A.Experience+=rand(1,4)
			if(A.Experience>100) A.Experience=100
			usr.DrainKi(A,1,(A.KiReq*(A.chargelvl*A.ChargeRate)/min(0.5,A.Experience/80))*(1+(LoopsCompleted/3)))
			LoopsCompleted++
			if(!Special) sleep((Refire*A.ChargeRate)/(max(0.8,A.Experience/100)))
			else sleep((10*A.ChargeRate)/(max(0.8,A.Experience/100)))

	BeamStream(Skill/Attacks/A,var/Spread,var/Special)
		A.charging=0
		A.streaming=1
		if(A.chargelvl==0)A.chargelvl=1
		var/image/ChargeOver = image(BlastCharge,layer=EFFECTS_LAYER+10)
		overlays-=ChargeOver
		if(!Flying) icon_state="Blast"
		if(A.MoveDelay<1) A.MoveDelay=1
		var/LoopsCompleted=0
		if(invisibility)
			invisibility=0
			see_invisible=0
			usr.CombatOut("The attack causes you to lose your focus and slip out of invisibility!")
			winset(usr.client,"INVIS","is-visible=false")
			for(var/Skill/Support/Invisibility/AA in usr) if(A.Using) spawn(45){AA.Using=0;usr<<"You feel your body relax again."}
		for(var/mob/player/M in range(20,src)) M.CombatOut("[src] begins to fire a [A]!")
		spawn while(A.streaming&&src)
			if(A.Experience<100) A.Experience+=rand(1,4)
			if(A.Experience>100) A.Experience=100
			if(KOd||Stunned||Frozen||Ki<A.KiReq||KB) BeamStop(A)
			sleep(round(A.MoveDelay/(max(0.8,A.Experience/100))))
			if(prob(0.1*A.MoveDelay)&&A.Experience<100) A.Experience+=rand(2,8)
			if(A.Experience>100) A.Experience=100
			var/obj/ranged/Beam/B=unpool("Beams")
			B.loc=get_step(src,src.dir)
			B.dir=src.dir
			B.name=A.name
			B.icon=A.icon
			B.icon_state="origin"
			//B.DrainMult=1 + (A.chargelvl*0.25)
			B.Special = Special
			if(A.pixel_x) B.pixel_x=A.pixel_x
			if(A.pixel_y) B.pixel_x=A.pixel_y
			B.beamVariables(A,src,Spread,Special)
			spawn(1) if(B.Damage>2500000&!locate(/Icon_Obj/Effects/KBHole1) in A.loc)KBHole1(B,B.dir,SE=1)
			DrainKi(A,1,5+(((B.kiDrain*(Spread+1))*A.chargelvl)/(A.Experience/100))*(1+(LoopsCompleted/4)))// ensures that even 'point blank' firing drains energy
			spawn(A.MoveDelay) if(B) B.icon_state="tail"
			if(B) spawn if(B) B.shoot()
			else return
			if(Spread==1)
				animate(B, transform = matrix()*2.7, time = 0)
				B.Radius=1
				switch(dir)
					if(NORTH) B.pixel_y+=8
					if(EAST) B.pixel_x+=8
					if(WEST) B.pixel_x-=8
					if(SOUTH) B.pixel_y-=8
					if(SOUTHEAST)
						B.pixel_x+=3
						B.pixel_y-=3
					if(SOUTHWEST)
						B.pixel_x-=3
						B.pixel_y-=3
					if(NORTHWEST)
						B.pixel_x-=3
						B.pixel_y+=3
					if(NORTHEAST)
						B.pixel_x+=3
						B.pixel_y+=3
			if(Spread==2)
				var/obj/ranged/Beam/C=unpool("Beams")
				C.loc=(get_step(src,turn(src.dir,-45)))
				C.icon=A.icon
				C.icon_state="origin"
				if(A.pixel_x) C.pixel_x=A.pixel_x
				if(A.pixel_y) C.pixel_x=A.pixel_y
				C.beamVariables(A,src)
				//Ki=max(0,Ki-(0.2*(C.kiDrain*A.chargelvl)/(A.Experience/20))) // ensures that even 'point blank' firing drains energy
				spawn(A.MoveDelay) if(C) C.icon_state="tail"
				if(C) spawn if(C)
					C.shoot()
					walk(C,dir,A.MoveDelay/(max(0.8,A.Experience/100)))
				var/obj/ranged/Beam/D=unpool("Beams")
				D.loc=(get_step(src,turn(src.dir,45)))
				D.icon=A.icon
				D.icon_state="origin"
				if(A.pixel_x) D.pixel_x=A.pixel_x
				if(A.pixel_y) D.pixel_x=A.pixel_y
				D.beamVariables(A,src)
				//Ki=max(0,Ki-(0.2*(D.kiDrain*A.chargelvl)/(A.Experience/20))) // ensures that even 'point blank' firing drains energy
				spawn(A.MoveDelay) if(D) D.icon_state="tail"
				if(D) spawn if(D)
					D.shoot()
					walk(D,dir,A.MoveDelay/(max(0.8,A.Experience/100)))
			walk(B,dir,A.MoveDelay/(max(0.8,A.Experience/100)))
			LoopsCompleted++


	BeamStop(Skill/Attacks/A)
		Beam_Refire_Delay_Active=1
		spawn(50/SpdMod) if(src) Beam_Refire_Delay_Active=0
		A.charging=0
		A.streaming=0
		attacking = 1
		spawn(Refire) attacking = 0
		A.chargelvl=1
		if(icon_state=="Blast"&&!Flying) icon_state=""
		if(KOd==0) move=1
		A.CDTick(src)
