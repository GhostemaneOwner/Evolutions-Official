






/*
mob/var/Icon_Obj/StatOverlay=null


mob/proc
	KOOverlay()
		set background=1
		set waitfor=0
		if(client) if(SOverlayToggle)
			RemoveStatOverlays()
			var/Icon_Obj/KOOverlay/L = new
			L.screen_loc = "CENTER"
			client.screen.Add(L)
			StatOverlay = L
			animate(L, transform = matrix()*50, time = 5)
	AngerOverlay()
		set background=1
		set waitfor=0
		if(client) if(SOverlayToggle&&!StatOverlay)
			RemoveStatOverlays()
			var/Icon_Obj/AngerOverlay/L = new
			L.screen_loc = "CENTER"
			client.screen.Add(L)
			StatOverlay = L
			animate(L, transform = matrix()*50, time = 5)
	RemoveStatOverlays()
		set background=1
		set waitfor=0
		if(client)
			client.screen -= StatOverlay
			del(StatOverlay)
			StatOverlay=null*/
mob/proc
	BlindOverlay()
		set background=1
		set waitfor=0
		if(SOverlayToggle)
			//RemoveBlind()
			if(!Blindness)
				var/Icon_Obj/Blindness/L = new
				L.screen_loc = "CENTER"
				client.screen.Add(L)
				Blindness = L
				spawn(1) animate(L, transform = matrix()*50, time = 5)
	RemoveBlind()
		set background=1
		set waitfor=0
		if(client)
			client.screen -= Blindness
			del(Blindness)
			Blindness=null




Icon_Obj/Blindness
	icon = 'Screen Overs.dmi'
	icon_state="Blind"
	layer = 100
	mouse_opacity = 0


Icon_Obj/KOOverlay
	icon = 'Screen Overs.dmi'
	icon_state ="KO"
	layer = 100
	mouse_opacity = 0

Icon_Obj/SolidOverlay
	icon = 'Screen Overs.dmi'
	icon_state="Solid"
	layer=100
	mouse_opacity=0


Icon_Obj/AngerOverlay
	icon = 'Screen Overs.dmi'
	icon_state="Anger"
	layer = 100
	mouse_opacity = 0




