

mob/proc/LowResourceHTFUpdate()//changed from looping through all players to being a proc that each player has running
	while(src)
		if(Vampire) Thirst += rand(0.25,1)
		else if(Race=="Namekian"&&!AndroidLevel&&!Vampire&&!Dead)
			var/random=rand(1,5)
			if(random == 1||random == 4) Thirst += 1
			else if(random == 2||random == 5) Fatigue += 0.5 / (1 * (HasBoundlessStamina + 1))
			else
				Thirst += 1
				Fatigue += 0.5 / (1 * (HasBoundlessStamina + 1))
		else if(Race!="Android"&&Race!="Namekian"&&!AndroidLevel&&!Vampire&&!Dead)
			var/random=rand(1,10)
			if(random == 1||random == 8) Hunger += 1
			else if(random == 2||random == 9) Thirst += 1
			else if(random == 3) Fatigue += 0.5 / (1 * (HasBoundlessStamina + 1))
			else if(random == 4||random == 10)
				Hunger += 1
				Thirst += 1
			else if(random == 5)
				Hunger += 1
				Fatigue += 0.5 / (1 * (HasBoundlessStamina + 1))
			else if(random == 6)
				Thirst += 1
				Fatigue += 0.5 / (1 * (HasBoundlessStamina + 1))
			else
				Hunger += 1
				Thirst += 1
				Fatigue += 0.5 / (1 * (HasBoundlessStamina + 1))
		if(Hunger > 100) Hunger = 100
		if(Thirst > 100) Thirst = 100
		if(Fatigue > 100) Fatigue = 100
		HungerThirstFatigue()
		sleep(3000)


obj/items/Water_Purifier
	icon='Basic Needs.dmi'
	icon_state="Water Purifier"
	density=1
	Grabbable=0
	desc="This is used to purify salt water into drinkable fresh water. It will slowly decay over time."
	var/purifying=0
	New()
		spawn(9000)
			if(src)
				view(src) << "The Water Purifier decays!"
				del(src)
	verb/Purify_Water()
		set src in oview(1)
		if(!src.purifying)
			for(var/obj/items/Salt_Water/W in usr.contents)
				if(W)
					src.purifying = 1
					usr << "You begin purifying salt water!"
					del(W)
					break

			if(!src.purifying)
				usr << "You need salt water to perform this action!"
				return

			var/HasBoost=0
			if(locate(/obj/items/How_To_Serve_Saiba) in usr) HasBoost=15
			var/CookSpeed=1000
			if(locate(/obj/items/furnace/Advanced_Furnace) in view(2,usr)) CookSpeed-=400
			else if(locate(/obj/items/furnace/Basic_Stovetop) in oview(2,usr)) CookSpeed-=200
			if(usr.Cooking_Level+HasBoost>=10) CookSpeed*=0.9
			if(usr.Cooking_Level+HasBoost>=25) CookSpeed*=0.9
			if(usr.Cooking_Level+HasBoost>=40) CookSpeed*=0.9
			if(usr.Cooking_Level+HasBoost>=50) CookSpeed*=0.9
			if(usr.Cooking_Level+HasBoost>=60) CookSpeed*=0.9
			if(usr.Cooking_Level+HasBoost>=70) CookSpeed*=0.9
			if(CookSpeed<5)CookSpeed=5

			spawn(CookSpeed) if(src&&usr)
			//spawn(1000)
				var/Amount=0
				for(var/obj/O in range(0,src)) if(O.loc != usr) Amount++
				if(Amount>=20)
					usr << "Nothing more can be created on this spot."
					src.purifying = 0
					return
				var/obj/items/Fresh_Water/W = new/obj/items/Fresh_Water
				W.loc = src.loc
				src.purifying = 0
				usr << "Your water has finished purifying!"
				return
		else
			usr << "This is already purifying something!"
			return

obj/items/Wool
	icon = 'Basic Needs.dmi'
	icon_state = "Wool"
	density = 0
	desc="This drops from certain mobs and is used to create Bedrolls."
	verb/Make_Bedroll()
		var/obj/items/Bedroll/B = new/obj/items/Bedroll
		B.loc = usr
		usr << "You created a Bedroll!"
		del(src)

obj/items/Bedroll
	icon = 'Basic Needs.dmi'
	icon_state = "Bedroll"
	density = 0
	desc="You can use this to sleep anywhere at the cost of some comfortability."
	