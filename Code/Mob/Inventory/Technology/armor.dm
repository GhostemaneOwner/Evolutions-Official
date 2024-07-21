mob
	var
		last_icon = null
	proc
		Eject(var/obj/items/Power_Armor/A)
			if(!istype(A,/obj/items/Power_Armor)) return
			A.loc = src.loc
			A.suffix = null
			if(src.hair) src.overlays += src.hair
			src.icon = src.oicon
			A.icon_state = "idle"
			view(20,src) << "[src] leaves the power armor!"
			usr.saveToLog("| | [src] leaves the power armor!")
			//if(A.Gundam) animate(src, transform = null, time = 0)
			if(Int_Mod>=4)
				if(A.Gundam) src.BPMult /= 1.3
				else src.BPMult /= 1.2
			//for(var/Skill/Buff/Giant_Mode/G in usr) if(G.Using) animate(src, transform = matrix()*2, time = 0)
			if(A.ForceModel) src.PowMult /= 1.2
			else src.StrMult /= 1.2
			if(src.HasArmorMastery) src.EndMult/=1.2
			else src.EndMult/=1.13
			src.SpdMult /= 0.8
			src.PowerArmorOn=0
			src.BreathInSpace -= 1
			src.Equip_Magic(A,"Remove")
			if(A.Health <= 0) A.icon_state = "broken"
			A.desc="<br>This is a suit of power armor. Entering it will confer +20% Strength and +13% Endurance but reduce your speed by -20%.\
Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
The suit can be grabbed and moved like a prop. Requires 100 intelligence to enter and use. [Commas(A.Health)] Durability Power Armor"

mob/var/Stealable
mob/var/HasAdamantineSkeleton=0
obj/items/Adamantine_Skeleton
	Health = 1000000000
	Grabbable = 1
	Stealable=0
	density=1
	Savable=1
	icon = 'Adamantine Tech.dmi'
	desc="<br>This Adamantine Skeleton is nigh indesctrubtible. Installing it will increase limb health by 25 and will even increase your durability by 8%. However, this will set you to 0 willpower and knock you out. This will make you sterile."

	verb/Skeletal_Surgery()
		set src in usr
		if(usr.Redoing_Stats) return
		if(usr.RPMode) return
		var/list/mob/Choices=new
		for(var/mob/player/P in get_step(usr,usr.dir))
			Choices+=P
		var/mob/M=input(usr,"Choose the target","Adamantine Skeleton") as null | anything in Choices
		if(usr.Confirm("Install Adamantine Skeleton on [M]?"))

			if(M.HasAdamantineSkeleton == 1)
				usr<<"[M] already has an [src]!"
				return

			if(M.RPMode)
				usr<<"[M] is in RPMode!"
				return


			if(M.Race == "Majin" || M.Race == "Namekian")
				usr << "Their race is unable to make use of this."
				return
			/*
			if(M.NoBreak)
				usr << "Their limbs are already immune to being broken."
				return
			*/

			if(M.HasAdamantineSkeleton == 0)

				switch(input(M,"[usr] wants to install the [src] on you. Allow it? This will make you sterile, knock you out and set you to 0 willpower.") in list("No","Yes"))
					if("No")
						usr << "[M] has declined the offer for [src]."
						return

				switch(input("Are you sure you want to proceed? they will become sterile, set to 0 willpower and be knocked out.") in list("No","Yes"))
					if("Yes")
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] applies the [src] to [M].\n")
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] applies the [src] to [M].\n")
						view(6,usr) << "<font color = grey>[usr] applies the [src] to [M]!"
						M.Willpower=0
						M.KO("applying the [src] to their body!")
						for(var/BodyPart/L in M)
							L.MaxHealth+=25
							M.Injure_Hurt(150,L,usr)
						M.HasAdamantineSkeleton=1
						M.Sterile=1
						//M.NoBreak = 1
						spawn() del(src)
					if("No")
						return
			//spawn(200)




obj/items/Android_Chassis
	Health = 1000
	Grabbable = 1
	density=1
	Savable=1
	Builder="Android Ship"
	var/AS_Droid=0
	icon = 'Android Chasis.dmi'
	New()
		desc="<br>This is an Android Chassis. It's nearly finished and only requires a player to log into it to become active."

obj/items/Enchanted_Doll
	Health = 1000
	Grabbable = 1
	density=1
	Savable=1
	icon = 'Synthetic Human.dmi'
	Builder="Mother Nature"
	New()
		desc="<br>This is an enchanted doll. This will allow a player to create as a Spirit Doll, they are loyal to their creators."

obj/items/Seedling
	Health = 1000
	Grabbable = 1
	density=1
	Savable=1
	icon = 'Saibaman.dmi'
	Builder="The Planet"
	New()
		desc="<br>A strange plant nearly ready, but requires a player to create as a saibaman."

mob/var/PowerArmorOn=0
obj/items/Power_Armor
	Health = 500
	Grabbable = 1
	Stealable=0
	density=1
	Tech=1
	Savable=1
	icon = 'Power Armour.dmi'
	icon_state = "idle"
	var/Gundam=0
	var/ForceModel=0

	New()
		desc="<br>This is a suit of power armor. Entering it will confer [ForceModel?"+20% Force" : "+20% Strength"] and +13% Endurance but reduce your speed by -20%.\
		Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
		The suit can be grabbed and moved like a prop. Requires 100 intelligence and an int mod of 4+ to enter and use. [Commas(Health)] Health Power Armor"
		if(prob(50)) icon='AndroidPowersuit.dmi'
		..()
	verb/Set_Password()
		set src in oview(1)
		if(Password == null)
			Password=input("Choose a password for this device.") as text
			usr << "Password set."
			return
		else
			usr << "This device already has a password set."
			return
	verb/Repair()
		set src in oview(1)
		var/obj/Resources/A
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		for(var/obj/Resources/B in usr) A=B
		var/Cost=5000000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(!usr.Confirm("Repair [src] for [Cost] resources?")) return
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to repair it."
			return
		view(usr)<<"[usr] repairs the [src]."
		A.Value-=Cost
		Durability=MaxDurability
		Health=Tech*500
		desc="<br>This is a suit of power armor. Entering it will confer [ForceModel?"+20% Force" : "+20% Strength"] and +13% Endurance but reduce your speed by -20%.\
		Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
		The suit can be grabbed and moved like a prop. Requires 100 intelligence and an int mod of 4+ to enter and use. [Commas(A.Health)] Health Power Armor"




	verb/Customize()
		set src in oview(1)
		var/obj/Resources/A
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		if(TotalEnchants>=15)
			icon='Base_Mech_Icon.dmi'
			pixel_x=-28
			pixel_y=0
		if(TotalEnchants>=15)
			usr<<"This is already fully customized."
			return
		if(TotalEnchants>=10&&Gundam==0)
			usr<<"This is already fully customized."
			return
		for(var/obj/Resources/B in usr) A=B
		var/Cost=60000000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/C=input("It will cost [Commas(Cost)] resources for you to customize [src] and grant it +1% in the chosen stat when equipped. Please choose a stat to enhance, up to a max of +5% in a single stat. Power Armor can have up to 10 customizations and Gundam can have 15.") in list("Strength","Durability","Speed","Force","Offense","Defense","Cancel")
		if(Cost>A.Value)
			usr<<"You do not have enough resources to repair it."
			return
		var/Actual=Cost
		switch(C)
			if("Cancel")
				return
			if("Strength")
				if(isturf(loc))
					if(add_str != 0.05)
						if(A.Value >= Actual)
							A.Value -= Actual
							add_str += 0.0101
							if(add_str >= 0.05)
								add_str = 0.05
							magical = 1
							cost += Actual
							TotalEnchants++
							usr << "Customization applied. Total +[add_str*100]% strength."
					else
						usr << "This stat is already fully customized."
//					return
			if("Durability")
				if(isturf(loc))
					if(add_end != 0.05)
						if(A.Value >= Actual)
							A.Value -= Actual
							add_end += 0.0101
							if(add_end >= 0.05) add_end = 0.05
							magical = 1
							cost += Actual
							TotalEnchants++
							usr << "Customization applied. Total +[add_end*100]% durability."
					else
						usr << "This stat is already fully customized."
//					return
			if("Force")
				if(isturf(loc))
					if(add_force != 0.05)
						if(A.Value >= Actual)
							A.Value -= Actual
							add_force += 0.0101
							if(add_force >= 0.05) add_force = 0.05
							magical = 1
							cost += Actual
							TotalEnchants++
							usr << "Customization applied. Total +[add_force*100]% force."
					else
						usr << "This stat is already fully customized."
//					return
			if("Speed")
				if(isturf(loc))
					if(add_spd != 0.05)
						if(A.Value >= Actual)
							A.Value -= Actual
							add_spd += 0.0101
							if(add_spd >= 0.05) add_spd = 0.05
							magical = 1
							cost += Actual
							TotalEnchants++
							usr << "Customization applied. Total +[add_spd*100]% speed."
					else
						usr << "This stat is already fully customized."
//					return
			if("Offense")
				if(isturf(loc))
					if(add_off != 0.05)
						if(A.Value >= Actual)
							A.Value -= Actual
							add_off += 0.0101
							if(add_off >= 0.05) add_off = 0.05
							magical = 1
							cost += Actual
							TotalEnchants++
							usr << "Customization applied. Total +[add_off*100]% offence."
					else
						usr << "This stat is already fully customized."
//					return
			if("Defense")
				if(isturf(loc))
					if(add_def != 0.05)
						if(A.Value >= Actual)
							A.Value -= Actual
							add_def += 0.0101
							if(add_def >= 0.05) add_def = 0.05
							magical = 1
							cost += Actual
							TotalEnchants++
							usr << "Customization applied. Total +[add_def*100]% defence."
					else
						usr << "This stat is already fully customized."
//					return

		view(usr)<<"[usr] customizes the [src], enhancing its [C]."
//		A.Value-=Cost
		if(TotalEnchants>=15)
			icon='Base_Mech_Icon.dmi'
			pixel_x=-28
			pixel_y=0



	verb/Upgrade()
		set src in view(1)
		var/obj/Resources/A
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		for(var/obj/Resources/B in usr) A=B
		var/CostA=15000000*Tech/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(usr.Int_Level>80&&!CapsuleTech) if(usr.Confirm("Add capsule tech for [CostA]?"))
			if(CostA>A.Value)
				usr<<"You do not have enough resources to add capsule tech."
				return
			A.Value-=CostA
			src.cost += CostA
			CapsuleTech=1
			usr<<"Capsule Tech added! You may now add this item to your inventory!"
			return
		if(Gundam) if(usr.Confirm("Apply Gundam icon effects?"))
			icon='Android-2.dmi'
			pixel_x=-20
			pixel_y=0
		var/Cost=500000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/GCost=80000000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? ([Tech]-[round(Max_Upgrade)])") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<=Tech) return
		Upgrade=round(Upgrade)
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		//view(usr)<<"[usr] upgrades the [src] to level [Upgrade]."
		A.Value-=Cost
		cost += Cost
		Tech=Upgrade
		Health=Tech*500
		if(Gundam)Health=Tech*2500
		if(usr.Int_Level>=130&&!Gundam&&usr.Int_Mod>=5)
			if(usr.Confirm("Would you like to upgrade it into a Gundam mobile suit? Cost: [Commas(GCost)]"))
				if(GCost>A.Value)
					usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
					return
				A.Value-=Cost
				cost += GCost
				Tech=Upgrade
				Health=Tech*2500
				Gundam=1
				icon='Android-2.dmi'
				pixel_x=-20
				pixel_y=0
				//animate(src, transform = matrix()*3, time = 2)
		desc="<br>This is a suit of power armor. Entering it will confer [ForceModel?"+20% Force" : "+20% Strength"] and +13% Endurance but reduce your speed by -20%.\
		Once the armor is reduced to 0 durability, it will break and eject its user. To exit or enter the armor, simply use the associated verb.  \
		The suit can be grabbed and moved like a prop. Requires 100 intelligence and an int mod of 4+ to enter and use. [Commas(A.Health)] Health Power Armor"


	verb/Use_Power_Armor()
		set src in view(1)
		if(usr.Redoing_Stats) return
		if(src.suffix == "*Equipped*")if(usr.KOd==0)
			usr.Eject(src)
			return
		if(usr.AndroidLevel)
			usr<<"You can not use this as a cyborg."
			return
		if(usr.Oozaru)
			usr << "Can't do that while in Oozaru."
			return
		if(usr.Werewolf)
			usr << "Can't do that while using Lycanthropy."
			return
		if(usr.HelmetOn)if(!usr.HasHeavyArmorTraining)
			usr<<"You are already wearing a helmet."
			return
		if(usr.ArmorOn)
			usr<<"You can't wear regular armor under the power armor."
			return
		if(usr.Int_Level < 100||usr.Int_Mod<4)
			if(!usr.Rank == "Red Ribbon Leader")
				usr << "You need an intelligence level of at least 100 and Int mod of atleast 4 in order to understand how to operate the complex controls used in this suit of power armor!"
				return
		if(Gundam&&usr.Int_Mod<5)
			usr << "You need an intelligence mod of at least 5 in order to understand how to operate the complex controls used in this Gundam!"
			return
		var/p=input("Input password.") as text
		if(src in range(1,usr)) if(src.suffix==null) if(src.Health > 0) if(usr.Int_Level >= 100) if(usr.KOd==0) if(p == src.Password)
			for(var/mob/M in range(1,src))
				if(M.GrabbedMob == src)
					usr << "You're unable to enter power armor that is being carried by someone."
					return
			var/already_wearing = 0
			for(var/obj/items/Power_Armor/A in usr)
				already_wearing = 1
				break
			if(!already_wearing)
				usr.oicon = usr.icon
				src.icon_state = ""
				usr.icon = src.icon
			//	if(Gundam) animate(usr, transform = matrix()*3, time = 2)
				if(usr.hair) usr.overlays -= usr.hair
				usr.overlays-=usr.hair
				usr.loc = src.loc
				src.loc = usr
				src.suffix = "*Equipped*"
				view(20,usr) << "[usr] enters the power armor!"
				usr.saveToLog("| | [usr] enters the power armor!")
				usr.Equip_Magic(src,"Add")
				if(usr.Int_Mod>=4)
					if(Gundam)
						usr.pixel_x=-20
						if(TotalEnchants>=15)usr.pixel_x=-28
						usr.BPMult *= 1.3
					else usr.BPMult *= 1.2
				if(ForceModel) usr.PowMult *= 1.2
				else usr.StrMult *= 1.2
				if(usr.HasArmorMastery) usr.EndMult*=1.2
				else usr.EndMult*=1.13
				usr.SpdMult *= 0.8
				usr.BreathInSpace += 1
				usr.PowerArmorOn=1
				return
			else
				usr << "You can't enter more than one suit of power armor at a time!"
				return
		if(src.Health <= 0)
			src.icon_state = "broken"
			usr << "You need to repair this armor using the Repair verb before you can use it again."
			return
	Click()
		if(src.suffix == "*Equipped*") if(src.loc == usr) if(usr.KOd==0)
			usr.Eject(src)
			return
obj/items/Bandages
	Health=100

	Flammable = 1
	icon = 'Torso Bandage.dmi'
	desc = "These are bandages. Equipping them gives you an increase to your regeneration for two minutes. Using them in battle makes them wear away."
	/*New()
		icon = pick('Torso Bandage.dmi','Arm Wraps.dmi')
		..()*/
	verb
		Use_on(mob/M in view(1))
			if(M.IsBandaged)
				usr<<"They already have bandages equipped."
				return
			M.overlays+='Torso Bandage.dmi'
			view(20,usr) << "[usr] puts [src] on [M]."
			usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src] on [M].\n")
			M.IsBandaged=100
			del(src)




mob/proc/ArmorRemove()
	for(var/obj/items/Armor/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		ArmorOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		if(src.HasArmorMastery) src.EndMult/=(A.End+0.07)
		else src.EndMult/=A.End
		src.SpdMult/=A.Spd
//		if(src.HasArmorMastery) src.ResMult/=1.1
		view(20,src) << "[src]'s [A] falls off."
		A.EquipmentDescAssign()
		break

mob/proc/SwordRemove()
	for(var/obj/items/Sword/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		SwordOn=0
		if(src.HasSwordsman) src.OffMult/=(A.Off+0.08)
		else src.OffMult/=A.Off
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		for(var/Skill/Buff/Armament/SF in src) if(SF.Using) SF.use(src)
		view(20,src) << "[src] removes [A]."
		break

mob/proc/HammerRemove()
	for(var/obj/items/Hammer/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		HammerOn=0
		StrMult/=1.1
		if(src.HasHammerTime) src.SpdMult*=(A.Spd+0.06)
		else src.SpdMult*=A.Spd
		if(src.HasHammerTime) src.OffMult*=(A.Off+0.06)
		else src.OffMult*=A.Off
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		for(var/Skill/Buff/Armament/SF in src) if(SF.Using) SF.use(src)
		view(20,src) << "[src] removes [A]."
		break
mob/proc/HelmetRemove()
	for(var/obj/items/Helmet/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		HelmetOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		view(20,src) << "[src] removes [A]."
		break



mob/proc/MaskRemove()
	for(var/obj/items/Magic_Mask/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		MaskOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		view(20,src) << "[src] removes [A]."
		break

mob/proc/GlovesRemove()
	for(var/obj/items/Gauntlets/A in src) if(A.suffix)
		Equip_Magic(A,"Remove")
		A.suffix=null
		GlovesOn=0
		var/image/_overlay = image(A.icon)
		_overlay.pixel_x = A.pixel_x
		_overlay.pixel_y = A.pixel_y
		overlays-=_overlay
		view(20,src) << "[src] removes [A]."
		break
obj/items/var/MasterSmith=0
obj/items/Armor
	Health=100

	var/KineticBarrier=0
	var/Spd=0.85
	var/End=1.15
	icon='Armor1.dmi'
	//desc="Wearing it will trade [Spd*100]% Speed for [End*100]% Endurance"
	New()
		desc="<br>[Commas(Health)] Health Armor. Wearing it will trade [Spd*100]% Speed for [End*100]% Endurance. (Armor Mastery adds +7% End)."
		..()
	verb/Repair()
		set src in oview(1)
		var/R=input("Intelligence or Magic?") in list("Intelligence","Magic","Cancel")
		if(R=="Intelligence")
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=500000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			if(!usr.Confirm("Repair [src] for [Cost] resources?")) return
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to repair [src]"
				return
			A.Value-=Cost
			Durability=MaxDurability
			Health=Tech*100
			src.EquipmentDescAssign()
			view(usr)<<"[usr] repairs [src]."


		if(R=="Magic")
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Cost=500000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
			if(!usr.Confirm("Repair [src] for [Cost] mana?")) return
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough mana to repair [src]"
				return
			A.Value-=Cost
			Durability=MaxDurability
			Health=Tech*100
			src.EquipmentDescAssign()
			view(usr)<<"[usr] repairs [src]."


	verb/Upgrade()
		set src in view(1)
		var/R=input("Intelligence or Magic?") in list("Intelligence","Magic","Cancel")
		if(R=="Intelligence")
			if(usr.Int_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=50000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
			var/Upgrade=input("Upgrade it to what level? ([Tech]-[round(Max_Upgrade)] [Cost] per level)") as num
			if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<=Tech) return
			Upgrade=round(Upgrade)
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			A.Value-=Cost
			cost += Cost
			Tech=Upgrade
			Health=Tech*100
			src.EquipmentDescAssign()
			view(usr)<<"[usr] upgrades [src] to level [Tech]."

		if(R=="Magic")
			if(usr.Magic_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Cost=50000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
			var/Upgrade=input("Upgrade it to what level? ([Tech]-[round(Max_Upgrade)] [Cost] per level)") as num
			if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<=Tech) return
			Upgrade=round(Upgrade)
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough mana to upgrade it to level [Upgrade]"
				return
			A.Value-=Cost
			cost += Cost
			Tech=Upgrade
			Health=Tech*100
			src.EquipmentDescAssign()
			view(usr)<<"[usr] upgrades [src] to level [Tech]."

	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
	Click()
		if(src in usr)
			if(usr.Redoing_Stats) return
			for(var/obj/items/Armor/A in usr)
				if(A.suffix)if(A!=src)
					usr<<"You already have armor equipped."
					return
			for(var/obj/items/Power_Armor/A in usr)
				if(A.suffix)if(A!=src)
					usr<<"You already have armor equipped."
					return
			if(Durability<=1)
				usr<<"[src] has 0 Durability. Repair it first."
				return
			if(Health<=1)
				usr<<"[src] has 0 Health. Repair it first."
				return
			if(!suffix)
				if(usr.ArmorOn)
					usr<<"You are already wearing an armor."
					return
				if(usr.HelmetOn)if(!usr.HasHeavyArmorTraining)
					usr<<"You are already wearing a helmet."
					return
				suffix="*Equipped*"
				usr.ArmorOn=1+AvoidsCrits
				usr.Equip_Magic(src,"Add")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays+=_overlay
				if(usr.HasArmorMastery) usr.EndMult*=(End+0.07)
				else usr.EndMult*=End
				usr.SpdMult*=Spd
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
				return
			else
				if(!usr.ArmorOn)
					usr<<"You are not currently wearing an armor."
					return
				suffix=null
				usr.ArmorOn=0
				usr.Equip_Magic(src,"Remove")
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays-=_overlay
				if(usr.HasArmorMastery) usr.EndMult/=(End+0.07)
				else usr.EndMult/=End
				usr.SpdMult/=Spd
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
				usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
				return
	Normal_Armor
	Copper_Armor
		Durability=150
		MaxDurability=150
	Iron_Armor
		Spd=0.8
		End=1.23
		Durability=175
		MaxDurability=175
	Bronze_Armor
		Durability=175
		MaxDurability=175
		End=1.18
	Mythril_Armor
		Durability=200
		MaxDurability=200
		Spd=1
		End=1.03
	Masterwork_Armor
		Durability=250
		MaxDurability=250
		KineticBarrier=15
		Spd=0.9
		End=1.08
	Silver_Armor
		End=1.18
		Durability=200
		MaxDurability=200
		AvoidsCrits=1
	Auracite_Armor
		End=1.2
		Durability=250
		MaxDurability=250
		AvoidsCrits=2
