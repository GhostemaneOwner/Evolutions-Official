mob/proc/TakeBodyFrom(mob/A)
	var/mob/player/C=new
	logAndAlertAdmins("| [src] stole [A]s body!")

	for(var/V in C.vars) if(issaved(C.vars[V]))if(!(V in list("type","client","lastKnownKey","key","ckey","tmpkey","tmpckey","parent_type","verbs","vars","group","address","lastKnownIP","appearance","appearance_flags","animate_movement","bounds","","","x","y","z","loc")))
		if(istype(A.vars[V],/list))
			var/list/L = A.vars[V]
			C.vars[V] = L.Copy()
		else C.vars[V]=A.vars[V]
	for(var/obj/I in A)
		var/obj/newI = new I.type
		for(var/V in newI.vars) if(issaved(newI.vars[V]))if(!(V in list("type","client","lastKnownKey","key","ckey","tmpkey","tmpckey","parent_type","verbs","vars","group","address","lastKnownIP","appearance","appearance_flags","animate_movement","bounds","","","x","y","z","loc")))
			if(istype(A.vars[V],/list))
				var/list/L = A.vars[V]
				C.vars[V] = L.Copy()
			else newI.vars[V]=I.vars[V]
		C.contents+= newI
/*
	for(var/Skill/SkillA in A) if(!locate(SkillA) in C) C.contents+=new SkillA.type
	for(var/Skill/SkillB in src) if(!locate(SkillB) in C) C.contents+=new SkillB.type
	for(var/Language/LanguageA in A) if(!locate(LanguageA) in C) C.contents+=new LanguageA.type
	for(var/Language/LanguageB in src) if(!locate(LanguageB) in C) C.contents+=new LanguageB.type

*/
	C.loc = A.loc
	src.loc=locate(423,52,9)
	A.loc=locate(423,52,9)

	src.DontDisconnect=1//2% $21.37
	src.TRIGGER_AFK()

	C.Savable=0
	C.OldMob=src
	C.BodyKey=A.key
	C.DontDisconnect=1
	C.key=src.client.key

	C.Update_Player()
	Grant_All_Skill_Mastery(C)

	C.contents+=new/obj/BodyRelease
	A.contents+=new/obj/BodyWatch
	spawn() C.RPMode()


mob/Admin3/verb/Steal_Body(mob/A)
	TakeBodyFrom(A)

mob/proc/Release_Body()
	var/mob/C=src
	for(var/mob/M in Players) if(M.client&&C.BodyKey==M.key)
		M.loc=src.loc
		for(var/obj/BodyWatch/VF in M) del(VF)
		M.OldMob=null
		M.BodyKey=null
	var/mob/AA=C.OldMob
	AA.loc=src.loc
	AA.key=src.client.key
	AA.DontDisconnect=0
	AA.OldMob=null
	AA.BodyKey=null
	src.BodyKey=null
	src.OldMob=null
	spawn del(C)

mob/var/tmp/BodyKey
obj/BodyRelease
	verb/Release_Body()
		set category="Skills"
		usr.Release_Body()

obj/BodyWatch
	verb/View_Body()
		set category="Other"
		set src=usr.contents
		var/list/CanO=list()
		for(var/mob/T in Players) if(T.BodyKey==usr.key) CanO+=T
		var/mob/M=input("Choose who to observe") in CanO
		if(M.BodyKey == usr.key)
			usr << "You use your link to [M] and see through their eyes."
			usr.Get_Observe(M, hear = 1)
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe body on [key_name(M)].\n")


