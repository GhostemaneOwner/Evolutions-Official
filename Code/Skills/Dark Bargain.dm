



mob/var/HasRitualOfPower=0


Skill/Spell/Ritual_Of_Power
	Experience=100
	desc="This will allow you to perform a ritual that will consume a large amount of mana but will change the BP% lost from Magic MPs from 5% per level to 1% per level for 2 days."


	verb/Ritual_Of_Power()
		set category="Skills"
		if(usr.HasRitualOfPower+3>Year)
			usr<<"You must wait until year [usr.HasRitualOfPower+3] to do this again."
			return
		var/Cost = 7000000
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
		for(var/obj/Mana/M in usr)
			if(M.Value > Actual)
				if(usr.Confirm("Spend [Actual] mana to perform the Ritual of Power and change the BP% you lose from Magic MPs to 1% instead of 5%?"))
					usr.HasRitualOfPower=WipeDay
					M.Value-=Actual
					logAndAlertAdmins("[usr] used Ritual Of Power.",1)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [usr] used Ritual Of Power.\n")
			else
				usr << "You do not have [Commas(Actual)] mana to spare in order to use the Ritual Of Power ritual."
				return


Skill/Spell/Dark_Bargain
	Experience=100
	desc="This will allow you to revive and summon someone that is dead but at the potential for great cost. (Chance for summon to fail and chance for user to die.)"


	verb/Dark_Bargain()
		set category="Skills"

		var/Cost = 6000000
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] mana. Your magic potential means it costs [Commas(Actual)] mana for you."
		for(var/obj/Mana/M in usr)
			if(M.Value > Actual)

				var/list/DeadList=new
				for(var/obj/Contact/X in usr.Contacts) for(var/mob/AA in Players) if(AA.ckey == X.pkey&&AA.Dead) DeadList+=AA
				var/mob/C=input("Who would you like to try to revive and summon with the dark ritual?") in DeadList
				if(usr.Confirm("Attempt to use Dark Bargain in order to revive and summon [C]?"))
					M.Value-=Actual
					C.Revive()
					if(prob(75)) C.loc=usr.loc
					else usr<<"The summoning portion failed."
					if(prob(10)) usr.Death("Dark Bargain")
					for(var/mob/DD) if(DD.Rank&&DD.Race=="Demon") DD.DBSummon(usr)
					logAndAlertAdmins("[usr] used Dark Bargain on [C].")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [usr] used Dark Bargain on [C].\n")



			else
				usr << "You do not have [Commas(Actual)] mana to spare in order to use the Dark Bargain ritual."
				return

mob/proc/DBSummon(mob/M)
    var/C=input("[M] has begun casting a dark ritual. Would you like to take advantage of the influx in dark energy and teleport to them?") in list("Yes","No")
    if(C=="Yes")
        src.loc=M.loc
        M.saveToLog("|  | [src] has chosen to teleport to [M] after [M] used Dark Bargain.")
        src.saveToLog("|  | [src] has chosen to teleport to [M] after [M] used Dark Bargain.")
