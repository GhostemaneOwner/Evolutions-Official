mob/var/OldDanceIcon
mob/verb/SlashDance()
	set hidden=1
	if(!OldDanceIcon)
		OldDanceIcon=icon
		icon='Michael Jackson.dmi'
	else
		icon=OldDanceIcon
		OldDanceIcon=null
		