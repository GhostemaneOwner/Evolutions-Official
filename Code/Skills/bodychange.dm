mob/Admin4/verb
	Body_Take(mob/player/M in oview(usr))
		set category = "Admin"
		if(!usr.Confirm("Use Body Swap on [M]?")) return
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		M.DontDisconnect=1
		M.key=usr.client.key
		M.DontDisconnect=0

	Body_Swap(mob/player/M in oview(usr))
		set category = "Admin"
		if(!usr.Confirm("Use Body Swap on [M]?")) return
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/mob/player/C=new
		var/mob/player/P=usr
		var/client/MC=M.client
		C.HasCreated=1
		C.Savable=0
		P.Savable=0
		M.Savable=0
		C.DontDisconnect=1
		P.DontDisconnect=1
		M.DontDisconnect=1
		C.key=MC.key
		M.key=usr.client.key
		P.key=MC.key
		M.DontDisconnect=0
		P.DontDisconnect=0
		C.DontDisconnect=0
		del(C)
		