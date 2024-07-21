


mob/proc/WillpowerGetUp() if(Willpower>1&&KOd)
	Un_KO()
	Health=Willpower
	view(src)<<"[src] struggles back to their feet."
mob/var/tmp/WillpowerFailure=0

mob/proc/WillpowerFailure()
	if(Willpower<=0&&!WillpowerFailure)
		Willpower=0
		WillpowerFailure=1
		src<<"You have lost all of your Willpower and require an outside influence to restore yourself or wait until your combat timer runs out."
		src<<"You may choose to die at any point in time while at 0 Willpower.  In order to die, please Ahelp with a request and explanation of the circumstances."


mob/proc/WillpowerFill()
	Willpower=MaxWillpower
	src<<"You have fully restored your Willpower."

mob/var/tmp/WPRC=0
mob/proc/WillpowerRestoreCheck() if(Willpower<=0)
	WPRC++
	if(Willpower<=0&&WPRC>=60)//&&!LethalCombatTracker
		WPRC=0
		Willpower=1
		Un_KO()
		WillpowerFailure=0
		src<<"You have finally woken up and regained some Willpower.  You are still severely injured and will require time to get back to full strength."

mob/proc/WillpowerRestore() if(Willpower<=0)
	Willpower=1
	WillpowerFailure=0
	src<<"You have been healed some how and now have 1 Willpower.  You are still severely injured and will require time to get back to full strength."
