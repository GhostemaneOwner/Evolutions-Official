

Skill/Spell/Conjure
	Experience=100
	desc="This will conjure a demon from Hell to serve you.  Make sure your contract is specific enough to control it. Summoning a demon removes part of your ki. (Allows someone to create a Demon. You may add a password)"
	verb/Conjure()
		set category="Other"
		var/Cost = 390000000
		var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
		usr << "Base cost for this spell is [Commas(Cost)] mana per level. Your magic potential means it costs [Commas(Actual)] mana per level for you."
		for(var/obj/Mana/M in usr) if(M.Value > Actual) if(usr.Confirm("Attempt to summon a demon for [Actual] mana?"))
			M.Value -= Actual
			view(src)<<"[usr] begins to summon a demon!"
			var/obj/Baby/A=new
			A.Race="Demon Contract"
			A.Builder = usr.ckey
			A.loc=usr.loc
			A.icon='fx.dmi'
			A.icon_state="chaos gate"
			A.name="Demonic Contract ([usr])"
			usr.AlignmentNumber-=1
			usr.AlignmentCalibrate()
			if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Demon Contract",null) as text



/*Skill/Technology/Create_Artificial_Angel
	Experience=100
	desc="This will create a 'perfect' being. This is science's attempt at creating a being of divine nature. (Allows someone to create a Kaio. You may add a password)"
	verb/Create_Artificial_Angel()
		set category="Skills"
		var/Cost = 3900000
		var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
		usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
		for(var/obj/Resources/M in usr) if(M.Value > Actual) if(usr.Confirm("Attempt to create an artificial angel for [Actual] resources?"))
			M.Value -= Actual
			view(src)<<"[usr] begins to create an artificial angel!"
			var/obj/Baby/A=new
			A.Race="Artificial Angel"
			A.loc=usr.loc
			A.icon='fx.dmi'
			A.icon_state="astral gate"
			A.name="Artificial Angel ([usr])"
			if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Artificial Angel",null) as text*/



/*
			else if(C.Race=="Bio-Android")
				Bio()
				Builder=C.Builder
				if(C.z) loc=locate(C.x,C.y,C.z)
				for(var/mob/P in Players) if(ckey(P.key)==Builder) loc=P.loc
				view(src)<<"[src] comes to life!"


		var/list/Demons=new/list
		for(var/mob/player/Demon in Players)
			if(!Demon.Rank&&!Demon.LethalCombatTracker&&!Demon.afk) if(Demon.Race=="Demon")
				Demons.Add(Demon)
		Demons+="Cancel"
		var/mob/Choice=input("Conjure which Demon?") in Demons
		if(Choice=="Cancel") return
		else if(Choice)
			if (Choice.MaxKi>=usr.MaxKi)
				usr<<"[Choice] is far beyond your ability to summon!"
				return
			if (Choice.Conjured==1)
				usr<<"[Choice] has already been conjured!"
				return
			else
				var/Reason=input("Input the contract you want the Demon to sign and abide by, allowing them to decide wether to agree or not.") as message
				spawn switch(input(Choice,"[usr] wishes to conjure you from the underworld to \his location. Their contract is as follows:\n [Reason]", "Summon request", text) in list ("No", "Yes",))
					if("Yes")
						var/Price
						do
							Price=input(Choice,"What will be your price? (in Energy) | Their max is [usr.MaxKi], it cannot be above this.","Price", 1000) as num
						while(!Price || Price > usr.MaxKi)
						if(usr)
							switch(alert("[Choice] has agreed to be conjured. Their price is [Price]. This is permanent. Do you accept?",,"Yes","No"))
								if("Yes")
									//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has conjured [key_name(Choice)] to do \his bidding! Price: [Price]\nContract: [Reason]")
									usr.MaxKi -= Price
									usr.Ki = usr.Ki - Price <= 0 ? 0 : usr.Ki - Price
									usr.Health*=0.5
									Choice.MaxKi += Price
									Choice.Ki = Choice.MaxKi
									oview(usr)<<"[usr] conjures the demon [Choice] to do \his bidding!"
									usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] Conjured [Choice]. <b>Price:</b> [Price]<br><b>Contract:</b> [Reason]\n")
									Choice.ConjureX=Choice.x
									Choice.ConjureY=Choice.y
									Choice.ConjureZ=Choice.z
									var/image/I=image(icon='Black Hole.dmi',icon_state="full")
									flick(I,Choice)
									Choice.loc=locate(usr.x,usr.y-1,usr.z)
									flick(I,Choice)
									spawn(1) step(Choice,SOUTH)
									Choice.Conjured=1
									Choice.ConjuredKey=usr.lastKnownKey

									var/obj/ConjureContractObj/SC=new
									SC.SoulKey=Choice.key
									SC.SoulName=Choice.real_name
									SC.SoulDate=Year
									SC.Contract="[Reason]"
									SC.name="[Choice]'s Contract"
									usr.contents+=SC
								if("No")
									Choice << "[usr] did not agree with your price."
					else if(usr)
						usr<<"[Choice] has denied the conjurer."
*/



obj/ConjureContractObj
	var/SoulKey
	var/SoulName
	var/SoulDate
	var/LastSummon
	var/Contract
	Click()
		..()
		usr<<"Demon Contract Information: [SoulName], Date Acquired: [SoulDate]<br> Contract: [Contract]"
		if(usr.RPMode) return
		if(usr.ActionCheck) return
		usr.ActionCheck=1
		spawn(20) usr.ActionCheck=0
		var/list/Choices=new
		Choices.Add("Summon","DeConjure","Cancel")
		var/Choice=input(usr,"Choose your action","Soul Contract") in Choices
		switch(Choice)
			if("DeConjure") if(usr.Confirm("This will destroy the contract. Continue?"))
				for(var/mob/Demon in Players) if(Demon.key==SoulKey) if(Demon.ConjuredKey==usr.key)
					Demon<<"[usr] has sent you back from whence you came."
					//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has deconjured [key_name(Demon)]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has deconjured [key_name(Demon)].\n")
					Demon.saveToLog("|| ([Demon.x], [Demon.y], [Demon.z]) | [key_name(Demon)] has been deconjured by [key_name(usr)]. \n")
					var/image/I=image(icon='Black Hole.dmi',icon_state="full")
					flick(I,Demon)
					Demon.loc=locate(Demon.ConjureX,Demon.ConjureY,Demon.ConjureZ)
					flick(I,Demon)
					Demon.Conjured=0
					Demon.ConjuredKey=null
					spawn() del(src)
			if("Summon")
				if(LastSummon+0.3<Year)
					for(var/mob/M in Players) if(M.key==SoulKey)
						if(M.z==10||M.LethalCombatTracker)
							usr<<"They can not be reached at this time..."
							return
						alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Conjure Contract summoned [key_name(M)]")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Conjure Contract summoned [key_name(M)]")
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Conjure Contract summoned [key_name(M)]")
						M<<"You feel a strange sensation as the person with your contract is summoning you..."
						for(var/mob/MM in view(15,M)) MM<<"[M] begins to glow as they are summoned away."
						M.overlays+='holybolt.dmi'
						sleep(15)
						M.overlays-='holybolt.dmi'
						M.loc=usr.loc
						LastSummon=Year
				else usr<<"You may only summon them once every four months."


mob/var/Contracted=0
obj/SoulContractObj
	var/SoulKey
	var/SoulName
	var/SoulLevel
	var/SoulDate
	var/SoulExpire
	var/LastKO
	var/LastSummon
	var/Contract
	Click()
		..()
		usr<<"Soul Contract Information: [SoulName], Date Acquired: [SoulDate]<br> Contract: [Contract]"
		if(usr.RPMode) return
		if(usr.ActionCheck) return
		usr.ActionCheck=1
		spawn(20) usr.ActionCheck=0
		var/list/Choices=new
		Choices.Add("Destroy Contract","Force Submit","Cancel")
		var/Choice=input(usr,"Choose your action","Soul Contract") in Choices
		switch(Choice)
			if("Destroy Contract")
				for(var/mob/M in Players) if(M.key==SoulKey) M.Contracted=0
				spawn() del(src)
			if("Force Submit")
				for(var/mob/M in view(20)) if(M.key==SoulKey)
					alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract KOd [key_name(M)]")
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract KOd [key_name(M)]")
					M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract KOd [key_name(M)]")
					M<<"You feel a strange sensation as the person with your soul is forcing you to submit..."
					for(var/mob/MM in view(20,M)) MM<<"[M] begins to glow as they are forced to submit."
					M.overlays+='Laser Particles.dmi'
					sleep(15)
					M.overlays-='Laser Particles.dmi'
					M.KO(usr)
					LastKO=Year
			if("Summon")
				if(LastSummon+0.3<Year)
					for(var/mob/M in Players) if(M.key==SoulKey)
						if(M.z==10||M.LethalCombatTracker)
							usr<<"They can not be reached at this time..."
							return
						alertAdmins("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract summoned [key_name(M)]")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract summoned [key_name(M)]")
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contract summoned [key_name(M)]")
						M<<"You feel a strange sensation as the person with your soul is summoning you..."
						for(var/mob/MM in view(15,M)) MM<<"[M] begins to glow as they are summoned away."
						M.overlays+='holybolt.dmi'
						sleep(15)
						M.overlays-='holybolt.dmi'
						M.loc=usr.loc
						LastSummon=Year
				else usr<<"You may only summon them once every four months."

Skill/Support/Soul_Contract
	Experience=100
	desc="Used to create a soul contract over someone.  You can use this when offering mortals training or skills in exchange for dominion over their soul."
	verb/Make_Soul_Contract()
		set category="Other"
		desc="Makes a soul contact."
		var/list/Demons=new/list
		Demons+="Cancel"
		for(var/mob/player/M in oview(1,usr)) if(M.client) Demons.Add(M)
		var/mob/Choice=input("Make a contract for who?") in Demons
		if(Choice!="Cancel")
			if(Choice.Contracted==1)
				usr<<"[Choice] has already been contracted!"
				return
			else
				var/Reason=input("Input the contract you want to propose to [Choice], allowing them to decide wether to agree or not. (Formatted as \"[usr] wishes to exchange your mortal soul for : Reason.\"") as message
				spawn switch(input(Choice,"[usr] wishes to exchange your mortal soul for :\n [Reason]", "Soul Contract", text) in list ("No", "Yes",))
					if("Yes")
						if(usr)
							alert("[Choice] has agreed to give up their soul in exchange for [Reason].")
							//("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							alertAdmins("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							oview(usr)<<"[usr] signs a contract with [Choice]"
							usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has Soul Contracted [key_name(Choice)] \nContract: [Reason]")
							Choice.Contracted=1
							var/obj/SoulContractObj/SC=new
							SC.SoulKey=Choice.key
							SC.SoulName=Choice.real_name
							SC.SoulLevel=1
							SC.SoulDate=Year
							SC.SoulExpire=Year+10
							SC.Contract="[Reason]"
							SC.name="[Choice]'s Contract"
							usr.contents+=SC
					else if(usr) usr<<"[Choice] has denied the contract."


/*		if(M.KOd==0)
			switch(alert(M,"[usr] wants to extract your DNA, allow it?","Genetic Sequencer","Yes","No"))
				if("Yes") Go=1
		else Go=1
		if(Go)*/


mob/verb/Show_Quest_Log()
	set category=null
	winshow(client,"QuestLog",1)
	var/Row=0
	for(var/obj/Quest/S in src)
		Row++
		src << output(S, "QuestGrid:1,[Row]")

obj/Quest
	var/QuestGiverKey
	var/QuestGiverName
	var/QuestDate
	var/QuestName
	var/QuestDescription
	var/QuestObjective
	var/QuestFailure
	var/QuestReward
	var/IsMasterQuest
	var/list/PeopleCompleted=list()
	var/list/PeopleAssigned=list()
	var/Status="In Progress"
	Click()
		..()
		var/QuestText={"<html>
<head><title>[QuestName] (Quest)</title><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
Quest: [QuestName]<br>
Status: [Status]<br>
-----<br>
Quest Giver: [QuestGiverName]<br>
Quest Accepted: [QuestDate]<br>
Quest Objective: [QuestObjective]<br>
Quest Failure: [QuestFailure]<br>
Quest Reward: [QuestReward]<br>
-----<br>
[QuestDescription]
<br>
</body><html>"}
		if(IsMasterQuest)
			QuestText={"<html>
<head><title>[QuestName] (Quest)</title><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
Quest: [QuestName]<br>
Status: [Status]<br>
-----<br>
Quest Giver: [QuestGiverName]<br>
Quest Accepted: [QuestDate]<br>
Quest Objective: [QuestObjective]<br>
Quest Failure: [QuestFailure]<br>
Quest Reward: [QuestReward]<br>
-----<br>
[QuestDescription]
-----<br>
Assigned to: [PeopleAssigned.Join(", ")]<br>
Completed by: [PeopleCompleted.Join(", ")]<br>
<br>
</body><html>"}
		usr<<output(QuestText,"QuestLog.questinfo")
/*		if(IsMasterQuest)
			//usr<<"Assigned to: [PeopleAssigned.Join(", ")]"
			//usr<<"Completed by: [PeopleCompleted.Join(", ")]"
			if(usr.Confirm("Give this quest to someone?"))
				var/list/Ps=list()
				for(var/mob/player/P in oview(usr))
					Ps+=P
					for(var/obj/Quest/Q in P) if(Q.QuestName==QuestName) Ps-=P
				Ps+="Cancel"
				var/mob/C=input("Give this quest to who?") in Ps
				if(C=="Cancel") return
				var/obj/Quest/A=new
				A.QuestGiverKey=usr.key
				A.QuestGiverName=usr.name
				A.QuestDate=YearOutput()
				A.QuestName=QuestName
				A.QuestDescription=QuestDescription
				A.QuestObjective=QuestObjective
				A.QuestFailure=QuestFailure
				A.QuestReward=QuestReward
				A.name="[QuestName] (Quest)"
				A.suffix=A.Status
				C.contents+=A
				C.BuffOut("[usr] has assigned you [A]!")
				PeopleAssigned+="[C] ([C.key])"
			else if(usr.Confirm("Edit this quest?"))
				QuestName=input(usr,"What is the name of this quest? (Shows up as X (Quest))","Quest Name",QuestName) as text
				name="[QuestName] (Quest)"
				QuestObjective=input(usr,"What is the objective of this quest? (Shows up as Objective: X)","Objective",QuestObjective) as text
				QuestFailure=input(usr,"What is the failure condition of this quest? (Shows up as Failure: X)","Failure",QuestFailure) as text
				QuestReward=input(usr,"What is the reward of this quest? (Shows up as Reward: X)","Reward",QuestReward) as text
				QuestDescription=input(usr,"What is the description of this quest? (Shows up as X at the bottom of the quest entry)","Description",QuestDescription) as message*/
	verb/Alter_Quest()
		set src in usr
		if(IsMasterQuest) if(usr.Confirm("Edit this quest?"))
			QuestName=input(usr,"What is the name of this quest? (Shows up as X (Quest))","Quest Name",QuestName) as text
			name="[QuestName] (Quest)"
			QuestObjective=input(usr,"What is the objective of this quest? (Shows up as Objective: X)","Objective",QuestObjective) as text
			QuestFailure=input(usr,"What is the failure condition of this quest? (Shows up as Failure: X)","Failure",QuestFailure) as text
			QuestReward=input(usr,"What is the reward of this quest? (Shows up as Reward: X)","Reward",QuestReward) as text
			QuestDescription=input(usr,"What is the description of this quest? (Shows up as X at the bottom of the quest entry)","Description",QuestDescription) as message
	verb/Assign_Quest()
		set src in usr
		if(IsMasterQuest) if(usr.Confirm("Give this quest to someone?"))
			var/list/Ps=list()
			for(var/mob/player/P in oview(usr))
				Ps+=P
				for(var/obj/Quest/Q in P) if(Q.QuestName==QuestName) Ps-=P
			Ps+="Cancel"
			var/mob/C=input("Give this quest to who?") in Ps
			if(C=="Cancel") return
			var/obj/Quest/A=new
			A.QuestGiverKey=usr.key
			A.QuestGiverName=usr.name
			A.QuestDate=YearOutput()
			A.QuestName=QuestName
			A.QuestDescription=QuestDescription
			A.QuestObjective=QuestObjective
			A.QuestFailure=QuestFailure
			A.QuestReward=QuestReward
			A.name="[QuestName] (Quest)"
			A.suffix=A.Status
			C.contents+=A
			C.BuffOut("[usr] has assigned you [A]!")
			PeopleAssigned+="[C] ([C.key])"
	verb/Complete_Quest()
		set src in usr
		var/list/L=list()
		for(var/mob/player/P in oview(usr)) if(P.key==QuestGiverKey) L+=P
		L+="Cancel"
		var/mob/C=input("Turn [src] into who?") in L
		if(C=="Cancel") return
		usr.QuestCompletion(src,usr,C)
	verb/Abandon_Quest()
		set src in usr
		if(usr.Confirm("Abandon [src]? You will need to speak to the quest giver to get it back.")) del(src)
mob/proc/QuestCompletion(obj/Quest/quest,mob/quester,mob/questgiver)
	var/QC=input(questgiver,"[quester] is requesting that you mark [quest] completed. Do you wish to do so?") in list("Yes","No")
	if(QC=="Yes")
		quest.Status="Complete"
		quest.suffix=quest.Status
		quester.BuffOut("You have completed [quest]!")
		questgiver.BuffOut("You have completed [quester]'s [quest]!")
		for(var/obj/Quest/QQ in questgiver) if(QQ.QuestName==quest.QuestName) QQ.PeopleCompleted+="[quester.name] ([quester.key])"
		