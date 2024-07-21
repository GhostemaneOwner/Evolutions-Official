

Icon_Obj/Effects/After_Image
	/*unpooled()
		..()
		filters += filter(type = "blur", size = 0)
		animate(filters[filters.len], size = 1.5, time = 10)
		animate(src,alpha=0,time=10)*/
		//spawn(9) flick(src.CustomZanzokenIcon,src)


mob/proc
	AfterImage(var/State)
		flick(src.CustomZanzokenIcon,src)
		var/Icon_Obj/Effects/After_Image/P = unpool("AfterImage")
		P.appearance=appearance
		P.overlays-=EnergyBar
		P.overlays-=HealthBar
		P.pixel_x=pixel_x
		P.pixel_y=pixel_y
		P.pixel_z=pixel_z
		P.loc=loc
		P.dir=dir
		P.icon_state=icon_state
		animate(P,alpha=0,time=12)
		P.filters += filter(type = "blur", size = 0)
		animate(P.filters[P.filters.len], size = 1.5, time = 12)
		if(State=="Dash Attack")
			P.pixel_x+=rand(-8,8)
			P.pixel_y+=rand(-8,8)
			P.pixel_z+=rand(-8,8)
		spawn(12) pool("AfterImage",P)



mob/var/tmp/LBCD=0
turf/Click(turf/T)
	if(!istype(T, /turf/))
		return 0
	var/HasIT=0
	if(usr.SplitFollowsMouse)
		for(var/mob/Splitform/B in view(usr,25)) if(B.lastKnownKey==usr.key)  B.DoChoice("Click Target",T)
		for(var/mob/Drone/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",T)
		for(var/mob/Doll/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",T)
	if(locate(/Skill/Support/InstantTransmission) in usr) HasIT=1
	if(usr.HasEnergyMovement) HasIT=1
	if(usr.move&&!usr.KB&&usr.KOd==0&&usr.icon_state!="Meditate"&&usr.icon_state!="Train")if(!usr.attacking||HasIT)
		if(usr.client.eye!=usr) return
		if(locate(usr) in src) return
		if(!usr.RPMode) for(var/Skill/Spell/Lightning_Bolt/LB in usr) if(usr.CanAttack(50,LB)) if(usr.getCooldown("[LB]")<world.time) if(LB.CostOnUse) /*if(usr.Spell_CD == 0)*/
			for(var/obj/Mana/M in usr)
				if(M.Value >= LB.CostOnUse)
					M.Value -= LB.CostOnUse
					usr.DrainKi("Lightning Bolt", 1, 50,show=1)//usr.DrainKi("Lightning Bolt", "Percent", 5)
					LB.CDTick(usr)
					var/obj/Lightning_Strike/S = new
					S.loc = locate(T.x,T.y + 3,T.z)
					S.Power = LB.Power
					S.Dest = T
					return
					break
				else
					usr << "You do not have enough mana to continue using this spell."
					LB.CostOnUse=0
			return
		for(var/Skill/Attacks/BlueCometSpecial/K in usr) if(usr.CanAttack(50,K))if(K.On&&!K.Blue_Comet_Special&&!usr.RPMode&&usr.getCooldown("[K]")<world.time) if(usr.Target)
			if(usr.Ki>=500) if(usr.Target.z==usr.z)
				usr.attacking=3
				K.Blue_Comet_Special=1
				K.On = 0
				if(K.Experience<100)
					K.Experience+=rand(5,9)
					if(K.Experience>100) K.Experience=100
				usr.DrainKi("Blue Comet Special", 1, 200,show=1)//usr.DrainKi("Blue Comet Special","Percent",30)
				K.CDTick(usr)
				var/amount=K.Level
				var/list/spawnArea = oview(T,3)
				spawn()
					while(!usr.KOd&&amount>0)
						amount-=1
						flick(usr.CustomZanzokenIcon,usr)
						var/obj/ranged/Blast/A=unpool("BCS")
						A.density=0
						A.Belongs_To=usr
						A.pixel_x=usr.pixel_x
						A.pixel_y=usr.pixel_y
						A.icon=usr.icon
						A.overlays=usr.overlays
						A.underlays=usr.underlays
						A.icon+=rgb(0,0,0,155)
						A.overlays+=rgb(0,0,0,155)
						A.name="Blue Comet Special"
						var/spawnSpot=pick(spawnArea)
						A.loc=spawnSpot
						spawnArea-=spawnSpot
						A.dir=usr.dir
						if(prob(5*(Experience/20))) A.Explosive=1
						A.Shockwave=1
						A.Damage=usr.BP*usr.Spd*Ki_Power*7
						A.Power=(usr.BP)*Ki_Power
						A.Offense=usr.Off*2
						spawn(rand(2,5))
							if(A)
								A.density=1
								walk_towards(A,usr.Target,1)
						sleep(1)
				spawn(usr.Refire)
					K.Blue_Comet_Special=0
					usr.attacking=0
				return
		for(var/Skill/Attacks/Explosion/K in usr) if(K.On&&!K.Using_Explosion) if(!usr.RPMode)if(usr.CanAttack(50,K))
			if(usr.Ki>=50)
				K.CDTick(usr)
				usr.attacking=3
				K.Using_Explosion=1
				//K.On = 0
				spawn(usr.Refire*2)
					if(usr)
						usr.attacking=0
						K.Using_Explosion=0
				if(K.Experience<100)
					if(K.Level == K.Experience) K.Level++
					K.Experience+=rand(5,9)
					if(K.Experience>100) K.Experience=100
//				ExplosionCEffect(T)
				ExplosionEffect(T)
				if(Level>4)Crater(T)
				else SmallCrater(T)
				var/exprange = range(K.Level,T)
				for(var/turf/A in exprange) if(prob(95))
					for(var/atom/X in A)
						if(X.Flammable)
							X.Burning = 1
							X.Burn(X.Health)
					for(var/mob/B in A) if(!B.afk&&!B.RPMode)
						var/didShield=0
						for(var/obj/items/Force_Field/S in B) if(S.Level>0)
							S.Level = max(0, (S.Level - 1000*((usr.Pow/B.End)*(usr.BP/B.BP)*Ki_Power))) // damage
							S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
							didShield=1
						var/Mult=1
						if(B.Shielding||didShield) Mult=0.7
						/*if(prob(25))
							var/BodyPart/Ears/L =locate(/BodyPart/Ears) in B
							B.Injure_Hurt(30,L,"Explosion ([usr])")*/
						if(B.icon_state == "Flight") if(prob(25))
							view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
							B.Flight_Land()
						if(!B.Flying)
							B.TakeDamage(usr, 7.5*((usr.Pow/B.End)*(usr.BP/B.BP)*Mult*Ki_Power), "Explosion")
					for(var/obj/B in A)
						B.TakeDamage(usr, usr.Pow*5, "Attack")
						//B.Health-=usr.Pow*5
						if(B.Health<=0)
							SmallCrater(B)
							del(B)
					ExplosionEffect(A)
					if(usr.HasSmolder) new/obj/Hazard/Burning_Embers(A)
					/*if(!A.density)
						A.Health=0
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")
					else
						A.TakeDamage(usr, usr.Pow*5, "Explosion")
						//A.Health -= usr.Pow*5
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")*/
					if(prob(20)) sleep(1)
				usr.DrainKi("Explosion", 1, 100,show=1)//usr.DrainKi("Explosion","Percent",5)//usr.Ki -= 50




			else
				usr<<"You do not have enough energy."
			return
		if(locate(/obj/Door) in T) return
		for(var/Skill/Support/InstantTransmission/A in usr) if(A.Experience>=25&&A.Zon)
			if(!T.density) if(usr && usr.client.eye==usr) if(usr.KOd==0)
				usr.Ki*=0.998
				if(!T.density&&!T.Water)
					flick(usr.CustomZanzokenIcon,usr)
					usr.loc=locate(x,y,z)
					return
		for(var/Skill/Zanzoken/A in usr)
			for(var/Skill/Attacks/AA in usr) if(AA.charging||AA.streaming||AA.Using) return 0
			if(usr.RPMode) return
			if(!A.Zon) return
			if(StunCheck(usr)) return
			if(usr.Frozen) return
			if(usr.S) return
			if(A.Charges<1) return
			if(usr.isGrabbing&&usr.Race!="Yardrat") return
			if(T.z!=usr.z) return
			if(usr.icon_state=="KB"||usr.KB) return
			if(T in view(15,usr))
				A.Charges--
				usr.CombatOut("[A.Charges] Zanzoken charges remain.([((usr.Refire*2)+5)/(1+usr.HasZanzokenMaster)] seconds per charge.)")
				spawn(((usr.Refire*2)+5)/ (1+usr.HasZanzokenMaster)) A.Charges++
				var/Drain = 50
				if(usr.HasZanzokenMaster) Drain*=0.05
				if(Drain > usr.MaxKi) Drain = usr.MaxKi
				if(!T.density && usr.Ki >= Drain)
					ZanzoDust(usr)
					//if(usr.Race=="Android") flick('Black Hole.dmi',usr)
					flick(usr.CustomZanzokenIcon,usr)
					var/turf/Can = get_step_to(usr,T,0)
					if(Can == null)
						usr << "You can't seem to reach there..."
						return
					if(isturf(Can))
						if(blankBlocked2(usr,Can))
							usr << "You can't seem to reach there..."
							return
						var/OldDir = usr.dir
						if(usr.Zanzoken>999) usr.AfterImage()
						usr.Move(T)
						usr.dir = OldDir
						usr.Zanzoken += 0.5*usr.ZanzoMod
						usr.DrainKi(A,1,Drain)//usr.Ki=max(0,usr.Ki-Drain)
					if(prob(10)) usr.BaseSpd+=0.01*usr.SpdMod*StatGain*usr.GravMulti*usr.CatchUp()*usr.StatCapCheck(usr.BaseSpd/usr.SpdMod)
				return
mob/Click()
	if(src==usr) if(usr.HasSSj4) if(usr.KOd==0) if(usr.Ki>usr.MaxKi*0.1) if(!usr.ssj) if(usr.Confirm("Go SSj4?")) if(usr.KOd==0) if(usr.Ki>usr.MaxKi*0.1) if(!usr.ssj) SSj4()
	if(usr.move&&!usr.KB&&usr.KOd==0&&usr.icon_state!="Meditate"&&usr.icon_state!="Train")if(!usr.attacking)
		if(usr.client.eye!=usr) return
		if(locate(usr) in src) return
		if(!usr.RPMode) for(var/Skill/Spell/Lightning_Bolt/LB in usr) if(usr.CanAttack(50,LB)) if(usr.getCooldown("[LB]")<world.time) if(LB.CostOnUse) /*if(usr.Spell_CD == 0)*/
			for(var/obj/Mana/M in usr)
				if(M.Value >= LB.CostOnUse)
					M.Value -= LB.CostOnUse
					usr.DrainKi("Lightning Bolt", 1, 50,show=1)//usr.DrainKi("Lightning Bolt", "Percent", 5)
					LB.CDTick(usr)
					var/obj/Lightning_Strike/S = new
					S.loc = locate(src.x,src.y + 3,src.z)
					S.Power = LB.Power
					S.Dest = src.loc
					return
					break
				else
					usr << "You do not have enough mana to continue using this spell."
					LB.CostOnUse=0
			return
		for(var/Skill/Attacks/BlueCometSpecial/K in usr) if(K.On&&!K.Blue_Comet_Special&&!usr.RPMode&&usr.getCooldown("[K]")<world.time) if(usr.Target)
			if(usr.Ki>=500) if(usr.Target.z==usr.z)
				usr.attacking=3
				K.Blue_Comet_Special=1
				K.On = 0
				if(K.Experience<100)
					K.Experience+=rand(5,9)
					if(K.Experience>100) K.Experience=100
				usr.DrainKi(src, 1, 200,show=1)//usr.DrainKi("Blue Comet Special","Percent",30)
				K.CDTick(usr)
				var/amount=K.Level
				var/list/spawnArea = oview(src,3)
				spawn()
					while(!usr.KOd&&amount>0)
						amount-=1
						flick(usr.CustomZanzokenIcon,usr)
						var/obj/ranged/Blast/A=unpool("BCS")
						A.density=0
						A.Belongs_To=usr
						A.pixel_x=usr.pixel_x
						A.pixel_y=usr.pixel_y
						A.icon=usr.icon
						A.overlays=usr.overlays
						A.underlays=usr.underlays
						A.icon+=rgb(0,0,0,155)
						A.overlays+=rgb(0,0,0,155)
						A.name="Blue Comet Special"
						var/spawnSpot=pick(spawnArea)
						A.loc=spawnSpot
						spawnArea-=spawnSpot
						A.dir=usr.dir
						if(prob(5*(Experience/20))) A.Explosive=1
						A.Shockwave=1
						A.Damage=usr.BP*usr.Spd*Ki_Power*7
						A.Power=(usr.BP)*Ki_Power
						A.Offense=usr.Off*2
						spawn(rand(2,5))
							if(A)
								A.density=1
								walk_towards(A,usr.Target,1)
						sleep(1)
				spawn(usr.Refire)
					K.Blue_Comet_Special=0
					usr.attacking=0
				return
		for(var/Skill/Attacks/Explosion/K in usr) if(K.On&&!K.Using_Explosion) if(!usr.RPMode)if(usr.CanAttack(50)) if(!src.afk&&!src.RPMode)
			if(usr.Ki>=50)
				K.CDTick(usr)
				usr.attacking=3
				K.Using_Explosion=1
				K.On = 0
				spawn(usr.Refire*2)
					if(usr)
						usr.attacking=0
						K.Using_Explosion=0
				if(K.Experience<100)
					if(K.Level == K.Experience) K.Level++
					K.Experience+=rand(5,9)
					if(K.Experience>100) K.Experience=100
//				ExplosionCEffect(T)
				ExplosionEffect(src)
				if(Level>4)Crater(src)
				else SmallCrater(src)
				var/exprange = range(K.Level,src)
				for(var/turf/A in exprange) if(prob(95))
					for(var/atom/X in A)
						if(X.Flammable)
							X.Burning = 1
							X.Burn(X.Health)
					for(var/mob/B in A)
						var/didShield=0
						for(var/obj/items/Force_Field/S in B) if(S.Level>0)
							S.Level = max(0, (S.Level - 1000*((usr.Pow/B.End)*(usr.BP/B.BP)*Ki_Power))) // damage
							S.desc = initial(S.desc)+"<br>[Commas(S.Level)] Battery Remaining"
							didShield=1
						var/Mult=1
						if(B.Shielding||didShield) Mult=0.7
						/*if(prob(25))
							var/BodyPart/Ears/L =locate(/BodyPart/Ears) in B
							B.Injure_Hurt(30,L,"Explosion ([usr])")*/
						if(B.icon_state == "Flight") if(prob(25))
							view(20,B) << "[B] is sucked to the ground by the force of the explosion!"
							B.Flight_Land()
						if(!B.Flying)
							B.TakeDamage(usr, 7.5*((usr.Pow/B.End)*(usr.BP/B.BP)*Mult*Ki_Power), "Explosion")
					for(var/obj/B in A)
						B.TakeDamage(usr, usr.Pow*5, "Attack")
						//B.Health-=usr.Pow*5
						if(B.Health<=0)
							SmallCrater(B)
							del(B)
					ExplosionEffect(A)
					if(usr.HasSmolder) new/obj/Hazard/Burning_Embers(A)
					if(!A.density)
						A.Health=0
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")
					else
						A.TakeDamage(usr, usr.Pow*5, "Explosion")
						//A.Health -= usr.Pow*5
						if(usr!=0) A.Destroy(usr,usr.key)
						else A.Destroy("Unknown","Unknown")
					if(prob(20))
						sleep(1)
				usr.DrainKi("Explosion", 1, 100,show=1)//usr.DrainKi("Explosion","Percent",5)//usr.Ki -= 50

			else
				usr<<"You do not have enough energy."
			return



	if(src==usr||usr.Target==src)
		usr.Target=null
		return
	else usr.getTarget(src)
	//for(var/obj/items/Scanner/A in usr) if(A.suffix) usr<<"Scanner: [Commas(BP)]"
	usr<<"[src] Lethality: [Lethality ? "On" : "Off"] [Spar ? "\[Pulling Punches\]" : ""]"
	if(src!=usr)if(usr.SplitFollowsMouse)
		for(var/mob/Drone/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",src)
		for(var/mob/Splitform/B in view(usr,25)) if(B.lastKnownKey==usr.key)  B.DoChoice("Click Target",src)
		for(var/mob/Doll/B in view(usr,25)) if(B.dronekey==usr.ckey)  B.DoChoice("Click Target",src)
	if(usr.client && usr.client.holder && usr==src && !usr.Target)
		usr.Target=src
		return
		