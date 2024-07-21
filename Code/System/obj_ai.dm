






var/tmp/objcleaning=0
var/tmp/npccleaning=0
var/tmp/npcareacount=0
var/tmp/objareacount=0



proc/Clean_Objs()
	if(isnum(objareacount) && objareacount < 3)
		objareacount ++
		//log_game("OBJ: Areacount [objareacount].")
		return
	else if (!isnum(objareacount)) return
	else if(objareacount == 3&&!objcleaning)
		objcleaning=1
		log_errors("Finding and removing wrongly placed Objects.")
		sleep(100)
		world<<"<span class=\"announce\">Finding and removing wrongly placed Objects.</span>"
		var/count
		/*for(var/OBJ_AI/SpaceDebris/O in world)
			if(isnull(O.loc)&&O.x==0||O.z==0||O.y==0) // Since it's impossible to have any of these coordinates 0 when you're ON the map, something must be wrong if any of the ARE 0 after placing the mobs.
				del(O)
				count++
			sleep(3)*/

		// automatically clean stacked doors
		for(var/obj/Door/B in global.worldObjectList)
			var/turf/T = locate(B.x, B.y, B.z)
			var/doorcount = 0
			for(var/obj/Door/D in T)
//				if(D.Builder)
//					doorcount++
				if(doorcount >= 2)
					del(D)
		log_errors("OBJ_AI cleaned. [count ? count : "0"] Erronous objects were removed.")
		world<<"<span class=\"announce\">Wrongly placed Objects cleansed.</span>"
		return
		