

proc/YearMonthNumber()//for year comparisons that factor in the month
	return Year+(Month/100)

mob/proc/Yearly_Update()
	set waitfor=0
	if(src.Savable)
		//Check_Milestones()
//		CatchUpXPCheck()
		if(FactionApproved(Z1FactionCode)) FactionIncome(Z1FactionCode,1)
		if(FactionApproved(Z2FactionCode)) FactionIncome(Z2FactionCode,2)
		if(FactionApproved(Z3FactionCode)) FactionIncome(Z3FactionCode,3)
		if(FactionApproved(Z4FactionCode)) FactionIncome(Z4FactionCode,4)
		if(FactionApproved(Z5FactionCode)) FactionIncome(Z5FactionCode,5)
		if(FactionApproved(Z6FactionCode)) FactionIncome(Z6FactionCode,6)
		if(FactionApproved(Z7FactionCode)) FactionIncome(Z7FactionCode,7)
		if(Age>4) for(var/Language/BabyTalk/BT in src)
			src<<"You have outgrown the baby talk phase."
			del(BT)
			if(!lan) for(var/Language/L in src)
				lan=L
				break
		if(HasWiseMentor) TeachLimit = 5
		if(TeachCD) TeachCD-=TeachLimit*0.5
		if(TeachCD<0) TeachCD=0
		/*if(LastKill+7<Year&&!Dead) if(AlignmentNumber<2.5) AlignmentNumber+=0.25
		if(NextAlignmentShift<Year&&abs(AlignmentNumber)<5&&!Dead)
			NextAlignmentShift=Year+2.5
			if(AlignmentNumber>0.5)AlignmentNumber-=0.5
			if(AlignmentNumber<0.5)AlignmentNumber+=0.5*/
/*		if(LastXP<Year)
			EvasionTeaches=1
			WeaponTeaches=1
			UnarmedTeaches=1
			KiManipTeaches=1*/
			/*if(HasWiseMentor)
				EvasionTeaches=2
				WeaponTeaches=2
				UnarmedTeaches=2
				KiManipTeaches=2*/

		if(HBTCPower>0)
			HBTCPower-=pick(0.25,0.5)
			if(HBTCPower<0)HBTCPower=0
		for(var/Skill/B in src)
			if(B.Experience<100) B.Experience+=rand(5,15)
			if(B.Experience>100) B.Experience=100
			if(B.Teach < TeachLimit) B.Teach += TeachLimit*0.5
		for(var/Language/B in src) B.Teach=min(2,B.Teach++)
		if(Race=="Saiyan"&&Age<16&&!locate(/BodyPart/Tail) in src)
			contents+=new/BodyPart/Tail(src)
			src<<"Your tail grew back."
		if(Race=="Saiyan"||Race=="Half-Saiyan") if(Age<16)
			for(var/BodyPart/Tail/O in src) if(O.Status=="Missing")
				O.Status="Healthy"
				O.Health=100
				src<<"Your tail grew back."
		if(Race=="Half-Saiyan"&&Age<16&&!locate(/BodyPart/Tail) in src)
			contents+=new/BodyPart/Tail(src)
			src<<"You feel a strange itching on your backside as you come to realize you now have a tail."
		if(client) if(src)
			Age_Update()
			//Gains_Update()
			if(Counterpart) for(var/mob/player/B in Players) if(Counterpart=="[B]([B.key])"&&B.Race==Race)
				B.Counterpart="[src]([src.key])"
				if(GainMultiplier<B.GainMultiplier) src.GainMultiplier=B.GainMultiplier
				src<<"<span class=\"narrate\">Your gain has equaled your counterpart, [Counterpart]</span>"
			if(Month==1||Month==4||Month==7||Month==10)
				src<<"<span class=\"narrate\">The moon comes out!</span>"
				var/turf/ZZ = src.loc
				if(ZZ.Inside==0)
					if(locate(/obj/items/Mark_Of_The_Beast) in src) src.Werewolf()
					if(src.HasWerewolf>=1) src.Werewolf()
					for(var/BodyPart/Tail/B in src) if(!src.afk) if(B.Setting)
						switch(src.z)
							if(1) if(EarthMoon) src.Oozaru()
							if(3) if(VegetaMoon) src.Oozaru()
							if(4) if(IceMoon) src.Oozaru()
							if(5) if(ArconiaMoon) src.Oozaru()
							if(6) if(AlienMoon) src.Oozaru()
		if(!Players.Find(src))
			Players += src
			Update_Player()
		if(PercocetAddiction)PercocetAddiction--
		if(MorphineAddiction)MorphineAddiction--
		if(EpinephrineAddiction)EpinephrineAddiction--

		var/Absorb_Max = Base*0.3
		if(Absorb>Absorb_Max) Absorb=Absorb_Max
		if(Absorb)
			var/N = Absorb_Max
			N = N * 0.25
			Absorb -= N
			if(Absorb <= Base*0.05)
				Absorb = 0
				src << "All your absorbed power has faded away."
		//sleep(1)

		if(Race=="Makyojin") MakyoStar()

		if(PercocetAddiction)src<<pick("You begin to crave some more Percocet...","You need more Percocet.","Your body aches for more Percocet.")
		if(MorphineAddiction)src<<pick("You begin to crave some more Morphine...","You need more Morphine.","Your body aches for more Morphine.")
		if(EpinephrineAddiction)src<<pick("You begin to crave some more Epinephrine...","You need more Epinephrine.","Your body aches for more Epinephrine.")
		if(Month==1&&TaxPaid&&Race=="Oni")
			src<<"You get your resource tax returns."
			for(var/obj/Resources/ManaBag in src) ManaBag+=round(TaxPaid*1.2)
			TaxPaid=0
		if(Month==1&&MTaxPaid&&Race=="Oni")
			src<<"You get your mana tax returns."
			for(var/obj/Mana/ManaBag in src) ManaBag+=round(MTaxPaid*1.2)
			MTaxPaid=0

		//Baby Age Up
		if(Offspring)
			if(Age>=13)
				if(icon=='BabyGirl.dmi') if(Confirm("Would you like to change your icon into an adult icon?"))Skin()
				if(icon=='BabyBoy.dmi') if(Confirm("Would you like to change your icon into an adult icon?"))Skin()
				if(icon=='Kid Namekian.dmi') if(Confirm("Would you like to change your icon into an adult icon?")) Skin()
			else if(Age>=6)
				if(icon=='BabyGirl.dmi') if(Confirm("Would you like to change your icon into a child/kid?"))icon='Kid Girl.dmi'
				if(icon=='BabyBoy.dmi') if(Confirm("Would you like to change your icon into a child/kid?"))icon='Kid Boy.dmi'
				if(icon=='Kid Namekian.dmi') if(Confirm("Would you like to change your icon into an adult icon?")) Skin()
			else if(Age>=2)
				if(icon=='BabyGirl.dmi') if(Confirm("Would you like to change your icon into a toddler?"))icon='Toddler Girl.dmi'
				if(icon=='BabyBoy.dmi') if(Confirm("Would you like to change your icon into a toddler?"))icon='Toddler Boy.dmi'
				if(icon=='Kid Namekian.dmi') if(Confirm("Would you like to change your icon into an adult icon?")) Skin()
		if(Age>=InclineAge) if(icon=='updated_baby_cell.dmi')if(Confirm("Would you like to change your icon now that you are at full incline?")) Skin()


var/MakyoStar=0
mob/proc/MakyoStar()// if(src.Savable)
	set background=1
	set waitfor=0
	if(MakyoStar==1&&!HadStarBoost)
		if(MakyoPower==0&&Race=="Makyojin"||MakyoPower==0&&Race=="Half-Makyojin")
			src<<"<span class=\"narrate\">The Makyo Star infuses you with power. (This causes your Expand to grant 1.10x BP)"
			HadStarBoost++
			RacialPowerAdd+=Base*0.25
	if(MakyoStar==0)
		for(var/Skill/Buff/S in src)
			if(istype(S,/Skill/Buff/Expand))
				if(S.Using)
					S.use(src)
		HadStarBoost=0


mob/proc/Age_Update()
	set background=1
	set waitfor=0
	if(Savable)
		Real_Age=Year-BirthYear
		SaveAge=WipeDay-DayCreated
		if(Month < BirthMonth)
			SaveAge--
			if(SaveAge<0)
				SaveAge=0
	/*	Moon_Used -= 1
		if(Moon_Used <= 0) Moon_Used = 0*/
		if(!Dead&&!Vampire) Age+=Year-LogYear
		LogYear=Year
		Body()
		GreyHair()
		if(Age >= 3.9 && (locate(/Language/BabyTalk) in src))
			contents -= /Language/BabyTalk
		if(!Sterile&&Age>=InclineAge&&!(locate(/obj/Mate) in src))
			contents+=new/obj/Mate
			for(var/obj/Mate/B in src) B.LastUse=WipeDay-1
		src<<"<span class=\"narrate\">You are now [round(Real_Age,0.1)] years old</span>"
		src<<"<span class=\"narrate\">[YearOutput()]</span>"
		if(!Dead&&!Immortal&&Age>Decline)
			if(Body<=0.35)
				src<<"<span class=\"narrate\">Old age takes it's toll, and you pass away.</span>"
				spawn src.Death("old age")
			else
				src << "<span class=\"narrate\">Old age wears on your body.</span>"
		if(PrayerAnsweredBy)
			if(PrayerAnsweredDate<=Year+(Month/100)-0.01)
				PrayerAnsweredBy=null
				src<<"You feel as though your prayers could be answered again."
	//Save()
		/*if(locate(/obj/items/Ring_Of_Experience) in src)
			for(var/obj/items/Ring_Of_Experience/NW in src) if(NW.Level<Year)
				NW.Level=Year
				XP+=75*/



proc/YearOutput()
	if(Month==1) return "Week [MonthCycle] of January, Year [round(Year)]"
	if(Month==2) return "Week [MonthCycle] of February, Year [round(Year)]"
	if(Month==3) return "Week [MonthCycle] of March, Year [round(Year)]"
	if(Month==4) return "Week [MonthCycle] of April,Year [round(Year)]"
	if(Month==5) return "Week [MonthCycle] of May, Year [round(Year)]"
	if(Month==6) return "Week [MonthCycle] of June, Year [round(Year)]"
	if(Month==7) return "Week [MonthCycle] of July, Year [round(Year)]"
	if(Month==8) return "Week [MonthCycle] of August, Year [round(Year)]"
	if(Month==9) return "Week [MonthCycle] of September, Year [round(Year)]"
	if(Month==10) return "Week [MonthCycle] of October, Year [round(Year)]"
	if(Month==11) return "Week [MonthCycle] of November, Year [round(Year)]"
	if(Month==12) return "Week [MonthCycle] of December, Year [round(Year)]"

mob/proc/Body()
	if(istype(src,/mob/NPC))
		Body=1
		return
	if((Age<InclineAge) && (InclineAge>0))
		Body = min(100,100/((InclineAge-Age)**(0.3)))	//Incline speed works better this way
	else if(Age>Decline)
		Body = min(100,100/((Age-Decline)**(0.3)))
	else if(WasCloned)
		Body = min(100,100/((4-(Age-WasCloned))**(0.3)))
	else Body = 100	//100 percent niggaaa
	if(Dead)
		if(KeepsBody) Body = 85
		else Body = 50
	if(Immortal) Body = 100
	Body *= 0.01	//Body is a percent, out of 100%
mob/proc/Die() //from old age
	if(inertia_dir)
		inertia_dir = 0
		last_move = null
	//PotentialUnlocked=0
	Experience=0
	//HBTC_Enters=0
	//Age=1
	if(icon=='Namek Old.dmi')
		icon='Namek Young.dmi'
	src << "<span class=\"narrate\">Old age takes it's toll, and you pass away.</span>"
	Death("old age")
	Body()
mob/proc/GreyHair()
	if(!ssj&&hair&&Age>Decline)
		if(Hair_Age<Decline) Hair_Age=Decline
		overlays -= hair
		hair = Hair_Base
		if(HairColor) hair+=HairColor
		hair += rgb(round(3*(Age-Hair_Age)),round(3*(Age-Hair_Age)),round(3*(Age-Hair_Age)))
		overlays += hair
