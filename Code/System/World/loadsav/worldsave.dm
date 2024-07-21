proc/SaveWorld()// if(PeopleCanSave)
	set waitfor = FALSE
	if(DebugOn) log_errors("World Save Start [time2text(world.timeofday, "hh:mm.ss")]")
	world << "<small>Saving the world.</small>"
	sleep(50)
	if(Server_Activated == 0)
		world << "<font color = yellow><font size = 6>Unable to verify server as legal, shutting down in 30 seconds..."
		sleep(300)
		del(world)
	find_savableObjects()
	for(var/mob/player/M in Players)
		if(M.Savable)
			M.Save()
			sleep(-1)
	world<<"<small>Players Saved!</small>"
	sleep(-1)
	CleanUpLoop()
	world << "<small>Clean Up finished.</small>"
	SaveHubText()
	world << "<small>Hubtext saved.</small>"
	SaveYear()
	world << "<small>Year saved.</small>"
	Save_Gain()
	world << "<small>Gain saved.</small>"
	sleep(-1)
	Save_Area()
	world << "<small>Area saved.</small>"
	SavePlanets()
	world<<"<small>Planets saved.</small>"
	if(global.CanSave) Save_Turfs()//MapSave()
	world << "<small>Turfs saved.</small>"
	sleep(-1)
	SaveItems()
	world << "<small>Items saved.</small>"
	sleep(-1)
	world << "<small>Reports saved.</small>"
	save_admins()
	world << "<small>Admins saved.</small>"
	SaveScalingPower()
	world << "<small>Dynamic power rankings saved.</small>"//Power ranking is [ScalingPower].
	sleep(-1)
	world << "<small>World saved.</small>"
	if(DebugOn) log_errors("World Save Success [time2text(world.timeofday, "hh:mm.ss")]")

proc/SaveWorldRepeat()
	set waitfor = FALSE
	while(TRUE)
		sleep(200000) // every 3-4 hours
		SaveWorld()
