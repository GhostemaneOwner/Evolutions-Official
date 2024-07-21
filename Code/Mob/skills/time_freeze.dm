Skill/Attacks/Time_Freeze
	desc="This will send paralyzing energy rings all around nearby people and they will not be able to move until it wears off. This has a minute cooldown."
	CDOverride=60
	Experience=100
	verb/Time_Freeze()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Frozen||usr.KOd) return
		if(!usr.CanAttack(100,src)) return
		CDTick(usr)
		Stun(usr,1,1)
		//usr.DrainKi(src,"Percent",10)
		usr.DrainKi(src, 1, 100,show=1)
		usr.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Time Freeze.\n")
		for(var/mob/A in oview(usr)) if(A.Team!=usr.Team)
			if(!A.Frozen&&A.client)
				sleep(2)
				var/obj/ranged/Blast/_TF=unpool("Blasts")
				_TF.Belongs_To=usr
				_TF.icon='TimeFreeze.dmi'
				_TF.name=src
				_TF.Power=usr.BP*Ki_Power
				_TF.Damage=_TF.Power*usr.Pow
				_TF.Offense=usr.Off*1.25
				_TF.Paralysis=5
				_TF.density=1
				missile(_TF,usr,A)
				_TF.Bump(A)
				