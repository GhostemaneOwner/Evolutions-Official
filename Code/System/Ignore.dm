

mob/verb/Ignore()
	if(CanPing)
		var/list/Is=new
		CanPing=0
		for(var/mob/M in Players) Is+=M.lastKnownKey
		Is+="Cancel"
		var/I=input("Ignore who?") in Is
		if(I=="Cancel")
			spawn(300) CanPing=1
			return
		else
			Ignores+=I
		spawn(300) CanPing=1



mob/verb/Remove_Ignore()
	if(CanPing)
		CanPing=0
		var/I=input("Remove which ignore?") in usr.Ignores
		if(usr.Confirm("Stop ignoring [I]?")) del(I)
		spawn(300) CanPing=1
