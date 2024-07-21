obj/items/Soccer_Ball
	desc="Used for playing soccer."
	icon='soccerball.dmi'
	Health=50000
	density=1
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
