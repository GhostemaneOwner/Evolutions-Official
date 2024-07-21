

obj/var/cost = 0
obj/items
	var
		magical = 0
		add_energy=0
		add_bp = 0
		add_str = 0
		add_end = 0
		add_spd = 0
		add_off = 0
		add_def = 0
		add_force = 0
		add_recov = 0
		add_regen = 0
		autosmelt = 0
		TotalEnchants=0
mob/var/tmp/Creating=0
obj/Magic
	var/displaykey
	var/Creates
	var/Cost=0
	var/Mod=1
	Level=1
	verb
		Inspect()
			set src in world
			set name = "Inspect"
			//set category = "Other"
			if(src.Creates)
				var/obj/A=new src.Creates
				usr << A.desc
				del(A)
	Click()
		if(usr.Creating)
			usr<<"You may only make one thing at a time."
			return
		if(!usr.Confirm("Create [src]?")) return
		for(var/obj/Mana/B in usr)
			if(usr.Creating)
				usr<<"You may only make one thing at a time."
				return
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(O.loc != usr) Amount++
			if(global.rebooting)
				usr << "Unable to make any new technology while a reboot is in progress."
				return
			for(var/area/UndergroundMine/W in view(3,usr))
				usr<<"You cannot do that here."
				return
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			if(B.Value < round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))
				usr<<"You do not have the mana to create this."
				return
			if(istype(src,/obj/Magic/Mana_Pylon))
				var/NumP=0
				for(var/obj/Mana_Pylon/MP) if(MP.Builder=="[usr.real_name]") NumP++
				if(NumP>=usr.Magic_Potential*3)
					usr<<"You already have too many Pylons. ([NumP] total)"
					return
			usr.Creating=1
			usr.AllOut("Crafting time for [src] is [((1*Level)/usr.Magic_Potential)/10] seconds.")
			spawn((1*Level)/usr.Magic_Potential)
				if(!usr.Creating)return
				B.Value -= round((initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))
				var/obj/A=new Creates
				A.cost= round((initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))
				if(istype(A,/obj/items/Armor))
					var/x=input(usr,"Choose the icon for [src]") in list("Armor 1","Bardock","Green","Black","Armor 2","Armor 3","Armor 4","Armor 5","Armor 6", "Armor 7", "Armor 8")
					switch(x)
						if("Armor 1")src.icon='Armor1.dmi'
						if("Bardock")src.icon='BardockArmor.dmi'
						if("Black")src.icon='TurlesArmor.dmi'
						if("Green")src.icon='Nappa Armor.dmi'
						if("Armor 2")src.icon='Armor2.dmi'
						if("Armor 3")src.icon='Armor3.dmi'
						if("Armor 4")src.icon='Armor4.dmi'
						if("Armor 5")src.icon='Armor5.dmi'
						if("Armor 6")src.icon='Armor6.dmi'
						if("Armor 7")src.icon='Armor7.dmi'
						if("Armor 8")src.icon='White Male Armor.dmi'

				if(istype(A,/obj/items/Sword))
					var/x=input(usr,"Choose the icon for [src]") in list("Trunks","Knight","Demon","Katana","Random","Short","Rebellion","Buster","Great", "Flame", "Samurai")
					switch(x)
						if("Trunks") src.icon='Sword_Trunks.dmi'
						if("Knight") src.icon='Sword 2.dmi'
						if("Demon") src.icon='Sword 1.dmi'
						if("Katana") src.icon='Item - Katana 2.dmi'
						if("Random") src.icon='Item - Katana.dmi'
						if("Short") src.icon='Short Sword.dmi'
						if("Rebellion") src.icon='Item, Sword 1.dmi'
						if("Buster") src.icon='Item, Buster Sword.dmi'
						if("Great") src.icon='Item, Great Sword.dmi'
						if("Flame") src.icon='Sword Flame.dmi'
						if("Samurai") src.icon='Sword, Samurai.dmi'

				if(A)
					view(20,usr) << "[usr] creates a [A]."
					A.loc=usr.loc
				//	for(var/obj/A=new Creates)

					A.Builder="[usr.real_name]"
					usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name] ([A])")
					global.worldObjectList+=A


				else
					B.Value += round(initial(Cost)/usr.Magic_Potential)
					usr<<"There are no more available ship interiors, you cannot create this."
					del(A)
				if(istype(A,/obj/Door))
					A:Grabbable=0
					A.Builder="[usr.real_name]"
					var/New_Password=input(usr,"Enter a password or leave blank") as text
					if(!A) return
					A.Password=New_Password
				if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
					var/obj/items/O=A
					O.MaxBPAdd+=5
					O.MasterSmith=1
				if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
					var/obj/items/Armor/O=A
					O.KineticBarrier+=5
					O.MasterSmith=1
				if(istype(A,/obj/items/Enchanted_Doll))
					A.Builder="[usr.real_name]"
					usr.MadeADoll++
					var/N=input(usr,"Enter a name.") as text
					if(!N)
						var/X = rand(100,900)
						A.name = "[X]"
					else A.name=N
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Spirit Doll",null) as text
				usr.Creating=0
				if(istype(A,/obj/items)) if(usr.Confirm("Add a custom description?"))
					var/obj/items/OO=A
					OO.CustomDesc=input("Description for [A]") as text

		/*	if(A)
			//	for(var/obj/A=new Creates)
				if(A==/obj/items/Drone)
					Creates=/mob/Drone         This code isn't nearly done yet.  I'm going to come back to it later.  In order for Drones to be placed in-game,
					either the tech system needs to be completely redesigned, or I have to jury-rig a fix in the mean-time.	*/


	New()
		if(Creates)
			var/obj/A=new Creates
		//	if(A.name)
			//	Creates=A.name
			if(A)
				icon=A.icon
				icon_state=A.icon_state
				del(A)
		else del(src)

	Magic_Goo
		Level=3
		Creates=/obj/TrainingEq/Magic_Goo
		Cost=4000
	Boxing_Gloves
		Level=4
		Creates=/obj/items/Boxing_Gloves
		Cost=1000
	Armor
		Level=5
		Creates=/obj/items/Armor/Normal_Armor
		Cost=250000
	Sword
		Level=6
		Creates=/obj/items/Sword/Normal_Sword
		Cost=500000
	Practice_Sword
		Level=6
		Creates=/obj/items/Sword/Practice_Sword
		Cost=125000
	Magic_Gauntlets
		Level=6
		Creates=/obj/items/Gauntlets/Normal_Gauntlets
		Cost=500000
	Basic_Helmet
		Level=6
		Creates=/obj/items/Helmet/Basic_Helmet
		Cost=200000
	Dummy
		Level=8
		Creates=/obj/TrainingEq/Dummy
		Cost=5000
	Door_Pass
		Level=9
		Creates=/obj/items/Door_Pass
		Cost=3000
	Magic_Hammer
		Level=9
		Creates=/obj/items/Hammer/Normal_Hammer
		Cost=500000
	Mana_Pylon
		Level=10
		Creates=/obj/Mana_Pylon
		Cost=150000
		Mod=3
	Spell_Book
		Level=10
		Creates=/obj/items/Spell_Book
		Cost=20000
	Utility_Belt
		Level=14
		Creates=/obj/items/Utility_Belt/Normal_Utility_Belt
		Cost=250000
		Mod=1.5
/*	MPDA
		Level=16
		Creates=/obj/items/MPDA
		Cost=1000*/
	Book_Case
		Level=15
		Creates=/obj/items/Bookcase
		Cost=800000
	Magic_Door
		Level=18
		Creates=/obj/Door/Lockable/Magic_Door
		Cost=400000
	Magic_Circle
		Level=18
		Creates=/obj/items/Magic_Circle
		Cost=100000
	//Lightning Bolt 25
	Simulation_Crystal
		Level=27
		Creates=/obj/items/Simulation_Crystal
		Cost=6000000
		Mod=2
	Magic_Scanner
		Level=28
		Creates=/obj/items/Magic_Scanner
		Cost=400000
	//materialize 35
/*	Magic_Mask
		Level=30
		Creates=/obj/items/Magic_Mask
		Cost=1000000
		Mod=2*/


	Locator
		Level=35
		Creates=/obj/items/Locator
		Cost=1500000
		Mod=2


	Disguise
		Level=53
		Creates=/obj/items/Disguise
		Cost=50000000
		Mod=3

	Stone_Of_Understanding
		Level=20
		Creates=/obj/items/Stone_Of_Understanding
		Cost=20000000
		Mod=2
	Magic_Fishing_Lure
		Level=35
		Creates=/obj/items/Magic_Fishing_Lure
		Cost=500000
		Mod=2
	Orb_Of_Mastery
		Level=25
		Creates=/obj/items/Orb_Of_Mastery
		Cost=1500000
		Mod=2
	Cooking_Bag
		Level=35
		Creates=/obj/items/Cooking_Bag
		Cost=5000000
		Mod=2
	Mining_Bag
		Level=35
		Creates=/obj/items/Mining_Bag
		Cost=5000000
		Mod=2
	Enchanted_Doll
		Level=25
		Creates=/obj/items/Enchanted_Doll
		Cost=4000000
		Mod=3
	//Telepathy 45
	Elixir_Of_Health
		Level=45
		Creates=/obj/items/Elixir_Of_Health
		Cost=1000000
		Mod=2
	Philosophers_Stone
		Level=45
		Creates=/obj/items/Philosophers_Stone
		Cost=777000000
		Mod=3
	Upgrade_Kit
		Level=69
		Creates=/obj/items/Upgrade_Kit
		Cost=2500000
		Mod=2
	Magic_Vault
		Level=47
		Creates=/obj/items/Magic_Vault
		Cost=8000000
	//Telekinesis 50
	//Enchant 53
	Elixir_Of_Life
		Level=55
		Creates=/obj/items/Elixir_Of_Life
		Cost=60000000
		Mod=3
	Elixir_of_Empowerment
		Level=53
		Creates=/obj/items/Elixir_Of_Empowerment
		Cost=25000000
		Mod=2
	Elixir_Of_Replenishment
		Level=58
		Creates=/obj/items/Elixir_Of_Replenishment
		Cost=5000000
		Mod=2

	Elixir_Of_Merriment
		Level=38
		Creates=/obj/items/Elixir_Of_Merriment
		Cost=80000
		Mod=2
	Elixir_Of_Respec
		Level=32
		Creates=/obj/items/Elixir_Of_Respec
		Cost=4000000
		Mod=2
	Elixir_of_Refreshment
		Level=30
		Creates=/obj/items/Elixir_of_Refreshment
		Cost=1000000
		Mod=2
	Mana_Biscuit
		Level=50
		Creates=/obj/items/Mana_Biscuit
		Cost=1000000
		Mod=3

	Elixir_Of_Uncertainty
		Level=32
		Creates=/obj/items/Elixir_Of_Uncertainty
		Cost=4000000
		Mod=2.5

/*	Moon
		Level=65
		Creates=/obj/items/Moon
		Cost=25000000
		Mod=3*/
	//Earth Prison 70
	//Frost Nova 75
	//Portals 80
	//Megaburst 85
	//Gravity Well 85
	Crystal_Ball
		Level=50
		Creates=/obj/items/Crystal_Ball
		Cost=550000000
		Mod=4
	Book_of_Lessons
		Level=93
		Creates=/obj/items/Book_of_Lessons
		Cost=300000000
		Mod=3
	Book_of_Fortitude
		Level=96
		Creates=/obj/items/Book_of_Fortitude
		Cost=500000000
		Mod=4
	Book_of_Ages
		Level=75
		Creates=/obj/items/Book_of_Ages
		Cost=950000000
		Mod=5
	Book_of_Power
		Level=107
		Creates=/obj/items/Book_of_Power
		Cost=1000000000
		Mod=5
///	Elixir_Of_Reformation
//		Level=96
//		Creates=/obj/items/Elixir_Of_Reformation
//		Cost=25000000
//		Mod=4

/*
	Old_Rod
		Level=25
		Creates=/obj/items/fishingpole/Old_Rod
		Cost=500000
	Good_Rod
		Level=25
		Creates=/obj/items/fishingpole/Good_Rod
		Cost=5000000
		Mod=2
	Super_Rod
		Level=25
		Creates=/obj/items/fishingpole/Super_Rod
		Cost=45000000
		Mod=4*/

	Phylactery
		Level=100
		Creates=/obj/items/Phylactery
		Cost=1000000000

obj/Technology
	var/displaykey
	var/Creates
	var/Cost=0
	var/Mod=1
	Level=1
	verb
		Inspect()
			set src in world
			set name = "Inspect"
			set category = "Other"
			if(src.Creates)
				var/obj/A=new src.Creates
				usr << A.desc
				del(A)
	Click()
		if(usr.Creating)
			usr<<"You may only make one thing at a time."
			return
		if(!usr.Confirm("Create [src]?")) return
		for(var/obj/Resources/B in usr)
			if(usr.Creating)
				usr<<"You may only make one thing at a time."
				return
			var/Amount=0
			for(var/obj/O in range(0,usr)) if(O.loc != usr) Amount++
			if(global.rebooting)
				usr << "Unable to make any new technology while a reboot is in progress."
				return
			if(Amount>=20)
				usr<<"Nothing more can be placed on this spot."
				return
			for(var/area/UndergroundMine/W in view(3,usr))
				usr<<"You cannot do that here."
				return
			if(B.Value < round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))) )
				usr<<"You do not have the resources to create this."
				return
			if(istype(src,/obj/Technology/Drill_Tower))
				var/NumP=0
				for(var/obj/Drill/MP) if(MP.Builder=="[usr.real_name]") NumP++
				if(NumP>=usr.Int_Mod*3)
					usr<<"You already have too many Drills. ([NumP] total)"
					return
			if(istype(src,/obj/Technology/Modernized_Cloning_Tank))
				if(usr.z==10 || usr.z==11 || usr.z==8||usr.z==17||usr.z==9)
					usr<<"<b>The materials in this realm cannot conjoin to make this [src].</b>"
					return
			usr.AllOut("Crafting time for [src] is [((1*Level)/usr.Int_Mod)/10] seconds.")
			usr.Creating=1
			spawn((1*Level)/usr.Int_Mod)
				if(!usr.Creating)return
				B.Value -= round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
				var/obj/A=new Creates
				A.cost= round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
				if(istype(A,/obj/items/FriendshipBracelet))
					A.Level=usr.Signature
					A.name="[usr]\'s Friendship Bracelet"
				if(istype(A,/obj/Ships))
					if(usr.z==10 || usr.z==11 || usr.z==8 || usr.z==17 || usr.z==9 || SpaceTravel==0)
						usr<<"<b>The materials in this realm cannot conjoin to make this [src].</b>"
						del (A)
				if(istype(A,/obj/items/Armor))
					var/x=input(usr,"Choose the icon for [src]") in list("Armor 1","Bardock","Green","Black","Armor 2","Armor 3","Armor 4","Armor 5","Armor 6", "Armor 7", "Armor 8")
					switch(x)
						if("Armor 1")A.icon='Armor1.dmi'
						if("Bardock")A.icon='BardockArmor.dmi'
						if("Black")A.icon='TurlesArmor.dmi'
						if("Green")A.icon='Nappa Armor.dmi'
						if("Armor 2")A.icon='Armor2.dmi'
						if("Armor 3")A.icon='Armor3.dmi'
						if("Armor 4")A.icon='Armor4.dmi'
						if("Armor 5")A.icon='Armor5.dmi'
						if("Armor 6")A.icon='Armor6.dmi'
						if("Armor 7")A.icon='Armor7.dmi'
						if("Armor 8")A.icon='White Male Armor.dmi'


				if(istype(A,/obj/items/Power_Armor))
					if(usr.Confirm("Make this a Force Model? (Increases Force insead of Strength)"))
						var/obj/items/Power_Armor/BB=A
						BB.ForceModel=1
				if(istype(A,/obj/items/Sword))
					var/x=input(usr,"Choose the icon for [src]") in list("Trunks","Knight","Demon","Katana","Random","Short","Rebellion","Buster","Great", "Flame", "Samurai")
					switch(x)
						if("Trunks") A.icon='Sword_Trunks.dmi'
						if("Knight") A.icon='Sword 2.dmi'
						if("Demon") A.icon='Sword 1.dmi'
						if("Katana") A.icon='Item - Katana 2.dmi'
						if("Random") A.icon='Item - Katana.dmi'
						if("Short") A.icon='Short Sword.dmi'
						if("Rebellion") A.icon='Item, Sword 1.dmi'
						if("Buster") A.icon='Item, Buster Sword.dmi'
						if("Great") A.icon='Item, Great Sword.dmi'
						if("Flame") A.icon='Sword Flame.dmi'
						if("Samurai") A.icon='Sword, Samurai.dmi'
				if(A)
					view(10,usr) << "[usr] creates a [A]."
					A.Serial = rand(11111,99999)
					A.loc=usr.loc
					A.cost = round(Cost/usr.Int_Mod)
					A.Builder="[usr.real_name]"
					usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] creates [A.name] ([A])")
					if(istype(A,/obj/items/Scanner)) if(usr.Confirm("Make the scouter use the sunglasses icon?")) A.icon='Item - Sun Glassess.dmi'
					global.worldObjectList+=A

				else
					B.Value +=  round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
					usr<<"There are no more available ship interiors or the realm you are in does not support this invention.  Therefore, you cannot create this."
					del(A)
				if(istype(A,/obj/Door))
					A:Grabbable=0
					A.Builder="[usr.real_name]"
					var/New_Password=input(usr,"Enter a password or leave blank") as text
					if(!A) return
					A.Password=New_Password
				if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
					var/obj/items/O=A
					O.MaxBPAdd+=5
					O.MasterSmith=1
				if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
					var/obj/items/Armor/O=A
					O.KineticBarrier+=5
					O.MasterSmith=1
				if(istype(A,/obj/items/Android_Chassis))
					A.Builder="[usr.real_name]"
					usr.MadeAnAndroid++
					var/N=input(usr,"Enter a name.") as text
					if(!N)
						var/X = rand(100,900)
						A.name = "Android - [X]"
					else A.name=N
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Android",null) as text
				if(istype(A,/obj/items/Seedling))
					A.Builder="[usr.real_name]"
					//usr.MadeASaiba++
					var/N=input(usr,"Enter a name.") as text
					if(!N)
						var/X = rand(100,900)
						A.name = "Saibaman - [X]"
					else A.name=N
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Saibaman",null) as text
				usr.Creating=0
				if(istype(A,/obj/items)) if(usr.Confirm("Add a custom description?"))
					var/obj/items/OO=A
					OO.CustomDesc=input("Description for [A]") as text


	New()
		if(Creates)
			var/obj/A=new Creates
		//	if(A.name)
			//	Creates=A.name
			if(A)
				icon=A.icon
				icon_state=A.icon_state
				del(A)
		else del(src)


	FriendshipBracelet
		Level=1
		Creates=/obj/items/FriendshipBracelet
		Cost=500
	Water_Purifier
		Level=1
		Creates=/obj/items/Water_Purifier
		Cost=1000
	Armor
		Level=2
		Creates=/obj/items/Armor/Normal_Armor
		Cost=250000
	Shovel
		Level=2
		Creates=/obj/items/Digging/Shovel
		Cost=4000
	Boxing_Gloves
		Level=3
		Creates=/obj/items/Boxing_Gloves
		Cost=1500
	Bandages
		Level=3
		Creates=/obj/items/Bandages
		Cost=4000
	Sword
		Level=3
		Creates=/obj/items/Sword/Normal_Sword
		Cost=500000
	Practice_Sword
		Level=3
		Creates=/obj/items/Sword/Practice_Sword
		Cost=125000
	Punching_Bag
		Level=4
		Creates=/obj/TrainingEq/Punching_Bag
		Cost=4000
	Soccer_Ball
		Level=5
		Creates=/obj/items/Soccer_Ball
		Cost=25000
	Gauntlets
		Level=6
		Creates=/obj/items/Gauntlets/Normal_Gauntlets
		Cost=500000
	Dummy
		Level=6
		Creates=/obj/TrainingEq/Dummy
		Cost=5000
/*	Steroids 
		Level=7
		Creates=/obj/items/Steroid_Injection
		Cost=4000*/
	Basic_Helmet
		Level=6
		Creates=/obj/items/Helmet/Basic_Helmet
		Cost=200000
	Drill_Tower
		Level=7
		Creates=/obj/Drill
		Cost=150000
		Mod=3
	Door_Pass
		Level=7
		Creates=/obj/items/Door_Pass
		Cost=20000
	Communicator
		Level=8
		Creates=/obj/items/Communicator
		Cost=40000
	LSD
		Level=8
		Creates=/obj/items/LSD
		Cost=10000
	Hand_Drill
		Level=9
		Creates=/obj/items/Digging/Hand_Drill
		Cost=60000
	Utility_Belt
		Level=14
		Creates=/obj/items/Utility_Belt/Normal_Utility_Belt
		Cost=250000
		Mod=1.5
	Ammo
		Level=19
		Creates=/obj/items/Ammo
		Cost=200000
	Book_of_Ages
		Level=55
		Creates=/obj/items/Book_of_Ages
		Cost=9500000
		Mod=5
	/*RPG
		Level=10
		Creates=/obj/items/Gun/RPG*/
		Cost=4000
	Reinforced_Vault
		Level=10
		Creates=/obj/Door/Lockable/Reinforced_Vault
		Cost=300000
	Reinforced_Door
		Level=10
		Creates=/obj/Door/Lockable/Reinforced_Door
		Cost=300000
	Spacesuit
		Level=16
		Creates=/obj/items/Spacesuit
		Cost=100000
	PDA
		Level=16
		Creates=/obj/items/PDA
		Cost=1000
	Book_Case
		Level=18
		Creates=/obj/items/Bookcase
		Cost=800000
	Hammer
		Level=18
		Creates=/obj/items/Hammer/Normal_Hammer
		Cost=500000
	Medicine_Cabinet
		Level=18
		Creates=/obj/items/Medicine_Cabinet
		Cost=100000
	Stun_Controls
		Level=20
		Creates=/obj/items/Stun_Controls
		Cost=400000
		Mod=2
	Stun_Chip
		Level=20
		Creates=/obj/items/Stun_Chip
		Cost=200000
		Mod=2
	Punchometer
		Level=27
		Creates=/obj/TrainingEq/Punchometer
		Cost=100000
		Mod=2
	Translator
		Level=20
		Creates=/obj/items/Translator
		Cost=20000000
		Mod=2
	Handgun
		Level=25
		Creates=/obj/items/Gun/Handgun
		Cost=300000
	Photon_Repeaters
		Level=28
		Creates=/obj/items/Gun/Photon_Repeaters
		Cost=750000
		Mod=2
	Punisher
		Level=20
		Creates=/obj/items/Gun/Punisher
		Cost=1000000
		Mod=2
	Shotgun
		Level=15
		Creates=/obj/items/Gun/Shotgun
		Cost=1000000
		Mod=2
	Rifle
		Level=15
		Creates=/obj/items/Gun/Rifle
		Cost=1500000
		Mod=2
	Red9
		Level=32
		Creates=/obj/items/Gun/Red9
		Cost=1500000
		Mod=2
	Cooking_Bag
		Level=35
		Creates=/obj/items/Cooking_Bag
		Cost=5000000
		Mod=2
	Minigun
		Level=35
		Creates=/obj/items/Gun/Minigun
		Cost=5000000
		Mod=2
	Blaster
		Level=10
		Creates=/obj/items/Gun/Blaster
		Cost=6000000
		Mod=3


	Mining_Bag
		Level=35
		Creates=/obj/items/Mining_Bag
		Cost=5000000
		Mod=2

	Ninja_Scarf
		Level=25
		Creates=/obj/items/Ninja_Scarf
		Cost=1500000
		Mod=2


	Locator
		Level=35
		Creates=/obj/items/Locator
		Cost=1500000
		Mod=2


	Scanner
		Level=22
		Creates=/obj/items/Scanner
		Cost=200000
	Security_Monitor
		Level=23
		Creates=/obj/items/Security_Monitor
		Cost=100000
	Regenerator
		Level=24
		Creates=/obj/items/Regenerator
		Cost=450000
	Motion_Detector
		Level=25
		Creates=/obj/items/Motion_Detector
		Cost=75000
	Simulator
		Level=27
		Creates=/obj/items/Simulator
		Cost=6000000
	Repair_Kit
		Level=19
		Creates=/obj/items/Repair_Kit
		Cost=800000

	Upgrade_Kit
		Level=69
		Creates=/obj/items/Upgrade_Kit
		Cost=2500000
		Mod=2

	Force_Field
		Level=32
		Creates=/obj/items/Force_Field
		Cost=8000000
		Mod=3
	Recycler
		Level=33
		Creates=/obj/items/Recycler
		Cost=1000000

	Slot_Machine
		Level=10
		Creates=/obj/items/Slot_Machine
		Cost=1500000
		Mod=2

	Vending_Machine
		Level=10
		Creates=/obj/Vending_Machine
		Cost=2000000
		Mod=3



	Cooking_Bag
		Level=35
		Creates=/obj/items/Cooking_Bag
		Cost=5000000
		Mod=2
	Basic_Stovetop
		Level=30
		Creates=/obj/items/furnace/Basic_Stovetop
		Cost=2000000
	Basic_Forge
		Level=35
		Creates=/obj/items/furnace/Basic_Forge
		Cost=2500000
		Mod=2
	Advanced_Furnace
		Level=47
		Creates=/obj/items/furnace/Advanced_Furnace
		Cost=5000000
		Mod=3
	Hand_Grenade
		Level=28
		Creates=/obj/items/Explosives/Hand_Grenade
		Cost=1000000
		Mod=1.5
	Stun_Grenade
		Level=39
		Creates=/obj/items/Explosives/Stun_Grenade
		Cost=2000000
		Mod=2
	Fire_Bomb
		Level=50
		Creates=/obj/items/Explosives/Fire_Bomb
		Cost=2500000
		Mod=3
	High_Explosive_Grenade
		Level=61
		Creates=/obj/items/Explosives/High_Explosive_Grenade
		Cost=3000000
		Mod=4
	Basic_Chest
		Level=28
		Creates=/obj/items/storage/Basic_Chest
		Cost=4000000
	Super_Anti_Virus
		Level=75
		Creates=/obj/items/drugs/Super_Anti_Virus
		Cost=60000000
		Mod=6
	Cialis
		Level=50
		Creates=/obj/items/drugs/Cialis
		Cost=1800000
		Mod=3
	Epinephrine
		Level=25
		Creates=/obj/items/drugs/Epinephrine
		Cost=800000
		Mod=3
	Morphine
		Level=25
		Creates=/obj/items/drugs/Morphine
		Cost=600000
		Mod=2.5
	Percocet
		Level=20
		Creates=/obj/items/drugs/Percocet
		Cost=500000
		Mod=2.5
	Vitamins
		Level=13
		Creates=/obj/items/drugs/Vitamins
		Cost=300000
		Mod=2
	Methylphenidate
		Level=15
		Creates=/obj/items/drugs/Methylphenidate
		Cost=300000
		Mod=2

	Old_Rod
		Level=25
		Creates=/obj/items/fishingpole/Old_Rod
		Cost=500000
	Good_Rod
		Level=25
		Creates=/obj/items/fishingpole/Good_Rod
		Cost=5000000
		Mod=2
	Super_Rod
		Level=25
		Creates=/obj/items/fishingpole/Super_Rod
		Cost=45000000
		Mod=4

	Medical_Assessment
		Level=35
		Creates=/obj/items/Medical_Assessment
		Cost=600000
		Mod=2

	Security_Camera
		Level=37
		Creates=/obj/items/Security_Camera
		Cost=300000
	Hacking_Console
		Level=42
		Creates=/obj/items/Hacking_Console
		Cost=50000000
		Mod=3
	Antihacking_Circuitry
		Level=42
		Creates=/obj/items/Antihacking_Circuitry
		Cost=50000000
		Mod=2
	Transporter_Pad
		Level=43
		Creates=/obj/items/Transporter_Pad
		Cost=15000000
		Mod=2
	Stud_Finder
		Level=44
		Creates=/obj/items/Stud_Finder
		Cost=900000
	Safe
		Level=47
		Creates=/obj/items/Safe
		Cost=8000000

	Prospecting_Toolkit
		Level=49
		Creates=/obj/items/Prospecting_Toolkit
		Cost=1000000
		Mod=2
	Android_Upgrade_Component
		Level=45
		Creates=/obj/items/Android_Upgrade
		Cost=6000000
		Mod=2
	Android_Chassis
		Level=25
		Creates=/obj/items/Android_Chassis
		Cost=10000000
		Mod=3
	Seedling
		Level=30
		Creates=/obj/items/Seedling
		Cost=10000
		Mod=1
	Advanced_Door_Pass
		Level=55
		Creates=/obj/items/Advanced_Door_Pass
		Mod=4
		Cost=20000000
	Cloak
		Level=55
		Creates=/obj/items/Cloak
		Cost=60000000
	Cloak_Controls
		Level=55
		Creates=/obj/items/Cloak_Controls
		Cost=90000000
		Mod=3
	Gravity
		Level=60
		Creates=/obj/items/Gravity
		Cost=250000000
		Mod=3
	Healing_Pylon
		Level=61
		Creates=/obj/items/HealingPylon
		Cost=500000000
		Mod=4

	Nanite_Tube
		Level=75
		Creates=/obj/items/Nanite_Tube
		Cost=950000000
		Mod=5
	/*Drone Level 50*/
	Moon
		Level=65
		Creates=/obj/items/Moon
		Cost=25000000
		Mod=3
/*	Energy_Infusion
		Level=68
		Creates=/obj/items/Energy_Infusion
		Cost=26000000*/
	Pod
		Level=45
		Creates=/obj/Ships/Spacepod
		Cost=180000000
		Mod=3
	Rocket_Booster
		Level=30
		Creates=/obj/items/Rocket_Booster
		Cost=12000000

	Modernized_Cloning_Tank
		Level=106
		Creates=/obj/items/Cloning_Tank/Modernized_Cloning_Tank
		Cost=19000000000
		Mod=5

	Android_Uplink_Mainframe
		Level=76
		Creates=/obj/items/Cloning_Tank/Android_Uplink_Mainframe
		Cost=15000000000
		Mod=3
	Elixir_Of_Empowerment
		Level=53
		Creates=/obj/items/Elixir_Of_Empowerment
		Cost=25000000
		Mod=2
	Coffee
		Level=30
		Creates=/obj/items/Coffee
		Cost=5000000
		Mod=2
	Elixir_Of_Respec
		Level=32
		Creates=/obj/items/Elixir_Of_Respec
		Cost=4000000
		Mod=2
	Genetic_Sequencer
		Level=75
		Creates=/obj/items/Genetic_Sequencer
		Cost=250000000
		Mod=4
	Teleportation_Watch
		Level=80
		Creates=/obj/items/Transporter_Watch
		Cost=200000000
		Mod=4
	Adamantine_Skeleton
		Level=90
		Creates=/obj/items/Adamantine_Skeleton
		Cost=400000000
		Mod=5

	PodMKIII
		Level=55
		Creates=/obj/Ships/SpacepodMKIII
		Cost=450000000
		Mod=4
	Mutagen_Injection
		Level=40
		Creates=/obj/items/Mutagen_Injection
		Cost=1000000
		Mod=5

	Self_Replicating_Code_Injector
		Level=65
		Creates=/obj/items/Self_Replicating_Code_Injector
		Cost=100000000
		Mod=5
	Configurable_Bomb
		Level=20
		Creates=/obj/items/Bomb
		Cost=90000000
		Mod=5
	Detonator
		Level=20
		Creates=/obj/items/Detonator
		Cost=500000
		Mod=5
	Power_Armor
		Level=100
		Creates=/obj/items/Power_Armor
		Cost=900000000
		Mod=4

	Ship
		Level=85
		Mod=4
		Creates=/obj/Ships/Ship
		Cost=750000000

	ShipMKII
		Level=85
		Creates=/obj/Ships/ShipMKII
		Cost=1150000000
		Mod=5

	ShipMKIII
		Level=85
		Creates=/obj/Ships/ShipMKIII
		Cost=1750000000
		Mod=6

	Elixir_Of_Reformation
		Level=55
		Creates=/obj/items/Elixir_Of_Reformation
		Cost=25000000
		Mod=4.5
		
