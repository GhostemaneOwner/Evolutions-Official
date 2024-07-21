
proc/wordcount(string)
	var/characters=length(string)
//Iteratethroughthestring,togglingstateifgoingfromanalphanumeric
//toanon-alphanumeric."'"isignoredandisconsideredtobethesame
//typeasthepreviouscharacter(e.g.,"that's"isoneword).
	var/alpha=0
	var/wordcount=0
	for(var/i=1,i<=characters,i++)
		switch(text2ascii(string,i))
			if(39)continue//apostrophe
			if(48 to 57,65 to 90,97 to 122)/*0-9,A-Z,a-z*/
//Encounteredanewword,increasewordcount
				if(!alpha) {alpha =! alpha; wordcount++}
			else
		//Wordended--ignorenon-alphanumericsuntilweencounteranotherword
				if(alpha){alpha=!alpha}
	return wordcount
	