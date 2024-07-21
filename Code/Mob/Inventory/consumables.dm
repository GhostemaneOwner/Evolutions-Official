


mob/proc/ChangeIdentity()
	Name()
	Gender()
	Skin()
	Signature = rand(100000,999999)

//### Elixer of Life ###


mob/var
	HasUsedReplenish=0
	TicksOfReplenish=0
	HasUsedBookOfAges=0
	HasUsedNaniteFart=0
	HasUsedBookOfFortitude=0
	HasUsedBookOfLessons=0
	HasUsedEmpowerment=0
	TicksOfMerriment=0

obj/items/Salt_Water
	icon='Basic Needs.dmi'
	icon_state="Salt Water"
	desc="Drinking this will significantly increase your Thirst stat. Purify this if you're looking for something to drink."
	Flammable = 0
	verb
		Drink()
			if(usr.KOd==0)
				if(usr.Vampire)
					usr << "This doesn't do anything for you."
					return
				if(usr.Thirst == 100)
					usr << "You're already completely dehydrated."
					return
				usr.Thirst+=rand(25,50)
				if(usr.Thirst > 100)
					usr.Thirst = 100
				view(usr)<<"[usr] drinks a bottle of salt water."
				del(src)

obj/items/Fresh_Water
	icon='Basic Needs.dmi'
	icon_state="Fresh Water"
	desc="Drinking this will reduce your Thirst stat."
	Flammable = 0
	verb
		Drink()
			if(usr.KOd==0)
				if(usr.Vampire)
					usr << "This doesn't do anything for you."
					return
				if(usr.Thirst == 0)
					usr << "You're already completely hydrated."
					return
				usr.Thirst-=rand(25,50)
				if(usr.Thirst < 0)
					usr.Thirst = 0
				view(usr)<<"[usr] drinks a bottle of fresh water."
				del(src)

obj/items/Elixir_of_Refreshment
	icon='enchantmenticons.dmi'
	icon_state="FP"
	desc="Drinking this will lower your fatigue."
	Flammable = 1
	verb
		Use()
			if(usr.KOd==0)// if(usr.Race!="Android")
				if(usr.Fatigue == 0)
					usr << "You're already completely rested."
					return
				usr.Fatigue-=rand(25,50)
				if(usr.Fatigue < 0)
					usr.Fatigue = 0
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				del(src)

obj/items/Coffee
	icon='enchantmenticons.dmi'
	icon_state="FP"
	desc="Drinking this will lower your fatigue."
	Flammable = 1
	verb
		Use()
			if(usr.KOd==0)// if(usr.Race!="Android")
				if(usr.Fatigue == 0)
					usr << "You're already completely rested."
					return
				usr.Fatigue-=rand(25,50)
				if(usr.Fatigue < 0)
					usr.Fatigue = 0
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a large latte!"
				del(src)
//Coffee added back
obj/items/Blood_Vial
	icon='Basic Needs.dmi'
	icon_state="Blood Vial"
	desc="Drinking this is probably a bad idea."
	Flammable = 0
	verb
		Drink()
			if(usr.KOd==0)
				if(usr.Vampire)
					if(usr.Thirst > 0)
						usr.Thirst-=rand(25,50)
						if(usr.Thirst < 0)
							usr.Thirst = 0
						view(usr)<<"[usr] drinks a vial of blood."
						del(src)
					else
						usr << "You're already completely hydrated."
						return
				else
					if(usr.Thirst == 100)
						usr << "You're already completely dehydrated."
						return
					else
						// We can add a chance for an infection later
						usr.Thirst+=rand(25,50)
						if(usr.Thirst > 100)
							usr.Thirst = 100
						view(usr)<<"[usr] drinks a vial of blood."
						usr << "It's surprisingly salty."
						del(src)

obj/items/Elixir_Of_Replenishment
	icon='enchantmenticons.dmi'
	icon_state="BPRES+"
	desc="Drinking this will temporarily speed up your Willpower recovery outside of combat and make your Lethal Combat Tracker go down quicker.  Be careful though, you can build up a resistance."
	Flammable = 1

	verb
		Use()
			if(usr.KOd==0)// if(usr.Race!="Android")
				usr.HasUsedReplenish++
				usr.TicksOfReplenish+=500/max(1,usr.HasUsedReplenish/10)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				del(src)
obj/items/Elixir_Of_Merriment
	icon='enchantmenticons.dmi'
	icon_state="BPRES+"
	New()
		..()
		icon+=rgb(25,25,25)
	desc="Drinking this will temporarily speed up your Contact Points. It is customarily alcholic. Be careful though, you can build up a resistance."
	Flammable = 1

	verb
		Use()
			if(usr.KOd==0) if(usr.Race!="Android")
				usr.TicksOfMerriment+=500
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				del(src)


obj/items/Book_of_Ages
	icon='enchantmenticons.dmi'
	icon_state="BoG"
	desc="It is said that reading this book will alter your perception of time and age you rapidly. Others say reading it will drive you mad. (One time use that grants +5 Age and 18 hours of XP)"
	Flammable = 1

	verb
		Use()
			if(!usr.HasUsedBookOfAges)
				usr.HasUsedBookOfAges=1
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				usr.Age+=5
				usr.Hair_Age+=5
				usr.XP+=XPRate*18 //6 hours of XP award
//				usr.UpdateStats("XP")
				del(src)
			else usr<<"It would have no effect on you."

obj/items/Nanite_Tube
	icon='Roids.dmi'
	icon_state="2"
	desc="These nanites will age the crap out of your body. (One time use that grants +5 Age and 18 hours of XP)"
	Flammable = 1

	verb
		Use()
			if(!usr.HasUsedNaniteFart)
				usr.HasUsedNaniteFart=1
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				usr.Age+=5
				usr.Hair_Age+=5
				usr.XP+=XPRate*18 //6 hours of XP award
//				usr.UpdateStats("XP")
				del(src)
			else usr<<"It would have no effect on you."

obj/items/Book_of_Fortitude
	icon='enchantmenticons.dmi'
	icon_state="BoEW"
	desc="It is said that reading this book will increase your resistance to damage for a period of time due to its otherworldly accounts of torture and suffering. (One time use, grants extra endurance/damage reduction.)"
	Flammable = 1

	verb
		Use()
			if(!usr.HasUsedBookOfFortitude)
				usr.HasUsedBookOfFortitude=WipeDay
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				del(src)
			else usr<<"It would have no effect on you."
obj/items/Book_of_Lessons
	icon='enchantmenticons.dmi'
	icon_state="BoTT"
	desc="It is said that reading this book will assist you with growing stronger by learning of the great lessons of the past. (One time use. Increases stats, bp and energy gains for 1 year.)"
	Flammable = 1

	verb
		Use()
			if(!usr.HasUsedBookOfLessons)
				usr.HasUsedBookOfLessons=Year
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				del(src)
			else usr<<"It would have no effect on you."
obj/items/Book_of_Power
	icon='enchantmenticons.dmi'
	icon_state="BoTW"
	desc="It is said that reading this book help you achieve greatness. (One time use, grants 5% BP Mod and 20% Base BP)"
	Flammable = 1

	verb
		Use()
			if(!usr.PotentialUnlocked)
				usr.PotentialUnlocked=3
				usr.BPMod*=1.05
				usr.Base*=1.2
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] reads a [src].\n")
				view(usr)<<"[usr] reads the [src]!"
				logAndAlertAdmins("[key_name(usr)] used a [src]",2)
				del(src)
			else usr<<"It would have no effect on you."
mob/var/HasUsedReform=0 
obj/items/Elixir_Of_Reformation
	icon='enchantmenticons.dmi'
	icon_state="PoMM+"
	desc="Drinking this will allow you to redo stats and refunds all refundable MPs."
	Flammable = 1
	verb
		Use()
			if(WipeDay<usr.Reformation_LastUse+5)
				usr<<"You cannot use this until day [usr.Reformation_LastUse+5]"
				return
			if(usr.Offspring)
				usr<<"Offspring may not use this."
				return
			if(usr.Vampire || usr.HasWerewolf)
				usr << "You can not bring yourself to swallow this."
				return
			if(usr.EnablementSlot)
				usr<<"You can not bring yourself to swallow this. (Already have an unique buff.)"
				return
			if(usr.Confirm("Redo stats? (This will remove mutations)"))
				usr.HasUsedReform++
				usr.UBList=list()
				spawn(1)del(src)
				if(!usr.Offspring)
					logAndAlertAdmins("[key_name(usr)] started to redo stats",1)
					usr.Redo_Stats()
					usr.verbs += /mob/proc/donec
					usr.verbs += /mob/proc/bodyc
					usr.verbs += /mob/proc/Skill_Points
					winshow(usr.client,"CharacterCreator",1)
					usr.mind.store_memory("<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key])<hr> [key_name(usr)] started to redo stats<br><hr>")
					usr.CheckRedoneStats()
				if(usr.Race=="Puar"&&usr.FBMAchieved)usr.Magic_Potential-=0.5
				if(usr.Race=="Tuffle"&&usr.FBMAchieved)usr.Int_Mod -=0.5
				usr.HasUsedReform=Year
				usr.MPPurgeRefund()
				usr.UBCheck()
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				usr.Reformation_LastUse=WipeDay

obj/items/Cooking_Bag
	icon='Misc.dmi'
	icon_state="ZenniBag"
	desc="This will contain all of your raw and cooked food, up to 50 items."
	Flammable = 1

obj/items/Mining_Bag
	icon='Misc.dmi'
	icon_state="ZenniBag"
	desc="This will contain all of your raw and forged metal, up to 50 items."
	Flammable = 1
	New()
		..()
		icon-=rgb(10,15,50)

obj/items/Magic_Fishing_Lure
	icon='enchantmenticons.dmi'
	icon_state="DrownedToad"
	desc="Using this will cause nearby water to spontaneously spawn fish."
	Flammable = 1

	verb
		Use()
			if(usr.KOd==0)
				view(usr)<<"[usr] uses the [src] and attacts some fish!"
				for(var/turf/Terrain/Water/W in view(2)) if(prob(80))
					W.HasFish=1
					W.overlays+='Whirlpool.dmi'
				del(src)

obj/items/Prospecting_Toolkit
	icon='Lab.dmi'
	icon_state="Labtop"
	desc="Using this will scan nearby ground for ore."
	Flammable = 1

	verb
		Use()
			if(usr.KOd==0)
				view(usr)<<"[usr] uses the [src] to scan for ore!"
				for(var/turf/Terrain/Ground/W in view(2)) if(prob(10+(usr.Mining_Level/3)))
					if(W.HasOre<=4) W.overlays=null
					if(!W.HasOre) W.HasOre++
					if(prob(25)&&W.HasOre<=2) W.HasOre++
					if(prob(10)&&W.HasOre<=3)
						W.HasOre++
						if(prob(10)&&W.HasOre<=3) W.HasOre++
					switch(W.HasOre)
						if(1) W.overlays+='Copper Ore Small.dmi'
						if(2) W.overlays+='Tin Ore Small.dmi'
						if(3) W.overlays+='Iron Ore  Small.dmi'
						if(4) W.overlays+='Mythril Ore Small.dmi'
				for(var/turf/Terrain/Grass/W in view(2)) if(prob(10+(usr.Mining_Level/3)))
					if(W.HasOre<=4) W.overlays=null
					if(!W.HasOre) W.HasOre++
					if(prob(25)&&W.HasOre<=2) W.HasOre++
					if(prob(10)&&W.HasOre<=3)
						W.HasOre++
						if(prob(10)&&W.HasOre<=3) W.HasOre++
					switch(W.HasOre)
						if(1) W.overlays+='Copper Ore Small.dmi'
						if(2) W.overlays+='Tin Ore Small.dmi'
						if(3) W.overlays+='Iron Ore  Small.dmi'
						if(4) W.overlays+='Mythril Ore Small.dmi'
				del(src)

mob/proc/CookingLevelCheck()
	if(Cooking_XP>=Cooking_Next&&Cooking_Level<TechCap)
		Cooking_XP-=Cooking_Next
		Cooking_Next=round(Cooking_Next*1.06)
		Cooking_Level++
		if(Cooking_XP>=Cooking_Next&&Cooking_Level<TechCap)CookingLevelCheck()
	if(Cooking_Level>=TechCap) Cooking_XP=0
//	UpdateStats("Cooking")
mob/proc/FishingLevelCheck()
	if(Fishing_XP>=Fishing_Next&&Fishing_Level<TechCap)
		Fishing_XP-=Fishing_Next
		Fishing_Next=round(Fishing_Next*1.06)
		Fishing_Level++
		if(Fishing_XP>=Fishing_Next&&Fishing_Level<TechCap)FishingLevelCheck()
	if(Fishing_Level>=TechCap) Fishing_XP=0
//	UpdateStats("Fishing")
mob/var/tmp
	IsFishing=0
	IsCooking=0

obj/items/rawfood
	icon='Food_Fish.dmi'
	Savable=0
	var
		ReqSkill=1
		GivesXP=200
		ResultingFood=null
	verb
		Cook()
			set src in view(1)
			var/HasBoost=0
			if(locate(/obj/items/How_To_Serve_Saiba) in usr) HasBoost=15
			if(usr.Cooking_Level+HasBoost>=ReqSkill)
				if(!usr.IsCooking&&!usr.IsMining&&!usr.IsFishing&&!usr.KOd)
					view(usr)<<"[usr] starts to cook [src]."
					usr.IsCooking=1
					var/CookSpeed=rand(300,600)
					if(locate(/obj/items/furnace/Advanced_Furnace) in view(2,usr)) CookSpeed-=400
					else if(locate(/obj/items/furnace/Basic_Stovetop) in oview(2,usr)) CookSpeed-=200
					if(usr.Cooking_Level+HasBoost>=10) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=25) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=40) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=50) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=60) CookSpeed*=0.9
					if(usr.Cooking_Level+HasBoost>=70) CookSpeed*=0.9
					if(CookSpeed<5)CookSpeed=5
					spawn(CookSpeed) if(src&&usr&&usr.IsCooking)
						view(usr)<<"[usr] has finished cooking [src]."
						var/obj/items/cookedfood/A=new ResultingFood
						var/XPG=GivesXP
						if(usr.RestedTime>world.realtime)XPG*=1.5
						if(usr.InspiredTime>world.realtime)XPG*=1.5
						usr.Cooking_XP+=XPG
						if(usr.HasLiberalArtsDegree)
							usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
							usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)

						usr.CookingLevelCheck()
						if(istype(A,/obj/items/cookedfood))usr.contents+=A
						else A.loc=usr.loc
						if(istype(A,/obj/items/cookedfood))
							A.GivesWPBoost*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesRegenBoost*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesRecovBoost*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesBPTrain*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesEnergyTrain*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.GivesStatTrain*=usr.Cooking_Level+(usr.HasMasterChef*50)
							A.icon-=rgb(50,50,50)
						usr.IsCooking=0
						del(src)
				else usr<<"You may only cook one thing at a time."
			else usr<<"You require cooking level [ReqSkill] to cook this."
	Small_Fish
		desc="This is a small, raw fish."
		icon='Fish small.dmi'
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Small_Fish
	Animal_Meat
		icon='Food Leg.dmi'
		desc="This is a raw animal meat."
		Flammable = 1
		ResultingFood=/obj/items/cookedfood/Cooked_Game_Meat
		ReqSkill=12
		GivesXP=1000

	Medium_Fish
		desc="This is a medium, raw fish."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Medium_Fish
		ReqSkill=10
		GivesXP=750
		icon='Fish medium.dmi'
	Large_Fish
		desc="This is a large, raw fish."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Large_Fish
		ReqSkill=25
		GivesXP=1500
		icon='Fish large.dmi'
	Magic_Fish
		desc="This is a magic, raw fish."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Magic_Fish
		ReqSkill=40
		GivesXP=5000
		icon='Magic Fish.dmi'
	Mana_Fish
		desc="This fish is worth some amount of mana once cooked."
		icon='Mana Fish.dmi'
		Flammable = 1

		ResultingFood=/obj/Mana/Mana_Crystal
		ReqSkill=15
		GivesXP=1000

	Gold_Fish
		desc="This is a worth some amount of resources once cooked."
		Flammable = 1

		ResultingFood=/obj/Resources/Treasure
		ReqSkill=15
		GivesXP=1000
		icon='Gold Fish.dmi'
		New()
			..()
			icon-=rgb(0,20,75)
			icon+=rgb(212,175,55)
	Baby_Shark
		desc="doo doo doo doo doo doo."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Baby_Shark
		ReqSkill=50
		GivesXP=5500
		New()
			src.icon+=rgb(30,50,40)
			..()
	Stat_Fish
		desc="This is a rare fish. It will grant a bonus to stat training."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Stat_Fish
		ReqSkill=30
		GivesXP=3000
		icon='Stat Fish.dmi'
	BP_Fish
		desc="This is a rare fish. It will grant a bonus to BP training."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_BP_Fish
		ReqSkill=30
		GivesXP=3000
		icon='Bp Fish.dmi'
	Energy_Fish
		desc="This is a rare fish. It will grant a bonus to energy training."
		Flammable = 1

		ResultingFood=/obj/items/cookedfood/Cooked_Energy_Fish
		ReqSkill=30
		GivesXP=3000
		New()
			src.icon+=rgb(0,0,90)
			..()
	Crab
		desc="This is a rare fish. It will grant a bonus to energy training."
		Flammable = 1
		icon='CRAB.dmi'
		ResultingFood=/obj/items/cookedfood/Chefs_Special
		ReqSkill=40
		GivesXP=6000

	Rare_Ingredients
		desc="This is a collection of rare ingredients. This will make a very special meal."
		Flammable = 1
		icon='CRAB.dmi'
		ResultingFood=/obj/items/cookedfood/Delicacy
		ReqSkill=50
		GivesXP=15000

mob/var
	HasFoodWP=0
	HasFoodRegen=0
	HasFoodRecov=0
	HasFoodBPTrain=0
	HasFoodStatsTrain=0
	HasFoodEnergyTrain=0
mob/proc/FoodLoss()
	if(HasFoodWP>0)HasFoodWP-=1+(HasHyperEnzymes*1.5)
	if(HasFoodRegen>0)HasFoodRegen-=1+(HasHyperEnzymes*1.5)
	if(HasFoodRecov>0)HasFoodRecov-=1+(HasHyperEnzymes*1.5)
	if(HasFoodBPTrain>0)HasFoodBPTrain-=1+(HasHyperEnzymes*1.5)
	if(HasFoodStatsTrain>0)HasFoodStatsTrain-=1+(HasHyperEnzymes*1.5)
	if(HasFoodEnergyTrain>0)HasFoodEnergyTrain-=1+(HasHyperEnzymes*1.5)
	if(HasFoodRegen<=0)
		HasFoodWP=0
		HasFoodRegen=0
		HasFoodRecov=0
		HasFoodBPTrain=0
		HasFoodStatsTrain=0
		HasFoodEnergyTrain=0
		src<<"You feel as if you could gain the benefits from eating again."
proc/CleanDrops()
	for(var/obj/items/rawfood/cf in world) if(cf.z)
		var/turf/P=cf.loc
		if(cf.z&&!ismob(P))
			view(cf)<<"[cf] rots away."
			del(cf)
		sleep(-1)
	for(var/obj/items/rawore/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			view(cf)<<"[cf] crumbles away."
			del(cf)
		sleep(-1)
	for(var/obj/items/cookedfood/cf in world) if(cf.z)
		var/turf/P=cf.loc
		if(cf.z&&!ismob(P))
			view(cf)<<"[cf] rots away."
			del(cf)
		sleep(-1)
	for(var/obj/items/rawmetal/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			view(cf)<<"[cf] crumbles away."
			del(cf)
		sleep(-1)
	for(var/obj/Mana/Mana_Crystal/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			view(cf)<<"[cf] dissipates."
			del(cf)
		sleep(-1)
	for(var/obj/Resources/Treasure/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			view(cf)<<"[cf] rusts away."
			del(cf)
		sleep(-1)
	for(var/obj/items/Blood_Vial/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			view(cf)<<"[cf] decays away."
			del(cf)
		sleep(-1)
	for(var/obj/items/Wool/cf in world)
		var/turf/P=cf.loc
		if(cf.z&&isturf(P))
			view(cf)<<"[cf] rots away."
			del(cf)
		sleep(-1)
obj/items/fishingpole
	icon='Fishing_Pole.dmi'
	Old_Rod
		icon='Fishing_Pole.dmi'
		desc="This is an old worn down fishing pole.  It is reliable but not very good at catching fish."
		Flammable = 1

	Good_Rod
		desc="This is a good fishing pole. It will reliably catch a fish and make reeling it in quicker, but it is not the best."
		Flammable = 1
		icon='Fishing_Pole-2.dmi'

	Super_Rod
		icon='Fishing_Pole-3.dmi'
		desc="This is an amazing fishing pole. This cutting-edge piece of equipment with virtually summon the fish out of the water and into your hands. This is the best fishing pole."
		Flammable = 1



obj/items/Explosives
	icon='TBomb.dmi'
	Hand_Grenade
		desc="This is a single use grenade that does Offense damage."
		verb/Hand_Grenade()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(!usr.CanAttack(50,src)) return
			spawn del(src)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			//usr.DrainKi(src,"Percent",5)//usr.Ki=max(0,usr.Ki-75)
			usr.DrainKi(src, 1, 50,1)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
	//		hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=7.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=2
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0
	Stun_Grenade
		desc="This is a single use grenade that does 1 tick of stun."
		verb/Stun_Grenade()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(!usr.CanAttack(50,src)) return
			spawn del(src)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			//usr.DrainKi(src,"Percent",5)//usr.Ki=max(0,usr.Ki-75)
			usr.DrainKi(src, 1, 50,1)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
	//		hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=5.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=1
			A.Paralysis=1
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0

	Fire_Bomb
		desc="This is a single use grenade that generates tiles of Burning Embers."
		verb/Fire_Bomb()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(!usr.CanAttack(50,src)) return
			spawn del(src)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			//usr.DrainKi(src,"Perfect",5)//usr.Ki=max(0,usr.Ki-75)
			usr.DrainKi(src, 1, 75,1)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
		//	hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=5.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=2
			A.MakesFire=1
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0
	High_Explosive_Grenade
		desc="This is a single use grenade that does a lot of damage and includes all other grenade effects."
		verb/High_Explosive_Grenade()
			set category="Skills"
			if(usr.RPMode) return
			if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
			if(usr.attacking|usr.Ki<50) return
			if(!usr.CanAttack(50,src)) return
			spawn del(src)
			//if(!Learnable)
			//	Learnable=1
			//	spawn(100) Learnable=0
			if(Experience<100) Experience+=rand(2,4)
			if(Experience>100) Experience=100
			//usr.DrainKi(src,"Perfect",5)//usr.Ki=max(0,usr.Ki-75)
			usr.DrainKi(src, 1, 75,1)
			usr.attacking=3
			for(var/mob/M in range(20,usr)) M.BuffOut("[usr] throws a [src]!")
		//	hearers(6,usr) << 'Charge_Fire.wav'
			flick(usr,"Blast")
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.name=src.name
			A.icon=icon
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			var/MaskDamage=0
			if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
				MaskDamage=MM.Health
				MM.DurabilityCheck(usr)
				break
			if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
			A.Damage=10.5*(usr.BP+MaskDamage)*usr.Off*Ki_Power  //200
			A.Power=(usr.BP+MaskDamage)*Ki_Power
			A.Offense=usr.Off*5
			A.Explosive=2
			A.MakesFire=1
			A.Hellzone=1
			A.dir=usr.dir
			A.loc=usr.loc
			step(A,A.dir)
			if(A) walk(A,A.dir,1)
			usr.attacking=0

obj/items/cookedfood
	icon='Food_Fish.dmi'
	Savable=0
	var
		GivesHunger=0
		GivesWPBoost=0
		GivesRegenBoost=0
		GivesRecovBoost=0
		GivesCapStats=0
		GivesBPTrain=0
		GivesEnergyTrain=0
		GivesStatTrain=0
	verb
		Eat()
			if(usr.KOd==0)
				if(usr.Race=="Android"||usr.Vampire||usr.Dead)
					usr << "You can't eat this!"
					return
				else
					usr.HasFoodWP=GivesWPBoost
					usr.HasFoodRegen=GivesRegenBoost
					usr.HasFoodRecov=GivesRecovBoost
					usr.HasFoodBPTrain=GivesBPTrain
					usr.HasFoodStatsTrain=GivesStatTrain
					usr.HasFoodEnergyTrain=GivesEnergyTrain
					usr.Hunger -= (GivesHunger + rand(-5,5))
					if(usr.Hunger < 0)
						usr.Hunger = 0
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
					view(usr)<<"[usr] eats a [src]."
					del(src)

	Cooked_Small_Fish
		desc="This is a small, cooked fish. This will grant a small regeneration bonus for a period of time."
		Flammable = 1
		icon='Fish small.dmi'
		GivesHunger = 20
		GivesWPBoost=0
		GivesRegenBoost=20
		GivesRecovBoost=0

	Cooked_Game_Meat
		desc="This is a cooked animal meat. This will grant a small regeneration and recovery bonus for a period of time."
		Flammable = 1
		icon='Food Leg.dmi'
		GivesHunger = 35
		GivesWPBoost=0
		GivesRegenBoost=40
		GivesRecovBoost=40

	Cooked_Medium_Fish
		desc="This is a medium, cooked fish. This will grant a small regeneration and recovery bonus for a period of time."
		Flammable = 1
		icon='Fish medium.dmi'
		GivesHunger = 35
		GivesWPBoost=0
		GivesRegenBoost=40
		GivesRecovBoost=40

	Cooked_Large_Fish
		desc="This is a large, cooked fish. This will grant a small regeneration, recovery and willpower regeneration bonus for a period of time."
		Flammable = 1
		icon='Fish large.dmi'
		GivesHunger = 50
		GivesWPBoost=60
		GivesRegenBoost=60
		GivesRecovBoost=60

	Cooked_Magic_Fish
		desc="This is a magic, cooked fish. This will grant a small regeneration, recovery and willpower regeneration bonus for a period of time. This will also cap all of your stats."
		Flammable = 1
		icon='Magic Fish.dmi'
		GivesHunger = 50
		GivesWPBoost=60
		GivesRegenBoost=60
		GivesRecovBoost=60
		GivesCapStats=1

	Cooked_Baby_Shark
		desc="doo doo doo doo doo doo."
		Flammable = 1
		GivesHunger = 65
		GivesWPBoost=80
		GivesRegenBoost=80
		GivesRecovBoost=80
		New()
			src.icon+=rgb(20,40,20)
			..()

	Chefs_Special
		desc="The chef made this just for you."
		Flammable = 1
		icon='Tiny_Crab.dmi'
		GivesHunger = 80
		GivesWPBoost=85
		GivesRegenBoost=85
		GivesRecovBoost=85
		verb/Change_Recipe()
			set src in usr
			desc=input("Change the description of this.") as text
			usr<<"desc set to [desc]"

	Cooked_Stat_Fish
		desc="This is a rare fish. It will grant a bonus to stat training."
		Flammable = 1
		icon='Stat Fish.dmi'
		GivesHunger = 30
		GivesWPBoost=30
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesStatTrain=30

	Cooked_BP_Fish
		desc="This is a rare fish. It will grant a bonus to BP training."
		Flammable = 1
		icon='Bp Fish.dmi'
		GivesHunger = 30
		GivesWPBoost=30
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesBPTrain=30

	Cooked_Energy_Fish
		desc="This is a rare fish. It will grant a bonus to energy training."
		Flammable = 1
		GivesHunger = 30
		GivesWPBoost=10
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesEnergyTrain=30
		New()
			src.icon+=rgb(0,0,90)
			..()

	Delicacy
		desc="This is a very special meal. It provides every food buff available."
		Flammable = 1
		icon='FoodTurkey.dmi'
		GivesHunger = 90
		GivesWPBoost=30
		GivesRegenBoost=30
		GivesRecovBoost=30
		GivesCapStats=1
		GivesBPTrain=30
		GivesEnergyTrain=30
		GivesStatTrain=30

	Cheese
		desc="This some cheese. Just cheese, nothing else."
		Flammable = 1
		icon='cheese.dmi'
		GivesHunger = 100
		GivesWPBoost=500
		GivesRegenBoost=500
		GivesRecovBoost=500
		GivesCapStats=1
		GivesBPTrain=500
		GivesEnergyTrain=500
		GivesStatTrain=500

obj/items/Mana_Biscuit
	desc="This biscuit has been conjured by a Mage, however they can never fully sate you."
	Flammable = 1
	icon='Cookie.dmi'
	verb
		Eat()
			if(usr.KOd==0)
				if(usr.Vampire)
					usr << "This does not do anything for you."
					return
				usr.Thirst-=rand(25,50)
				usr.Hunger-=rand(25,50)
				if(usr.Thirst < 25)
					usr.Thirst = 25
				if(usr.Hunger < 25)
					usr.Hunger = 25
				view(usr)<<"[usr] eats a conjured mana biscuit."
				del(src)

obj/items/Elixir_Of_Health
	icon='Health Potion.dmi'
	desc="Drinking this will temporarily increase Regeneration ticks by 3x.  It will decrease over time."
	var/Increase=3
	Flammable = 1

	verb
		Use()
			if(usr.KOd==0) if(usr.Race!="Android")
				if(usr.HealthPotion<6) usr.HealthPotion+=Increase
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				usr.Calm()
				usr.Thirst = 0
				del(src)

obj/items/Elixir_Of_Empowerment
	icon='enchantmenticons.dmi'
	icon_state="BPSTR++"
	desc="Drinking this will automatically cap all of your stats."
//	var/Increase=3
	Flammable = 1

	verb
		Use()
			if(Year<usr.HasUsedEmpowerment+3)
				usr<<"You cannot use this until year [usr.HasUsedEmpowerment+3]."
				return
			if(usr.KOd==0)
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drinks a [src].\n")
				view(usr)<<"[usr] drinks a mysterious potion!"
				usr.Calm()
				usr.Thirst = 0
				usr.HasUsedEmpowerment=Year
				usr.CapStats()
				del(src)

obj/items/Elixir_Of_Life
	icon='enchantmenticons.dmi'
	icon_state="PoM1"
	Level=1

//	Injection=1
	desc="This extends life by 25 years."
	verb/Use(mob/A in view(1,usr))
		if(A.Race=="Android")
			usr<<"You can not use this on an Android."
			return
		if(A==usr|A.Frozen|A.KOd)
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Elixer of Life!\n")
			A.Decline+=25
			A.Ki=10
			A.Fatigue = 0
			del(src)

mob/var/LastEOU=0
obj/items/Elixir_Of_Uncertainty
	icon='enchantmenticons.dmi'
	icon_state="PoM1"
	New()
		..()
		icon+=rgb(15,50,15)
	Level=1
//	Injection=1
	desc="This will allow you to refund 1 tier 3 or 4 skill you bought with XP. 5 year cooldown."
	verb/Use()
		if(usr.EnablementSlot)
			usr<<"You can not bring yourself to swallow this. (Already have an unique buff.)"
			return
		if(usr.LastEOU+4>Year)
			usr<<"You must wait until year [usr.LastEOU+5] to use this again."
			return
		view(usr)<<"[usr] drinks an [src]!"
		usr.LastEOU=Year
		usr.XPSkillRefund()
		del(src)


mob/proc/XPSkillRefund()
	var/list/Skillies=list()
	for(var/Skill/S in src) if(S.Tier==3||S.Tier==4)if(!S.RankKit) if(!findtext(S.desc,"taught this")) Skillies+=S
	Skillies+="Cancel"
	var/Skill/SS=input("Refund which skill?") in Skillies
	if(SS=="Cancel")return
	if(src.Confirm("Would you like to refund [SS] for [SS.Tier==4?"700":"350"] XP?"))
		switch(SS.Tier)
			if(4) src.XP+=700
			if(3) src.XP+=350
		LastEOU=Year
		del(SS)


//mob/var/LastRespec=0
obj/items/Elixir_Of_Respec
	icon='enchantmenticons.dmi'
	icon_state="BPEND"
	Level=1
	desc="This will allow you to reduce a stat by 50%. (Reduces a stat to a minimum of 25% of the stat cap.)"
	verb/Use()
		if(usr.Confirm("Use [src]?"))
			view(usr)<<"[usr] drinks a mysterious potion!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses an Elixer of Respec!\n")
			var/RC=input(usr,"Choose a stat to reduce","Potion of Respec") in list("Might","Endurance","Speed","Offense","Defense")
			switch(RC)
				if("Might")
					if(usr.BaseStr/usr.StrMod>=SoftStatCap*0.25)
						usr.BaseStr/=2
						if(usr.BaseStr/usr.StrMod>=SoftStatCap*0.25) usr.BaseStr=SoftStatCap*0.25*usr.StrMod
					else
						usr<<"This will have no effect."
						return
				if("Endurance")
					if(usr.BaseEnd/usr.EndMod>=SoftStatCap*0.25)
						usr.BaseEnd/=2
						if(usr.BaseEnd/usr.EndMod>=SoftStatCap*0.25) usr.BaseEnd=SoftStatCap*0.25*usr.EndMod
					else
						usr<<"This will have no effect."
						return
				if("Speed")
					if(usr.BaseSpd/usr.SpdMod>=SoftStatCap*0.25)
						usr.BaseSpd/=2
						if(usr.BaseSpd/usr.SpdMod>=SoftStatCap*0.25) usr.BaseSpd=SoftStatCap*0.25*usr.SpdMod
					else
						usr<<"This will have no effect."
						return
				if("Offense")
					if(usr.BaseOff/usr.OffMod>=SoftStatCap*0.25)
						usr.BaseOff/=2
						if(usr.BaseOff/usr.OffMod>=SoftStatCap*0.25) usr.BaseOff=SoftStatCap*0.25*usr.OffMod
					else
						usr<<"This will have no effect."
						return
				if("Defense")
					if(usr.BaseDef/usr.DefMod>=SoftStatCap*0.25)
						usr.BaseDef/=2
						if(usr.BaseDef/usr.DefMod>=SoftStatCap*0.25) usr.BaseDef=SoftStatCap*0.25*usr.DefMod
					else
						usr<<"This will have no effect."
						return
			del(src)

obj/items/Mutagen_Injection
	icon='Roids.dmi'
	icon_state="2"
	Level=1

	desc="This will inject a mutation into someone that has less than two mutations already."
	verb/Use()
		if(usr.MutationNumber<2)
			if(usr.Race=="Android")
				usr<<"You can not use this on an Android."
				return
			view(usr)<<"[usr] injects themselves with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses a Mutagen Injection!\n")
			usr.GetMutation()
			del(src)
		else usr<<"You already have mutations."

obj/items/Self_Replicating_Code_Injector
	icon='enchantmenticons.dmi'
	icon_state="BPEND"
	Level=1

	desc="This will give an Android a mutation. They can only have one."
	verb/Use()
		if(usr.MutationNumber<2)
			if(usr.Race!="Android")
				usr<<"Only an Android can use this."
				return
			view(usr)<<"[usr] injects themselves with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses a [src]!\n")
			usr.GetMutation()
			del(src)
		else usr<<"You already have mutations."


obj/items/Medical_Assessment
	icon='Lab.dmi'
	icon_state="Lab2"
	Level=1

	desc="This will perform a medical assessment of a person and tell you information about them based on your intelligence."
	verb/Use(mob/M in view(5))
		if(usr.Confirm("Use [src] on [M]?"))
			view(usr)<<"[usr] performs a medical assessment of [M]."
			for(var/mob/player/P in view(usr)) P.MedicalAssessment(M,usr.Int_Level,usr.Int_Mod)
			del(src)






mob/proc/MedicalAssessment(mob/M,SkillWith,SkillMod)
	var/A={"[M] is a [M.Size] [M.gender]<br>
Health: [M.Health] Max Health: [M.MaxHealth]
Body: [M.Body*100]%"}
	if(SkillWith>20)A+={"Age: [M.Age] Incline Age: [M.InclineAge] Decline Age: [M.Decline]"}

/*
Energy: [round(M.MaxKi)] ([M.KiMod] Mod) ([M.KiMult] Mult [round(M.BaseMaxKi/M.KiMod)] Weighted)</td></tr>
Strength: [round(M.Str)] ([M.StrMod] Mod) ([M.StrMult] Mult [round(M.BaseStr/M.StrMod)] Weighted)</td></tr>
Endurance: [round(M.End)] ([M.EndMod] Mod) ([M.EndMult] Mult [round(M.BaseEnd/M.EndMod)] Weighted)</td></tr>
Speed: [round(M.Spd)] ([M.SpdMod] Mod) ([M.SpdMult] Mult [round(M.BaseSpd/M.SpdMod)] Weighted)</td></tr>
Force: [round(M.Pow)] ([M.PowMod] Mod) ([M.PowMult] Mult [round(M.BasePow/M.PowMod)] Weighted)</td></tr>
Offense: [round(M.Off)] ([M.OffMod] Mod) ([M.OffMult] Mult [round(M.BaseOff/M.OffMod)] Weighted)</td></tr>
Defense: [round(M.Def)] ([M.DefMod] Mod) ([M.DefMult] Mult [round(M.BaseDef/M.DefMod)] Weighted)</td></tr>
Regeneration: [M.Regeneration] ([M.RegenMult] x [M.BaseRegeneration] Base)</td></tr>
Recovery: [M.Recovery] ([M.RecovMult] x [M.BaseRecovery] Base)</td></tr>*/


	if(SkillWith>60)A+={"
Energy: [round(M.MaxKi)] ([M.KiMult] Mult [round(M.BaseMaxKi/M.KiMod)] Weighted)
Strength: [round(M.Str)] ([M.StrMult] Mult [round(M.BaseStr/M.StrMod)] Weighted)
Endurance: [round(M.End)] ([M.EndMult] Mult [round(M.BaseEnd/M.EndMod)] Weighted)
Speed: [round(M.Spd)] ([M.SpdMult] Mult [round(M.BaseSpd/M.SpdMod)] Weighted)
Force: [round(M.Pow)] ([M.PowMult] Mult [round(M.BaseStr/M.StrMod)] Weighted)
Offense: [round(M.Off)] ([M.OffMult] Mult [round(M.BaseOff/M.OffMod)] Weighted)
Defense: [round(M.Def)]  ([M.DefMult] Mult [round(M.BaseDef/M.DefMod)] Weighted)
Regeneration: [M.Regeneration] ([M.RegenMult] x [M.BaseRegeneration] Base)
Recovery: [M.Recovery] ([M.RecovMult] x [M.BaseRecovery] Base)
Weighted Stats: [Commas(round(M.WeightedStats))]<br>
Potential (Gain Multiplier): [(M.GainMultiplier)]<br>


<br>"}




/*{"

Energy: [round(M.MaxKi)] ([M.KiMod] Mod) ([M.KiMult] Mult [round(M.BaseMaxKi/M.KiMod)] Weighted)
Strength: [round(M.Str)] ([M.StrMod] Mod) ([M.StrMult] Mult [round(M.BaseStr/M.StrMod)] Weighted)
Endurance: [round(M.End)] ([M.EndMod] Mod) ([M.EndMult] Mult [round(M.BaseEnd/M.EndMod)] Weighted)
Speed: [round(M.Spd)] ([M.SpdMod] Mod) ([M.SpdMult] Mult [round(M.BaseSpd/M.SpdMod)] Weighted)
Force: [round(M.Pow)] ([M.PowMod] Mod) ([M.PowMult] Mult [round(M.BasePow/M.PowMod)] Weighted)
Offense: [round(M.Off)] ([M.OffMod] Mod) ([M.OffMult] Mult [round(M.BaseOff/M.OffMod)] Weighted)
Defense: [round(M.Def)] ([M.DefMod] Mod) ([M.DefMult] Mult [round(M.BaseDef/M.DefMod)] Weighted)
Regeneration: [M.Regeneration] ([M.RegenMult] x [M.BaseRegeneration] Base)
Recovery: [M.Recovery] ([M.RecovMult] x [M.BaseRecovery] Base)"}*/

/*{"

Energy: [round(M.MaxKi)] ([M.KiMult] Mult [round(M.BaseMaxKi/M.KiMod)] Weighted)
Strength: [round(M.Str)] ([M.StrMult] Mult [round(M.BaseStr/M.StrMod)] Weighted)
Endurance: [round(M.End)] ([M.EndMult] Mult [round(M.BaseEnd/M.EndMod)] Weighted)
Speed: [round(M.Spd)] ([M.SpdMult] Mult [round(M.BaseSpd/M.SpdMod)] Weighted)
Force: [round(M.Pow)] ([M.PowMult] Mult [round(M.BasePow/M.PowMod)] Weighted)
Offense: [round(M.Off)] ([M.OffMult] Mult [round(M.BaseOff/M.OffMod)] Weighted)
Defense: [round(M.Def)]  ([M.DefMult] Mult [round(M.BaseDef/M.DefMod)] Weighted)
Regeneration: [M.Regeneration] ([M.RegenMult] x [M.BaseRegeneration] Base)
Recovery: [M.Recovery] ([M.RecovMult] x [M.BaseRecovery] Base)



"}*/


	else if(SkillWith>40)A+={"
Energy: [round(M.MaxKi)]
Strength: [round(M.Str)]
Endurance: [round(M.End)]
Speed: [round(M.Spd)]
Force: [round(M.Pow)]
Offense: [round(M.Off)]
Defense: [round(M.Def)]
Regeneration: [M.Regeneration]
Recovery: [M.Recovery]<br>
Weighted Stats: [Commas(round(M.WeightedStats))]<br>

"}
	if(SkillWith>80)A+={"
Max Anger: [M.MaxAnger]% ([M.AngerMult] x)
Zenkai: [Commas(M.ZenkaiPower)] ([M.Zenkai] x)
Gravity: [round(M.GravMastered)]
Combat Mod Total: [((M.StrMod+M.EndMod+M.SpdMod+M.OffMod+M.DefMod))]<br>"}
	if(SkillWith>100)
		if(M.MutationNumber) A+="<br><font color=#FFFF99>Mutations: [M.MutationNumber]<br>[M.Mutations.Join(", ")]"
		else A+="<br><font color=#FFFF99>No Mutations<br>"

	if(usr.Int_Mod>=6) A+="<br><font color=#FFFF99>Infection Status: [M.Infection?"Infected":"Uninfected"]<br>"

	src<<"[A]"


// ### YEMMA FRUIT ###

obj/items/Fruit
	icon='Yemma Fruit.dmi'
	//Add=50 //minutes of training

	Flammable = 1
	var/XP = 50
	desc="Eating this will cap your BP if it is the first time you are eating one. It will also grant you +15% of your\
	Base as temporary BP that wears off over time for your first two eaten. It also gives you the experience of its creator, unless you have more than them, everytime you eat one."
	verb/Eat()
		usr.Fruits++
		usr.Hunger = 0
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats [src]!\n")
		if(usr.Fruits<2)
			if(usr.Base<TrueBPCap*usr.BPMod) usr.Base=TrueBPCap*usr.BPMod
			usr.CapStats(1)
		//	if(usr.BaseMaxKi<EnergyHardCap*usr.KiMod) usr.BaseMaxKi=EnergyHardCap*usr.KiMod
		if(usr.Fruits<3) usr.RacialPowerAdd+=usr.Base*0.15
		if(usr.GainMultiplier <= src.XP) usr.GainMultiplier = src.XP
		view(usr)<<"[usr] eats a [src]"
		del(src)

/*

//### POISON ###

obj/items/Poison_Injection
//	Injection=1
	icon='Poison Injection.dmi'
	Level=1

	/*verb/Use(mob/A in view(1,usr))
		if(A==usr|A.KOd|A.Frozen) if(A.Race!="Android")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Poison (Level: [src.Level])!\n")
			A.Poisoned+=Level
			del(src)*/

// ### ANTIVIRUS ###

obj/items/Antivirus
	icon='Antivirus.dmi'

	Level=1
	/*verb/Use() if(usr.Race!="Android")
		view(usr)<<"[usr] uses the [src] and all infection disappears"
		for(var/mob/player/M in view(usr))
			if(!M.client) return
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses Antivirus and all infection disappears!\n")
		//usr.Heart_Virus_Cure()
		usr.Poisoned=0
		del(src)*/

//### STEROIDS ###

*/
obj/items/Steroid_Injection
	icon='Roids.dmi'
	Level=1
	desc="Level 1 Steroid Injection. This will increase Battle Power by up to 30% of your base, but decrease Regeneration and Recovery by the same factor, and Refire between attacks. The more steroids you take the longer \
		the effects take to wear off, it could even be years. If you die however, the effects disappear instantly and you are returned to normal. It will also make you infertile until the BP boost wears off."

//	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.KOd) if(A.Race!="Android")
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with Steroids (Level: [src.Level])!\n")
			if(A.client)
				A.RoidPower+=Level*A.BPMod
				if(A.RoidPower>A.Base*0.3) A.RoidPower=A.Base*0.3
			else A.BP+= 100*Level*A.BPMod
			for(var/obj/Mate/B in A) B.LastUse=WipeDay+5
			del(src)
			spawn usr.Steroid_Wearoff()

	verb/Upgrade()
		set src in view(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value/4000*usr.Int_Mod)]") as num
			if(Amount>round(A.Value/4000*usr.Int_Mod)) Amount=round(A.Value/4000*usr.Int_Mod)
			if(Amount<0) Amount=0
			Level+=Amount
			A.Value-=Amount*4000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
			name="Steroids x[Level]"
		desc="Level [Level] [src]. This will increase Battle Power by up to 30% of your base, but decrease Regeneration and Recovery by the same factor, and Refire between attacks. The more steroids you take the longer \
		the effects take to wear off, it could even be years. If you die however, the effects disappear instantly and you are returned to normal. It will also make you infertile until the BP boost wears off."


mob/proc/Bandages()
	if(IsBandaged)
		overlays-='Torso Bandage.dmi'
		IsBandaged=0
		view(20,src) << "[src]'s bandages fall away."


// ### Senzu ###
mob/var/LastUsedSenzu=0
obj/items/Senzu
	icon='Senzu.dmi'
	name="Senzu"
	desc="Eating this will temporarily increase Regeneration by 3x.  It will decrease over time and will increase Willpower by +5."
	var/Increase=6
	var/division=1
	Flammable = 1

	New()
		pixel_x+=rand(-16,16)
		pixel_y+=rand(-16,16)

	verb
		Eat()
			if(usr.KOd==0)
				if(usr.LastUsedSenzu==WipeDay)
					usr<<"You can only eat one of these a day."
					return
				usr.LastUsedSenzu=WipeDay
				if(usr.Senzu<6) usr.Senzu+=Increase
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
				view(usr)<<"[usr] eats a [src]"
				usr.Calm()
				usr.Willpower+=5
				usr.Hunger = 0
				usr.Thirst = 0
				usr.Fatigue = 0
				if(usr.Willpower>usr.MaxWillpower)usr.Willpower=usr.MaxWillpower
				spawn del(src)
			else usr<<"You can't eat a Senzu while unconscious"
		Throw(mob/M in oview(usr))
			view(usr)<<"[usr] throws a Senzu to [M]"
			missile('Senzu.dmi',usr,M)
			sleep(3)
			view(usr)<<"[M] catches the Senzu"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
			Move(M)
		Use_on(mob/M in oview(1))
			if(M.KOd)
				if(M.LastUsedSenzu==WipeDay)
					usr<<"You can only eat one of these a day and they have already."
					return
				M.LastUsedSenzu=WipeDay
				view(usr)<<"[usr] gives a [src] to [M]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] catches the [src].\n")
				M.icon_state=""
				if(M.Senzu<6) M.Senzu+=Increase
				M.Willpower+=5
				M.Hunger = 0
				M.Thirst = 0
				M.Fatigue = 0
				if(M.Willpower>M.MaxWillpower)M.Willpower=M.MaxWillpower
				M.Un_KO()
				spawn del(src)
			else usr<<"You can only use this on an unconscious person."
		Split()
			if(Increase<=1)
				usr<<"This is too small to split any further"
				return
			view(usr)<<"[usr] splits a [src] in half"
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] splits a [src] in half.\n")
			var/amount=2
			while(amount)
				var/obj/items/Senzu/A=new
				A.division=division*2
				A.Increase=Increase*0.5
				A.name="1/[A.division] Senzu"
				usr.contents+=A
				amount-=1
			del(src)


Skill/Support/PlantSenzu
	Experience=100
	UB1="Bestial Wrath"
	UB2="Fungal Plague"
	desc="This is how you grow senzu beans. You get 1.5 beans a day.."
	Tier=3
	RequiresApproval=1
	var/Uses=0
	var/MaxUses=1
	verb/Plant_Senzu()
		set category="Other"
		MaxUses=round(WipeDay*1.5)
		if(Uses>=MaxUses)
			usr<<"You must wait to use this."
			return
		usr<<"[MaxUses-Uses] remaining seeds..."
		var/obj/items/Senzu/A=new
		Uses++
		A.loc=usr.loc
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

//### LSD ###
obj/var/Injection=0

obj/items/LSD
	icon='LSD.dmi'
	Level=1

	desc="This will cause you to hallucinate and become intoxicated."
	Injection=1
	verb/Use(mob/A in view(1,usr))
		if(A==usr|A.Frozen|A.KOd)
			view(usr)<<"[usr] injects [A] with a mysterious needle!"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] injects [A] with LSD (level: [src.Level]!\n")
			if(A.client) A.LSD(src.Level)
			del(src)
	verb/Upgrade()
		set src in view(1)
		for(var/obj/Resources/A in usr)
			var/Amount=input("How many levels do you want to add? Up to [Commas(A.Value)]") as num
			if(Amount>round(A.Value)) Amount=round(A.Value)
			if(Amount<0) Amount=0
			Level+=Amount*usr.Int_Mod
			A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
			view(usr)<<"[usr] upgraded the [src] to level [Level]"
		desc="Level [Level] [src]."

mob/proc/LSD(var/Level)
	spawn(100)
	while(src&&Level>1)
		src<<"OSHIT!"
		client.dir=pick(SOUTH,EAST,WEST,SOUTHEAST,SOUTHWEST,NORTHEAST,NORTHWEST)
		sleep(rand(10,600))
		Level--
		if(client.dir==NORTH) return
