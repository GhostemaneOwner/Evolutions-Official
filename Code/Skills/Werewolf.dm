obj/items/Mark_Of_The_Beast
	desc="Possessing this will increase your BP by +5% but it will also cause you to transform into a Werewolf in the full moon."
	icon='enchantmenticons.dmi'
	icon_state="RoR"

mob/var
	Werewolf=0
	HasWerewolf=0
	StoredX=0
	StoredY=0
	WereX=-11
	WereY=27

Skill/Support/Werewolf_Infect
	Experience=100
	var/LastUse=-1
	desc="You can use this ability to give someone lycanthropic abilities, and causes low HP to only reduce BP to 70% instead of 30% but will reduce their Regeneration ticks by 20%. They will also get some skills and stats. Each infection will drain you of 1000 of your max energy and 20% of your current stats. 1 Year CD."
	verb/Werewolf_Infect()
		set category="Skills"
		if(usr.RPMode) return
		if(!usr.Werewolf)
			usr << "You need to be transformed to use this."
			return
		if(LastUse+1>WipeDay)
			usr<<"You need to wait until day [LastUse+1]."
			return
		if(usr.BaseMaxKi >= 1500)
			for(var/mob/P in get_step(usr,usr.dir)) if(P.client)
				if(P.KOd==0) switch(input(P,"Do you want [usr] to turn you into a werewolf? (Causes low HP to only reduce BP to 70% instead of 30% but will reduce their Regeneration ticks by 20%)") in list("No","Yes"))
					if("No") return
				if(P.HasWerewolf)
					usr<<"They are already a werewolf."
					return
				if(P.Regenerate||P.Race=="Android"||P.Race=="Majin"||P.AndroidLevel)
					usr<<"They seem to be immune to lycanthropy."
					return
				usr.BaseMaxKi -= 1000
				view(usr)<<"[usr] scratches [P] and turns them into a werewolf!"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] turns [P] into a werewolf \n")
				alertAdmins("[key_name_admin(usr)] has turned [P] into a werewolf.")
				usr.BaseStr/= 1.2
				usr.BaseSpd/= 1.2
				usr.BaseEnd/= 1.2
				usr.BaseDef/= 1.2
				usr.BaseOff/= 1.2
				LastUse=WipeDay
				P.HasWerewolf=1
				P.Werewolf_Skills()
				return

Skill/Support/Pack_Telepathy
	Experience=100
	verb/Pack_Telepathy()
		set src=usr.contents
		set category="Other"
		set instant=1
		var/message=input("Say what in Pack Telepathy?") as text
		usr << "<span class=\"telepathy\"><font size=[usr.TextSize]>You say in Pack Telepathy \"[message]\"</font></span>"
		usr.saveToLog("<span class=\"telepathy\">You say in Pack Telepathy \"[message]\"</span>\n")
		for(var/mob/player/M in Players)
			if(M.HasWerewolf)
				if(M.seetelepathy) if(M != usr)
					message = copytext(sanitize(message), 1, MAX_MESSAGE_LEN)
					if(!message)	return
					if(M)  M<< "<span class=\"telepathy\"><font size=[M.TextSize]>[usr] says in Pack Telepathy, \"[message]\"</font></span>"
				else
					usr << "You are unable to communicate with [M.name]!"

mob/proc/Werewolf()if(!Werewolf&&!ssj&&!Oozaru)
	if(getCooldown("Werewolf")>world.time)
		src << "The effect of the moons rays don't seem to do anything for you at the moment, [round((getCooldown("Werewolf")-world.time)/600,0.1)] minutes cooldown remaining!"
		return
	for(var/obj/items/Power_Armor/A in src) if(A.suffix) src.Eject(A)
	RemoveBuffs()
	if(BuffNumber>0)
		src<<"You are already using too many buffs. (Werewolf counts as 2 buffs)"
		return
	oicon=icon
	Overlays.Add(overlays)
	overlays.Remove(overlays)
	icon='Werewolf.dmi'
	StoredX=pixel_x
	pixel_x=WereX
	HealthBar.pixel_x=-WereX
	EnergyBar.pixel_x=-WereX
	//animate(src, transform = matrix()*2, time = 3)
	BPMult*=2.5
	Werewolf=1
	setCooldown("Werewolf",12000)
	BuffNumber+=2
	Buffs+="Werewolf"
	OozaruTimer=600

mob/proc/Werewolf_Revert()if(Werewolf)
	//animate(src, transform = null, time = 3)
	icon=oicon
	pixel_x=StoredX
	overlays=null
	overlays.Add(Overlays)
	Overlays.Remove(Overlays)
	HealthBar.pixel_x=0
	EnergyBar.pixel_x=0
	BPMult/=2.5
	Werewolf=0
	BuffNumber-=2
	Buffs-="Werewolf"


mob/proc/RemoveWerewolf_Skills()
	if(HasWerewolf>=1)
		if(HasWerewolf==2)
			for(var/X in OGWerewolfSkills)
				if((X = locate(X) in src))
					src.contents-=X
		for(var/X in WerewolfSkills)
			if((X = locate(X) in src))
				src.contents-=X
		HasWerewolf=0
		StrMod/= 1.1
		SpdMod/= 1.1
		EndMod/= 1.1
		OffMod/= 1.1

mob/proc/Werewolf_Skills()
	if(HasWerewolf==2)
		for(var/X in OGWerewolfSkills)
			if(!locate(X) in src)
				src.contents+=new X
	for(var/X in WerewolfSkills)
		if(!locate(X) in src)
			src.contents+=new X
	StrMod*= 1.1
	SpdMod*= 1.1
	EndMod*= 1.1
	OffMod*= 1.1
	Remove_Duplicate_Moves()
	