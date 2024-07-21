

/*
mob/verb/EnterMob(mob/M in oview(5))
	set category="Testing"
	adminObserve=1
	M.key=key
*/

obj/items/var/tmp/mob/OldOwner=null
mob/proc/ReleaseFusion()
	var/mob/C=src
	for(var/obj/items/I in C)
		if(I.OldOwner)
			I.OldOwner.contents+=I
			I.OldOwner=null
		else I.loc=locate(x,y,z)
	for(var/obj/items/I in src)
		if(I.OldOwner)
			I.OldOwner.contents+=I
			I.OldOwner=null
		else I.loc=locate(x,y,z)
	for(var/mob/M in Players) if(M.client&&src.FusionKey2==M.key)
		M.InFusion=0
		M.loc=src.loc
		M.reset_view(null)
		for(var/obj/View_Fusion/VF in M) del(VF)
		M.OldMob=null
	var/mob/AA=C.OldMob
	AA.loc=src.loc
	AA.key=src.client.key
	AA.OldMob=null
	spawn AA.InFusion=0
	C.InFusion=0
	spawn del(C)


obj/FusionRelease
	verb/Release_Fusion()
		set category="Skills"
		usr.ReleaseFusion()

mob/var/FusionKey2
mob/var/tmp/IsFusion=0
mob/var/tmp/InFusion=0
mob/var/tmp/mob/OldMob
mob/var/tmp/FusionTimer=0
mob/proc/MakeFusion(mob/A,mob/B)
	var/mob/player/C=new
	C.IsFusion=1
	if(A.Race == B.Race) C.Race = A.Race
	else C.Race="[A.Race] / [B.Race] Fusion"
	C.BPMod=(max(A.BPMod,B.BPMod))//+0.1
	C.BaseMaxAnger=max(A.BaseMaxAnger,B.BaseMaxAnger)
	C.BaseMaxKi=max(B.BaseMaxKi,A.BaseMaxKi)
	C.KiMod=max(B.KiMod,A.KiMod)//+0.1
	C.StrMod=max(B.StrMod,A.StrMod)//+0.1
	C.EndMod=max(B.EndMod,A.EndMod)//+0.1
	C.SpdMod=max(B.SpdMod,A.SpdMod)//+0.1
	C.OffMod=max(B.OffMod,A.OffMod)//+0.1
	C.DefMod=max(B.DefMod,A.DefMod)//+0.1
	C.BaseRegeneration=max(B.BaseRegeneration,A.BaseRegeneration)
	C.BaseRecovery=max(B.BaseRecovery,A.BaseRecovery)
	C.BaseStr=(0.85*max(B.BaseStr,A.BaseStr))+(0.35*(min(B.BaseStr,A.BaseStr)))
	C.BaseEnd=(0.85*max(B.BaseEnd,A.BaseEnd))+(0.35*(min(B.BaseEnd,A.BaseEnd)))
	C.BaseSpd=(0.85*max(B.BaseSpd,A.BaseSpd))+(0.35*(min(B.BaseSpd,A.BaseSpd)))
	C.BaseOff=(0.85*max(B.BaseOff,A.BaseOff))+(0.35*(min(B.BaseOff,A.BaseOff)))
	C.BaseDef=(0.85*max(B.BaseDef,A.BaseDef))+(0.35*(min(B.BaseDef,A.BaseDef)))
	C.Base=(0.85*max(B.Base,A.Base))+(0.35*(min(B.Base,A.Base)))
	C.GravMastered=max(A.GravMastered,B.GravMastered)+50
	C.Zanzoken=max(A.Zanzoken,B.Zanzoken)
	C.FlySkill=max(A.FlySkill,B.FlySkill)
	C.FBMAchieved=max(A.FBMAchieved,B.FBMAchieved)
	C.MaxGodKi=max(A.MaxGodKi,B.MaxGodKi)
	C.Age=max(B.Age,A.Age)
	if(C.MaxGodKi) C.contents += new/obj/God_Ki
	C.GodKi=C.MaxGodKi
	if(A.BreathInSpace||B.BreathInSpace) C.BreathInSpace=1
	if(A.Regenerate||B.Regenerate) C.Regenerate=max(A.Regenerate,B.Regenerate)
	C.FusionKey2=B.key
	C.HasSSj=max(A.HasSSj,B.HasSSj)
	C.HasSSj4=max(A.HasSSj4,B.HasSSj4)
	for(var/Skill/SkillA in A) if(!locate(SkillA) in C) C.contents+=new SkillA.type
	for(var/Skill/SkillB in B) if(!locate(SkillB) in C) C.contents+=new SkillB.type
	for(var/Language/LanguageA in A) if(!locate(LanguageA) in C) C.contents+=new LanguageA.type
	for(var/Language/LanguageB in B) if(!locate(LanguageB) in C) C.contents+=new LanguageB.type
	C.icon=pick(A.icon,B.icon)
	C.name="[copytext(A.name,1,round(length(A.name)/2))][copytext(B.name,round(length(B.name)/2),0)]"
	logAndAlertAdmins("| [B] fused with [A], base ([C.Base]), BPMod [C.BPMod]")
	C.overlays+='Pants Icon.dmi'
	C.overlays+='Clothes_Boots.dmi'
	C.ViewX = A.ViewX
	C.ViewY = A.ViewY
	C.icon_sizeSave = A.icon_sizeSave
	C.overlays+=pick('Fusion_Ha_RT_V3.dmi','Fusion_Clothes_Blue.dmi','Fusion_Clothes_Cyan.dmi','Fusion_Clothes_Green.dmi','Fusion_Clothes_Red.dmi','Fusion_Clothes_Yellow.dmi')
	//C.XP+=Year*XPRate*48
	C.XP=(WipeUpTimer/600)*XPRate//each hour the server was up times the xp rate
	C.overlays+=pick(A.hair,B.hair)
	for(var/obj/items/I in A) if(!istype(I,/obj/items/Clothes))
		I.OldOwner=A
		C.contents+=I
	for(var/obj/items/I in B) if(!istype(I,/obj/items/Clothes))
		I.OldOwner=B
		C.contents+=I
	C.loc = A.loc
	A.loc=locate(423,52,9)
	B.loc=locate(423,52,9)
	A.InFusion=1
	B.InFusion=2//2% $21.37
	A.TRIGGER_AFK()
	C.key=A.client.key
	C.Update_Player()
	C.HasCreated=1
	C.InclineAge=1
	C.UnarmedSkill=max(A.UnarmedSkill,B.UnarmedSkill)
	C.SwordSkill=max(A.SwordSkill,B.SwordSkill)
	C.Athleticism=max(A.Athleticism,B.Athleticism)
	C.KiManipulation=max(A.KiManipulation,B.KiManipulation)
	C.SSjDrain=300
	C.SSj2Drain=300
	C.SSj3Drain=300
	C.SSGSSDrain=300
	C.TransDrain=300
	C.AgreedtoTerms=1
	C.Savable=0
	C.contents+=new/obj/FusionRelease
	B.contents+=new/obj/View_Fusion
	B.Get_Observe(C, hear=1)
//	C.UpdateStats("All")
	C.FusionTimer=800
	Grant_All_Skill_Mastery(C)
	C.OldMob=A
	spawn() C.RPMode()
	alert(C,"Spend your XP!","Points refunded")
	B.AllOut("You have fused with [A] to become [C]!")
	for(var/mob/player/PP in view(C)) PP.AllOut("[A] and [B] have fused to become [C]!")
Skill/FusionDance//2.5k exp cost
	var/LastUse=0
	Tier=5
	desc="Fusion dance! You must be lined up on the left of the person you want to fuse into for success. 1 Year CD."
	verb/Fusion_Dance()
		set category="Skills"
		if(WipeDay<LastUse+1)
			usr<<"You cannot use this until day [LastUse+1]"
			return
		if(usr.IsFusion) return
		var/MeC=0
		if(usr.Confirm("Would you like to control the fusion?"))MeC=1
		/*for(var/mob/player/P in Players) if(P.IsFusion)
			usr<<"There may only be one fusion at a time."
			return*/
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client) if(!A.IsFusion)
			for(var/obj/Contact/C in usr.Contacts) if(C.Signature == A.Signature)
				if(C.familiarity>14.9)
					LastUse=WipeDay
					var/app=input(A,"Fuse with [usr]","Fusion") in list("Yes","No")
					if(app=="Yes"&&usr.Confirm("Fuse with [A]?"))
						A.RemoveBuffs()
						A.Reset_StatMultipliers()
						usr.RemoveBuffs()
						usr.Reset_StatMultipliers()
						A.loc=locate(usr.x+1,usr.y,usr.z)
						var/usrOldicon=usr.icon
						var/list/usroldovers=usr.overlays
						var/themOldicon=A.icon
						var/list/themoldovers=A.overlays
						usr.overlays=null
						A.overlays=null
						usr.icon='Left.dmi'
						A.icon='Right.dmi'
						usr.pixel_x-=3
						A.pixel_x+=3
						spawn(1)
							usr.pixel_x-=3
							A.pixel_x+=3
							spawn(1)
								var/x=6
								while(x)
									usr.pixel_x++
									A.pixel_x--
									sleep(2)
									x--
						sleep(45)
						usr.icon=usrOldicon
						A.icon=themOldicon
						usr.overlays=usroldovers
						A.overlays=themoldovers
						if(MeC)usr.MakeFusion(usr,A)
						else A.MakeFusion(A,usr)
					else
						LastUse=0
						return
					break
				else usr<<"You need to get to know them more first. (15 Familiarity)"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)





obj/View_Fusion
	verb/View_Fusion()
		set category="Other"
		set src=usr.contents
		var/list/CanO=list()
		for(var/mob/T in Players) if(T.FusionKey2==usr.key) CanO+=T
		var/mob/M=input("Choose who to observe") in CanO
		if(M.FusionKey2 == usr.key)
			usr << "You use your link to [M] and see through their eyes."
			usr.Get_Observe(M, hear = 1)
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe Fusion on [key_name(M)].\n")
			