/*

######### Turf Saving/Loading #########

*/


proc
	MapSave()
		var/amount=0
		fdel("MapSave")
		var/savefile/F=new("MapSave")
		var/list/L=new/list
		for(var/area/A) //for(var/AA in A)//if(A.Builder)
			var/list/ML=list()
			for(var/mob/player/M in A) ML+=M
			L.Add(A.contents-ML)
			L.Add(A)
			amount+=1
		F<<L
		world<<"Map Saved ([amount])"
	MapLoad()
		if(fexists("MapSave"))
			var/savefile/F=new("MapSave")
			var/list/L=new/list
			F>>L
		world<<"<font size=1>Map Loaded."
		MapsLoaded=1
		CanSave = 1
