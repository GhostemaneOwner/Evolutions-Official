
mob/proc/MiningLevelCheck()
	if(Mining_XP>=Mining_Next&&Mining_Level<TechCap)
		Mining_XP-=Mining_Next
		Mining_Next=round(Mining_Next*1.06)
		Mining_Level++
		if(Mining_XP>=Mining_Next&&Mining_Level<TechCap) MiningLevelCheck()
	if(Mining_Level>=TechCap) Mining_XP=0
//	UpdateStats("Mining")
mob/proc/SmithingLevelCheck()
	if(Smithing_XP>=Smithing_Next&&Smithing_Level<TechCap)
		Smithing_XP-=Smithing_Next
		Smithing_Next=round(Smithing_Next*1.06)
		Smithing_Level++
		if(Smithing_XP>=Smithing_Next&&Smithing_Level<TechCap) SmithingLevelCheck()
	if(Smithing_Level>=TechCap) Smithing_XP=0

//	UpdateStats("Smithing")




/*obj/Mine_Deep/verb/Mine_Deep()
	set category="Other"
	var/lr = list(1,2,3,4,5)
	if(usr.z in lr)
		if(usr.MineX&&usr.MineY&&usr.MineZ)for(var/area/UndergroundMine/B in range(0,usr))
			usr.loc=locate(usr.MineX,usr.MineY,usr.MineZ)
			usr<<"Returned to the surface."
			return
	if(usr.z in lr)
		for(var/area/UndergroundMine/B in range(0,usr))
			usr<<"You may not use this here."
			return
		if(!usr.Confirm("Are you sure you want to Mine Deep?")) return
		usr<<"Entering in 15 seconds."
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used mine deep.\n")
		spawn(150)
			if(!usr.KOd&&usr.z in lr)
				usr.MineX=usr.x
				usr.MineY=usr.y
				usr.MineZ=usr.z
				usr.Flight_Land()
				if(ismob(usr.GrabbedMob)) usr.GrabbedMob.grabberSTR=null
				usr.GrabbedMob = null
				usr.isGrabbing = null
				switch(usr.z)
					if(1) usr.loc=locate(/area/UndergroundMine/Earth/Entrance)
					if(2) usr.loc=locate(/area/UndergroundMine/Namek)
					if(3) usr.loc=locate(/area/UndergroundMine/Vegeta/Entrance)
					if(4) usr.loc=locate(/area/UndergroundMine/Ice)
					if(5) usr.loc=locate(/area/UndergroundMine/Arconia/Entrance)
	else usr<<"You may not Mine Deep from here."
*/
obj/items/var/SellingPrice=0
obj/Vending_Machine
	icon='Vending_machine.dmi'
	pixel_x=-18
	var/MaxContents=8
	desc="This will allow you to store items inside and then sell them at a given price."
	Health=50000
	Savable=1
	density=1
	var/SafeResources = 0
	verb/Sell_Item()
		set src in oview(1)
		var/passwd = input ("What is this [src]'s password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			if(contents.len<MaxContents)
				var/list/Items=new
				for(var/obj/items/K in usr) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Store what from your inventory? (Can hold [MaxContents] total items)") in Items
				if(istype(C,/obj/Magic_Ball))
					usr<<"You can not store this."
					return
				if(C=="Cancel") return
				if(usr.Confirm("Store [C] in [src]?"))
					src.contents+=C
					C.SellingPrice=input("Sell this [C] for how many resources?") as num
					if(C.SellingPrice<1) C.SellingPrice=1
					view(usr)<<"[usr] stored [C] in [src]."
			else usr<<"It is already full."
	verb/Withdraw_Item()
		set src in oview(1)
		var/passwd = input ("What is this [src]'s password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/list/Items=new
			for(var/obj/K in src.contents) Items+=K
			Items+="Cancel"
			var/obj/items/C=input("Withdraw what from [src]?") in Items
			if(C=="Cancel") return
			if(usr.Confirm("Withdraw [C]?"))
				usr.contents+=C
//				usr.InventoryCheck()
				view(usr)<<"[usr] took [C] out of the [src]."
	verb/Purchase_Item()
		set src in oview(1)
		var/list/Items=new
		for(var/obj/K in src.contents) Items+=K
		Items+="Cancel"
		var/obj/items/C=input("Purchase what from [src]?") in Items
		if(C=="Cancel") return
		if(usr.Confirm("Purchase [C] for [C.SellingPrice] resources?"))

			var/Cost = C.SellingPrice
			for(var/obj/Resources/RR in usr)
				if(RR.Value >= Cost)
					RR.Value-=Cost
					SafeResources+=Cost
					usr.contents+=C
//					usr.InventoryCheck()
					view(usr)<<"[usr] bought [C] out of the [src] for [Cost] resources."
				else
					usr << "You do not have [Commas(Cost)] resources to spare in order to buy [C]."
					return
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."
			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1

	verb/Set_Password()
		set src in oview(1)
		if(Password == null)
			Password = input("Entering a password will help keep this [src] private.") as text
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return

	verb/Withdraw_Resources()
		set src in view(1)
		var/passwd = input("What is this [src]'s password?")
		if(SafeResources <= 0)
			SafeResources = 0
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How many resources would you like to withdraw from [src]?") as num
			if(getRSC < 1) return
			getRSC=round(getRSC)
			if(getRSC > SafeResources)getRSC=SafeResources
			for(var/obj/Resources/A in usr)
				A.Value       += getRSC
				SafeResources -= getRSC
				usr<<"You withdrew [getRSC] resources."

	verb/Check_Resources()
		set src in view(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input ("What is this [src]'s password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the [src]."
			return
	verb/Upgrade()
		set src in view(1)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			Health=50000*Level
			usr<<"Upgraded [src] to security level [Level]. Health [Health]"
	Del()
		for(var/obj/I in contents) I.loc=src.loc
		var/obj/Resources/A=new
		A.loc=src.loc
		A.Value=SafeResources
		A.name="[Commas(A.Value)] Resources"
		..()

obj/items/storage
	var/MaxContents=8
	desc="This will allow you to store items inside, but it can not be moved once placed."
	Health=100000
	Grabbable=0
	Bolted=1
	Flammable = 1
	density=1
	verb/Store()
		set src in oview(1)
		if(contents.len<MaxContents)
			var/list/Items=new
			for(var/obj/items/K in usr) Items+=K
			Items+="Cancel"
			var/obj/items/C=input("Store what from your inventory? (Can hold [MaxContents] total items)") in Items
			if(istype(C,/obj/Magic_Ball))
				usr<<"You can not store this."
				return
			if(C=="Cancel") return
			if(usr.Confirm("Store [C] in [src]?"))
				src.contents+=C
				view(usr)<<"[usr] stored [C] in [src]."
		else usr<<"It is already full."
	verb/Withdraw()
		set src in oview(1)
		var/list/Items=new
		for(var/obj/K in src.contents) Items+=K
		Items+="Cancel"
		var/obj/items/C=input("Withdraw what from [src]?") in Items
		if(C=="Cancel") return
		if(usr.Confirm("Withdraw [C]?"))
			usr.contents+=C
//			usr.InventoryCheck()
			view(usr)<<"[usr] took [C] out of the [src]."


	Del()
		for(var/obj/I in contents) I.loc=src.loc
		..()
	Basic_Chest
		icon='Normal Chest.dmi'
		MaxContents=8
	Copper_Chest
		icon='Chest Copper.dmi'
		MaxContents=10
		Flammable = 0
/*	Bronze_Chest
		icon='Chest Bronze.dmi'
		MaxContents=10
		Flammable = 0*/
	Iron_Chest
		icon='Chest Iron.dmi'
		MaxContents=12
		Flammable = 0
	Mythril_Chest
		icon='Chest Mytril.dmi'
		MaxContents=15
		Flammable = 0
	Masterwork_Chest
		icon='Chest MasterWork.dmi'
		MaxContents=25
		Flammable = 0

obj/items/furnace
	Basic_Forge
		icon='KitchenStove.dmi'
		desc="This will speed up smelting if you are within 2 tiles."
		Health=100000
		Grabbable=1
		Flammable = 0
		density=1
	Basic_Stovetop
		icon='Turf 52.dmi'
		icon_state="stove"
		desc="This will speed up cooking if you are within 2 tiles."
		Health=100000
		Grabbable=1
		Flammable = 0
		density=1
	Advanced_Furnace
		icon='KitchenStove.dmi'
		desc="This will speed up both cooking and smelting significantly if you are within 2 tiles."
		Health=500000
		Grabbable=1
		Flammable = 0
		density=1
		New()
			..()
			icon+=rgb(20,0,0)
			icon-=rgb(0,10,10)
obj/items/pickaxe
	icon='Pickaxe.dmi'
	Old_Pickaxe
		desc="Speeds up mining."
		Flammable = 1

	Good_Pickaxe
		icon_state="2"
		desc="Speeds up mining more than an Old Pickaxe."
		Flammable = 1

	Super_Pickaxe
		icon_state="3"
		desc="Speeds up mining more than a Good Pickaxe."
		Flammable = 1



obj/items/ingredients
	Fishing_Line
		icon='FishingLine.dmi'
		desc="This is some fishing line. A blacksmith can combine this with some copper to make a fishing rod."
		Flammable = 1

	Heart_Of_The_Mountain
		icon='enchantmenticons.dmi'
		icon_state="ArcanOrb"
		desc="This is a heart of the mountain. This gem can be used with some copper to fashion a pickaxe by a blacksmith or used to change a Mythril item into a Masterwork."
		Flammable = 1

		var/ReqSkill=55
		var/GivesXP=30000
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Mythril_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Mythril_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Mythril_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Mythril_Armor/K in usr) Items+=K
				for(var/obj/items/storage/Mythril_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Mythril_Helmet/K in view(usr)) Items+=K
				for(var/obj/items/Utility_Belt/Mythril_Utility_Belt/K in view(usr)) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(C.suffix=="*Equipped*")
						usr<<"You must unequip this first!"
						return
					if(istype(C,/obj/items/Sword/Mythril_Sword)) Creating=/obj/items/Sword/Masterwork_Sword
					if(istype(C,/obj/items/Hammer/Mythril_Hammer)) Creating=/obj/items/Hammer/Masterwork_Hammer
					if(istype(C,/obj/items/Gauntlets/Mythril_Gauntlets)) Creating=/obj/items/Gauntlets/Masterwork_Gauntlets
					if(istype(C,/obj/items/Armor/Mythril_Armor)) Creating=/obj/items/Armor/Masterwork_Armor
					if(istype(C,/obj/items/storage/Mythril_Chest)) Creating=/obj/items/storage/Masterwork_Chest
					if(istype(C,/obj/items/Helmet/Mythril_Helmet)) Creating=/obj/items/Helmet/Masterwork_Helmet
					if(istype(C,/obj/items/Utility_Belt/Mythril_Utility_Belt)) Creating=/obj/items/Utility_Belt/Masterwork_Utility_Belt
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					A.magical=A.magical
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					if(usr.RestedTime>world.realtime)XPG*=1.5
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."



obj/items/rawmetal
//	Savable=0
	var
		GivesXP=300
		ReqSkill=1
	verb/Practice()
		set category=null
		var/HasBoost=0
		if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
		if(usr.Smithing_Level+HasBoost>=ReqSkill)
			if(usr.Confirm("Train your Smithing skill, destroying [src] in the process?"))
				view(usr)<<"[usr] has practiced their Smithing! ([src])."
				var/XPG=GivesXP
				if(usr.InspiredTime>world.realtime)XPG*=1.5
				if(usr.RestedTime>world.realtime)XPG*=1.5
				if(usr.HasLiberalArtsDegree)
					usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
					usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
				usr.Smithing_XP+=XPG
				usr.SmithingLevelCheck()
			//	usr.UpdateStats("Smithing")
				del(src)
		else usr<<"You require Smithing level [ReqSkill] to use this."
	Copper_Ingot
		icon='Copper Bar.dmi'
		//icon_state="Copper"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Normal_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Normal_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Normal_Gauntlets/K in usr) Items+=K
				for(var/obj/items/storage/Basic_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Utility_Belt/Normal_Utility_Belt/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Basic_Helmet/K in view(usr)) Items+=K
				for(var/obj/items/Armor/Normal_Armor/K in usr) Items+=K
				for(var/obj/items/ingredients/Fishing_Line/K in usr) Items+=K
				for(var/obj/items/ingredients/Heart_Of_The_Mountain/K in usr) Items+=K
					/*if(istype(K,/obj/items/Armor/Copper_Armor))continue
					if(istype(K,/obj/items/Armor/Bronze_Armor))continue
					if(istype(K,/obj/items/Armor/Iron_Armor))continue
					if(istype(K,/obj/items/Armor/Mythril_Armor))continue
					if(istype(K,/obj/items/Armor/Masterwork_Armor))continue*/
				//for(var/obj/items/rawmetal/Iron_Ingot/K in usr) Items+=K

				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(C.suffix=="*Equipped*")
						usr<<"You must unequip this first!"
						return
					if(istype(C,/obj/items/Sword/Normal_Sword)) Creating=/obj/items/Sword/Copper_Sword
					if(istype(C,/obj/items/Hammer/Normal_Hammer)) Creating=/obj/items/Hammer/Copper_Hammer
					if(istype(C,/obj/items/Gauntlets/Normal_Gauntlets)) Creating=/obj/items/Gauntlets/Copper_Gauntlets
					if(istype(C,/obj/items/Armor/Normal_Armor)) Creating=/obj/items/Armor/Copper_Armor
					if(istype(C,/obj/items/storage/Basic_Chest)) Creating=/obj/items/storage/Copper_Chest
					if(istype(C,/obj/items/Helmet/Basic_Helmet)) Creating=/obj/items/Helmet/Copper_Helmet
					if(istype(C,/obj/items/ingredients/Fishing_Line)) Creating=/obj/items/fishingpole/Old_Rod
					if(istype(C,/obj/items/ingredients/Heart_Of_The_Mountain)) Creating=/obj/items/pickaxe/Old_Pickaxe
					//if(istype(C,/obj/items/rawmetal/Iron_Ingot)) Creating=/obj/items/Sword/Practice_Sword
					if(istype(C,/obj/items/Utility_Belt/Normal_Utility_Belt)) Creating=/obj/items/Utility_Belt/Copper_Utility_Belt
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					A.magical=A.magical
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."

	Tin_Ingot
		GivesXP=3000
		ReqSkill=15
		icon='Tin Bar.dmi'
		//icon_state="Tin"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Copper_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Copper_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Copper_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Copper_Armor/K in usr) Items+=K
//				for(var/obj/items/storage/Copper_Chest/K in view(usr)) Items+=K
//				for(var/obj/items/Helmet/Copper_Helmet/K in view(usr)) Items+=K

//				for(var/obj/items/fishingpole/Old_Rod/K in usr) Items+=K
//				for(var/obj/items/pickaxe/Old_Pickaxe/K in usr) Items+=K
				//for(var/obj/items/Utility_Belt/Copper_Utility_Belt/K in usr) Items+=K

/*
				for(var/obj/items/Sword/Copper_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Copper_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Copper_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Copper_Armor/K in usr) Items+=K
				for(var/obj/items/Utility_Belt/Copper_Utility_Belt/K in usr) Items+=K
				for(var/obj/items/ingredients/Fishing_Line/K in usr) Items+=K
				for(var/obj/items/ingredients/Heart_Of_The_Mountain/K in usr) Items+=K
				for(var/obj/items/storage/Copper_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Copper_Helmet/K in view(usr)) Items+=K*/

				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(C.suffix=="*Equipped*")
						usr<<"You must unequip this first!"
						return
					if(istype(C,/obj/items/Sword/Copper_Sword)) Creating=/obj/items/Sword/Bronze_Sword
					if(istype(C,/obj/items/Hammer/Copper_Hammer)) Creating=/obj/items/Hammer/Bronze_Hammer
					if(istype(C,/obj/items/Gauntlets/Copper_Gauntlets)) Creating=/obj/items/Gauntlets/Bronze_Gauntlets
					if(istype(C,/obj/items/Armor/Copper_Armor)) Creating=/obj/items/Armor/Bronze_Armor
//					if(istype(C,/obj/items/storage/Copper_Chest)) Creating=/obj/items/storage/Bronze_Chest
//					if(istype(C,/obj/items/Helmet/Copper_Helmet)) Creating=/obj/items/Helmet/Bronze_Helmet
//					if(istype(C,/obj/items/Utility_Belt/Copper_Utility_Belt)) Creating=/obj/items/Utility_Belt/Bronze_Utility_Belt


					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."

	Silver_Ingot
		GivesXP=5000
		ReqSkill=40
		icon='Tin Bar.dmi'
		New()
			..()
			icon+=rgb(100,100,100)
		//icon_state="Tin"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Bronze_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Bronze_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Bronze_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Bronze_Armor/K in usr) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(C.suffix=="*Equipped*")
						usr<<"You must unequip this first!"
						return
					if(istype(C,/obj/items/Sword/Bronze_Sword)) Creating=/obj/items/Sword/Silver_Sword
					if(istype(C,/obj/items/Hammer/Bronze_Hammer)) Creating=/obj/items/Hammer/Silver_Hammer
					if(istype(C,/obj/items/Gauntlets/Bronze_Gauntlets)) Creating=/obj/items/Gauntlets/Silver_Gauntlets
					if(istype(C,/obj/items/Armor/Bronze_Armor)) Creating=/obj/items/Armor/Silver_Armor
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."

	Iron_Ingot
		GivesXP=3000
		ReqSkill=15
		icon='Iron Bar.dmi'
		//icon_state="Iron"
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Copper_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Copper_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Copper_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Copper_Armor/K in usr) Items+=K
				for(var/obj/items/Utility_Belt/Copper_Utility_Belt/K in usr) Items+=K
				for(var/obj/items/storage/Copper_Chest/K in view(usr)) Items+=K
				for(var/obj/items/fishingpole/Old_Rod/K in usr) Items+=K
				for(var/obj/items/pickaxe/Old_Pickaxe/K in usr) Items+=K
				for(var/obj/items/storage/Copper_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Copper_Helmet/K in view(usr)) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(C.suffix=="*Equipped*")
						usr<<"You must unequip this first!"
						return
					if(istype(C,/obj/items/Sword/Copper_Sword)) Creating=/obj/items/Sword/Iron_Sword
					if(istype(C,/obj/items/Hammer/Copper_Hammer)) Creating=/obj/items/Hammer/Iron_Hammer
					if(istype(C,/obj/items/Gauntlets/Copper_Gauntlets)) Creating=/obj/items/Gauntlets/Iron_Gauntlets
					if(istype(C,/obj/items/Armor/Copper_Armor)) Creating=/obj/items/Armor/Iron_Armor
					if(istype(C,/obj/items/fishingpole/Old_Rod)) Creating=/obj/items/fishingpole/Good_Rod
					if(istype(C,/obj/items/pickaxe/Old_Pickaxe)) Creating=/obj/items/pickaxe/Good_Pickaxe
					if(istype(C,/obj/items/storage/Copper_Chest)) Creating=/obj/items/storage/Iron_Chest
					if(istype(C,/obj/items/Utility_Belt/Copper_Utility_Belt)) Creating=/obj/items/Utility_Belt/Iron_Utility_Belt
					if(istype(C,/obj/items/Helmet/Copper_Helmet)) Creating=/obj/items/Helmet/Iron_Helmet
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."
	Mythril_Ingot
		GivesXP=5000
		ReqSkill=40
		icon='Mythril Bar.dmi'
		desc="This is used for blacksmithing."
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Iron_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Iron_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Iron_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Iron_Armor/K in usr) Items+=K
				for(var/obj/items/Utility_Belt/Iron_Utility_Belt/K in usr) Items+=K
				for(var/obj/items/storage/Iron_Chest/K in view(usr)) Items+=K
				for(var/obj/items/Helmet/Iron_Helmet/K in view(usr)) Items+=K
				for(var/obj/items/fishingpole/Good_Rod/K in usr) Items+=K
				for(var/obj/items/pickaxe/Good_Pickaxe/K in usr) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(C.suffix=="*Equipped*")
						usr<<"You must unequip this first!"
						return
					if(istype(C,/obj/items/Sword/Iron_Sword)) Creating=/obj/items/Sword/Mythril_Sword
					if(istype(C,/obj/items/Hammer/Iron_Hammer)) Creating=/obj/items/Hammer/Mythril_Hammer
					if(istype(C,/obj/items/Gauntlets/Iron_Gauntlets)) Creating=/obj/items/Gauntlets/Mythril_Gauntlets
					if(istype(C,/obj/items/Armor/Iron_Armor)) Creating=/obj/items/Armor/Mythril_Armor
					if(istype(C,/obj/items/storage/Iron_Chest)) Creating=/obj/items/storage/Mythril_Chest
					if(istype(C,/obj/items/Helmet/Iron_Helmet)) Creating=/obj/items/Helmet/Mythril_Helmet
					if(istype(C,/obj/items/Utility_Belt/Iron_Utility_Belt)) Creating=/obj/items/Utility_Belt/Mythril_Utility_Belt
					if(istype(C,/obj/items/fishingpole/Good_Rod)) Creating=/obj/items/fishingpole/Super_Rod
					if(istype(C,/obj/items/pickaxe/Good_Pickaxe)) Creating=/obj/items/pickaxe/Super_Pickaxe
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."
	Auracite_Ingot
		GivesXP=15000
		ReqSkill=50
		icon='Mythril Bar.dmi'
		desc="This is used for blacksmithing."
		New()
			..()
			icon+=rgb(66,66,66)
		verb/Infuse()
			set category=null
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill&&!usr.KOd)
				var/list/Items=new
				for(var/obj/items/Sword/Silver_Sword/K in usr) Items+=K
				for(var/obj/items/Hammer/Silver_Hammer/K in usr) Items+=K
				for(var/obj/items/Gauntlets/Silver_Gauntlets/K in usr) Items+=K
				for(var/obj/items/Armor/Silver_Armor/K in usr) Items+=K
				Items+="Cancel"
				var/obj/items/C=input("Infuse [src] into what?") in Items
				if(C=="Cancel")return
				if(usr.Confirm("Infuse [C] with [src]?"))
					var/Creating
					if(C.suffix=="*Equipped*")
						usr<<"You must unequip this first!"
						return
					if(istype(C,/obj/items/Sword/Silver_Sword)) Creating=/obj/items/Sword/Auracite_Sword
					if(istype(C,/obj/items/Hammer/Silver_Hammer)) Creating=/obj/items/Hammer/Auracite_Hammer
					if(istype(C,/obj/items/Gauntlets/Silver_Gauntlets)) Creating=/obj/items/Gauntlets/Auracite_Gauntlets
					if(istype(C,/obj/items/Armor/Silver_Armor)) Creating=/obj/items/Armor/Auracite_Armor
					var/obj/items/A=new Creating
					A.Health=C.Health
					A.Serial=C.Serial
					A.add_bp=C.add_bp
					A.add_energy=C.add_energy
					A.add_str=C.add_str
					A.add_end=C.add_end
					A.add_spd=C.add_spd
					A.add_force=C.add_force
					A.add_off=C.add_off
					A.add_def=C.add_def
					A.add_regen=C.add_regen
					A.add_recov=C.add_recov
					A.TotalEnchants=C.TotalEnchants
					A.magical=A.magical
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Armor))
						var/obj/items/Armor/O=A
						O.KineticBarrier+=5
						O.MasterSmith=1
					if(usr.HasMasterBlacksmith) if(istype(A,/obj/items/Sword)||istype(A,/obj/items/Hammer)||istype(A,/obj/items/Gauntlets))
						A.MasterSmith=1
						A.MaxBPAdd+=5
					A.EquipmentDescAssign()
					usr.contents+=A
					view(usr)<<"[usr] has created a [A]!"
					var/XPG=GivesXP
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Smithing_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.SmithingLevelCheck()
					del(C)
					del(src)
			else usr<<"You require Smithing level [ReqSkill] to use this."


obj/items/rawore
	Savable=0
	var
		GivesXP=300
		ReqSkill=1
		ResultingOre=/obj/items/rawmetal/Copper_Ingot
	Copper
		icon='Copper Raw.dmi'
		//icon_state="Copper"
		ResultingOre=/obj/items/rawmetal/Copper_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Tin
		GivesXP=5000
		ReqSkill=15
		icon='Tin Raw.dmi'
		//icon_state="Tin"
		ResultingOre=/obj/items/rawmetal/Tin_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Iron
		GivesXP=1500
		ReqSkill=15
		icon='Iron Raw.dmi'
		//icon_state="Iron"
		ResultingOre=/obj/items/rawmetal/Iron_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Silver
		GivesXP=3000
		ReqSkill=40
		icon='Small Magic Ore.dmi'
		ResultingOre=/obj/items/rawmetal/Silver_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Mythril
		GivesXP=8000
		ReqSkill=40
		icon='Mythril Raw.dmi'
		ResultingOre=/obj/items/rawmetal/Mythril_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	Auracite
		GivesXP=12000
		ReqSkill=50
		icon='Medium Magic Ore.dmi'
		New()
			..()
			icon+=rgb(35,35,35)
		ResultingOre=/obj/items/rawmetal/Auracite_Ingot
		desc="This is used for blacksmithing, but first must be smelted."
	verb
		Smelt()
			set src in view(1)
			var/HasBoost=0
			if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
			if(usr.Smithing_Level+HasBoost>=ReqSkill)
				if(!usr.IsCooking&&!usr.IsMining&&!usr.IsFishing)
					view(usr)<<"[usr] starts to smelt [src]."
					usr.IsCooking=1
					var/CookSpeed=rand(300,600)
					if(locate(/obj/items/furnace/Advanced_Furnace) in view(2,usr)) CookSpeed-=400
					else if(locate(/obj/items/furnace/Basic_Forge) in view(2,usr)) CookSpeed-=200
					if(usr.Smithing_Level+HasBoost>=15) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=30) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=45) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=60) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=75) CookSpeed*=0.9
					if(usr.Smithing_Level+HasBoost>=90) CookSpeed*=0.9
					if(CookSpeed<5)CookSpeed=5
					spawn(CookSpeed) if(src&&usr&&usr.IsCooking)
						view(usr)<<"[usr] has finished smelting [src]."
						var/obj/items/cookedfood/A=new ResultingOre
						var/XPG=GivesXP/4
						if(usr.InspiredTime>world.realtime)XPG*=1.5
						if(usr.RestedTime>world.realtime)XPG*=1.5
						usr.Smithing_XP+=XPG
						if(usr.HasLiberalArtsDegree)
							usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
							usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
						usr.SmithingLevelCheck()
						usr.contents+=A
						usr.IsCooking=0
//						usr.InventoryCheck()
						del(src)
				else usr<<"You may only smelt one thing at a time."
			else usr<<"You require smithing level [ReqSkill] to smelt this."
mob/var
	MineX
	MineY
	MineZ
mob/var/tmp/IsMining=0
area/UndergroundMine
	luminosity = 1
	Earth
		Entrance
	Namek
	Vegeta
		Entrance
	Ice
	Arconia
		Entrance
	New()
		..()
		Mines +=src
	Del()
		Mines-=src
		..()

turf/Terrain/Grass
	var/tmp/HasOre=0
	var/tmp/ExtraOre=0
	var/timer
	New()
		..()
		if(prob(17)) OreGenerate()
	proc/OreGenerate()
		src.HasOre=0
		src.overlays=null
		if(prob(1) && !HasOre)
			timer=((600*Year_Speed)*4) // Lasts a month in-game
			HasOre++
			if(prob(20)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15))
				HasOre++
				if(prob(10)) HasOre++
		switch(HasOre)
			if(1) overlays+='Copper Ore Small.dmi'
			if(2) overlays+='Tin Ore Small.dmi'
			if(3) overlays+='Iron Ore  Small.dmi'
			if(4) overlays+='Mythril Ore Small.dmi'
			if(5) overlays+='Small Magic Ore.dmi'
			if(6) overlays+='Medium Magic Ore.dmi'
		if(prob(20)) ExtraOre++
		if(HasOre) luminosity = 5
		if(ExtraOre)
			src.overlays=null
			switch(HasOre)
				if(1) overlays+='Copper Ore Medium.dmi'
				if(2) overlays+='Tin Ore Medium.dmi'
				if(3) overlays+='Iron Ore  Medium.dmi'
				if(4) overlays+='Mythril Ore.dmi'
			if(prob(HasOre))
				var/spawnNPC
				spoot
				spawnNPC= pick(typesof(/mob/NPC/Peaceful))
				if(spawnNPC==/mob/NPC||spawnNPC==/mob/NPC/Peaceful) goto spoot
				var/mob/NPC/NewNPC= new spawnNPC
				NewNPC.loc=locate(src.x,src.y,src.z)
		spawn(timer)
			HasOre=0
			overlays=null


	proc/OreGenerate2()
		src.HasOre=0
		src.overlays=null
		if(prob(30) && !HasOre)
			timer=((600*Year_Speed)*4) // Lasts a month in-game
			HasOre++
			if(prob(20)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15))
				HasOre++
				if(prob(10)) HasOre++
		switch(HasOre)
			if(1) overlays+='Copper Ore Small.dmi'
			if(2) overlays+='Tin Ore Small.dmi'
			if(3) overlays+='Iron Ore  Small.dmi'
			if(4) overlays+='Mythril Ore Small.dmi'
			if(5) overlays+='Small Magic Ore.dmi'
			if(6) overlays+='Medium Magic Ore.dmi'
		if(prob(20)) ExtraOre++
		if(ExtraOre)
			src.overlays=null
			switch(HasOre)
				if(1) overlays+='Copper Ore Medium.dmi'
				if(2) overlays+='Tin Ore Medium.dmi'
				if(3) overlays+='Iron Ore  Medium.dmi'
				if(4) overlays+='Mythril Ore.dmi'
		if(prob(2.5*HasOre))
			var/spawnNPC
			spoot
			spawnNPC= pick(typesof(/mob/NPC/Predators))
			if(spawnNPC==/mob/NPC||spawnNPC==/mob/NPC/Predators||spawnNPC==/mob/NPC/Predators/Weaker_Version||spawnNPC==/mob/NPC/Predators/Weakest_Version) goto spoot
			var/mob/NPC/NewNPC= new spawnNPC
			NewNPC.loc=locate(src.x,src.y,src.z)
		spawn(timer)
			HasOre=0
			overlays=null

	verb
		Mine()
			set src in view(1)
			if(src.HasOre&&!usr.IsMining&&!usr.IsCooking&&!usr.IsFishing&&!usr.KOd)
				var/ore = "Copper Ore"
				var/SkillNeed=1
				var/obj/items/rawore/A=/obj/items/rawore/Copper
				if(src.HasOre==2)
					ore = "Tin Ore"
					SkillNeed=15
					A=/obj/items/rawore/Tin
				if(src.HasOre==3)
					ore = "Iron Ore"
					SkillNeed=15
					A=/obj/items/rawore/Iron
				if(src.HasOre==4)
					ore = "Mythril Ore"
					SkillNeed=40
					A=/obj/items/rawore/Mythril
				if(src.HasOre==5)
					ore = "Silver Ore"
					SkillNeed=40
					A=/obj/items/rawore/Silver
				if(src.HasOre==6)
					ore = "Auracite Ore"
					SkillNeed=50
					A=/obj/items/rawore/Auracite
				var/HasBoost=0
				if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
				if(usr.Mining_Level+HasBoost<SkillNeed)
					usr<< "You require mining level [SkillNeed] in order to mine this."
					return
				view(usr)<<"[usr] starts to mine at the [ore]."
				var/R=rand(1,1000)
				usr.IsMining=R
				var/MineSpeed=rand(300,600)
				var/SmeltSpeed=rand(300,600)
				var/usingpick=0
				var/cansmelt=0
				for(var/obj/items/pickaxe/PA in usr)
					if(istype(PA,/obj/items/pickaxe/Old_Pickaxe))
						if(usingpick < 1)
							usingpick = 1
							if(PA.autosmelt)
								cansmelt=PA.autosmelt
								MineSpeed=((rand(300,600))-75) + (SmeltSpeed-(SmeltSpeed*cansmelt))
							else
								MineSpeed=(rand(300,600))-75
					if(istype(PA,/obj/items/pickaxe/Good_Pickaxe))
						if(usingpick < 2)
							usingpick = 2
							if(PA.autosmelt)
								cansmelt=PA.autosmelt
								MineSpeed=((rand(300,600))-140) + (SmeltSpeed-(SmeltSpeed*cansmelt))
							else
								MineSpeed=(rand(300,600))-140
					if(istype(PA,/obj/items/pickaxe/Super_Pickaxe))
						if(usingpick < 3)
							usingpick = 3
							if(PA.autosmelt)
								cansmelt=PA.autosmelt
								MineSpeed=((rand(300,600))-200) + (SmeltSpeed-(SmeltSpeed*cansmelt))
							else
								MineSpeed=(rand(300,600))-200
				if(usr.Mining_Level+HasBoost>=15) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=30) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=45) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=60) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=75) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=90) MineSpeed*=0.9
				spawn(MineSpeed) if(src&&usr&&usr.IsMining==R&&HasOre)
					if(prob(1))
						usr<<"You manage to find a heart of the mountain."
						usr.contents+= new /obj/items/ingredients/Heart_Of_The_Mountain
					var/XPG
					var/result
					if(cansmelt)
						var/obj/items/rawore/AA=new A
						XPG=AA.GivesXP
						A=AA.ResultingOre
						del(AA)
						var/obj/items/cookedfood/B=new A
						result=B.name
						usr.contents+=B
					else
						var/obj/items/rawore/AA=new A
						XPG=AA.GivesXP
						result=AA.name
						usr.contents+=AA
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Mining_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.MiningLevelCheck()
					if(cansmelt)
						usr.Smithing_XP+=XPG
						usr.SmithingLevelCheck()
						view(usr)<<"[usr] has mined out a [result]!"
						if(ExtraOre)
							var/obj/items/cookedfood/AAA=new A
							usr.contents+=AAA
							view(usr)<<"[usr] has mined out a [result]!"
					else
						view(usr)<<"[usr] has mined out a [result] ore!"
						if(ExtraOre)
							var/obj/items/rawore/AAA=new A
							usr.contents+=AAA
							view(usr)<<"[usr] has mined out a [result] ore!"
					usr.IsMining=0
//					usr.InventoryCheck()
					src.HasOre=0
					src.overlays=null



turf/Terrain/Ground
	var/tmp/HasOre=0
	var/tmp/ExtraOre=0
	var/timer
	New()
		..()
		if(prob(5)) OreGenerate()
	proc/OreGenerate()
		src.HasOre=0
		src.overlays=null
		if(prob(1) && !HasOre)
			timer=((600*Year_Speed)*4)
			HasOre++
			if(prob(20)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15))
				HasOre++
				if(prob(10)) HasOre++
		switch(HasOre)
			if(1) overlays+='Copper Ore Small.dmi'
			if(2) overlays+='Tin Ore Small.dmi'
			if(3) overlays+='Iron Ore  Small.dmi'
			if(4) overlays+='Mythril Ore Small.dmi'
			if(5) overlays+='Small Magic Ore.dmi'
			if(6) overlays+='Medium Magic Ore.dmi'
		if(prob(20)) ExtraOre++
		if(HasOre) luminosity = 5
		if(ExtraOre)
			src.overlays=null
			switch(HasOre)
				if(1) overlays+='Copper Ore Medium.dmi'
				if(2) overlays+='Tin Ore Medium.dmi'
				if(3) overlays+='Iron Ore  Medium.dmi'
				if(4) overlays+='Mythril Ore.dmi'
			if(prob(HasOre))
				var/spawnNPC
				spoot
				spawnNPC= pick(typesof(/mob/NPC/Peaceful))
				if(spawnNPC==/mob/NPC||spawnNPC==/mob/NPC/Peaceful) goto spoot
				var/mob/NPC/NewNPC= new spawnNPC
				NewNPC.loc=locate(src.x,src.y,src.z)
		spawn(timer)
			HasOre=0
			overlays=null


	proc/OreGenerate2()
	/*	//if(prob(66))
		if(z==1) Gravity=rand(EarthGrav,TechCap)
		else if(z==2) Gravity=rand(NamekGrav,TechCap)
		else if(z==3) Gravity=rand(VegetaGrav,TechCap)
		else if(z==5) Gravity=rand(ArconiaGrav,TechCap)
		else if(z==4) Gravity=rand(IceGrav,TechCap)
		else Gravity=rand(1,TechCap)*/
		if(prob(30) && !HasOre)
			timer=((600*Year_Speed)*4) // Lasts a month in-game
			HasOre++
			if(prob(20)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15)) HasOre++
			if(prob(15))
				HasOre++
				if(prob(10)) HasOre++
		switch(HasOre)
			if(1) overlays+='Copper Ore Small.dmi'
			if(2) overlays+='Tin Ore Small.dmi'
			if(3) overlays+='Iron Ore  Small.dmi'
			if(4) overlays+='Mythril Ore Small.dmi'
			if(5) overlays+='Small Magic Ore.dmi'
			if(6) overlays+='Medium Magic Ore.dmi'
		if(prob(20)) ExtraOre++
		if(ExtraOre)
			src.overlays=null
			switch(HasOre)
				if(1) overlays+='Copper Ore Medium.dmi'
				if(2) overlays+='Tin Ore Medium.dmi'
				if(3) overlays+='Iron Ore  Medium.dmi'
				if(4) overlays+='Mythril Ore.dmi'
		if(prob(2.5*HasOre))
			var/spawnNPC
			spoot
			spawnNPC= pick(typesof(/mob/NPC/Predators))
			if(spawnNPC==/mob/NPC||spawnNPC==/mob/NPC/Predators||spawnNPC==/mob/NPC/Predators/Weaker_Version||spawnNPC==/mob/NPC/Predators/Weakest_Version) goto spoot
			var/mob/NPC/NewNPC= new spawnNPC
			NewNPC.loc=locate(src.x,src.y,src.z)
		spawn(timer)
			HasOre=0
			overlays=null

	verb
		Mine()
			set src in view(1)
			if(src.HasOre&&!usr.IsMining&&!usr.IsCooking&&!usr.IsFishing&&!usr.KOd)
				var/ore = "Copper Ore"
				var/SkillNeed=1
				var/obj/items/rawore/A=/obj/items/rawore/Copper
				if(src.HasOre==2)
					ore = "Tin Ore"
					SkillNeed=15
					A=/obj/items/rawore/Tin
				if(src.HasOre==3)
					ore = "Iron Ore"
					SkillNeed=15
					A=/obj/items/rawore/Iron
				if(src.HasOre==4)
					ore = "Mythril Ore"
					SkillNeed=40
					A=/obj/items/rawore/Mythril
				if(src.HasOre==5)
					ore = "Silver Ore"
					SkillNeed=40
					A=/obj/items/rawore/Silver
				if(src.HasOre==6)
					ore = "Auracite Ore"
					SkillNeed=50
					A=/obj/items/rawore/Auracite
				var/HasBoost=0
				if(locate(/obj/items/Ring_Of_Smithing) in usr) HasBoost=10
				if(usr.Mining_Level+HasBoost<SkillNeed)
					usr<< "You require mining level [SkillNeed] in order to mine this."
					return
				view(usr)<<"[usr] starts to mine at the [ore]."
				var/R=rand(1,1000)
				usr.IsMining=R
				var/MineSpeed=rand(300,600)
				var/SmeltSpeed=rand(300,600)
				var/usingpick=0
				var/cansmelt=0
				for(var/obj/items/pickaxe/PA in usr)
					if(istype(PA,/obj/items/pickaxe/Old_Pickaxe))
						if(usingpick < 1)
							usingpick = 1
							if(PA.autosmelt)
								cansmelt=PA.autosmelt
								MineSpeed=((rand(300,600))-75) + (SmeltSpeed-(SmeltSpeed*cansmelt))
							else
								MineSpeed=(rand(300,600))-75
					if(istype(PA,/obj/items/pickaxe/Good_Pickaxe))
						if(usingpick < 2)
							usingpick = 2
							if(PA.autosmelt)
								cansmelt=PA.autosmelt
								MineSpeed=((rand(300,600))-140) + (SmeltSpeed-(SmeltSpeed*cansmelt))
							else
								MineSpeed=(rand(300,600))-140
					if(istype(PA,/obj/items/pickaxe/Super_Pickaxe))
						if(usingpick < 3)
							usingpick = 3
							if(PA.autosmelt)
								cansmelt=PA.autosmelt
								MineSpeed=((rand(300,600))-200) + (SmeltSpeed-(SmeltSpeed*cansmelt))
							else
								MineSpeed=(rand(300,600))-200
				if(usr.Mining_Level+HasBoost>=15) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=30) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=45) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=60) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=75) MineSpeed*=0.9
				if(usr.Mining_Level+HasBoost>=90) MineSpeed*=0.9
				spawn(MineSpeed) if(src&&usr&&usr.IsMining==R&&HasOre)
					if(prob(1))
						usr<<"You manage to find a heart of the mountain."
						usr.contents+= new /obj/items/ingredients/Heart_Of_The_Mountain
					var/XPG
					var/result
					if(cansmelt)
						var/obj/items/rawore/AA=new A
						XPG=AA.GivesXP
						A=AA.ResultingOre
						del(AA)
						var/obj/items/cookedfood/B=new A
						result=B.name
						usr.contents+=B
					else
						var/obj/items/rawore/AA=new A
						XPG=AA.GivesXP
						result=AA.name
						usr.contents+=AA
					if(usr.InspiredTime>world.realtime)XPG*=1.5
					if(usr.RestedTime>world.realtime)XPG*=1.5
					usr.Mining_XP+=XPG
					if(usr.HasLiberalArtsDegree)
						usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
						usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
					usr.MiningLevelCheck()
					if(cansmelt)
						usr.Smithing_XP+=XPG
						usr.SmithingLevelCheck()
						view(usr)<<"[usr] has mined out a [result]!"
						if(ExtraOre)
							var/obj/items/cookedfood/AAA=new A
							usr.contents+=AAA
							view(usr)<<"[usr] has mined out a [result]!"
					else
						view(usr)<<"[usr] has mined out a [result] ore!"
						if(ExtraOre)
							var/obj/items/rawore/AAA=new A
							usr.contents+=AAA
							view(usr)<<"[usr] has mined out a [result] ore!"
					usr.IsMining=0
//					usr.InventoryCheck()
					src.HasOre=0
					src.overlays=null


