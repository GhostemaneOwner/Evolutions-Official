mob/var
	OOCColor="font color=gray"
	SayColor="font color=green"

	is_silenced = 0
	isafk = 0

obj/BigCrater
	icon='Craters.dmi'
	icon_state="Center"
	mouse_opacity = 0
	New()
		..()
		var/image/A=image(icon='Craters.dmi',icon_state="N",pixel_y=32)
		var/image/B=image(icon='Craters.dmi',icon_state="S",pixel_y=-32)
		var/image/C=image(icon='Craters.dmi',icon_state="E",pixel_x=32)
		var/image/D=image(icon='Craters.dmi',icon_state="W",pixel_x=-32)
		var/image/E=image(icon='Craters.dmi',icon_state="NE",pixel_y=32,pixel_x=32)
		var/image/F=image(icon='Craters.dmi',icon_state="NW",pixel_y=32,pixel_x=-32)
		var/image/G=image(icon='Craters.dmi',icon_state="SE",pixel_y=-32,pixel_x=32)
		var/image/H=image(icon='Craters.dmi',icon_state="SW",pixel_y=-32,pixel_x=-32)
		overlays.Add(A,B,C,D,E,F,G,H)
		spawn
			sleep(500)
			del(src)

mob/proc/TransformDustGen(var/amount)
	set waitfor=0
	while(amount)
		amount -= 1
		spawn
			var/obj/A = new(loc)
			A.icon = 'DamagedGround.dmi'
			spawn while(prob(80))
				sleep(25)
				step_rand(A)
			spawn(100) del(A)
	return

mob/proc/SSj2GroundGrind()
	for(var/turf/T in view(2,src))
		if(prob(20)) sleep(1)
		var/image/I=image(icon='Dirt.dmi',dir=rand(1,8))
		I.pixel_x+=rand(-16,16)
		I.pixel_y+=rand(-16,16)
		if(prob(50)) T.overlays+=I
		spawn(600) if(I)
			T.overlays-=I
			del(I)
	for(var/turf/T in view(4,src))
		if(prob(20)) sleep(1)
		var/image/I=image(icon='Dirt.dmi',dir=rand(1,8))
		I.pixel_x+=rand(-16,16)
		I.pixel_y+=rand(-16,16)
		if(prob(50)) T.overlays+=I
		spawn(600) if(I)
			T.overlays-=I
			del(I)
	for(var/turf/T in view(6,src))
		if(prob(20)) sleep(1)
		var/image/I=image(icon='Dirt.dmi',dir=rand(1,8))
		I.pixel_x+=rand(-16,16)
		I.pixel_y+=rand(-16,16)
		if(prob(50)) T.overlays+=I
		spawn(600) if(I)
			T.overlays-=I
			del(I)
	for(var/turf/T in view(8,src))
		if(prob(20)) sleep(1)
		var/image/I=image(icon='Dirt.dmi',dir=rand(1,8))
		I.pixel_x+=rand(-16,16)
		I.pixel_y+=rand(-16,16)
		if(prob(50)) T.overlays+=I
		spawn(600) if(I)
			T.overlays-=I
			del(I)
mob/proc/EliteGroundGrind()
	for(var/turf/T in view(2,src))
		if(prob(10)) sleep(1)
		var/image/I=image(icon='Dirt.dmi',dir=rand(1,8))
		I.pixel_x+=rand(-16,16)
		I.pixel_y+=rand(-16,16)
		if(prob(50)) T.overlays+=I
		spawn(600) if(I)
			T.overlays-=I
			del(I)
	for(var/turf/T in view(4,src))
		if(prob(10)) sleep(1)
		var/image/I=image(icon='Dirt.dmi',dir=rand(1,8))
		I.pixel_x+=rand(-16,16)
		I.pixel_y+=rand(-16,16)
		if(prob(50)) T.overlays+=I
		spawn(600) if(I)
			T.overlays-=I
			del(I)
	for(var/turf/T in view(6,src))
		if(prob(10)) sleep(1)
		var/image/I=image(icon='Dirt.dmi',dir=rand(1,8))
		I.pixel_x+=rand(-16,16)
		I.pixel_y+=rand(-16,16)
		if(prob(50)) T.overlays+=I
		spawn(600) if(I)
			T.overlays-=I
			del(I)

mob/proc/SSJ2Cinematic()
//	for(var/mob/M in view(usr)) if(M.client) M << sound('rockmoving.wav')
	dir = SOUTH
	for(var/turf/T in view(src))
		if(prob(10)) spawn(rand(10,150)) T.overlays += 'Electric_Blue.dmi'
	//	else if(prob(10)) spawn(rand(10,150)) T.overlays += 'SSj Lightning.dmi'
		else if(prob(30)) spawn(rand(10,150)) T.overlays += 'Rising Rocks.dmi'
		spawn(rand(200,400)) T.overlays -= 'Electric_Blue.dmi'
	//	spawn(rand(200,400)) T.overlays -= 'SSj Lightning.dmi'
		spawn(rand(200,400)) T.overlays -= 'Rising Rocks.dmi'
	spawn(rand(40,60)) for(var/turf/T in view(10))
		var/image/W = image(icon='Lightning flash.dmi',layer=MOB_LAYER+1)
		T.overlays += W
		spawn(2) T.overlays -= W
	var/amount = 16
	sleep(50)
//	var/image/I = image(icon='Aurabigcombined.dmi')
//	I.plane = 7
//	overlays+=I
	spawn(130)
//	overlays-=I
	sleep(100)
	Quake()
	Quake()
	Quake()
	spawn Quake()
	spawn SSj2GroundGrind()
	while(amount)
		var/obj/A = new/obj
		A.loc = locate(x,y,z)
	//	A.icon = 'Electricgroundbeam2.dmi'
		if(amount==8) spawn(rand(1,50)) walk(A,NORTH,2)
		if(amount==7) spawn(rand(1,50)) walk(A,SOUTH,2)
		if(amount==6) spawn(rand(1,50)) walk(A,EAST,2)
		if(amount==5) spawn(rand(1,50)) walk(A,WEST,2)
		if(amount==4) spawn(rand(1,50)) walk(A,NORTHWEST,2)
		if(amount==3) spawn(rand(1,50)) walk(A,NORTHEAST,2)
		if(amount==2) spawn(rand(1,50)) walk(A,SOUTHWEST,2)
		if(amount==1) spawn(rand(1,50)) walk(A,SOUTHEAST,2)
		spawn(50) del(A)
		amount -= 1
	spawn(20) new/obj/BigCrater(locate(x,y,z))
	TransformDustGen(4)
	spawn(30)
//	overlays -= 'Aurabigbottom.dmi'
	spawn for(var/turf/T in view(src)) spawn(rand(1,50)) if(prob(1)) new/obj/BigCrater(locate(T.x,T.y,T.z))

