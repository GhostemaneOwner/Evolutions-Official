

mob/proc/BlackWater()
	BlackWaterPower=1
	contents+=new/Skill/Misc/HiveMind
	src<<"You have been infected by the Black Water and as such you must obey the water's owner. (Like being Majinized. You have a verb to resist the power and you may RP attempting to break out\
by using the verb.  If you fail, you will need to wait for a cooldown.) Any commands they issue you telepathically must be obeyed.  You are still able to communicate, but you will be angry and violent."

mob/proc/RemoveBlackWater()
	BlackWaterPower=0
//

Skill/Black_Water_Infect
	desc="Using this will attempt to infect someone with the Black Water. If successful, you will forcibly control them to act violent and attack those you command.  Both of you will\
get an equal increase in power.  They may try to break free at anytime with a verb that has a cooldown. (6 month CD)"
	Experience=100
	var/Infects=10
	var/tmp/Infecting=0
	var/LastUse=0
	verb/Black_Water_Infect()
		set category="Skills"
		set desc="Using this will attempt to infect someone with the Black Water. If successful, you will forcibly control them to act violent and attack those you command.  Both of you will\
get an equal increase in power.  They may try to break free at anytime with a verb that has a cooldown. (6 month CD)"
		if(!Infects) return
		if(Infecting) return
		if(LastUse+0.5>Year)
			usr<<"You can only do this once every six months."
			return
		Infecting=1
		var/list/People=new
		for(var/mob/A in oview(usr)) if(A.client&&!A.BlackWaterPower) if(A.Race!="Android")if(A.Race!="Demon")if(A.Race!="Kaio")if(A.Race!="Bio-Android")if(A.Race!="Majin")if(A.Class!="Legendary")People+=A
		//People+="Cancel"
		var/mob/B=input("Who? (Androids, Demon, Kaio and rares are immune)") in People
		if(!usr.Confirm("Infect [B]?")) return
		if(locate(/Skill/Buff/Mystic) in B)
			usr<<"They are somehow immune."
			return
		switch(input(B.client,"[usr] is trying to infect you with the Black Water Mist... Do you want to resist?") in list("Yes","No"))
			if("Yes")
				usr<<"[B] attempts to resist..."
				var/ResC=B.EndMod*15
				if(ResC<40) ResC=40
				if(ResC>90) ResC=90
				if(!prob(ResC))
					view(B)<<"[B] has failed to resist and is overtaken by the Black Water Mist..."
					Infects--
					LastUse=Year
					B.BlackWater()
					usr.BlackWaterPower+=0.35
					if(usr.BlackWaterPower>2.5) usr.BlackWaterPower=2.5
				Infecting=0
			if("No")
				view(B)<<"[B] has accepted the mist's takeover and surrendered to [usr]'s will."
				Infects--
				B.BlackWater()
				usr.BlackWaterPower+=0.2
				if(usr.BlackWaterPower>2)usr.BlackWaterPower=2
				Infecting=0
	verb/Black_Water_Remove()
		set category="Skills"
		var/list/People=new
		People+="Cancel"
		for(var/mob/player/A in Players) if(A.BlackWaterPower) People+=A
		var/mob/B=input("Remove Black Water Powers from who?") in People
		if(B=="Cancel") return
		B.RemoveBlackWater()
		Infects++
	verb/Sense_Black_Water()
		set category="Skills"
		if(Infects) usr<<"You have enough water left for [Infects] more infections."
		else usr<<"You have run out of water for any new infections."
		for(var/mob/A in Players) if(A.BlackWaterPower) usr<<"You can sense the Black Water within [A]."



mob/var/HiveMind

Skill/Misc/HiveMind
	Experience=100
	verb/Hive_Telepathy()
		set src=usr.contents
		set instant=1
		if(usr.Dead)
			usr << "Unable to do this while deceased."
			return
		var/message=input("Say what in Hive Telepathy?") as text
		usr << "<span class=\"telepathy\"><font size=[usr.TextSize]>You say in Hive Telepathy \"[message]\"</font></span>"
		usr.saveToLog("<span class=\"telepathy\">You say in Hive Telepathy \"[message]\"</span>\n")
		for(var/mob/player/M in Players)
			if(M.HiveMind==usr.HiveMind)
				if(!message) return
				if(M)
					M << "<span class=\"telepathy\"><font size=[M.TextSize]>[usr] says in Hive Telepathy, \"[message]\"</font></span>"
					M.saveToLog("<span class=\"telepathy\">| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Hive Telepathy: \"[message]\"</span>\n")


