/*
Categories:

Roofs	(/turf/Upgradeable/Roofs)

Walls	(/turf/Upgradeable/Walls)

Doors 	(/obj/Door)

Terrain (thing which change the terrain)
	> Grass			(/turf/Terrain/Grass)
	> Ground		(/turf/Terrain/Ground)
	> Sky			(/turf/Terrain/Sky)
	> Stairs		(/turf/Terrain/Stairs)
	> Tiles			(/turf/Terrain/Tiles)
	> Water			(/turf/Terrain/Water)
	> Misc			(/turf/Terrain/Misc)

Props (things which decorate)
	> Chairs		(/obj/Props/Chairs)
	> Tables		(/obj/Props/Tables)
	> Heatsources	(/obj/Props/Heatsources)
	> Signs			(/obj/Props/Signs)

	> Rocks			(/obj/Props/Rocks)
	> Edges			(/obj/Props/Edges)
	> Surf			(/obj/Props/Surf)

	> Bushes 		(/obj/Props/Bushes)
	> Plants		(/obj/Props/Plants)
	> Trees			(/obj/Props/Trees)

	> Misc			(/obj/Props/Misc)
*/


/*

######### Vars #########

*/
mob/var/BuildIsFree=0
turf/var/FlyOverAble=1
atom/var/Buildable=1

var/list/Turfs = new // List of all user-built turfs.
var/list/CreatedItems
var/Wall_Strength=60


obj/Build
	var/Creates
mob/var/BuildWithMana=0
mob/var/OutsideBuild=0
mob/var/BuildLayer=0
mob/verb/ChangeBuildCost()
	set category=null
	BuildWithMana=!BuildWithMana
	if(BuildWithMana) usr<<"Now using mana for building."
	else usr<<"Now using resources for building."
mob/verb/ChangeBuildOutside()
	set category=null
	OutsideBuild=!OutsideBuild
	if(OutsideBuild) usr<<"Your buildings will now be considered outside/diggable."
	else usr<<"Your buildings will now be considered inside/nondiggable."
mob/verb/ChangeBuildLayer()
	set category=null
	BuildLayer=input("What layer would you like your built objects to be on? (0 will reset to the objects default)") as num
	if(BuildLayer<0) BuildLayer=0
	if(BuildLayer>10) BuildLayer=10
	BuildLayer=round(BuildLayer)
	usr<<"Build Layer set to [BuildLayer==0?"Default":"[BuildLayer]"]."



mob
	verb
		Roofs()
			usr.BuildTab = "Roofs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Walls()
			usr.BuildTab = "Walls"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Doors()
			usr.BuildTab = "Doors"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Grass()
			usr.BuildTab = "Grass"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Ground()
			usr.BuildTab = "Ground"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Sky()
			usr.BuildTab = "Sky"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Stairs()
			usr.BuildTab = "Stairs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Tiles()
			usr.BuildTab = "Tiles"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Water()
			usr.BuildTab = "Water"
			usr.BuildOpen = 0
			usr.OpenBuild()
		TerrainMisc()
			usr.BuildTab = "Terrain Misc"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Beds()
			usr.BuildTab = "Beds"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Chairs()
			usr.BuildTab = "Chairs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Tables()
			usr.BuildTab = "Tables"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Heat()
			usr.BuildTab = "Heat"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Signs()
			usr.BuildTab = "Signs"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Rocks()
			usr.BuildTab = "Rocks"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Edges()
			usr.BuildTab = "Edges"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Surf()
			usr.BuildTab = "Surf"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Bushes()
			usr.BuildTab = "Bushes"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Plants()
			usr.BuildTab = "Plants"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Trees()
			usr.BuildTab = "Trees"
			usr.BuildOpen = 0
			usr.OpenBuild()
		Misc()
			usr.BuildTab = "Misc"
			usr.BuildOpen = 0
			usr.OpenBuild()
		OpenBuild()
			set name = ".OpenBuild"
			if(!HasBuildingPermit&&!usr.Rank&&usr.BuildingPermit<Year)
				usr<<"You need the Building Permit milestone, to be a rank or to have a temporary building permit from a faction leader."
				return
			if(usr.BuildOpen == 0)
				usr.BuildOpen = 1
				winshow(usr.client,"new_build",1)
				var/I = 1
				winset(usr.client, "new_build.new_build_grid", "cells=0x0")
				usr << output(null, "new_build.new_build_grid")
				if(usr.BuildTab == "Roofs")
					for(var/atom/a in global.buildRoofs)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Walls")
					for(var/atom/a in global.buildWalls)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Doors")
					for(var/atom/a in global.buildDoors)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Grass")
					for(var/atom/a in global.buildGrass)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Ground")
					for(var/atom/a in global.buildGround)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Sky")
					for(var/atom/a in global.buildSky)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")

				if(usr.BuildTab == "Stairs")
					for(var/atom/a in global.buildStairs)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Tiles")
					for(var/atom/a in global.buildTiles)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Water")
					for(var/atom/a in global.buildWater)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Terrain Misc")
					for(var/atom/a in global.terrainMisc)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Beds")
					for(var/atom/a in global.buildBeds)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Chairs")
					for(var/atom/a in global.buildChairs)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Tables")
					for(var/atom/a in global.buildTables)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Heat")
					for(var/atom/a in global.buildHeatsources)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Signs")
					for(var/atom/a in global.buildSigns)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Rocks")
					for(var/atom/a in global.buildRocks)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Edges")
					for(var/atom/a in global.buildEdges)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Surf")
					for(var/atom/a in global.buildSurf)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Bushes")
					for(var/atom/a in global.buildBushes)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Plants")
					for(var/atom/a in global.buildPlants)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Trees")
					for(var/atom/a in global.buildTrees)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				if(usr.BuildTab == "Misc")
					for(var/atom/a in global.propMisc)
						I += 1
						winset(usr.client, "new_build.new_build_grid", "cells=1x[I]")
						winset(usr.client, "new_build.new_build_grid", "current-cell=1,[I]")
						usr << output(a, "new_build.new_build_grid")
				return
			else
				usr.BuildOpen = 0
				winshow(usr.client,"new_build",0)
				return

