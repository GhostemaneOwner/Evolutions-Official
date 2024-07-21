



mob/proc/GetLanguage()
//Gives each race the language loadout.
	switch(Race)
		if("Android" || "Bio-Android")
			contents+=new/Language/Machine(100,src)
			contents+=new/Language/Common(100,src)
		if("Human")
			contents+=new/Language/English(100,src)
		if("Puar")
			contents+=new/Language/English(100,src)
		if("Demigod")
			contents+=new/Language/Common(100,src)
			contents+=new/Language/Old_Tongue(100,src)
		if("Makyojin")
			contents+=new/Language/Demonic(100,src)
			contents+=new/Language/English(100,src)
		if("Shinjin")
			contents+=new/Language/Old_Tongue(100,src)
			contents+=new/Language/Kaio(100,src)
		if("Spirit Doll")
			contents+=new/Language/Common(100,src)
		if("Tuffle")
			contents+=new/Language/Saiyan(100,src)
			contents+=new/Language/Tuffle(100,src)
		if("Namekian")
			contents+=new/Language/Namekian(100,src)
			contents+=new/Language/Common(100,src)
		if("Saiyan")
			contents+=new/Language/Saiyan(100,src)
		if("Changeling")
			contents+=new/Language/Changeling(100,src)
			contents+=new/Language/Saiyan(100,src)
		if("Demon")
			contents+=new/Language/Demonic(100,src)
			contents+=new/Language/Old_Tongue(100,src)
		if("Oni")
			contents+=new/Language/Common(100,src)
			contents+=new/Language/Old_Tongue(100,src)
		if("Heran")
			contents+=new/Language/Heran(100,src)
		if("Yardrat")
			contents+=new/Language/Yardrat(100,src)
			contents+=new/Language/Tuffle(100,src)
		if("Konatsian")
			contents+=new/Language/Heran(100,src)
			contents+=new/Language/Arconian(100,src)
		if("Alien")
			contents+=new/Language/Arconian(100,src)
			contents+=new/Language/Common(100,src)
		if("Saibaman")
			contents+=new/Language/Common(100,src)
		if("Primal Ape")
			contents+=new/Language/Common(100,src)
		if("Cerealian")
			contents+= new/Language/Common(100,src)
		if("Heeter")
			contents+= new/Language/Common(100,src)
		if("Greys")
			contents+= new/Language/Common(100,src)
		if("Kanassan")
			contents+= new/Language/Common(100,src)
		if("Majin")
			contents+= new/Language/Common(100,src)
		if("Dragon")
			contents+= new/Language/Common(100,src)

mob/proc/Android(sizing=0)
	RaceDescription={"-Androids-
Androids are mechanical beings with great potential. Their skill is more so determined by their ability to gather and consume component chips. With the right amount of technological support, they can be a dominant force in the universe. They are created by skilled scientists.

"}
	if(!sizing)
//		Potential=0
		undelayed=1
		Sterile=1
		Int_Mod=2
		Magic_Potential = 1
		Decline=100
		InclineAge=0
		HPDoesNotAffectBP = 1
		ZanzoMod=2
		Zanzoken=500
		FlyMod=5
		FlySkill=50
		GravMastered=20
		Zenkai=1
		MedMod=1
		Race="Android"
		BaseMaxKi=100
		Age=1
		IgnoresGodKi=1
		BreathInSpace=1
		contents+=new/Skill/Misc/Absorb_Android
		GeneticLearnList=AndroidLearnList

	BPMod=2.3
	FBMMult=2
	AscensionMult=1.5
	BaseMaxAnger=100
	KiMod=3
	StrMod=1.3
	EndMod=1.3
	SpdMod=1.3
	OffMod=1.3
	DefMod=1.3
	BaseRegeneration=1.5
	BaseRecovery=2.8


	Android_Advancement()
	if(!sizing&&!HasCreated)
		var/list/Androids = new
		var/GiveChoice = 0
		for(var/obj/items/Android_Chassis/A)
			if(A.z)
				Androids += A
				GiveChoice = 1
		if(!GiveChoice)
			src<<"There are no available Chasis to choose from, please choose a different race."
			del(src)
			return
		if(GiveChoice)
			Androids+="Cancel"
			var/obj/choice = input("Choose an Android to activate.","Android Activation") in Androids
			switch(choice)
				if("Cancel")
					BackChar()
					/*del(src)
					return*/
				else
					if(!src.Confirm("This Android was made by [choice.Builder]. Continue?"))
						del(src)
						return
					if(choice.Password)
						var/PA=input(src,"[choice] Password","New Character",null)
						if(PA!=choice.Password)
							if(src)
								var/mob/player/A = new
								A.key = key
								A = src
								del(src)
					var/obj/items/Android_Chassis/O = choice
					src.loc = O.loc
					src.Builder=O.Builder
					src.name = O.name
					view(8,src) << "[O.name] activates."
					view(8,src) << "[O] says: Systems online..."
					src.Delete = O
					var/FreeUps=5
					while(FreeUps>0)
						var/obj/items/Android_Upgrade/AU=new
						contents+=AU
						FreeUps--


/*
Absorb cost money and cyberize grants it.
*/

mob/proc/Android_Advancement() for(var/mob/player/A in Players) if(A.AS_Droid)
	if(A.Int_Level>Int_Level)
		Int_Level=A.Int_Level
		Int_XP=A.Int_XP
		Int_Next=A.Int_Next
	if(A.Base*0.5>Base)
		Base+=A.Base*0.25
	//Offspring=1
	if(A.GainMultiplier>GainMultiplier) GainMultiplier=A.GainMultiplier
	src<<"The Android Ship has learned from her past mistakes and made you all the more powerful."



mob/proc/Child(sizing=0)
	RaceDescription={"-Child-
TBD
"}
	if(!sizing)//intense powerhouse

		//Race Unique
		//Race = "Dragon"
		//HPDoesNotAffectBP = 1
		//Immortal = 1
		//RacialPowerAdd = 400
		//AlignmentNumber = 2
		//Alignment = "Justice"

		//Int or Wis
		Int_Mod = 1
		Magic_Potential = 1

		//Age
		InclineAge = 10
		Decline = 30

		//Utility Mods
		ZanzoMod = 1
		FlyMod = 1
		FlySkill = 1
		Zenkai = 1
		MedMod = 1
		GravMastered = 1

		//Contents, Learnlists
		//GeneticLearnList = DragonLearnList


	//Stat Mods
	BPMod = 1
	FBMMult = 1
	BaseMaxAnger = 100
	AscensionMult = 1
	KiMod = 1
	StrMod = 1
	EndMod = 1
	SpdMod = 1
	OffMod = 1
	DefMod = 1
	BaseRegeneration = 1
	BaseRecovery = 1

mob/proc/Human(sizing=0)//

	RaceDescription={"-Human-
Humans make up the majority of the population on Earth. Versatile, intelligent and curious, they are capable of being adaptive to any environment they find themselves in. Having recently come out of the last dark era, they are attempting to rebuild their world and decide what they should do with, if anything, their new neighbours. Some Humans are incredibly xenophobic and are willing to go to great lengths to reclaim their world as their own. Others, however, are curious about these relative newcomers and may try to befriend them. Further still, having been scarred so heavily by the overuse of Magic, Technology has become a focus for some, in an effort to not repeat the mistakes of the past.
"}

	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Decline=45
		ZanzoMod=1.5
		FlyMod=1.3
		BaseMaxKi=20
		Zenkai=3
		MedMod=2
		Race="Human"
		GravMastered=1
		GeneticLearnList=HumanLearnList

	BPMod=1.9
	FBMMult=2.35
	AscensionMult=1
	BaseMaxAnger=140
	KiMod=2
	StrMod=2
	EndMod=2
	SpdMod=2.1
//	ResMod=2
	OffMod=2.1
	DefMod=2.1
	BaseRegeneration=2
	BaseRecovery=2.3

mob/proc/Triclops(sizing=0)
	RaceDescription={"-Human-
Born with a rare literal Third eye, you are a Triclops capable of managing your spiritual Third Eye more adeptly than any other human.
"}
	if(!sizing)//Similar to human but with a third eye

		//Race Unique
		Race = "Human"
		Class = "Triclop"
		RacialPowerAdd = 10
		BaseMaxKi = 20


		//Int or Wis
		Int_Mod = 1
		Magic_Potential = 1

		//Age
		InclineAge = 16
		Decline = 35

		//Utility Mods
		ZanzoMod = 1.5
		FlyMod = 1.3
		FlySkill = 2
		Zenkai = 3
		MedMod = 2.1
		GravMastered = 1

		//Contents, Learnlists
		GeneticLearnList = HumanLearnList


	//Stat Mods
	BPMod=1.9
	FBMMult=2.35
	AscensionMult=1
	BaseMaxAnger=140
	KiMod=2
	StrMod=2
	EndMod=2
	SpdMod=2.1
//	ResMod=2
	OffMod=2.1
	DefMod=2.1
	BaseRegeneration=2
	BaseRecovery=2.3

mob/proc/Adam(sizing=0)
	RaceDescription={"-Human-
Adama the first human of a GOD that made them in their image. Beyond all other humans.
"}
	if(!sizing)//Similar to human but with GODs Human

		//Race Unique
		Race = "Human"
		Class = "Adamus"
		RacialPowerAdd = 100
		BaseMaxKi = 200


		//Int or Wis
		Int_Mod = 1.5
		Magic_Potential = 1

		//Age
		InclineAge = 6
		Decline = 100

		//Utility Mods
		ZanzoMod = 1.5
		FlyMod = 1.3
		FlySkill = 2
		Zenkai = 3
		MedMod = 2.1
		GravMastered = 1

		//Contents, Learnlists
		GeneticLearnList = HumanLearnList


	//Stat Mods
	BPMod = 2.2
	FBMMult=2.55
	AscensionMult=1.5
	BaseMaxAnger=120
	KiMod=2
	StrMod=2.1
	EndMod=2.1
	SpdMod=2.1
	OffMod=2.2
	DefMod=2.2
	BaseRegeneration=2.1
	BaseRecovery=2.3


mob/proc/Demigod(sizing=0) //
	RaceDescription={"-Demi-Gods-
Born from the Union of the Pure Beings of Chaos (Demons) or the Beings of Order (Kaios) between a normal Mortal race. Demi-gods generally will draw their power from the many Elder Beings above this realm, drawing energies from the realms beyond to empower their own body and their own history. These beings are generally referred to as Gods, Kaioshins, Lords of Hell, and many other names were from Dynasties of the past. These Dynasties of past beings are often referred to as “Pantheons”
"}
	if(!sizing)
		Magic_Potential=1
		InclineAge=16
		Decline=45
		ZanzoMod=1
		FlyMod=2
		BaseMaxKi=50
		MedMod=2
		Race="Demigod"
		GravMastered=10
		//Sterile=1

		GeneticLearnList=DemiLearnList
		RacialPowerAdd=150

	BPMod=2.4
	FBMMult=2
	AscensionMult=1
	BaseMaxAnger=130
	KiMod=2
	StrMod=2
	EndMod=1.9
	SpdMod=1.9
	OffMod=2
	DefMod=2
	BaseRegeneration=2
	BaseRecovery=2

mob/proc/Makyojin(sizing=0) //17.3 anger, expand, fbm
	RaceDescription={"-Makyojin-
Having recently  came into existance, they find themselves lost between worlds with nowhere to really call home. Most Makyojin resent Humanity for bringing them into this world, some are happy to be given the chance to find their own path. Being Eldritch in origin and powerful fighters, they aren't trusted, but after gaining sentience after the rift was closed some were able to organize a ceasefire. This is a short lived peace period for most Makyojin as they begin amassing their strength, if in the event they are pushed too far, and decide to take their new home by force.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1.5
		InclineAge=16
		Decline=45
		FlySkill=4
		BaseMaxKi=60
		Zenkai=5
		MedMod=2
		FlyMod=1.3
		ZanzoMod=1.2
		Race="Makyojin"
		GravMastered=10

		GeneticLearnList=MakyoLearnList
		/*AlignmentNumber=-2
		Alignment="Evil"*/
		RacialPowerAdd=50

	BPMod=2.2
	FBMMult=2
	AscensionMult=1.15
	BaseMaxAnger=150
	KiMod=2
	StrMod=2
	EndMod=2
	SpdMod=1.8
	OffMod=1.8
	DefMod=1.7
	BaseRegeneration=2
	BaseRecovery=2.5


mob/proc/Shinjin(sizing=0)//
	RaceDescription={"-Kaios-
Among the first beings to arise in the universe, they were born from an unknown power. Often appearing angelic, beautiful and graceful, nonetheless they were created for only one purpose, to bring order to the universe by whatever means at their disposal. Whether this means bringing about order through kindness, cooperation and benevolent acts, or crushing dissent with an iron rule, their primary concern is order, bringing law and justice for those under their influence. Traditionally considering Heaven to be their home, some might consider the rules and laws there to be restrictive, sometimes even to the point of being tyrannical in their pursuit of perfect order.
Good is not required, they are beings of order first.
"}

	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=18
		Decline=60
		ZanzoMod=2
		Zanzoken=25
		FlyMod=2
		FlySkill=2
		BaseMaxKi=70
		Zenkai=2.5
		MedMod=3
		Race="Shinjin"
		BreathInSpace=1
		GravMastered=10
		GeneticLearnList=ShinjinLearnList
		contents+=new/obj/Potara_Earrings
		AlignmentNumber=5
		Alignment="Good"
//		Sterile=1
		RacialPowerAdd=250
//		Asexual=1
	BPMod=2.5
	FBMMult=2
	AscensionMult=1
	BaseMaxAnger=130
	KiMod=3
	StrMod=1.8
	EndMod=1.8
	SpdMod=2
	OffMod=1.7
	DefMod=2
	BaseRegeneration=2
	BaseRecovery=2.6


mob/proc/Doll(sizing=0) //
	RaceDescription={"-Spirit Doll-
These curious things are constructs of pure magic, typically created by a skilled mage.
"}
	if(!sizing)
		//Asexual=1
		Sterile=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=45
		InclineAge=6
		Sterile=1
		ZanzoMod=2
		FlyMod=2
		BaseMaxKi=50
		BreathInSpace=1
		contents+=new/Skill/Support/Telekinesis
		//contents+=new/Skill/Buff/Ki_Force
		src.TK = 1
		MedMod=2
		Race="Spirit Doll"

		GeneticLearnList=DollLearnList

	BPMod=1.9
	FBMMult=2
	AscensionMult=1.2
	BaseMaxAnger=130
	KiMod=3
	StrMod=1.9
	EndMod=1.9
	SpdMod=2
	OffMod=2.2
	DefMod=2.2
	BaseRegeneration=2
	BaseRecovery=3
	if(!sizing&&!HasCreated)
		var/list/Dolls = new
		var/GiveChoice = 0
		for(var/obj/items/Enchanted_Doll/ED in world)
			if(ED.invisibility <= 0)
				Dolls += ED
				GiveChoice = 1
		if(!GiveChoice)
			src<<"There are no available Dolls to choose from, please choose a different race."
			del(src)
			return
		if(GiveChoice)
			Dolls+="Cancel"
			var/obj/choice = input("Choose a Doll to activate.","Spirit Doll Activation") in Dolls
			switch(choice)
				if("Cancel")
					BackChar()
				else
					if(!src.Confirm("This Spirit Doll was made by [choice.Builder]. Continue?"))
						del(src)
						return
					if(choice.Password)
						var/PA=input(src,"[choice] Password","New Character",null)
						if(PA!=choice.Password)
							if(src)
								var/mob/player/A = new
								A.key = key
								A = src
								del(src)
					var/obj/items/Enchanted_Doll/O = choice
					src.loc = O.loc
					src.Builder=O.Builder
					src.name = O.name
					view(8,src) << "[O.name] awakens."
					src.Delete = O


mob/proc/Tuffle(sizing=0) //
	RaceDescription={"-Tuffles-

An indigenous humanoid race that coexisted with the Saiyans, but their relationship has been tumultuous over the years, marked by both conflict and peace. However, this race has contributed greatly to the planet's technological progress, earning them the reputation as the most intelligent species in the galaxy.

The Tsufurujin race had a reputation for being resourceful and intellectual, but unfortunately, this reputation ultimately led to their downfall. The Outsiders arrived and quickly took over the planet, subjugating the Saiyans over decades of brutality. In an effort to avoid the same fate as their previous leaders, the Tsufurujin submitted to the Outsiders. However, they had a hidden motive. Some saw this as an opportunity to overthrow the Outsiders and dismiss the Saiyan race as rulers of the planet. Others believed that it was a chance for the Saiyans and Tsufurujin to combine their strengths and overcome this overwhelming force, leading to an era of prosperity between them both. Nowadays, Tsufurujin are often split one of three ways, aiding the Tyrant, aiding some Saiyans with rumors of rebellion, or simply keeping to themselves.
"}
	if(!sizing)
		Int_Mod=2
		Magic_Potential = 1
		Decline=45
		InclineAge=16
		ZanzoMod=2
		FlyMod=1.5
		BaseMaxKi=20
		Zenkai=5
		MedMod=2
		Race="Tuffle"
		GravMastered=10
//		HasSuperTuffle=0

		GeneticLearnList=TuffleLearnList
		RacialPowerAdd=50

	BPMod=2.1
	FBMMult=2
	AscensionMult=1.2
	BaseMaxAnger=140
	KiMod=2.2
	StrMod=1.9
	EndMod=1.9
	SpdMod=2
	OffMod=2
	DefMod=2
	BaseRegeneration=2
	BaseRecovery=2


mob/proc/Namekian(sizing=0) //
	RaceDescription={"-Namekian-
Spiritual beings who are taken care of by their Mother Namek and Father Porunga. They strive to protect their world and those within it from harm and outsiders. They can produce fierce warriors and wise strategists. It would be unusual to see a Namekian make the first move in a conflict, but they would defend their interests with a ferocity unseen in other races.
"}

	if(!sizing)
		Asexual=1
		Magic_Potential = 1
		Int_Mod=1
		InclineAge=8
		Decline=60
		BaseMaxKi=50
		ZanzoMod=2
		Zanzoken=1
		FlyMod=2
		FlySkill=10
		Zenkai=2.5
		MedMod=2.5
		Race="Namekian"
		Class="Undefined Class"
		GravMastered=2
		contents+=new/Skill/Support/Counterpart
		GeneticLearnList=NamekianLearnList
		CanLimbRegen=1
		RacialPowerAdd=40
//		SNjAt=600000

	BPMod=2.1
	FBMMult=2
	AscensionMult=1.16
	BaseMaxAnger=130
	KiMod=3
	StrMod=2
	EndMod=1.8
	SpdMod=2.2
	OffMod=2
	DefMod=2
	BaseRegeneration=4
	BaseRecovery=2.2


mob/proc/AncientNamekian(sizing=0) //
	RaceDescription={"-Ancient Namekian-
Ancient Namekians are a very dark and evil race.
"}

	if(!sizing)
		Asexual=1
		Magic_Potential = 2
		Int_Mod=1
		InclineAge=8
		Decline=60
		BaseMaxKi=150
		ZanzoMod=2
		Zanzoken=1
		FlyMod=2
		FlySkill=10
		Zenkai=5
		MedMod=2.5
		Race="Namekian"
		Class="Ancient"
		GravMastered=5
		//contents+=new/Skill/Support/Counterpart
		GeneticLearnList=AncientNamekianLearnList
		CanLimbRegen=1
		RacialPowerAdd=50
		contents+=new/Skill/Buff/Ancient_Form

//		SNjAt=600000

	BPMod=2.3
	FBMMult=2
	AscensionMult=1
	BaseMaxAnger=130
	KiMod=3
	StrMod=2
	EndMod=2.2
	SpdMod=1.8
	OffMod=2
	DefMod=1.5
	BaseRegeneration=4
	BaseRecovery=1.8


mob/proc/Low(sizing=0) //
	RaceDescription={"-Saiyan-
A warrior race that once took pride in their existence, and used to rule their planet with an iron fist. They had many names, 'Sun Warriors,' 'Moon Beasts.' They were known for their refined and spiritual culture and last but not least, their physical prowess, making them the apex of Sadala. However, centuries of prosperity weakened their abilities, causing them to lose the golden touch that once set them apart from other coexisting races—leaving them at the mercy of the Outsiders.

When the Outsiders came, they took everything away from them: their many names, homes, and lives- But the one thing a Saiyan always keeps is their pride - or so they thought. Decades of being beaten down, being bred for loyalty and extreme mental manipulation and fatigue have made them a mere shadow of their grandparents and elders. However, not all hope is lost, some still retain that burning desire to fight against seemingly impossible odds and that could very welll bring about a Second Golden Era.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Race="Saiyan"
		Class="Low"
		Decline=45
		ZanzoMod=1.2
//		if(FindSaiyanBP()<9) RacialPowerAdd = rand(500,750)
//		else if(FindSaiyanBP()<=35) RacialPowerAdd = rand(100,250)
//		else RacialPowerAdd = 0
		BaseMaxKi=40
		FlyMod=1.5
		Zenkai=10
		MedMod=2
		GravMastered=15
		RacialPowerAdd=rand(25,100)
		SSjMult=1.5
		SSj2Mult=1.3
		GeneticLearnList=SaiyanLearnList
	BPMod=2.2
	FBMMult=1.6
	AscensionMult=1.05
	BaseMaxAnger=160
	KiMod=1.8
	StrMod=1.8
	EndMod=1.8
	SpdMod=1.8
	OffMod=1.8
	DefMod=1.8
	BaseRegeneration=2
	BaseRecovery=1.8

mob/proc/GetChangieTrans() if(Race=="Changeling")
	if(Class=="Undefined Class")
		Form2Mult = 1.2
		Form3Mult = 1.2
		Form4Mult = 1.2
	if(Class=="Frieza")
		Form2Mult = 1.2
		Form3Mult = 1.55
		Form4Mult = 1.85
		Form7Mult = 2
	if(Class=="Cooler")
		Form2Mult=1.35
		Form3Mult=1.55
		Form4Mult=1.85
		Form5Mult=2
	if(Class=="King Kold")
		Form2Mult=1.6
	MaxHealth=110
	Health=MaxHealth


mob/proc/Changeling(sizing=0) //
	RaceDescription={"-Changeling-
A mutated variant of a mysterious alien race originates from Ice-7770, an enigmatic planet that is observed by many other worlds due to its ominous atmosphere. Although it is known for its harsh and incredible conditions, life still managed to survive there.

The inhabitants of this world have impressively adapted to their climate, becoming powerful beings without any formal training. Once enough time had passed, the world became civilized, and eventually, a tyrannical ruler had risen from the race of lizard-like beings, and ruled with unquestionable authority.  Being at such a level of power, with such little effort at that, the ruler at this time decided that they were un-matched and set out to conquer the stars, hoping to dominate worlds beyond just their own planet.

Their attention turned to a world they had only heard about in rumour, from those who had escaped from conflicts - Sadala. Upon this world resided a warrior race known by many names, though not many amongst the Changeling's cared to remember. All they seemed to really care for was exerting their dominating power over whatever world they come into contact with. Unfortunately for the residents of Sadala, they were not exempt.

The Changelings learned that of all of those they had conquered before, the Saiyan’s pride was stubborn. These warriors relished the challenge in fighting the changelings, and as such, tactics needed to change. A long game needed to be played as manipulation and oppression would lead to conquering the Saiyan pride. Cruel and unforgiving the Changelings residing on Sadala have great disdain for being isolated on this primitive world, and blame the Saiyans and their pride for your fate. Punishing those monkey-men that dare defy you has taught you that while the Saiyans enjoy the physical test, breaking their mental states is far more effective… and fun.
"}
	if(!sizing)
		Asexual=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=85
		InclineAge=10
		BaseMaxKi=200
		Race="Changeling"
		GravMastered=20
		Zanzoken=50
		ZanzoMod=1.5
		FlyMod=3
		FlySkill=4
		BreathInSpace=1
		contents+=new/Skill/Attacks/Blast
		Zenkai=5
		GeneticLearnList=ChangelingLearnList
		AlignmentNumber=-2
		Alignment="Evil"
		RacialPowerAdd=200
	BPMod=2.45
	FBMMult=1.7
	BaseMaxAnger=140
	KiMod=3
	StrMod=2
	EndMod=2.2
	SpdMod=2
	OffMod=1.8
	DefMod=1.8
	BaseRegeneration=2.5
	BaseRecovery=2.3
	AscensionMult=1


mob/proc/Cooler(sizing=0) //
	RaceDescription={"-Changeling-
A mutated variant of a mysterious alien race originates from Ice-7770, an enigmatic planet that is observed by many other worlds due to its ominous atmosphere. Although it is known for its harsh and incredible conditions, life still managed to survive there.

The inhabitants of this world have impressively adapted to their climate, becoming powerful beings without any formal training. Once enough time had passed, the world became civilized, and eventually, a tyrannical ruler had risen from the race of lizard-like beings, and ruled with unquestionable authority.  Being at such a level of power, with such little effort at that, the ruler at this time decided that they were un-matched and set out to conquer the stars, hoping to dominate worlds beyond just their own planet.

Their attention turned to a world they had only heard about in rumour, from those who had escaped from conflicts - Sadala. Upon this world resided a warrior race known by many names, though not many amongst the Changeling's cared to remember. All they seemed to really care for was exerting their dominating power over whatever world they come into contact with. Unfortunately for the residents of Sadala, they were not exempt.

The Changelings learned that of all of those they had conquered before, the Saiyan’s pride was stubborn. These warriors relished the challenge in fighting the changelings, and as such, tactics needed to change. A long game needed to be played as manipulation and oppression would lead to conquering the Saiyan pride. Cruel and unforgiving the Changelings residing on Sadala have great disdain for being isolated on this primitive world, and blame the Saiyans and their pride for your fate. Punishing those monkey-men that dare defy you has taught you that while the Saiyans enjoy the physical test, breaking their mental states is far more effective… and fun.
"}
	if(!sizing)
		Class="Cooler"
		Asexual=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=45
		InclineAge=10
		BaseMaxKi=200
		Race="Changeling"
		GravMastered=20
		Zanzoken=50
		ZanzoMod=1.5
		FlyMod=3
		FlySkill=4
		BreathInSpace=1
		contents+=new/Skill/Attacks/Blast
		Zenkai=5
		GeneticLearnList=ChangelingLearnList
		AlignmentNumber=-2
		Alignment="Evil"
		RacialPowerAdd=200
	BPMod=2.6
	FBMMult=1.55
	BaseMaxAnger=130
	KiMod=1.6
	StrMod=1.8
	EndMod=2.3
	SpdMod=1.6
	OffMod=1.7
	DefMod=1.7
	BaseRegeneration=2
	BaseRecovery=2.1
	AscensionMult=1

mob/proc/Kold(sizing=0) //
	RaceDescription={"-Changeling-
A mutated variant of a mysterious alien race originates from Ice-7770, an enigmatic planet that is observed by many other worlds due to its ominous atmosphere. Although it is known for its harsh and incredible conditions, life still managed to survive there.

The inhabitants of this world have impressively adapted to their climate, becoming powerful beings without any formal training. Once enough time had passed, the world became civilized, and eventually, a tyrannical ruler had risen from the race of lizard-like beings, and ruled with unquestionable authority.  Being at such a level of power, with such little effort at that, the ruler at this time decided that they were un-matched and set out to conquer the stars, hoping to dominate worlds beyond just their own planet.

Their attention turned to a world they had only heard about in rumour, from those who had escaped from conflicts - Sadala. Upon this world resided a warrior race known by many names, though not many amongst the Changeling's cared to remember. All they seemed to really care for was exerting their dominating power over whatever world they come into contact with. Unfortunately for the residents of Sadala, they were not exempt.

The Changelings learned that of all of those they had conquered before, the Saiyan’s pride was stubborn. These warriors relished the challenge in fighting the changelings, and as such, tactics needed to change. A long game needed to be played as manipulation and oppression would lead to conquering the Saiyan pride. Cruel and unforgiving the Changelings residing on Sadala have great disdain for being isolated on this primitive world, and blame the Saiyans and their pride for your fate. Punishing those monkey-men that dare defy you has taught you that while the Saiyans enjoy the physical test, breaking their mental states is far more effective… and fun.
"}
	if(!sizing)
		Asexual=1
		Int_Mod=1
		Magic_Potential = 1
		Decline=45
		InclineAge=10
		BaseMaxKi=200
		Race="Changeling"
		Class="King Kold"
		GravMastered=20
		Zanzoken=50
		ZanzoMod=1.5
		FlyMod=3
		FlySkill=4
		BreathInSpace=1
		Zenkai=5
		contents+=new/Skill/Attacks/Blast
		GeneticLearnList=ChangelingLearnList
		/*AlignmentNumber=-2
		Alignment="Evil"*/
		RacialPowerAdd=200
	BPMod=2.6
	FBMMult=1.8
	AscensionMult=1.1
	BaseMaxAnger=130
	KiMod=1.6
	StrMod=1.8
	EndMod=2.3
	SpdMod=1.6
	OffMod=1.7
	DefMod=1.7
	BaseRegeneration=2
	BaseRecovery=2.1

mob/proc/Frieza(sizing=0) //
	RaceDescription={"-Changeling-
A mutated variant of a mysterious alien race originates from Ice-7770, an enigmatic planet that is observed by many other worlds due to its ominous atmosphere. Although it is known for its harsh and incredible conditions, life still managed to survive there.

The inhabitants of this world have impressively adapted to their climate, becoming powerful beings without any formal training. Once enough time had passed, the world became civilized, and eventually, a tyrannical ruler had risen from the race of lizard-like beings, and ruled with unquestionable authority.  Being at such a level of power, with such little effort at that, the ruler at this time decided that they were un-matched and set out to conquer the stars, hoping to dominate worlds beyond just their own planet.

Their attention turned to a world they had only heard about in rumour, from those who had escaped from conflicts - Sadala. Upon this world resided a warrior race known by many names, though not many amongst the Changeling's cared to remember. All they seemed to really care for was exerting their dominating power over whatever world they come into contact with. Unfortunately for the residents of Sadala, they were not exempt.

The Changelings learned that of all of those they had conquered before, the Saiyan’s pride was stubborn. These warriors relished the challenge in fighting the changelings, and as such, tactics needed to change. A long game needed to be played as manipulation and oppression would lead to conquering the Saiyan pride. Cruel and unforgiving the Changelings residing on Sadala have great disdain for being isolated on this primitive world, and blame the Saiyans and their pride for your fate. Punishing those monkey-men that dare defy you has taught you that while the Saiyans enjoy the physical test, breaking their mental states is far more effective… and fun.
"}

	if(!sizing)//intense powerhouse mutant changer

		//Race Unique
		Race = "Changeling"
		Class = "Frieza"
		Asexual = 1
		BreathInSpace = 1
		BaseMaxKi = 1000
		RacialPowerAdd = 600
		AlignmentNumber = -2
		Alignment = "Selfish"

		//Int or Wis
		Int_Mod = 1
		Magic_Potential = 1

		//Age
		InclineAge = 10
		Decline = 30

		//Utility Mods
		Zanzoken = 50
		ZanzoMod = 1.5
		FlyMod = 3
		FlySkill = 4
		Zenkai = 5
		MedMod = 2.25
		GravMastered = 20

		//Contents, Learnlists
		GeneticLearnList = ChangelingLearnList


	//Stat Mods
	BPMod = 2.65
	FBMMult = 1.8
	BaseMaxAnger = 120
	AscensionMult = 1.15
	KiMod = 2.5
	StrMod = 2
	EndMod = 2.2
	SpdMod = 2
	OffMod = 1.8
	DefMod = 1.8
	BaseRegeneration = 1.8
	BaseRecovery = 1.8

mob/proc/Demon(sizing=0)//
	RaceDescription={"-Demons-
Demons, or as they are sometimes known, devils, formed out of a corruption of the Kaio vision of order, emanating from a mysterious source. They are the antithesis of the Kaio, being manifestations of chaos, with their appearances and forms varying wildly, each being expressing its own nature. Sometimes their deeds might be as small as a prank like misplacing an item, or it can be as extreme as planetary genocide. Most demons possess a large amount of chaotic energy that they channel into advancing their agendas throughout the realms, or simply instead going around causing mischief. Chaos is in their blood, and their home, Hell, reflects this, with few rules and little order, but some demons parody the Kaio idea of order, organizing vast armies of the damned to make their demonic visions a reality, temporarily using order to eventually blanket the universe in chaos.

Evil is not required, they are beings of Chaos first.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		Decline=50
		InclineAge=16
		ZanzoMod=1.5
		Zanzoken=5
		FlyMod=2
		FlySkill=3
		Zenkai=6
		MedMod=2
		Race="Demon"
		AlignmentNumber=-5
		Alignment="Evil"
		BreathInSpace=1
		GravMastered=10
		GeneticLearnList=DemonLearnList
		BaseMaxKi=100
		RacialPowerAdd=250
		//Asexual=1
		//Sterile=1
	BPMod=2.6
	AscensionMult=1
	FBMMult=2
	BaseMaxAnger=140
	KiMod=2
	StrMod=1.9
	EndMod=1.9
	SpdMod=1.8
	OffMod=1.8
	DefMod=1.6
	BaseRegeneration=2.5
	BaseRecovery=1.8


mob/proc/Oni(sizing=0)
	RaceDescription={"-Oni-
Birthed from the Years and years of Demon and Kaio Magic that has existed in the Plains of the Realm. Becoming a Sort of Naturally combination of the universe, the realm's answer to the balance for them. However due to the fact that sometimes, this mixing can be not perfect, it will cause them to be born into different shades of colors, With Blue hues generally being more Orderly Charged, and Red hues generally being more Chaotically charged. As they have lived, and experienced the souls of the mortals, they have learned to adapt the many things that the dead have taught before, being also the race well known in the afterlife for keeping knowledge of the many past lives of people before they pass on. This allows them to maintain onto past ideas given by Mortals and they can use it to create grand devices by mixing their many eons of tech study.
"}
	if(!sizing)
		Int_Mod=1.5
		Magic_Potential =1.5
		InclineAge=12
		Decline=50
		ZanzoMod=1
		FlyMod=1
		BaseMaxKi=50
		Zenkai=5
		MedMod=2
		Race="Oni"
		GravMastered=10
		BreathInSpace=1
		FlySkill=2
		GeneticLearnList=OniLearnList
		RacialPowerAdd=150
	BPMod=2.3
	FBMMult=2
	BaseMaxAnger=150
	AscensionMult=1.2
	KiMod=2
	StrMod=2
	EndMod=2.3
	SpdMod=1.6
	OffMod=1.7
	DefMod=1.6
	BaseRegeneration=2
	BaseRecovery=1.8


mob/proc/SpacePirate(sizing=0)
	RaceDescription={"-Heran-
Being part of their clan is all they’ve known. Protecting the Promised Land from being defiled is a huge part of Heran culture. The clan celebrated for only a moment that they brought down a large colony ship heading towards the Promised Land. It was short lived as they now find themselves crash landed on Namek. The ship is inoperable, but perhaps not entirely broken.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=12
		Race="Heran"
		Decline=45
		FlySkill= 50
		FlyMod=1.5
		BaseMaxKi=80
		Zenkai=6
		GravMastered=15
		Class="Heran"
		GeneticLearnList=HeranLearnList
		RacialPowerAdd=50
	BojackMult=1.5
	SuperBojackMult=1.25
	AscensionMult=1.16
	BPMod=2.3
	FBMMult=1.58
	BaseMaxAnger=150
	KiMod=1.8
	StrMod=2
	EndMod=2
	SpdMod=1.9
	OffMod=1.9
	DefMod=1.5
	BaseRegeneration=2
	BaseRecovery=1.8



mob/proc/Yardrat(sizing=0) //
	RaceDescription={"-Yardrats-

Once had a large thriving population on their home world of Yardrat. After the Changelings laid waste to the world they decided to claim Yardrat race as mere servants for the Empire. Their powers of teleportation were deemed a useful asset for the Empire's future conquests of the Galaxy. However, the Yardrat's low fighting potential meant that they were mere peons doing menial and often degrading tasks. They are seen as slaves to the Empire and daren't speak out of turn out of fear of being executed on the spot.

While they may long for freedom, they dare not share this with anyone. They are considered disposable, and while their abilities make them useful, it most certainly doesn't make them invincible.
"}
	if(!sizing)
		Asexual=1
		Magic_Potential = 1
		Int_Mod=1
		InclineAge=10
		Decline=50
		BaseMaxKi=90
		ZanzoMod=5
		Zanzoken=100
		FlyMod=2
		FlySkill=1
		Zenkai=3
		MedMod=3
		Race="Yardrat"
		Class="Yardrat"
		GravMastered=10
		contents+=new/Skill/Support/InstantTransmission
		GeneticLearnList=YardratLearnList
		RacialPowerAdd=35
	BPMod=2.2
	FBMMult=1.92
	AscensionMult=1.2
	BaseMaxAnger=135
	KiMod=2.5
	StrMod=1.8
	EndMod=1.8
	SpdMod=2.5
	OffMod=1.8
	DefMod=1.8
	BaseRegeneration=2
	BaseRecovery=2.2


mob/proc/Kanassan(sizing=0)//
	RaceDescription={"-Kanassans-
Kanassans are a race of impressive foresight. Some say that the most skilled of their race are even able to see events in the future, though only for fleeting moments.
"}
	if(!sizing)
		Int_Mod=1
		Asexual=1
		Magic_Potential = 1
		InclineAge=14
		Decline=50
		ZanzoMod=1.5
		FlyMod=1.5
		Zenkai=3
		MedMod=3
		Race="Kanassan"
		Class="Kanassan"
		GravMastered=10
		GeneticLearnList=KanassanLearnList
		contents+=new/Skill/Support/Telepathy
		BaseMaxKi=100
		swimSkill=2000
	BPMod=2.2
	FBMMult=2.05
	AscensionMult=1.2
	BaseMaxAnger=135
	KiMod=2
	StrMod=1.8
	EndMod=1.7
	SpdMod=2.0
	OffMod=1.9
	DefMod=2.3
	BaseRegeneration=2
	BaseRecovery=2.1
	Asexual=1

mob/proc/Alien(skipicon=0)
	RaceDescription={"-Custom Alien-
As a descendant of a plethora of races and origin planets, most origins are murky at best, and mostly forgotten. Even if individuals recall where their ancestry lies, nobody else would likely be able to corroborate or even care. They find themselves marooned on this green world, knowing only that they were attacked without reason. Carving out their existence on Namek, or taking the fight to your aggressors, who conveniently find themselves lost nearby could be valid options, or perhaps they will find something else entirely to commit to.
"}
	if(!skipicon)
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Decline=55
		//alert("[RaceDescription]")
		ZanzoMod=1.5
		FlyMod=2
		Zenkai=4
		MedMod=2
		Race="Alien"
		BaseMaxKi=80
		RacialPowerAdd=rand(20,40)
		//XP=720
		GravMastered=10
		GeneticLearnList=AlienLearnList

	BPMod=2.2
	FBMMult=1.95
	AscensionMult=1.2
	BaseMaxAnger=130
	KiMod=1.4
	StrMod=1.15
	EndMod=1.15
	SpdMod=1.15
	OffMod=1.15
	DefMod=1.15
	BaseRegeneration=1.9
	BaseRecovery=1.35


mob/proc/Majin(sizing=0) //
	RaceDescription="Majin(Placeholder)"

	if(!sizing)
		Sterile=1
		Int_Mod=1
		Magic_Potential = 1.5
		undelayed=1
		InclineAge=10
		Decline=200
		contents+=new/Skill/Misc/Absorb_Majin
		contents+=new/Skill/Misc/Fly
		contents+=new/Skill/Zanzoken
		//FlySkill=1
		BaseMaxKi=1000
		Zenkai=1
		Age=1
		Race="Majin"
		BreathInSpace=1
		Zanzoken=1000
		GravMastered=50
		Regenerate=2
		CanLimbRegen=1
		AlignmentNumber=-6
		Alignment="Very Evil"
	BPMod=2.5
	FBMMult=1.9
	AscensionMult=1.3
	BaseMaxAnger=140
	KiMod=3
	StrMod=2
	EndMod=2
	SpdMod=2
//	ResMod=2
	OffMod=1.5
	DefMod=1.5
	BaseRegeneration=5
	BaseRecovery=3


mob/proc/Bio(sizing=0) //
	RaceDescription="You are created as a Biological Android! Through many years of study, careful processing, data collection and sample acquisition, your creator has perfected the fabrication of a master hybrid species. However, you are not complete just yet and an insatiable urge, a hunger; hollowness of self lingers at the back of your mind constantly. It seems by some design or instinct, you are destined to seek ultimate perfection and ascend to your fullest potential. As a Biological Android, you are able to regenerate from death, so long as a single one of your unique cells remain. "

	if(!sizing)
		Sterile=1
		Int_Mod=1.5
		Magic_Potential = 1
//		Potential=1
		InclineAge=10
		Decline=20
		contents+=new/Skill/Misc/Absorb_Bio
		contents+=new/Skill/Misc/Fly
		contents+=new/Skill/Zanzoken
		Zanzoken=500
		FlySkill=10
		FlyMod=2
		BaseMaxKi=1000
		Zenkai=9
		MedMod=2
		Age=1
		Race="Bio-Android"
		BreathInSpace=1
		Regenerate=1
		CanLimbRegen=1
		GeneticLearnList+="Super Perfect Form"
		//src.loc = locate(321,419,14)
		GravMastered=50
		//src << "<p>You are created as a Biological Android! Through many years of study, careful processing, data collection and sample acquisition, your creator has perfected the fabrication of a master hybrid species. However, you are not complete just yet and an insatiable urge, a hunger; hollowness of self lingers at the back of your mind constantly. It seems by some design or instinct, you are destined to seek ultimate perfection and ascend to your fullest potential. As a Biological Android, you are able to regenerate from death, so long as a single one of your unique cells remain. <p><p>"
		AlignmentNumber=-5
		Alignment="Evil"
	BPMod=2.5
	FBMMult=1.9
	AscensionMult=1
	BaseMaxAnger=150
	KiMod=2
	StrMod=1.8
	EndMod=1.8
	SpdMod=1.8
	OffMod=1.8
	DefMod=1.8
	BaseRegeneration=2.5
	BaseRecovery=2.5




mob/proc/LSSJ(sizing=0)
	RaceDescription={"-Saiyan-
You are born with the Legendary Gene, a rare mutation within a Saiyans genetic DNA structure! A mythic pantheon of unstoppable might and resilience amongst a race of already formidable warriors, your destiny truly seems laid out in gold. However, the gene is highly unstable, lowering your lifespan by around ten years and causing you to become prone to fits of anger more easily at best, and insane insatiable perpetual rage fits at worst. Although not impossible, it is quite hard to snap out of such episodes. This is certainly both a blessing or a curse, left up for you to decide. Lastly and most importantly, achieving the Super Saiyan state is nearly as easy as breathing for you.
"}
	if(!sizing)
		FlyMod=1.5
		Zenkai=10
		MedMod=2
		GravMastered=5
		Int_Mod=1
		Magic_Potential=1
		InclineAge=16
		Race="Saiyan"
		Class="Legendary"
		Decline=45
		ZanzoMod=1
		BaseMaxKi=150
		RacialPowerAdd=rand(25,100)
	BPMod=2.2
	FBMMult=1.8
	AscensionMult=1.05
	BaseMaxAnger=170
	KiMod=1.8
	StrMod=1.8
	EndMod=2
	SpdMod=1.8
	OffMod=1.8
	DefMod=1.8
	BaseRegeneration=2
	BaseRecovery=1.8

mob/proc/Puar(sizing=0)
	RaceDescription={"-Puar-
Much like the Makyojin, these beings have recently gained sentience. Being birthed from excess magical energies that flooded Earth during the time of the open breach, these creatures are generally seemed to be innocent and curious. They don't appear to hold any negative temperament. Some Mages take to calling them Familiars and have posed an excellent studies for them. Some fighters have noticed that while a Puar has little in the way of offence, they make for excellent sparring partners and due to their body composition, are rather difficult to take out of a fight. There have been stories and sightings of these combat-mages being incredibly supportive during skirmishes to whoever the Puar decide to aid. Their very presence could turn the flow of a battle.
"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential = 2
		InclineAge=12
		Decline=50
		ZanzoMod=1
		FlyMod=1.4
		BaseMaxKi=50
		Zenkai=2
		MedMod=2.2
		Race="Puar"
		GravMastered=10
		BreathInSpace=1
		FlySkill=2
		GeneticLearnList=PuarLearnList
		contents+=new/Skill/Support/Imitation
		RacialPowerAdd=5
		Sterile = 1
	BPMod=1.9
	FBMMult=2
	BaseMaxAnger=150
	AscensionMult=1.2
	KiMod=2
	StrMod=1.55
	EndMod=2
	SpdMod=2.3
	OffMod=1.5
	DefMod=2
	BaseRegeneration=2.2
	BaseRecovery=2

mob/proc/PrimalApe(sizing=0)
	RaceDescription={"-Saiyan-
Primal Apes are the Primodal Creatures of what a LSSJ are. They are the original Saiya-jins and the last one's of the old ways. They are born with the Legendary Gene. Yet they lack control of there actions.
"}
	if(!sizing)
		FlyMod=1.5
		Zenkai=10
		MedMod=2
		GravMastered=5
		Int_Mod=1
		Magic_Potential = 1
		InclineAge=16
		Race="Saiyan"
		Class="Primal"
		Decline=45
		ZanzoMod=1
		BaseMaxKi=250
	BPMod=2.45
	FBMMult=1.8
	AscensionMult=1.05
	BaseMaxAnger=170
	KiMod=1.8
	StrMod=2
	EndMod=1.8
	SpdMod=1.8
	OffMod=1.8
	DefMod=1.9
	BaseRegeneration=2
	BaseRecovery=1.8

mob/proc/Saibaman(sizing=0)
	RaceDescription={"-Saibaman-
A strange natural like creation, grown from the dirt of a planet and used for whatever means the creator wishes, they obey without question, though may protest.

"}
	if(!sizing)
		Int_Mod=1
		Magic_Potential =1
		InclineAge=1
		Decline=12
		ZanzoMod=1
		FlyMod=1
		BaseMaxKi=50
		Zenkai=2
		MedMod=1
		Race="Saibaman"
		GravMastered=10
		BreathInSpace=1
		FlySkill=2
		GeneticLearnList=SaibaLearnList
//		RacialPowerAdd=100
		Sterile=1
	BPMod=2
	FBMMult=1.2
	BaseMaxAnger=145
	AscensionMult=1.04
	KiMod=2
	StrMod=2
	EndMod=2
	SpdMod=1.9
	OffMod=1.9
	DefMod=1.9
	BaseRegeneration=2
	BaseRecovery=2
	if(!sizing&&!HasCreated)
		var/list/Saibas = new
		var/GiveChoice = 0
		for(var/obj/items/Seedling/SL in world)
			if(SL.invisibility <= 0)
				Saibas += SL
				GiveChoice = 1
		if(!GiveChoice)
			src<<"There are no available Saibas to choose from, please choose a different race."
			del(src)
			return
		if(GiveChoice)
			Saibas+="Cancel"
			var/obj/choice = input("Choose a Saiba to activate.","Saibaman Growth") in Saibas
			switch(choice)
				if("Cancel")
					BackChar()
				else
					if(!src.Confirm("This Saibaman was made by [choice.Builder]. Continue?"))
						del(src)
						return
					if(choice.Password)
						var/PA=input(src,"[choice] Password","New Character",null)
						if(PA!=choice.Password)
							if(src)
								var/mob/player/A = new
								A.key = key
								A = src
								del(src)
					var/obj/items/Seedling/O = choice
					src.loc = O.loc
					src.Builder=O.Builder
					src.name = O.name
					view(8,src) << "[O.name] awakens."
					src.Delete = O

mob/proc/Konatsian(sizing=0)
	RaceDescription={"-Konatsian-
The mercenaries who are often seen travelling with Herans. They are often paid well and spend years at a time with a clan before moving onto the next job or pursuing dreams of their own. They are very loyal and just, provided a contract is valid and in place. Some may argue that crash landing on a planet with no way off of it may void several clauses in said contract, allowing for the Konatsians to renegotiate, or perhaps find another employer entirely
"}
	if(!sizing)//these guys are basically worse herans they need their own identity.
		Int_Mod=1.5
		Magic_Potential =1.5
		InclineAge=12
		Decline=45
		ZanzoMod=1
		FlyMod=1
		BaseMaxKi=50
		Zenkai=5
		MedMod=2
		Race="Konatsian"
		GravMastered=10
		BreathInSpace=0
		FlySkill=2
		GeneticLearnList=KonatLearnList
		RacialPowerAdd=50
	BPMod=2.2
	FBMMult=2.05
	BaseMaxAnger=150
	AscensionMult=1.2
	KiMod=2
	StrMod=2
	EndMod=1.6
	SpdMod=1.8
	OffMod=2.1
	DefMod=1.8
	BaseRegeneration=2
	BaseRecovery=2

mob/proc/Cerealian(sizing=0)
	RaceDescription={"-Cerealian-
Snipers that pew pew people ded! -Placeholder-
"}
	if(!sizing)//these guys are basically worse herans they need their own identity.
		Int_Mod = 1.5
		Magic_Potential = 1
		InclineAge = 12
		Decline = 45
		ZanzoMod = 1
		FlyMod = 1
		BaseMaxKi = 50
		Zenkai = 5
		MedMod = 2
		Race = "Cerealian"
		GravMastered=10
		BreathInSpace=0
		FlySkill=2
		GeneticLearnList=CerealianLearnList
		RacialPowerAdd=50
	BPMod=2.2
	FBMMult=2.05
	BaseMaxAnger=150
	AscensionMult=1.2
	KiMod=2
	StrMod=2
	EndMod=1.6
	SpdMod=1.8
	OffMod=2.1
	DefMod=1.8
	BaseRegeneration=2
	BaseRecovery=2

mob/proc/Heeter(sizing=0)
	RaceDescription={"-Heeter-
Crazy strong berzerker aliens! -Placeholder-
"}
	if(!sizing)//these guys are basically worse herans they need their own identity.
		Int_Mod = 1
		Magic_Potential = 1.5
		InclineAge = 12
		Decline = 45
		ZanzoMod = 1
		FlyMod = 1
		BaseMaxKi = 50
		Zenkai = 5
		MedMod = 2
		Race = "Heeter"
		GravMastered = 10
		BreathInSpace = 0
		FlySkill = 2
		GeneticLearnList = HeeterLearnList
		RacialPowerAdd = 50
	BPMod = 2.2
	FBMMult = 2.05
	BaseMaxAnger = 150
	AscensionMult = 1.2
	KiMod = 2
	StrMod = 2
	EndMod = 1.6
	SpdMod = 1.8
	OffMod = 2.1
	DefMod = 1.8
	BaseRegeneration = 2
	BaseRecovery = 2

mob/proc/Roswell_Grey(sizing=0)
	RaceDescription={"-Greys-
The Greys are most known for a singular warrior whom fought Gods and won, Others are still known to have a strong sense of Justice and often seek it out, They always have Gray skin and normally all black eyes.
"}
	if(!sizing)//intense powerhouse

		//Race Unique
		Race = "Greys"
		HPDoesNotAffectBP = 1
		RacialPowerAdd = 250
		AlignmentNumber = 2
		Alignment = "Justice"

		//Int or Wis
		Int_Mod = 1
		Magic_Potential = 1.5

		//Age
		InclineAge = 10
		Decline = 30

		//Utility Mods
		ZanzoMod = 1.3
		FlyMod = 1.15
		FlySkill = 2
		Zenkai = 1.25
		MedMod = 2.25
		GravMastered = 15

		//Contents, Learnlists
		GeneticLearnList = Roswell_GreyLearnList


	//Stat Mods
	BPMod = 2.9
	FBMMult = 2.15
	BaseMaxAnger = 115
	AscensionMult = 1.25
	KiMod = 1.8
	StrMod = 2
	EndMod = 1.8
	SpdMod = 1.8
	OffMod = 2
	DefMod = 1.8
	BaseRegeneration = 1.9
	BaseRecovery = 1.95

mob/proc/Dragon(sizing=0)
	RaceDescription={"-Dragon-
EC Purposes
"}
	if(!sizing)//intense powerhouse

		//Race Unique
		Race = "Dragon"
		HPDoesNotAffectBP = 1
		Immortal = 1
		RacialPowerAdd = 400
		AlignmentNumber = 2
		Alignment = "Justice"

		//Int or Wis
		Int_Mod = 1
		Magic_Potential = 1.5

		//Age
		InclineAge = 10
		Decline = 30

		//Utility Mods
		ZanzoMod = 1.3
		FlyMod = 1.15
		FlySkill = 2
		Zenkai = 1.25
		MedMod = 2.25
		GravMastered = 15

		//Contents, Learnlists
		GeneticLearnList = DragonLearnList


	//Stat Mods
	BPMod = 3
	FBMMult = 2.15
	BaseMaxAnger = 110
	AscensionMult = 1.25
	KiMod = 1.8
	StrMod = 2
	EndMod = 1.8
	SpdMod = 1.8
	OffMod = 2
	DefMod = 1.8
	BaseRegeneration = 1.9
	BaseRecovery = 1.95
	