// Spamfilter uses the following two libraries:

//#include <deadron\texthandling\TextHandling.dme>


var/sf_SpamFilter/Phoenix
	gSpamFilter = new

sf_SpamFilter

	//============================================================================================
	var
		sf_maxLength			= MAX_MESSAGE_LEN
		global/sf_SpamControlOpen

	//============================================================================================
	proc
		//----------------------------------------------------------------------------------------
		//	Applies all of the default filters, tracks the number of messages,
		//	and mutes those who sent too many.
		sf_Filter(Chatter,Message)
			if ( !Message || src.sf_IsMuted(Chatter) )	return ""

			Message	= src.sf_FilterWhiteSpace(Chatter,Message)
			Message	= src.sf_FilterLength(Chatter,Message)
	//		Message	= src.sf_FilterCapitals(Chatter,Message)
			Message	= src.sf_FilterWords(Chatter,Message)

			src.sf_TrackChats(Chatter,Message)
			//	Mute if too much talk from the same client.
			if (sf_ChatsThisPeriod(Chatter) > src.sf_maxChatsPerPeriod)
				if ( src.sf_Mute(Chatter) )	return ""

			//	Clean up those who are not muted.
			src.sf_Unmute(Chatter)

			return Message

		//----------------------------------------------------------------------------------------
		//	Filters out shouting.
		//	By default, all this does is make messages which are all capitals be all lowercase.
		//	It's not perfect, but it's quick.
	/*	sf_FilterCapitals(Chatter,Message)
			//	Check for too many capital letters (shouting).
			if ( Message == uppertext(Message) )	Message	= lowertext(Message)
			return Message*/

		//----------------------------------------------------------------------------------------
		//  If the message is too long, it'll display the entire message to the author again and inform
		//  them that the message was too long. It will then reduce its length.
		//	Reduces the length of Message if it is too long and adds " ..." to the end.
		sf_FilterLength(Chatter,Message)
			if ( length(Message) > src.sf_maxLength)
				Chatter << Message
				Chatter << "<font color=yellow><b>SYSTEM :: </font>Your message was too long.</b>"
				Message = copytext(Message,1,src.sf_maxLength+1) + " ..."
			return Message

		//----------------------------------------------------------------------------------------
		//	Escapes HTML.  Removes tabs, new lines, and sequential spaces.
		sf_FilterWhiteSpace(Chatter,Message)
			Message	= html_encode(Message)
			Message	= dd_replacetext(Message, "\n", "")
			Message	= dd_replacetext(Message, "\t", "")
			//	Checking for 3 spaces.  Two would be normal after puncuation for some people.
			Message	= dd_replacetext(Message, "   ", "")
			if (Message == " ") Message	= ""

			return Message

		//----------------------------------------------------------------------------------------
		//	Filters words from the word list and replaces them with ****
		sf_FilterWords(Chatter,Message)

			var/p
			Message = " " + copytext(Message,1) + " "

			if(sf_wordfilter.len)
				for(var/i=1,i<=sf_wordfilter.len,i++)
					p = findtext(Message,sf_wordfilter[i])
					while(p)
						Message = copytext(Message,1,p) + "***" + copytext(Message,p+length(sf_wordfilter[i]))
						p = findtext(Message,sf_wordfilter[i])

			return Message

		//----------------------------------------------------------------------------------------
		//	Sets the maximum length a message can be.  It must be at least 1.
		//	Returns TRUE on success.
		sf_SetMaxLength(Amount=1)
			if ( !isnum(Amount) || (Amount < 1) )	return FALSE

			src.sf_maxLength	= Amount
			return TRUE

