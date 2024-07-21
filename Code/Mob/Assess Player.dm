













/*obj/Assess/verb/Assess(mob/M in world)
	set src=usr.contents
	set category="Other"
	usr.Get_Assess(M)


	<tr><td>Flying:</td><td>[round(FlySkill)] ([FlyMod])</td></tr>
	<tr><td>Zanzoken:</td><td>[round(Zanzoken)] ([ZanzoMod])</td></tr>
	<tr><td>Unarmed:</td><td>[round(UnarmedSkill)]</td></tr>
	<tr><td>Weapon:</td><td>[round(SwordSkill)]</td></tr>
	<tr><td>Ki Manipulation:</td><td>[round(KiManipulation)]</td></tr>
	<tr><td>Evasion:</td><td>[round(Athleticism)]</td></tr>
*/


mob/proc/Get_PlayerAssess()

	var/Gravity_Multiplier=min(2.5,1+((GravMastered/25)/25))
	var/A={"<html><style type="text/css"><!--body {color:#449999;background-color:black;font-size:18;}table {font-size:18;}--></style><body>
	[src]<br>
	[Size] [gender] [Race]<br>
	Current Anger: [Anger]% (Willpower: [Willpower])<br>
	<table cellspacing="6%" cellpadding="1%">

	<tr><td>Buffs:</td><td>Buffs [BuffNumber] ([Buffs.Join(", ")])</td></tr><br>
	<tr><td>Age:</td><td>[Age] ([Real_Age] True Age) (Save Age [SaveAge])</td></tr>
	<tr><td>Body:</td><td>[Body*100]% ([Decline] Decline)</td></tr>
	<br>
	<tr><td>Battle Power:</td><td>[ScouterOn?"[Commas(BP)]":"???"] [BPMult]x Mult [Base/BPMod>TrueBPCap*0.99? "(Overcapped)":Base/BPMod>TrueBPCap*0.9? "(Capped)":""] [FBMAchieved ? "(FBM) " : ""][PotentialUnlocked?" Potential Unlocked":""]</td></tr>
	<br>
	<tr><td>+Energy:</td><td>[round(MaxKi)] ([KiMult] Mult) [StatCapCheck(BaseMaxKi/KiMod)<0.65?"(Overcapped)":StatCapCheck(BaseMaxKi/KiMod)<1? "(Capped)":""]</td></tr>
	<tr><td>[pfocus=="Might"?"+":pfocus=="Balanced"?"+":""]Strength:</td><td>[round(Str)] ([StrMult] Mult) [StatCapCheck(BaseStr/StrMod)<0.65?"(Overcapped)":StatCapCheck(BaseStr/StrMod)<1? "(Capped)":""]</td></tr>
	<tr><td>[pfocus=="Might"?"+":pfocus=="Balanced"?"+":""]Force:</td><td>[round(Pow)] ([PowMult] Mult) [StatCapCheck(BaseStr/StrMod)<0.65?"(Overcapped)":StatCapCheck(BaseStr/StrMod)<1? "(Capped)":""]</td></tr>
	<tr><td>[pfocus=="Endurance"?"+":pfocus=="Balanced"?"+":""]Endurance:</td><td>[round(End)] ([EndMult] Mult) [StatCapCheck(BaseEnd/EndMod)<0.65?"(Overcapped)":StatCapCheck(BaseEnd/EndMod)<1? "(Capped)":""]</td></tr>
	<tr><td>[mfocus=="Speed Only"?"+":mfocus=="Balanced"?"+":""]Speed:</td><td>[round(Spd)] ([SpdMult] Mult) [StatCapCheck(BaseSpd/SpdMod)<0.65?"(Overcapped)":StatCapCheck(BaseSpd/SpdMod)<1? "(Capped)":""]</td></tr>
	<tr><td>[mfocus=="Offense"?"+":mfocus=="Balanced"?"+":""]Offense:</td><td>[round(Off)] ([OffMult] Mult) [StatCapCheck(BaseOff/OffMod)<0.65?"(Overcapped)":StatCapCheck(BaseOff/OffMod)<1? "(Capped)":""]</td></tr>
	<tr><td>[mfocus=="Defense"?"+":mfocus=="Balanced"?"+":""]Defense:</td><td>[round(Def)] ([DefMult] Mult) [StatCapCheck(BaseDef/DefMod)<0.65?"(Overcapped)":StatCapCheck(BaseDef/DefMod)<1? "(Capped)":""]</td></tr>
<br>
	<tr><td>[ifocus=="Intelligence"?"+":""]Intelligence:</td><td>[Int_Level] ([Int_Mod]) ([Commas(Int_XP)] / [Commas(40*(Int_Next/Int_Mod))]) [Int_Level>TechCap ?"(Overcapped)":Int_Level==TechCap ? "(Capped)":""]</td></tr>
	<tr><td>[ifocus=="Magical Skill"?"+":""]Magic Skill:</td><td>[Magic_Level] ([Magic_Potential]) ([Commas(Magic_XP)] / [Commas(40*(Magic_Next/Magic_Potential))]) [Magic_Level>TechCap ?"(Overcapped)":Magic_Level==TechCap ? "(Capped)":""]</td></tr>
<br><br>
	<tr><td>Regeneration:</td><td>[Regeneration] ([RegenMult] x [BaseRegeneration] Base)</td></tr>
	<tr><td>Health per tick:</td><td>[HPTick]</td></tr>
	<tr><td>Recovery:</td><td>[Recovery] ([RecovMult] x [BaseRecovery] Base)</td></tr>
	<tr><td>Energy per tick:</td><td>[KiTick]</td></tr>
	<tr><td>Gravity:</td><td>[round(GravMastered)] ([Gravity_Multiplier] x BP Boost)</td></tr>
	<tr><td>Max Anger:</td><td>[MaxAnger]% ([AngerMult] x)</td></tr>
	<tr><td>Energy Signature:</td><td>[Signature]</td></tr>
	</td></tr></table><br><table>"}
	src=usr
	winshow(src.client,"SkillSheet",1)
	sleep()
	winset(src.client,"GridSS","cells=0x0")
	usr<<output(A,"SkillSheet.characterinfo")
	var/Row=0
	Row++
	src << output("Skill", "GridSS:1,[Row]")
	src << output("Mastery", "GridSS:2,[Row]")
	src << output("Description", "GridSS:3,[Row]")
	for(var/Skill/MartialArt/S in src)
		Row++
		src << output(S, "GridSS:1,[Row]")
		src << output("[S.MasteryLevel]", "GridSS:2,[Row]")
		src << output("[S.desc] Core: [S.StanceCore] ([S.SpdMult]x Speed, [S.OffMult]x Offense, [S.DefMult]x Defense)", "GridSS:3,[Row]")
	for(var/Skill/S in src) if(!istype(S,/Skill/MartialArt))if(!istype(S,/Skill/Buff)) if(!istype(S,/Skill/Misc/Fly))if(!istype(S,/Skill/Zanzoken))if(!istype(S,/Skill/Buff/Kaioken))if(!istype(S,/Skill/Buff/SSj))if(!istype(S,/Skill/Buff/AlienTransformation))if(!istype(S,/Skill/Buff/ChangelingTransformation))
		Row++
		src << output(S, "GridSS:1,[Row]")
		src << output("[S.Experience] % (Teachable Day: [S.TeachDay])", "GridSS:2,[Row]")
		//else src << output("[S.Experience] %", "GridSS:2,[Row]")
		src << output("[S.desc]", "GridSS:3,[Row]")
	for(var/Skill/Buff/S in src) if(!istype(S,/Skill/Buff/SSj))if(!istype(S,/Skill/Buff/AlienTransformation))if(!istype(S,/Skill/Buff/ChangelingTransformation))
		Row++
		src << output(S, "GridSS:1,[Row]")
		src << output("[S.Experience] % [S.NotTeachable=1?"(Not Teachable)":"(Teachable Day: [S.TeachDay])"]", "GridSS:2,[Row]")
		src << output("[S.GetDescription(usr)]", "GridSS:3,[Row]")//
	for(var/Skill/Zanzoken/SF in src)
		Row++
		src << output(SF, "GridSS:1,[Row]")
		src << output("[min(100,round(Zanzoken/10))] %", "GridSS:2,[Row]")
		src << output("[SF.desc]", "GridSS:3,[Row]")
	if(TK)
		Row++
		src << output("Telekinesis", "GridSS:1,[Row]")
		src << output("100 %", "GridSS:2,[Row]")
		src << output("You can use this to move objects remotely. Click and drag an object on screen to use it.", "GridSS:3,[Row]")
	if(TK_Magic)
		Row++
		src << output("Magical Telekinesis", "GridSS:1,[Row]")
		src << output("100%", "GridSS:2,[Row]")
		src << output("You can use this to move objects remotely. Click and drag an object on screen to use it. Using this will drain a small amount of mana.", "GridSS:3,[Row]")
	if(src.Precognition||HasPrecognition)
		Row++
		src << output("Precognition", "GridSS:1,[Row]")
		src << output("100 %", "GridSS:2,[Row]")
		src << output("Allows you to automatically avoid projectiles at the cost of some energy. Adds 5% more speed (20% total) towards Offense and Defense calculations.", "GridSS:3,[Row]")
	for(var/Skill/Misc/Fly/SF in src)
		Row++
		src << output(SF, "GridSS:1,[Row]")
		src << output("[round(FlySkill)] Skill", "GridSS:2,[Row]")
		src << output("[SF.desc]", "GridSS:3,[Row]")
	for(var/Skill/Buff/SSj/SJ in src)
		Row++
		src << output(SJ, "GridSS:1,[Row]")
		src << output("[round(SSjDrain/3)] %", "GridSS:2,[Row]")
		src << output("[SJ.desc] Super Saiyan 1 Grants 1.5x BP, 1.1x Str, 1.1x Force, 1.1x Speed, 1.1x Off, 1.1x Def", "GridSS:3,[Row]")
		if(HasSSj>=2)
			Row++
			src << output("Super Saiyan 2", "GridSS:1,[Row]")
			src << output("[round(SSj2Drain/3)] %", "GridSS:2,[Row]")
			src << output("[SJ.desc] Super Saiyan 2 Grants 1.3x BP", "GridSS:3,[Row]")
		if(HasSSj>=3)
			Row++
			src << output("Super Saiyan 3", "GridSS:1,[Row]")
			src << output("[round(SSj3Drain/3)] %", "GridSS:2,[Row]")
			src << output("[SJ.desc] Super Saiyan 3 Grants 1.2x BP", "GridSS:3,[Row]")
		if(HasSSj4)
			Row++
			src << output("Super Saiyan 4", "GridSS:1,[Row]")
			src << output("100 %", "GridSS:2,[Row]")
			src << output("[SJ.desc] Super Saiyan 4 Grants 2.5x BP, ignores God Ki and does not drain", "GridSS:3,[Row]")
//		if(HasSSj5)
//			Row++
//			src << output("Super Saiyan 5", "GridSS:1,[Row]")
//			src << output("100 %", "GridSS:2,[Row]")
//			src << output("[SJ.desc] Super Saiyan 5 Grants 3.5x BP, ignores God Ki and does not drain", "GridSS:3,[Row]")
		if(MaxGodKi)
			Row++
			src << output("Super Saiyan God Super Saiyan", "GridSS:1,[Row]")
			src << output("[round(SSGSSDrain/3)] %", "GridSS:2,[Row]")
			src << output("You have awakened a power beyond that of the God's! You can go Super Saiyan while harnessing God Ki!", "GridSS:3,[Row]")
	for(var/Skill/Buff/AlienTransformation/AT in src)
		Row++
		src << output(AT, "GridSS:1,[Row]")
		if(Class!="Heran") src << output("[round(TransDrain/3)] %", "GridSS:2,[Row]")
		else src << output("[round(SSjDrain/3)] %", "GridSS:2,[Row]")
		src << output("[AT.desc]", "GridSS:3,[Row]")
		if(Class=="Heran"&&HasBojack==2)
			Row++
			src << output("Super Bojack (SSj2)", "GridSS:1,[Row]")
			src << output("[round(SSj2Drain/3)] %", "GridSS:2,[Row]")
			src << output("[AT.desc]", "GridSS:3,[Row]")
	for(var/Skill/Buff/ChangelingTransformation/AT in src)
		Row++
		src << output(AT, "GridSS:1,[Row]")
		src << output("100 %","GridSS:2.[Row]")
		src << output("[AT.desc]", "GridSS:3,[Row]")
	if(Race=="Changeling") if(HasForm>=5)
		Row++
		src << output("Golden Form (Form 5)", "GridSS:1,[Row]")
		src << output("[round(Form6Drain/3)] %", "GridSS:2,[Row]")
		src << output("Description TBD!", "GridSS:3,[Row]")
	for(var/BodyPart/Tail/AT in src)
		Row++
		src << output("Oozaru", "GridSS:1,[Row]")
		src << output("[round(OozaruMastery)] %", "GridSS:2,[Row]")
		src << output("[AT.GetDescription(usr)]", "GridSS:3,[Row]")
	for(var/obj/God_Ki/SF in src)
		Row++
		src << output(SF, "GridSS:1,[Row]")
		src << output("[(GodKi)]", "GridSS:2,[Row]")
		src << output("God Ki works like a seperate energy reserve. Turning it on increases your recovery ticks by +50%, reduces WP drain, and increases your Strength, Force and Endurance by 50% while draining your reserve God Ki by a portion of all energy spent while it is active.", "GridSS:3,[Row]")

	Row++
	src << output("Unarmed Combat", "GridSS:1,[Row]")
	src << output("[round(UnarmedSkill)] +[(HasUnarmed * 50)+(UnarmedSkillAdd*max(0.025,Year/30))] / [round((WipeDay*25)+50)] Skill", "GridSS:2,[Row]")
	src << output("Your skill in hand-to-hand combat. This helps to unlock new skills and is used to unlock passive abilities.", "GridSS:3,[Row]")
	Row++
	src << output("Weapon Handling", "GridSS:1,[Row]")
	src << output("[round(SwordSkill)] +[(HasWeapon * 50)+(SwordSkillAdd*max(0.025,Year/30))] / [round((WipeDay*25)+50)] Skill", "GridSS:2,[Row]")
	src << output("Your skill in combat with weapons. This helps to unlock new skills and is used to unlock passive abilities.", "GridSS:3,[Row]")
	Row++
	src << output("Ki Manipulation", "GridSS:1,[Row]")
	src << output("[round(KiManipulation)] +[(HasKiManip * 50)+(KiManipulationAdd*max(0.025,Year/30))] / [round((WipeDay*25)+50)] Skill", "GridSS:2,[Row]")
	src << output("Your skill with using Ki for combat. This helps to unlock new skills and is used to unlock passive abilities.", "GridSS:3,[Row]")
	Row++
	src << output("Evasion", "GridSS:1,[Row]")
	src << output("[round(Athleticism)] +[(HasEvasion * 50)+(AthleticismAdd*max(0.025,Year/30))] / [round((WipeDay*25)+50)] Skill", "GridSS:2,[Row]")
	src << output("Your skill with evading and blocking attacks.", "GridSS:3,[Row]")
	Row++
	src << output("Gravity", "GridSS:1,[Row]")
	src << output("[round(GravMastered,0.5)] x", "GridSS:2,[Row]")
	src << output("Increases the results of your training while mastering and grants a permanent BP percentage boost based on mastery.", "GridSS:3,[Row]")
	Row++
	src << output("Swimming", "GridSS:1,[Row]")
	src << output("[round(swimSkill/20,0.5)] %", "GridSS:2,[Row]")
	src << output("Helps you not drown while swimming.", "GridSS:3,[Row]")
	Row++
	src << output("Learns Remaining", "GridSS:1,[Row]")
	src << output("[LearnSlots] Learn Slots", "GridSS:2,[Row]")
	Row++
	if(HasWiseMentor) TeachLimit = 5
	src << output("Teach Limit ", "GridSS:1,[Row]")
	src << output("[TeachLimit] Teaches / Teach Timer [TeachCD]", "GridSS:2,[Row]")
	var/HasBoost=0
	if(locate(/obj/items/How_To_Serve_Saiba) in src) HasBoost=15 
	Row++
	src << output("Cooking", "GridSS:1,[Row]")
	src << output("[round(Cooking_Level+HasBoost)] Level", "GridSS:2,[Row]")
	src << output("([Commas(Cooking_XP)] / [Commas(Cooking_Next)]) [Cooking_Level>TechCap ?"(Overcapped)":Cooking_Level==TechCap ? "(Capped)":""]", "GridSS:3,[Row]")
	HasBoost=0
	if(locate(/obj/items/Anglers_Lure) in src) HasBoost=15
	Row++
	src << output("Fishing", "GridSS:1,[Row]")
	src << output("[round(Fishing_Level+HasBoost)] Level", "GridSS:2,[Row]")
	src << output("([Commas(Fishing_XP)] / [Commas(Fishing_Next)]) [Fishing_Level>TechCap ?"(Overcapped)":Fishing_Level==TechCap ? "(Capped)":""]", "GridSS:3,[Row]")
	Row++
	HasBoost=0
	if(locate(/obj/items/Ring_Of_Smithing) in src) HasBoost=10
	src << output("Mining", "GridSS:1,[Row]")
	src << output("[round(Mining_Level+HasBoost)] Level", "GridSS:2,[Row]")
	src << output("([Commas(Mining_XP)] / [Commas(Mining_Next)]) [Mining_Level>TechCap ?"(Overcapped)":Mining_Level==TechCap ? "(Capped)":""]", "GridSS:3,[Row]")
	Row++
	src << output("Smithing", "GridSS:1,[Row]")
	src << output("[round(Smithing_Level+HasBoost)] Level", "GridSS:2,[Row]")
	src << output("([Commas(Smithing_XP)] / [Commas(Smithing_Next)]) [Smithing_Level>TechCap ?"(Overcapped)":Smithing_Level==TechCap ? "(Capped)":""]", "GridSS:3,[Row]")


