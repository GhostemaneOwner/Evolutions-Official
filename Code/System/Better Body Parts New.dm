
BodyPart
	parent_type=/obj
	var/MaxHealth=100
	var/CanRegen=0
	var/Status="Healthy"
	var/Cybernetic
	New(mob/M as mob)
		//if(!M) del(src)
		if(M) if(ismob(M))
			Health=MaxHealth
			if(M.Regenerate) CanRegen=1
		..()
	Click()
		usr<<"[src] ([Health] / [MaxHealth] Health)"
		if(src.loc!=usr) return
		//	return
		if(usr.CanLimbRegen)if(!usr.RPMode) if(Status!="Healthy")
			if(usr.Ki>usr.MaxKi*0.5&&usr.Willpower>11)
				if(usr.Confirm("Regenerate [src] (Costs 50% Energy and 10 Willpower?"))
					usr.Ki=usr.Ki*0.5
					usr.Willpower=max(0,usr.Willpower-10)
					usr.Injure_Heal(rand(200),src,1)
					usr.Injure_Heal(rand(200),src,1)
					view(usr)<<"[usr] forcefully regenerates [src]!"
			else usr<<"You require more energy to regenerate your [src]."
		..()
	verb/Injure_Self()
		set name ="Injure Self"
		set category=null
		set src in usr
		if(usr.KeepsBody==0) if(usr.Dead) return
		if(usr.Confirm("Injure Your [src]?")) usr.Injure_Hurt(500,src,usr)
	Head
		desc="Affects some speech and may lead to death."
		icon='Head.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(M.Critical_Head)
					M.Critical_Head = 0
					M.Int_Mod*=2
					M.Magic_Potential*=2
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Head = 0
			..()
	Eyes
		desc="Affects sight."
		icon='Eyes.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(M.Critical_Sight)
					M.Critical_Sight = 0
					M.RemoveBlind()
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy")
				M.Critical_Sight = 0
				M.RemoveBlind()
			..()
	Ears
		desc="Affects hearing."
		icon='Ears.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken") if(M.Critical_Hearing) M.Critical_Hearing = 0
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Hearing = 0
			..()
	Throat
		desc="Affects speech and may lead to death."
		icon='Throat.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken") if(M.Critical_Throat) M.Critical_Throat = 0
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Throat = 0
			..()
	Chest
		desc="Affects Ki, End and Res."
		icon='Chest.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(M.Critical_Torso)
					M.Critical_Torso = 0
					M.Reset_StatMultipliers()
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Torso = 0
			..()
	Left_Arm
		desc="Affects Str and Force."
		icon='Left Arm.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(M.Critical_Left_Arm)
					M.Critical_Left_Arm = 0
					M.Reset_StatMultipliers()
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Left_Arm = 0
			..()
	Left_Leg
		desc="Affects Off, Def and Speed."
		icon='Left Leg.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(M.Critical_Left_Leg)
					M.Critical_Left_Leg = 0
					M.Reset_StatMultipliers()
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Left_Leg = 0
			..()
	Right_Arm
		desc="Affects Str and Force."
		icon='Right Arm.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(M.Critical_Right_Arm)
					M.Critical_Right_Arm = 0
					M.Reset_StatMultipliers()
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Right_Arm = 0
			..()
	Right_Leg
		desc="Affects Off, Def and Speed."
		icon='Right Leg.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(M.Critical_Right_Leg)
					M.Critical_Right_Leg = 0
					M.Reset_StatMultipliers()
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Right_Leg = 0
			..()
	Reproduction
		desc="Affects mating."
		icon='Reproduction.dmi'
		icon_state="Healthy"
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken") if(M.Critical_Mate) M.Critical_Mate = 0
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Mate = 0
			..()
	TailChangeling
		desc="Doesn't affect stats."
		icon='StatusTail.dmi'
		layer=MOB_LAYER+1
	Tail
		var/BP=2.5
		var/Def=0.35
//		var/Moon_Used=0
		var/OozX=-32
		var/OozY=-12
		var/StoredX
		var/StoredY
		icon='StatusTail.dmi'
		layer=MOB_LAYER+1
		proc/GetDescription(mob/Getter)
			desc="This is your tail. Your tail grants you the power to turn into a large ape every full moon. Your BP increases to [BP]x and Defense decreases to [Def]x while in Oozaru"
		//	..()
		var/Setting=1
		var/shown=1
		verb/Custom_Oozaru_Icon()
			//set category="Other"
		/*	if(usr.OozaruIcon.icon!='DSOozaru.dmi')
				usr.OozaruIcon.icon='DSOozaru.dmi'
				return*/
			var/ICO = input("Select an icon to use.","Custom Oozaru Icon") as null|icon
			if(!ICO)
				return 0
			var/size = length(ICO)
			Size(size)
			if(length(ICO) > iconsize)
				alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
				return 0
			else
				var/X_Offset=input(usr,"Choose pixel_x offset, each tile is 32 pixels.") as num
				var/Y_Offset=input(usr,"Choose pixel_y offset") as num
				OozX = X_Offset
				OozY = Y_Offset
				usr << "Icon accepted!"
				usr.OozaruIcon=ICO
		verb/Toggle_Moon_Setting()
			//set category="Other"
			set src in usr
			if(Health<=0|Status!="Healthy") return
			if(Setting)
				Setting=0
				if(usr.Oozaru) usr.Oozaru_Revert()
				usr<<"You decide not to look at the full moon if it comes out"
			else
				if(Health<25)
					usr<<"Your tail is too damaged to wishstand the transformation."
					return
				Setting=1
				usr<<"You decide to look at the moon if it comes out"
		verb/Wrap_Tail()
			//set category="Other"
			set src in usr
			if(Health<=0|Status!="Healthy") return
			if(shown)
				shown=0
				usr.Tail_Remove()
				usr<<"You hide your tail."
			else
				shown=1
				usr.Tail_Add()
				usr<<"You allow your tail to flow freely."
		InjuryHealed(mob/M,forced=0)
			if(Status=="Broken")
				if(istype(src,/BodyPart/Tail)&&M.Critical_Tail)
					M.Critical_Tail = 0
					M.Tail_Add()
			if(Status=="Maimed") Status="Broken"
			if(Status=="Missing"&&forced) Status="Maimed"
			if(Status=="Healthy") M.Critical_Tail = 0
			..()

	proc/LimbCheck(mob/M as mob,mob/S as mob)
		if(!istype(S,/mob/player)) return
		if(!src) return
		if(Status=="Missing") return
//		if(Cybernetic&&Health<=1&&Status=="Broken") return
		if(Health>1) return
		//icon_state = Status
		if(Health<0) Health=0
		if(Health<=1)
			if(Status=="Maimed") if(M!="Kaioken"&&M!="Limit Breaker"&&M!="Gravity")
				Status="Missing"
				if(M) for(var/mob/A in view(S))
					A.CombatOut("<font color = red>[M] has removed [S]'s [src]!")
					A.ICOut("<font color = red>[M] has removed [S]'s [src]!")
				else  for(var/mob/A in view(S))
					A.CombatOut("<font color = red>[S]'s [src] has been removed!")
					A.ICOut("<font color = red>[S]'s [src] has been removed!")
				if(ismob(M)) S.saveToLog(" ([S.x], [S.y], [S.z]) | [key_name(M)]  has  removed [S]'s [src].\n")
				else S.saveToLog("([S.x], [S.y], [S.z]) | [S]'s [src]  has been removed.\n")
				Cybernetic=0
				if(istype(src,/BodyPart/Head))
					var/OldL=0
					if(M.Lethality)OldL=1
					M.Lethality=1
					S.Death(M)
					M.Lethality=OldL
				if(istype(src,/BodyPart/Throat)) if(!S.BreathInSpace) S.Death(M)
				//if(istype(src,/BodyPart/Tail)) del(src)
				return
			if(Status=="Broken") if(M!="Kaioken"&&M!="Limit Breaker"&&M!="Gravity")
				Status="Maimed"
				if(M) for(var/mob/A in view(S))
					A.CombatOut("<font color = red>[M] has maimed [S]'s [src]!")
					A.ICOut("<font color = red>[M] has maimed [S]'s [src]!")
				else  for(var/mob/A in view(S))
					A.CombatOut("<font color = red>[S]'s [src] has been maimed!")
					A.ICOut("<font color = red>[S]'s [src] has been maimed!")
				if(ismob(M)) S.saveToLog(" ([S.x], [S.y], [S.z]) | [key_name(M)]  has  maimed [S]'s [src].\n")
				else S.saveToLog("([S.x], [S.y], [S.z]) | [S]'s [src]  has been maimed.\n")
				return
			if(Status=="Healthy")
				if(istype(src,/BodyPart/Tail))
					if(S.Critical_Tail== 0)
						S.Critical_Tail = 1
						S.Tail_Remove()
						S << "Your tail has been injured!"
				if(istype(src,/BodyPart/Eyes))
					if(S.Critical_Sight == 0)
						S.Critical_Sight = 1
						S.OffMult*=Injury_Max
						S.DefMult*=Injury_Max
						S.BlindOverlay()
						S << "Your ability to see has been damaged."
				if(istype(src,/BodyPart/Reproduction))
					if(S.Critical_Mate == 0)
						S.Critical_Mate = 1
						S << "Your ability to reproduce has been damaged."
				if(istype(src,/BodyPart/Throat))
					if(S.Critical_Throat == 0)
						S.Critical_Throat = 1
						S << "Your ability to speak has been severely damaged."
				if(istype(src,/BodyPart/Ears))
					if(S.Critical_Hearing == 0)
						S.Critical_Hearing = 1
						S << "Your ability to hear has been severely damaged."
				if(istype(src,/BodyPart/Chest))
					if(S.Critical_Torso == 0)
						S.Critical_Torso = 1
						if(!S.IgnoresBrokenLimbs)
							S.KiMult*=Injury_Max
							S.EndMult*=Injury_Max
						S << "Your torso has been crushed badly, you feel some of your energy and endurance slip away..."
				if(istype(src,/BodyPart/Head))
					if(S.Critical_Head == 0)
						S.Critical_Head = 1
						S.Int_Mod/=2
						S.Magic_Potential/=2
						S << "Your head has been crushed badly, you have alot of trouble thinking straight..."
				if(istype(src,/BodyPart/Left_Leg))
					if(S.Critical_Left_Leg == 0)
						if(!S.IgnoresBrokenLimbs)
							S.Critical_Left_Leg = 1
							S.OffMult*=Injury_Max
							S.DefMult*=Injury_Max
							S.SpdMult*=Injury_Max
						S << "Your left leg has been broken..."
				if(istype(src,/BodyPart/Right_Leg))
					if(S.Critical_Right_Leg == 0)
						S.Critical_Right_Leg = 1
						if(!S.IgnoresBrokenLimbs)
							S.OffMult*=Injury_Max
							S.DefMult*=Injury_Max
							S.SpdMult*=Injury_Max
						S << "Your right leg has been broken..."
				if(istype(src,/BodyPart/Right_Arm))
					if(S.Critical_Right_Arm == 0)
						S.Critical_Right_Arm = 1
						if(!S.IgnoresBrokenLimbs)
							S.StrMult*=Injury_Max
							S.PowMult*=Injury_Max
						S << "Your right arm has been broken..."
				if(istype(src,/BodyPart/Left_Arm))
					if(S.Critical_Left_Arm == 0)
						S.Critical_Left_Arm = 1
						if(!S.IgnoresBrokenLimbs)
							S.StrMult*=Injury_Max
							S.PowMult*=Injury_Max
						S << "Your left arm has been broken..."
				Status="Broken"
				Health=50
				if(M) for(var/mob/A in view(S))
					A.ICOut("<font color = red>[M] has heavily damaged [S]'s [src]!")
					A.CombatOut("<font color = red>[M] has heavily damaged [S]'s [src]!")
				else  for(var/mob/A in view(S))
					A.ICOut("<font color = red>[S]'s [src] has been heavily damaged!")
					A.CombatOut("<font color = red>[S]'s [src] has been heavily damaged!")
				if(S.client)
					if(ismob(M)) S.saveToLog(" ([S.x], [S.y], [S.z]) | [key_name(M)]  has  heavily damaged [S].\n")
					else S.saveToLog("([S.x], [S.y], [S.z]) | [S]'s [src]  has been heavily damaged.\n")
			if(S.BodyHUD==1)
				icon_state = Status
				src.screen_loc = "1,1"
				S.client.screen.Remove(src)
				S.client.screen.Add(src)






	proc/InjuryHealed(mob/M,forced=0)
		if(Status!="Healthy")
			if(Status=="Missing"&&!forced) return
			//..()
			Health=50
			if(Status=="Broken")
				Status="Healthy"
				if(forced==0)M.Heal_Zenkai()
				M.ICOut("The injury to your [src] seems to have completely healed.")
				M.CombatOut("The injury to your [src] seems to have completely healed.")
			if(Status=="Maimed")
				Status="Broken"
				if(forced==0)M.Heal_Zenkai()
				M.ICOut("The injury to your [src] is starting to heal.")
				M.CombatOut("The injury to your [src] is starting to heal.")
			if(Status=="Missing"&&forced)
				Status="Broken"
				if(forced==0)M.Heal_Zenkai()
				M.ICOut("Your [src] has regrown, but it is still injured.")
				M.CombatOut("Your [src] has regrown, but it is still injured.")
		if(M.BodyHUD==1)
			icon_state = Status
			src.screen_loc = "1,1"
			M.client.screen.Remove(src)
			M.client.screen.Add(src)

mob
	var/LastHumiliate=-1
	var/LastMercy=-1

mob/verb/Injure()
	set category="Other"
	if(usr.RPMode) return
	for(var/mob/player/A in get_step(usr,usr.dir)) if(A.client)
		if(A.KOd) //if(!A.RPMode)
			if(A.KeepsBody == 0&&A.Dead)
				usr << "They don't have a body and can't be harmed that way."
				return
			if(A.Willpower>50)
				usr<<"Their Willpower is still too high."
				return
			/*if(usr.TotalXP<360)
				usr<<"You require atleast 360 lifetime XP in order to be able to injure or rob someone and 540 in order to be able to kill someone."
				return*/
			var/list/Choices=new
			for(var/BodyPart/P in A) Choices.Add(P)
			Choices.Add("Show Mercy","Humiliate")
			Choices.Add("Cancel")
			if(A.Willpower<=30)
				Choices.Add("Loot")
				if(SaveAge>=1&&A.Willpower<=0) Choices.Add("Kill")
				if(Z1ControllingRuler==A.name||A.FactionApproved(Z1FactionCode,4)) Choices+="Seize Control Point"
				else if(Z2ControllingRuler==A.name||A.FactionApproved(Z2FactionCode,4)) Choices+="Seize Control Point"
				else if(Z3ControllingRuler==A.name||A.FactionApproved(Z3FactionCode,4)) Choices+="Seize Control Point"
				else if(Z4ControllingRuler==A.name||A.FactionApproved(Z4FactionCode,4)) Choices+="Seize Control Point"
				else if(Z5ControllingRuler==A.name||A.FactionApproved(Z5FactionCode,4)) Choices+="Seize Control Point"
				else if(Z6ControllingRuler==A.name||A.FactionApproved(Z6FactionCode,4)) Choices+="Seize Control Point"
				else if(Z7ControllingRuler==A.name||A.FactionApproved(Z7FactionCode,4)) Choices+="Seize Control Point"
			else if(usr.Race=="Heran") Choices.Add("Mug")
			var/BodyPart/Result = input("Choose injury to apply") in Choices
			if(Result=="Cancel") return
			if(usr.Confirm("[Result]?")) if(A.KOd) if(A in range(1,usr))
				if(Result=="Kill") A.Death(usr)
				if(Result=="Seize Control Point") usr.TakeCP(A)
				if(Result=="Show Mercy") A.Mercy(usr)
				if(Result=="Humiliate") A.Humiliate(usr)
				else if(Result=="Loot")
					var/list/Lootables=list()
					for(var/obj/Resources/R in A) Lootables+=R
					for(var/obj/Mana/R in A) Lootables+=R
					for(var/obj/items/R in A) if(R.Stealable) Lootables+=R
					Lootables+="Cancel"
					var/obj/C=input("Loot what from [A]?") in Lootables
					if(C=="Cancel") return
					else
						view(usr)<<"[usr] steals [C] from [A]"
						if(istype(C,/obj/Resources)) for(var/obj/Resources/R in usr)
							var/obj/Resources/CC=A
							R.Value+=CC.Value
							CC.Value=0
						else if(istype(C,/obj/Mana)) for(var/obj/Mana/R in usr)
							var/obj/Mana/CC=A
							R.Value+=CC.Value
							CC.Value=0
						else if(istype(C,/obj/items))
							A.overlays-=C.icon
							if(C.suffix)
								if(C.suffix == "*Equipped*")
									A.Equip_Magic(C,"Remove")
									C.suffix = null
									if(istype(C,/obj/items/Bandages)) A.Bandages()
								if(A) A.Click(C)
							if(C) usr.contents+=C
						usr.HasRobbed++
						usr.AlignmentNumber--
						usr.AlignmentCalibrate()
				else if(Result=="Mug")
					var/list/Lootables=list()
					for(var/obj/Resources/R in A) Lootables+=R
					for(var/obj/Mana/R in A) Lootables+=R
					Lootables+="Cancel"
					var/obj/C=input("Loot what from [A]?") in Lootables
					if(C=="Cancel") return
					else
						view(usr)<<"[usr] steals [C] from [A]"
						if(istype(C,/obj/Resources)) for(var/obj/Resources/R in usr)
							var/obj/Resources/CC=A
							R.Value+=CC.Value
							CC.Value=0
						else if(istype(C,/obj/Mana)) for(var/obj/Mana/R in usr)
							var/obj/Mana/CC=A
							R.Value+=CC.Value
							CC.Value=0
						usr.HasRobbed++
						usr.AlignmentNumber--
						usr.AlignmentCalibrate()
				else if(Result)
					if(Result.Status!="Healthy")
						if(usr.Confirm("Remove their [Result]? (Currently [Result.Status])"))
							if(Result.type==/BodyPart/Head) if(!usr.Lethality) return
							view(10,usr) << "<font color = red>[usr] has taken off [A]'s [Result]!"
							Result.Status="Missing"
							A.Injure_Hurt(Result.MaxHealth,Result,usr)
							new/obj/Body_Part(usr.loc)
							if(A.AlignmentNumber>3) usr.AlignmentNumber-=3
							else usr.AlignmentNumber-=2
							usr.AlignmentCalibrate()
					else
						if(A.AlignmentNumber>3) usr.AlignmentNumber-=1.25
						else usr.AlignmentNumber-=0.75
						usr.AlignmentCalibrate()
						A.Injure_Hurt(Result.MaxHealth,Result,usr)
					usr.CausedInjury++
					if(usr.Infection&&!A.Infection) A.Infection=1
					if(A.RPMode) A.RPMode()
		//	del(Choices)

mob/verb/CheckBody()
	var/list/Parts=list()
	for(var/BodyPart/B in src) Parts.Add(B)
	usr<<"[Parts.Join(", ")]"

mob/proc
	Injure_Hurt(Percent,BodyPart/Limb,mob/M)
		if(!istype(src,/mob/player)) return
		if(NoBreak) return
		//if(!RPMode)return
		if(KeepsBody==0&&Dead) return
		if(Limb == null) Limb="Random"
		if(Limb=="Eyes")
			for(var/BodyPart/Eyes/B in src) Limb=B
		if(Limb=="Ears")
			for(var/BodyPart/Ears/B in src) Limb=B
		if(Limb=="Throat")
			for(var/BodyPart/Throat/B in src) Limb=B
		if(Limb=="Random")
			var/list/Parts=list()
			for(var/BodyPart/B in src) Parts.Add(B)
			Limb = pick(Parts)
		if(Limb=="Arms")
			var/list/Parts=list()
			for(var/BodyPart/Left_Arm/B in src) Parts.Add(B)
			for(var/BodyPart/Right_Arm/B in src) Parts.Add(B)
			Limb = pick(Parts)
		if(Limb=="Legs")
			var/list/Parts=list()
			for(var/BodyPart/Left_Leg/B in src) Parts.Add(B)
			for(var/BodyPart/Right_Leg/B in src) Parts.Add(B)
			Limb = pick(Parts)
		if(Limb=="Head")
			var/list/Parts=list()
			for(var/BodyPart/Head/B in src) Parts.Add(B)
			for(var/BodyPart/Eyes/B in src) Parts.Add(B)
			for(var/BodyPart/Ears/B in src) Parts.Add(B)
			for(var/BodyPart/Throat/B in src) Parts.Add(B)
			Limb = pick(Parts)
		if(Limb=="Body")
			var/list/Parts=list()
			for(var/BodyPart/Tail/B in src) Parts.Add(B)
			for(var/BodyPart/TailChangeling/B in src) Parts.Add(B)
			for(var/BodyPart/Chest/B in src) Parts.Add(B)
			for(var/BodyPart/Reproduction/B in src) Parts.Add(B)
			Limb = pick(Parts)
		if(Percent>0)
			Limb.Health=max(0,Limb.Health-Percent)
			Limb.LimbCheck(M,src)
			src.CombatOut("[M] injured your [Limb]! ([Percent] Damage)")


	BPDamage(mob/M,Damage,rate=1)
		if(!istype(src,/mob/player)) return
		if(ismob(M))
			if(M.Spar)
				rate*=0.5
				Damage*=0.5
			if(prob(35*rate))
				if(M.Calculated_Strikes&&M.Calculated_Target&&prob(66))src.Injure_Hurt(Damage,M.Calculated_Target,M)
				else src.Injure_Hurt(Damage,"Random",M)
		else src.Injure_Hurt(Damage,"Random",M)



	BodyHUD()
		if(client)
			for(var/BodyPart/L in src)
				L.icon_state = L.Status
				L.layer=EFFECTS_LAYER+100
				L.screen_loc = "1,1"
				client.screen.Remove(L)
				if(BodyHUD) client.screen.Add(L)

			var/obj/Chart=new
			Chart.icon='Chart.dmi'
			Chart.layer=EFFECTS_LAYER+99
			Chart.screen_loc = "1,1"
			Chart.mouse_opacity=0
			client.screen.Remove(Chart)
			if(BodyHUD) client.screen.Add(Chart)

	Injure_Heal(Percent,BodyPart/L,admin=0)
		if(src.RPMode&&admin==0) return
		if(!src.client) return
		if(L.Status=="Missing") if(admin==0) return
		if(L.Status=="Maimed") if(admin==0) Percent*=0.3//return
		if(L.Status=="Broken") if(admin==0) Percent*=0.5//return
		L.Health+=Percent
		if(L.Health>=L.MaxHealth) L.InjuryHealed(src,admin)
		if(L.Health>L.MaxHealth) L.Health=L.MaxHealth
		if(L.Health<0)L.Health=0
