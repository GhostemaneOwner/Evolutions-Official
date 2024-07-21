Skill/Attacks/ExplosiveWave
	UB1="Channel"

	Tier=2
	desc="An area of effect attack that does Force based damage and knocks back people in the area. (9 Targets Max)"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
	verb/Explosive_Wave()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<50||charging) return
		if(!usr.CanAttack(50,src)) return
		if(Experience<100) Experience+=rand(5,11)
		if(Experience>100) Experience=100
		CDTick(usr)
		//usr.DrainKi(src,"Percent",20)//usr.Ki=max(0,usr.Ki-50)
		usr.DrainKi(src, 1, 200,show=1)
		usr.attacking=3
		charging=1
		BigShockwave(usr)
		Crater(usr)
	//	var/maxHit=9
		//spawn if(usr) for(var/turf/T in oview(usr,3)) if(prob(30)&&!T.density&&!T.Water)FightingDirt(T)
		spawn if(usr) for(var/mob/P in oview(usr,3)) if(P!=usr) if(!P.afk&&!P.RPMode)//if(maxHit>0)
		//	maxHit--
			/*if(prob(10))
				var/Distance=round((usr.Pow/P.End)*(usr.BP/P.BP))
				if(Distance>5) Distance=5
				*/
			P.Shockwave_Knockback(5,usr.loc)
			P.Flight_Land()
			P.Injure_Hurt(1.5*((usr.BP*usr.Pow)/(P.BP*P.End)),"Ears",usr)
			P.TakeDamage(usr, 5*((usr.BP*usr.Pow)/(P.BP*P.End)), "Explosive Wave")
			sleep(0)
		spawn(100/(max(20,Experience/2))) if(usr)
			usr.attacking=0
			charging=0


Skill/Attacks/Earthquake
	UB1="Fungal Plague"
	UB2="Death"
	Tier=3
	desc="An area of effect attack that does Strength based damage and knocks back people in the area. (9 Targets Max)"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")
	verb/Earthquake()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking||usr.Ki<50||charging) return
		if(!usr.CanAttack(200,src)) return
		if(Experience<100) Experience+=rand(5,11)
		if(Experience>100) Experience=100
		CDTick(usr)
		//usr.DrainKi(src,"Percent",20)//usr.Ki=max(0,usr.Ki-200)
		usr.DrainKi(src, 1, 200,show=1)
		usr.attacking=3
		charging=1
		BigShockwave(usr)
		Crater(usr)
		var/maxHit=9
		///spawn if(usr) for(var/turf/T in oview(usr,3)) if(prob(30)&&!T.density&&!T.Water)FightingDirt(T)
		spawn if(usr) for(var/mob/P in oview(usr,3)) if(P!=usr) if(!P.afk&&!P.RPMode) if(maxHit>0)
			maxHit--
			if(prob(30))
				var/Distance=round((usr.Str/P.End)*(usr.BP/P.BP))
				if(Distance>5) Distance=5
				P.Shockwave_Knockback(Distance,usr.loc)
			P.Flight_Land()
			P.Injure_Hurt(1.5*((usr.BP*usr.Str)/(P.BP*P.End)),"Legs",usr)
			P.TakeDamage(usr, 5*((usr.BP*usr.Str)/(P.BP*P.End)), "Earthquake")
			sleep(0)
		spawn(100/(max(20,Experience/2))) if(usr)
			usr.attacking=0
			charging=0


