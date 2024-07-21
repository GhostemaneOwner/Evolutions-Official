/*
The object that's put inside the player's inventory. This is NOT the object created upon firing.
Look further down for the actual blast object that triggers Bump()
*/
/*
obj/Blast/var

	Damage
	Fatal=1
	Explosive
	Shockwave
	Piercer
	Paralysis
	Beam
	Shuriken
	Shrapnel //Shrapnel from explosions if any
	Deflectable=1
	Power=1 //BP of the Blast. Force can be obtained by dividing damage by Power.
	Offense=1
	Distance=30

*/
Skill/Attacks/Blast
//	Fatal=1
	Tier=1
	Experience=1
	var/Spread=1
	icon='1.dmi'
	desc="An attack that becomes more rapid as your skill with it develops"
	verb/Ki_Settings()
		set category="Other"
		Shockwave=0
		Spread=input("This allows you to choose the spread level of the Blast ability. 1 is slightly stronger but only travels straight forward. 2 is slightly weaker but shoots 3 blasts at once.") in list(1,2)
		Spread=round(Spread)
		switch(input("Do you want your blasts to knock away the people they hit?") in list("Yes","No"))
			if("Yes") Shockwave=1
			if("No") Shockwave=0
		/*if(Shockwave==0) switch(input("Do you want your blasts to home towards your target? This will reduce their damage by 25%.") in list("Yes","No"))
			if("Yes") Seek=1
			if("No") Seek=0*/
		switch(input("Do you want your blasts to destroy walls when they hit?") in list("Yes","No"))
			if("Yes") usr.Destroy_Walls = 1
			if("No") usr.Destroy_Walls = 0
	verb/Blast()
		set category="Skills"
		if(usr.RPMode) return
	//	usr.Learn_Attack()
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
	//	usr.kimanip+=(0.01*usr.kimanipmod)
		if(usr.attacking||usr.Ki<(2.5+Shockwave)*(Spread)) return
		if(!usr.CanAttack((2.5+Shockwave)*(Spread))) return
		//var/Drain = (roll("1d2")+((2.5+Shockwave)*(Spread)))/10
		//usr.DrainKi(src,"Percent",Drain)
		usr.DrainKi(src, 1, 1+(Shockwave*2),1)
		usr.attacking=3
		usr.Bandages()
		var/Delay = usr.Refire / 14
		Delay += 70 / Experience
		spawn(Delay) usr.attacking=0
		if(Experience<100) Experience+=0.2
		if(Experience>100) Experience=100
//		hearers(6,usr) << pick('Blast1.wav','Blast2.wav')
		if(Spread>1)
			var/obj/ranged/Blast/B=unpool("Blasts")
			B.Belongs_To=usr
			B.pixel_x=pixel_x
			B.pixel_y=pixel_y
			B.pixel_x+=rand(-16,16)
			B.pixel_y+=rand(-16,16)
			B.icon=src.icon
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			B.Damage=0.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			B.Power=(usr.BP+MaskDamage)*Ki_Power
			B.Offense=usr.Off
			if(prob(15)) B.Shockwave=Shockwave
			B.dir=usr.dir
			var/obj/ranged/Blast/C=unpool("Blasts")
			C.Belongs_To=usr
			C.pixel_x=pixel_x
			C.pixel_y=pixel_y
			C.pixel_x+=rand(-16,16)
			C.pixel_y+=rand(-16,16)
			C.icon=src.icon
			C.Damage=0.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			C.Power=(usr.BP+MaskDamage)*Ki_Power
			C.Offense=usr.Off
			if(prob(15)) C.Shockwave=Shockwave
			C.dir=usr.dir
			var/obj/ranged/Blast/A=unpool("Blasts")
			flick("Blast",usr)
			A.Belongs_To=usr
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-16,16)
			A.pixel_y+=rand(-16,16)
			A.icon=src.icon
			A.Damage=0.3*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off
			if(prob(15)) A.Shockwave=Shockwave

			C.loc=usr.loc
			step(C,turn(usr.dir,-45))
			B.loc=usr.loc
			step(B,turn(usr.dir,45))
			if(usr.HasSmolder)
				A.CausesBurns=1
				B.CausesBurns=1
				C.CausesBurns=1
			if(C)
				C.dir=usr.dir
				walk(C,C.dir)
			if(B)
				B.dir=usr.dir
				walk(B,B.dir)

			if(A)
				A.dir=usr.dir
				A.loc=usr.loc
				walk(A,A.dir)
		else
			var/obj/ranged/Blast/A=unpool("Blasts")
			flick("Blast",usr)
			A.Belongs_To=usr
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.pixel_x+=rand(-16,16)
			A.pixel_y+=rand(-16,16)
			A.icon=icon
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=1*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off
			if(prob(15)) A.Shockwave=Shockwave
			A.dir=usr.dir
			A.loc=usr.loc
			if(usr.HasSmolder) A.CausesBurns=1
			walk(A,A.dir)

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
/*
Actual damage doing object.
Using two different object allows for easy tweaking/renaming of these objects without affecting players.
*/

obj/ranged/Blast
	density=1
	New()
		spawn(200) del(src)
	Bump(mob/A)
		if(Belongs_To)
			if(isobj(A)||isturf(A))
				if(isnum(A.Health))
					if(isturf(A))
						if(istype(A,/turf/Upgradeable/Walls/))
							if(src.Belongs_To)
								var/mob/M = src.Belongs_To
								if(M.Destroy_Walls) A.TakeDamage(src, (Damage)/GunBPAssign(A.Level,5), "Blast","energy")//A.Health = -100
						else A.TakeDamage(src, 50, "Blast","energy")
					else
						if(istype(A,/obj/TrainingEq/Punchometer))
							if(ismob(Belongs_To)) A.TakeDamage(src, (Damage)/(A.BP*A.End), "Blast","energy")//A.Health-=Damage/Belongs_To.Pow
						else
							if(ismob(Belongs_To)) A.TakeDamage(src, (Damage)/TrueBPCap, "Blast","energy")//A.Health-=Damage/Belongs_To.Pow
							else A.TakeDamage(src, 50, "Blast","energy")//A.Health-=Damage/2000
				if(isnum(A.Health)&&A.Health<=0&&!istype(A,/obj/ranged/Blast))
					//LOG SHIPS
					if(istype(A,/obj/Ships)) Belongs_To.saveToLog("| [Belongs_To.client.address ? (Belongs_To.client.address) : "IP not found"] | ([Belongs_To.x], [Belongs_To.y], [Belongs_To.z]) | [key_name(Belongs_To)] has destroyed [A].\n")
					if(isturf(A))
						var/turf/B=A
						if(!usr||usr==0||isnull(usr)) B.Destroy("Unknown","Unknown")
						else B.Destroy(usr,usr.key)
					else if(!istype(A,/Icon_Obj))
						SmallCrater(A)
						del(A)
				if(istype(A,/obj/ranged/Blast))
					var/obj/ranged/Blast/J=A
					if(J.Damage<Damage) del(A)
				Explode(Belongs_To, Damage)
				if(!Piercer) del(src)
			else if(ismob(A)/*||istype(A,/NPC_AI)*/) // Either the object hit by the beam is a mob or an NPC
				//if(istype(A,/NPC_AI)&&isnum(A.Health)&&A.Health<=0){A.Death(Belongs_To);del(A);return FALSE} // If the NPC's health is a number (sanity) and below 0, kill them.
	//			if(istype(A,/mob/Cookable)){del(A);return FALSE} // If it's a cookable mob, just destroy it.
				if(A.afk) del(src)
				var/EMPBP=0
				if(A.ArmorOn) for(var/obj/items/Armor/AA in src) if(AA.suffix&&AA.Durability>0) if(AA.KineticBarrier) EMPBP=A.BP*(AA.KineticBarrier/100)
				if(A.EmpoweredDefenseTicks) EMPBP=A.BP*0.5
				Damage/=(A.BP+EMPBP)*(A.End-((Belongs_To.HasThisDrill*0.1)*A.End))
				var/Life_Decrease=1*(Damage/(A.Base*A.Body*A.End))
				for(var/obj/items/Force_Field/S in A) if(S.Level>0) if(prob(70))//if(S.suffix)
					if(S.Level>65000000) S.Level=65000000
					S.Level = max(0, (S.Level - 10*Damage) )
					S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
					Damage*=0.7
					if(S.Level<=0)
						S.Level=0
						S.suffix=null
						view(src)<<"[A]'s force field is drained!"
						spawn() del(S)
					S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
					A.Force_Field()
					if(prob(5))
						src.HeatSeeking=0
						walk(src,pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST))
						return FALSE
				var/shlded=0
				if(Deflectable&&A.Shielding)
					/*if(prob(10))
						A.Ki = max(0, A.Ki-10)
						A.CombatOut("Your shield reflected [Belongs_To]'s [src]!")
						Belongs_To.CombatOut("[A]'s shield reflected your [src]!")
						src.HeatSeeking=0
						walk(src,A.dir)
						return FALSE
					else*/
					//A.DrainKi("Shield","Percent",0.5)
					A.DrainKi("Shield", "Percent", 1,1)
					shlded=1//ki drain
				if(Belongs_To&&Belongs_To.HasEnergyMarksmanship) if(prob(20)&&A.Precognition) if(A.icon_state in list("","Flight"))
					step(A,turn(dir,pick(-45,45)))
					return FALSE
				else if(prob(50))if(A.Precognition||A.HasPrecognition) if(A.icon_state in list("","Flight"))
					step(A,turn(dir,pick(-45,45)))
					return FALSE
				//var/DEF = A.Def



				var/Hit_Chance=KiAccuracyFormula(src,Belongs_To,A,60)   //(60*((((src.Power/global.Ki_Power))*src.Offense)/(A.BP*A.Def)))+(Belongs_To.HasEnergyMarksmanship*15)+(Belongs_To.HasBullsEye*2.5)//30%



				if(Belongs_To.StanceCore==1) Hit_Chance*=1.03
				if(A.StanceCore==1) Hit_Chance*=0.97
				if(A.Blocking) Hit_Chance-=30
				if(prob(Hit_Chance)||!Deflectable||A.KOd) //||A.Frozen)
					if(shlded) Damage = Damage * 0.7
					else if(!prob(Hit_Chance)||prob(20*A.Blocking))
						if(prob(10)) ShockwaveScale(A,Belongs_To.BP)
						Damage = Damage * 0.7
					/*if(A.KOd)
						A.Life-=Life_Decrease
						if(A.Life<=0)
							if(A.Regenerate) if(A.BP*125*A.Regenerate<Power)if(Belongs_To.Lethality)  A.Absorbed=1
							if(Belongs_To.Lethality) A.Death(Belongs_To)
							del(src)
							return FALSE*/
					if(A)
						if(isnum(A.Health)&&A.Health>=1)
							Explode(Belongs_To, Damage)
							A.TakeDamage(Belongs_To, Damage, "[src]","energy")
					//		return FALSE
						else if(isnum(A.Health)&&A.Health<=0)
							if(!A.KOd)
								A.KO(Belongs_To)
								return FALSE
							else
								if(!A.client)
									A.Death(Belongs_To)
									return FALSE
								else
									A.Life-=Life_Decrease
									if(A.Life<=0)
										if(A.Regenerate) if(A.BP*200*A.Regenerate<Power) if(Belongs_To.Lethality) A.Dead=1
										if(Belongs_To.Lethality) A.Death(Belongs_To)
										return FALSE
						if(CausesBurns&&prob(50)) A.BurnDamage(Belongs_To,"Smolder Burn",Damage*0.165)
						if(ChainTrigger) A.BleedDamage(src,"Echoing Slash Bleed",Damage*0.5)
						if(Slowing)if(A) Slow(A,5,Slowing)
						if(IceGrips) A.GripOfIce()
						if(Paralysis) if(A) Stun(A,Paralysis)
						if(Stagger) if(A)
							A.Flight_Land()
							Stagger(A,Stagger)
						if(A&&src&&A.dir==dir&&A.KOd&&locate(/BodyPart/Tail) in A)
							for(var/BodyPart/Tail/T in A)
								A.overlays-=T
								del(T)
							view(A)<<"[A]'s tail is blasted off!"
							A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] 's tail is blasted off!\n")
							A.Tail_Remove()
							A.Critical_Tail = 1
							for(var/BodyPart/Tail/T in A)
								T.Health=0
								T.Status="Missing"
						if(prob(Shockwave*50)) A.Shockwave_Knockback(Shockwave,Belongs_To.loc)
				else
					dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
					if(A.client) flick("Attack",A)
					loc=A.loc
					src.HeatSeeking=0
					walk(src,dir)
					A.CombatOut("You deflected [Belongs_To]'s [src]!")
					Belongs_To.CombatOut("[A] deflected [src]!")
					return FALSE
				if(!Piercer) del(src)
			..()
