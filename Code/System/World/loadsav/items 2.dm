/*

######### Item Saving/Loading #########

*/

proc/add_CreatedItems(var/item)

	if(!CreatedItems) CreatedItems=new
	CreatedItems+=item

proc/rem_CreatedItems(var/item)

	CreatedItems-=item
	if(!CreatedItems|!CreatedItems.len) CreatedItems=null


mob/proc/dropRares()
	for(var/obj/Magic_Ball/A in src)	//Remove dragonballs from their person
		A.loc=loc
		Save()

var/list/worldObjectList = new


proc/find_savableObjects()

	for(var/obj/_object in world) // Find all objects in the world
		if(!_object.z||_object.z==0) continue
		if(_object in global.worldObjectList)
			if(!_object.z||_object.z==0)
				global.worldObjectList -= _object
				del(_object)
			else continue // If it's already in the world object list, skip it.
		if(_object.Savable==1) global.worldObjectList+=_object // If it's NOT, and we want it saved, add it to the world object list.

		if(istype(_object,/obj/Drill)) // add drills to the global list.
			if(_object in global.DrillList) continue
			global.DrillList += _object
		if(istype(_object,/obj/Mana_Pylon)) // add pylons to the global list.
			if(_object in global.DrillList) continue
			global.DrillList += _object
		sleep(-1)

proc/RemoveItemSaves()
	while(fexists("Data/ItemSaves/ItemSave1.bdb"))
		fdel("Data/ItemSaves/")
	world << "<small>Removed old item saves.</small>"

proc/SaveItems()
	if(global.CanSave)
		if(fexists("Data/ItemSaves/ItemSave1.bdb"))
			world<<"<small>Removing old item saves...</small>"
			RemoveItemSaves()
		world<<"<small>Saving current items...</small>"
		var/foundobjects=0
		var/savedobjs = list()
		var/E = 1
		var/savefile/F=new("Data/ItemSaves/ItemSave[E].bdb")
		var/list/L=new
		for(var/obj/A in global.worldObjectList)
			if(A.Savable||istype(A,/obj/TrainingEq))
				foundobjects ++
				A.savedX = A.x
				A.savedY = A.y
				A.savedZ = A.z
				A.Save_Loc = A.loc
				//A.loc = null
				L += A
				savedobjs += A
			if(foundobjects % 1000 == 0)
				F["SavedItems"] << L
				E ++
				F=new("Data/ItemSaves/ItemSave[E].bdb")
				L=new
			//sleep(-1)
		for(var/mob/NPC/A in global.worldObjectList)
			if(istype(A,/mob/NPC))
				foundobjects ++
				A.savedX=A.x
				A.savedY=A.y
				A.savedZ=A.z
				//A.Save_Loc = A.loc
				//A.loc = null
				L+=A
				savedobjs += A
			if(foundobjects % 1000 == 0)
				F["SavedItems"] << L
				E ++
				F=new("Data/ItemSaves/ItemSave[E].bdb")
				L=new
		for(var/mob/Drone/A in global.worldObjectList)
			if(istype(A,/mob/Drone))
				foundobjects ++
				A.savedX=A.x
				A.savedY=A.y
				A.savedZ=A.z
				//A.Save_Loc = A.loc
				//A.loc = null
				L+=A
				savedobjs += A
			if(foundobjects % 1000 == 0)
				F["SavedItems"] << L
				E ++
				F=new("Data/ItemSaves/ItemSave[E].bdb")
				L=new
		for(var/mob/Doll/A in global.worldObjectList)
			if(istype(A,/mob/Doll))
				foundobjects ++
				A.savedX=A.x
				A.savedY=A.y
				A.savedZ=A.z
				//A.Save_Loc = A.loc
				//A.loc = null
				L+=A
				savedobjs += A
			if(foundobjects % 1000 == 0)
				F["SavedItems"] << L
				E ++
				F=new("Data/ItemSaves/ItemSave[E].bdb")
				L=new

		if(foundobjects % 1000 != 0) F["SavedItems"] << L

		for(var/obj/A in savedobjs)
			if(A.Save_Loc) A.loc = A.Save_Loc
			else if(A.savedX) if(A.savedY) if(A.savedZ) A.loc = locate(A.savedX,A.savedY,A.savedZ)
		for(var/mob/A in savedobjs)
			if(A.savedX) if(A.savedY) if(A.savedZ)
				A.loc = locate(A.savedX,A.savedY,A.savedZ)
		world<<"<small>Items saved ([foundobjects] items)</small>"

proc/LoadItems()
	world<<"Starting Items load."
	if(global.ItemsLoaded == 0)
		if(fexists("Data/ItemSaves/ItemSave1.bdb"))
			world<<"Item save detected. Deleting initial items."
			DeleteInitialItems()
			LoadItemFiles()
		global.ItemsLoaded=1
		loopThroughDrills()

mob/verb/skillout()
	usr<<"[typesof(/Skill).Join(", ")]"

proc/DeleteInitialItems()
	for(var/obj/I in world) if(I.Savable) del(I)
	//for(var/obj/Props/E in world) del(E)
proc/LoadItemFiles(E=1, amount=0)
	//set background = 1
	world<<"Checking for file [E]"
	if(fexists("Data/ItemSaves/ItemSave[E].bdb")) // Check if the file exists
		var/savefile/F=new("Data/ItemSaves/ItemSave[E].bdb") // Load it
		world<<"File found! [E]"
		var/list/L=F["SavedItems"]
		world<<"File initialized! [E]"

		for(var/obj/A in L) // Loop through all objects that could be in the file
			amount++
			if(istype(A,/obj/Turfs/)) if(!A.Builder) del(A)
			if(istype(A,/obj/Props/)) if(!A.Builder) del(A)
			if(A.savedX) if(A.savedY) if(A.savedZ) A.loc=locate(A.savedX,A.savedY,A.savedZ)
			//global.worldObjectList+=A
			sleep(-1)
		world<<"File placed! [E]"
		for(var/mob/A in L)
			if(!istype(A,/mob/NPC)&&!istype(A,/mob/Drone)&&!istype(A,/mob/Doll)) L-=A
			amount++
			if(A.savedX) if(A.savedY) if(A.savedZ) A.loc=locate(A.savedX,A.savedY,A.savedZ)
			global.worldObjectList+=A
			sleep(-1)
		world<<"File loaded! [E]"
		E++

		.(E,amount) // Recursive call (basically, move onto the next file)

	else
		world<<"<span class=\"announce\">Items Loaded ([amount]).</span>"
		world.log = null
		world.log << "All files loaded. Ready for transfer. Year [Year]"
		diary << "All files loaded."
		world.log = errors


