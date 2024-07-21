





mob/proc/Cancel_Olympus() src.Olympus_Revert()
mob/var/Pantheon

Skill/Buff/Pantheon
	RequiresApproval = 0
	Tier=4
	buffon="taps into the power of the gods!"
	buffoff="returns to using their mortal power."
	var
	//Zeus
		ZBP=1.55
		ZPow=1.5
		ZRecov=1.2
	//Odin
		OBP=1.5
	//Horus
		HoBP=1.65
		HoSpd=1.3
		HoRegen=1.5
	//Nuada
		NBP=1.45
		NEnd=1.5
		NStr=1.1


	//Chernobog
		CBP=1.65
		COff=1.3
		CAnger=1.2
	//Akatosh
		AkBP=1.85
		AkEnd=1.2
		AkStr=1.3
	//Vulcan
		VBP=1.4
		VEnd=1.2
		VPow=1.3

	//Hanuman
		HBP=1.4
		HDef=1.25
		HSpd=1.25
		HStr=1.25
	//Ravana
		RBP=2
		RSpd=1.3
		RStr=1.3
		ROff=1.3
		REnd=1.3
		RDef=1.3
		RPow=1.3
		RRecov=1.3


	Experience=100
	var/tmp/Clicks=0
	icon='Spartan2.dmi'

	layer=MOB_LAYER+1
	var/list/Panths=list("Zeus","Odin","Horus","Nuada")
	GetDescription()
		var/Returner="This ability has several different forms. Zeus: [ZPow]x Force, [ZBP]x BP and [ZRecov]x Recovery. Odin: [OBP]x BP. Horus: [HoSpd]x Speed, [HoBP]x BP and [HoRegen]x Regeneration. Nuada: [NBP]x BP, [NEnd]x End, [NStr]x Str."
		if(Panths.Find("Akatosh")) Returner="[Returner] Akatosh:[AkBP]x BP, [AkStr]x Str, [AkEnd]x Endurance."
		if(Panths.Find("Vulcan")) Returner="[Returner] Vulcan: [VBP]x BP, [VPow]x Force, [VEnd]x Endurance."
		if(Panths.Find("Hanuman")) Returner="[Returner] Hanuman: [HBP]x BP, [HDef]x Defense, [HStr]x Strength, and [HSpd]x Speed."
		if(Panths.Find("Chernobog")) Returner="[Returner] Chernobog: [CBP]x BP, [COff]x Offense, [CAnger]x Anger Mult."
		if(Panths.Find("Ravana")) Returner="[Returner] Ravana: [RBP]x BP, [RSpd]x Spd, [RStr]x Str, [ROff]x Off, [REnd]x End, [RPow]x Force, [RRecov]x Recovery."
		return Returner
	//	..()
	verb/Pantheon()
		set category="Skills"
		set src = usr.contents
		//if(usr.Race!="Demigod") return
		//if(usr.RPMode) return
		if(usr.KOd) return
		if(Clicks)
			if(prob(1)) usr<<"You only need to click once, fool."
			return
		if(usr.Ki<usr.MaxKi*0.1)
			usr<<"You require atleast 10% energy to use Pantheon."
			return
		Clicks=1
		if(!Using)
			if(usr.BuffNumber>=usr.BuffLimit)
				usr.BuffOut("You are already using too many buffs.")
				return
			if(usr.MaxGodKi) if(!Panths.Find("Ravana"))
				Panths.Add("Ravana")
				usr<<"You have unlocked the Ravana Pantheon"
				alertAdmins("[usr] has unlocked the Ravana Pantheon")
			if(usr.Base/usr.BPMod>=Tier3Req)if(!Panths.Find("Chernobog"))
				Panths.Add("Chernobog")
				usr<<"You have unlocked the Chernobog Pantheon"
				alertAdmins("[usr] has unlocked the Chernobog Pantheon")
			if(usr.Base/usr.BPMod>=Tier2Req&&usr.UnarmedSkill>1000)if(!Panths.Find("Akatosh"))
				Panths.Add("Akatosh")
				usr<<"You have unlocked the Akatosh Pantheon"
				alertAdmins("[usr] has unlocked the Akatosh Pantheon")
			if(usr.Base/usr.BPMod>=Tier2Req&&usr.KiManipulation>1000)if(!Panths.Find("Vulcan"))
				Panths.Add("Vulcan")
				usr<<"You have unlocked the Vulcan Pantheon"
				alertAdmins("[usr] has unlocked the Vulcan Pantheon")
			if(usr.FBMAchieved) if(!Panths.Find("Hanuman"))
				Panths.Add("Hanuman")
				usr<<"You have unlocked the Hanuman Pantheon"
				alertAdmins("[usr] has unlocked the Hanuman Pantheon")
			var/Choice=input(usr,"Choose your form","Pantheon") in Panths
			if(usr.BuffNumber>=usr.BuffLimit)
				usr.BuffOut("You are already using too many buffs.")
				return
			switch(Choice)
				if("Zeus")
					usr.PowMult*=ZPow
					usr.BPMult*=ZBP
					usr.RecovMult*=ZRecov
					usr.Pantheon="Zeus"
					usr.FirstTransWPRestore(usr)
				if("Odin")
					usr.BPMult*=OBP
					usr.Pantheon="Odin"
					usr.FirstTransWPRestore(usr)
				if("Horus")
					usr.BPMult*=HoBP
					usr.SpdMult*=HoSpd
					usr.RegenMult*=HoRegen
					usr.Pantheon="Horus"
					usr.FirstTransWPRestore(usr)
				if("Nuada")
					usr.BPMult*=NBP
					usr.StrMult*=NStr
					usr.EndMult*=NEnd
					usr.Pantheon="Nuada"
					usr.FirstTransWPRestore(usr)
				if("Chernobog")
					usr.BPMult*=CBP
					usr.OffMult*=COff
					usr.AngerMult*=CAnger
				//	spawn() if(usr.Anger>100)
					//usr.Calm()
				//		usr.Anger()
					//usr.StrMult*=CStr
					usr.Pantheon="Chernobog"
					usr.FirstTransWPRestore(usr,4)
				if("Hanuman")
					usr.BPMult*=HBP
					usr.DefMult*=HDef
					usr.SpdMult*=HSpd
					usr.StrMult*=HStr
					usr.Pantheon="Hanuman"
					usr.FirstTransWPRestore(usr,2)
				if("Akatosh")
					usr.BPMult*=AkBP
					usr.EndMult*=AkEnd
					usr.StrMult*=AkStr
					usr.Pantheon="Akatosh"
					usr.FirstTransWPRestore(usr,3)
				if("Vulcan")
					usr.BPMult*=VBP
					usr.EndMult*=VEnd
					usr.PowMult*=VPow
					usr.Pantheon="Vulcan"
					usr.FirstTransWPRestore(usr,3)
				if("Ravana")
					usr.BPMult*=RBP
					usr.SpdMult*=RSpd
					usr.StrMult*=RStr
					usr.OffMult*=ROff
					usr.EndMult*=REnd
					usr.DefMult*=RDef
					usr.PowMult*=RPow
					usr.RecovMult*=RRecov
					usr.Pantheon="Ravana"
					usr.FirstTransWPRestore(usr,5)
			usr.BuffNumber++
			usr.Buffs+="Pantheon"
			usr.overlays+=src
			usr.energydraining+=MediumDrain
			LargeDust(usr)
			Using=1
			for(var/mob/player/M in view(usr)) M.BuffOut("[usr] begins using Pantheon.")
			/*if(Global_GodKi==1)
				view(usr)<<"You stop being able to sense [usr]'s ki."


							user.Buffs += buffname
			Using = 1
			user.BPMult*=src.BP
			user.StrMult*=src.Str
			user.EndMult*=src.End
			user.SpdMult*=src.Spd
			user.PowMult*=src.Pow
			user.OffMult*=src.Off
			user.DefMult*=src.Def
			user.RegenMult*=Regen
			user.RecovMult*=Recov
			user.AngerMult*=Anger
			user.energydraining+=energydrain
			user.healthdraining+=healthdrain


				usr.SSjGodKi+=max(0.5,usr.GodKi/3)*/
		else {usr.Cancel_Olympus()}
		spawn(15) Clicks=0

mob/proc/Olympus_Revert() for(var/Skill/Buff/Pantheon/A in src) if(A.Using) if(Pantheon)
	A.Using=0
	view(src)<<"[src] stops using Pantheon."
	switch(Pantheon)
		if("Zeus")
			PowMult/=A.ZPow
			BPMult/=A.ZBP
			RecovMult/=A.ZRecov
			Pantheon=null
		if("Nuada")
			StrMult/=A.NStr
			BPMult/=A.NBP
			EndMult/=A.NEnd
			Pantheon=null
		if("Akatosh")
			BPMult/=A.AkBP
			EndMult/=A.AkEnd
			StrMult/=A.AkStr
			Pantheon=null
		if("Vulcan")
			BPMult/=A.VBP
			EndMult/=A.VEnd
			PowMult/=A.VPow
			Pantheon=null
		if("Odin")
			BPMult/=A.OBP
			Pantheon=null
		if("Horus")
			BPMult/=A.HoBP
			SpdMult/=A.HoSpd
			RegenMult/=A.HoRegen
			Pantheon=null
		if("Chernobog")
			BPMult/=A.CBP
			OffMult/=A.COff
		//	StrMult/=A.CStr
			AngerMult/=A.CAnger
			//spawn() if(Anger>100)
			Calm()
			//	Anger()
			Pantheon=null
		if("Hanuman")
			BPMult/=A.HBP
			DefMult/=A.HDef
			SpdMult/=A.HSpd
			StrMult/=A.HStr
			Pantheon=null
		if("Ravana")
			BPMult/=A.RBP
			SpdMult/=A.RSpd
			StrMult/=A.RStr
			OffMult/=A.ROff
			DefMult/=A.RDef
			PowMult/=A.RPow
			EndMult/=A.REnd
			RecovMult/=A.RRecov
			Pantheon="Ravana"
	energydraining-=MediumDrain
	BuffNumber--
	Buffs-="Pantheon"
	overlays -= A





