

mob/verb/RefreshStatus()
	Get_PlayerAssess()

mob/var/sfocus="Balanced"
mob/verb
	Stat_Focus()
		set category=null//"Other"
		var/Choice=input(src,"Self Train Focus (Choosing Skills will gain a small amount of Speed/Off/Def instead of Might/End)","(Physical)") in list("Balanced","Might (Str/Force)","Endurance","Skills (Speed/Off/Def)")
		switch(Choice)
			if("Might (Str/Force)") pfocus="Might"
			if("Endurance") pfocus="Endurance"
			if("Balanced") pfocus="Balanced"
			if("Skills (Speed/Off/Def)") pfocus="Skills"

		Choice=input(src.client,"Spiritual Focus","(Spiritual)") in list("Balanced","Force","Energy")
		switch(Choice)
			if("Force") sfocus="Force"
			if("Energy") sfocus="Energy"
			if("Balanced") sfocus="Balanced"

		Choice=input(src.client,"Do you want to focus on Balanced, Offense, Defense or only Speed?","(Style)") in list("Balanced","Offense","Defense","Speed Only")
		switch(Choice)
			if("Offense") mfocus="Offense"
			if("Defense") mfocus="Defense"
			if("Balanced") mfocus="Balanced"
			if("Speed Only") mfocus="Speed Only"
		Choice=input(src.client,"Do you want to focus on Intelligence, Magical Skill, or Stats?","(Meditation)") in list("Intelligence","Magical Skill","Stats")
		switch(Choice)
			if("Intelligence")
				ifocus="Intelligence"
				magicfocus = 0
				if(HasPursuitOfKnowledge)
					ifocus="Intelligence"
					magicfocus="Magical Skill"
					usr<<"Pursuit of Knowledge activated. Gaining both Int and Magic."
			if("Magical Skill")
				magicfocus="Magical Skill"
				ifocus = 0
				if(HasPursuitOfKnowledge)
					ifocus="Intelligence"
					magicfocus="Magical Skill"
					usr<<"Pursuit of Knowledge activated. Gaining both Int and Magic."
			if("Stats")
				ifocus=0
				magicfocus=0
			if("Nothing")
				ifocus=5
				magicfocus=5
//		UpdateStats("All")
	Int_Focus()
		set category=null
		if(ifocus!="Intelligence")
			ifocus="Intelligence"
			magicfocus = 0
			usr<<"Intelligence gains on."
			if(HasPursuitOfKnowledge)
				ifocus="Intelligence"
				magicfocus="Magical Skill"
				usr<<"Pursuit of Knowledge activated. Gaining both Int and Magic."
		else
			ifocus = 0
			magicfocus = 0
			usr<<"Intelligence gains off."
	Magic_Focus()
		set category=null
		if(magicfocus!="Magical Skill")
			magicfocus="Magical Skill"
			ifocus = 0
			usr<<"Magic gains on."
			if(HasPursuitOfKnowledge)
				ifocus="Intelligence"
				magicfocus="Magical Skill"
				usr<<"Pursuit of Knowledge activated. Gaining both Int and Magic."
		else
			ifocus = 0
			magicfocus = 0
			usr<<"Magic gains off."
			