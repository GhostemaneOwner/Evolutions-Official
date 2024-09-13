//New Activities Coding by Tenkichi
		

mob/var/GotQuest=75
mob/var/RerollQuest=76
mob/var/tmp/InReroll=0

var/list/QuestList

world/New()
	QuestList = typesof(/Activity) - /Activity

mob/proc/GetQuest(reroll=0,Activity/OldAct)
	if(reroll)
		sleep(5)
		lab3
		var/gettype=pick(QuestList)
		if(gettype==OldAct.type) goto lab3
		if(gettype==/Activity/Mana3) if(Magic_Potential<2) goto lab3
		if(gettype==/Activity/Loot3) if(Int_Mod<2) goto lab3
		if(gettype==/Activity/Teach5) if(!Rank) goto lab3
		if(gettype==/Activity/Learn3) if(Rank) goto lab3
		src.contents+=new gettype(src)
		return
	RerollQuest-=1.5
	GotQuest--
	for(var/Activity/A in src) if(istype(A,/Activity)) if(A)
		A.Lifetime--
		if(A.Lifetime<=9000) if(prob(5)) if(prob(5)) if(prob(2)) src<<"[A] is going to expire soon..."
		if(A.Lifetime<=0)
			src<<"[A] has expired."
			del(A)
	if(RerollQuest<0) RerollQuest=0
	if(GotQuest<0) GotQuest=0
	if(src.GotQuest<=0)
		lab1
		var/gettype=pick(QuestList)
		//if(gettype==/Activity/MasterSkill) for(var/Skill/Attacks/A in src) if(A.Experience<80) goto lab1
		if(gettype==/Activity/Mana3) if(Magic_Potential<2) goto lab1
		if(gettype==/Activity/Loot3) if(Int_Mod<2) goto lab1
		if(gettype==/Activity/Teach5) if(!Rank) goto lab1
		if(gettype==/Activity/Learn3) if(Rank) goto lab1
		src.contents+=new gettype(src)
		lab2
		var/gettype2=pick(QuestList)
		//if(gettype2==/Activity/MasterSkill) for(var/Skill/Attacks/A in src) if(A.Experience<2) goto lab2
		if(gettype2==/Activity/Mana3) if(Magic_Potential<2) goto lab2
		if(gettype2==/Activity/Loot3) if(Int_Mod<2) goto lab2
		if(gettype==/Activity/Teach5) if(!Rank) goto lab2
		if(gettype==/Activity/Learn3) if(Rank) goto lab2
		src.contents+=new gettype2(src)
		src.GotQuest=36000
		src<<"New Activities Added!"




Activity
	parent_type=/obj
	Savable=1
	var/Lifetime=88000
	var/ownerkey
	var/Type
	var/Subtype
	var/Title
	var/Description
	var/Progress=0
	var/TT=null
	var/RLevel=1
	var/Rewards
	var/Requirement
	var/Rewarded
	var/list/Tracker=list()
	New(mob/owner)
		name="([Type] : [time2text(world.realtime,"Day")]) [Title]"
		..()
	Click()
		if(isnum(Requirement))
			var/out={"<html><head><title>[Type]</title><body>
		<body bgcolor="#000000"><font size=2><font color="#0099FF"><b>
		<br>(Level [Level] ) (Type [Subtype] )<br>
		Title: [Title]<br>
		Remaining Time: [round(Lifetime/60/60)] Hours Remaining<br>
		Progress: [round(Progress/Requirement,0.001)*100]%<br>
		Description: [Description]<br>
		</body></html>"}
			usr<<browse(out,"window=Quest;size=350x300")
		//src.CheckProgress(src.Progress,0,usr)
	//	if(usr.Confirm("Check [src] progress?")) src.CheckProgress(src.Progress,0,usr)

	verb/Reroll_Activity()
		set category="Other"
		set src in usr
		if(usr.InReroll) return
		if(usr.RerollQuest>0)
			usr<<"You must wait longer before rerolling another activity. ([usr.RerollQuest/1.5/60] Minutes)"
			return
		if(Rewarded) return
		if(Progress>=Requirement) return
		usr.InReroll=1
		if(usr.Confirm("Reroll [src] for another random activity?"))
			usr.RerollQuest=6000
			usr.GetQuest(1,src)
			spawn(1) usr.InReroll=0
			spawn(1) del(src)
		usr.InReroll=0


	proc/CheckProgress(prog=0,valid=0,mob/use)
		if(Requirement=="Unset")
			if(istype(src,/Activity/MedianBP))
				var/AverageBP
				var/Player_Count
				for(var/mob/player/B in Players)
					Player_Count++
					AverageBP+=B.Base
				if(Player_Count<1) Player_Count=1
				if(!AverageBP) AverageBP=500
				AverageBP/=Player_Count
				if(AverageBP==use.Base) AverageBP*=1.3
				Requirement=AverageBP
			if(istype(src,/Activity/BP30)) Requirement=use.Base*1.3
			if(istype(src,/Activity/BP300)) Requirement=use.Base*2
			if(istype(src,/Activity/MedianEnergy))
				var/AverageEN
				var/Player_Count
				for(var/mob/player/B in Players)
					Player_Count++
					AverageEN+=B.MaxKi/B.KiMod
				if(Player_Count<1) Player_Count=1
				if(!AverageEN) AverageEN=500
				AverageEN/=Player_Count
				if(AverageEN==use.MaxKi/use.KiMod) AverageEN*=1.3
				Requirement=AverageEN*use.KiMod
			if(istype(src,/Activity/Energy30)) Requirement=use.MaxKi*1.3
			if(istype(src,/Activity/Energy300)) Requirement=use.MaxKi*1.5
		if(valid&&valid!=0) if(Subtype!="Social") if(Subtype!="Language") if(Subtype!="Teach") if(Subtype!="Learn")
			if(valid in Tracker) return
			Tracker+=valid
		if(Rewarded) del(src)
		if(prog>0)
			if(Subtype=="Training"||Subtype=="Energy") Progress=prog
			if(Subtype=="Social") if(valid==TT) Progress=prog
			if(Subtype=="Language") if(valid==TT) Progress=prog
			if(Subtype=="Economy"||Subtype=="Mana"||Subtype=="Spar"||Subtype=="KO"||Subtype=="Teach"||Subtype=="Learn"||Subtype=="RP")
				Progress+=prog
				return
		if(Subtype=="Power")
			if(Requirement==1)
				if(use.BPRank<10) Progress=1
				if(use.StatRank<10) Progress=1
			if(Requirement==30)
				if(use.BPRank<35) Progress=30
				if(use.StatRank<35) Progress=30
			if(Requirement==50)
				if(use.BPRank<55) Progress=50
				if(use.StatRank<55) Progress=50
		if(Progress>=Requirement) if(!Rewarded)
			Rewarded=1

			del(src)


Activity

	RP1
		Type="Daily"
		Subtype="RP"
		Title="RP with 3 People"
		Description="Find and RP with atleast 3 people."
		Level=1
		Rewards=list("BP","Energy")
		Requirement=3
	RP2
		Type="Daily"
		Subtype="RP"
		Title="RP with 5 People"
		Description="Find and RP with atleast 5 people."
		Level=2
		Rewards=list("BP","Energy")
		Requirement=5
	RP3
		Type="Daily"
		Subtype="RP"
		Title="RP with 9 People"
		Description="Find and RP with atleast 9 people. (Daily +)"
		Level=3
		Rewards=list("BP","Energy","Skills")
		Lifetime=264000
		Requirement=9
	RP4
		Type="Weekly"
		Subtype="RP"
		Title="RP with 15 People"
		Description="Find and RP with atleast 15 people."
		Level=5
		Lifetime=924000
		Rewards=list("BP","Energy","Skills")
		Requirement=15

	Spar1
		Type="Daily"
		Subtype="Spar"
		Title="Spar 3 People"
		Description="IC spar three other people."
		Level=1
		Rewards=list("Items","Energy")
		Requirement=3
		//icon=Fist x 1
	Spar2
		Type="Daily"
		Subtype="Spar"
		Title="Spar 4 People"
		Description="IC spar four other people."
		Level=2
		Rewards=list("Items","Energy")
		Requirement=4
		//icon=Fist x 2
	Spar3
		Type="Weekly"
		Subtype="Spar"
		Title="Spar 10 People"
		Description="IC spar ten other people."
		Level=4
		Rewards=list("BP","Energy","Skills")
		Lifetime=924000
		Requirement=10

	SparStrongest
		Type="Weekly"
		Subtype="Spar"
		Title="Fight the Worlds Strongest"
		Description="Locate and spar/fight the strongest person."
		Level=5
		Rewards=list("BP","Energy","Skills")
		Requirement=1
		Lifetime=924000
	SparTopTier
		Type="Weekly"
		Subtype="Spar"
		Title="Fight Three Top Tier Fighters"
		Description="Locate and spar/fight three top tier fighters."
		Level=4
		Rewards=list("BP","Energy")
		Requirement=3
		Lifetime=924000

	KO1
		Type="Daily"
		Subtype="KO"
		Title="Knockout Another Player"
		Description="Knockout another player in an IC scenario. Combat and sparring both work as well as ki and melee."
		Level=1
		Rewards=list("Items","Energy")
		Requirement=1
		//icon=Fist x 1
	KO2
		Type="Daily"
		Subtype="KO"
		Title="Knockout Three Other Players"
		Description="Knockout three other players in an IC scenario. Combat and sparring both work as well as ki and melee."
		Level=2
		Rewards=list("Items","Energy")
		Requirement=3
		//icon=Fist x 1
	KO3
		Type="Weekly"
		Subtype="KO"
		Title="Knockout Six Other Players"
		Description="Knockout six other players in an IC scenario. Combat and sparring both work as well as ki and melee."
		Level=4
		Rewards=list("Energy","Skills","Items")
		Requirement=6
		Lifetime=924000
		//icon=Fist x 1


	Loot1
		Type="Daily"
		Subtype="Economy"
		Title="Gather Ten Thousand Resources"
		Description="Gather ten thousand resources."
		Level=1
		Rewards=list("BP","Items","Energy")
		Requirement=10000
	Loot2
		Type="Daily"
		Subtype="Economy"
		Title="Gather One Hundred Thousand Resources"
		Description="Gather one hundred thousand resources."
		Level=2
		Rewards=list("BP","Items","Energy")
		Requirement=100000
	Loot3
		Type="Weekly"
		Subtype="Economy"
		Title="Gather Two Million Resources"
		Description="Gather two million resources."
		Level=4
		Rewards=list("BP","Items","Energy")
		Requirement=2000000
		Lifetime=924000

	Mana1
		Type="Daily"
		Subtype="Mana"
		Title="Gather Ten Thousand Mana"
		Description="Gather ten thousand mana."
		Level=1
		Rewards=list("BP","Items","Energy")
		Requirement=10000
	Mana2
		Type="Daily"
		Subtype="Mana"
		Title="Gather One Hundred Thousand Mana"
		Description="Gather one hundred thousand mana."
		Level=2
		Rewards=list("BP","Items","Energy")
		Requirement=100000
	Mana3
		Type="Weekly"
		Subtype="Mana"
		Title="Gather Two Million Mana"
		Description="Gather two million mana."
		Level=4
		Rewards=list("BP","Items","Energy")
		Requirement=2000000
		Lifetime=924000

	MedianBP
		Type="Daily"
		Subtype="Training"
		Title="Achieve Average BP"
		Description="Increase your BP to the average for your race."
		Level=1
		Rewards=list("Energy","Skills")
		Requirement="Unset"
	BP30
		Type="Daily"
		Subtype="Training"
		Title="Gain 30% More Base BP"
		Description="Increase your Base BP by 30%. Buffs and transformations will not count."
		Level=2
		Rewards=list("Energy","Skills","Items")
		Requirement="Unset"
		//icon=Fist x 1
	BP300
		Type="Weekly"
		Subtype="Training"
		Title="Gain 100% More Base BP"
		Description="Increase your Base BP by 100%. Buffs and transformations will not count."
		Level=4
		Rewards=list("Energy","Skills")
		Requirement="Unset"
		Lifetime=924000
	MedianEnergy
		Type="Daily"
		Subtype="Energy"
		Title="Achieve Average Energy"
		Description="Increase your Energy to the average for your race."
		Level=1
		Rewards=list("BP","Items")
		Requirement="Unset"
	Energy30
		Type="Daily"
		Subtype="Energy"
		Title="Gain 30% More Base Energy"
		Description="Increase your Base Energy by 30%."
		Level=2
		Rewards=list("BP","Items")
		Requirement="Unset"
	Energy300
		Type="Weekly"
		Subtype="Energy"
		Title="Gain 150% More Base Energy"
		Description="Increase your Base Energy by 150%."
		Level=4
		Rewards=list("BP","Skills")
		Requirement="Unset"
		Lifetime=924000

	MeetSomeone
		Type="Daily"
		Subtype="Social"
		Title="Make A New Friend"
		Description="Make a new contact and increase the bond to 3."
		Level=2
		Rewards=list("Skills","Items")
		Requirement=2.9
		//icon=Fist x 1
		New(mob/owner)
			..()
			if(owner) for(var/obj/Contact/A in owner) Tracker+=A.Signature

	LoveSomeone
		Type="Weekly"
		Subtype="Social"
		Title="Make A Very Close Friend"
		Description="Increase your bond with someone to 50."
		Level=5
		Rewards=list("Items","Skills","BP")
		Requirement=50
		Lifetime=924000
		//icon=Fist x 1
		New(mob/owner)
			..()
			if(owner) for(var/obj/Contact/A in owner) if(A.familiarity>45) Tracker+=A.Signature

	SR50
		Type="Daily"
		Subtype="Power"
		Title="Achieve 50 Power Rank"
		Description="Climb halfway up either the stat or power rankings."
		Level=1
		Rewards=list("BP","Energy","Skills")
		Requirement=50
	SR30
		Type="Daily"
		Subtype="Power"
		Title="Achieve 30 Power Rank"
		Description="Climb to the top tier of the stat or power rankings."
		Level=2
		Rewards=list("BP","Energy","Skills")
		Requirement=30
	SR1
		Type="Weekly"
		Subtype="Power"
		Title="Become the Strongest"
		Description="Climb to the absolute top of the power rankings!"
		Level=5
		Rewards=list("BP","Energy")
		Requirement=1
		Lifetime=924000

	Lan1
		Type="Daily"
		Subtype="Language"
		Title="Learn a Language"
		Description="Become 60% fluent in a new language! (Languages with mastery above 30% are excluded.)"
		Level=2
		Rewards=list("BP","Energy","Skills")
		Requirement=60
		New(mob/owner)
			..()
			if(owner) for(var/Language/A in owner) if(A.Mastery>30) Tracker+=A.name

	Lan3
		Type="Weekly"
		Subtype="Language"
		Title="Learn a Language"
		Description="Become 100% fluent in a new language! (Languages with mastery above 75% are excluded.)"
		Level=3
		Rewards=list("BP","Energy","Skills")
		Requirement=100
		Lifetime=924000
		New(mob/owner)
			..()
			if(owner) for(var/Language/A in owner) if(A.Mastery>75) Tracker+=A.name

	Teach1
		Type="Daily"
		Subtype="Teach"
		Title="Teach a Skill"
		Description="IC teach someone a skill."
		Level=2
		Rewards=list("BP","Energy","Skills")
		Requirement=1
	Teach3
		Type="Daily"
		Subtype="Teach"
		Title="Teach 2 Skills"
		Description="IC teach a total of two skills. (Same skill to multiple people counts)"
		Level=3
		Rewards=list("BP","Energy","Skills")
		Requirement=2
	Teach5
		Type="Weekly"
		Subtype="Teach"
		Title="Teach 4 Skills"
		Description="IC teach a total of four skills. (Same skill to multiple people counts)"
		Level=4
		Rewards=list("BP","Energy")
		Requirement=4
		Lifetime=924000

	Learn1
		Type="Daily"
		Subtype="Learn"
		Title="Learn a Skill"
		Description="Learn a skill IC."
		Level=2
		Rewards=list("BP","Energy")
		Requirement=1
	Learn2
		Type="Daily"
		Subtype="Learn"
		Title="Learn 2 Skills"
		Description="Learn a total of two skills IC. (Daily +)"
		Level=3
		Rewards=list("BP","Energy")
		Requirement=2
		Lifetime=264000
	Learn3
		Type="Weekly"
		Subtype="Learn"
		Title="Learn 3 Skills"
		Description="Learn a total of three skills IC."
		Level=4
		Rewards=list("BP","Energy")
		Requirement=3
		Lifetime=924000
		
