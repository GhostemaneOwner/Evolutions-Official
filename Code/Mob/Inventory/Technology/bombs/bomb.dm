obj/items/Bomb
	icon='Lab.dmi'
	icon_state="Panel1"
	density=1

	Flammable = 1
	desc="Upgrading will increase the damage of whatever the explosion touches."
	var/Force=1
	var/Range=8
	//var/Speed=1
	New()
		..()
		spawn if(src) if(Bolted) Proximity_Detonation()
	verb/Upgrade()
		set src in oview(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=700000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].\n")
		A.Value-=Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Force=Upgrade*rand(90,110)
		Reset_Desc()
	proc/Reset_Desc()
		desc=initial(desc)
		desc+="<br>Force: [Commas((Force**3)*100)] BP"
		desc+="<br>Radius: [Range]"
		//desc+="<br>Explosion Speed: [Speed]"
	proc/Detonate()
		var/Damage=100*(Force**3)
		var/Amount=5
		while(Amount)
			Amount-=1
			for(var/turf/A in range(src,Range))
				A.TakeDamage(src, Damage, "Bomb")
				for(var/obj/B in A) if(B!=src)
					B.TakeDamage(src, Damage, "Bomb")
					if(B.Health<=0||istype(B,/obj/Props/Edges)) del(B)
				for(var/mob/B in A)
					B.TakeDamage(src, Damage/(B.BP*B.End), "Bomb")
				if(A.Health<=0)
					if(usr!=0) A.Destroy(usr,usr.key)
					else A.Destroy("Unknown","Unknown")
				A.Self_Destruct_Lightning(100)
			spawn(10)
			del(src)
	verb/Set()
		set src in oview(1,usr)
		if(Bolted)
			usr<<"It is already armed, you cannot reprogram it"
			return
		view(src)<<"[usr] has begun to program the bomb."
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has begun to program the bomb.\n")
			alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has begun to program the bomb.")
		Password=input("Set the access code for remote detonation.") as text
		name=input("Name this bomb") as text
		if(!name) name=initial(name)
	verb/Arm()
		set src in oview(1,usr)
		if(Bolted)
			usr<<"It is already armed"
			return
		switch(input("Choose method. Only choose if you do not plan on remote detonation. Once \
		activated, it cannot be deactivated.") in list("Cancel","Timer","Proximity"))
			if("Timer") Timed_Detonation()
			if("Proximity") Proximity_Detonation()
	proc/Timed_Detonation()
		var/Timer=input("Set the timer, in minutes. (1-30)") as num
		Bolted=1
		if(Timer<1) Timer=1
		if(Timer>30) Timer=30
		Timer=round(Timer)
		if(Timer!=1)
			view(src)<<"[src]: Detonation in [Timer] minutes."
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [src]: Detonation in [Timer] minutes.\n")
				alertAdmins("| ([M.x], [M.y], [M.z]) | [src]: Detonation in [Timer] minutes.")
		Timer-=1
		sleep(Timer)
		view(src)<<"[src]: Detonation in 1 minute."
		sleep(300)
		view(src)<<"[src]: Detonation in 30 seconds."
		sleep(200)
		view(src)<<"[src]: Detonation in 10..."
		sleep(10)
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [src] detonates.\n")
		var/Amount=9
		while(src&&Amount)
			view(src)<<"[src]: [Amount]..."
			Amount-=1
			sleep(10)
		if(src) Detonate()
	proc/Proximity_Detonation()
		view(src)<<"[src]: Proximity Detonation active in 1 minute"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [src]: Proximity Detonation activation in 1 minute.\n")
			alertAdmins("| ([M.x], [M.y], [M.z]) | [src]: Proximity Detonation activation in 1 minute.")
		Bolted=1
		sleep(600)
		while(src)
			for(var/mob/A in view(5,src)) if(A.client)
				view(src)<<"[src]: Proximity Breach. Detonation Commencing in 5 seconds..."
				spawn(50) if(src) Detonate()
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [src] detonates.\n")
				return
			sleep(75)
	proc/Remote_Detonation()
		Bolted=1
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [src] detonates.\n")
			alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has remote detonated the bomb.")
		Detonate()
		return
		