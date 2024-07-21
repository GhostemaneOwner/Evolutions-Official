//Health & Ki

mob/var
	Icon_Obj/HealthBar=new/Icon_Obj/HealthBar
	Icon_Obj/EnergyBar=new/Icon_Obj/EnergyBar

mob/var/list/Bars=list()
mob/var/BarToggle=1

mob/verb
	Graphics_Options()
		set category=null
		var/PP=input("Change what option?","Graphics Options") in list("Set FPS","Screen Size","Toggle Scouter Overlays","Toggle Body Part HUD","Show HUD","Text Size","Cancel")
		switch(PP)
			if("Set FPS") Set_Client_FPS()
			if("Toggle Body Part HUD") Toggle_BodyHUD()
			if("Show HUD") Show_HUD()
		//	if("Show Popup Chat") PopupChat()
			if("Text Size") Text_Size()
			if("Screen Size") Screen_Size()
			if("Toggle Scouter Overlays")Toggle_Scouter_Overlays()
			if("Adjust Status Bar X/Y") Adjust_Status_Bars()
//			if("Toggle Team Overlays")Toggle_Team_Overlays()

	Customization_Options()
		set category=null
		var/PP=input("Change what option?","Customization Options") in list("Change Icon","Change X/Y or Layer","Change Hair","Get Clothes","Text Color","Customize Ability Icons","Adjust Status Bar X/Y","Cancel")
		switch(PP)
			if("Change Icon") Change_IconP()
			if("Get Clothes") Clothes()
			if("Change Hair") Hair()
			if("Text Color") Text_Color()
			if("Adjust Status Bar X/Y") Adjust_Status_Bars()
			if("Change X/Y or Layer") AdjustXY()
			if("Customize Ability Icons") Customize()


	Set_Client_FPS()
		set hidden=1
		var/NewStatLag = input("Please set your requested FPS: Choosing 0 will default to the server settings") as num
		if(NewStatLag<=0) NewStatLag=world.fps
		client.fps=NewStatLag


/*
mob/verb/Toggle_Status_Bars()
	set category=null//"Other"
	if(BarToggle)
		BarToggle=0
		addBars()
		updateBars()
	else
		BarToggle=1
		addBars()
		updateBars()*/


mob/verb/Adjust_Status_Bars()
	set category=null
	HealthBar.pixel_x=input("Choose the pixel X for the status bars.") as num
	if(HealthBar.pixel_x>64)HealthBar.pixel_x=64
	if(HealthBar.pixel_x<-64)HealthBar.pixel_x=-64
	EnergyBar.pixel_x=HealthBar.pixel_x
	HealthBar.pixel_y=input("Choose the pixel Y for the status bars.") as num
	HealthBar.pixel_y=HealthBar.pixel_y+4
	if(HealthBar.pixel_y>64)HealthBar.pixel_y=64
	if(HealthBar.pixel_y<-64)HealthBar.pixel_y=-64
	EnergyBar.pixel_y=HealthBar.pixel_y
	//updateBars()

//	for(var/O in Bars)
//		overlays-=O
//		overlays+=O


Icon_Obj/HealthBar
	icon = 'Health_and_Energy_bars.dmi'
	icon_state="HP Overlay"
	layer = EFFECTS_LAYER+100
	Health=10000000
	//invisibility=1
	appearance_flags=RESET_TRANSFORM | KEEP_APART
	mouse_opacity = 0
	pixel_y=4
Icon_Obj/EnergyBar
	icon = 'Health_and_Energy_bars.dmi'
	icon_state="Energy Overlay"
	layer = EFFECTS_LAYER+100
	appearance_flags=RESET_TRANSFORM | KEEP_APART
	Health=10000000
//	invisibility=2
	mouse_opacity = 0
	pixel_y=4

/*mob/proc/addBars() if(BarToggle)
	var/skill=1
	if(MaxKi>=3000/KiMod) skill++
	if(MaxKi>=5000/KiMod) skill++
	if(skill==3)
		for(var/mob/player/P in view(12))if(!P.adminDensity) for(var/O in P.Bars) if(!istype(O,/Icon_Obj/LethalBar))
			var/BarOver = image (O,P)
			usr<<BarOver
			spawn(17) del BarOver
	if(skill==2)
		for(var/mob/player/P in view(12))if(!P.adminDensity) for(var/O in P.Bars) if(istype(O,/Icon_Obj/HealthBar))
			var/BarOver = image (O,P)
			usr<<BarOver
			spawn(17) del BarOver
*/
mob/proc/updateBars()
	if(Health/MaxHealth>0.95) HealthBar.icon_state="HP 100%"
	else if(Health/MaxHealth<0.95 && Health/MaxHealth>0.89) HealthBar.icon_state="HP 92%"
	else if(Health/MaxHealth<0.89 && Health/MaxHealth>0.80) HealthBar.icon_state="HP 85%"
	else if(Health/MaxHealth<0.80 && Health/MaxHealth>0.76) HealthBar.icon_state="HP 78%"
	else if(Health/MaxHealth<0.76 && Health/MaxHealth>0.70) HealthBar.icon_state="HP 75%"
	else if(Health/MaxHealth<0.70 && Health/MaxHealth>0.63) HealthBar.icon_state="HP 66%"
	else if(Health/MaxHealth<0.63 && Health/MaxHealth>0.55) HealthBar.icon_state="HP 60%"
	else if(Health/MaxHealth<0.55 && Health/MaxHealth>0.45) HealthBar.icon_state="HP 50%"
	else if(Health/MaxHealth<0.45 && Health/MaxHealth>0.39) HealthBar.icon_state="HP 41%"
	else if(Health/MaxHealth<0.39 && Health/MaxHealth>0.29) HealthBar.icon_state="HP 35%"
	else if(Health/MaxHealth<0.29 && Health/MaxHealth>0.19) HealthBar.icon_state="HP 25%"
	else if(Health/MaxHealth<0.19 && Health/MaxHealth>0.13) HealthBar.icon_state="HP 16%"
	else if(Health/MaxHealth<0.13 && Health/MaxHealth>0.6) HealthBar.icon_state="HP 10%"
	else if(Health/MaxHealth<0.6 && Health/MaxHealth>0) HealthBar.icon_state="HP 3%"
	else if(Health/MaxHealth<=0) HealthBar.icon_state="HP 0%"
	if(round(Ki/MaxKi*100)>=95) EnergyBar.icon_state="Energy 100%"
	else if(round(Ki/MaxKi*100)<95&& round(Ki/MaxKi*100)>89) EnergyBar.icon_state="Energy 92%"
	else if(round(Ki/MaxKi*100)<89&& round(Ki/MaxKi*100)>80) EnergyBar.icon_state="Energy 85%"
	else if(round(Ki/MaxKi*100)<80&& round(Ki/MaxKi*100)>76) EnergyBar.icon_state="Energy 78%"
	else if(round(Ki/MaxKi*100)<76 && round(Ki/MaxKi*100)>70) EnergyBar.icon_state="Energy 75%"
	else if(round(Ki/MaxKi*100)<70&& round(Ki/MaxKi*100)>63) EnergyBar.icon_state="Energy 66%"
	else if(round(Ki/MaxKi*100)<63 && round(Ki/MaxKi*100)>55) EnergyBar.icon_state="Energy 60%"
	else if(round(Ki/MaxKi*100)<55 && round(Ki/MaxKi*100)>45) EnergyBar.icon_state="Energy 50%"
	else if(round(Ki/MaxKi*100)<45&& round(Ki/MaxKi*100)>39) EnergyBar.icon_state="Energy 41%"
	else if(round(Ki/MaxKi*100)<39 && round(Ki/MaxKi*100)>29) EnergyBar.icon_state="Energy 35%"
	else if(round(Ki/MaxKi*100)<29 && round(Ki/MaxKi*100)>19) EnergyBar.icon_state="Energy 25%"
	else if(round(Ki/MaxKi*100)<19&& round(Ki/MaxKi*100)>13) EnergyBar.icon_state="Energy 16%"
	else if(round(Ki/MaxKi*100)<13 && round(Ki/MaxKi*100)>6) EnergyBar.icon_state="Energy 10%"
	else if(round(Ki/MaxKi*100)<6&& round(Ki/MaxKi*100)>0) EnergyBar.icon_state="Energy 3%"
	else if(round(Ki/MaxKi*100)<0) EnergyBar.icon_state="Energy 0%"
	if(Race=="Android"||AndroidLevel||HelmetOn>=2)
		EnergyBar.icon_state="Energy 0%"
		HealthBar.icon_state="HP 0%"
	overlays-=HealthBar
	overlays-=EnergyBar
	overlays+=HealthBar
	overlays+=EnergyBar
	/*Bars=list()
	Bars+=HealthBar
	Bars+=EnergyBar*/
	//Bars+=LethalBar
	//for(var/O in Bars) overlays-=image(O)
	//if(!afk) addBars()


