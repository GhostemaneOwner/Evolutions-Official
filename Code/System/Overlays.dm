// This is pretty straightforward.
// It's essentially a substitute variable that interfaces with the built in overlay and underlay lists so that
// They can be accessed a bit better. (Required for saving/loading purposes)

mob
	var/list/k_access

	proc
		AddAccess(A)
			if(!k_access) k_access = list()
			if(!A) return
			k_access += A
			UpdateOverlays()

		ClearAccess()
			if(k_access) k_access = list()
			UpdateOverlays()
			// done!

		RemoveAccess(A)
			if(!k_access) k_access = list()
			if(!A) return
			k_access -= A
			UpdateOverlays()



	UpdateOverlays()
		if(k_overlays) ..()
		if(k_access) overlays += k_access

//	BuildOverlays()
//		rebuildEquips()//this is for an independent equipment system

atom
	var
		list
			k_overlays
			k_underlays

	movable
		New()
			..()
			UpdateOverlays()

	proc
		AddOverlay(A)
			if(!A) return
			if(!k_overlays) k_overlays = list()
			if(islist(A))
				world << islist(A)
				k_overlays |= A
			else k_overlays += A
			UpdateOverlays()

		AddUnderlay(A)
			if(!A) return
			if(!k_underlays) k_underlays = list()
			k_underlays += A
			UpdateUnderlays()

		ClearOverlay()
			if(k_overlays) k_overlays = list()
			UpdateOverlays()

		RemoveOverlay(A)
			if(!A) return
			if(!k_overlays) k_overlays = list()
			k_overlays -= A
			UpdateOverlays()

		RemoveUnderlay(A)
			if(!A) return
			if(!k_underlays) k_underlays = list()
			k_underlays -= A
			UpdateUnderlays()

		UpdateOverlays()
			overlays = list()
			overlays += k_overlays

		UpdateUnderlays()
			underlays = list()
			underlays += k_underlays

		BuildOverlays()

