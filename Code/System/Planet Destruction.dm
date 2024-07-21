turf/Del()
	var/Type=type
	if(InitialType) Type=InitialType
	spawn InitialType=Type
	Builder=null
	if(Turfs) Turfs-=src
	//if(!Turfs|!Turfs.len) Turfs=null
	..()
turf/var/InitialType

var
	Earth=1
	EarthMoon=1
	Namek=1
	Vegeta=1
	VegetaMoon=1
	Arconia=1
	ArconiaMoon=1
	Ice=1
	IceMoon=1
	Desert=1
	Jungle=1
	Android=1
	Alien = 1
	AlienMoon=1
	SpaceStation=1
	Ocean=1
	DarkPlanet=1

proc/Planet_Restore(Z)
	set waitfor=0
	if(Z==1) Earth=1
	if(Z==2) Namek=1
	if(Z==3) Vegeta=1
	if(Z==5) Arconia=1
	if(Z==4) Ice=1
	if(Z==6) DarkPlanet=1
	if(Z==7) SpaceStation=1
	for(var/turf/A in block(locate(1,1,Z),locate(world.maxx,world.maxy,Z)))
		if(A.InitialType) new A.InitialType(A)
		if(prob(0.5)) sleep(1)

proc/Planet_Destroyed()
	set waitfor=0
	if(!Earth)
		for(var/turf/A in block(locate(1,1,1),locate(world.maxx,world.maxy,1)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==1) del(A)
		for(var/obj/Planets/Earth/DP) del(DP)
	if(!Namek)
		for(var/turf/A in block(locate(1,1,2),locate(world.maxx,world.maxy,2)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==2) del(A)
		for(var/obj/Planets/Namek/DP) del(DP)
	if(!Vegeta)
		for(var/turf/A in block(locate(1,1,3),locate(world.maxx,world.maxy,3)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==3) del(A)
		for(var/obj/Planets/Vegeta/DP) del(DP)
	if(!Arconia)
		for(var/turf/A in block(locate(1,1,5),locate(world.maxx,world.maxy,5)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==5) del(A)
		for(var/obj/Planets/Arconia/DP) del(DP)
	if(!Ice)
		for(var/turf/A in block(locate(1,1,4),locate(world.maxx,world.maxy,4)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==4) del(A)
		for(var/obj/Planets/Ice/DP) del(DP)
	if(!SpaceStation)
		for(var/turf/A in block(locate(1,1,7),locate(world.maxx,world.maxy,7)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==7) del(A)
		for(var/obj/Planets/SpaceStation/DP) del(DP)
	if(!DarkPlanet)
		for(var/turf/A in block(locate(1,1,6),locate(world.maxx,world.maxy,6)))
			new/turf/Other/Stars(locate(A.x,A.y,A.z))
			new/area/Space(locate(A.x,A.y,A.z))
			if(prob(1)) sleep(1)
		for(var/obj/Props/A) if(A.z==6) del(A)
		for(var/obj/Planets/DarkPlanet/DP) del(DP)
	if(!Alien) for(var/obj/Planets/Alien/A) del(A)
	if(!Desert) for(var/obj/Planets/Desert/A) del(A)
	if(!Jungle) for(var/obj/Planets/Jungle/A) del(A)
	if(!Ocean) for(var/obj/Planets/Ocean/A) del(A)
	if(!AlienMoon) for(var/obj/Planets/AlienMoon/A) del(A)
	if(!EarthMoon) for(var/obj/Planets/EarthMoon/A) del(A)
	if(!ArconiaMoon) for(var/obj/Planets/ArconiaMoon/A) del(A)
	if(!IceMoon) for(var/obj/Planets/IceMoon/A) del(A)
	if(!VegetaMoon) for(var/obj/Planets/VegetaMoon/A) del(A)

proc/Destroy_Planet(Z)
	set waitfor=0
	if(Z==1) Earth=0
	if(Z==2) Namek=0
	if(Z==3) Vegeta=0
	if(Z==5) Arconia=0
	if(Z==4) Ice=0
	if(Z==6) DarkPlanet=0
	if(Z==7) SpaceStation=0
	var/Destroying=1
	for(var/area/A) if(A.type!=/area&&A.z==Z) A.icon_state="Mega Darkness"
	sleep(2000)  // Added explosion block back in.
	spawn while(Destroying) for(var/turf/A in block(locate(1,1,Z),locate(world.maxx,world.maxy,Z)))
		if(prob(0.002))
			for(var/turf/B in range(10,A)) if(prob(60)&&B.type!=/turf/Other/Stars)
				ExplosionEffect(B)
				if(prob(90)) new/turf/meltingrock(locate(B.x,B.y,B.z))
				else new/turf/Terrain/Water/Water7(locate(B.x,B.y,B.z))
			sleep(20)
		for(var/mob/player/P in A) if(A.z==Z) spawn P.Quake()
		sleep(100)
	sleep(2000) //  ^^  Added explosion block back in - Ghostemane
	spawn while(Destroying)
		var/obj/Lightning_Strike/A=new(locate(rand(1,world.maxx),world.maxy,Z))
		spawn(1200) if(A) del(A)
		sleep(12)
	sleep(2000)
	Destroying=0
	Planet_Destroyed()
	for(var/mob/player/A in Players) if(A.z==Z) Liftoff(A)

turf
	proc
		Wave(var/Amount,var/Chance)
			spawn if(src) while(Amount)
				Amount-=1
				for(var/turf/T in oview(src,5))
					if(prob(10)&&!T.density&&!T.Water)FightingDirt(T)
					if(prob(Chance)) spawn(rand(0,10)) missile(pick('Haze.dmi','Electric_Blue.dmi','Dust.dmi'),src,T)
				sleep(3)

/turf/meltingrock
	name = "Super-heated rock"
	icon = 'nuclearfire.dmi'
	icon_state = "1"
	Buildable = 0
	New()
		icon_state = pick("1", "2", "3")
		dir = pick(cardinal)
		spawn(rand(16,64))
			var/turf/moltenrock/rock = new /turf/moltenrock(locate(src.x,src.y,src.z))
			Turfs-=src
			Turfs+=rock
		..()
/turf/moltenrock
	name = "Super-heated rock"
	icon = 'Turfs1.dmi'
	icon_state = "lava"
	Buildable = 0
	New()
		icon_state = pick("lava", "lava2", "lava3", "lava4", "lava5", "ash", "ash2", "ash3", "ash4", "ash5")
		..()
obj/Lightning_Strike
	Savable=0
	var/Power = 0
	var/Dest = null
	density = 0
	New()
		var/image/A=image(icon='Lightning Strike.dmi',icon_state="Front",layer=99)
		var/image/B=image(icon='Lightning Strike.dmi',pixel_y=32,layer=99)
		var/image/C=image(icon='Lightning Strike.dmi',pixel_y=64,layer=99)
		var/image/D=image(icon='Lightning Strike.dmi',pixel_y=96,icon_state="End",layer=99)
		overlays.Add(A,B,C,D)
		spawn()
//			hearers(12,src) << 'lightning01.wav'
			src.Bolt()
		if(!src.Power) spawn(150) if(src) del(src)
	proc
		Bolt()
			set waitfor=0
			if(src.z) src.loc = locate(src.x,src.y-1,src.z)
			if(src.loc == src.Dest)
				Crater(src)
				for(var/obj/O in range(0,src))
					if(O != src)
						O.TakeDamage(src, 100, "Lightning")
						if(istype(O,/obj/Door)) O.TakeDamage(src, src.Power*10, "Lightning")
						if(O.Flammable)
							O.Burning = 1
							O.Burn(O.Health)
						if(O.Health <= 0) del(O)
				for(var/mob/M in range(0,src))
					M.TakeDamage(src, (Power)/(M.BP), "Lightning")
				var/turf/T = src.loc
				if(T) T.Wave(1,5)
				del(src)
			sleep(1)
			spawn(0) if(src) src.Bolt()

obj/LightningStrike
	Savable=0
	density = 0
	icon='Lightning.dmi'
	icon_state="strike"
	New()
		..()
		spawn(7) del(src)
//Hakai Coding going in next.
Skill/Misc/Planet_Destroy
	desc="This will destroy an entire planet. Don't use it without a really good reason."
	verb/Planet_Destroy()
		set category="Other"
		if(usr.RPMode) return
		if(!(usr.z in list(1,2,3,4,5,7)))
			usr<<"Ahelp to destroy this."
			return
		if(usr.z==1&&!Earth) return
		if(usr.z==2&&!Namek) return
		if(usr.z==3&&!Vegeta) return
		if(usr.z==5&&!Arconia) return
		if(usr.z==4&&!Ice) return
		if(usr.z==6&&!DarkPlanet) return
		if(usr.z==7&&!SpaceStation) return
		switch(input("Destroy the planet?") in list("No","Yes"))
			if("Yes")
				alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has started Planet Destroy  on [usr.z == 1 ? "Earth" : usr.z == 2 ? "Namek" : usr.z == 3 ? "Vegeta" : usr.z == 5 ? "Ice" : usr.z ==6?"Dark Planet" : usr.z==7 ? "Space Station" : "Not somewhere they're supposed to! WTF?" ].")
				Crater(usr)
				spawn Destroy_Planet(usr.z)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has started Planet Destroy on [usr.z == 1 ? "Earth" : usr.z == 2 ? "Namek" : usr.z == 3 ? "Vegeta" : usr.z == 5 ? "Ice" : usr.z ==6?"Dark Planet" : usr.z==7 ? "Space Station" : "Not somewhere they're supposed to! WTF?" ].\n")



