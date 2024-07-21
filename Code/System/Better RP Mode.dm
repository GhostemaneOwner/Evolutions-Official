
mob/proc/RPMode()
	if(RPMode)
		var/image/AA=image('RPMode.dmi',layer=25)
		src.overlays-=AA
		RPMode=0
		view(src)<< "[src] disabled RP mode."
		if(KOd&&LethalCombatTracker) WillpowerGetUp()
	else
		Stop_TrainDig_Schedulers()
		var/image/AA=image('RPMode.dmi',layer=25)
		src.overlays+=AA
		RPMode=1
		src <<"[src] has entered RPMode."

mob/var/RPMode=0

mob/verb/RP_Mode() usr.RPMode()

