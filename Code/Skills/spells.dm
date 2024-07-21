
turf
	proc
		Explosion(var/mob/M)
			for(var/turf/A in range(6,src))
				ExplosionEffect(A)
				spawn(1)
					for(var/mob/B in A)
						if(B.icon_state == "Flight") if(prob(50))
							view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
							B.Flight_Land()
						if(!B.Flying)
							B.TakeDamage(src, 30*(M.Pow/B.End)*(M.BP/B.BP), "Explosion")
							//B.Health-=30*(M.Pow/B.Res)*(M.BP/B.BP)
							if(B.Health<=0)
								if(B.client) spawn B.KO("[M]")
								else spawn B.Death("[M]")
					for(var/obj/B in A)
						B.TakeDamage(src, M.Pow*5, "Explosion")
						//B.Health-=M.Pow*5
						if(B.Health<=0)
							if(prob(50)) Crater(B)
							del(B)
					if(!A.density)
						A.Health=0
						if(M!=0) A.Destroy(M,M.key)
						else A.Destroy("Unknown","Unknown")
					else
						A.TakeDamage(src, M.Pow*5, "Explosion")
						//A.Health -= M.Pow*5
						if(M!=0) A.Destroy(M,M.key)
						else A.Destroy("Unknown","Unknown")
mob
	proc
		Equip_Magic(var/obj/items/I,var/State,var/Ver)
			if(I) if(istype(I,/obj/items))
				var/N = 1
				if(I.magical) if(State == "Add")
					src << "This item empowers your stats."
					src.overlays -= 'tk.dmi'
					src.overlays += 'tk.dmi'
					src.Remove_Effects()
				if(I.add_bp)
					N = N + I.add_bp
					if(State == "Add")
						src.BPMult *= N
					if(State == "Remove")
						src.BPMult /= N
					if(!Ver)
						N = 1
				if(I.add_energy)
					N = N + I.add_energy
					if(State == "Add")
						src.KiMult *= N
					if(State == "Remove")
						src.KiMult /= N
						if(src.Ki > src.MaxKi)
							src.Ki = src.MaxKi
					if(!Ver)
						N = 1
				if(I.add_str)
					N = N + I.add_str
					if(State == "Add")
						src.StrMult *= N
					if(State == "Remove")
						src.StrMult /= N
					if(!Ver)
						N = 1
				if(I.add_end)
					N = N + I.add_end
					if(State == "Add")
						src.EndMult *= N
					if(State == "Remove")
						src.EndMult /= N
					if(!Ver)
						N = 1
				if(I.add_spd)
					N = N + I.add_spd
					if(State == "Add")
						src.SpdMult *= N
					if(State == "Remove")
						src.SpdMult /= N
					if(!Ver)
						N = 1
				if(I.add_force)
					N = N + I.add_force
					if(State == "Add")
						src.PowMult *= N
					if(State == "Remove")
						src.PowMult /= N
					if(!Ver)
						N = 1
				if(I.add_off)
					N = N + I.add_off
					if(State == "Add")
						src.OffMult *= N
					if(State == "Remove")
						src.OffMult /= N
					if(!Ver)
						N = 1
				if(I.add_def)
					N = N + I.add_def
					if(State == "Add")
						src.DefMult *= N
					if(State == "Remove")
						src.DefMult /= N
					if(!Ver)
						N = 1
				if(I.add_regen)
					N = N + I.add_regen
					if(State == "Add")
						src.RegenMult *= N
					if(State == "Remove")
						src.RegenMult /= N
					if(!Ver)
						N = 1
				if(I.add_recov)
					N = N + I.add_recov
					if(State == "Add")
						src.RecovMult *= N
					if(State == "Remove")
						src.RecovMult /= N
					if(!Ver)
						N = 1
		Display_Magic(var/obj/items/I)
			if(I) if(istype(I,/obj/items))
				var/returner
				if(I.add_bp)returner="[returner] <br>Power increase of [I.add_bp*100]%"
				if(I.add_energy)returner="[returner] <br>Energy increase of [I.add_energy*100]%"
				if(I.add_str)returner="[returner] <br>Strength increase of [I.add_str*100]%"
				if(I.add_end)returner="[returner] <br>Durability increase of [I.add_end*100]%"
				if(I.add_spd)returner="[returner] <br>Speed increase of [I.add_spd*100]%"
				if(I.add_force)returner="[returner] <br>Force increase of [I.add_force*100]%"
				if(I.add_off)returner="[returner] <br>Offense increase of [I.add_off*100]%."
				if(I.add_def)returner="[returner] <br>Defense increase of [I.add_def*100]%"
				if(I.add_regen)returner="[returner] <br>Regeneration increase of [I.add_regen*100]%"
				if(I.add_recov)returner="[returner] <br>Recovery increase of [I.add_recov*100]%"
				if(istype(I,/obj/items/fishingpole))
					if(I.autosmelt)returner="[returner] <br>Auto-Cook speed of [I.autosmelt*100]%"
				if(istype(I,/obj/items/pickaxe))
					if(I.autosmelt)returner="[returner] <br>Auto-Smelt speed of [I.autosmelt*100]%"
				return returner

atom
	MouseDrag(var/obj/Over_Object,var/turf/Turf_Start,var/obj/Over_Loc)
		var/Actual = 3
		var/can_use = 0
		var/using = null
		var/Logit = 0
		for(var/X in NoMove)
			if(src.type == X)
				return
		if(usr.attacking!=1)
			for(var/obj/Telekinesis_Magic in usr)
				if(usr.TK_Magic)
					Actual = 25
					Actual = round(initial(Actual)/usr.Magic_Potential)
					for(var/obj/Mana/X in usr)
						if(X.Value >= Actual)
							can_use = 1
							using = "mana"
							X.Value -= Actual
							if(ismob(src))
								var/mob/M = src
								if(usr.TK_Last != "[M.real_name] ([M.key])")
									usr.TK_Last = "[M.real_name] ([M.key])"
									Logit = 1
							else
								if(usr.TK_Last != "[src]")
									usr.TK_Last = "[src]"
									Logit = 1
			for(var/obj/Telekinesis in usr)
				if(usr.TK) if(can_use == 0)
					if(usr.Ki >= Actual)
						can_use = 1
						using = "energy"
						usr.DrainKi("Telekinesis", 1, Actual,show=1)//usr.DrainKi("Telekinesis","Percent",Actual)
						if(ismob(src))
							var/mob/M = src
							if(usr.TK_Last != "[M.real_name] ([M.key])")
								usr.TK_Last = "[M.real_name] ([M.key])"
								Logit = 1
						else
							if(usr.TK_Last != "[src]")
								usr.TK_Last = "[src]"
								Logit = 1
			if(src in range(20,usr)) if(can_use) if(usr.KOd==0) if(usr.afk == 0)
				if(ismob(src))
					var/mob/M = src
					var/moves = 25
					if(M.afk == 0) if(!usr.invisibility)
						if(using == "mana")
							moves += usr.Magic_Level
							moves -= M.Magic_Level
						if(using == "energy")
							moves += usr.MaxKi / 100
							moves -= M.MaxKi / 100
						if(prob(moves))
							if(using == "mana")
								M.overlays -= 'fx dispel.dmi'
								M.overlays += 'fx dispel.dmi'
								usr.overlays -= 'fx dispel.dmi'
								usr.overlays += 'fx dispel.dmi'
							if(using == "energy")
								M.overlays -= 'tk.dmi'
								M.overlays += 'tk.dmi'
								usr.overlays -='tk.dmi'
								usr.overlays += 'tk.dmi'
							usr.Remove_Effects()
							spawn(10)
								if(M)
									M.overlays -= 'tk.dmi'
									M.overlays -= 'fx dispel.dmi'
							if(M in view(1,Over_Loc))
								for(var/atom/A in Over_Loc)
									if(A.density)
										return
								M.Move(Over_Loc)
								Stagger(M,1)
								if(Logit) usr.saveToLog("| [key_name(usr)] moves [src] with their [using] based Telekinesis..\n")
				if(isobj(src)&&!istype(src,/obj/ranged/))
					var/obj/O = src
					if(!O.Bolted) if(Over_Loc)
						if(using == "energy")
							usr.overlays -= 'tk.dmi'
							usr.overlays += 'tk.dmi'
							O.overlays -= 'tk.dmi'
							O.overlays += 'tk.dmi'
						if(using == "mana")
							usr.overlays -= 'fx dispel.dmi'
							usr.overlays += 'fx dispel.dmi'
							O.overlays -= 'fx dispel.dmi'
							O.overlays += 'fx dispel.dmi'
						usr.Remove_Effects()
						spawn(10)
							if(O)
								O.overlays -= 'tk.dmi'
								O.overlays -= 'fx dispel.dmi'
						if(!usr.invisibility)
							if(istype(O,/obj/Props/))
								var/obj/Props/P = src
								P.Slinger = "[usr]"
								P.Slinger_Key = "[key_name(usr)]"
							if(using == "mana")
								O.Projectile_Speed = usr.Magic_Level
							if(using == "energy")
								O.Projectile_Speed = usr.MaxKi / 100
						if(O in view(1,Over_Loc))
							for(var/atom/A in Over_Loc)
								if(A.density)
									O.Bump(A)
									return
							O.Move(Over_Loc)
							if(Logit)usr.saveToLog("| [key_name(usr)] moves [src] with their [using] based Telekinesis..\n")

			if(using == "mana") if(can_use == 0)
				usr << "Not enough mana!"
			if(using == "energy") if(can_use == 0)
				usr << "Not enough energy!"
mob
	proc
		Remove_Effects()
			spawn(10)
				if(src)
					src.overlays -= 'fx dispel.dmi'
					src.overlays -= 'tk.dmi'

Skill/Spell
	Experience=100
	Earth_Prison
		CDOverride=240
		desc="This will create a large barrier 5 tiles away from you to trap in your enemies."
		verb/Earth_Prison()
			set category = "Skills"
			if(usr.RPMode) return
			if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 55)
				var/Cost = 1500000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi("Earth Prison", "Percent", 25)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						var/startx=usr.x-5
						var/starty=usr.y-5
						var/endx=usr.x+5
						var/endy=usr.y+5
						if(startx<1) startx=1
						if(starty<1) starty=1
						if(endx>world.maxx) endx=world.maxx
						if(endy>world.maxy) endy=world.maxy
						var/placer=startx
						var/placery=starty
						spawn()
							while(placery<endy+1)
								//if(startx>=placer&&placer<=endx)
								if(placery==starty)
									var/turf/C=new /obj/Blocker/EarthPrison(locate(placer,placery,usr.z))
									C.Builder="[usr.real_name]"
									C.Health=(usr.Magic_Level**3)*500
									spawn(12*usr.Magic_Level) del(C)
								else if(placer==startx||placer==endx)
									var/turf/C=new /obj/Blocker/EarthPrison(locate(placer,placery,usr.z))
									C.Builder="[usr.real_name]"
									C.Health=(usr.Magic_Level**3)*500
									spawn(12*usr.Magic_Level) del(C)
								else if(placery==endy)
									var/turf/C=new /obj/Blocker/EarthPrison(locate(placer,placery,usr.z))
									C.Builder="[usr.real_name]"
									C.Health=(usr.Magic_Level**3)*500
									spawn(12*usr.Magic_Level) del(C)
								if(placer>=endx)
									placer=startx
									placery++
								else
									if(placery>starty&&placery<endy) placer=endx
									else placer++
								sleep(0)
						CDTick(usr)
						M.Value -= Actual
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to cast Earth Prison")
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Earth Prison spell."
						return

	Empowered_Attacks
		CDOverride=60
		desc="This will cause all team mates within 5 tiles to receive empowered attacks for 15 seconds. (70% chance to occur, Fire deals burn damage, Wind grants homing charges and chance for lightning bolt, Ice slows and chance for stagger movement)"
		/*icon='Flaming_Purple_fists.dmi'
		New()
			..()
			icon+=rgb(rand(0,75),rand(0,75),rand(0,75))*/
		verb/Empower_Attacks()
			set category="Skills"
			if(usr.RPMode) return
			if(usr.KOd) return
			if(!usr.CanAttack(1,src)) return
			var/Cost = 2000000
			var/Actual = round(initial(Cost)/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets)))
			usr << "Base cost for this skill is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
			for(var/obj/Mana/M in usr)
				if(M.Value > Actual)
					M.Value-=Actual
					CDTick(usr)
					for(var/mob/A in view(usr,5)) if(A.Team==usr.Team)
						A.Element=pick("Fire","Wind","Ice")
						A.ElementTicks=13
						A.overlays+=/Icon_Obj/Customization/Auras/Sparkles
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses Empowered Attacks on [A]")
				else
					usr << "You do not have [Commas(Actual)] mana to spare in order to use the Empowered Attacks."
					return

	Empowered_Defenses
		CDOverride=60
		desc="This will cause all team mates within 5 tiles to receive empowered defense for 30 seconds. (+50% BP on defensive calculations.)"
		/*icon='Flaming_Purple_fists.dmi'
		New()
			..()
			icon+=rgb(rand(0,75),rand(0,75),rand(0,75))*/
		verb/Empowered_Defenses()
			set category="Skills"
			if(usr.RPMode) return
			if(usr.KOd) return
			if(!usr.CanAttack(1,src)) return
			var/Cost = 1500000
			var/Actual = round(initial(Cost)/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets)))
			usr << "Base cost for this skill is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
			for(var/obj/Mana/M in usr)
				if(M.Value > Actual)
					M.Value-=Actual
					CDTick(usr)
					for(var/mob/A in view(usr,5)) if(A.Team==usr.Team)
						A.EmpoweredDefenseTicks=25
						A.overlays+=/Icon_Obj/Customization/Auras/Sparkles
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses Empowered Defenses on [A]")
				else
					usr << "You do not have [Commas(Actual)] mana to spare in order to use the Empowered Defenses."
					return

	Frost_Nova
		CDOverride=45
		desc="This will emit a freezing aura around you that slows all enemies and damages them."
		verb/Frost_Nova()
			set category = "Skills"
			if(usr.RPMode) return
			if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 55)
				var/Cost = 800000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.DrainKi(src, 1, 200,show=1)//usr.DrainKi("Frost Nova", "Percent", 20)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						for(var/turf/T in orange(usr,2))
							T.overlays+='Ice Icon.dmi'
							spawn(30) T.overlays-='Ice Icon.dmi'
						for(var/mob/A in orange(usr,2))
							if(A!=usr) if(!A.afk)
								var/DamageDealt=(usr.BP*(1+(usr.Magic_Potential*2))/A.BP)
								M.TakeDamage(usr, DamageDealt, "Frost Nova")
								if(A.Health<=0) A.KO(usr)
							//Freeze effects
								Slow(A,5,20)//Stagger(A,5)
							M.Value -= Actual
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to cast Frost Nova")
						CDTick(usr)
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Frost Nova spell."
						return

	Frost_Bolt
		Tier=3
		desc="This will fire a damaging ice blast that slows on hit and home towards your target."
		icon='Ice Blast.dmi'
		verb/Frost_Bolt()
			set category = "Skills"
			if(usr.RPMode) return
			if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 43)
				var/Cost = 400000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.DrainKi(src, 1, 50,show=1)//usr.DrainKi("Frost Bolt", "Percent", 5)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						var/obj/ranged/Blast/A=unpool("Blasts")
						A.Belongs_To=usr
						flick("Blast",usr)
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
						A.Power=GunBPAssign(usr.Magic_Level,usr.Magic_Potential)*Ki_Power			//200
						A.Damage=2.5*A.Power*SoftStatCap  //200
						A.Offense=usr.Off*1.2
						A.HeatSeeking=1
						A.Slowing=30
						A.dir=usr.dir
						A.loc=usr.loc
						walk(A,A.dir)
						A.name="Frost Bolt"
						M.Value -= Actual
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to cast Frost Bolt")
						CDTick(usr)
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Frost Bolt spell."
						return

	Fireball
		Tier=2
		desc="This will fire a damaging fire blast that burns on hit and home towards your target."
		icon='Fireball.dmi'
		verb/Fireball()
			set category = "Skills"
			if(usr.RPMode) return
			if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 53)
				var/Cost = 200000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.DrainKi(src, 1, 50,show=1)//usr.DrainKi("Fireball", "Percent", 5)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						var/obj/ranged/Blast/A=unpool("Blasts")
						A.Belongs_To=usr
						flick("Blast",usr)
						A.pixel_x=pixel_x
						A.pixel_y=pixel_y
						A.pixel_x+=rand(-16,16)
						A.pixel_y+=rand(-16,16)
						A.icon=icon
						A.name="Fireball"
						var/MaskDamage=0
						if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
							MaskDamage=MM.Health
							MM.DurabilityCheck(usr)
							break
						if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
						A.Power=GunBPAssign(usr.Magic_Level,usr.Magic_Potential)*Ki_Power			//200
						A.Damage=4*A.Power*SoftStatCap  //200
						A.Offense=usr.Off*1.2
						A.HeatSeeking=1
						A.CausesBurns=1
						A.dir=usr.dir
						A.loc=usr.loc
						walk(A,A.dir)
						M.Value -= Actual
						for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to cast Fireball")
						CDTick(usr)
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Fireball spell."
						return

	Lightning_Bolt
		Tier=3
		desc="This is a bolt of lightning."
		//var/Active=0
		var/tmp/CostOnUse=0
		var/Power=0
		verb/Lightning_Bolt()
			set category = "Skills"
			if(usr.RPMode) return
			if(CostOnUse)
				usr << "You are no longer casting this spell."
				CostOnUse=0
				Power=0
				return
			if(usr.Magic_Level >= 25)
				//var/Y = (Year/10) + 1
				var/Cost = 500000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				var/PowerC = usr.BP*usr.Magic_Potential*rand(1,3)
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				CostOnUse = Actual
				Power = PowerC
				for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=teal>[usr] begins to conjure a spell.")
				return

	Enchant
		desc="Allows you to enchant certain equipment to give stat bonuses. (Up to +3% in a single stat, 0.6% per enchant and 15 enchants total (25 enchants with Enchant Master)"
		verb/Enchant()
			set category = "Other"
			if(usr.RPMode) return
			if(usr.Magic_Level >= 40)
				var/Cost = 50000000
				var/Actual = round(initial(Cost)/usr.Magic_Potential/(1+usr.HasEnchantMaster))*(1-(0.15*usr.HasDeepPockets))
				switch(input("Do you want to enchant a sword, hammer, guantlets, helmet, armor piece, fishing rod, or pickaxe? The base cost is [Commas(Cost)] mana. For you it will cost [Commas(Actual)] mana.") in list("No","Yes"))
					if("Yes")
						for(var/obj/Mana/M in usr)
							if(M.Value > Actual)
								var/obj/items/X
								var/N = input(usr, "How many times do you want to enchant an item?") as num
								if(N <= 0) return
								if(N >= 5) N = 5
								for(var/obj/items/I in get_step(usr,usr.dir))
									if(I.magical)
										switch(input("Are you sure you want to enchant [I]?") in list("No","Yes"))
											if("Yes") X = I
								if(!X)
									for(var/obj/items/Sword/S in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [S]?") in list("No","Yes"))
											if("Yes") X = S
								if(!X)
									for(var/obj/items/Armor/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/Gauntlets/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/Helmet/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/Hammer/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/fishingpole/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(!X)
									for(var/obj/items/pickaxe/A in get_step(usr,usr.dir))
										switch(input("Are you sure you want to enchant [A]?") in list("No","Yes"))
											if("Yes") X = A
								if(X)
									if(X.TotalEnchants>=25)
										usr<<"This is already maxed for your current abilities."
										return
									if(!usr.HasEnchantMaster&&X.TotalEnchants>=15)
										usr<<"This is already maxed for your current abilities."
										return
									if((istype(X,/obj/items/fishingpole)||istype(X,/obj/items/pickaxe))&&X.TotalEnchants>=10)
										usr<<"This is already maxed for your current abilities."
										return
									if((istype(X,/obj/items/fishingpole)||istype(X,/obj/items/pickaxe))&&!usr.HasEnchantMaster&&X.TotalEnchants>=5)
										usr<<"This is already maxed for your current abilities."
										return
									if(istype(X,/obj/items/fishingpole))
										switch(input("It will cost [Commas(Actual)] mana for you to enchant [X] and grant it auto-cooking. Multiple levels reduces the additional time added to fishing speed by 5%.") in list("Confirm","Cancel"))
											if("Cancel")
												return
											if("Confirm")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.autosmelt != 0.5 && X.TotalEnchants != 5+(5*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.autosmelt += 0.05
																if(X.autosmelt >= 0.5) X.autosmelt = 0.5
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.autosmelt*100]% auto-cooking."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.autosmelt*100]% auto-cooking."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.autosmelt*100]% auto-cooking."
															N = 0
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +5% auto-cooking [Num - N] times.\n")
													return
									else if(istype(X,/obj/items/pickaxe))
										switch(input("It will cost [Commas(Actual)] mana for you to enchant [X] and grant it auto-smelting. Multiple levels reduces the additional time added to mining speed by 5%.") in list("Confirm","Cancel"))
											if("Cancel")
												return
											if("Confirm")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.autosmelt != 0.5 && X.TotalEnchants != 5+(5*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.autosmelt += 0.05
																if(X.autosmelt >= 0.5) X.autosmelt = 0.5
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.autosmelt*100]% auto-smelting."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.autosmelt*100]% auto-smelting."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.autosmelt*100]% auto-smelting."
															N = 0
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +5% auto-smelting [Num - N] times.\n")
													return
									else
										switch(input("It will cost [Commas(Actual)] mana for you to enchant [X] and grant it +0.6% in the chosen stat when equipped. Please choose a stat to enhance, up to a max of +3%.") in list("Strength","Durability","Speed","Force","Offense","Defense","Cancel"))
											if("Cancel")
												return
											if("Strength")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.add_str != 0.03 && X.TotalEnchants != 15+(10*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.add_str += 0.006
																if(X.add_str >= 0.03) X.add_str = 0.03
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.add_str*100]% strength."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_str*100]% strength."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_str*100]% strength."
															N = 0
													//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% strength [Num - N] times.")
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% strength [Num - N] times.\n")
													return
											if("Durability")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.add_end != 0.03 && X.TotalEnchants != 15+(10*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.add_end += 0.006
																if(X.add_end >= 0.03)
																	X.add_end = 0.03
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.add_end*100]% durability."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_end*100]% durability."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_end*100]% durability."
															N = 0
													//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% durability [Num - N] times.")
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% durability [Num - N] times.\n")
													return
											if("Force")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.add_force != 0.03 && X.TotalEnchants != 15+(10*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.add_force += 0.006
																if(X.add_force >= 0.03)
																	X.add_force = 0.03
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.add_force*100]% force."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_force*100]% force."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_force*100]% force."
															N = 0
													//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% force [Num - N] times.")
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% force [Num - N] times.\n")
													return
											if("Speed")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.add_spd != 0.03 && X.TotalEnchants != 15+(10*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.add_spd += 0.006
																if(X.add_spd >= 0.03)
																	X.add_spd = 0.03
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.add_spd*100]% speed."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_spd*100]% speed."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_spd*100]% speed."
															N = 0
													//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% speed [Num - N] times.")
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% speed [Num - N] times.\n")
													return
											if("Offense")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.add_off != 0.03 && X.TotalEnchants != 15+(10*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.add_off += 0.006
																if(X.add_off >= 0.03)
																	X.add_off = 0.03
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.add_off*100]% offence."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_off*100]% offense."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_off*100]% offense."
															N = 0
													//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% offense [Num - N] times.")
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% offense [Num - N] times.\n")
													return
											if("Defense")
												if(isturf(X.loc))
													var/Num = N
													while(N)
														if(X.add_def != 0.03 && X.TotalEnchants != 15+(10*usr.HasEnchantMaster))
															if(M.Value >= Actual)
																M.Value -= Actual
																X.add_def += 0.006
																if(X.add_def >= 0.03)
																	X.add_def = 0.03
																X.magical = 1
																X.cost += Actual
																X.TotalEnchants++
																usr << "Enchantment applied. Total +[X.add_def*100]% defence."
																N -= 1
															else
																usr << "[Num - N] enchants were added before you ran out of available mana. It will grant +[X.add_def*100]% defense."
																N = 0
														else
															usr << "[Num - N] enchantments applied. The item can not be improved now beyond its current enchantments. It will currently grant +[X.add_def*100]% defense."
															N = 0
													//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.1% defense [Num - N] times.")
													usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchanted [X] with +0.6% defense [Num - N] times.\n")
													return
							else
								usr << "Not enough mana! You need [Commas(Actual)]"
								return

	Create_Portal
		CDOverride=7200
		desc="Allows you to create a portal to another realm..."
		var/PortalID=0
		verb/Create_Portal()
			set category = "Other"
			if(usr.RPMode) return
			if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 55)
				if(SpaceTravel == 0)
					usr << "This realm doesn't support the creation of portals."
					return
				var/Cost = 100000000
				if(PortalID!=0)Cost/=10
				for(var/obj/Magical_Portal/P in range(4,usr))
					usr << "This is too close to another portal."
					return
				var/list/Options= list("Personal Realm")
				if(usr.Magic_Level>=80) Options.Add("Location")
				Options.Add("Cancel")
				switch(input("Do you want to create/revisit your personal realm or travel to a location? (Personal Realm is 10% of the normal cost after the first cast)") in Options)
					if("Personal Realm")
						if(usr.z==17||usr.z==13||usr.z==11)
							usr<<"You may not create a realm here."
							return
						var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
						usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
						switch(input("Are you very sure?") in list("No","Yes"))
							if("Yes")
								for(var/obj/Mana/M in usr)
									if(M.Value > Actual)
										if(PortalID==0)
											if(Portals)
												var/PID = pick(Portals)
												PortalID = PID
												Portals -= PID
										M.Value -= Actual
										var/obj/Magical_Portal/P = new
										P.loc = usr.loc
										P.Savable=1
										P.Portal_Number = PortalID
										P.Builder="[usr.real_name]"
										view(usr)<<"<font color=teal>[usr] uses their magic to create a portal!"
										usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a new magical realm.\n")
										var/turf/T = usr.loc
										T.Wave(5,100)
										//CDTick(usr)
										return
									else
										usr << "You do not have [Commas(Actual)] mana to spare in order to use create a new magical realm."
										return
							if("No")
								return
					if("Location")
//						Cost = 100000000
						var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
						usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
						alert(usr,"Choose the X,Y,Z of the location you want to travel to. Keep in mind that different dimensions from the one you create the portal on cost more to travel to. These portals only last 15 minutes real time before they shut.")
						var/x = input(usr,"x coordinate") as num
						var/y = input(usr,"y coordinate") as num
						var/z = input(usr,"z coordinate") as num
						if(!usr.Confirm("Create portal to [x] [y] [z]?")) return

						var/restricted = list(9,13,16,17)
						var/al = list(8,10,11)
						var/lr = list(1,2,3,4,5,6,7,12,14,15)
						var/travel_al = 0
						if(z in al) travel_al = 1
						if(z in restricted)
							usr << "Unable to teleport to that z coordinate, please choose another!"
							return
						if(usr.z in al) if(travel_al == 0) //if(!RealmTeleport)
							usr << "You're unable to pierce the veil between realms!"
							return
						if(usr.z in lr) if(travel_al) //if(!RealmTeleport)
							usr << "You're unable to pierce the veil between realms!"
							return
						if(usr.z in restricted)
							usr << "Unable to teleport from this z coordinate!"
							return
						var/turf/location = locate(x,y,z)
						for(var/obj/Magical_Portal/P in range(4,location))
							usr << "The destination is too close to another portal."
							return
						for(var/obj/Mana/M in usr)
							if(M.Value > Actual)
								M.Value -= Actual
								var/obj/Magical_Portal/P = new
								P.tag = "Special"
								P.loc = usr.loc
								P.Portal_Number = rand(100000,1000000)
								var/turf/T = usr.loc
								if(T) T.Wave(5,100)
								var/obj/Magical_Portal/P2 = new
								P2.tag = "Special"
								P2.loc = locate(x,y,z)
								P2.Portal_Number = P.Portal_Number
								var/turf/T2 = P2.loc
								if(T2) T2.Wave(5,100)
								//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a portal to [x],[y],[z]...")
								usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] created a portal to [x],[y],[z]...\n")
								alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name_admin(usr)] created a portal to [x],[y],[z].", 1)
								CDTick(usr)
								return
					if("Cancel") return

	Rejuvenate
		CDOverride=60
		desc="Heals someone and removes 25 minutes of their Lethal Combat Tracker."
		verb/Rejuvenate()
			set category = "Skills"
			if(usr.RPMode) return
			if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 5)
				var/Cost = 400000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi("Rejuvenate", "Percent", 15)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
							if(A.Willpower<=0) A.WillpowerRestore()
							if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower++
							if(A.KOd) A.Un_KO()
							A.Health += 25
							A.LethalCombatTracker-=1000
							if(A.LethalCombatTracker<0)A.LethalCombatTracker=0
							if(A.Health>A.Willpower) A.Health=A.Willpower
							for(var/BodyPart/P in A)
								if(usr.Magic_Level>70)  if(P.Health<=P.MaxHealth) A.Injure_Heal(25,P,1)
								else  if(P.Health<=P.MaxHealth) A.Injure_Heal(20,P)
							A.Heal_Zenkai()
							M.Value -= Actual
							CDTick(usr)
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to heal [A]")
							//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)]")
							usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)].\n")
							A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was spell healed by [key_name(usr)].\n")
							break
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Heal spell."
						return


	Accelerate
		CDOverride=60
		desc="Grants someone the speed buff, which negates slows and increases hit chance and movement speed."
		verb/Accelerate()
			set category = "Skills"
			if(usr.RPMode) return
			if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 5)
				var/Cost = 1000000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
				usr.DrainKi(src, 1, 150,show=1)//usr.DrainKi("Accelerate", "Percent", 15)
				for(var/obj/Mana/M in usr)
					if(M.Value > Actual)
						for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
							Acceleration(A,usr.Magic_Potential*5,10*usr.Magic_Potential)
							CDTick(usr)
							for(var/mob/player/teleg in view(usr)) teleg.CombatOut("<font color=#FFFF00>[usr] uses their magic to accelerate [A]")
							//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] spell healed [key_name(A)]")
							usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] accelerated [key_name(A)].\n")
							A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was accelerated by [key_name(usr)].\n")
							break
					else
						usr << "You do not have [Commas(Actual)] mana to spare in order to use the Accelerate spell."
						return
						