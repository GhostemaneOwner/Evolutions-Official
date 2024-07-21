area
	//mouse_opacity=0
	var/Value=33000000
	var/Value_Mana = 33000000
	//var/Inside=0
	//var/Temperature=1
	New()
		layer=99
		icon='Weather.dmi'

//	var/TemperatureType
//	var/WeatherOverride=0
//	var/WeatherOdds=0
//	icon='Weather.dmi'
	Void
	HBTC
	PlanetWrapper // This area can be placed on the edges of each map and will ensure the player is teleported to the other side.
			// Should work on ever Z-level and doesn't need to be adjusted.
		var/zportal
		Entered(var/atom/movable/O)
			//if(istype(O,/NPC_AI/)) return
			var/nx = O.x
			var/ny = O.y
			zportal= O.z
			switch(zportal)
				if(1)
					switch(nx)
						if(1) nx = world.maxx-1
						if(500) nx = 2
					switch(ny)
						if(1) ny = 399
						if(400) ny = 2
					O.loc = locate(nx,ny,src.zportal)
				if(2)
					switch(nx)
						if(1) nx = world.maxx-1
						if(500) nx = 2
					switch(ny)
						if(1) ny = 382
						if(383) ny = 2
					O.loc = locate(nx,ny,src.zportal)
				if(3)
					switch(nx)
						if(1) nx = world.maxx-1
						if(500) nx = 2
					switch(ny)
						if(1) ny = 375
						if(376) ny = 2
					O.loc = locate(nx,ny,src.zportal)
				if(4)
					switch(nx)
						if(1) nx = world.maxx-1
						if(500) nx = 2
					switch(ny)
						if(1) ny = 379
						if(380) ny = 2
					O.loc = locate(nx,ny,src.zportal)
				if(5)
					switch(nx)
						if(1) nx = world.maxx-1
						if(500) nx = 2
					switch(ny)
						if(1) ny = 425
						if(426) ny = 2
					O.loc = locate(nx,ny,src.zportal)
				if(6)
					switch(nx)
						if(1) nx = world.maxx-1
						if(500) nx = 2
					switch(ny)
						if(1) ny = world.maxy-1
						if(500) ny = 2
					O.loc = locate(nx,ny,src.zportal)
				if(7)
					switch(nx)
						if(1) nx = world.maxx-1
						if(500) nx = 2
					switch(ny)
						if(1) ny = world.maxy-1
						if(500) ny = 2
					O.loc = locate(nx,ny,src.zportal)
				if(14)
					switch(nx)
						if(1)
							nx += 247
						if(249)
							nx = 2
					switch(ny)
						if(1)
							if(O.icon_state=="Flight")// south DP border Flight in order to prevent players from getting STUCK
								ny += 247
						if(500)
							ny -= 247
						if(252)
							if(O.icon_state=="Flight") // south JP border
								ny = world.maxy-1
						if(249)
							ny = 2
					O.loc = locate(nx,ny,src.zportal)

	Realm
//		Value=1.#INF
//		Value_Mana=1.#INF
	Space
		Entered(var/mob/player/A) if(A.z!=12)
			spawn A.loc=locate(A.x,A.y,12)
			