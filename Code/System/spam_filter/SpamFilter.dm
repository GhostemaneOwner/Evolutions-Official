sf_SpamFilter

	//============================================================================================
	var
		list/sf_chatterToChatsInPeriod

		sf_period				= 40
		sf_maxChatsPerPeriod	= 5

	//============================================================================================
	New()
		..()
		src.sf_chatterToChatsInPeriod	= list()
		src.sf_wordfilter				= list()
		//src.sf_Load()

	//============================================================================================
	proc
		//----------------------------------------------------------------------------------------
		//	Returns the number of messages Chatter sent during their current period.
		sf_ChatsThisPeriod(Chatter)
			if (Chatter in src.sf_chatterToChatsInPeriod)
				return src.sf_chatterToChatsInPeriod[Chatter]
			return 0

		//----------------------------------------------------------------------------------------
		//	Returns the chat settings to their initial state.
		//	Old chats are erased from the tracker.
		//	Those who were muted can speak again.
		//	Returns TRUE on success.
		sf_Defaults()
			var/chatter
			for(chatter in src.sf_chatterToChatsInPeriod)
				src.sf_chatterToChatsInPeriod[chatter]	= 0
			for(chatter in global.MutedList)				global.MutedList[chatter]	= 0

			src.sf_maxLength			= initial(sf_maxLength)
			src.sf_period				= initial(sf_period)
			src.sf_maxChatsPerPeriod	= initial(sf_maxChatsPerPeriod)
			src.sf_punishment			= initial(src.sf_punishment)

			return TRUE

		//----------------------------------------------------------------------------------------
		//	Sets the maximum amount of messages a chatter can send during a period.
		//	It must be at least 1.
		//	Returns TRUE on success.
		sf_SetMaxChatsPerPeriod(Amount=1)
			if ( !isnum(Amount) || (Amount < 1) )	return FALSE

			var/difference				= src.sf_maxChatsPerPeriod
			src.sf_maxChatsPerPeriod	= Amount
			difference					= src.sf_maxChatsPerPeriod - difference

			//	Don't count an old, larger number of chats against chatters.
			if (difference < 0)
				for(var/chatter in src.sf_chatterToChatsInPeriod)
					src.sf_chatterToChatsInPeriod[chatter]	+= difference

			return TRUE

		//----------------------------------------------------------------------------------------
		//	Sets the number of ticks during which a chatter's messages will be counted.
		//	It must be at least 1.
		//	Returns TRUE on success.
		//	If Amount is less than the current period, then old chat counts will be erased.
		sf_SetPeriod(Amount=1)
			if ( !isnum(Amount) || (Amount < 1) )	return FALSE

			if (Amount < src.sf_period)
				for(var/chatter in src.sf_chatterToChatsInPeriod)
					src.sf_chatterToChatsInPeriod[chatter]	= 0

			src.sf_period	= Amount

			return TRUE

		//----------------------------------------------------------------------------------------
		sf_SetWordFilter(filter)
			if ( isnull(filter) || !filter ) return FALSE

			src.sf_wordfilter = filter

			return TRUE


		//----------------------------------------------------------------------------------------
		//	Keeps track of how many messages Chatter sent.
		//	Returns FALSE if there is no message to track or Chatter can not be muted.
		sf_TrackChats(Chatter,Message)
			//	Don't track empty messages.
			if ( !Message || !src.sf_CanMute(Chatter) )	return	FALSE

			//	Count chats per period.
			var/chatsThisPeriod	= 1
			if (Chatter in src.sf_chatterToChatsInPeriod)
				chatsThisPeriod	+= src.sf_chatterToChatsInPeriod[Chatter]

			//	Record the number.
			src.sf_chatterToChatsInPeriod[Chatter]		= chatsThisPeriod
			spawn(src.sf_period)
				src.sf_chatterToChatsInPeriod[Chatter]	-= 1
				if (src.sf_chatterToChatsInPeriod[Chatter] <= 0)
					src.sf_chatterToChatsInPeriod		-= Chatter

			return TRUE
