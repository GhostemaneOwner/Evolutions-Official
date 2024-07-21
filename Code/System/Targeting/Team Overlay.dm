


//mob/var/TeamDisplay=1//<span style=font-size:4pt>
/*mob/verb/Toggle_Team_Overlays()
	set category=null
	if(usr.TeamDisplay)
		usr.TeamDisplay = 0
		usr << "You have made Team overlays hidden."
		return
	else
		usr.TeamDisplay = 1
		usr << "You have made Team overlays show."
		return*/

mob
	proc
		addTeams()
			for(var/mob/P in view(15))
				if(Team&&P.Team==Team&&P!=src)
					if(client)//if it is a client(real person)
						var/teamoverlay
						teamoverlay = image('Team Icon.dmi',P,pixel_x=P.HealthBar.pixel_x,pixel_y=8+P.HealthBar.pixel_y)//calls icon from life.dmi, attaches icon to mob, icon state = flash
						src << teamoverlay  //only allow the usr to see it
						spawn(16) del teamoverlay
						