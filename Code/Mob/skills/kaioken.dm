
/
Skill/Buff/Kaioken
	buffon="emits a bright red aura."
	buffoff="stops using Kaioken."
	BP=2
	Spd=2
	Def=1.5
	Off=1.5
	Regen=1.2
	healthdrain=0.7
	layer=MOB_LAYER+1
	icon = 'Kaioken New.dmi'
	pixel_x=-32
	pixel_y=-32
	/*GetDescription()
		return "Kaioken is a skill you can master up to 20x. Each level grants you 1.05x BP up to 2x BP from level 20 at the cost of draining health. More mastery will decrease the HP drain."
		..()*/
	verb/Kaioken()
		set category="Skills"
		set src = usr.contents
		use(usr)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

atom/proc/Body_Parts()
	var/Amount=6
	var/list/Turfs=new
	for(var/turf/A in view(src)) if(!A.density) Turfs+=A
	while(Amount&&Turfs)
		if(locate(/turf) in Turfs)
			var/obj/Body_Part/A=new
			A.name="[src] chunk"
			A.loc=pick(Turfs)
			Amount-=1
			break
		else return

obj/Body_Part
	icon='Body Parts.dmi'
	Savable=0
	New()
		spawn(rand(2000,4000)) del(src)
		pixel_y+=rand(-16,16)
		pixel_x+=rand(-16,16)
		dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)
