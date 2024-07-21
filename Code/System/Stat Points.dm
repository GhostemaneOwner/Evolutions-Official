
mob/var/tmp/PointsSpent=0
mob/proc/Set_Minimum_Stats()
	Minimum_Stats=list("Eff"=KiMod,"Str"=StrMod,"End"=EndMod,"Off"=OffMod,"Def"=DefMod,"Spd"=SpdMod,"Reg"=BaseRegeneration,"Rec"=BaseRecovery)
mob/proc/Skill_Points(type as text,skill as text)
	set name=".Skill_Points"
	set hidden=1
	if(Offspring)return
	if(ActionCheck)return
	if(Race=="Undefined")
		usr<<"You must choose Race first."
		return
	if(!ImDoingStats&&!Redoing_Stats&&!InCreation) return
	if(!(skill in list("Strength","Endurance","Speed","Force","Offense","Defense","Regeneration","Recovery"))) return
	//if(!(winget(usr,"CharacterCreator","is-visible")=="true")) return
	if(!(type in list("-","+"))) return
	var/Increase=1
	if(type=="-")
		if(PointsSpent+Points>Max_Points) return
		if(Points>=Max_Points) return //You cant subtract any more points if points are full
		Increase=-1
	if(type=="+")
		Increase=1
		if(Points<=0) return //You cant add any more points if you had none left
	if(usr.HasCreated!=0) if(!Redoing_Stats) return
	//Redoing_Stats=1
	var/max = 6
	ActionCheck=1
	spawn(3) ActionCheck=0
	if(usr.Race=="Alien") max = 25
	switch(skill)
		if("Strength")
			if(type=="-")
				if(StrMod<=Minimum_Stats["Str"])
					return
				if(usr.Total_Stats_Strength > 0&&StrMod>Minimum_Stats["Str"])
					usr.Total_Stats_Strength -= 1
					PointsSpent--
					Raise_Strength(Increase)
			if(type=="+")
				if(usr.Total_Stats_Strength == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					Raise_Strength(Increase)
					usr.Total_Stats_Strength += 1
					PointsSpent++
			if(usr) if(client)
				winset(usr.client,"[skill]","text=[StrMod]")
		if("Endurance")
			if(type=="-")
				if(EndMod<=Minimum_Stats["End"])
					return
				if(usr.Total_Stats_Endurance > 0&&EndMod>Minimum_Stats["End"])
					usr.Total_Stats_Endurance -= 1
					PointsSpent--
					Raise_Durability(Increase)
			if(type=="+")
				if(usr.Total_Stats_Endurance == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					Raise_Durability(Increase)
					usr.Total_Stats_Endurance += 1
					PointsSpent++
			if(usr) if(client)
				winset(usr.client,"[skill]","text=[EndMod]")
		if("Speed")
			if(type=="-")
				if(SpdMod<=Minimum_Stats["Spd"])
					return
				if(usr.Total_Stats_Speed > 0&&SpdMod>Minimum_Stats["Spd"])
					usr.Total_Stats_Speed -= 1
					PointsSpent--
					Raise_Speed(Increase)
			if(type=="+")
				if(usr.Total_Stats_Speed == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					Raise_Speed(Increase)
					usr.Total_Stats_Speed += 1
					PointsSpent++
			if(usr) if(client)
				winset(usr.client,"[skill]","text=[SpdMod]")
/*		if("Force")
			if(type=="-")
				if(PowMod<=Minimum_Stats["Pow"])
					return
				if(usr.Total_Stats_Force > 0&&PowMod>Minimum_Stats["Pow"])
					usr.Total_Stats_Force -= 1
					PointsSpent--
					Raise_Force(Increase)
			if(type=="+")
				if(usr.Total_Stats_Force == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					Raise_Force(Increase)
					usr.Total_Stats_Force += 1
					PointsSpent++
			if(usr) if(client)
				winset(usr.client,"[skill]","text=[PowMod]")
*/
		if("Offense")
			if(type=="-")
				if(OffMod<=Minimum_Stats["Off"])
					return
				if(usr.Total_Stats_Off > 0&&OffMod>Minimum_Stats["Off"])
					usr.Total_Stats_Off -= 1
					PointsSpent--
					Raise_Offense(Increase)
			if(type=="+")
				if(usr.Total_Stats_Off == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					Raise_Offense(Increase)
					usr.Total_Stats_Off += 1
					PointsSpent++
			if(usr) if(client)
				winset(usr.client,"[skill]","text=[OffMod]")
		if("Defense")
			if(type=="-")
				if(DefMod<=Minimum_Stats["Def"])
					return
				if(usr.Total_Stats_Def > 0&&DefMod>Minimum_Stats["Def"])
					usr.Total_Stats_Def -= 1
					PointsSpent--
					Raise_Defense(Increase)
			if(type=="+")
				if(usr.Total_Stats_Def == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					Raise_Defense(Increase)
					usr.Total_Stats_Def += 1
					PointsSpent++
			if(usr) if(client)
				winset(usr.client,"[skill]","text=[DefMod]")
		if("Recovery")
			if(type=="-")
				if(BaseRecovery<=Minimum_Stats["Rec"])
					return
				if(usr.Total_Stats_Recov > 0&&BaseRecovery>Minimum_Stats["Rec"])
					usr.Total_Stats_Recov -= 1
					usr.Total_Stats_Energy -= 1
					Raise_Recovery(Increase*0.7)
					Raise_Energy(Increase)
					PointsSpent--
			if(type=="+")
				if(usr.Total_Stats_Recov == max)
					usr << "Unable to put more than [max] points into any mod."
					return
				else
					Raise_Recovery(Increase*0.7)
					Raise_Energy(Increase)
					usr.Total_Stats_Recov += 1
					usr.Total_Stats_Energy += 1
					PointsSpent++
			if(usr) if(client)
				winset(usr.client,"[skill]","text=[BaseRecovery]")
				winset(usr.client,"Efficiency","text=[KiMod]")
		else
			alert("You really ought to try not to abuse character generation!")
			return
	Points-=Increase
	if(usr) if(client) winset(usr.client,"PointsRemaining","text=[Points]")
	//BodySizeCheck()
	return
mob/var/tmp/ImDoingStats=0
mob/proc/Stat_Point_Window_Refresh()
	if(!ImDoingStats&&!Redoing_Stats) return
	if(HasCreated) if(!Redoing_Stats) return
	winset(src.client,"PointsRemaining","text=[Points]")
	if(Offspring) return
	if(src) if(client)
		winset(src.client,"RaceBP","text=\"[BPMod]x\"")
		winset(src.client,"AngerLabel","text=\"[BaseMaxAnger/100]x\"")
		winset(src.client,"BodySizeLabel","text=\"[Size]\"")
		winset(src.client,"Efficiency","text=[KiMod]")
		winset(src.client,"Strength","text=[StrMod]")
		winset(src.client,"Endurance","text=[EndMod]")
		winset(src.client,"Speed","text=[SpdMod]")
		winset(src.client,"Offense","text=[OffMod]")
		winset(src.client,"Defense","text=[DefMod]")
		winset(src.client,"Regeneration","text=[BaseRegeneration]")
		winset(src.client,"Recovery","text=[BaseRecovery]")
		winset(src.client,"namec","text=\"[name]\"")
		winset(src.client,"genderc","text=\"[gender]\"")
		winset(src.client,"agec","text=\"Age [Age]\"")
		winset(src.client,"BodySizeLabel","text=\"[Size]\"")




mob/proc/Raise_Energy(Amount=1)
	if(Race == "Alien")KiMod+=(Minimum_Stats["Eff"]*0.1)*Amount*(1-(Total_Stats_Energy*0.01))
	else KiMod+=(Minimum_Stats["Eff"]*0.1)*Amount*(1-(Total_Stats_Energy*0.05))
mob/proc/Raise_Speed(Amount=1)
	if(Race == "Alien")SpdMod+=(Minimum_Stats["Spd"]*0.1)*Amount*(1-(Total_Stats_Speed*0.01))
	else SpdMod+=(Minimum_Stats["Spd"]*0.1)*Amount*(1-(Total_Stats_Speed*0.05))
mob/proc/Raise_Strength(Amount=1)
	if(Race == "Alien")StrMod+=(Minimum_Stats["Str"]*0.1)*Amount*(1-(Total_Stats_Strength*0.01))
	else StrMod+=(Minimum_Stats["Str"]*0.1)*Amount*(1-(Total_Stats_Strength*0.05))
mob/proc/Raise_Durability(Amount=1)
	if(Race == "Alien")EndMod+=(Minimum_Stats["End"]*0.1)*Amount*(1-(Total_Stats_Endurance*0.01))
	else EndMod+=(Minimum_Stats["End"]*0.1)*Amount*(1-(Total_Stats_Endurance*0.05))
mob/proc/Raise_Offense(Amount=1)
	if(Race == "Alien")OffMod+=(Minimum_Stats["Off"]*0.1)*Amount*(1-(Total_Stats_Off*0.01))
	else OffMod+=(Minimum_Stats["Off"]*0.1)*Amount*(1-(Total_Stats_Off*0.05))
mob/proc/Raise_Defense(Amount=1)
	if(Race == "Alien")DefMod+=(Minimum_Stats["Def"]*0.1)*Amount*(1-(Total_Stats_Def*0.01))
	else DefMod+=(Minimum_Stats["Def"]*0.1)*Amount*(1-(Total_Stats_Def*0.05))
mob/proc/Raise_Recovery(Amount=1)
	if(Race == "Alien")BaseRecovery+=(Minimum_Stats["Rec"]*0.1)*Amount*(1-(Total_Stats_Recov*0.01))
	else BaseRecovery+=(Minimum_Stats["Rec"]*0.1)*Amount*(1-(Total_Stats_Recov*0.05))
mob/proc/Racial_Stats()
	if(Offspring) return
	if(src)
		Points = 15
		Max_Points = 15
		if(Race == "Alien")
			Points=65
			Max_Points = 65
		if(Offspring) Points = 0
		Set_Minimum_Stats()
		Total_Stats_Energy=0
		Total_Stats_Strength=0
		Total_Stats_Endurance=0
		Total_Stats_Speed=0
		Total_Stats_Off=0
		Total_Stats_Def=0
		Total_Stats_Regen=0
		Total_Stats_Recov=0
		ImDoingStats=1
		Stat_Point_Window_Refresh()



obj/Redo_Stats
	verb/Redo_Stats()
		set category="Other"
		if(usr.Redoing_Stats==1) return
		usr.Redoing_Stats=1
		if(usr.Confirm("Redo stats?"))
			if(usr.Offspring)
				usr<<"Offspring may not use this."
				del(src)
				return
			if(usr.Confirm("Really Redo Stats? (Resets mutations too)"))
				usr.Redoing_Stats=1
				usr.SelectedAge=1
				spawn(1) del src
				logAndAlertAdmins("[key_name(usr)] started to redo stats",1)
				var/BPO=usr.Base
				//usr.Historys()
				usr.Redo_Stats()
				usr.verbs += /mob/proc/donec
				usr.verbs += /mob/proc/bodyc
				usr.verbs += /mob/proc/Skill_Points
				winshow(usr.client,"CharacterCreator",1)
				usr.mind.store_memory("<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key])<hr> [key_name(usr)] started to redo stats<br><hr>")
				usr<<"This is a one time use item... It will self destruct now."
				usr<<"[src]: Goodbye!"
				usr.Base=BPO
				usr.CheckRedoneStats()
				del src
			else usr.Redoing_Stats=0
		else usr.Redoing_Stats=0



mob/proc/CheckRedoneStats()
	if(BaseStr>SoftStatCap*1.2)BaseStr=SoftStatCap*1.2
	if(BaseEnd>SoftStatCap*1.2)BaseEnd=SoftStatCap*1.2
	if(BaseSpd>SoftStatCap*1.2)BaseSpd=SoftStatCap*1.2
	if(BaseOff>SoftStatCap*1.2)BaseOff=SoftStatCap*1.2
	if(BaseDef>SoftStatCap*1.2)BaseDef=SoftStatCap*1.2


mob/proc/RevertAll()
	if(Race=="Saiyan") if(GodKiActive) SSG()
	Shadow_Overlays()
	var/Reverts=5
	while(Reverts)
		Reverts-=1
		Cancel_Transformation()
	Cancel_Transformation()
	BurningShotBuffRemove()
	Cancel_Olympus()
	Oozaru_Revert()
	Werewolf_Revert()
	Flight_Land()
	Cancel_PowerControl()
	for(var/Skill/Buff/S in src) if(S.Using) S.debuff(src)
	overlays-= ExtraOvers
	ExtraOvers=null
	OverlayCleanse()
	Smashing=0
	if(ThunderingBlows)
		ThunderingBlows=0
		SpdMult/=0.9
	if(BleedingEdge)
		BleedingEdge=0
		SpdMult/=0.9
	Shielding = 0
	ismystic=0
	ismajin=0
	Precognition=HasPrecognition
	if(Race=="Kanassan") Precognition=1
	HasThornsOn=0
	Cancel_Olympus()
	IgnoresBrokenLimbs=0
	DisableRegen=0
	KiDoesNotAffectBP=0


mob/proc/OverlayCleanse()
	overlays.Remove(/Icon_Obj/Cloak/UIAura,/Icon_Obj/Cloak/LSSJCloak,/Icon_Obj/Cloak/LSSJGCloak,/Icon_Obj/Cloak/BlackCloak,/Icon_Obj/Cloak/WhiteCloak,/Icon_Obj/Cloak/PurpleCloak,/Icon_Obj/Cloak/BlueCloak,/Icon_Obj/Cloak/PinkCloak,/Icon_Obj/Cloak/DarkAura)
	animate(src, transform = null, time = 3)


mob/proc/RevertDrains()
	var/Reverts=5
	Shadow_Overlays()
	while(Reverts)
		Reverts-=1
		Cancel_Transformation()
	Cancel_Transformation()
	Flight_Land()
	Cancel_PowerControl()
	Werewolf_Revert()
	Cancel_Olympus()
	for(var/Skill/Buff/S in src) if(S.Using) S.use(src)
	overlays-= ExtraOvers
	ExtraOvers=null

mob/proc/RemoveBuffs()
	ArmorRemove()
	SwordRemove()
	HammerRemove()
	HelmetRemove()
	GlovesRemove()
	MaskRemove()
	MaskOn=0
	ArmorOn=0
	SwordOn=0
	HammerOn=0
	GlovesOn=0
	HelmetOn=0
	//HasBelt=0
	for(var/obj/items/Power_Armor/S in src) Eject(S)
	for(var/obj/items/I in src) if(I.suffix)if(I.magical) //if(!istype(I,/obj/items/Scanner/AndroidScanner))
		I.suffix=null
		overlays-=I
		Equip_Magic(I,"Remove")
		var/image/_overlay = image(I.icon)
		_overlay.pixel_x = I.pixel_x
		_overlay.pixel_y = I.pixel_y
		overlays-=_overlay
	RevertAll()




mob/proc/Redo_Stats()
	Redoing_Stats=1
	var/Asex=Asexual
	RemoveBuffs()
	if(Race=="Android")
		if(Upgrade_Components>0)
			while(Upgrade_Components>0)
				var/obj/items/Android_Upgrade/AU=new
				contents+=AU
				Upgrade_Components--
	Total_Stats_Energy=0
	Total_Stats_Strength=0
	Total_Stats_Endurance=0
	Total_Stats_Speed=0
	Total_Stats_Off=0
	Total_Stats_Def=0
	Total_Stats_Regen=0
	Total_Stats_Recov=0
	PointsSpent=0
	AssignRaceStats()
	Set_Minimum_Stats()
	BodyStatGive()
	RedoBodySize()
	KiMod=Minimum_Stats["Eff"]
	SpdMod=Minimum_Stats["Spd"]
	StrMod=Minimum_Stats["Str"]
	EndMod=Minimum_Stats["End"]
	OffMod=Minimum_Stats["Off"]
	DefMod=Minimum_Stats["Def"]
	BaseRegeneration=Minimum_Stats["Reg"]
	BaseRecovery=Minimum_Stats["Rec"]
	Racial_Stats()
	Asexual=Asex
	Mutations=new/list()
	MutationNumber=0

