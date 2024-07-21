sf_SpamFilter

	//============================================================================================
	var

		sf_punishment	= 600//1*60*10	Roughly 1 minute
		list/sf_wordfilter

	//============================================================================================
	proc
		//----------------------------------------------------------------------------------------
		//	Returns whether or not Chatter can be muted.
		//	It is called with the current Message for consistency.
		//	By default, it simply returns whether or not there is punishment time.
		//	However, it's probably a good idea to protect administrators from being muted as well.
		sf_CanMute(Chatter,Message)
			return (src.sf_punishment > 0)

		//----------------------------------------------------------------------------------------
		//	Returns the ID stored in the mute list to represent Chatter.
		//	It should persist so the chatter can't logout and then login again to delete the effect.
		//	By default, this is the ckey if Chatter is a mob or client and null otherwise.
		sf_ID(Chatter)
			if ( istype(Chatter,/client) )
				var/client/C	= Chatter
				return ckey(C.key)
			if ( ismob(Chatter) )
				var/mob/M	= Chatter
				return ckey(M.key)
			return null

		//----------------------------------------------------------------------------------------
		//	Returns whether or not Candidate is muted.
		sf_IsMuted(Candidate)
			if(src==null) src = usr
			if(!Candidate) return FALSE
			Candidate							= src.sf_ID(Candidate)
			if (!(Candidate in global.MutedList))	return FALSE
			return (global.MutedList[Candidate] > world.realtime)

		//----------------------------------------------------------------------------------------
		//	Attempts to mute Chatter for the current amount of punishment time.
		//	Returns TRUE on success.
		sf_Mute(Chatter)
			if ( !src.sf_CanMute(Chatter) || src.sf_IsMuted(Chatter) )	return FALSE

			global.MutedList[src.sf_ID(Chatter)]	= world.realtime + src.sf_punishment

			//var/derp = src.sf_ID(Chatter)

			world << "<font color=yellow><b>ANTI-SPAM :: </font>[sf_ID(Chatter)] has been automatically muted.</b>"
			//world << "<font color=red><b>DEBUG9 :: </font>Muted list contains: [list2params(global.MutedList)].</b>"
			logAndAlertAdmins("[key_name_admin(Chatter)] has been automatically muted.", 2)

			spawn(5) src.sf_MutedCheck(Chatter)

			return TRUE

		//----------------------------------------------------------------------------------------
		//	Sets the number of ticks a chatter can be punished for spamming.
		//	Returns TRUE on success and the currently muted are affected.
		sf_SetPunishment(Amount=0)
			if ( !isnum(Amount) )	return FALSE

			var/difference			= src.sf_punishment
			src.sf_punishment		= Amount
			difference				= src.sf_punishment - difference

			//	Adjust the time of those currently muted.
			for(var/chatter in global.MutedList)	global.MutedList[chatter]	+= difference

			return TRUE

		//----------------------------------------------------------------------------------------
		//	Attempts to remove Chatter's ID from the group of muted IDs.
		//	Returns TRUE on success.
		sf_Unmute(Chatter)
			if(src==null) src = usr
			var/id	= src.sf_ID(Chatter)
			if (id in global.MutedList)
				global.MutedList	-= id
				//world << "<font color=red><b>DEBUG7 :: </font>[Chatter] was unmuted. <br> Muted list contains: [list2params(global.MutedList)].</b><br>called by [src]"

				Chatter << "<font color=yellow><b>SYSTEM :: </font>You have been unmuted.</b>"

				return TRUE
			return FALSE

		sf_MutedCheck(Chatter)
			//world << "<font color=red><b>DEBUG77 :: </font>sf_MutedCheck is running for [Chatter].</b>"
		//	var/id = src.sf_ID(Chatter)  Caps filter possibility 1
			while(1)

				if(!Chatter) break

				if(world.realtime >= global.MutedList[src.sf_ID(Chatter)])
					//world << "<font color=red><b>DEBUG133 :: </font>sf_MutedCheck is running for [Chatter].</b>"
					logAndAlertAdmins("[key_name_admin(Chatter)] has been automatically unmuted.", 2)
					sf_Unmute(Chatter)
					break

				//world << "<font color=red><b>DEBUG33 :: </font>sf_MutedCheck is running for [Chatter].</b><br>
			//	world.realtime = [world.realtime] || world.time = [world.time]<br> 
			//	Muted list contains: [list2params(global.MutedList)]"
				sleep(50)
				