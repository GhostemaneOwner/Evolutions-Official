
//Testing the Setup
obj/Assess/verb/Assess(mob/M in world)
	set src=usr.contents
	set category="Other"
	usr.Get_Assess(M)

mob/proc/Get_Assess(mob/M)
	if(!M) src<<"The person you just assessed is broken in some way. Please alert management."
	log_admin({"[key_name(src)] Assessed [M]"})
	var/Gravity_Multiplier=min(2.5,1+((M.GravMastered/25)/25))
	var/A={"
	<html>
	<style type="text/css">
	<!--
	body {
	     color:#449999;
	     background-color:black;
	     font-size:12;
	 }
	table {
	     font-size:12;
	 }
	//-->
	</style>
	<body>
	<A HREF='?src=\ref[src.client.holder];assess=\ref[M]'>Refresh</A><br>
	Coordinates: ([M.x], [M.y], [M.z]) (Infection: [M.Infection])<br>
	[M] (Key: [M.key]) [M.Rank ? "([M.Rank])" : ""]<br>
	[M.Size] [M.gender] [M.Race] [M.Class=="Undefined Class" ? "" : "([M.Class])"]<br>
	Current Anger: [M.Anger]% (Willpower: [M.Willpower])(Health: [M.Health])<br>
	Alignment: [M.AlignmentNumber] ([M.Alignment])
	<table cellspacing="6%" cellpadding="1%">
	<tr><td>Buffs:</td><td>Buffs [M.BuffNumber] ([M.Buffs.Join(", ")])</td></tr>
	<tr><td>Power Rank:</td><td>BP ([round(M.BPRank)]) / Stat ([round(M.StatRank)])</td></tr>
	<tr><td>RP Power:</td><td>Mult ([M.RPPower]) / Add ([M.RPPowerAdd]) / Racial [Commas(M.RacialPowerAdd)]</td></tr>
	<tr><td>Age:</td><td>[M.Age] ([M.Real_Age] True Age) (Save Age [M.SaveAge])</td></tr>
	<tr><td>Body:</td><td>[M.Body*100]% ([M.Decline] Decline)</td></tr>
	<tr><td>Base:</td><td>[Commas(M.Base)] ([M.FBMAchieved ? "(FBM) " : ""][M.BPMod] x [Commas(M.Base/M.BPMod)])[M.PotentialUnlocked?" Potential Unlocked":""]</td></tr>
	<tr><td>Current BP:</td><td>[Commas(M.BP)] ([M.BPMult] Mult)</td></tr>
	<tr><td>Energy: ([M.Total_Stats_Recov] points)</td><td>[round(M.MaxKi)] ([M.KiMod] Mod) ([M.KiMult] Mult [round(M.BaseMaxKi/M.KiMod)] Weighted)</td></tr>
	<tr><td>Strength: ([M.Total_Stats_Strength] points)</td><td>[round(M.Str)] ([M.StrMod] Mod) ([M.StrMult] Mult [round(M.BaseStr/M.StrMod)] Weighted)</td></tr>
	<tr><td>Endurance: ([M.Total_Stats_Endurance] points)</td><td>[round(M.End)] ([M.EndMod] Mod) ([M.EndMult] Mult [round(M.BaseEnd/M.EndMod)] Weighted)</td></tr>
	<tr><td>Speed: ([M.Total_Stats_Speed] points)</td><td>[round(M.Spd)] ([M.SpdMod] Mod) ([M.SpdMult] Mult [round(M.BaseSpd/M.SpdMod)] Weighted)</td></tr>
	<tr><td>Force: ([M.Total_Stats_Strength] points)</td><td>[round(M.Pow)] ([M.StrMod] Mod) ([M.PowMult] Mult [round(M.BaseStr/M.StrMod)] Weighted)</td></tr>
	<tr><td>Offense: ([M.Total_Stats_Off] points)</td><td>[round(M.Off)] ([M.OffMod] Mod) ([M.OffMult] Mult [round(M.BaseOff/M.OffMod)] Weighted)</td></tr>
	<tr><td>Defense: ([M.Total_Stats_Def] points)</td><td>[round(M.Def)] ([M.DefMod] Mod) ([M.DefMult] Mult [round(M.BaseDef/M.DefMod)] Weighted)</td></tr>
	<tr><td>Regeneration:</td><td>[M.Regeneration] ([M.RegenMult] x [M.BaseRegeneration] Base) ([M.HPTick] HP Tick)</td></tr>
	<tr><td>Recovery:</td><td>[M.Recovery] ([M.RecovMult] x [M.BaseRecovery] Base) ([M.KiTick] Ki Tick)</td></tr>
	<tr><td>Zenkai:</td><td>[Commas(M.ZenkaiPower)] ([M.Zenkai] x)</td></tr>
	<tr><td>Gravity:</td><td>[round(M.GravMastered)] ([Gravity_Multiplier] x BP Boost)</td></tr>
	<tr><td>Max Anger:</td><td>[M.MaxAnger]% ([M.AngerMult] x)</td></tr>
	<tr><td>Meditation:</td><td>[M.MedMod]</td></tr>
	<tr><td>Flying:</td><td>[round(M.FlySkill)] ([M.FlyMod])</td></tr>
	<tr><td>Zanzoken:</td><td>[round(M.Zanzoken)] ([M.ZanzoMod])</td></tr>
	<tr><td>Unarmed:</td><td>[round(M.UnarmedSkill)]</td></tr>
	<tr><td>Weapon:</td><td>[round(M.SwordSkill)]</td></tr>
	<tr><td>Ki Manipulation:</td><td>[round(M.KiManipulation)]</td></tr>
	<tr><td>Evasion:</td><td>[round(M.Athleticism)]</td></tr>
	<tr><td>Intelligence:</td><td>[M.Int_Level] ([M.Int_Mod])</td></tr>
	<tr><td>Magic Skill:</td><td>[M.Magic_Level] ([M.Magic_Potential])</td></tr>
	<tr><td>Energy Signature:</td><td>[M.Signature]</td></tr>
	<tr><td>Gain Multiplier:</td><td>[(M.GainMultiplier)]</td></tr>
	<tr><td>Weighted Stats:</td><td>[Commas(round(M.WeightedStats))]</td></tr>
	<tr><td>Combat Mod Total:</td><td>[((M.StrMod+M.EndMod+M.SpdMod+M.OffMod+M.DefMod))]</td></tr>
	</td></tr></table><br><table>"}// [M.Int_Level>20 ? "(Int Level [M.Int_Level*70/M.Int_Mod])" : ""] [M.Magic_Level>20 ? "(Magic Level [M.Magic_Level*70/M.Magic_Potential])" :""]
	if("Super Namekian" in M.LearnList) A+="<tr><td><font color=#FFFF99>SNj At: [Commas(M.SNjAt)]</td></tr>"
	if("Third Eye" in M.LearnList) A+="<tr><td><font color=#FFFF99>Third Eye At: [Commas(M.ThirdEyeAt)]</td></tr>"
	if(M.Race=="Saiyan")
		A+="<tr><td><font color=#FFFF99>SSj 1 At: [Commas(M.SSjAt)]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 1 Mult: [M.SSjMult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 2 Mult: [M.SSj2Mult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 3 Mult: [M.SSj3Mult]</td></tr>"
	if(M.Race=="Half-Saiyan")
		A+="<tr><td><font color=#FFFF99>SSj 1 At: [Commas(M.SSjAt)]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 1 Mult: [M.SSjMult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 2 Mult: [M.SSj2Mult]</td></tr>"
	if(M.Race=="Part-Saiyan")
		A+="<tr><td><font color=#FFFF99>SSj 1 At: [Commas(M.SSjAt)]</td></tr>"
		A+="<tr><td><font color=#FFFF99>SSj 1 Mult: [M.SSjMult]</td></tr>"
	if(M.Race=="Changeling"||M.Race=="Half-Changeling")
		A+="<tr><td><font color=#FFFF99>Form 2 Mult: [M.Form2Mult]</td></tr>"
		if(M.Class!="King Kold") A+="<tr><td><font color=#FFFF99>Form 3 Mult: [M.Form3Mult]</td></tr>"
		if(M.Class!="King Kold") A+="<tr><td><font color=#FFFF99>Form 4 Mult: [M.Form4Mult]</td></tr>"
		if(M.Class=="Cooler") A+="<tr><td><font color=#FFFF99>Form 5 Mult: [M.Form5Mult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>Golden Form Mult: [M.Form6Mult]</td></tr>"
//	if(M.Race=="Alien")
//		A+="<tr><td><font color=#FFFF99>Ascension At: [Commas(M.FBMAt*5)] (>1 God Ki)</td></tr>"
	if(M.Race=="Heran")
		A+="<tr><td><font color=#FFFF99>Bojack At: [Commas(M.SSjAt)]</td></tr>"
		A+="<tr><td><font color=#FFFF99>Bojack Mult: [M.SSjMult]</td></tr>"
		A+="<tr><td><font color=#FFFF99>Super Bojack Mult: [M.SSj2Mult]</td></tr>"
	if(M.Offspring)
		A+="<tr><td><font color=#FFFF99>Offspring: [M.Parents]</td></tr>"
	A+={"<tr><td><font color=#C5CAE9>God Ki: [M.GodKi] / [M.MaxGodKi]</td></tr></table>"}
	A+="<br><font color=#FFFF99>Mutations: [M.MutationNumber]<br>[M.Mutations.Join(", ")]"
	//A+="<br><font color=#FFFF99>Milestones: [M.DisplayMilestones()]<br>"
	for(var/Milestone/MP in M) A+="<br><font color=#FFFF99>[MP]<br>"
	usr<<browse(A,"window=[M.name];size=400x800")
	