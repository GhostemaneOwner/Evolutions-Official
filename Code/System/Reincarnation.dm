var/list/Reincarnations=new
var/Reincarnation_Status = "Off"
obj/ReincarnationObj
	var/Flight
	var/Zanzoken
	var/Kaioken
	var/Power
	var/Energy
	var/Strength
	var/Endurance
	var/Force
	var/Resistance
	var/Speed
	var/Offense
	var/Defense
	var/Training_Experience
	var/Milestones
	var/KiManip
	var/Unarmed
	var/Weapon
	var/Athlete
	var/XP
	var/Grav
	var/datum/mind/mindhold


mob/proc/Reincarnation()
	var/obj/ReincarnationObj/A=new
	RemoveBuffs()
	A.name=key
	A.Flight=FlySkill/FlyMod
	A.Zanzoken=Zanzoken/ZanzoMod
	A.Power=Base/BPMod
	A.Energy=BaseMaxKi/KiMod
	A.Strength=BaseStr/StrMod
	A.Endurance=BaseEnd/EndMod
	A.Speed=BaseSpd/SpdMod
	A.Offense=BaseOff/OffMod
	A.Defense=BaseDef/DefMod
	A.Training_Experience=GainMultiplier
	A.KiManip=KiManipulation
	A.Unarmed=UnarmedSkill
	A.Weapon=SwordSkill
	A.Grav=GravMastered
	A.Athlete=Athleticism
	A.mindhold=mind
	A.XP=round(TotalXP*0.7)

	Reincarnations += A


	var/mob/player/B = new
	B.key=key
	B.client.Choose_Login()
	//spawn del(src)

mob/var/Reincarnated=0
mob/proc/Check_Incarnates() for(var/obj/ReincarnationObj/A in Reincarnations) if(A.name==key)
	FlySkill = A.Flight*FlyMod
	Zanzoken = A.Zanzoken*ZanzoMod
	Base = A.Power*BPMod/1.25
	BaseMaxKi = A.Energy*KiMod
	BaseStr = A.Strength*StrMod/1.25
	BaseEnd = A.Endurance*EndMod/1.25
//	BasePow = A.Force*PowMod/1.25
	BaseSpd = A.Speed*SpdMod/1.25
	BaseOff = A.Offense*OffMod/1.25
	BaseDef = A.Defense*DefMod/1.25
	GainMultiplier = A.Training_Experience/1.25
	KiManipulation=A.KiManip
	UnarmedSkill=A.Unarmed
	SwordSkill=A.Weapon
	GravMastered=(A.Grav*0.75)
	Athleticism=A.Athlete
	mind=A.mindhold
	XP=A.XP
	TotalXP=XP
	Reincarnated=1
	Body()
	del(A)


Skill/Support/Reincarnate
	Experience=100
	desc="This can be used to reincarnate someone into an entirely different race, but they keep their \
	stats, but they are reproportioned to match the new mods of that race."
	verb/Reincarnate(mob/M in oview(1,usr))
		set src=usr.contents
		set category="Skills"
		if(usr.RPMode) return
		switch(input(M,"[usr] has offered to help reincarnate you into another body and mind, this will purify your spirit and erase your memories, starting your life in the living world all over again. You will keep your power and some of your skills, but re-proportioned for the new race you choose. If you hit yes it will be too late to turn back. Do you want to do this?") in list("No","Yes"))
			if("Yes")
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has reincarnated [key_name(M)]")
				alertAdmins("[key_name(usr)] has reincarnated [key_name(M)]")
				view(usr) << "[usr] has reincarnated [M]"
				M.Reincarnation()
			if("No") view(M) << "[M] declined reincarnation from [usr]"

mob/proc/DeathBasedReincarnation()
	switch (input(src,"You have died more than twice and your soul is now too weak to continue living. Would you like to continue on to the Final Realms, or reincarnate to a new character?") in list("Continue to the Final Realms","Reincarnate to a New Character"))
		if("Reincarnate to a New Character")
			Reincarnation()
			logAndAlertAdmins("[key_name(src)] died and went to the TFR and chose to reincarnate.")
		if("Continue to the Final Realms")
			for(var/mob/M in Players) if(M.client && M.client.holder) M.AllOut("<b><font color=red>(Reincarnation)</font color> <A HREF='?src=\ref[M.client.holder];privatemessage=\ref[src]'>[src.key]</a href>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>) : Died and went to TFR and did not reincarnate</b>")


mob/proc/NewGameReincarnation()
	switch (input(src,"Would you like to continue on to the Final Realms, or reincarnate to a new character?") in list("Continue to the Final Realms","Reincarnate to a New Character"))
		if("Reincarnate to a New Character")
			Reincarnation()
			logAndAlertAdmins("[key_name(src)] died and went to the TFR and chose to reincarnate.")
		if("Continue to the Final Realms")
			for(var/mob/M in Players) if(M.client && M.client.holder) M.AllOut("<b><font color=red>(Reincarnation)</font color> <A HREF='?src=\ref[M.client.holder];privatemessage=\ref[src]'>[src.key]</a href>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>) : Died and went to TFR and did not reincarnate</b>")
			