

mob/var
	issupermystic=0
	issupermajin=0

Skill/Buff/Mystic
	buffon="emits a great and calming power."
	buffoff="stops using Mystic."
	Tier=4
	BP=1.5
	Spd=1.2
	Def=1.2
	Experience=100
	icon='Electric_Mystic.dmi'
	layer=MOB_LAYER+1
	var/Super=0
	DoesNotStackWith="Majin"
	GetDescription(mob/Getter)
		return "Mystic will increase your BP by [BP]x, Defense by [Def]x and Power Up by +10%."
		..()
	verb/Mystic()
		set category="Skills"
		if(usr.ismajin)
			usr<<"You cant use this with Majin"
			return
		if(Super)
			icon = 'White Cloak.dmi'
			pixel_x = -32
			pixel_y = -32
			alpha = 200
			use(usr,null,0,0,0,0,0,0)
			usr.FirstTransWPRestore(usr,2)
		else
			use(usr,null,0,0,0,0,0,0)
			usr.FirstTransWPRestore(usr)
		usr.HairAdd()

Skill/Buff/Super_Mystic
	buffon="emits a great and calming power."
	buffoff="stops using Super Mystic."
	Tier=4
	BP=1.85
	Spd=1.5
	Def=1.65
	Experience=100
	icon='Electric_Mystic.dmi'
	layer=MOB_LAYER+1
	var/Super=0
	DoesNotStackWith="Majin"
	GetDescription(mob/Getter)
		return "Mystic will increase your BP by [BP]x, Defense by [Def]x and Power Up by +10%."
		..()
	verb/Super_Mystic()
		set category="Skills"
		if(usr.ismajin)
			usr<<"You cant use this with Majin"
			return
		if(Super)
			icon = 'White Cloak.dmi'
			pixel_x = -32
			pixel_y = -32
			alpha = 200
			use(usr,null,0,0,0,0,0,0)
			usr.FirstTransWPRestore(usr,2)
		else
			use(usr,null,0,0,0,0,0,0)
			usr.FirstTransWPRestore(usr)
		usr.HairAdd()
		if(Super) if(usr.Confirm("Would you like to use Super? (+1 God Ki)"))
			for(var/mob/player/M in view(usr)) M.BuffOut("You feel a great and terrifying power emanate from [usr].")
		//	usr.SSjGodKi++
			usr.issupermystic=1

Skill/Buff/Majin
	buffon="emits a great and terrifying power."
	buffoff="stops using Majin."
	Tier=4
	BP=1.5
	End=1.2
	Off=1.2
	Experience=100
	var/Super=0
	icon='Electric_Majin.dmi'
	layer=MOB_LAYER+1
	DoesNotStackWith="Mystic"
	GetDescription(mob/Getter)
		return "Majin will increase your BP by [BP]x and Off by [Off]x. It will passively increase your HP ticks. +10% Anger."
		..()
	verb/Majin()
		set category="Skills"
		if(usr.ismystic)
			usr<<"You cant use this with Mystic"
			return
		if(Super)
			icon = 'Black Cloak.dmi'
			pixel_x = -32
			pixel_y = -32
			alpha = 200
			use(usr,null,0,0,0,0,0,0)
			usr.FirstTransWPRestore(usr,2)
			if(Super) if(usr.Confirm("Would you like to use Super? (+1 God Ki)"))
				for(var/mob/player/M in view(usr)) M.BuffOut("You feel a great and terrifying power emanate from [usr].")
			//	usr.SSjGodKi++
				usr.issupermystic=1
		else
			use(usr,null,0,0,0,0,0,0)
			usr.FirstTransWPRestore(usr)



Skill/Support/Majinize
	Experience=100
	RequiresApproval=1
	var/LastUse
	var/list/Majins=list()
	verb/Majinize(mob/player/M in oview(1))
		set category="Other"
		set src = usr.contents
		if(WipeDay<LastUse+5)
			usr<<"You cannot use this until day [LastUse+5]"
			return
		alert(usr,"You must make a discord post following the appropriate format which can be found in the RANKS section","ATTENTION")
		if(M.Race!="Shinjin")for(var/Skill/Buff/Mystic/MM in M)
			if(usr.Confirm("Remove their Mystic?"))
				del(MM)
				LastUse=WipeDay-2.5
				if(M.EnablementSlot) M.EnablementSlot=0
				return
		if(M.EnablementSlot)
			usr<<"They already possess great skill."
			return
		if(locate(/Skill/Buff/Majin) in M)
			src<<"They already have it"
			return
		if(M.Race=="Demon")
			usr<<"You may not use this on another Demon."
			return
		var/x=input(M,"[usr] would like to use [src] on you.  You will be forced to obey them in-character. Do you accept?") in list("No","Yes")
		if(x!="Yes") return
		if(locate(/Skill/Buff/Majin) in M)
			src<<"They already have it"
			return
		M.Majin_By = usr.key
		Majins+=M.key
		for(var/Skill/Buff/Mystic/A in M) del(A)
		M.contents += new /Skill/Buff/Majin(M)
		LastUse=WipeDay
		M.EnablementSlot=1
		M.AlignmentNumber-=4
		M.AlignmentCalibrate()
		alertAdmins("[key_name(usr)] has Majinized [key_name(M)].")
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Majinized [key_name(M)]")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Majinized [key_name(M)].\n")
		M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)] was Majinized by [key_name(usr)].\n")

Skill/Support/Mystify
	Experience=100
	RequiresApproval=1
	var/LastUse
	verb/Mystify(mob/player/M in oview(1))
		set category="Other"
		set src = usr.contents
		if(WipeDay<LastUse+5)
			usr<<"You cannot use this until day [LastUse+5]"
			return
		alert(usr,"You must make a discord post following the appropriate format which can be found in the RANKS section","ATTENTION")
		if(M.Race!="Demon")for(var/Skill/Buff/Majin/MM in M)
			if(usr.Confirm("Remove their Majin?"))
				del(MM)
				LastUse=WipeDay-2.5
				if(M.EnablementSlot) M.EnablementSlot=0
				return
		if(M.EnablementSlot)
			usr<<"They already possess great skill."
			return
		if(locate(/Skill/Buff/Mystic) in M)
			src<<"They already have it"
			return
		if(M.Race=="Shinjin")
			usr<<"You may not use this on another Kaio."
			return
		var/x=input(M,"[usr] would like to use [src] on you.  You will be alignment locked to Good for the duration. Do you accept?") in list("No","Yes")
		if(x!="Yes") return
		if(locate(/Skill/Buff/Mystic) in M)
			src<<"They already have it"
			return
		for(var/Skill/Buff/Majin/A in M) del(A)
		M.contents += new/Skill/Buff/Mystic(M)
		LastUse=WipeDay
		M.AlignmentNumber+=4
		M.AlignmentCalibrate()
		M.EnablementSlot=1
		alertAdmins("[key_name(usr)] has Mystified [key_name(M)].")
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Mystified [key_name(M)]")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Mystified [key_name(M)].\n")
		M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)] was Mystified by [key_name(usr)].\n")




