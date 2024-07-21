

mob/var/MacroType=1
mob/verb/ChangeMacro()
	set hidden=1
	MacroType++
	if(MacroType>3) MacroType=1
	if(MacroType==1)
		usr<<"Arrow Keys used for movement."
		winset(client, "mainwindow", "macro = macro")
	if(MacroType==2)
		usr<<"WASD used for movement."
		winset(client, "mainwindow", "macro = macro2")
	if(MacroType==3)
		usr<<"Arrow Keys AND WASD used for movement."
		winset(client, "mainwindow", "macro = macro3")

client
	var
		north = 0				//Keep track of movement key presses. See also movement_macros.dms.
		east = 0
		south = 0
		west = 0



	North()	//Player is trying to go northward.
		north = 1					//North was activated. Keep track of this.
		if(east) Northeast()		//If east is also activated, then move Northeast.
		else if(west) Northwest()	//Else if west is also activated, then move Northwest.
		else ..()
	East()
		east = 1
		if(north) Northeast()
		else if(south) Southeast()
		else ..()
	South()
		south = 1
		if(east) Southeast()
		else if(west) Southwest()
		else ..()
	West()
		west = 1
		if(north) Northwest()
		else if(south) Southwest()
		else ..()

	verb
		NorthReleased()
			set hidden = 1
			set instant=1
			north = 0
		EastReleased()
			set hidden = 1
			set instant=1
			east = 0
		SouthReleased()
			set hidden = 1
			set instant=1
			south = 0
		WestReleased()
			set hidden = 1
			set instant=1
			west = 0
