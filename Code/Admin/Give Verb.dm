




/client/proc/Give_Object_Menu(var/mob/M in Players)
	set name = "Give Object"
	set category = "Admin"
/*
	if(usr.client && !usr.client.holder||TestServerOn)
		src << "Only administrators may use this command."
		return*/

	var/txt = {"<HTML><HEAD><TITLE>Give Object</TITLE></HEAD><BODY>
				<FORM NAME="Spawner" ACTION="byond://?src=\ref[src]" METHOD="GET">
				<b>Selected player:</b> [M] <INPUT TYPE=hidden NAME="GiveObjectListMob" VALUE="\ref[M]"><br>
				<b>Type:</b> <INPUT TYPE="text" NAME="SearchBar" VALUE="" onKeyUp="updateSearch()" onKeyPress="submitFirst(event)" style="width:300px"><BR>
				<b>Number:</b> <INPUT TYPE="text" NAME="number"  VALUE="1" style="width:100px"><BR><BR>
				<SELECT NAME="GiveObjectList" id="GiveObjectList" size="20" multiple style="width:400px"></SELECT><BR>
				<INPUT TYPE="hidden" name="src" value="\ref[src]">
				<INPUT TYPE="submit" value="spawn">
				</FORM>
				<SCRIPT LANGUAGE="JavaScript">
					var OldSearch = "";
					var GiveObjectList = document.Spawner.GiveObjectList;
					var ObjectTypes = "[dd_list2text(typesof(/obj),";")]";
					var ObjectArray = ObjectTypes.split(";");
					document.Spawner.SearchBar.focus();
					populateList();
					function populateList()
					{
						var myElem;
						GiveObjectList.options.length = 0;
						for(myElem in ObjectArray)
						{
							var oOption = document.createElement("OPTION");
							oOption.value = ObjectArray\[myElem\];
							oOption.text = ObjectArray\[myElem\];
							GiveObjectList.options.add(oOption);
						}
					}
					function updateSearch()
					{
						if(OldSearch == document.Spawner.SearchBar.value) return;
						OldSearch = document.Spawner.SearchBar.value;
						ObjectArray = new Array();
						var TestElem;
						var TmpArray = ObjectTypes.split(";");
						if(OldSearch!=null) OldSearch = OldSearch.toLowerCase(); // Turn the search string into lowercase
						for(TestElem in TmpArray)
						{
							if(TmpArray\[TestElem\].toLowerCase().search(OldSearch) < 0) continue; //compare the lowercase entry to the lowercase search string for a match.
							ObjectArray.push(TmpArray\[TestElem\]);
						}
						populateList();
					}
					function submitFirst(event)
					{
						if(!GiveObjectList.options.length) return false;
						if(event.keyCode == 13 || event.which == 13)
							GiveObjectList.options\[0\].selected = 'true';
					}
				</SCRIPT></BODY></HTML>"}
	usr << browse(txt, "window=give_object;size=440x490")











/*

mob/verb
	Grant_CappedStats(mob/M in Players)
		set category="Admin"
		if(usr.Confirm("Cap all [M]'s stats?"))
			M.CapStats()

			log_admin("[key_name(usr)] capped [M]'s stats.")
			alertAdmins("[key_name_admin(usr)] capped [M]'s stats.", 1)


	Grant_AllSkill_Mastery(mob/M in Players)
		set category="Admin"
		if(usr.Confirm("Master all of [M]'s skills?"))
			for(var/Skill/S in M) S.Experience=100
			M.Zanzoken=1000
			M.FlySkill=5000
			M<<"Your skills were all mastered."
			log_admin("[key_name(usr)] mastered [key_name(M)]'s skills.")
			alertAdmins("[key_name(usr)] mastered [key_name(M)]'s skills.")
*/

client/proc





	Give_Other(mob/M as mob in Players)
		set category="Admin"
		set name="Give Menu"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		var/list/Choices=list("Cancel","Reset Cooldowns","Warning","Remove Power Mate","Remove Combat Flag","Alter Willpower","Give Infection","Remove Infection", "Admin Revive", "Give Build","Remove Build","Give Nitro Booster","Give Starter Boost","Give Skill Mastery","Give Object","Give Anger","Force Reincarnate","Give Redo Stats","Give Martial Arts","Alter Stats","Alter Mutations","Give Capped Stats","Allow Multikeys")
		if(usr.client.holder.level >= 2) Choices.Add("HBTC Boost","Make Basic EC","Give Werewolf","Remove Werewolf","Give Vampire","Remove Vampire","Give God Ki","Give Rank","Give Rare Access","Give Transformation","Assign Control Point")
		var/PP=input("Give [M] what?","Give Other") in Choices
		switch(PP)
			if("Reset Cooldowns") usr.ResetCDs(M)
			if("Give Build") usr.Give_Build(M)
			if("Remove Build") usr.Remove_Build(M)
			if("Give Nitro Booster") usr.Give_NitroBooster(M)
			if("Give Starter Boost") usr.Grant_Starter_Boost(M)
			if("Give Skill Mastery")usr.Grant_All_Skill_Mastery(M)
			if("Give Martial Arts")usr.Grant_Martial_Arts(M)
			if("Give God Ki")usr.Grant_God_Ki(M)
			if("Give Capped Stats")usr.Grant_Capped_Stats(M)
			if("Give Rank") usr.client.Give_Rank(M)
			if("Give Anger") usr.Grant_Anger(M)
			if("Give Object") usr.client.Give_Object_Menu(M)
			if("Force Reincarnate") usr.Force_Reincarnate(M)
			if("Give Redo Stats") usr.Give_RedoStats(M)
			if("Give Rare Access") usr.client.allow_rares(M)
			if("Give Transformation") usr.client.Grant_Transformation(M)
			if("Alter Stats") usr.client.Reward(M)
			if("Alter Mutations") usr.AssignMutation(M)
			if("HBTC Boost") usr.HBTCBoost(M)
			if("Allow Multikeys") usr.ApproveMultikey(M)
			if("Assign Control Point")usr.Assign_Control_Point(M)
			if("Remove Combat Flag") usr.RemoveCombat(M)
			if("Alter Willpower") usr.AlterWP(M)
			if("Admin Heal Injury") usr.Get_Injury_Healed(M)
			if("Admin Revive") usr.ARevive(M)
			if("Make Basic EC") usr.Grant_Basic_EC_Stuff(M)
			if("Warning") usr.Warn(M)
			if("Give Vampire") usr.Grant_Vampire(M)
			if("Remove Vampire") usr.Remove_Vampire(M)
			if("Give Werewolf") usr.Grant_Werewolf(M)
			if("Remove Werewolf") usr.Remove_Werewolf(M)
			if("Remove Infection") M.Infection=0
			if("Give Infection") M.Infection=1
			if("Remove Power Mate") usr.Remove_Power_Mate(M)





/*
/client/proc/GiveObj(mob/M in Players)
	set category = "Admin"
	if(!src.holder || (src.holder.level < 2))	//EV and above
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/list/B = new
	B+="Cancel"
	B+=typesof(/obj)
	B.Remove(typesof(/obj/admins),typesof(/obj/Body_Part),typesof(/Icon_Obj),typesof(/HairType),typesof(/obj/Props),\
	typesof(/OBJ_AI/SpaceDebris),typesof(/obj/Planets),\
	typesof(/obj/Technology),typesof(/obj/Warper),typesof(/obj/Build)\
	,typesof(/obj/Contact),typesof(/obj/DeadZone),typesof(/obj/Faction)\
	,typesof(/obj/Faction),typesof(/obj/Well),typesof(/obj/Baby)\
	,typesof(/obj/Lightning_Strike),typesof(/obj/ranged/Blast),typesof(/obj/Curse),typesof(/obj/Sacred_Water)\
	,typesof(/obj/Controls),typesof(/obj/Controls/PodControls),typesof(/obj/Ships),typesof(/Skill/MartialArt),typesof(/obj/Drill))

	var/Choice=input("") in B
	if(Choice=="Cancel")
		return
	if(M.contents)	//You wouldn't expect an error to come of removing this, but one did!
		M.contents += new Choice
	else
		return
	log_admin({"[key_name(src)] gave [key_name(M)] [Choice]</div>"})
	alertAdmins("[key_name(src)] gave [key_name(M)] [Choice]")
*/

mob/proc/
	Remove_Power_Mate(mob/M in Players)
		set category="Admin"
		if(src.Confirm("Remove [M]s mutations?"))
			M.BPMod=M.GeneticBPMod
			M.BaseMaxAnger=M.GeneticMaxAnger
			M.StrMod=M.GeneticStrMod
			M.EndMod=M.GeneticEndMod
			M.SpdMod=M.GeneticSpdMod
			M.OffMod=M.GeneticOffMod
			M.DefMod=M.GeneticDefMod
			M.BaseRecovery=M.GeneticRecovery
			log_admin("[key_name(src)] removed [key_name(M)]'s mutations")
			alertAdmins("[key_name(src)] removed [key_name(M)]'s mutations")

	AlterWP(mob/M in Players)
		if(!src.client.holder)
			src << "Only administrators may use this command."
			return
		var/inp=input("New WP for [M]") as num
		if(src.Confirm("Change [M]s WP to [inp]"))
			M.Willpower=inp
			log_admin("[key_name(usr)] used Alter WP on [key_name(M)]")
			alertAdmins("[key_name(usr)] used Alter WP on [key_name(M)]")

	ResetCDs(mob/M in Players)
		if(!src.client.holder)
			src << "Only administrators may use this command."
			return
		if(src.Confirm("Reset [M]'s CDs?"))
			M.cooldowns = null
			log_admin("[key_name(usr)] used reset CDs on [key_name(M)]")
			alertAdmins("[key_name(usr)] used reset CDs on [key_name(M)]")

	RemoveCombat(mob/M in Players)
		if(!src.client.holder)
			src << "Only administrators may use this command."
			return
		if(src.Confirm("Remove [M]s Combat Tracker?"))
			M.LethalCombatTracker=0
			log_admin("[key_name(usr)] used Remove Combat Flag on [key_name(M)]")
			alertAdmins("[key_name(usr)] used Remove Combat Flag on [key_name(M)]")

	Warn(mob/M in Players)
//		set category = "Admin"
		set desc = "Warn a player"
		if(!src.client.holder)
			src << "Only administrators may use this command."
			return
		if(M.client && M.client.holder && (M.client.holder.level >= src.client.holder.level))
			alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
			return
		if(!src.Confirm("Warn [M]?")) return
		var/addedMemory = input("Warn for what?") as message
		if(!M.client.warned)
			M << "\red <B>You have been warned by an administrator. This is the only warning you will recieve.</B>"
			M << "\red <hr>[addedMemory]"
			M.client.warned = 1
			alertAdmins("[key_name(src)] warned [key_name(M)].")
			addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([src.key])<hr> [addedMemory]<br><hr>"
			M.mind.store_memory(addedMemory)
		else
			addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([src.key])<hr> [addedMemory]<br><hr>"
			M.mind.store_memory(addedMemory)
			AddBan(M.ckey, M.computer_id, "Autobanning due to previous warn", src.ckey, 1, 10)
			M << "\red<BIG><B>You have been autobanned by [src.ckey]. This is your \"second warning\".</B></BIG>"
			M << "\red <hr>[addedMemory]"
			M << "\red This is a temporary ban; it will automatically be removed in 10 minutes."
			log_admin("[key_name(src)] warned [key_name(M)], resulting in a 10 minute autoban.")
			alertAdmins("[key_name(usr)] warned [key_name(M)] resulting in a 10 minute autoban.")
			del(M.client)
			del(M)

	Reset_Milestones(var/mob/player/A in Players)
		if(usr.Confirm("Reset [A]'s XP?"))
			//A.ResetMiles()
			A.XP=0
			A.TotalXP=0
			A.CatchUpXPs=0

	Get_Injury_Healed(mob/M in Players)
		set category = "Admin"
		set name = "Admin Heal Injury"
		/*if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(!M)
			alert("Mob doesn't exist!")
			return
		for(var/BodyPart/P in M) M.Injure_Heal(200,P,1)
		/*var/list/Parts=list()
		for(var/BodyPart/P in M) Parts+=P
		Parts+="Cancel"
		Parts+="All"
		var/BodyPart/Cho=input(usr,"Heal which part?") in Parts
		if(Cho=="Cancel") return
		if(Cho=="All") for(var/BodyPart/P in M) M.Injure_Heal(200,Cho,1)
		else M.Injure_Heal(200,Cho,1)*/
		log_admin("[key_name(usr)] used AdminHeal Injury on [key_name(M)]")
		alertAdmins("[key_name(usr)] used AdminHeal Injury on [key_name(M)]")

/*
	AHeal(mob/M in Players)
		//set category = "Admin"
		set name = "Admin Heal Injury"
		if(!src.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!M)
			alert("Mob doesn't exist!")
			return
		var/PP=input(src,"Heal all injuries?") in list("All Injuries","Cancel")
		switch(PP)
			if("All Injuries") src.Get_Injury_Healed(M)*/


	ARevive(mob/M in Players)
		//set category = "Admin"
		set name = "Admin Give Life"
		/*if(!src.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(!M)
			alert("Mob doesn't exist!")
			return
		if(M.Dead)
			M.Revive()
			if(M.KOd) M.Un_KO()
			M.Health = M.MaxHealth
			M.Calm()
			M.Ki = M.MaxKi
		else
			alert("[M] isn't dead!")
			return
		log_admin("[key_name(src)] used AdminRevive on [key_name(M)]")
		alertAdmins("[key_name(src)] used AdminRevive on [key_name(M)]")



	Give_NitroBooster(mob/M as mob in Players)
		set hidden=1
		if(usr.Confirm("Mark this person as a Nitro Booster?"))
			M.NitroBooster=1
//			M.contents+= new/obj/Nitro_Booster
			M.BoosterTag="\icon['logo5.png']"
//			M.OOCTag="\icon['logo5.png']"
			logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] Nitro Booster Privileges.",2)


	Give_Build(mob/M as mob in Players)
		set hidden=1//set category="Admin"
		/*if(!usr.client.holder || usr.client.holder.level < 1)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		M.HasBuildingPermit=1
		if(usr.Confirm("Give them the ability to build in space too?")) M.BuildInSpace=1
		logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] Build Privileges.",2)

	Remove_Build(mob/M as mob in Players)
		set hidden=1
		M.HasBuildingPermit=0
		M.BuildInSpace=0
		logAndAlertAdmins("[key_name(usr)] removed [key_name(M)]'s Build Privileges.",2)

	ApproveMultikey(mob/M as mob in Players)
		set hidden=1//set category="Admin"
		M.MultikeyApproved=input("Choose which multikey access to grant [M] 0 = None 1 = same IP 2 = same PC") as num
		M.MultikeyApproved=round(M.MultikeyApproved)
		if(M.MultikeyApproved<0)M.MultikeyApproved=0
		if(M.MultikeyApproved>3)M.MultikeyApproved=3
		logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] [M.MultikeyApproved] multikey access.",2)


	HBTCBoost(mob/M as mob in Players)
		set hidden=1//set category="Admin"
		/*if(!usr.client.holder || usr.client.holder.level < 2)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(usr.Confirm("Give them an HBTC boost? (Lasts for about 2 IC Years) This boost is equal to 1 year of training inside the HBTC."))
			M.HBTCPower=10
			M.Alter_Age(1)
		logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] the [M.Race] [M.Class] HBTC training.",2)

	Give_RedoStats(mob/M as mob in Players)
		set hidden=1//set category="Admin"
	/*	if(!usr.client.holder || usr.client.holder.level < 1)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		M.contents+=new/obj/Redo_Stats
		logAndAlertAdmins("[key_name(usr)] gave [key_name(M)] the [M.Race] [M.Class] Redo Stats.",2)

	Grant_Anger(mob/M as mob in Players)
		set category = "Admin"
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(!M) return
		var/DA=input("Death Anger?") in list("Full Death", "Partial Death", "Normal")
		if(M)
			if(DA=="Full Death")
				M.DeathAnger=1
				M.Anger()
			if(DA=="Partial Death")
				M.DeathAnger=0.5
				M.Anger()
			if(DA=="Normal") M.Anger()
			alertAdmins("Grant Anger: [key_name(usr)] granted [M] [DA] Anger",1)
			log_admin("Grant Anger: [key_name(usr)] granted [M] [DA] Anger")

	Force_Reincarnate(mob/M in Players)
		set category="Admin"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(usr.Confirm("Reincarnate [M]?"))
			M<<"You are being reincarnated. Please choose new and create your new character. If this was in mistake, press load."
			M.Reincarnation()
			log_admin("[key_name(usr)] reincarnated [M].")
			alertAdmins("[key_name_admin(usr)] reincarnated [M].", 1)




	Grant_Starter_Boost(mob/M as mob in Players)
		set category="Admin"
		/*(!usr.client.holder || usr.client.holder.level < 1)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(usr.Confirm("Give [M] a Starter Boost?"))
			M.GetStarterBoost()
			logAndAlertAdmins("[key_name(src)] gave [key_name(M)] the [M.Race] [M.Class] a starter boost.",2)

	Grant_Vampire(mob/M as mob in Players)
		set category="Admin"
		if(usr.Confirm("Give [M] Vampirism?"))
			M.Vampire=2
			if(!M.Regenerate) M.Regenerate+=0.6

			M.Vampire_Skills()
			logAndAlertAdmins("[key_name(src)] gave [key_name(M)] the [M.Race] [M.Class] vampirism.",2)

	Remove_Vampire(mob/M as mob in Players)
		set category="Admin"
		if(usr.Confirm("Remove [M] Vampirism?"))
			M.RemoveVampire_Skills()
			logAndAlertAdmins("[key_name(src)] removed [key_name(M)] the [M.Race] [M.Class] vampirism.",2)

	Grant_Werewolf(mob/M as mob in Players)
		set category="Admin"
		if(usr.Confirm("Give [M] Lycanthropy?"))
			M.HasWerewolf=2
			if(!M.Regenerate) M.Regenerate+=0.6

			M.Werewolf_Skills()
			logAndAlertAdmins("[key_name(src)] gave [key_name(M)] the [M.Race] [M.Class] lycanthropy.",2)

	Remove_Werewolf(mob/M as mob in Players)
		set category="Admin"
		if(usr.Confirm("Remove [M] Lycanthropy?"))
			M.RemoveWerewolf_Skills()
			logAndAlertAdmins("[key_name(src)] removed [key_name(M)] the [M.Race] [M.Class] lycanthropy.",2)

	Grant_Basic_EC_Stuff(mob/M in Players)
		set category="Admin"
		if(!usr.Confirm("Make them EC?")) return
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(usr.Confirm("Cap all [M]'s stats?"))
			M.CapStats()

			log_admin("[key_name(usr)] capped [M]'s stats.")
			alertAdmins("[key_name_admin(usr)] capped [M]'s stats.", 1)
		M.Zanzoken=1000
		M.FlySkill=5000
		M.UnarmedSkill=1000
		M.SwordSkill=1000
		M.KiManipulation=1000
		M<<"Your skills were all mastered."

		if(Base<StarterBoostBP*BPMod*2.5) Base=StarterBoostBP*BPMod*2.5
		//if(BaseMaxKi<StarterBoostEnergy*KiMod*2) BaseMaxKi=StarterBoostEnergy*KiMod*2
		if(usr.Confirm("Give them MPs?"))
			M.XP=(WipeUpTimer/600)*XPRate
			M.TotalXP=XP
		/*if(usr.Confirm("Give them a stance?"))
			M.GetStance()
			logAndAlertAdmins("[src.key] has given [M] Custom Martial Arts.",2)*/
		if(usr.Confirm("Give them a basic kit?"))
			M.SpaceKing(0)
		if(usr.Confirm("Master all of [M]'s skills?"))
			for(var/Skill/S in M) S.Experience=100
			log_admin("[key_name(usr)] mastered [key_name(M)]'s skills.")
			alertAdmins("[key_name(usr)] mastered [key_name(M)]'s skills.")

	Grant_Capped_Stats(mob/M in Players)
		set category="Admin"
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(usr.Confirm("Cap all [M]'s stats?"))
			var/N=input("Cap them at which rate? 1x = cap, 1.1x=over cap)") as num
			if(N<0.5)N=0.5
			if(N>1.5)N=1.5
			M.CapStats(N)

			log_admin("[key_name(usr)] capped [M]'s stats.")
			alertAdmins("[key_name_admin(usr)] capped [M]'s stats.", 1)
	Grant_All_Skill_Mastery(mob/M in Players)
		set category="Admin"
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		if(usr.Confirm("Master all of [M]'s skills?"))
			for(var/Skill/S in M) S.Experience=100
			M.Zanzoken=1000
			M.FlySkill=5000
			M.UnarmedSkill=1000
			M.SwordSkill=1000
			M.KiManipulation=1000
			M<<"Your skills were all mastered."
			log_admin("[key_name(usr)] mastered [key_name(M)]'s skills.")
			alertAdmins("[key_name(usr)] mastered [key_name(M)]'s skills.")

	Grant_Martial_Arts(mob/M as mob in Players)
		set category = "Admin"
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		M.GetStance()
		logAndAlertAdmins("[src.key] has given [M] Custom Martial Arts.",2)

	Grant_God_Ki(mob/M as mob in Players)
		set category = "Admin"
		/*(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return*/
		switch(input("Would you like to grant [M] God Ki or remove it?") in list("Remove","Grant"))
			if("Grant")
				M<<"You feel an unfamiliar energy within your body... It's hard to describe, but it is unlike anything you have ever felt before.  The only thing you know for certain is that it is powerful..."
				M.GodKi=1
				M.MaxGodKi=1
				if(!locate(/obj/God_Ki) in M) M.contents+=new/obj/God_Ki
				for(var/mob/player/MM in view(15,M)) MM<<'Carl_Orff_35_SEC.wav'
				logAndAlertAdmins("[src.key] has given [M] God Ki.",2)
				return
			if("Remove")
				M.GodKi=0
				M.MaxGodKi=0
				M<<"You have lost the God Ki you once possessed."
				for(var/obj/God_Ki/SS in M) del(SS)
				logAndAlertAdmins("[src.key] has taken away [M]'s God Ki.",2)


