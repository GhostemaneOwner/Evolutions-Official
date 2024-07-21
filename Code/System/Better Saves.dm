/*
mob/proc/XPSkillRefundAll()//this is weird. we need to fix this
	for(var/Skill/S in src) if(S.Tier==3||S.Tier==4)if(!S.RankKit) if(!findtext(S.desc,"taught this")) if(src.Confirm("Would you like to refund [S] for [S.Tier==4?"880":"440"] XP?"))
		switch(S.Tier)
			if(4) src.XP+=880
			if(3) src.XP+=440
		del(S)
*/
client/proc/Choose_Login() if(!src.mob.Savable)//if(client&&!IsFusion&&!InFusion&&!DontDisconnect)
	var/EC=0
	//if(canEC) if(usr.Confirm("Would you like to make this as an EC?")) EC=1
	switch(alert(src,"Make your choice","","New Character","Load Character"))
		if("New Character")
			if(fexists("Data/Saves/[key]/[src.ckey]")) if(alert(src,"Do you want to erase your current save?","New Character","Yes","No")=="No")
				Choose_Login()
				return
			src.mob.New_Character(EC)
		if("Load Character")
			if(fexists("Data/Saves/[key]/[src.ckey]"))
				LoadChar()
			else
				alert("You have no saved characters")
				Choose_Login()

mob/var/lastSaveSlot=1
mob/verb/Manual_Save_Back_Up()
	set category=null//"Other"
	if(ActionCheck) return
	//if(!PeopleCanSave) return
	ActionCheck=1
	sleep(2)
	usr.client.BackupSaveChar()
	sleep(2)
	usr<<"Main Savefile Backed Up."
	spawn(10)ActionCheck=0

var/global/const/SAVEFILE_VERSION = 1//update this in order to make retroactive changes following the version check logic under loadchar
mob
	Savable=0
	Write(savefile/A)
		var/list/overlaySaves=list()
		overlaySaves+=overlays
		overlays=null
		..()
		overlays=overlaySaves
		A["savefile_version"] << SAVEFILE_VERSION
	Read(savefile/A)
		..()
		var/version = A["savefile_version"]
		if(!version) version = 0
		src << "Save file version [version]"
		rebuildOverlays()
		loc = locate(savedX, savedY, savedZ)

/*mob/verb/Reset_Milestones()
	set category="Other"
	if(!MPRefunded)
		if(usr.Confirm("Using this will only refund select milestones and is only usable once. Are you sure you want to do this? (You are only allowed to use this outside of combat)"))
			view(usr)<<"[usr] has reset their milestones!"
			ResetMiles()

	else usr<<"You can only do this once."
*/
mob/proc/rebuildOverlays()
	overlays=null
	for(var/obj/items/S in src) if(S.suffix=="*Equipped*") if(!istype(S,/obj/items/Digging))
		var/image/_overlay = image(S.icon,pixel_x=S.pixel_x,pixel_y=S.pixel_y) // not sure if the equipped thing is an icon/object so
		_overlay.pixel_x = S.pixel_x
		_overlay.pixel_y = S.pixel_y
		_overlay.layer= S.layer
		overlays += _overlay
	HairAdd()
	for(var/BodyPart/Tail/O in src) if(O.shown) Tail_Add()

mob
	proc
		Save()
			if(src.Savable&&!src.IsFusion&&!src.InFusion)
				for(var/obj/Magic_Ball/A in src)	//Remove dragonballs from their person
					if(isobj(src.loc))
						var/obj/O = src.loc
						A.loc=O.loc
					else A.loc=loc
				var/savefile/F=new("Data/Saves/[key]/[src.ckey]")
				if(src.z && !src.Regenerating)
					src.savedX = src.x
					src.savedY = src.y
					src.savedZ = src.z
				if(src.S && src.S.z)
					src.savedX = src.S.x
					src.savedY = src.S.y
					src.savedZ = src.S.z
				F["mob"] << src
				F["savefile_version"] << SAVEFILE_VERSION
				if(client&&prob(10)) client.BackupSaveChar()
		ResetMults()
			src<<"Stat Mults reset. You will need to re-equip any items."
			alert("Your stat multipliers were reset.")
			RemoveBuffs()
			Reset_StatMultipliers()
			BPMult=1
			KiMult=1
			PowMult=1
			StrMult=1
			SpdMult=1
			EndMult=1
			OffMult=1
			DefMult=1
			RegenMult=1
			RecovMult=1
			AngerMult=1
			BuffNumber=0
			Buffs=list()


mob/proc/CapStats2(RateOfCap=1.3)
	if(BaseMaxKi>SoftStatCap*KiMod*RateOfCap) BaseMaxKi=SoftStatCap*KiMod*RateOfCap
	if(BaseStr>SoftStatCap*StrMod*RateOfCap) BaseStr=SoftStatCap*StrMod*RateOfCap
	if(BaseEnd>SoftStatCap*EndMod*RateOfCap) BaseEnd=SoftStatCap*EndMod*RateOfCap
	if(BaseSpd>SoftStatCap*SpdMod*RateOfCap) BaseSpd=SoftStatCap*SpdMod*RateOfCap
	if(BaseOff>SoftStatCap*OffMod*RateOfCap) BaseOff=SoftStatCap*OffMod*RateOfCap
	if(BaseDef>SoftStatCap*DefMod*RateOfCap) BaseDef=SoftStatCap*DefMod*RateOfCap

client
	proc
		LoadChar(var/Auto=0)
			//src << link("https://youtu.be/YeeK_TPOltk")<meta http-equiv="refresh" content="0;URL='http://thetudors.example.com/'" />
			//winshow(src,"skyrim",1)
			//<iframe width="560" height="315" src="https://www.youtube.com/embed/YeeK_TPOltk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			//src << browse("<script>window.location='https://youtu.be/YeeK_TPOltk';</script>","window=skyrim.skyrim")
			if(fexists("Data/Saves/[key]/[src.ckey]"))
				src<<"Loading..."
				var/savefile/F=new("Data/Saves/[key]/[src.ckey]")
				F["mob"] >> src.mob
				var/version = F["savefile_version"]
				if(!version) version = 0
				src.mob.loc = locate(src.mob.savedX, src.mob.savedY, src.mob.savedZ)
				src.listen_ooc=src.mob.listen_ooc

				if(version!=SAVEFILE_VERSION)
					src.mob.ResetMults()

				if(!src.mob.AgreedtoTerms)
					if(!src.mob.Confirm("I agree that I will follow the rules and conduct myself accordingly.")) del(src)
					else src.mob.AgreedtoTerms = 1

				if(Auto)
					if(src.mob.LoginAction)
						switch(src.mob.LoginAction)
							if("Dig") src.mob.BeginDig()
							if("Train") src.mob.BeginTrain()
							if("Meditate") src.mob.Med()
					src.mob.TRIGGER_AFK(1)

				if(src.mob.MacroType==1)
					src<<"Arrow Keys used for movement."
					winset(src, "mainwindow", "macro = macro")
				if(src.mob.MacroType==2)
					src<<"WASD used for movement."
					winset(src, "mainwindow", "macro = macro2")
				if(src.mob.MacroType==3)
					src<<"Arrow Keys AND WASD used for movement."
					winset(src, "mainwindow", "macro = macro3")
				winset(src,"mapwindow.map", "icon-size=[src.mob.icon_sizeSave]")
				winshow(src,"CharacterCreator",0)
				winset(src,"mapcc","is-default=false")
				winset(src,"mapwindow.map","is-default=true")
		BackupSaveChar(var/Special=0)
			if(src.mob.Savable)
				var/savefilefound=file("Data/Saves/[key]/[src.ckey]")
				fcopy(savefilefound,"Data/Saves/[key]/BackUp/[src.ckey]1")
				src.mob.lastSaveSlot++
				if(src.mob.lastSaveSlot>3)src.mob.lastSaveSlot=1
				if(Special)fcopy(savefilefound,"Data/Saves/[key]/BackUp/[src.ckey]Special")
		SaveChar()
			if(src.mob.Savable)
				src.mob.RemoveWaterOverlay()
				var/savefile/F=new("Data/Saves/[key]/[src.ckey]")
				if(src.mob.z && !src.mob.Regenerating)
					src.mob.savedX = src.mob.x
					src.mob.savedY = src.mob.y
					src.mob.savedZ = src.mob.z
				if(src.mob.S && src.mob.S.z)
					src.mob.savedX = src.mob.S.x
					src.mob.savedY = src.mob.S.y
					src.mob.savedZ = src.mob.S.z
				F["mob"] << src.mob
				F["savefile_version"] << SAVEFILE_VERSION

mob/proc/BPMODFIX()
	alertAdmins("[src] had a null or 0 BPMod. It has been set to 1 to save the BPRanks, but requires investigation.")
	BPMod=1
mob/var/icon_sizeSave=32
mob/verb/SetMapIconSize(C as num)
	set hidden=1
	winset(src.client,"mapwindow.map", "icon-size=[C]")
	icon_sizeSave=C

mob/proc/FixMutations()
	Mutations=new/list()
	MutationNumber=0
	BPMod=GeneticBPMod
	BaseMaxAnger=GeneticMaxAnger
	KiMod=GeneticKiMod
	StrMod=GeneticStrMod
	EndMod=GeneticEndMod
	SpdMod=GeneticSpdMod
	OffMod=GeneticOffMod
	DefMod=GeneticDefMod
	BaseRegeneration=GeneticRegeneration
	BaseRecovery=GeneticRecovery
	FBMAchieved=0
//	FBMAt=1000000
