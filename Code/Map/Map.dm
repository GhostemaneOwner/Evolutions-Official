
obj/var/Projectile_Speed = 1


obj/Props
	Savable=0
	layer=4
	Buildable = 1
	var/Slinger = null
	var/Slinger_Key = null
	Builder = "Admin"
	Bump(mob/m)
		if(isobj(m))
			m.TakeDamage(src, 50, "Collision")
			//m.Health -= 50
			if(m.Health <= 0)
				SmallCrater(src)
				del(m)
				del(src)
		if(ismob(m))
			for(var/mob/X in view(8,src))
				if(X.client)
					X.saveToLog("| [X.client.address ? (X.client.address) : "IP not found"] | ([X.x], [X.y], [X.z]) | [src] is slung into [m] by [src.Slinger_Key].\n")
			var/Evasion = 10
			if(m.Spd)
				Evasion += m.Spd
			if(m.Def)
				Evasion += m.Def/m.DefMod/100
			if(src.Projectile_Speed)
				Evasion -= src.Projectile_Speed / 10
			if(m.afk)
				Evasion = 100
			if(!prob(Evasion))
				view(10,m) << "[src.Slinger] slams [src] into [m]!"
				SmallCrater(src)
				if(src.Projectile_Speed)
					var/dmg = src.Projectile_Speed / 10
					dmg -= m.End / 1000
					if(dmg <= 0)
						dmg = 1
					if(dmg >= 10)
						dmg = 10
					m.TakeDamage(src, dmg, "Collision")
					//m.Health -= dmg
				del(src)
			else
				flick(m.CustomZanzokenIcon,m)

turf/var/Water

var/HBTC_Open

turf/Other
	Blank
		opacity=1
		FlyOverAble=0
		density=1
		Health=1.#INF
		Enter(mob/A)
			if(ismob(A)) if(A.client)
				if(A.client.holder)
					return ..()
				else
					return 0
			else return //why was this del(A)
turf/Special
	Buildable=0

	Teleporter
		Health=1.#INF
		density=1
		var/gotox
		var/gotoy
		var/gotoz
		Enter(mob/M) M.loc=locate(gotox,gotoy,gotoz)

	EarthCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave04Out)
		Cave05Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave05In)
		Cave05In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave05Out)
		Cave06Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave06In)
		Cave06In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave06Out)
		Cave07Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave07In)
		Cave07In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthCaves/Cave07Out)

	EarthTower
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Tower01Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower01In)
		Tower01In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower01Out)
		Tower02Out
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower02In)
		Tower02In
			Enter(mob/M) M.loc=locate(/turf/Special/EarthTower/Tower02Out)



	IceCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/IceCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/IceCaves/Cave01Out)

	NamekCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave04Out)
		Cave05Out
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave05In)
		Cave05In
			Enter(mob/M) M.loc=locate(/turf/Special/NamekCaves/Cave05Out)
	VegetaCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave04Out)
		Cave05Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave05In)
		Cave05In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave05Out)
		Cave06Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave06In)
		Cave06In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave06Out)
		Cave07Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave07In)
		Cave07In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave07Out)
		Cave08Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave08In)
		Cave08In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave08Out)
		Cave09Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave09In)
		Cave09In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave09Out)
		Cave10Out
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave10In)
		Cave10In
			Enter(mob/M) M.loc=locate(/turf/Special/VegetaCaves/Cave10Out)
	ArconiaCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave02Out)
		Cave03Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave03In)
		Cave03In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave03Out)
		Cave04Out
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave04In)
		Cave04In
			Enter(mob/M) M.loc=locate(/turf/Special/ArconiaCaves/Cave04Out)
	ASMiscCaves
		icon='Special.dmi'
		icon_state="Special4"
		Health=1.#INF
		density=1
		Cave01Out
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave01In)
		Cave01In
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave01Out)
		Cave02Out
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave02In)
		Cave02In
			Enter(mob/M) M.loc=locate(/turf/Special/ASMiscCaves/Cave02Out)

	EnterHBTC/Enter(mob/A)
		if(ismob(A))
			A.loc=locate(/turf/Special/ExitHBTC)
		//	A.loc=locate(469,481,9) // OPTIMIZED MAP
			logAndAlertAdmins("([A.key])[A] has entered the HBTC.",1)
			A<<"HBTC power is handled by admins. If you have IC access to the HBTC, are knowledgable about its effects and would like to apply for the boost, please submit an Ahelp including HBTC boost somewhere in the message."
			//HBTC()
			A.HBTC_Enters++
			//else if(ismob(A)) A<<"You cannot enter the time chamber more than twice a lifetime."
	ExitHBTC/Enter(mob/A) A.loc=locate(/turf/Special/EnterHBTC)
//	ExitHBTC/Enter(mob/A) A.loc=locate(195,108,9) // OPTIMIZED MAP


proc/HBTC() if(!HBTC_Open)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16) A<<"The time chamber will remain open for one hour, \
	if you do not exit before then you will be trapped until someone enters the time chamber again, \
	and you will continue aging at ten times the normal rate until you exit"
	sleep(6000)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16)
		if(A.HBTCPower<=16) A.HBTCPower++
		A<<"The time chamber will be unlocked for 50 more minutes"
	sleep(6000)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16)
		if(A.HBTCPower<=16) A.HBTCPower++
		A<<"The time chamber will be unlocked for 40 more minutes"
	sleep(6000)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16)
		if(A.HBTCPower<=16) A.HBTCPower++
		A<<"The time chamber will be unlocked for 30 more minutes"
	sleep(6000)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16)
		if(A.HBTCPower<=16) A.HBTCPower++
		A<<"The time chamber will be unlocked for 20 more minutes"
	sleep(6000)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16)
		if(A.HBTCPower<=16) A.HBTCPower++
		A<<"The time chamber will be unlocked for 10 more minutes"
	sleep(3000)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16)
		if(A.HBTCPower<=16) A.HBTCPower++
		A<<"The time chamber will be unlocked for 5 more minutes (One more message)"
	sleep(2400)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16)
		A.HBTCPower++
		A<<"The time chamber will remain unlocked for ONE more minute (Leave now.)"
	sleep(600)
	HBTC_Open=1
	for(var/mob/player/A in Players) if(A.z==16) A<<"The time chamber exit disappears. You are now trapped"
	HBTC_Open=0

turf/var/DestroyedBy=null


