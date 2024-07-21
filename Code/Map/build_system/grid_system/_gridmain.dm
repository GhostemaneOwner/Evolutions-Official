#define BUILD_CATS "grid_buildCats"
#define BUILD_SUBS "grid_buildSubs"
#define BUILD_CONTENT "grid_Build"
#define BUILDWINDOW "windowBuild"

// These lists are their settings (which categories do they have expanded?)
// and they're temporary because I doubt saving the list will add much of value.

var/list
	build_categ
	buildter_sub
	buildprop_sub

mob/var
	CanBuild=1


obj/Build

	Click(location)
		if(usr.HasBuildingPermit||usr.Rank||usr.BuildingPermit>Year)if(usr.CanBuild)
			if(usr.Target==src)
				usr<<"You have deselected [src]"
				usr.Target=null
				winset(usr.client, "mapwindow", "focus=false")
				return
			Build_Lay(src,usr)
			if(usr.Target!=src)
				usr.Target=src
				usr<<"You have selected [src]"
				/*var/column = text2num(copytext(location,1,2))+1
				var/row = text2num(copytext(location,3))
				var/obj/grid/SelectorR/A = new
				usr << output(A, "grid_buildObj:[column],[row]")*/
				//winshow(usr, BUILDWINDOW, 0)
				//sleep(1)
				//winshow(usr, BUILDWINDOW, 1)
				winset(usr.client, "mapwindow", "focus=false")
		else
			usr<<"You need the Building Permit milestone, to be a rank or to have a temporary building permit from a faction leader."
			return

