
obj/items/var/CapsuleTech=0
obj/items/Antihacking_Circuitry
	icon='Lab.dmi'
	icon_state="Computer 3"
	desc="This will make it +5 levels harder to hack your door."
	verb/Install()
		var/Choices=list()
		for(var/obj/Door/D in view(1,usr)) if(!D.AntiHack) Choices+=D
		Choices+="Cancel"
		var/obj/Door/C=input("Install [src] into which door?") in Choices
		if(C=="Cancel") return
		range(20,C) << "[usr] enchances their [C] to AntiHack level [C.AntiHack]."
		usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] enchances their door [C].\n")
		C.AntiHack += 5
		del(src)

/*
obj/items/Medical_Scanner
	icon='Lab.dmi'
	icon_state="Panel1"
	desc="Tells you various information about a character depending on the upgrade level."
	verb/Medical_Scan(mob/player/P in view(5)) if(usr.CanPing)
		usr.CanPing=0
		usr<<"[P] is a [P.gender] [P.Race]."
		/*
Age, decline, incline, body, body parts, what is critical, birthdate, mods, mutations, genetic mods, "scarring" aka zenkai, meditation, fly, zanzo, combat mods, gain mult

*/
		spawn(20) usr.CanPing=1*/


obj/items/Stud_Finder
	icon='Lab.dmi'
	icon_state="Panel1"
	desc="Tells you the health remaining on a door, roof or wall."
	verb/Detect()
		if(usr.CanPing)
			usr.CanPing=0
			for(var/obj/Door/A in get_step(usr,usr.dir)) range(5,usr) << "(Door) Stud Finder: [A] has [A.Health] remaining."
			var/turf/T=get_step(usr,usr.dir)
			if(istype(T,/turf/Upgradeable)) range(5,usr) << "Stud Finder: [T] has [T.Health] remaining."
			spawn(20) usr.CanPing=1
		else usr<<"On cool down."

obj/items/Repair_Kit
	icon='Lab.dmi'
	icon_state="Tool2"
	desc="Restores full durability to any item. (Target must be on the ground)"
	verb/Repair()
		var/list/repairlist=list()
		for(var/obj/items/A in view(usr,1)) if(A.Durability<A.MaxDurability) repairlist+=A
		repairlist+="Cancel"
		var/obj/items/c=input("Repair what?") in repairlist
		if(c=="Cancel") return
		else
			c.Durability=c.MaxDurability
			if(c.Durability>c.MaxDurability) c.Durability=c.MaxDurability
			if(istype(c,/obj/items/Armor))
				c.Health=initial(c.Health)*c.Tech
			c.EquipmentDescAssign()
			view(usr)<<"[usr] repaired the [c] to full Durability!"
			del(src)


obj/items/relic/
	var/rewardTier=1
	New()
		..()
		rewardTier=rand(1,5)
		switch(rewardTier)
			if(1)name="Common Old World Relic"
			if(2)name="Average Old World Relic"
			if(3)name="Uncommon Old World Relic"
			if(4)name="Rare Old World Relic"
			if(5)name="Exceptional Old World Relic"
	desc="A mysterious old-world artifact." 
	icon='Lab.dmi'
	icon_state="Door"
	Health=500
	Flammable=1
	Old_World_Relic
	verb/Investigate()
		set category=null
		set src in usr
		var/GenPower=rewardTier
		var/obj/items/Making
		if(usr.Int_Mod>=rewardTier||usr.Magic_Potential>=rewardTier)
			GenPower*=max(usr.Int_Mod,usr.Magic_Potential)
			GenPower*=(rand(50,130)/100)
			if(GenPower<4)Making=pick(/obj/items/Enchanted_Doll,/obj/items/Android_Chassis,/obj/items/Advanced_Door_Pass,/obj/items/Mining_Bag,/obj/items/Magic_Scanner,/obj/items/Scanner,/obj/items/Digging/Hand_Drill,/obj/items/Bomb,/obj/items/Genetic_Sequencer)
			else if(GenPower<8)Making=pick(/obj/items/Enchanted_Doll,/obj/items/Android_Chassis,/obj/items/Cooking_Bag,/obj/items/Mining_Bag,/obj/items/Magic_Scanner,/obj/items/Scanner,/obj/items/Digging/Hand_Drill,/obj/items/Armor/Mythril_Armor,/obj/items/Translator,/obj/items/Simulation_Crystal)
			else if(GenPower<12)Making=pick(/obj/items/Enchanted_Doll,/obj/items/Android_Chassis,/obj/items/Stone_Of_Understanding,/obj/items/Armor/Mythril_Armor,/obj/items/Translator,/obj/items/Simulation_Crystal,/obj/items/Philosophers_Stone,/obj/items/Genetic_Sequencer,/obj/items/Android_Upgrade)
			else if(GenPower<16) Making=pick(/obj/items/Enchanted_Doll,/obj/items/Android_Chassis,/obj/items/Stone_Of_Understanding,/obj/items/Translator,/obj/items/Simulation_Crystal,/obj/items/Philosophers_Stone,/obj/items/Genetic_Sequencer,/obj/items/Android_Upgrade,/obj/items/Armor/Mythril_Armor,/obj/items/Armor/Masterwork_Armor)
			else if(GenPower<20) Making=pick(/obj/items/Gauntlets/Auracite_Gauntlets,/obj/items/Armor/Auracite_Armor,/obj/items/Armor/Masterwork_Armor,/obj/items/Sword/Auracite_Sword,/obj/items/Sword/Mythril_Sword,/obj/items/Hammer/Mythril_Hammer,/obj/items/Hammer/Silver_Hammer)
			else if(GenPower<24) Making=pick(/obj/items/Elixir_Of_Empowerment,/obj/items/Book_of_Ages,/obj/items/Book_of_Lessons,/obj/items/Gauntlets/Auracite_Gauntlets,/obj/items/Armor/Auracite_Armor,/obj/items/Armor/Masterwork_Armor,/obj/items/Sword/Auracite_Sword,/obj/items/Sword/Mythril_Sword,/obj/items/Hammer/Mythril_Hammer,/obj/items/Hammer/Silver_Hammer)
			else if(GenPower<29) Making=pick(/obj/items/Self_Replicating_Code_Injector,/obj/items/Mutagen_Injection,/obj/items/Elixir_Of_Empowerment,/obj/items/Book_of_Ages,/obj/items/Book_of_Lessons,/obj/items/Gauntlets/Auracite_Gauntlets,/obj/items/Armor/Auracite_Armor,/obj/items/Armor/Masterwork_Armor,/obj/items/Sword/Auracite_Sword,/obj/items/Sword/Mythril_Sword,/obj/items/Hammer/Mythril_Hammer,/obj/items/Hammer/Silver_Hammer)
			else  Making=pick(/obj/items/Self_Replicating_Code_Injector,/obj/items/Mutagen_Injection,/obj/items/Elixir_Of_Empowerment,/obj/items/Book_of_Ages,/obj/items/Book_of_Lessons,/obj/items/Helmet/Masterwork_Helmet,/obj/items/Power_Armor,/obj/items/Gravity,/obj/items/Hacking_Console,/obj/items/Force_Field,/obj/items/Book_of_Fortitude,/obj/items/Adamantine_Skeleton)
			var/obj/A = new Making
			A.loc=usr.loc
			view(usr)<<"[usr] has uncovered [A] from the [src]!"
			del(src)
		else
			usr<<"It is too advanced for you to decipher."


obj/items/Upgrade_Kit
	icon='Lab.dmi'
	icon_state="Tool2"
	desc="Multiplies the BP add of any weapon. (Target must be on the ground, max of 1 billion BP add)"
	New()
		..()
		icon-=rgb(0,75,75)
	verb/Upgrade()
		var/list/repairlist=list()
		for(var/obj/items/Hammer/A in view(usr,1)) repairlist+=A
		for(var/obj/items/Gauntlets/A in view(usr,1)) repairlist+=A
		for(var/obj/items/Sword/A in view(usr,1)) repairlist+=A
		repairlist+="Cancel"
		var/obj/items/c=input("Upgrade what?") in repairlist
		if(c=="Cancel") return
		else
			c.Health*=1.5
			if(c.Health>1000000000)c.Health=1000000000
			view(usr)<<"[usr] upgraded the [c] to +[c.Health] BP!"
			c.EquipmentDescAssign()
			del(src)