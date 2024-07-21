




mob/proc/EventKillReward(mob/M,mob/C)
	/*M.AllOut("You were rewarded XP and temporary BP for killing [C]!")
	logAndAlertAdmins("[key_name(M)] has received a EC Kill reward for killing [key_name(C)].",1)
	M.XP+=50
	M.RacialPowerAdd+=M.Base*(DayScaler-1)*/


mob/var/EventCharacter=0
mob/proc/MakeEC()
	PassiveSkillsIncrease(100*Year,100*Year,100*Year,100*Year)
	if(!locate(/obj/RankChatECPool) in src) src.contents+=new /obj/RankChatECPool
	if(!locate(/obj/Set_RPPower) in src) src.contents+=new /obj/Set_RPPower
	for(var/X in BasicSkills) if(!locate(X) in src) src.contents+=new X
	var/Template=input(src,"Choose which skill template you would like.") in list("Melee", "Weapon", "Ki")
	switch(Template)
		if("Weapon") for(var/X in WeaponSkills) if(!locate(X) in src)
			var/Skill/S = new X
			S.RankKit=1
			contents+=S
			src<<"Added [X] to skill set"
		if("Melee") for(var/X in MeleeSkills) if(!locate(X) in src)
			var/Skill/S = new X
			S.RankKit=1
			contents+=S
			src<<"Added [X] to skill set"
		if("Ki") for(var/X in KiSkills) if(!locate(X) in src)
			var/Skill/S = new X
			S.RankKit=1
			contents+=S
			src<<"Added [X] to skill set"

	// var/Skill/LB = new /Skill/Buff/Limit_Breaker
	// LB.RankKit=1
	// contents+=LB
	// src<<"Added [LB] to skill set"

	var/Skill/MA = new /Skill/MartialArt
	MA.RankKit=1
	contents+=MA
	src<<"Added [MA] to skill set"


	for(var/obj/Resources/Res in src) Res.Value+=250000*Year
	for(var/obj/Mana/Man in src) Man.Value+=250000*Year

	var/list/LChoices=list()
	for(var/X in LimitedSkills) if(!locate(X) in src) LChoices+=X

	var/SC=input(src,"Choose 3 more of these skills") in LChoices
	LChoices-=SC
	var/Skill/S2 = new SC
	S2.RankKit=1
	contents+=S2
	src<<"Added [S2] to skill set"

	var/SEC=input(src,"Choose 2 more of these skills") in LChoices
	LChoices-=SEC
	var/Skill/S3 = new SEC
	S3.RankKit=1
	contents+=S3
	src<<"Added [S3] to skill set"

	var/SCC=input(src,"Choose 1 more of these skills") in LChoices
	LChoices-=SCC
	var/Skill/S4 = new SCC
	S4.RankKit=1
	contents+=S4
	src<<"Added [S4] to skill set"

	var/list/L=list()
	for(var/Skill/SSS in src)
		SSS.Experience=100
		if(SSS.RankKit) L+=SSS
	logAndAlertAdmins("[key_name(src)] has received [L.Join(", ")] as their EC kit.",1)
	VillainTrain=1
	HasBuildingPermit=1
	XP=Year*180
	EventCharacter=Year
	MaxHealth=150
	MaxWillpower=150
	Willpower=MaxWillpower
	Health=MaxHealth
	Zanzoken=1000
	FlySkill=5000
	MultikeyApproved=2
	//Mumit's attempt to fix below
	KiManipulation=(125+(25*Year))
	UnarmedSkill=(125+(25*Year))
	Athleticism=(125+(25*Year))
	SwordSkill=(125+(25*Year))
	GravMastered=50

	if(Year>=11)
		GravMastered=((TechCap-43)*6)
	//Mumit's attempt to fix ended

	AlignmentNumber=input(src.client,"Alignment? -10 = Evil 0 = Neutral 10 = Good") as num
	var/xx=input(src.client,"X Location? Current is [x]") as num
	var/yy=input(src.client,"Y Location? Current is [y]") as num
	var/zz=input(src.client,"Z Location? Current is [z] (1 = Earth, 2 = Namek, 3 = Vegeta, 4 = Icer, 5 = Arconia 6 = Dark Planet 7 = Space Station)") as num
	switch(input(src.client,"Are you sure? (Press No to stay on this planet)") in list ("Yes", "No",))
		if("Yes")
			unSummonX = x
			unSummonY = y
			unSummonZ = z
			loc=locate(xx,yy,zz)

	alert(src,"You are an event character. You are expected to contribute to conflict based RP and are expected to be killed off or defeated within 3-5 days of making. You have the ability to reward players that RP with you and defeat you and are encouraged to do so using the things available in your kit.")


/*
	//Mumit code
mob/proc/SetEC_RP_Power()
	var/NewECRPP=input(usr,"What RPPower would you like to set yourself to?") as num
	if(NewECRPP<1) NewECRPP=1
	if(NewECRPP>2) NewECRPP=2
	usr.RPPower=NewECRPP
	usr.BuffOut("BP multiplied by [RPPower].")

mob/verb/Set_EC_Power()
	set src = usr.contents
	set category="Other"
	desc="This will let you multiply your battle power by the value you put in."
	SetEC_RP_Power()
*/


obj/Set_RPPower
	desc="This will let you multiply your battle power by the value you put in."
	verb/SetEC_RP_Power()
		set category="Other"
		var/NewECRPP=input(usr,"What RPPower would you like to set yourself to? Note: Suggestion is 1.25 - 1.4 depending on enemies") as num
		if(NewECRPP<1) NewECRPP=1
		if(NewECRPP>2) NewECRPP=2
		usr.RPPower=NewECRPP
		usr.BuffOut("BP has been multiplied by [usr.RPPower].")
		alertAdmins("[key_name(usr)] altered their RPPower to [usr.RPPower].")

		//Mumit code
		