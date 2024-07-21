
//mob/var/TeachLimit=2
mob/var/TeachCD=0
mob/var
	LearnSlots=2
	LastLearn=0
	LastLearnSlotRefresh=0
	TeachLimit = 2

Skill
	parent_type=/obj
	var
		Teach=0
		LastTeach=0
		TeachDay=0
		WaitTime=0
		RequiresApproval=0
		list/HasApproval=new
		NotTeachable=0
		Tier=1
		RankKit=0
		CDOverride=0
		OriginalCD
		UB1//needs removed
		UB2//needs removed
	New()
		..()
		switch(Tier)
			if(3)
				WaitTime=1
				RequiresApproval = 1
			if(4)
				WaitTime=2
				RequiresApproval = 1
			if(5)
				WaitTime=3
				RequiresApproval = 1
		if(!TeachDay)TeachDay=WipeDay+WaitTime
mob/var/tmp/energydraining=0
mob/var/tmp/transenergydraining=0
mob/var/tmp/transstaticenergydraining=0
mob/var/tmp/healthdraining=0
mob/var/tmp/staticenergydraining=0
mob/var/tmp/UsingTier5
mob/var/IgnoreRealmTeleport
Skill/Buff
	Tier=5
	Experience=100
	layer=MOB_LAYER+EFFECTS_LAYER
	var
		BP=1
		Str=1
		End=1
		Spd=1
		Pow=1
		Off=1
		Def=1
		Regen=1
		Recov=1
		Anger=1
		KiNeeded = 0.1
		energydrain = 0 // a multiplier for energy drain feature
		healthdrain = 0 // a multiplier for health drain feature
		staticenergydrain=0//static drain
		list/DoesNotStackWith=null
		buffslot=1
		buffname="Buff"
		buffon=""
		buffoff=""
		TimedBuff=0
		CritCan=0
		WeaponLevel=1
	New()
		..()
		buffname="[src]"
		if(!staticenergydrain&&!energydrain&&Tier==5&&!healthdrain) staticenergydrain=HighStaticDrain

	proc
		use(mob/user,var/ExtraOver,var/KiBPEffect,var/DisableRegen,var/IgnoreLimb,var/Thorns,var/NeedsSword,var/SNJ,var/Shield,var/Ultra,var/BoundWeapon)
			//if(istype(src,/Skill/Buff/Bound_Weapon))
			//	var/Skill/Buff/Bound_Weapon/BW=src
			//	BW.BWuse(user)
			//	return
			if(!ismob(user)) return
			if(!Using)
				if(buffslot && user.BuffNumber+buffslot > user.BuffLimit)
					user.BuffOut("You are already using too many buffs.")
					return
				buff(user,ExtraOver,KiBPEffect,DisableRegen,IgnoreLimb,Thorns,NeedsSword,SNJ,Shield,Ultra,BoundWeapon)
			else if(Using) debuff(user,ExtraOver,KiBPEffect,DisableRegen,IgnoreLimb,Thorns,NeedsSword,SNJ,Shield,Ultra,BoundWeapon)
		buff(mob/user,var/ExtraOver,var/KiBPEffect,var/DisableRegen,var/IgnoreLimb,var/Thorns,var/NeedsSword,var/SNJ,var/Shield,var/Ultra,var/BoundWeapon) if(!Using)
			if(!ismob(user)) return
			//if(user.RPMode) return
			if(user.KOd) return
			if(DoesNotStackWith) if(user.Buffs.Find(DoesNotStackWith))
				user.BuffOut("[buffname] does not stack with [DoesNotStackWith].")
				return
			//if(istype(src,/Skill/Buff/
			if(user.UsingTier5&&Tier>=5)
				user.BuffOut("You can only use one tier 5 buff at a time.")
				return
			/*if(NeedsSword)
				if(!usr.WeaponCheck())
					user<<"A weapon is required for this skill."
					return*/
			if(user.Ki < user.MaxKi * KiNeeded)
				user.BuffOut("You need at least [KiNeeded*100]% energy to use [src].")
				return
			if(buffslot) user.BuffNumber+=buffslot
			if(user.BP>1000) SmallDust(usr)
			else if(user.BP>10000) LargeDust(usr)
			if(user.BP>100000)BigShockwave(usr)


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
			user.staticenergydraining+=staticenergydrain
			if(Tier>=5) user.UsingTier5++
			if(istype(src,/Skill/Buff/Mystic))
				user.ismystic=1
				var/Skill/Buff/Mystic/M=src
				if(M.Super==1) user.issupermystic=1
			if(istype(src,/Skill/Buff/Majin))
				user.ismajin=1
				var/Skill/Buff/Majin/M=src
				if(M.Super==1) user.issupermajin=1
			if(Ultra)user.Precognition+=Ultra
			if(Shield) user.Shielding=1
//			if(SNj) user.SNj=1
			if(Thorns) user.HasThornsOn+=Thorns
			if(IgnoreLimb) user.IgnoresBrokenLimbs+=IgnoreLimb
			if(DisableRegen) user.DisableRegen+=DisableRegen
			if(KiBPEffect) user.KiDoesNotAffectBP+=KiBPEffect

			if(BoundWeapon)
				if(user.HasHammerTime)
					user.OffMult*=1.06
					user.SpdMult*=1.06
				if(user.HasSwordsman&&!user.HasHammerTime) user.OffMult*=1.08
				user.SwordOn=1+CritCan
				user.HammerOn=1+CritCan
				user.BoundWeaponOn=WeaponLevel

			if(isicon(icon)) //user.overlays += src
				var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
				_overlay.pixel_x = pixel_x
				_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays += _overlay

			if(buffon) for(var/mob/player/M in view(usr)) M.BuffOut("[user] [buffon]")
			user.overlays-=user.HealthBar
			user.overlays-=user.EnergyBar
			if(istype(src,/Skill/Buff/Expand))
				if(usr.Race=="Namekian") animate(usr, transform = matrix()*1.5, time = 3)
				else animate(usr, transform = matrix()*1.3, time = 3)
			if(istype(src,/Skill/Buff/Makyo_Form))animate(usr, transform = matrix()*2, time = 3)
			if(istype(src,/Skill/Buff/Giant_Mode))animate(usr, transform = matrix()*2, time = 3)
			if(istype(src,/Skill/Buff/Ancient_Form))animate(usr, transform = matrix()*2, time = 3)
			if(usr.Class=="Legendary")
				if(istype(src,/Skill/Buff/SSj))
					animate(usr, transform = matrix()*1.5, time = 3)
			if(TimedBuff) spawn(TimedBuff) if(Using) debuff(user,ExtraOver,KiBPEffect,DisableRegen,IgnoreLimb,Thorns,NeedsSword,SNJ,Shield,Ultra)
			user.overlays+=user.HealthBar
			user.overlays+=user.EnergyBar

			if(ExtraOver) //user.overlays+=ExtraOver
				var/image/_overlay = image(ExtraOver) // In order to get pixel offsets to stick to overlays we create an image
		//		_overlay.pixel_x = pixel_x
		//		_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays += _overlay
				user.ExtraOvers += _overlay

		debuff(mob/user,var/ExtraOver,var/KiBPEffect,var/DisableRegen,var/IgnoreLimb,var/Thorns,var/NeedsSword,var/SNJ,var/Shield,var/Ultra,var/BoundWeapon) if(Using)
			if(!ismob(user)) return
			if(buffslot) user.BuffNumber-=buffslot
			user.Buffs -= buffname
			Using = 0
			user.BPMult/=src.BP
			user.StrMult/=src.Str
			user.EndMult/=src.End
			user.SpdMult/=src.Spd
			user.PowMult/=src.Pow
			user.OffMult/=src.Off
			user.DefMult/=src.Def
			user.RegenMult/=Regen
			user.RecovMult/=Recov
			user.AngerMult/=Anger
			user.energydraining-=energydrain
			user.healthdraining-=healthdrain
			user.staticenergydraining-=staticenergydrain
			if(istype(src,/Skill/Buff/Mystic))
				user.ismystic=0
				user.issupermystic=0
			if(istype(src,/Skill/Buff/Majin))
				user.ismajin=0
				user.issupermajin=0
			if(Ultra) user.Precognition-=Ultra
			if(Shield) user.Shielding=0
//			if(SNJ) user.SNj=0
			if(Thorns) user.HasThornsOn=0
			if(IgnoreLimb) user.IgnoresBrokenLimbs-=IgnoreLimb
			if(DisableRegen) user.DisableRegen-=DisableRegen
			if(KiBPEffect) user.KiDoesNotAffectBP-=KiBPEffect
			if(Tier>=5) user.UsingTier5--

			if(BoundWeapon||istype(src,/Skill/Buff/Bound_Weapon))
				if(user.HasHammerTime)
					user.OffMult/=1.06
					user.SpdMult/=1.06
				if(user.HasSwordsman&&!user.HasHammerTime) user.OffMult/=1.08
				user.SwordOn=0
				user.HammerOn=0
				user.BoundWeaponOn=0
			if(isicon(icon)) //user.overlays += src
				var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
				_overlay.pixel_x = pixel_x
				_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays -= _overlay

	//		if(isicon(icon)) user.overlays -= src
	//		if(ExtraOver) user.overlays-=ExtraOver
//			user.HairAdd()
			if(buffoff) for(var/mob/player/M in view(usr)) M.BuffOut("[user] [buffoff]")
			if(istype(src,/Skill/Buff/Expand)) animate(usr, transform = null, time = 3)
			if(istype(src,/Skill/Buff/Adaptive))
				CDTick(user)
			if(istype(src,/Skill/Buff/Combat_Mathematics))
				CDTick(user)
			if(istype(src,/Skill/Buff/Ascend))
				CDTick(user)
			if(istype(src,/Skill/Buff/Makyo_Form)) animate(usr, transform = null, time = 3)
			if(istype(src,/Skill/Buff/Giant_Mode)) animate(usr, transform = null, time = 3)
			if(istype(src,/Skill/Buff/Ancient_Form)) animate(usr, transform = null, time = 3)

			if(ExtraOver) //user.overlays+=ExtraOver
				var/image/_overlay = image(ExtraOver) // In order to get pixel offsets to stick to overlays we create an image
			//	_overlay.pixel_x = pixel_x
			//	_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays -= _overlay
				user.ExtraOvers -= _overlay

Skill/Support/Give_Power
	var/LastUse = 0
	Tier=4
	UB1="Machine Force"
	UB2="Channel"
	Experience=100
	desc="You can transfer your health and energy to someone right beside you by clicking them. It will \
	knock your character out. The person can exceed 100% power if you have enough health and energy \
	to give to them. The effect is only temporary, because health and energy do not stay above 100% \
	for long."
	verb/Give_Power()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.KOd) return
		if(usr.Lethality!=1)
			usr << "You must be set for Lethal Combat to do this!"
			return
		if(usr.Willpower<35)
			usr << "You do not have the Willpower to do this!"
			return
		if(WipeDay<LastUse+0.5)
			usr<<"You cannot use this until day [LastUse+0.5]."
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			if(A.GotPower==1) return
			LastUse=WipeDay
			usr.Willpower-=30
			A.HealDamage("Give Power ([usr])", round(usr.Health*0.35,0.5))
			A.Ki+=usr.Ki
			A.GotPower=1
		//	usr.KO("giving power to [A]")
			usr.Health*=0.75
			usr.Ki*=0.01
			A.Power_Giving_Reset()
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] gives [key_name(A)] their power")
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

Skill/Zanzoken
	UB1="Godspeed"
	UB2="Kaioken"
	desc="Zanzoken allows you to instantly move to another location within a short range. \
	To use it, simply click the spot you want to go to, within sight, and your character will teleport there. (3 Charges Max)"
	var/tmp/Charges=3
	icon='Zanzoken.dmi'
	Experience=100
	Tier=2
	var/Zon=0
	verb/Toggle_Zanzoken()
		set category="Other"
		if(Zon)
			Zon = 0
			usr.BuffOut("Zanzoken toggled off.")
			return
		else
			Zon = 1
			usr.BuffOut("Zanzoken toggled on.")
			return
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
	verb/Toggle_Combo()
		set category="Other"
		if(usr.attacking) return
		if(!usr.Warp)
			usr.BuffOut("Combo Toggle On. (Increases attack speed by 5x but reduced damage per attack to 1/5.)")
			usr.Warp=1
			usr.attacking=1
			spawn(4) usr.attacking=0
		else
			usr.BuffOut("Combo Toggle Off. (Normal attack speed and damage.)")
			usr.Warp=0
			usr.attacking=1
			spawn(4) usr.attacking=0



	verb/Customize_Zanzoken_Icon()
		set category="Other"
		if(usr.Confirm("Do you want to have custom icon for your Zanzoken?"))

			var/ICO=input("Select an icon to use.","Custom Zanzoken Icon") as null|icon
			if(!ICO)
				return 0
			var/size = length(ICO)
			Size(size)
			if(length(ICO) > iconsize)
				alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
				return 0
			else
				usr << "Icon accepted!"
				usr.CustomZanzokenIcon=ICO

		else
			var/CC=input("Choose a default zanzoken icon") in list("Default","Male Shadow","Female Shadow","Black Hole","Lightning","Flame","Flame2","Flame3","Leaf","Light","Tech","Rune","Snow","Thorn","Water","Wind","Cherry")

			switch(CC)
				if("Default") usr.CustomZanzokenIcon='Zanzoken.dmi'
				if("Male Shadow") usr.CustomZanzokenIcon='Male Shadow.dmi'
				if("Female Shadow") usr.CustomZanzokenIcon='Female Shadow.dmi'
				if("Black Hole") usr.CustomZanzokenIcon='Black Hole.dmi'
				if("Lightning") usr.CustomZanzokenIcon='Lightning Zanzo.dmi'
				if("Flame") usr.CustomZanzokenIcon='Flame Zanzo.dmi'
				if("Flame2") usr.CustomZanzokenIcon='Flame2 Zanzo.dmi'
				if("Flame3") usr.CustomZanzokenIcon='Flame3 Zanzo.dmi'
				if("Leaf") usr.CustomZanzokenIcon='Leaf Zanzo.dmi'
				if("Light") usr.CustomZanzokenIcon='Light Zanzo.dmi'
				if("Tech") usr.CustomZanzokenIcon='Tech Zanzo.dmi'
				if("Water") usr.CustomZanzokenIcon='Water Zanzo.dmi'
				if("Rune") usr.CustomZanzokenIcon='Rune Zanzo.dmi'
				if("Snow") usr.CustomZanzokenIcon='Snow Zanzo.dmi'
				if("Thorn") usr.CustomZanzokenIcon='Thorn Zanzo.dmi'
				if("Wind") usr.CustomZanzokenIcon='Wind Zanzo.dmi'
				if("Cherry") usr.CustomZanzokenIcon='Cherry Zanzo.dmi'




Skill/Support/Telekinesis
	Experience=100
	verb/Toggle_Telekinesis()
		set category="Other"
		if(usr.TK)
			usr.TK = 0
			usr << "Telekinesis toggled off."
			return
		else
			usr.TK = 1
			usr << "Telekinesis toggled on."
			return
Skill/Spell/Telekinesis_Magic
	Experience=100
	verb/Toggle_Magical_Telekinesis()
		set category="Other"
		if(usr.TK_Magic)
			usr.TK_Magic = 0
			usr << "Magical telekinesis toggled off."
			return
		else
			usr.TK_Magic = 1
			usr << "Magical telekinesis toggled on."
			return

Skill/Support/Keep_Body
	Experience=100
	desc="Using this on someone will allow them to use 85% of their power while dead."
	verb/Keep_Body()
		set category="Other"
		for(var/mob/M in get_step(usr,usr.dir))
			switch(input("Allow [M] to keep their body?") in list("Yes","No"))
				if("Yes")
					M.KeepsBody=1
					if(M.last_icon) M.icon = M.last_icon
					alertAdmins("[key_name(usr)] has allowed [key_name(M)] to keep their body")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has allowed [key_name(M)] to keep their body.\n")
				if("No")
					M.KeepsBody=0
					alertAdmins("[key_name(usr)] has prevented [key_name(M)] from keeping their body")
			break


Skill/Support/Make_Fruit
	Experience=100
	desc="With this you can make fruits that will increase the power and energy of those who eat them, \
	along with a temporary boost to regeneration and recovery. The more of them you eat however, the \
	less of an effect they will have each time."
	var/tmp/Making=0
	var/LastUse=0
	verb/Make_Fruit()
		set category="Other"
		if(Making)
			usr<<"You are already making one"
			return
		if(WipeDay<LastUse+2)
			usr<<"You must wait before making another one. (Day [LastUse+2])"
			return
		Making=1
		view(usr)<<"[usr] begins planting something"
		LastUse=WipeDay
		sleep(750)
		Making=0
		view(usr)<<"A strange fruit appears in front of [usr]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] makes a Fruit.\n")
		//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] made a Fruit")
		var/obj/items/Fruit/A=new(get_step(usr,usr.dir))
		A.name="[usr] Fruit"
		A.XP = usr.GainMultiplier

Skill/Buff/False_Moon
	Experience=100
	Tier=2
	desc="A skill that uses Ki to create a False Moon that will trigger any nearby Saiyan's Oozaru transformation."
	verb/False_Moon()
		set category="Skills"
		if(usr.getCooldown("[src]")>world.time)
			usr<<"You must wait longer."
			return
		if(usr.RPMode) return
		if(usr.KOd) return
		if(usr.Ki<=100) return
		else
			CDTick(usr)
			if(Experience<100) Experience+=rand(10,21)
			if(Experience>100) Experience=100
			var/obj/items/Moon/M = new
			M.loc=locate(usr.x,usr.y+1,usr.z)
			M.icon_state="On"
			M.Despawn()
			for(var/mob/A in view(12,usr))
				if(locate(/obj/items/Mark_Of_The_Beast) in A) A.Werewolf()
				else if(A.HasWerewolf >= 1) A.Werewolf()
				else A.Oozaru()
			usr.Ki/=1.05
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)


Skill/Support/Bind
	Experience=100
	var/LastUse=0
	var/LastUnBind=0
	desc="You can use this to bind someone to hell. You can only bind a person who is less than your own power at the time. The stronger they are compared to you the more energy it will drain to bind them (1 Year CD)"
	verb/Bind()
		set category="Other"
		if(usr.RPMode) return
		if(LastUse+0.5>WipeDay)
			usr<<"You can not use this until day [LastUse+0.5]."
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
			if(A.KOd)
				if(A.BP>usr.BP)
					view(usr)<<"[usr] attempts to bind [A] to hell, but [A]'s spiritual power deflects it!"
					return
				if(usr.Ki<usr.MaxKi*0.9)
					usr<<"You need at least 90% energy to attempt a bind"
					return
				if(A.BindPower)
					view(usr)<<"[usr] strengthens the bind already placed on [A]!"
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] strenghtens the bind already placed on [A].\n")
					A.BindPower+=usr.MaxKi
				else

					view(usr)<<"[usr] successfully binds [A] to the afterlife!"
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] binds [key_name(A)] to Hell.")
					alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] binds [key_name(A)] to the Afterlife.")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] binds [key_name(A)] to the Afterlife.\n")
					A.BindPower=usr.MaxKi
					spawn A.Bind_Return()
				usr.Ki=0
				LastUse=WipeDay
			else
				usr << "[A] must be knocked out in order to use this."
				return
	verb/UnBind()
		set category="Other"
		if(LastUnBind+1>Year)
			usr<<"You can only use this once every year"
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client) if(A.BindPower)
			if(usr.Ki<usr.MaxKi*0.9)
				usr<<"You need at least 90% energy to attempt to remove a bind"
				return
			LastUnBind=Year
			A.BindPower-=usr.Ki
			usr.Ki=0
			if(A.BindPower<=0)
				view(usr)<<"[usr] succeeds in breaking the bind placed on [A]!"
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from hell")
				alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from hell")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] unbound [key_name(A)] from Hell.\n")
				A.BindPower=0
			else
				view(usr)<<"[usr] weakened the bind somewhat, but did not yet break it"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] weakened the bind somewhat, but did not yet break it.\n")
			return

/*
mob/proc/MajinRemove() if(Majin_By)
	for(var/obj/MajinAbsorbReleaser/Maj in MajinRemove) if(Majin_By==Maj.MajinKey)
		Majin_Revert()
		for(var/Skill/Buff/Majin/MJ in src) del(MJ)
		src<<"The person who majinized you has perished and their power over you has faded away."

*/
mob/var/tmp/Absorbed = 0
mob/var/MajinAbsorbed
obj/MajinAbsorbReleaser
	var
		SendX
		SendY
		SendZ
		MajinKey

mob/proc/MajinAbsorbRelease()
	for(var/obj/MajinAbsorbReleaser/Maj in MajinAbsorbRemove) if(MajinAbsorbed==Maj.MajinKey)
		MajinAbsorbed=0
		loc=locate(Maj.SendX,Maj.SendY,Maj.SendZ)
		for(var/Skill/Support/ObserveAbsorber/OA in src) del(OA)

Skill/Misc/Absorb
	var/LastUse = 0
	Experience=100
	desc="This allows you to add the power of a person you absorb into your own. This bonus BP caps at +30% Base BP. The Release option lets you release the power you have absorbed. \
	Absorb does have disadvantages, it will reduce your healing and energy recovery ticks by 50% at full absorb BP. Also if your a living creature you cannot absorb androids, unless you yourself are a bio-android."
	verb/Release_Absorb()
		set category="Other"
		switch(input("Are you sure you want to release this absorbed power?") in list("No","Yes"))
			if("Yes")
				usr<<"You release all your absorbed power"
				usr.Absorb=0
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(!M.client) return
		if(usr.SaveAge<3)
			usr<<"A save must be atleast three days old to absorb."
			return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(M.Race=="Android")
			usr<<"You can not absorb an android."
			return
		if(usr.Lethality!=1)usr.Lethality=1
		if(M.Willpower>0) return
		if(WipeDay<LastUse+1)
			usr<<"You cannot use this until day [LastUse+1]"
			return
		if(usr.Absorb>=usr.Base)
			view(usr)<<"[usr] attempts to absorb [M], but finds that they cannot hold any more power"
			return
		view(usr)<<"[usr] absorbs [M]!"
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		LastUse =WipeDay
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has Absorbed [key_name(M)] for [AbsorbBP] power.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has absorbed [key_name(M)] for [AbsorbBP] power.\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		M.Absorbed = 1
		spawn M.Death(usr)


Skill/Misc/Absorb_Android
	var/LastUse = 0
	Experience=100
	desc="This allows you to destroy another Android and take their upgrade modules as well as a portion of their Base and Energy. (+25% of their Base/Energy) 1 year CD"
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(usr.Race!="Android") return
		if(M.Willpower>0) return
		if(usr.SaveAge<3)
			usr<<"A save must be atleast three days old to absorb."
			return
		if(M.Race!="Android")
			usr<<"You can only absorb other androids."
			return
		if(usr.Lethality!=1)usr.Lethality=1
		if(WipeDay<LastUse+1)
			usr<<"You cannot use this until day [LastUse+1]"
			return
		view(usr)<<"[usr] android absorbs [M]!"
		LastUse=WipeDay
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has Android Absorbed [key_name(M)] for [AbsorbBP] power.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has android absorbed [key_name(M)] for [AbsorbBP].\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		M.Absorbed = 1
		spawn M.Death(usr)

Skill/Misc/Absorb_Bio
	var/LastUse = 0
	Experience=100
	desc="This allows your to absorb the power of a defeated enemy. You get a Base BP boost equal to 25% of the absorbed person's base, 10% of their Max Ki and 10% of their lifespan. (1 year CD)"
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(usr.Race!="Bio-Android") return
		if(M.Willpower>0) return
		if(usr.SaveAge<3)
			usr<<"A save must be atleast three days old to absorb."
			return
		if(WipeDay<LastUse+1)
			usr<<"You cannot use this until day [LastUse+1]"
			return
		if(usr.Lethality!=1)usr.Lethality=1
		view(usr)<<"[usr] absorbs [M]!"
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		LastUse=WipeDay
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has bio Absorbed [key_name(M)] for [AbsorbBP] power.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has bio absorbed [key_name(M)] for [AbsorbBP]  BP!.\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		M.Absorbed = 1
		spawn M.Death(usr)
		spawn usr.Bio_Forms()

Skill/Misc/Absorb_Majin
	var/LastUse = 0
	Experience=100
	desc="This allows your to absorb the power of a defeated enemy. You will absorb them into your being and utilize their power while they remain within you. (Locked in a TFR like map. \
Granted option to reincarnate or wait out your death, when they will be released.) You get a Base BP boost equal to 20% of the absorbed person's base and you gain Absorb BP equal to half their Base, for a total of 60% of their power. (1 year CD)"
	verb/Absorb(mob/M in get_step(usr,usr.dir))
		set category="Other"
		if(usr.SaveAge<3)
			usr<<"A save must be atleast three days old to absorb."
			return
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd|M.KOd==0) return
		if(usr.Race!="Majin") return
		if(M.Willpower>0) return
		if(WipeDay<LastUse+1)
			usr<<"You cannot use this until day [LastUse+1]"
			return
		if(usr.Lethality!=1)usr.Lethality=1
		if(M.MajinAbsorbed==usr.key)
			usr<<"You have already absorbed their power and are unable to gain any further benefit."
			M.Death(usr)
			spawn M.loc=locate(250,250,8)
			LastUse =WipeDay
			alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has majin Absorbed [key_name(M)] but got no bonus due to already absorbing them..")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has majin absorbed [key_name(M)] but got no bonus due to already absorbing them..\n")
			return
		view(usr)<<"[usr] absorbs [M]!"
		var/AbsorbBP=M.Base
		usr.Absorb+=AbsorbBP
		var/Absorb_Max = usr.Base*0.3
		if(usr.Absorb>Absorb_Max) usr.Absorb=Absorb_Max
		var/Mutes=2
		fig1
		if(Mutes)if(usr.MutationNumber<round(usr.TotalXP/400))
			var/X=pick("Strength Mod","Endurance Mod","Speed Mod","Offense Mod","Defense Mod","Recovery","Max Anger","BP Mod")
			if(M.MutationNumber) X=pick(M.Mutations)
			switch(X)
				if("BP Mod") if(!usr.UniqueMutation)
					usr.BPMod*=1.05
					usr.Mutations+="BP Mod"
					usr.MutationNumber++
					Mutes--
					usr.UniqueMutation=1
				if("Max Anger") if(!usr.UniqueMutation)
					usr.BaseMaxAnger*=1.05
					usr.Mutations+="Max Anger"
					usr.MutationNumber++
					Mutes--
					usr.UniqueMutation=1
				if("Strength Mod") 
					usr.StrMod*=1.1
					usr.Mutations+="Strength Mod"
					usr.MutationNumber++
					Mutes--
				if("Endurance Mod")
					usr.EndMod*=1.1
					usr.Mutations+="Endurance Mod"
					usr.MutationNumber++
					Mutes--
				if("Speed Mod")
					usr.SpdMod*=1.1
					usr.Mutations+="Speed Mod"
					usr.MutationNumber++
					Mutes--
				if("Offense Mod")
					usr.OffMod*=1.1
					usr.Mutations+="Offense Mod"
					usr.MutationNumber++
					Mutes--
				if("Defense Mod")
					usr.DefMod*=1.1
					usr.Mutations+="Defense Mod"
					usr.MutationNumber++
					Mutes--
				if("Recovery") if(!usr.UniqueMutation)
					usr.BaseRecovery*=1.05
					usr.Mutations+="Recovery"
					usr.MutationNumber++
					Mutes--
					usr.UniqueMutation=1
			if(X) usr<<"([X] Mutation Stolen!)"
			alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has majin Absorbed [key_name(M)] for [AbsorbBP] power. ([X] Mutation)")
			goto fig1
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has majin absorbed [key_name(M)] for [AbsorbBP].\n")
		usr.Health=(usr.Willpower/usr.MaxWillpower)*100
		usr.Ki=usr.MaxKi
		LastUse=WipeDay
		spawn M.Death(usr,"[usr.key]")
		spawn M.contents+=new/Skill/Support/ObserveAbsorber
		spawn M.loc=locate(283,214,17)
	verb/Release()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.Race!="Majin") return
		var/list/Choices=list()
		for(var/mob/player/M in Players) if(M.MajinAbsorbed==usr.key) Choices+=M
		Choices+="Cancel"
		var/mob/CC=input(usr,"Choose someone to release.","Majin Absorb") in Choices
		if(CC=="Cancel") return
		else if(usr.Confirm("Release [CC]? (You will lose your Absorb BP)"))
			usr.Absorb=0
			alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has majin released [key_name(CC)]")
			CC.loc=locate(usr.x,usr.y,usr.z)
			for(var/Skill/Support/ObserveAbsorber/OA in CC) del(OA)
			CC.MajinAbsorbed=null


Skill/Misc/Absorb_Energy
	Experience=100
	var/LastUse = 0
	desc="You may use this in place of an injure when you win a round of combat. This will steal 15% of their max ki and 10% of their decline age to add to your own."
	verb/Energy_Absorb(mob/M in get_step(usr,usr.dir))
		set category="Skills"
		if(usr.RPMode) return
		if(!M.client) return
		if(M.client) if(M.client.address==usr.client.address) return
		if(usr.KOd)return
		if(M.KOd==0) return
		if(M.Willpower>30)
			usr<<"They must be at 30 Willpower or below."
			return
		if(usr.SaveAge<3)
			usr<<"A save must be atleast three days old to absorb."
			return
		if(WipeDay<LastUse+2)
			usr<<"You cannot use this until day [LastUse+2]"
			return
		view(usr)<<"[usr] absorbs some of [M]'s energy!"
		M << "You feel weaker, as some years off your life are suddenly stolen or consumed..."
		var/AbsorbNRG
		var/AbsorbD
		AbsorbNRG=M.MaxKi*0.15
		AbsorbD=M.Decline/10
		usr.BaseMaxKi+=AbsorbNRG
		usr.Decline+=AbsorbD
		M.MaxKi-=AbsorbNRG
		M.Decline-=AbsorbD
		usr.Ki=usr.MaxKi
		alertAdmins("([usr.x], [usr.y], [usr.z])[key_name(usr)] has absorbed [key_name(M)]'s energy.")
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has absorbed some of [key_name(M)]'s energy!.\n")
		LastUse =WipeDay
		usr.Ki=usr.MaxKi

Skill/Support/InstantTransmission
	CDOverride=3600
	var/Teachable=0
	NotTeachable=1
	Experience=1
	Tier=5
	var/Zon=0
	var/tmp/inUse //A temporary var so the state doesn't get saved or logging out while using it might bug the skill.
	desc="Shunkan Ido, also known as Instant Transmission, is self-explanatory. If you have enough \
	skill you can detect powers further away, and teleport to them. The more skill you have the \
	less time it will take to locate their energy. Anyone next to you will also be brought with you. \
	Some people are just too weak to sense, even to someone with very high skill in Shunkan Ido"
	verb/Instant_Transmission(var/obj/Contact/X in usr.Contacts)
		set category="Skills"
		set src=usr.contents
		if(usr.RPMode) return
		var/mob/A = null
		for(var/mob/M in Players)
			if(M.ckey == X.pkey)
				if(M.Race == "Android")
					usr << "Androids do not have an energy signature!"
					return
				if(M.BP<5000)
					usr<<"You can't seem to find their energy within range."
					return
				else if(M.z!=usr.z) if(M.BP<250000)
					usr<<"You can't seem to find their energy on this planet."
					return
				if(X.familiarity >= 15)
					A = M
					break
				else
					usr << "You're not familiar enough with that energy signature to find it."
					return

		if(A)
			var/restricted = list(9,13,16)
			var/al = list(10,11)
			var/lr = list(1,2,3,4,5,6,7,8,12,14,15,17)
			var/travel_al = 0
			if(usr.z in lr) if(A.z in al) travel_al=1
			if(usr.z in al) if(A.z in lr) travel_al=1
			if(A.z in restricted)
				usr<<"You cannot teleport to other dimensions."
				return
			if(usr.z in restricted)
				usr<<"You cannot locate their energy from here."
				return
			/*if(travel_al) if(X.familiarity<40)
				usr<<"You cannot sense their energy..."
				return*/
			if(travel_al) if(!RealmTeleport) if(!usr.IgnoreRealmTeleport)
				usr<<"You cannot teleport to other dimensions."
				return
		if(!A) return
		if(A.afk)
			usr<<"You can not reach them now."
			return
		if(usr.Ki<100||inUse)
			usr<<"You do not have enough energy"
			return
		if(!usr.CanAttack(usr.MaxKi*0.3,src)) return
		inUse=1
		view(usr)<<"[usr] begins concentrating..."
		var/OldHP=usr.Health
		usr<<"This may take a minute..."
		var/Modifier=1
		if(usr.Race=="Yardrat"||usr.Race=="Half-Yardrat") Modifier=2
		sleep(1200/(Experience/5)/Modifier)
		if(Experience<100) Experience+=rand(5,9)
		if(Experience>100) Experience=100
		if(usr.Health<OldHP)
			usr<<"Interrupted due to damage."
			inUse=0
			return
		if(usr.KOd==0&&usr.Ki>100)
			if(A)
				if(usr.isGrabbing)
					usr.GrabRelease()
				usr<<"You found their energy signature."
				CDTick(usr)
				oview(usr)<<"[usr] disappears in a flash!"
				for(var/mob/B in oview(1,usr)) if(B.client) if(B.client.address!=usr.client.address)
					oview(B)<<"[B] disappears!"
					B.loc=A.loc
					step_rand(B)
					spawn(1) oview(B)<<"[B] suddenly appears!"
				usr.loc=A.loc
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] teleported to [key_name(A)] who was at [A.loc]\n")
				step_rand(usr)
				inUse=0
			else
				usr<<"They logged out..."
				inUse=0
/*	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
*/
Skill/Support/Teleport
	Experience=100
	desc="Teleport to any planet instantly. This will drain all your energy. Anyone who is beside \
	you will be taken with you if Realm Teleport is enabled. (Once every 3 years)"
	var/LastUse=0
	verb/Realm_Teleport()
		set category="Other"
		if(usr.RPMode) return
		/*if(usr.z==8)
			usr<<"You can not teleport out of this place."
			return*/
		if(usr.MaxKi<3000)
			usr<<"You do not have enough energy to use this."
			return
		if(usr.Ki<usr.MaxKi)
			usr<<"You need full energy to use this."
			return
		var/list/Planets=new
		Planets.Add("Cancel","Afterlife")
		if(usr.KPAuthorized) Planets.Add("???")
		if(RealmTeleport||usr.IgnoreRealmTeleport) Planets.Add("Arconia","Earth","Namek","Vegeta","Ice","Desert","Jungle","Alien","Ocean","Dark Planet")
		//else if(usr.RPPower>1.2) Planets.Add("Arconia","Earth","Namek","Vegeta","Ice","Desert","Jungle","Alien")
		var/image/I=image(icon='Black Hole.dmi',icon_state="full")
		I.icon+=rgb(rand(0,255),rand(0,255),rand(0,255))
		var/CHOICE=input("Choose a realm") in Planets
		if(CHOICE!="Afterlife"&&CHOICE!="???"&&CHOICE!="Cancel")
			if(WipeDay<LastUse+1)
				usr<<"You cannot use this until day [LastUse+1]."
				return
		switch(CHOICE)
			if("Afterlife")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(183,71,11)
				CHOICE="Afterlife"
			if("Arconia")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(364,253,5)
				CHOICE="Arconia"
			if("Earth")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,1)
				CHOICE="Earth"
			if("Namek")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(279,372,2)
				CHOICE="Namek"
			if("Vegeta")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(333,462,3)
				CHOICE="Vegeta"
			if("Ice")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(246,227,4)
				CHOICE="Ice"
			if("Desert")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(112,123,14)
				CHOICE="Desert"
			if("Jungle")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(108,370,14)
				CHOICE="Jungle"
			if("Android")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(238,429,9)
				CHOICE="Android"
			if("Alien")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(342,79,14)
				CHOICE="Alien"
			if("Dark Planet")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(290,107,6)
				CHOICE="Dark Planet"
			if("???")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(400,400,10)
				CHOICE="???"
			if("Cancel") return
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio Teleport to go to planet [CHOICE].\n")
		LastUse=WipeDay
		usr.Ki=0

Skill/Support/DemonTeleport
	Experience=100
	desc="Teleport to any planet instantly. This will drain all your energy. Anyone who is beside uou will be taken with you if Makyo Star is  enabled. (3 Year CD. When the Makyo Star is NOT out, you must grab the other person. Grab chains are not allowed and anyone abusing this will be stripped of their rank.)"
	var/LastUse=0
	verb/Realm_Teleport()
		set category="Other"
		if(usr.RPMode) return
		if(usr.z==16)
			usr<<"You can not teleport out of this place."
			return
		if(usr.MaxKi<3000)
			usr<<"You do not have enough energy to use this."
			return
		if(usr.Ki<usr.MaxKi)
			usr<<"You need full energy to use this."
			return
		var/list/Planets=new
		Planets.Add("Cancel","Afterlife","Arconia","Earth","Namek","Vegeta","Ice","Desert","Jungle","Alien","Ocean","Dark Planet")
		var/image/I=image(icon='Black Hole.dmi',icon_state="full")
		I.icon+=rgb(rand(0,255),rand(0,255),rand(0,255))
		var/CHOICE=input("Choose a realm") in Planets
		if(CHOICE!="Afterlife"&&CHOICE!="???"&&CHOICE!="Cancel"&&CHOICE!="Hell")
			if(WipeDay<LastUse+2)
				usr<<"You cannot use this until day [LastUse+2]."
				return
		switch(CHOICE)
			if("Afterlife")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(203,78,11)
				CHOICE="Afterlife"
		//	if("Hell")
		//		if(usr.isGrabbing)
		//			usr.GrabRelease()
		//		flick(I,usr)
		//		for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
		//		usr.loc=locate(254,255,19)
		//		CHOICE="Afterlife"
			if("Arconia")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(364,253,5)
				CHOICE="Arconia"
			if("Earth")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(250,250,1)
				CHOICE="Earth"
			if("Namek")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(279,372,2)
				CHOICE="Namek"
			if("Vegeta")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(333,462,3)
				CHOICE="Vegeta"
			if("Ice")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(246,227,4)
				CHOICE="Ice"
			if("Desert")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(112,123,14)
				CHOICE="Desert"
			if("Jungle")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(108,370,14)
				CHOICE="Jungle"
			if("Ocean")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(370,80,14)
				CHOICE="Jungle"
			if("Android")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(238,429,9)
				CHOICE="Android"
			if("Alien")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(MakyoStar) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(342,79,14)
				CHOICE="Alien"
			if("Dark Planet")
				if(usr.isGrabbing)
					usr.GrabRelease()
				flick(I,usr)
				if(RealmTeleport) for(var/mob/A in oview(1,usr)) spawn(1) A.loc=usr.loc
				usr.loc=locate(290,107,6)
				CHOICE="Dark Planet"
			if("Cancel") return
		LastUse=WipeDay
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Demon Teleport to go to planet [CHOICE].\n")
		usr.Ki=0


mob/var/KPAuthorized=0
obj/KaioshinControls
	/*verb/Toggle_Realm_Teleport()
		set category = "Skills"
		if(!usr.Confirm("Toggle Global Realm Teleport? Current is [RealmTeleport]")) return
		else RealmTeleport=!RealmTeleport
		usr<<"Realm Teleport: [RealmTeleport ? "On" : "Off"]"
		logAndAlertAdmins("([usr.key]) [usr] set Global Realm Teleport to [RealmTeleport ? "On" : "Off"]",2)*/
	verb/Allow_Planet_Access(mob/M in oview(1))
		set category = "Skills"
		if(M.client)
			if(!M.KPAuthorized)
				M.KPAuthorized=1
				usr<<"[M] can now access your planet."
				M<<"[usr] has granted you access to the Kaioshin Planet."
			else
				M.KPAuthorized=0
				usr<<"[M] can no longer access the Kaioshin Planet."
				M<<"[usr] has revoked your access to the Kaioshin Planet."

mob/proc/AuraOverlays(donotapply)
	overlays.Remove(GodKiAura,/Icon_Obj/Cloak/SSG2,/Icon_Obj/Cloak/Bojack,/Icon_Obj/Cloak/SSJ1,/Icon_Obj/Cloak/SSJ2,/Icon_Obj/Cloak/SSJ2FP,/Icon_Obj/Cloak/LSSJ,/Icon_Obj/Cloak/SN,/Icon_Obj/Cloak/SSR,/Icon_Obj/Cloak/SSGSS,/Icon_Obj/Cloak/SSGFP,/Icon_Obj/Cloak/SSRFP,'Aura SSj3.dmi','Sparks LSSj.dmi','SNj Elec.dmi',\
	'Electric_Mystic.dmi','Mutant Aura.dmi','Void Aura.dmi','Rising Rocks.dmi','Elec PU 3.dmi',/Icon_Obj/Cloak/PowerCloak)
	underlays-=/Icon_Obj/Cloak/SSj4
	for(var/Skill/Buff/Power_Control/A in src)
		overlays-=A
		var/image/G=image(A,layer=EFFECTS_LAYER)
		overlays-=G
		if(A.Powerup>0) if(!donotapply)
			overlays-=G
			//if(Race=="Void Spawn"|ContractPower) overlays+='Void Aura.dmi'
			//if(Race=="Namekian"&&FBMAchieved) overlays+=/Icon_Obj/Cloak/SN
			//else if(Race=="Heran") overlays+='Mutant Aura.dmi'
			if(GodKiActive&&!ssj)
				if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan")
					if(Class!="Legendary") overlays+=/Icon_Obj/Cloak/SSG2
					else
						overlays+=/Icon_Obj/Cloak/SSG2
				else overlays+=GodKiAura
			else if(Bojack) overlays+=/Icon_Obj/Cloak/Bojack
			else if(!ssj) if(MaxKi>=500) overlays+=G
			else if(ssj&&Class=="Legendary")
				overlays+=/Icon_Obj/Cloak/LSSJ
			else if(ssj == 1&&Class!="Legendary") overlays+=/Icon_Obj/Cloak/SSJ1
			else if(ssj == 2&&SSj2Drain<280&&Class!="Legendary") overlays+=/Icon_Obj/Cloak/SSJ2
			else if(ssj == 2&&Class!="Legendary") overlays+=/Icon_Obj/Cloak/SSJ2FP
			else if(ssj == 3)
				overlays+=/Icon_Obj/Cloak/SSJ2
				overlays+=/Icon_Obj/Cloak/SSJ1
			else if(ssj == 4) underlays+=/Icon_Obj/Cloak/SSj4
			else if(ssj==5)
				if(SSGSSColor=="Rose"&&SSGSSDrain<=290) overlays+=/Icon_Obj/Cloak/SSR
				else if(SSGSSColor=="Rose") overlays+=/Icon_Obj/Cloak/SSRFP
				else if(ssj == 5&&SSGSSDrain<=290) overlays+=/Icon_Obj/Cloak/SSGSS
				else if(ssj == 5) overlays+=/Icon_Obj/Cloak/SSGFP
			if(ismystic) overlays+='Electric_Mystic.dmi'
			//if(BP> 1000000)
			if(BP> 25000) overlays+='Rising Rocks.dmi'
			if(BP> 250000) overlays+='Elec PU 3.dmi'
			if(BP> 2500000) overlays+=/Icon_Obj/Cloak/PowerCloak
			break

/*
				var/image/_overlay = image(ExtraOver) // In order to get pixel offsets to stick to overlays we create an image
				_overlay.pixel_x = pixel_x
				_overlay.pixel_y = pixel_y
				_overlay.layer= EFFECTS_LAYER+layer
				user.overlays += _overlay
*/

turf/proc/Rising_Rocks()
	overlays-='Rising Rocks.dmi'
	overlays+='Rising Rocks.dmi'
	spawn(rand(20,150)) if(src) overlays-='Rising Rocks.dmi'


var/image/Self_Destruct_Fire=image(icon='Lightning flash.dmi',layer=99)

turf/proc/Self_Destruct_Lightning(B) if(B)
	overlays-=Self_Destruct_Fire
	overlays+=Self_Destruct_Fire
	spawn(B) if(src) overlays-=Self_Destruct_Fire

Skill/Attacks/Self_Destruct
	UB1="Death"
	UB2="Arcane Power"
	Experience=100
	Tier=3
	desc="Using this will kill you. It is an extremely powerful attack, one of the top 3 at least. It will affect a large area."
	verb/Self_Destruct()
		set category="Skills"
		if(usr.RPMode) return
		if(Using) return
		if(usr.KOd) return
		if(!usr.CanAttack(200,src)) return
		if(usr.Willpower>70)
			usr<<"This technique requires 70 or less Willpower."
			return
		if(!usr.Lethality) if(!usr.Confirm("Lethality is currently off. Using SD will set lethality on. Continue?")) return
		switch(input("Self Destruct?") in list("No","Yes"))
			if("Yes") if(!usr.Dead&&usr.KOd==0&&usr.CanAttack(200,src))
				usr.Lethality=1
				usr.move=0
				Using=1
				for(var/mob/player/P in view(12)) P.BuffOut("[usr] begins gathering all the energy around him into his body!")
				sleep(30)
				for(var/mob/player/P in view(12)) P.BuffOut("The ground begins to shake fiercely around [usr]!")
				sleep(30)
				if(usr.KOd)
					Using=0
					usr.move=1
					return
				for(var/mob/player/P in view(12)) P.BuffOut("A huge explosion emanates from [usr] and surrounds the area!")
				for(var/turf/T in view(usr,8))
				//	if(prob(7)) sleep(1)
					if(T) spawn T.Self_Destruct_Lightning(rand(50,100))
					//T.Health-=100*usr.Pow
					T.TakeDamage(src, 100*usr.Off, "Self Destruct")
					spawn(rand(50,100)) {if(usr!=0) T.Destroy(usr,usr.key);else T.Destroy("Unknown","Unknown")}
					for(var/mob/M in T) if(M!=usr)if(!M.afk)
						M.TakeDamage(usr, ((usr.BP+usr.Off)/(M.BP+M.End))*100, "Self Destruct")
						//M.Health-=((usr.BP+usr.Pow)/(M.BP+M.Res))*120
						if(M.Health<=0)
							if(M.Regenerate&&M.KOd==0) if(usr.BP>M.BP*M.Regenerate) M.Absorbed=1
							spawn M.Death(usr)
				usr.Death("Self Destruct")
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Self Destruct.\n")
				usr.Ki=0
				usr.move=1
				spawn(10) if(usr) src.Using=0

Skill/Attacks/SuperExplosiveWave
	UB1="War"
	UB2="Channel"
	Experience=100
	Tier=4
	desc="This is similar to self destruct but you don't die. It deals less damage but is faster as a result."
	verb/Super_Destructive_Wave()
		set category="Skills"
		if(usr.RPMode) return
		if(Using) return
		if(usr.KOd) return
		if(!usr.CanAttack(200,src)) return
		/*if(usr.Health<=25)
			usr<<"This requires atleast 26% Health to use."
			return*/
		//if(!usr.Lethality) if(!usr.Confirm("Lethality is currently off. Use SD and die without killing anyone?")) return
		switch(input("Super Explosive Wave?") in list("No","Yes"))
			if("Yes") if(!usr.Dead&&usr.KOd==0&&usr.CanAttack(200,src))
				usr.move=0
				CDTick(usr)
				Using=1
				for(var/mob/player/P in view(12)) P.BuffOut("[usr] begins gathering all the energy around him into his body!")
				sleep(25)
				for(var/mob/player/P in view(12)) P.BuffOut("The ground begins to shake fiercely around [usr]!")
				sleep(25)
				if(usr.KOd)
					Using=0
					usr.move=1
					return
				for(var/mob/player/P in view(12)) P.BuffOut("A huge explosion emanates from [usr] and surrounds the area!")
				for(var/turf/T in view(usr,5))
				//	if(prob(7)) sleep(1)
					if(T) spawn T.Self_Destruct_Lightning(rand(50,100))
					T.TakeDamage(usr, 40*usr.Off, "Super Explosive Wave")
					spawn(rand(50,100)) {if(usr!=0) T.Destroy(usr,usr.key);else T.Destroy("Unknown","Unknown")}
					for(var/mob/M in T) if(M!=usr) if(!M.afk)
						var/DamageDealt=((usr.BP+usr.Off)/(M.BP+M.End))*40
						M.TakeDamage(usr, DamageDealt, "Super Explosive Wave")
						if(M.Health<=0) M.KO(usr)
						M.Shockwave_Knockback(15,usr.loc)
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Super_Explosive_Wave")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Super_Explosive_Wave.\n")
				usr.DrainKi(src, "Percent", 25)
				usr.TakeDamage(src,25, "Super Explosive Wave")
				usr.move=1
				spawn(10) if(usr) src.Using=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
Skill/Attacks/Grand_Explosion
	Experience=100
	Tier=5
	desc="Causes you to unleash a massive Force based explosion from your body. Costs 10% of energy and 15% Health."
	verb/Grand_Explosion()
		set category="Skills"
		if(usr.RPMode) return
		if(Using) return
		if(usr.KOd) return
		if(!usr.CanAttack(200,src)) return
		/*if(usr.Ki/usr.MaxKi<=0.25)
			usr<<"This requires atleast 26% energy to use."
			return*/
		//if(!usr.Lethality) if(!usr.Confirm("Lethality is currently off. Use SD and die without killing anyone?")) return
		switch(input("Grand Explosion?") in list("No","Yes"))
			if("Yes") if(!usr.Dead&&usr.KOd==0&&usr.CanAttack(200,src))
				usr.move=0
				CDTick(usr)
				Using=1
				for(var/mob/player/P in view(12)) P.BuffOut("[usr] begins gathering all the energy around him into his body!")
				sleep(20)
				for(var/mob/player/P in view(12)) P.BuffOut("The ground begins to shake fiercely around [usr]!")
				sleep(20)
				if(usr.KOd)
					Using=0
					usr.move=1
					return
				for(var/mob/player/P in view(12)) P.BuffOut("A huge explosion emanates from [usr] and surrounds the area!")
				for(var/turf/T in view(usr,5))
				//	if(prob(7)) sleep(1)
					if(T) spawn T.Self_Destruct_Lightning(rand(50,100))
					T.TakeDamage(usr, 20*usr.Off, "Grand Explosion")
					//T.Health-=60*usr.Pow
					spawn(rand(50,100)) {if(usr!=0) T.Destroy(usr,usr.key);else T.Destroy("Unknown","Unknown")}
					for(var/mob/M in T) if(M!=usr) if(!M.afk)
						var/DamageDealt=((usr.BP+usr.Off)/(M.BP+M.End))*20
						M.TakeDamage(usr, DamageDealt, "Grand Explosion")
						//M.TakeDamage(usr, DamageDealt)
						if(M.Health<=0) M.KO(usr)
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Grand Explosion")
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Grand Explosion.\n")
				//usr.Ki=max(0,usr.Ki*0.5)
				usr.DrainKi(src, "Percent", 10)
				usr.TakeDamage(src, 15, "Grand Explosion")
				usr.move=1
				spawn(10) if(usr) src.Using=0


Skill/Support/Kaio_Revive
	Experience=100
	desc="This will bring someone back to life. You cannot use it more than once every 2.5 years."
	var/LastUse=0
	verb/Revive()
		set category="Other"
		if(WipeDay<LastUse+2.5)
			usr<<"You can not use this til day [LastUse+2.5]"
			return
		if(usr.Dead)
			usr<<"You cannot use this if you are dead."
			return
		//if(usr.Decline*0.9<=usr.Age) if(!usr.Confirm("This may cause  you to begin to age... Continue?")) return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.client&&A.Dead)
			if(WipeDay<A.Died+Dead_Time)
				usr<<"This can't be used on someone not attuned to the realm of the dead, their incorporeal form hasn't been deceased long enough. This process usually takes [Dead_Time] years."
				return
			view(usr)<<"[A] is revived by [usr]"
			LastUse=WipeDay
			A.Revive()
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio Revive on [key_name(A)]")
			alertAdmins("[key_name(usr)] used Kaio Revive on [key_name(A)]")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Kaio Revive on [key_name(A)].\n")
			A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was revived by [key_name(usr)] (Kaio Revive).\n")
			//if(A.InclineAge<A.Age) A.InclineAge=A.Age+1
			break

Skill/Support/Heal
	UB1="Channel"
	UB2="Machine Force"
	Tier=2
	desc="You can heal anyone in front of you by giving up some of your own health and energy. If they \
	have certain status problems they can be further alleviated by healing them, with multiple heals \
	they may be cured."
	Experience=1
	verb/Heal()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.KOd||usr.Ki<usr.MaxKi/usr.KiMod) return
		if(!usr.CanAttack(usr.MaxKi*0.1,src)) return
		for(var/mob/A in get_step(usr,usr.dir))
			if(!A.client) return
			if(Experience<100) Experience+=rand(4,9)
			if(Experience>100) Experience=100
			CDTick(usr)
			usr.TakeDamage(usr, 50/(Experience/25), "Healing [A]")
			usr.DrainKi(src,1,(usr.MaxKi/usr.KiMod)/(Experience/50))//usr.Ki=max(0,usr.Ki-)
			if(A.Willpower<=0) A.WillpowerRestore()
			if(A.Willpower<100&&A.Willpower>0&&usr.Willpower>10)
				A.Willpower+=0.1*(Experience/10)
				usr.Willpower-=0.05*(Experience/10)
				if(usr.Willpower<1) usr.Willpower=1
			A.Un_KO()
			A.HealDamage("Heal ([usr])", round(25*(Experience/25),0.5))
			for(var/BodyPart/P in A)
				if(usr.RPPower>1.1) if(P.Health<=P.MaxHealth) A.Injure_Heal(20,P,1)
				else if(P.Health<=P.MaxHealth) A.Injure_Heal(10,P)
			A.Heal_Zenkai()
			if((A.Health/A.MaxHealth)*100>(A.Willpower/A.MaxWillpower)*100) A.Health=(A.Willpower/A.MaxWillpower)*100
			view(usr)<<"<font color=#FFFF00>[usr] heals [A]"
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] healed [key_name(A)]")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] healed [key_name(A)].\n")
			A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was healed by [key_name(usr)].\n")
			break
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
mob/var/tmp/SolarFlared=0

Skill/Attacks/SolarFlare
	UB1="Kaioken"
	Experience=100
	Tier=3
	desc="Solar Flare blinds an Opp for a limited amount of time. \
	The amount of time the person is blinded depends on their regeneration. It is mainly used so \
	that they dont see what direction you went in, and so that they cant pursue you until they can \
	see again"
	verb/Solar_Flare()
		set category="Skills"
		if(usr.RPMode) return
		if(!usr.CanAttack(usr.MaxKi*0.1,src)) return
		if(!usr.attacking)
			CDTick(usr)
			usr.attacking=3
			usr.Ki*=0.8
			var/distance=round(usr.Ki*0.001)
			if(distance>15) distance=20
			if(distance<1) distance=1
			for(var/turf/A in orange(usr,distance)) A.Self_Destruct_Lightning(5)
			sleep(5)
			for(var/mob/A in orange(usr,distance))if(!A.afk)
				if(A.SolarFlareHit(usr,A,distance))

					A.SolarFlare(distance)
					A<<"You are blinded by [usr]'s Taiyoken"
					var/BodyPart/Eyes/L =locate(/BodyPart/Eyes) in A
					var/DamageD=(25*((usr.BP*usr.Pow)/(A.BP*A.End)))
					if(A.Critical_Sight == 0) A.Injure_Hurt(DamageD,L,usr)
				else A<<"You managed to avoid looking at the solar flare."


			spawn(usr.Refire) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

mob/proc/SolarFlareHit(mob/U,mob/T,distance)
	var/didHit=0
	if(get_dir(T, U)==T.dir)didHit=1
	if(get_dir(T, U)==turn(T.dir, 45))didHit=1
	if(get_dir(T, U)==turn(T.dir, -45))didHit=1
	if(get_dist(T, U)<= 1)didHit=1
	return didHit

obj
	Taiyoken
		icon='Taiyoken.dmi'
		layer=999
mob/proc/SolarFlare(var/Power)
	var/duration=20*Power
	SolarFlared=1
	if(duration<20)duration=20
	if(duration>200)duration=200
	var/obj/x=new/obj/Taiyoken
	x.screen_loc="1,1 to 25,25"
	src.client.screen+=x
	spawn(20)src.client.screen-=x
	spawn(30)src.client.screen-=x
	while(prob(90))
		x.icon_state=pick("1","2","3","4")
		if(prob(40))sleep(0.1)
	while(prob(80))
		x.icon_state=pick("5","6","7","8")
		if(prob(40))sleep(0.1)
	while(prob(70))
		x.icon_state=pick("9","10","11","12")
		if(prob(40))sleep(0.1)
	while(prob(80))
		x.icon_state=pick("13","14","15","16")
		if(prob(40))sleep(0.1)
	while(prob(90))
		x.icon_state=pick("17","18","19","20")
		if(prob(40))sleep(0.1)
	src.client.eye=null
	SolarFlared=0
	spawn(duration)src.client.eye=src


Skill/Support/Imitation
	Experience=100
	desc="You can use this on someone to imitate them in almost every way, so much so that you may be confused with them. You can hit it again to stop imitating."
	var/imitating
	var/imitatorname
	var/list/imitatoroverlays=new
	var/imitatoricon
	var/imitatetext
	verb/Imitate()
		set category="Skills"
		if(usr.RPMode) return
		if(!imitating)
			imitating=1
			imitatorname=usr.name
			imitatoroverlays.Add(usr.overlays)
			imitatoricon=usr.icon
			var/list/People=new
			for(var/mob/A in oview(usr,10)) if(!istype(A,/mob/Admin_Mode)) People.Add(A)
			var/Choice=input("Imitate who?") in People
			for(var/mob/A in People) if(A==Choice)
				usr.icon=A.icon
				usr.overlays.Remove(usr.overlays)
				usr.overlays.Add(A.overlays)
				usr.AFKRemove()
				usr.name=A.name
				usr.Signature_True = usr.Signature
				usr.Signature = A.Signature
				imitatetext=usr.TextColor
				usr.TextColor=A.TextColor
				/*var/properAge = "Infant"
				if(A.Age>1) properAge="Young"
				if(A.Age==A.InclineAge||A.Age>A.InclineAge) properAge="Prime"
				if(A.Decline-A.Age<15) properAge="Mature"
				if(A.Decline-A.Age<5) properAge="Old"
				if(A.Age>A.Decline) properAge="Elderly"*/
				//usr.FakeAge=properAge
				//usr.FakeGender=uppertext(A.gender)
				//usr.FakePortrait=A.Portrait
				//if(!A.ShowGender) usr.FakeGender="???"
				//usr.FakeHeight=A.Height
				//usr.FakeWeight=A.BodyWeight
				//usr.FakeBackstory=A.Backstory

				if(!A.CustomProfile) usr.FakeProfile=A.DefaultProfile[1]
				else usr.FakeProfile=A.CustomProfile[1]

				imitating=1
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] imitates [key_name(A)].\n")
		else usr.ImitationCancel()

mob/proc/ImitateRevert()for(var/Skill/Support/Imitation/II in src) if(II.imitating)
	II.imitating=0
	name=II.imitatorname
	overlays.Remove(overlays)
	overlays.Add(II.imitatoroverlays)
	icon=II.imitatoricon
	Signature = Signature_True
	TextColor=II.imitatetext
	II.imitatoroverlays.Remove(II.imitatoroverlays)
	FakeProfile=null
	//FakeAge=null
	//FakeGender=null
	//FakePortrait=null
	//FakeHeight=null
	//FakeWeight=null
	//FakeBackstory=null
	Signature_True=null
	saveToLog("| | ([x], [y], [z]) | [key_name(src)] deactivates imitate.\n")
mob/proc/ImitationCancel() for(var/Skill/Support/Imitation/II in src) if(II.imitating) ImitateRevert()
Skill/Support/Invisibility
	Experience=100
	desc="You can use this to make yourself invisible. Some people with very good senses will still know you are there, or if they have visors capable of seeing invisible objects."
	verb/Invisibility()
		set category="Skills"
		if(usr.RPMode) return
		if(Using&&!usr.invisibility) // Using will be 1 but their invisiblity disabled if they've attacked while invisible.
			usr<<"Your body feels too tense and you are unable to turn invisible!"
			Using=0
			return
		else if(!usr.invisibility&&!Using)
			usr.invisibility=99
			usr.see_invisible=99
			Using=1
			usr<<"You are now invisible."
			//if(usr.SOverlayToggle == 1)
			winset(usr.client,"INVIS","is-visible=true")
		else if(usr.invisibility&&Using)
			usr.see_invisible=0
			usr.invisibility=0
			winset(usr.client,"INVIS","is-visible=false")
			usr<<"You are visible again."
			spawn(45){Using=0;src<<"You can now turn invisible again."}
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [usr.invisibility ? "is now invisible" : "is no longer invisible"].\n")

//mob/var/tmp/Observee=null
mob/var/tmp/Observer=null

Skill/Support/ObserveAbsorber
	desc="This will allow you to observe the person who absorbed you.  You will also see says/emotes that they see."
	Experience=100
	verb/Observe_Absorber()
		set category="Other"
		set src=usr.contents
		var/list/Choices=list()
		Choices+=usr
		for(var/mob/M in Players) if(M.key==usr.MajinAbsorbed) Choices+=M
		var/mob/MM=input("Choose") in Choices
		usr.Get_Observe(MM)
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe on [key_name(MM)].\n")
Skill/Support/Observe
	desc="This will allow you to observe someone's character.  You will also see says/emotes that they see."
	Experience=100
	verb/Observe()
		set category="Other"
		set src=usr.contents
		var/mob/A=input(usr,"Choose someone to observe.") as mob in Players
		if(A.HelmetOn>=3)
			usr<<"You can not seem to locate this person."
			return
		if(A=="Cancel") return
		usr << "You are now watching [A]."
		usr.Get_Observe(A)
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe on [key_name(A)].\n")








Skill/Support/Observe_Majinizations
	Experience=100
	verb/Observe_Majinizations()
		set category="Other"
		set src=usr.contents
		var/list/CanO=list()
		for(var/mob/T in Players) if(T.Majin_By==usr.key) CanO+=T
		CanO+=usr
		var/mob/M=input("Choose who to observe") in CanO
		if(M == usr)
			usr.Get_Observe(M)
			return
		if(M.Majin_By == usr.key)
			usr << "You use your link to [M] and see through their eyes. Observe yourself to reset your view."
			usr.Get_Observe(M)
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe majinization on [key_name(M)].\n")



mob/proc/Get_Observe(mob/M, hear=1)
	if(M==src)
		//Observee=null
		for(var/mob/player/MM in Players) if(MM.Observer==usr.key) MM.Observer=null
		src.reset_view(null)//client.eye=src
	else
		if(hear)
			if(M) M.Observer=src.key
		src.reset_view(M)


Skill/Support/NamekianFusion
	Experience=100
	RequiresApproval=1
	Tier=4
	desc="You can use this to fuse with another person of the same race. You will die from it, but the \
	other person will gain a very large power boost. If the person was your counterpart, it breaks that \
	bond forever. (You will not gain extra from fusing with your counterpart.)"
	//var/list/Fused=new
	var/tmp/Fusing
	verb/Namekian_Fusion()
		set category="Other"
		set src=usr.contents
		if(usr.RPMode) return
		if(Fusing) return
		if(usr.Dead) return
		if(usr.SaveAge<5)
			usr<<"Your save must be five years old before you can fuse."
			return
		for(var/mob/A in get_step(usr,usr.dir)) if(A.Race==usr.Race) if(usr.Confirm("Fuse with [A]?"))
			if(A.Fusions>=2)
				usr<<"You cannot fuse with this person, they have already fused too many times."
				return
			if(A.client) if(A.client.address==usr.client.address||!A.client||A.Dead||A.Race!=usr.Race)
				usr<<"You cannot fuse with this person"
				return
			if(usr.Offspring)if(findtext(usr.Parents,A.client.key))
				usr<<"You cannot fuse with your parent. (They may fuse into you though.)"
				return
			Fusing=1
			var/Choice=alert(A,"[usr] wants to fuse with you and give you their power, do you accept?","","No","Yes")
			switch(Choice)
				if("Yes")
					A.RemoveBuffs()
					usr.RemoveBuffs()
					view(usr)<<"[usr] fuses with [A]!"
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Fusion with [key_name(A)]")
					alertAdmins("[key_name(usr)] used Fusion with [key_name(A)]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Fusion with [key_name(A)]\n")
					A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] fused via Fusion with [key_name(usr)].\n")
					A.RacialPowerAdd+=(usr.Base/3)
					A.BaseMaxKi+=(usr.BaseMaxKi/3)
					A.BPMod*=1.1
					A.Decline+=10
					A.Fusions++
					A.Fusions+=usr.Fusions
					if(A.Fusions>=3)A.Fusions=3
					//Fused.Add(A.key)
					if(usr.Counterpart=="[A]([A.key])")
						usr.Counterpart=null
						A.Counterpart=null
					spawn
						usr.Absorbed=1
						usr.Death("sacrificed their life through fusion")
						//usr.Save()
						usr.Reincarnation()
				else view(A)<<"[A] declines [usr]'s offer to fuse"
			Fusing=0
/*	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)*/
Skill/Technology/MakeWeights
	Experience=100
	Tier=2
	desc="You can use this to make weighted clothing."
	verb/Make_Weights()
		set category="Other"
		switch(input("") in list("Check Lift","Make Weights","Cancel"))
			if("Check Lift")
				var/list/Mobs=new
				for(var/mob/B in view(usr)) Mobs+=B
				var/mob/A=input("Who?") as null | anything in Mobs
				alert("[A] can lift [Commas((A.BaseStr+A.BaseEnd)*2)] pounds. You make up to [Commas(usr.MaxKi*usr.KiMod)]")  //Was .5
				if(usr.Confirm("Make [A] weights? ([Commas(10*((A.BaseStr+A.BaseEnd)*2)*(1-(0.15*usr.HasDeepPockets)))] Resources)"))
					var/obj/Resources/AA
					for(var/obj/Resources/B in usr) AA=B
					var/WM=(A.BaseStr+A.BaseEnd)*2
					var/WR
					if(WM>usr.MaxKi*usr.KiMod)
						WR=WM-(usr.MaxKi*usr.KiMod)
						WM=usr.MaxKi*usr.KiMod
					WM=round(WM)
					var/Cost=10*WM*(1-(0.15*usr.HasDeepPockets))
					if(AA.Value<Cost)
						usr<<"You do not have enough resources."
						return
					AA.Value-=Cost
					var/obj/items/Weights/WA=new(get_step(usr,usr.dir))
					WA.Weight=round(WM)
					WA.name="[round(WA.Weight)]lb Weights ([A])"
					WA.icon='Clothes_Wristband.dmi'
					if(WR)
						WM=WR
						WR=0
						if(WM>usr.MaxKi*usr.KiMod)
							WR=WM-(usr.MaxKi*usr.KiMod)
							WM=usr.MaxKi*usr.KiMod
						WM=round(WM)
						var/obj/items/Weights/WA2=new(get_step(usr,usr.dir))
						WA2.Weight=round(WM)
						WA2.name="[round(WA2.Weight)]lb Weights ([A])"
						WA2.icon='Clothes_Wristband.dmi'
						if(WR)
							WM=WR
							WR=0
							if(WM>usr.MaxKi*usr.KiMod)
								WR=WM-(usr.MaxKi*usr.KiMod)
								WM=usr.MaxKi*usr.KiMod
							Cost=10*WM*(1-(0.15*usr.HasDeepPockets))
							WM=round(WM)
							var/obj/items/Weights/WA3=new(get_step(usr,usr.dir))
							WA3.Weight=round(WM)
							WA3.name="[round(WA3.Weight)]lb Weights ([A])"
							WA3.icon='Clothes_Wristband.dmi'
			if("Make Weights")
				var/Weights=input("How heavy? Between 1 and [Commas(usr.MaxKi*usr.KiMod)] pounds. You can lift [Commas((usr.BaseStr+usr.BaseEnd)*2)] pounds (Costs 10 resources per pound.)") as num
				if(!Weights) return
				if(Weights>usr.MaxKi*usr.KiMod) Weights=usr.MaxKi*usr.KiMod
				if(Weights<1) Weights=1
				Weights=round(Weights)
				var/Cost=10*Weights*(1-(0.15*usr.HasDeepPockets))
				var/obj/Resources/AA
				for(var/obj/Resources/B in usr) AA=B
				if(AA.Value<Cost)
					usr<<"You do not have enough resources."
					return
				AA.Value-=Cost
				var/obj/items/Weights/A=new(get_step(usr,usr.dir))
				A.Weight=round(Weights)
				A.name="[round(A.Weight)]lb Weights"
				var/style=pick("Cape","Shirt","Wristbands","Scarf","Turban")
				switch(style)
					if("Cape") A.icon='Clothes_Cape.dmi'
					if("Shirt") A.icon='Clothes_ShortSleeveShirt.dmi'
					if("Wristbands") A.icon='Clothes_Wristband.dmi'
					if("Scarf") A.icon='Clothes_NamekianScarf.dmi'
					if("Turban") A.icon='Clothes_Turban.dmi'
				var/RGB=input("") as color|null
				if(RGB) A.icon+=RGB

Skill/Support/Materialization
	Experience=100
	Tier=2
	desc="You can use this to materialize clothing that has different weights. The more energy you get the higher weight you can make."
	verb/Materialize()
		set category="Other"
		switch(input("") in list("Check Lift","Make Weights","Cancel"))
			if("Check Lift")
				var/list/Mobs=new
				for(var/mob/B in view(usr)) Mobs+=B
				var/mob/A=input("Who?") as null | anything in Mobs
				alert("[A] can lift [Commas((A.BaseStr+A.BaseEnd)*2)] pounds. You make up to [Commas(usr.MaxKi*usr.KiMod)]")  //Was .5
				if(usr.Confirm("Make [A] weights? ([Commas(((A.BaseStr+A.BaseEnd)*2)*5*(1-(0.15*usr.HasDeepPockets)))] Mana)"))
					var/Cost=((A.BaseStr+A.BaseEnd)*2)*5*(1-(0.15*usr.HasDeepPockets))
					var/obj/Mana/AA
					for(var/obj/Mana/B in usr) AA=B
					if(AA.Value<Cost)
						usr<<"You do not have enough mana."
						return
					AA.Value-=Cost
					var/WM=(A.BaseStr+A.BaseEnd)*2
					var/WR
					if(WM>usr.MaxKi*usr.KiMod)
						WR=WM-(usr.MaxKi*usr.KiMod)
						WM=usr.MaxKi*usr.KiMod
					WM=round(WM)
					var/obj/items/Weights/WA=new(get_step(usr,usr.dir))
					WA.Weight=round(WM)
					WA.name="[round(WA.Weight)]lb Weights ([A])"
					WA.icon='Clothes_Wristband.dmi'
					if(WR)
						WM=WR
						WR=0
						if(WM>usr.MaxKi*usr.KiMod)
							WR=WM-(usr.MaxKi*usr.KiMod)
							WM=usr.MaxKi*usr.KiMod
						WM=round(WM)
						var/obj/items/Weights/WA2=new(get_step(usr,usr.dir))
						WA2.Weight=round(WM)
						WA2.name="[round(WA2.Weight)]lb Weights ([A])"
						WA2.icon='Clothes_Wristband.dmi'
						if(WR)
							WM=WR
							WR=0
							if(WM>usr.MaxKi*usr.KiMod)
								WR=WM-(usr.MaxKi*usr.KiMod)
								WM=usr.MaxKi*usr.KiMod
							WM=round(WM)
							var/obj/items/Weights/WA3=new(get_step(usr,usr.dir))
							WA3.Weight=round(WM)
							WA3.name="[round(WA3.Weight)]lb Weights ([A])"
							WA3.icon='Clothes_Wristband.dmi'
			if("Make Weights")
				var/Weights=input("How heavy? Between 1 and [Commas(usr.MaxKi*usr.KiMod)] pounds. You can lift [Commas((usr.BaseStr+usr.BaseEnd)*2)] pounds (Costs [5*(1-(0.15*usr.HasDeepPockets))] mana per pound.)") as num
				if(!Weights) return
				if(Weights>usr.MaxKi*usr.KiMod) Weights=usr.MaxKi*usr.KiMod
				if(Weights<1) Weights=1
				Weights=round(Weights)
				var/Cost=5*Weights*(1-(0.15*usr.HasDeepPockets))
				var/obj/Mana/AA
				for(var/obj/Mana/B in usr) AA=B
				if(AA.Value<Cost)
					usr<<"You do not have enough mana."
					return
				AA.Value-=Cost
				var/obj/items/Weights/A=new(get_step(usr,usr.dir))
				A.Weight=round(Weights)
				A.name="[round(A.Weight)]lb Weights"
				var/style=pick("Cape","Shirt","Wristbands","Scarf","Turban")
				switch(style)
					if("Cape") A.icon='Clothes_Cape.dmi'
					if("Shirt") A.icon='Clothes_ShortSleeveShirt.dmi'
					if("Wristbands") A.icon='Clothes_Wristband.dmi'
					if("Scarf") A.icon='Clothes_NamekianScarf.dmi'
					if("Turban") A.icon='Clothes_Turban.dmi'
				var/RGB=input("") as color|null
				if(RGB) A.icon+=RGB
			if("Make Sword")
				var/obj/items/Sword/A=new
				A.Health+=usr.Base*usr.KiMod
				A.EquipmentDescAssign()
				A.loc=get_step(usr,usr.dir)
			if("Make Armor")
				var/obj/items/Armor/A=new
				A.Health+=100
				A.EquipmentDescAssign()
				A.loc=get_step(usr,usr.dir)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
Skill/Support/Restore_Youth
	Experience=100
	var/LastUse=0
	desc="You can use this to change someone's age to their body's peak."
	verb/Restore_Youth(mob/player/M in oview(1,usr))
		set category="Skills"
		set src=usr.contents
		if(usr.RPMode) return
		if(usr.Dead)
			usr<<"You may not do this while dead."
			return
		if(WipeDay<LastUse+3)
			usr<<"You cannot use this until day [LastUse+3]"
			return
		if(!M) return
		if(M.SaveAge<14)
			usr<<"They must have a save age of atleast 14."
			return
		if(!M.client) return
		if(usr.Confirm("Restore [M]'s youth?"))
			switch(input(M,"Do you want [usr] to restore your youth?") in list("No","Yes",))
				if("Yes")
					M.Age=M.InclineAge
					M.Body=M.InclineAge
					LastUse=WipeDay
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has altered [key_name(M)]'s age to [M.Age]")
					alertAdmins("[key_name(usr)] has altered [key_name(M)]'s age to [M.Age]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has altered [key_name(M)]'s age to [M.Age].\n")
					M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(M)]'s age was altered to [M.Age] by [key_name(usr)].\n")
				if("No")
					usr<<"[M] declined your offer."
/*
obj/Sacred_Water
	icon='props.dmi'
	icon_state="Closed"
	desc="This raises your endurance up to a certain level, as long as it is not already above that \
	level"
	density=1
	Savable=0
	Spawn_Timer=180000
	verb/Drink()
		set category="Other"
		set src in oview(1)
		if(usr.KOd) return
		if(icon_state!="Open")
			icon_state="Open"
			spawn(600) icon_state="Closed"
		view(usr)<<"[usr] drinks from the sacred water jar"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks from the sacred water jar.\n")
		usr.Health-=20000/usr.BaseEnd
		if(usr.BaseEnd<400*usr.EndMod) usr.BaseEnd=400*usr.EndMod
*/


obj/QuestGiver
	verb/Create_Quest()
		set src=usr.contents
		set category="Event Character"
		if(usr.Confirm("Would you like to create a new quest?"))
			var/obj/Quest/Q=new
			Q.QuestGiverKey=usr.key
			Q.QuestGiverName=usr.name
			Q.QuestDate=Year
			Q.QuestName=input("What is the name of this quest? (Shows up as X (Quest))") as text
			Q.name="[Q.QuestName] (Quest)"
			Q.QuestObjective=input("What is the objective of this quest? (Shows up as Objective: X)") as text
			Q.QuestFailure=input("What is the failure condition of this quest? (Shows up as Failure: X)") as text
			Q.QuestReward=input("What is the reward of this quest? (Shows up as Reward: X)") as text
			Q.QuestDescription=input("What is the description of this quest? (Shows up as X at the bottom of the quest entry)") as message
			Q.IsMasterQuest=1
			Q.Status="Master Quest"
			Q.suffix=Q.Status
			usr.contents+=Q
			usr.BuffOut("You have created the quest [Q]!")

mob/var/LastAlignmentAssign=-2
mob/var/LastXPAssign=-2

obj/RankChatECPool
	verb/Rank_Chat(A as text)
		set src=usr.contents
		set category="Event Character"
		var/msg = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
		for(var/mob/player/B in Players)
			if(B.client.holder)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] EC Pool: [msg]"
			else
				for(var/obj/RankChat/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChat2/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChatECPool/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
	verb/Add_Player_Note(mob/M in oview(6))
		set category = "Event Character"
		M.mind.show_memory(usr)
	verb/Create_Quest()
		set src=usr.contents
		set category="Event Character"
		if(usr.Confirm("Would you like to create a new quest?"))
			var/obj/Quest/Q=new
			Q.QuestGiverKey=usr.key
			Q.QuestGiverName=usr.name
			Q.QuestDate=Year
			Q.QuestName=input("What is the name of this quest? (Shows up as X (Quest))") as text
			Q.name="[Q.QuestName] (Quest)"
			Q.QuestObjective=input("What is the objective of this quest? (Shows up as Objective: X)") as text
			Q.QuestFailure=input("What is the failure condition of this quest? (Shows up as Failure: X)") as text
			Q.QuestReward=input("What is the reward of this quest? (Shows up as Reward: X)") as text
			Q.QuestDescription=input("What is the description of this quest? (Shows up as X at the bottom of the quest entry)") as message
			Q.IsMasterQuest=1
			Q.Status="Master Quest"
			Q.suffix=Q.Status
			usr.contents+=Q
			usr.BuffOut("You have created the quest [Q]!")
/*
	verb/Mark_As_Alignment(mob/M in view(12))
		set category="Event Character"
		if(M.LastAlignmentAssign+1<=Year)
			var/Align=input("Mark [M] as being which alignment?") in list("Good","Evil","Neutral")
			view(M)<<"[M] has been marked as [Align]."
			if(M.LastAlignmentAssign+1> Year) return
			switch(Align)
				if("Evil") M.AlignmentNumber-=1
				if("Good") M.AlignmentNumber+=1
				if("Neutral") if(M.AlignmentNumber!=0) M.AlignmentNumber/=3
			M.AlignmentCalibrate()
			M.LastAlignmentAssign=Year
		//	AlignmentHook(usr,M,Align)
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align]")
			logAndAlertAdmins("([usr.Rank]) [key_name(usr)] marked [key_name(M)] to [Align].")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
		else usr<<"Their alignment is on cooldown."*/
/*
	verb/Reward_Experience(mob/M in view(12))
		set category="Event Character"
		if(Year<20)
			if(M.LastXPAssign+1<=Year)
				if(M.XP>=M.TotalXP)
					usr<<"They already have too much stored."
					return
				if(usr.Confirm("Grant [M] +50 XP? (This should be used as an IC reward for training/quests/good RP/etc)"))
					if(M.LastXPAssign+1> Year) return
					M<<"You have been rewarded 50 XP."
					M.XP+=50
					M.TotalXP+=50
					M.LastXPAssign=Year
					logAndAlertAdmins("([usr.Rank]) [M] has been rewarded +50 XP by [usr].")
					usr.saveToLog("| | ([usr.Rank]) [M] has been rewarded +50 XP by [usr].\n")
			else usr<<"Their Reward Experience is on cooldown."*/


obj/RankChat2
	verb/Rank_Chat(A as text)
		set src=usr.contents
		set category="Rank"
		var/msg = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
		for(var/mob/player/B in Players)
			if(B.client.holder)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
			else
				for(var/obj/RankChat/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChat2/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChatECPool/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
	verb/Add_Player_Note(mob/M in oview(12))
		set category = "Rank"
		M.mind.show_memory(usr)
	verb/Create_Quest()
		set src=usr.contents
		set category="Rank"
		if(usr.Confirm("Would you like to create a new quest?"))
			var/obj/Quest/Q=new
			Q.QuestGiverKey=usr.key
			Q.QuestGiverName=usr.name
			Q.QuestDate=Year
			Q.QuestName=input("What is the name of this quest? (Shows up as X (Quest))") as text
			Q.name="[Q.QuestName] (Quest)"
			Q.QuestObjective=input("What is the objective of this quest? (Shows up as Objective: X)") as text
			Q.QuestFailure=input("What is the failure condition of this quest? (Shows up as Failure: X)") as text
			Q.QuestReward=input("What is the reward of this quest? (Shows up as Reward: X)") as text
			Q.QuestDescription=input("What is the description of this quest? (Shows up as X at the bottom of the quest entry)") as message
			Q.IsMasterQuest=1
			Q.Status="Master Quest"
			Q.suffix=Q.Status
			usr.contents+=Q
			usr.BuffOut("You have created the quest [Q]!")

	verb/Mark_As_Alignment(mob/M in view(12))
		set category="Rank"
		if(M.LastAlignmentAssign+1<=Year)
			var/Align=input("Mark [M] as being which alignment?") in list("Good","Evil","Neutral")
			view(M)<<"[M] has been marked as [Align]."
			if(M.LastAlignmentAssign+1> Year) return
			switch(Align)
				if("Evil") M.AlignmentNumber-=1
				if("Good") M.AlignmentNumber+=1
				if("Neutral") if(M.AlignmentNumber!=0) M.AlignmentNumber/=3
			M.AlignmentCalibrate()
			M.LastAlignmentAssign=Year
		//	AlignmentHook(usr,M,Align)
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align]")
			logAndAlertAdmins("([usr.Rank]) [key_name(usr)] marked [key_name(M)] to [Align].")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
		else usr<<"Their alignment is on cooldown."
/*
	verb/Reward_Experience(mob/M in view(12))
		set category="Rank"
		if(Year<20)
			if(M.LastXPAssign+1<=Year)
				if(M.XP>=M.TotalXP)
					usr<<"They already have too much stored."
					return
				if(usr.Confirm("Grant [M] +50 XP? (This should be used as an IC reward for training/quests/good RP/etc)"))
					if(M.LastXPAssign+1> Year) return
					M<<"You have been rewarded 50 XP."
					M.XP+=50
					M.TotalXP+=50
					M.LastXPAssign=Year
					logAndAlertAdmins("([usr.Rank]) [M] has been rewarded +50 XP by [usr].")
					usr.saveToLog("| | ([usr.Rank]) [M] has been rewarded +50 XP by [usr].\n")
			//		XPHook(usr,M)
			else usr<<"Their Reward Experience is on cooldown."*/

obj/RankChat
	var/Acquired=0
	New()
		..()
		if(!Acquired) Acquired=Year
	verb/Rank_Chat(A as text)
		set src=usr.contents
		set category="Rank"
		var/msg = copytext(sanitize(A), 1, MAX_MESSAGE_LEN)
		if(!msg)	return
		for(var/mob/player/B in Players)
			if(B.client.holder)
				B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
			else
				for(var/obj/RankChat/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChat2/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
				for(var/obj/RankChatECPool/RC in B)
					B << "<font color=teal><font size=[B.TextSize]>(Rank Chat) [usr] [usr.Rank]: [msg]"
	verb/Create_Quest()
		set src=usr.contents
		set category="Rank"
		if(usr.Confirm("Would you like to create a new quest?"))
			var/obj/Quest/Q=new
			Q.QuestGiverKey=usr.key
			Q.QuestGiverName=usr.name
			Q.QuestDate=Year
			Q.QuestName=input("What is the name of this quest? (Shows up as X (Quest))") as text
			Q.name="[Q.QuestName] (Quest)"
			Q.QuestObjective=input("What is the objective of this quest? (Shows up as Objective: X)") as text
			Q.QuestFailure=input("What is the failure condition of this quest? (Shows up as Failure: X)") as text
			Q.QuestReward=input("What is the reward of this quest? (Shows up as Reward: X)") as text
			Q.QuestDescription=input("What is the description of this quest? (Shows up as X at the bottom of the quest entry)") as message
			Q.IsMasterQuest=1
			Q.Status="Master Quest"
			Q.suffix=Q.Status
			usr.contents+=Q
			usr.BuffOut("You have created the quest [Q]!")
	verb/Add_Player_Note(mob/M in oview(6))
		set category = "Rank"
		M.mind.show_memory(usr)
	verb/Mark_As_Alignment(mob/M in view(12))
		set category="Rank"
		if(M.LastAlignmentAssign+1<=Year)
			var/Align=input("Mark [M] as being which alignment?") in list("Good","Evil","Neutral")
			view(M)<<"[M] has been marked as [Align]."
			if(M.LastAlignmentAssign+1> Year) return
			switch(Align)
				if("Evil") M.AlignmentNumber-=1
				if("Good") M.AlignmentNumber+=1
				if("Neutral") if(M.AlignmentNumber!=0) M.AlignmentNumber/=3
			M.AlignmentCalibrate()
			M.LastAlignmentAssign=Year
		//	AlignmentHook(usr,M,Align)
			//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align]")
			logAndAlertAdmins("([M.Rank]) [key_name(usr)] marked [key_name(M)] to [Align].")
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
			M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(usr)] marked [key_name(M)] to [Align].\n")
		else usr<<"Their alignment is on cooldown."

	verb/Appoint_Successor(mob/player/M in oview(usr))
		set category = "Rank"
		if(Acquired+10>WipeDay)
			usr<<"You need to have held this for over 10 years."
			return
		if(M==usr)
			usr<<"You can't use this on yourself."
			return
		if(usr.Confirm("Make [M] your successor?"))
			M.Rank=usr.Rank
			usr.Rank=null
			M.contents+=new/obj/RankChat
			M.CreateRank("[M.Rank]")
			for(var/Skill/S in usr) if(S.RankKit) if(!locate(S) in M&&!locate(S.type) in M)
				var/Skill/SS= new S.type
				M.contents+=SS
				SS.RankKit=1
			for(var/X in BasicSkills) if(!locate(X) in M) M.contents+=new X
			SuccessionHook(usr,M,M.Rank)
			logAndAlertAdmins("([M.Rank]) [key_name(usr)] appointed [M] as their successor.")
			spawn(1) del(src)
	verb/Set_Student(mob/m as mob in oview())
		set category = "Rank"
		if(m.Age<5)
			usr<<"They must be atleast 5 years old in order to become a student of your rank."
			return
		if(usr.Confirm("Mark [m] as your student and teach them a technique after 2 days wait?"))
			var/list/Moves=new
			for(var/Skill/K in usr) if(K.RequiresApproval) Moves+=K
			Moves+="Cancel"
			var/Skill/C=input("Choose which technique to teach them! (Only moves that require this notice will show up)") in Moves
			if(C=="Cancel") return
			TrainingHook(usr,m,C)
			C.HasApproval["[m.real_name]"]=WipeDay+2
			usr << "Successfully sent new student to the Discord!"
			alertAdmins("[usr.name]([usr.key]) the [usr.Rank] has set [m.name]([m.key]) as their student for the [C] technique and will be able to teach wipe day [WipeDay+2]!", 1)
	verb/View_Approved_Teachings()
		set category = "Rank"
		for(var/Skill/K in usr) if(K.RequiresApproval&&K.HasApproval) for(var/p in K.HasApproval) usr << "You may teach [K] to [p] on day [K.HasApproval[p]]"
/*	verb/Reward_Experience(mob/M in view(12))
		set category="Rank"
		if(Year<20)
			if(M.LastXPAssign+1<=Year)
				if(M.XP>=M.TotalXP)
					usr<<"They already has too much stored."
					return
				if(usr.Confirm("Grant [M] +50 XP? (This should be used as an IC reward for training/quests/good RP/etc)"))
					if(M.LastXPAssign+1> Year) return
					M<<"You have been rewarded 50 XP."
					M.XP+=50
					M.TotalXP+=50
					M.LastXPAssign=Year
					logAndAlertAdmins("([usr.Rank]) [M] has been rewarded +50 XP by [usr].")
					usr.saveToLog("| | ([usr.Rank]) [M] has been rewarded +50 XP by [usr].\n")
			//		XPHook(usr,M)
			else usr<<"Their Reward Experience is on cooldown."*/
proc/XPHook(mob/Appointer,mob/Appointee)
	var/UserKey = Appointer.key
	var/TargetKey = Appointee.key
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/1187313264691003402/hN_FtJgJkPlXTOnZZflbgn0WQ-CAz1bs2AkPpi3llimuKHuFlTqcwlt9qOP1ZBPbvzUH",
					list(
						content = "**XP Granted** \n ```Rank: [Appointer]([UserKey]) \nTarget: [Appointee]([TargetKey])\nCurrent XP: [Appointee.XP]```",
						username = "[Appointer] the [Appointer.Rank]"
					)
				)
proc/AlignmentHook(mob/Appointer,mob/Appointee,AppointedAlignment)
	var/UserKey = Appointer.key
	var/TargetKey = Appointee.key
	usr.client.HttpPost(
					// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
					"https://discord.com/api/webhooks/1187313264691003402/hN_FtJgJkPlXTOnZZflbgn0WQ-CAz1bs2AkPpi3llimuKHuFlTqcwlt9qOP1ZBPbvzUH",
					list(
						content = "**Marked as [AppointedAlignment]** \n ```Rank: [Appointer]([UserKey]) \nTarget: [Appointee]([TargetKey])\nAlignment: [AppointedAlignment]\nCurrent Alignment: [Appointee.AlignmentNumber]```",
						username = "[Appointer] the [Appointer.Rank]"
					)
				)
				