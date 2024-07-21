
obj/Baby
	icon='Baby Boy.dmi'
	density=1
//	Password="123567890"
	Savable=1
	var
		Race
		Class
		Size
		Base=1
		GainMultiplier
		MaxKi
		Decline
		ParentKey
		Parent2Key
		Parent1
		Parent2
		Magic_Potential
		Int_Mod=1
		InclineAge=16
		BPMod
		FBMMult=1.5
		MaxAnger
		KiMod
		StrMod
		EndMod
		SpdMod
		PowMod
		ResMod
		OffMod
		DefMod
		BaseRegeneration
		BaseRecovery
		DeathRegen
		Zenkai
		BreathInSpace
		GravMasteredB
		MedMod=1
		list/GeneticLearnList=list()
		Asexual
		Sterile
		CanLimbRegen
		HiveMind
		AscensionMult

mob/var/Parents

mob/proc/HybridBaby(obj/Baby/B)
	Int_Mod=B.Int_Mod
	Magic_Potential = B.Magic_Potential
	Age=0.1
	InclineAge=B.InclineAge
	RaceDescription="[B.Race]"
	ZanzoMod=2
	FlyMod=2
	BPMod=B.BPMod
	BaseMaxAnger=B.MaxAnger
	KiMod=B.KiMod
	StrMod=B.StrMod
	EndMod=B.EndMod
	SpdMod=B.SpdMod
//	PowMod=B.PowMod
	OffMod=B.OffMod
	DefMod=B.DefMod
	BaseRegeneration=B.BaseRegeneration
	BaseRecovery=B.BaseRecovery
	Zenkai=B.Zenkai
	MedMod=B.MedMod
	Race="[B.Race]"
	if(B.Class) Class=B.Class
	Size=B.Size
	GainMultiplier=B.GainMultiplier
	Base=GainMultiplier*BPMod
	BaseMaxKi=B.MaxKi
	Decline=B.Decline
	Racial_Stats=3
	Real_Age=0
	BirthYear=Year
	BirthMonth=Month
	Asexual=B.Asexual
	if(Asexual)Sterile=1
	GravMastered=B.GravMasteredB
	Regenerate=B.DeathRegen
	AscensionMult=B.AscensionMult
	FBMMult=B.FBMMult
	Sterile=B.Sterile
	if(B.HiveMind)
		HiveMind=B.HiveMind
		contents+=new/Skill/Misc/HiveMind
	Parents="[B.Parent1] ([B.ParentKey]) and [B.Parent2] ([B.Parent2Key])"
	ICanMate=1
	GeneticLearnList=B.GeneticLearnList
	CanLimbRegen=B.CanLimbRegen
	Alien_Trans_Type()

mob
	var
		GeneticDecline=1
		GeneticMagic_Potential=1
		GeneticInt_Mod=1
		GeneticBPMod=1
		GeneticFBMMult=1
		GeneticMaxAnger=100
		GeneticKiMod=1
		GeneticStrMod=1
		GeneticEndMod=1
		GeneticSpdMod=1
		GeneticPowMod=1
		GeneticOffMod=1
		GeneticDefMod=1
		GeneticRegeneration=1
		GeneticRecovery=1
		GeneticDeathRegen=0
		list/GeneticLearnList=list()
		GeneticParentKey
		GeneticParent
		GeneticAscensionMult=1
		GeneticBreathInSpace
		GeneticCanLimbRegen
		BeenSequenced=0
		Gender

obj/items/Genetic_Sequencer
	icon='Splooge.dmi'
	icon_state="Clean"
	desc="You can use this on a reproducing race to extract a sample of their genetics.  You can then use this with another sequencer in order to create a sterile offpsring between the two sets of genetics."
	var
		GeneticRace=null
		GeneticClass=null
		GeneticSize
		GeneticDecline=1
		GeneticMagic_Potential=1
		GeneticInt_Mod=1
		GeneticBPMod=1
		GeneticFBMMult=1
		GeneticMaxAnger=100
		GeneticKiMod=1
		GeneticStrMod=1
		GeneticEndMod=1
		GeneticSpdMod=1
		GeneticPowMod=1
		GeneticOffMod=1
		GeneticDefMod=1
		GeneticRegeneration=1
		GeneticRecovery=1
		GeneticDeathRegen=0
		GeneticZenkai=1
		GeneticMedMod=1
		GeneticBreathInSpace=0
		GeneticCanLimbRegen=0
		GeneticAscensionMult=1
		InclineAge=0
		BaseMaxKi=1
		GainMultiplier=1
		list/GeneticLearnList=list()
		GeneticParentKey
		GeneticParent
	verb/Sequence(mob/M in view(1))
		set category=null
		var/Go=0
		if(!M.CanMate2())
			usr<<"You can not use this on them."
			return
		if(M.Gender=="Plural")
			usr<<"This cannot be done."
			return
		if(M.Sterile||M.Race=="Android"||M.Race=="Majin"||M.Race=="Saibaman"||M.Vampire||M.Dead||M.BeenSequenced>2)
			usr<<"You can not use this on them."
			return
		switch(alert(M,"[usr] wants to extract your DNA, allow it?","Genetic Sequencer","Yes","No"))
			if("Yes") Go=1
		if(Go)
			GeneticRace=M.Race
			GeneticClass=M.Class
			GeneticSize=M.Size
			GeneticDecline=M.GeneticDecline
			GeneticMagic_Potential=M.GeneticMagic_Potential
			GeneticInt_Mod=M.GeneticInt_Mod
			GeneticBPMod=M.GeneticBPMod
			GeneticFBMMult=M.GeneticFBMMult
			GeneticMaxAnger=M.GeneticMaxAnger
			GeneticKiMod=M.GeneticKiMod
			GeneticStrMod=M.GeneticStrMod
			GeneticEndMod=M.GeneticEndMod
			GeneticSpdMod=M.GeneticSpdMod
			GeneticPowMod=M.GeneticStrMod
			GeneticOffMod=M.GeneticOffMod
			GeneticDefMod=M.GeneticDefMod
			GeneticRegeneration=M.GeneticRegeneration
			GeneticRecovery=M.GeneticRecovery
			GeneticDeathRegen=M.GeneticDeathRegen
			GeneticZenkai=M.Zenkai
			GeneticMedMod=M.MedMod
			InclineAge=M.InclineAge
			GainMultiplier=M.GainMultiplier
			BaseMaxKi=M.BaseMaxKi
			GeneticBreathInSpace=M.GeneticBreathInSpace
			GeneticCanLimbRegen=M.GeneticCanLimbRegen
			GeneticLearnList=M.GeneticLearnList
			GeneticParentKey=M.key
			GeneticAscensionMult=M.AscensionMult
			GeneticParent=M.name
			icon_state="STICKY"
			name="[GeneticParent]'s Genetic Sequence"
			M.BeenSequenced++
	verb/Combine_Sequences()
		set category=null
		var/list/Items=new
		for(var/obj/items/Genetic_Sequencer/K in usr) Items+=K
		Items+="Cancel"
		var/obj/items/Genetic_Sequencer/C=input("Combine [src] with what? (Consumes both)") in Items
		if(C=="Cancel") return
		if(!C.GeneticRace||!GeneticRace)
			usr<<"One of these is not viable"
			return
		else
			usr.MakeFakeBaby(src,C,usr)
			spawn()
				del(C)
				del(src)


mob/proc/MakeFakeBaby(obj/items/Genetic_Sequencer/A,obj/items/Genetic_Sequencer/B,mob/CC)
	var/obj/Baby/C=new
	if(A.GeneticRace==B.GeneticRace) C.Race=B.GeneticRace
	else if((B.GeneticRace=="Shinjin"&&A.GeneticRace!="Shinjin")||(B.GeneticRace!="Shinjin"&&A.GeneticRace=="Shinjin"))
		C.GeneticLearnList+="Mystic"
		C.Race="Demigod"
	else if((B.GeneticRace=="Demon"&&A.GeneticRace!="Demon")||(B.GeneticRace!="Demon"&&A.GeneticRace=="Demon"))
		C.GeneticLearnList+="Majin"
		C.Race="Demigod"
	else if(A.GeneticRace=="Demigod"||B.GeneticRace=="Demigod")
		C.Race="Demigod"
	else if((B.GeneticRace=="Saiyan"&&A.GeneticRace!="Saiyan")||(B.GeneticRace!="Saiyan"&&A.GeneticRace=="Saiyan")) C.Race="Half-Saiyan"
	else if(!findtext(B.GeneticRace,"Half-")&&!findtext(B.GeneticRace,"Part-")) C.Race="Half-[B.GeneticRace]"
	else C.Race="Part-[copytext(B.GeneticRace,6)]"
	if(C.Race!="Half-Saiyan") if(C.Race!="Part-Saiyan") if(C.Race!="Demigod")
		if(A.GeneticClass!="Undefined Class"&&B.GeneticClass!="Undefined Class") C.Class = pick(A.GeneticClass,B.GeneticClass)
		else if(A.GeneticClass!="Undefined Class"&&B.GeneticClass=="Undefined Class") C.Class="[A.GeneticClass]"
		else if(B.GeneticClass!="Undefined Class"&&A.GeneticClass=="Undefined Class") C.Class="[B.GeneticClass]"
	C.Size=pick(A.GeneticSize,B.GeneticSize)
	C.BPMod=round(((A.GeneticBPMod+B.GeneticBPMod)/2),0.05)
	C.FBMMult=round(((A.GeneticFBMMult+B.GeneticFBMMult)/2),0.05)
	if(C.Race=="Half-Saiyan") C.FBMMult=1.6
	C.Decline=(B.GeneticDecline+A.GeneticDecline)/2
	C.Int_Mod=round((A.GeneticInt_Mod+B.GeneticInt_Mod)/2,0.1)
	if(!C.Int_Mod) C.Int_Mod=1
	C.Magic_Potential = round((B.GeneticMagic_Potential+A.GeneticMagic_Potential)/2,0.1)
	C.InclineAge=round((B.InclineAge+A.InclineAge)/2)
	if(C.InclineAge>12)C.InclineAge=12
	if(C.InclineAge<1)C.InclineAge=1
	C.MaxAnger=round(((B.GeneticMaxAnger+A.GeneticMaxAnger)/2),0.5)
	C.MaxKi=round(((B.BaseMaxKi+A.BaseMaxKi)/2),0.5)
	C.KiMod=round(((B.GeneticKiMod+A.GeneticKiMod)/2),0.05)
	C.StrMod=round(((B.GeneticStrMod+A.GeneticStrMod)/2),0.05)
	C.EndMod=round(((B.GeneticEndMod+A.GeneticEndMod)/2),0.05)
	C.SpdMod=round(((B.GeneticSpdMod+A.GeneticSpdMod)/2),0.05)
	C.PowMod=round(((B.GeneticStrMod+A.GeneticStrMod)/2),0.05)
	C.OffMod=round(((B.GeneticOffMod+A.GeneticOffMod)/2),0.05)
	C.DefMod=round(((B.GeneticDefMod+A.GeneticDefMod)/2),0.05)
	C.BaseRegeneration=round(((B.GeneticRegeneration+A.GeneticRegeneration)/2),0.05)
	C.BaseRecovery=round(((B.GeneticRecovery+A.GeneticRecovery)/2),0.05)
	C.GainMultiplier=max(A.GainMultiplier,B.GainMultiplier)
	C.Zenkai=round((B.GeneticZenkai+A.GeneticZenkai)/2)
	C.MedMod=round((B.GeneticMedMod+A.GeneticMedMod)/2,0.1)
	C.AscensionMult=round((B.GeneticAscensionMult+A.GeneticAscensionMult)/2,0.1)
	if(A.GeneticBreathInSpace&&B.GeneticBreathInSpace) C.BreathInSpace=1
	if(A.GeneticDeathRegen&&B.GeneticDeathRegen) C.DeathRegen=1
	C.ParentKey=A.GeneticParentKey
	C.Parent2Key=B.GeneticParentKey
	C.GravMasteredB=CC.PlanetGravity()
	C.Parent1=A.GeneticParent
	C.Parent2=B.GeneticParent
	C.Asexual=1
	C.Sterile=1
	var/list/LearnList1=list()
	if(C.Race==A.GeneticRace&&B.GeneticRace==A.GeneticRace)
		C.GeneticLearnList=A.GeneticLearnList
		if(A.GeneticCanLimbRegen) C.CanLimbRegen=1
	else
		//A.GeneticLearnList.Remove("Pantheon","Swell","Physics Simulation","Super Tuffle","Giant Mode","Makyo Transform","Majin","Mystic","Super Namekian","Post Human","Humanism")
		LearnList1=A.GeneticLearnList+B.GeneticLearnList
		var/LearnRemove=(LearnList1.len)/2
		while(LearnRemove>1&&LearnList1.len)
			var/Z=pick(LearnList1)
			LearnList1-=Z
			LearnRemove--
			C.GeneticLearnList+=Z
	if(B.GeneticRace=="Shinjin"||A.GeneticRace=="Shinjin")GeneticLearnList+="Mystic"
	if(B.GeneticRace=="Demon"||A.GeneticRace=="Demon")GeneticLearnList+="Majin"
	if(C.Race=="Half-Makyojin")GeneticLearnList+="Makyo Transform"
	if(C.Race=="Half-Tuffle")GeneticLearnList+="Physics Simulation"
	if(C.Race=="Half-Human")GeneticLearnList+="Humanism"
	if(C.Race=="Half-Namekian")GeneticLearnList+="Super Namekian"
	if(C.Race=="Half-Oni")GeneticLearnList+="Giant Mode"
	if(C.Race=="Half-Konatsian")GeneticLearnList+="Weapon Force"
//	if(A.HiveMind)C.HiveMind=A.HiveMind
//	if(B.HiveMind)C.HiveMind=B.HiveMind
	C.name="[C.Race], Parents: [B] and [A] (Test Tube User: [CC])"
//	log_game("| [B] mated with [A]. (Test Tube User: [CC])")
	logAndAlertAdmins("| [B] mated with [A], base ([C.Base]), BPMod [C.BPMod]  (Test Tube User: [CC])")
	C.loc = CC.loc
	if(CC.Confirm("Add a password?")) C.Password=input("Password for baby") as text
	else C.Password=null


mob/proc/MakeBaby(mob/A,mob/B)
	var/obj/Baby/C=new
	if(A.Race==B.Race) C.Race=B.Race
	else if((B.Race=="Shinjin"&&A.Race!="Shinjin")||(B.Race!="Shinjin"&&A.Race=="Shinjin"))
		C.GeneticLearnList+="Mystic"
		C.Race="Demigod"
	else if((B.Race=="Demon"&&A.Race!="Demon")||(B.Race!="Demon"&&A.Race=="Demon"))
		C.GeneticLearnList+="Majin"
		C.Race="Demigod"
	else if(A.Race=="Demigod"||B.Race=="Demigod")
		C.Race="Demigod"
	else if((B.Race=="Saiyan"&&A.Race!="Saiyan")||(B.Race!="Saiyan"&&A.Race=="Saiyan")) C.Race="Half-Saiyan"
	else if(!findtext(B.Race,"Half-")&&!findtext(B.Race,"Part-")) C.Race="Half-[B.Race]"
	else C.Race="Part-[copytext(B.Race,6)]"
	if(C.Race!="Half-Saiyan") if(C.Race!="Part-Saiyan") if(C.Race!="Demigod")
		if(A.Class!="Undefined Class"&&B.Class!="Undefined Class") C.Class = pick(A.Class,B.Class)
		else if(A.Class!="Undefined Class"&&B.Class=="Undefined Class") C.Class="[A.Class]"
		else if(B.Class!="Undefined Class"&&A.Class=="Undefined Class") C.Class="[B.Class]"
	C.Size=pick(A.Size,B.Size)
	C.BPMod=round(((A.GeneticBPMod+B.GeneticBPMod)/2),0.05)
	C.FBMMult=round(((A.GeneticFBMMult+B.GeneticFBMMult)/2),0.05)
	if(C.Race=="Half-Saiyan") C.FBMMult=1.6
	C.Decline=(B.GeneticDecline+A.GeneticDecline)/2
	C.Int_Mod=round((A.GeneticInt_Mod+B.GeneticInt_Mod)/2,0.1)
	if(!C.Int_Mod) C.Int_Mod=1
	C.Magic_Potential = round((B.GeneticMagic_Potential+A.GeneticMagic_Potential)/2,0.1)
	C.InclineAge=round((B.InclineAge+A.InclineAge)/2)
	if(B.HasTheSeedIsStrong)C.InclineAge-=3
	if(A.HasTheSeedIsStrong)C.InclineAge-=3
	if(C.InclineAge<1)C.InclineAge=1
	C.MaxAnger=round(((B.GeneticMaxAnger+A.GeneticMaxAnger)/2),0.5)
	C.MaxKi=round(((B.BaseMaxKi+A.BaseMaxKi)/2),0.5)
	C.KiMod=round(((B.GeneticKiMod+A.GeneticKiMod)/2),0.05)
	C.StrMod=round(((B.GeneticStrMod+A.GeneticStrMod)/2),0.05)
	C.EndMod=round(((B.GeneticEndMod+A.GeneticEndMod)/2),0.05)
	C.SpdMod=round(((B.GeneticSpdMod+A.GeneticSpdMod)/2),0.05)
	C.PowMod=round(((B.GeneticStrMod+A.GeneticStrMod)/2),0.05)
	C.OffMod=round(((B.GeneticOffMod+A.GeneticOffMod)/2),0.05)
	C.DefMod=round(((B.GeneticDefMod+A.GeneticDefMod)/2),0.05)
	C.BaseRegeneration=round(((B.GeneticRegeneration+A.GeneticRegeneration)/2),0.05)
	C.BaseRecovery=round(((B.GeneticRecovery+A.GeneticRecovery)/2),0.05)
	C.GainMultiplier=max(A.GainMultiplier,B.GainMultiplier)
	C.AscensionMult=round((B.AscensionMult+A.AscensionMult)/2,0.1)
	C.Zenkai=round((B.Zenkai+A.Zenkai)/2)
	C.MedMod=round((B.MedMod+A.MedMod)/2,0.1)
	if(A.BreathInSpace&&B.BreathInSpace) C.BreathInSpace=1
	if(A.GeneticDeathRegen&&B.GeneticDeathRegen) C.DeathRegen=1
	if(A.client)
		C.ParentKey=A.key
		C.Parent2Key=B.key
		C.Parent1=A.name
		C.Parent2=B.name
	else
		C.ParentKey=A.GeneticParentKey
		C.Parent2Key=B.GeneticParentKey
		C.Parent1=A.GeneticParent
		C.Parent2=B.GeneticParent
	var/list/LearnList1=list()
	if(A.Asexual) C.GeneticLearnList=A.GeneticLearnList
	if(C.Race==A.Race&&B.Race==A.Race)
		C.GeneticLearnList=A.GeneticLearnList
		if(A.CanLimbRegen) C.CanLimbRegen=1
	else
		//A.GeneticLearnList.Remove("Pantheon","Swell","Physics Simulation","Super Tuffle","Giant Mode","Makyo Transform","Majin","Mystic","Super Namekian","Post Human","Humanism")
		LearnList1=A.GeneticLearnList+B.GeneticLearnList
		var/LearnRemove=(LearnList1.len)/2
		while(LearnRemove>1&&LearnList1.len)
			var/Z=pick(LearnList1)
			LearnList1-=Z
			LearnRemove--
			C.GeneticLearnList+=Z
	if(B.Race=="Shinjin"||A.Race=="Shinjin")GeneticLearnList+="Mystic"
	if(B.Race=="Demon"||A.Race=="Demon")GeneticLearnList+="Majin"
	if(C.Race=="Half-Makyojin")GeneticLearnList+="Makyo Transform"
	if(C.Race=="Half-Tuffle")GeneticLearnList+="Physics Simulation"
	if(C.Race=="Half-Human")GeneticLearnList+="Humanism"
	if(C.Race=="Half-Namekian")GeneticLearnList+="Super Namekian"
	if(C.Race=="Half-Oni")GeneticLearnList+="Giant Mode"
	if(C.Race=="Half-Konatsian")GeneticLearnList+="Weapon Force"
	if(A.HiveMind)C.HiveMind=A.HiveMind
	if(B.HiveMind)C.HiveMind=B.HiveMind
	C.GravMasteredB=A.PlanetGravity()
	C.name="[C.Race], Parents: [B] and [A]"
//	if(A!=B) log_game("| [B] mated with [A].")
//	else log_game("| [key_name(usr)] laid an egg.")
	alertAdmins("| [B] mated with [A], base ([C.Base]), BPMod [C.BPMod]")
	if(A.Asexual||A.gender=="Asexual")
		C.name="[C.Race], Parent: [A]"
		C.icon='Egg.dmi'
		C.icon_state="[rand(1,8)]"
		C.Class="[A.Class]"
		C.Asexual=1
		C.loc=locate(A.x,A.y,A.z)
	else C.loc = A
	if(A.Confirm("Add a password?")) C.Password=input("Password for baby") as text
	else C.Password=null
	if(A.RPs<49)alertAdmins("| [B] mated with [A], [A] has a low number of emotes!")
	if(B.RPs<49)alertAdmins("| [B] mated with [A], [B] has a low number of emotes!")

mob/var/AdminCanMate=0
mob/proc
	CanMate()
		if(AdminCanMate) return 1
		if(Gender == "Plural")
			src << "You seem to have an unknown Gender."
			return 0
		if(Critical_Mate)
			src << "You're too injured to do that."
			return 0
		if(Oozaru) return 0
		if(MadeChildren>=4+(HasTheSeedIsStrong*2)+(HasBroodMother*4))
			src<<"You have already had the maximum amount of children."
			return 0
		/*if(TotalXP<XPRate*48)
			src<<"You need atleast [XPRate*48] lifetime exp."
			return 0*/
		/*if(Race=="Demon")
			src<<"Demons can not mate."
			return 0
		if(Race=="Shinjin")
			src<<"Shinjin can note mate."
			return 0*/
		if(SaveAge<1)
			src<<"Your save must be two years old before you can mate."
			return 0
		if(Race=="Post Human")
			src<<"The foreign energies that you have embraced have rendered you sterile."
			return 0
		if(Sterile)
			src<<"You are sterile and can not have children."
			return 0
		if(Dead) return 0
		if(Age<16)
			src<<"You are too young."
			return 0
		if(Age>Decline) if(!HasCialis)
			src<<"You are too old."
			return 0
		if(Race=="Android"||Race=="Saibaman")
			src<<"Artificials can not use this."
			return 0
		if(KOd) return 0
		if(RoidPower)
			src<<"The steroids are preventing you from becoming fertile."
			return 0
		if(IsFusion)

			return 0
		return 1
	CanMate2()
		if(AdminCanMate) return 1
		/*if(TotalXP<XPRate*48)
			src<<"You need atleast [XPRate*48] total XP."
			return 0*/
		if(SaveAge<1)
			src<<"Their save must be two years old before you can mate."
			return 0
		if(Sterile)
			src<<"They are sterile."
			return 0
		if(Dead) return 0
		if(Age<16)
			src<<"You are too young."
			return 0
		if(Age>Decline)  if(!HasCialis)
			src<<"You are too old."
			return 0
		if(Race=="Android"||Race=="Saibaman")
			src<<"Artificials can't do this."
			return 0
		if(RoidPower)
			src<<"The steroids are preventing you from becoming fertile."
			return 0
		if(IsFusion) return 0
		return 1

mob/var/MadeChildren=0
mob/var/ICanMate=0
obj/Mate
	var/LastUse=0
	var/tmp/Mating=0
	desc="You can use this to create an offspring that will inherit your base power, some of your \
	energy, along with some other things. Depending on your race, you must mate with the opposite sex, \
	or you can reproduce Asexually by laying eggs."
	verb/Mate()
		set category="Other"
		if(Year<3&&!usr.AdminCanMate)
			usr<<"You must wait until year 3 to mate."
			return
		if(WipeDay<LastUse+(1-(usr.HasTheSeedIsStrong*0.5))) if(!usr.HasBroodMother)
			usr<<"You cannot use this until day [LastUse+1-(usr.HasTheSeedIsStrong*0.5)]"
			return
		if(Mating) return
		if(!usr.CanMate()) return
		if(!usr.Asexual) for(var/mob/A in get_step(usr,usr.dir)) if(A.client) if(usr.gender!=A.gender)
			for(var/obj/Contact/C in usr.Contacts) if(C.Signature == A.Signature)
				if(C.familiarity>14.9)
					if(A.Asexual||A.gender=="Asexual")
						usr<<"They are Asexual and can not mate with you."
						return
					if(usr.Race=="Shinjin"&&A.Race=="Demon")
						usr<<"Shinjins can not mate with Demons."
						return
					if(usr.Race=="Demon"&&A.Race=="Shinjin")
						usr<<"Shinjins can not mate with Demons."
						return
					if(!A.CanMate()) return
					if(A.client&&usr.client) if(A.client.computer_id==usr.client.computer_id) // Based on computer ID instead of IP.
						if(usr.ckey != "blackclaw185" && usr.ckey != "saizetsu")
							usr<<"Do not interact with alternate keys"
							alertAdmins("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has been forced off the server for attempted alt interaction with [key_name(A)].\n")
							usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] has been forced off the server for attempted alt interaction with [key_name(A)].\n")
							usr.Logout()
					Mating=1
					var/app=input(A,"Mate with [usr]","Mating") in list("Yes","No")
					if(app=="Yes"&&usr.Confirm("Mate with [A]?"))
						A.RemoveBuffs()
						A.Reset_StatMultipliers()
						usr.RemoveBuffs()
						usr.Reset_StatMultipliers()
						usr.MakeBaby(usr,A)
						LastUse=WipeDay
						usr.MadeChildren++
						A.MadeChildren++
						Mating=0
					else
						Mating=0
						return
					break
				else usr<<"You need to get to know them more first. (15 Familiarity)"
		else if(!usr.Dead)
			LastUse=WipeDay
			usr.RemoveBuffs()
			usr.MakeBaby(usr,usr)
			usr.MadeChildren++
			Mating=0

