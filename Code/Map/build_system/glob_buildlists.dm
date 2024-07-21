//#define childtypes(type) typesof(type) - type

// childtypes grabs all the types of a certain type and removes the parent.
// For example, ever type of /turf/Upgradeable/Roofs is grabbed except for '/turf/Upgradeable/Roofs' itself

var/list/global

	buildRoofs= new
	buildWalls= new
	buildDoors= new

// Terrain category

	buildGrass=new
	buildGround=new
	buildSky=new
	buildStairs=new
	buildTiles=new
	buildWater=new
	terrainMisc=new

// Props category

	buildBeds=new
	buildChairs=new
	buildTables=new
	buildHeatsources=new
	buildSigns=new

	buildRocks=new
	buildEdges=new
	buildSurf=new

	buildBushes=new
	buildPlants=new
	buildTrees=new

	propMisc=new
	all=new

/*

AddBuilds() adds whatever the player is allowed to build to one of these list.

*/

proc/AddBuilds()

	global.buildRoofs = grabTypes("/turf/Upgradeable/Roofs")
	global.buildWalls = grabTypes("/turf/Upgradeable/Walls")
	global.buildDoors = grabTypes("/obj/Door",grabparent=TRUE)

	global.buildGrass = grabTypes("/turf/Terrain/Grass")
	global.buildGround = grabTypes("/turf/Terrain/Ground")
	global.buildSky = grabTypes("/turf/Terrain/Sky")
	global.buildStairs = grabTypes("/turf/Terrain/Stairs")
	global.buildTiles = grabTypes("/turf/Terrain/Tiles")
	global.buildWater = grabTypes("/turf/Terrain/Water")
	global.terrainMisc = grabTypes("/turf/Terrain/Misc")

	global.buildBeds = grabTypes("/obj/Props/Beds")
	global.buildChairs = grabTypes("/obj/Props/Chairs")
	global.buildTables = grabTypes("/obj/Props/Tables")
	global.buildHeatsources = grabTypes("/obj/Props/Heatsources")
	global.buildSigns = grabTypes("/obj/Props/Sign",grabparent=TRUE)

	global.buildRocks = grabTypes("/obj/Props/Rocks")
	global.buildEdges = grabTypes("/obj/Props/Edges")
	global.buildSurf = grabTypes("/obj/Props/Surf")

	global.buildBushes = grabTypes("/obj/Props/Bushes")
	global.buildPlants = grabTypes("/obj/Props/Plants")
	global.buildTrees = grabTypes("/obj/Props/Trees")

	global.propMisc = grabTypes("/obj/Props/Misc")
	global.propMisc += grabTypes("/obj/Turfs/Glass")


	global.all += buildRoofs
	global.all += buildWalls
	global.all += buildDoors
	global.all += buildGrass
	global.all += buildGround
	global.all += buildSky
	global.all += buildStairs
	global.all += buildTiles
	global.all += terrainMisc
	global.all += buildChairs
	global.all += buildTables
	global.all += buildHeatsources
	global.all += buildSigns
	global.all += buildRocks
	global.all += buildEdges
	global.all += buildSurf
	global.all += buildBushes
	global.all += buildPlants
	global.all += buildTrees
	global.all += propMisc




	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] addbuilds()"

/*
	for(var/A in typesof(/obj/Door))
		var/obj/B=new A
		if(B) if(B.Buildable)
			var/obj/Build/C=new
			C.icon=B.icon
			C.icon_state=B.icon_state
			C.Creates=B.type
			C.name="[B.name]-B"
			global.buildDoors+=C
		del(B)
*/
/*

grabTypes()

Is the proc that populates the actual list, allowing you to choose wether or not it should include the parent

*/
proc/grabTypes(path,grabparent=FALSE)
	var/gatherTypes
	var/list/buildList = new

	if(grabparent)
		gatherTypes = typesof(text2path(path))
	else
		gatherTypes = childtypes(text2path(path))

	if(findtextEx(path,"turf",1,7))
		for(var/A in gatherTypes)
			var/turf/C=new A(locate(1,1,9))
			if(C) if(C.Buildable)
				var/obj/Build/B=new
				B.icon=C.icon
				B.icon_state=C.icon_state
				B.Creates=C.type
				B.name="[C.name]-B"
				buildList+=B
				del(C)
	else
		for(var/A in gatherTypes)
			var/obj/C=new A
			if(C) if(C.Buildable)
				var/obj/Build/B=new
				B.icon=C.icon
				B.icon_state=C.icon_state
				B.Creates=C.type
				B.name="[C.name]-B"
				buildList+=B
				del(C)

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] grabtypes()"

	if(path=="/turf/Terrain/Sky")
		var/obj/Turfs/CustomObj1/CO=new
		var/obj/Build/B=new
		B.icon=CO.icon
		B.icon_state=CO.icon_state
		B.Creates=CO.type
		B.name="Custom Obj"
		buildList+=B
		del(CO)

		var/turf/Upgradeable/CustomTurf/CT=new(locate(1,1,9))
		var/obj/Build/C=new
		C.icon=CT.icon
		C.icon_state=CT.icon_state
		C.Creates=CT.type
		C.name="Custom Turf"
		buildList+=C
		del(CT)

	return buildList
