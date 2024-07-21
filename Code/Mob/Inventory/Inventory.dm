// ### VERBS ###
obj/items/var
	CustomDesc=null

obj/items/verb/Drop()
	if(global.rebooting)
		usr << "Unable to pick up or drop items while a reboot is in progress."
		return
	for(var/area/Void/V in range(usr))
		usr<<"You may not drop things here."
		return
	if(istype(src,/obj/items/gifts))
		usr<<"You may not drop this."
		return
	if(isturf(usr.loc))
		var/Amount=0
		for(var/obj/O in range(0,usr)) if(O.loc != usr) Amount++
		if(Amount>=5)
			usr<<"Nothing more can be placed on this spot."
			return
		if(suffix) if(!Can_Drop_With_Suffix)
			usr<<"You must unequip it first"
			return
		for(var/mob/player/A in view(usr))
			if(A.see_invisible>=usr.invisibility)
				A<<"[usr] drops [src]"
				A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [src].\n")
		usr.overlays-=icon
		loc=usr.loc
		step_to(src,usr.dir)
		dir=SOUTH
	usr.Save()
//	usr.InventoryCheck()
//obj/items/var/Element
// ### ITEMS ###

obj/Ships/verb/Drop()
	if(global.rebooting)
		usr << "Unable to pick up or drop items while a reboot is in progress."
		return
	if(isturf(usr.loc))
		for(var/mob/player/A in view(usr))
			if(A.see_invisible>=usr.invisibility)
				A<<"[usr] deploys [src]"
				A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deploys [src].\n")
		usr.overlays-=icon
		loc=usr.loc
		step_to(src,usr.dir)
		dir=SOUTH
	usr.Save()
//	usr.InventoryCheck()

/*

obj/items/Resource_Vaccuum
	icon='Item, Vaccuum.dmi'
	var/tmp/Vaccuuming
	Click() if(locate(src) in usr)
		if(Vaccuuming) return
		Vaccuuming=1
		spawn(100) Vaccuuming=0
		spawn while(Vaccuuming)		//while(R&&!(R in usr)&&R.loc)
			for(var/obj/Resources/R in view(10,usr))
				//if(!R||isnull(R)) break // sanity check
				var/Old_Loc=R.loc
				step_towards(R,usr)
				if(R.loc==Old_Loc) break
				if(R in view(1,usr))
					for(var/obj/Resources/A in usr) A.Value+=R.Value
					del(R)
				sleep(2)

*/

obj/items/Spell_Book
	name="Spell Book"
	var/ManaMult=2
	var/ExtraManaMult=0
	/*icon='Magic Items.dmi'
	icon_state = "spell book"*/
	icon='enchantmenticons.dmi'
	icon_state="BoTS"

	desc="This is a magical book full of spells. Keeping it on you while drawing on ambient forces will increase the rate you attain mana."
	New()
		name="Level [ManaMult] Spell Book (+[ExtraManaMult])"
		..()
	verb/Enhance()
		set src in view(1)
		if(usr.Magic_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Mana/A
		for(var/obj/Mana/B in usr) A=B
		var/Cost=100000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+ManaMult
		if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
		if(ManaMult>=Max_Upgrade)
			usr<<"It is already upgraded beyond what you can manage."
			return
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magical skill (Max Upgrade cannot exceed magical skill), and how much mana you have. So if the maximum is less than your magic skill then it is instead due to not having enough mana to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<ManaMult) return
		Cost*=Upgrade-ManaMult
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
		A.Value-=Cost
		ManaMult=Upgrade
		name="Level [ManaMult] Spell Book (+[ExtraManaMult])"
		//desc="Level [ManaMult] Spell Book"
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
//obj/var/Grabbable
obj/items/Magic_Circle
	icon='Magic_Circle_Pulse.dmi'
	icon_state = null
	Grabbable = 1
//	Bolted = 1
	Savable = 1
	layer = 2
	desc="This is a magical creation of sorts, able to bolster the amount of ambient mana absorbed into yourself when held in your inventory."
	verb
		Relocate()
			set src in oview(1)
			if(x&&y&&z&&!Bolted)
				Bolted=1
				range(20,src)<<"[usr] secures the [src] to the ground."

				return
			if(Bolted) if(src.Builder=="[usr.real_name]")
				range(20,src)<<"[usr] moves the [src] from the ground."
				Bolted=0

				return
		Remove()
			set src in range(1,usr)
			if(src.Builder=="[usr.real_name]")
				switch(input("Are you sure you want to remove this circle?") in list("No","Yes"))
					if("Yes")
						if(usr in range(1,src))
							range(20,src) << "[usr] removes their [src]."
							for(var/mob/M in range(20,src))
								if(M.client)
									M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removed their circle [src].\n")
							del(src)
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

		/*Destroy()
			set category=null
			if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(src in usr) del src*/
obj/items/Door_Pass
	name="Key"
	icon='Door Pass.dmi'

	desc="Click this to set it's password. Door's will check if it is correct and only let you in if it is."
	Password = null
	Click()
		if(Password)
			usr<<"It has already been programmed and cannot be reprogrammed."
			return
		Password=input("Enter a password for the doors to check if it is correct") as text
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src


obj/items/Advanced_Door_Pass
	name="Key"
	icon='Door Pass.dmi'

	desc="Click this to set it's password. Door's will check if it is correct and only let you in if it is. This will store up to 3 different passwords."
	Password = null
	var/Password2 = null
	var/Password3 = null
	Click()
		if(Password&&Password2&&Password3)
			usr<<"It has already been programmed and cannot be reprogrammed."
			return
		if(!Password)
			Password=input("Enter a password for the doors to check if it is correct") as text
			return
		if(!Password2)
			Password2=input("Enter a password for the doors to check if it is correct (Password 2)") as text
			return
		if(!Password3)
			Password3=input("Enter a password for the doors to check if it is correct (Password 3)") as text
			return
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

/*

obj/items/Cybernetics_Guide
	desc={"Cybernetics is actually quite simple. There are many modules that have different purposes.
	When you install a module, it will serve its intended purpose, but they have various drawbacks.
	These advantages and drawbacks can be read using the description verb. You can activate modules
	by picking them up and clicking them, once activated, only death can undo them. Common side effects
	of cyberization include lowering of energy, recovery, and regeneration. And yes, due to the lowered
	biological energy, it can slow learning and skill mastery of biological skills. Certain
	cyberizations will also restrict access to certain biological abilities, such as body expand. Any
	abilities lost can usually be replaced by a mechanical alternative. The more intelligence you
	gain the more modules you can make. Modules themselves are usually trade-offs of one thing for
	another, but also they will increase the effect upgrades have on you, but decrease the effect of
	biological training. When you get weapons or attacks from modules, they hardly ever use your
	natural battle power or energy to decide their damage capabilities, but rather, they will decide
	damage based on your cybernetic/artificial power from upgrading, and they will drain the energy
	from your generator to use them. Ballistic weaponry uses your strength to augment damage rather
	than force. Another common side effect of modules is loss of natural battle power gain, but
	increased effect from cybernetic power gotten from upgrades as you get more modules. Since most
	cybernetic modules decrease natural power gain, certain races would have a harder time achieving
	certain things, such as Super Saiyan for instance, and even ascension. But the cybernetic power
	you acquire can help you to become more powerful very fast, and if your race is considered weak,
	it can tip the odds heavily. In the very long run, it may be bad to be a cybernetic being, but,
	all you have to do to restore yourself, is die, and you are returned to normal. Another common
	effect of cybernetic modules is increased lifespan that rises with each new module. Many modules
	can be further upgraded before or after being installed on someone. Scientist's can upgrade not
	only the amount of available energy an android has in its generator, but the generator is also
	the biggest part of an android's artificial battle power, upgrading it is the key to having an
	android with a lot of battle power. Other modules increase artificial power very slightly just by
	having them installed."}*/

obj/items/Hacking_Console
	icon='Lab.dmi'
	icon_state="Labtop"

//	var/Value=0
	desc="If this is upgraded past the upgrade level of a door, it can open the door for you."
	verb/Upgrade()
		set src in view(1)
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=10000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade].\n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src] ([Value] Battery)"
		Level=Upgrade
		Value=Level**Level
	/*verb/Upgrade()
		set src in oview(1,usr)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"You upgrade the [src] to level [Level]"
		else usr<<"It is beyond your upgrading capabilities"*/
	verb/Use()
		for(var/obj/A in get_step(usr,usr.dir))
			if(istype(A,/obj/Door))
				var/obj/Door/D=A
				if(D.Magic_Secure)
					view(usr)<<"[usr] tries to hack into the [A], but is not able to do so!"
					return
			if(A.Level+A.AntiHack<Level)
				if(prob(100))
					view(usr)<<"[usr] uses the [src] to hack into the [A] and opens it!"
					for(var/mob/player/M in view(src))
						if(!M.client) return
						M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] and opens it!\n")
					if(istype(A,/obj/Door))
						var/obj/Door/D=A
						D.Open()
					if(istype(A,/obj/items/Safe))
						var/obj/items/Safe/S=A
						view(usr)<<"[usr] took [S.SafeResources] resources from the safe!"
						for(var/obj/Resources/B in usr) B.Value+=S.SafeResources
						S.SafeResources=0
					if(istype(A,/obj/items/Magic_Vault))
						var/obj/items/Magic_Vault/S=A
						view(usr)<<"[usr] took [S.SafeResources] mana from the vault!"
						for(var/obj/Mana/B in usr) B.Value+=S.SafeResources
						S.SafeResources=0
					if(istype(A,/obj/Ships/Spacepod))
						if(Level<A.Tech)
							view(usr)<<"[usr] tries to hack into the [A], but failed"
							return
						var/obj/Ships/Spacepod/Sh=A
						if(!Sh.Pilot)
							usr.isGrabbing = null
							Sh.Pilot=usr
							usr.reset_view(Sh)
							usr.S=Sh
							usr.loc=Sh.contents//locate(0,0,0)
					else if(istype(A,/obj/Ships))
						if(Level<A.Tech)
							view(usr)<<"[usr] tries to hack into the [A], but failed"
							return
						var/obj/Ships/Ship/Sh=A
						if(Sh.Ship=="Ardent"||Sh.Ship=="Icebreaker")
							for(var/obj/Airlock/C in world) if(C.Ship==Sh.Ship)
								view(usr)<<"[usr] enters the ship"
								usr.loc=locate(C.x,C.y-1,C.z)
								usr.InShip=Sh.Ship
						else for(var/obj/Controls/MKIControls/C in world) if(C.Ship==Sh.Ship)
							view(usr)<<"[usr] enters the ship"
							usr.loc=locate(C.x,C.y-1,C.z)
							usr.InShip=Sh.Ship

					//if(A.Password) usr << "The password is [A.Password]"
					return
				else
					view(usr)<<"[usr] tries to hack into the [A], but failed"
					return
			else
				view(usr)<<"[usr] tries to hack into the [A], but it is too advanced"
				for(var/mob/player/M in view(src))
					if(!M.client) return
					M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses the [src] to hack into [A] but it is too advanced!\n")
				return
//mob/var/Stealable
mob/var/Shockwaveable

obj/items/Magic_Vault
	desc       = "A magic vault allows for the safe storage of valuable mana.  Right click the vault and choose either 'deposit' or 'withdraw' to place or remove mana from storage."
	icon       = 'Magic Items.dmi'
	icon_state = "magic vault"
	Stealable = 1
	Savable = 1
	var/SafeResources = 0
	var/SafePassword  = ""
	Shockwaveable=0
	verb/Set_Password()
		set src in oview(1)
		if(Password == null)
			Password = input("Entering a password will help keep this vault private.") as text
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return
	verb/Deposit()
		set src in oview(1)
		var/passwd = input("What is this safe's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/putRSC = input("How much mana would you like to place in the vault?") as num
			if(putRSC<1) return
			putRSC=round(putRSC)
			for(var/obj/Mana/A in usr)
				if(A.Value < 1) return
				if(A.Value < putRSC)
					usr << "You do not have that much mana!"
					return
				else
					A.Value       -= putRSC
					SafeResources += putRSC
					return

	verb/Withdraw()
		set src in view(1)
		var/passwd = input("What is this vault's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How much mana would you like to withdraw from the vault?") as num
			if(getRSC < 1) return
			getRSC=round(getRSC)

			if(getRSC > SafeResources)
				usr << "You do not have that much mana inside of the vault!"
				return
			else
				for(var/obj/Mana/A in usr)
					A.Value       += getRSC
					SafeResources -= getRSC
				return

	verb/Check_Storage()
		set src in view(1)
		var/passwd = input ("What is this vault's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the vault."
			return
	verb/Upgrade()
		set src in view(1)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"Upgraded [src] to security level [Level]."
obj/items/Safe
	desc       = "A safe allows for the safe storage of valuable resources.  Right click the safe and choose either 'deposit' or 'withdraw' to place or remove materials from storage."
	icon       = 'Safe.dmi'
	icon_state = ""
	Stealable = 1
	Savable = 1
	var/SafeResources = 0
	//var/SafePassword  = ""

	Shockwaveable=0
	verb/Set_Password()
		set src in oview(1)
		if(Password == null)
			Password = input("Entering a password will help keep this safe private.") as text
			usr << "Password set!"
			return
		else
			usr << "The password has already been set!"
			return
	verb/Deposit()
		set src in oview(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input("What is this safe's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/putRSC = input("How many resources would you like to place in the safe?") as num
			if(putRSC<1) return
			putRSC=round(putRSC)
			for(var/obj/Resources/A in usr)
				if(A.Value < 1) return
				if(A.Value < putRSC)
					usr << "You do not have that many resources!"
					return
				else
					A.Value       -= putRSC
					SafeResources += putRSC
					return

	verb/Withdraw()
		set src in view(1)
		var/passwd = input("What is this safe's password?")
		if(SafeResources <= 0)
			SafeResources = 0
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			var/getRSC = input("How many resources would you like to withdraw from the safe?") as num
			if(getRSC < 1) return
			getRSC=round(getRSC)

			if(getRSC > SafeResources)
				usr << "You do not have that many resources inside of the safe!"
				return
			else
				for(var/obj/Resources/A in usr)
					A.Value       += getRSC
					SafeResources -= getRSC
				return

	verb/Check_Storage()
		set src in view(1)
		if(SafeResources <= 0)
			SafeResources = 0
		var/passwd = input ("What is this safe's password?")
		if(passwd != Password)
			usr << "Incorrect Password"
			return
		else
			usr << "You have [Commas(SafeResources)] in the safe."
			return
	verb/Upgrade()
		set src in view(1)
		if(Level<usr.Int_Level)
			Level=usr.Int_Level
			usr<<"Upgraded [src] to security level [Level]."

obj/items/Recycler
	desc="Clicking this will activate the recycling process and crush anything within into raw resources, but only returning half of the cost used to make the object."
	icon='Recycle.dmi'
	icon_state="open"
	layer=2.9
	Grabbable = 1
	Savable=1
	var/tmp/in_use = 0
	var/unable = list(/obj/Airlock,/obj/AndroidAirlock,/obj/AndroidControls,/obj/AndroidShip,/obj/MainframeControls,/obj/Controls,/obj/Door,/obj/Magical_Portal,/obj/Planets/,/obj/Resources,/obj/Mana,/obj/Magic_Ball/,/obj/items/Water_Purifier)
	New()
		src.pixel_x = -15
		src.pixel_y = -25
	Click()
		if(src.in_use == 0) if(src in range(1, usr))
			usr.saveToLog("| [usr] clicked [src].\n")
			if(src.icon_state != "closed")
				src.in_use = 1
				flick("closing", src)
				spawn(5) if(src)
					src.layer = 5
					spawn(10) if(src)
						src.icon_state = "closed"
						src.in_use = 0
						for(var/obj/I in src.loc)
							if(I != src)
								for(var/X in unable)
									if(ispath(I.type, X))
										return
								var/obj/Resources/A = new
								A.loc = src.loc
								if(I.cost)
									A.Value = I.cost / 2
								else
									A.Value = 1
								A.name="[Commas(A.Value)] Resources"
								view(src) << "[usr] recycles [I] for Resources."
								usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] recycles [I] for [Commas(A.Value)] Resources.\n")
								del(I)
								break
						for(var/mob/M in src.loc)
							return
			else
				src.in_use = 1
				flick("opening", src)
				spawn(7) if(src)
					src.layer = 2.9
					spawn(8) if(src)
						src.icon_state = "open"
						src.in_use = 0
		else
			usr << "This item is in the process of recycling already."
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
			return

obj/items/Force_Field
	desc="Holding this will protect you against energy attacks by having a 70% chance to reduce the damage by 30%. Each shot it shields drains the battery and requires battery to work."
	icon='Lab.dmi'
	icon_state="Computer 1"

	verb/Upgrade()
		set src in oview(1,usr)
		if(Level>10000000)
			usr<<"Item is already beyond its capacity."
			return
		var/Amount=input("How many resources do you want to put into its battery?") as num
		if(Amount<1) return
		for(var/obj/Resources/A in usr)
			if(Amount>10000000) Amount=10000000
			if(Amount>A.Value) Amount=A.Value
			Amount=round(Amount)
			src.cost += Amount
			A.Value-=Amount
			//var/Extra = 1 + Year //Helps make force fields stronger as years go by.
			Level+=Amount*usr.Int_Mod
			if(Level>65000000) Level=65000000
			view(usr)<<"[usr] adds [Commas(Amount*usr.Int_Mod)] to the [src]'s battery"
			desc=initial(desc)+"<br>[Commas(Level)] Battery Remaining"
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds to the [Commas(Amount*usr.Int_Mod)] [src]'s battery.\n")

mob/proc/Force_Field() spawn if(src)
	var/A='Force Field.dmi'
	A+=rgb(100,200,250,120)
	overlays-=A
	overlays+=A
	spawn(50) overlays-=A

/*
obj/Antivirus_Tower
	icon='Lab.dmi'
	icon_state="Tower 1"
	density=1
	desc="This emits a pulse every minute that will carry with it the antivirus, killing all zombies \
	in proximity, and curing anyone who is infected."
	var/Distance=35
	New()
		spawn if(src) Antivirus_Tower()
		var/image/A=image(icon='Lab.dmi',icon_state="Tower 2",pixel_y=32,layer=MOB_LAYER+1)
		var/image/B=image(icon='Lab.dmi',icon_state="Tower 3",pixel_y=64,layer=MOB_LAYER+1)
		overlays.Remove(A,B)
		overlays.Add(A,B)
		//sd_SetLuminosity(3)

	proc/Antivirus_Tower() while(src)
		for(var/mob/A in view(Distance,src))
			if(A.client) A.Zombied=0
			else if(A.Zombied) del(A)
		sleep(rand(400,800))


obj/items/Hover_Chair
	icon='Item, Hover Chair.dmi'
	icon_state="base"
	density=1
	layer=MOB_LAYER+10
	Savable=1
	New()
		var/image/A=image(icon='Item, Hover Chair.dmi',icon_state="side1",pixel_y=0,pixel_x=-32,layer=10)
		var/image/B=image(icon='Item, Hover Chair.dmi',icon_state="side2",pixel_y=0,pixel_x=32,layer=10)
		var/image/C=image(icon='Item, Hover Chair.dmi',icon_state="back",pixel_y=0,pixel_x=-0,layer=MOB_LAYER-1)
		var/image/D=image(icon='Item, Hover Chair.dmi',icon_state="front",pixel_y=0,pixel_x=0,layer=MOB_LAYER+10)
		var/image/E=image(icon='Item, Hover Chair.dmi',icon_state="bottom",pixel_y=-32,pixel_x=0,layer=10)
		overlays.Remove(A,B,C,D,E)
		overlays.Add(A,B,C,D,E)


	Click() if(locate(src) in usr)
		if(!suffix)
			usr.overlays+=src
			suffix="*Equipped*"
		else
		//	usr.overlays-=src
			usr.layer=MOB_LAYER+10
			usr.overlays-=usr.overlays
			suffix=null**/
obj/items/Cloak_Controls
	icon='Cloak.dmi'
	icon_state="Controls"
	desc="You can use this to activate or deactivate all cloaked objects matching the same password \
	you have set for the controls. You can also use this to remove the cloaking chip from objects \
	next to you by using uninstall on it. You can upgrade this to have more cloaking capability so \
	that it is harder to detect. This is also a personal cloak, if you activate it, you will become \
	out of phase, and stay out of phase until you deactivate it. While out of phase you will also see \
	anything that is in the same phase or lower than yourself. The personal cloak is 5 levels less \
	powerful than the cloaking modules themselves."
	var/Active
	Level=1

	verb/Use()
		if(Level<1)
			usr<<"You cannot use this without further upgrades"
			return
		if(!usr.invisibility)
			view(usr)<<"[usr] activates their personal cloak"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their personal cloak.\n")
			usr<<"You are now [Level] levels out of phase"
			usr.invisibility=Level
			usr.see_invisible=Level
			winset(usr.client,"INVIS","is-visible=true")
		else
			usr.invisibility=0
			usr.see_invisible=0
			view(usr)<<"[usr] deactivates their personal cloak."
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their personal cloak.\n")
			winset(usr.client,"INVIS","is-visible=false")

	verb/Activate()
		if(!Active)
			view(usr)<<"[usr] activates the cloaking controls"
			Active=1
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their cloak controls.\n")
		else
			view(usr)<<"[usr] deactivates the cloaking controls"
			Active=0
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] deactivates their cloak controls.\n")
		for(var/obj/A) for(var/obj/items/Cloak/B in A) if(B.Password==Password)
			if(Active) A.invisibility=Level
			else A.invisibility=0
	verb/Set() Password=input("Set the password for tracking cloaking chips of the same password") as text
	verb/Uninstall() for(var/obj/A in get_step(usr,usr.dir)) for(var/obj/items/Cloak/B in A)
		view(usr)<<"[usr] removes the cloaking system from [A]"
		A.invisibility=0
		B.loc=usr.loc
	verb/Upgrade()
		set src in view(1)
		if(Level>=100)
			usr<<"It is at the maximum."
			return
		if(usr.Int_Level<Tech)
			usr<<"This is too advanced for you to mess with."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/Cost=400000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		var/Max_Upgrade=(A.Value/Cost)+Tech
		if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
		var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
		if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
		if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
		if(Upgrade<1) Upgrade=1
		Upgrade=round(Upgrade)
		if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
			if("No") return
		Cost*=Upgrade-Tech
		if(Cost<0) Cost=0
		if(Cost>A.Value)
			usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
			return
		view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
		for(var/mob/player/M in view(src))
			if(!M.client) return
			M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].\n")
		A.Value-=Cost
		src.cost += Cost
		Tech=Upgrade
		desc="Level [Tech] [src]"
		Level=1+round(0.1*Upgrade)
		if(Level<1) Level=1
		if(Level>100) Level=100

mob/var/Upgrade_Components
obj/items/Android_Upgrade
	icon='android tech.dmi'
	name = "Android Upgrade Component"
	icon_state = "component"
	desc="This is an Android Upgrade Component, a special device capable of enhancing an artifical being. Use it on an Android and you can select which mod \
	to upgrade. Each upgrade will increase the mod you choose by 0.2x. Once a mod reaches 3, you can no longer upgrade that mod. There is a limit of 25 installed total."

	Savable = 1
/*	verb/Consume()
		if(usr.Race!="Android") usr<<"Only Androids are capable of using this."
		if(usr.Race=="Android")
			if(usr.Upgrade_Components>=10)
				if(usr.Modules<25)
					usr.Modules++
					if(usr.Modules>=20 )usr.contents+=new/Skill/Buff/Overdrive
					usr<<"You assimilate the component into your main processor and exponentially increase your power. ([usr.Modules] total installed)"
					del(src)
				else usr<<"You may not install any additional upgrades."
			else usr<<"You require atleast 10 components installed before you may consume them."*/
	verb/Use(mob/M in range(1,usr))
		if(src in usr)
			if(M.Race == "Android")
				if(M.Critical_Left_Arm || M.Critical_Right_Arm || M.Critical_Right_Leg || M.Critical_Left_Leg || M.Critical_Torso)
					usr << "Unable to use this until your systems are repaired."
					return
				if(M.Upgrade_Components>=25)
					usr<<"They are fully upgraded already."
					return
				for(var/obj/X in M)
					if(X.Using)
						if(M != usr)
							usr << "[M] must not be using any buffs before they are upgraded!"
						M << "You can't use buffs while being upgraded, please disable them so [usr] can try upgrading you again."
						return
				usr << "<font color = teal>Select a mod to upgrade. Each Android Upgrade Component will increase the selected mod by 0.1 for all but Energy and BP, up to a cap of 2. Energy will increase by 0.5 per component up to a cap of 5, BP and Speed at 2.5.<p>"
				var/T = "[M] Power - [M.BPMod]<br>[M] Energy - [M.KiMod]<br>[M] Might - [M.StrMod]<br>[M] Durability - [M.EndMod]<br>[M] Speed - [M.SpdMod]<br>[M] Offense - [M.OffMod]<br>[M] Defense - [M.DefMod]<br>[M] Regeneration - [M.BaseRegeneration]<br>[M] Recovery - [M.BaseRecovery]<br>"
				M << "[T]"
				if(M != usr)
					usr << "[T]"
				var/list/Choices=new
				Choices.Add("Might","Durability","Speed","Offense","Defense","Cancel")
				switch(input("Choose Option") in Choices)
					if("Cancel")
						return
					if("Speed")
						if(M in range(1,usr))
							if(round(M.SpdMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							M.SpdMod += 0.2
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for speed has been increased! Their speed mod went up by 0.2.     It is now [M.SpdMod].<p>"
							M << "<font color = teal>Your potential for speed has increased! Your speed mod went up by 0.2.     It is now [M.SpdMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s speed mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s speed mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Might")
						if(M in range(1,usr))
							if(round(M.StrMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.BaseStr / M.StrMod
							M.StrMod += 0.2
							M.BaseStr = N * M.StrMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for Might has been increased! Their Might mod went up by 0.2.     It is now [M.StrMod].<p>"
							M << "<font color = teal>Your potential for Might has increased! Your Might mod went up by 0.2.     It is now [M.StrMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s Might mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s Might mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Durability")
						if(M in range(1,usr))
							if(round(M.EndMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.BaseEnd / M.EndMod
							M.EndMod += 0.2
							M.BaseEnd = N * M.EndMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for durability has been increased! Their durability mod went up by 0.2.     It is now [M.EndMod].<p>"
							M << "<font color = teal>Your potential for durability has increased! Your durability mod went up by 0.2.     It is now [M.EndMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s durability mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s durability mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Offense")
						if(M in range(1,usr))
							if(round(M.OffMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.BaseOff / M.OffMod
							M.OffMod += 0.2
							M.BaseOff = N * M.OffMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for offense has been increased! Their offense mod went up by 0.2.     It is now [M.OffMod].<p>"
							M << "<font color = teal>Your potential for offense has increased! Your offense mod went up by 0.2.     It is now [M.OffMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s offense mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s offense mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
					if("Defense")
						if(M in range(1,usr))
							if(round(M.DefMod,0.1) >= 3)
								usr << "They are already maxed out."
								return
							var/N = M.BaseDef / M.DefMod
							M.DefMod += 0.2
							M.BaseDef = N * M.DefMod
							view(20,usr) << "[usr] inserts the [src] into [M].<p>"
							if(M != usr) usr << "<font color = teal>[M]'s potential for defense has been increased! Their defense mod went up by 0.2.     It is now [M.DefMod].<p>"
							M << "<font color = teal>Your potential for defense has increased! Your defense mod went up by 0.2.     It is now [M.DefMod].<p>"
							usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s defense mod by 0.2\n")
							if(M != usr) M.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [M]'s defense mod by 0.2\n")
							M.Upgrade_Components++
							del(src)
			else
				usr << "This can only be used on an Android."
				return
		else
			return
obj/items/Cloak
	icon='Cloak.dmi'
	desc="You can install this on any object to cloak it using cloak controls. First you must set the \
	password so that it matches the password of your cloak controls or it cannot be activated by those \
	controls."
	verb/Set() Password=input("Set the password for this cloak") as text
	verb/Use()
		if(!Password)
			usr<<"You must Set it first"
			return
		for(var/obj/A in get_step(usr,usr.dir))
			for(var/X in NoCloak)
				if(A.type == X)
					usr << "Unable to bend light around this item using a cloaking device....how strange..."
					return
			view(usr)<<"[usr] installs a cloaking system onto the [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a cloaking system onto [A].\n")
			A.contents+=src
obj/items/Stun_Chip
	icon='Control Chip.dmi'

	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	New()
		name=initial(name)

	verb/Use(mob/A in view(1,usr))
		if(A==usr||A.KOd)
			if(A!=usr) if(A.Willpower>=1)
				usr<<"They must be at 0 Willpower."
				return
			view(usr)<<"[usr] installs a stun chip in [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] installs a stun chip in [A].\n")
			var/obj/Stun_Chip/B=new
			B.Password=input("Input a remote access code to activate the chip") as text
			A.contents+=B
			del(src)
	verb/Remove(mob/A in view(1,usr))
		for(var/obj/Stun_Chip/B in A)if(B.CanRemove)
			view(usr)<<"[usr] removes a Stun Chip from [A]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes a Stun Chip from [A].\n")
			del(B)
			del(src)
			break
obj
	items
		Savable = 1
obj/Stun_Chip
	var/CanRemove=1
	desc="You can install this on someone and use the Stun Remote to stun them temporarily. To use the \
	remote to stun them your remote must share the same remote access code as the installed chip. \
	You can also use this to remove chips from somebody using the Remove command, both chips will be \
	destroyed in the process."
	icon='Control Chip.dmi'
obj/items/Stun_Controls
	icon='Stun Controls.dmi'
	desc="You can use this to activate a stun chip you have installed on somebody. It only works \
	within your visual range."

	verb/Set() Password=input("Input a remote access code for activating nearby stun chips") as text
	verb/Use()
		view(usr)<<"[usr] activates their stun controls"
		for(var/mob/A in view(usr))
			A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their stun controls.\n")
			for(var/obj/Stun_Chip/B in A) if(B.Password==Password) A.KO("by stun chip!")
obj/items/Transporter_Pad
	icon='Telepad.dmi'
	desc="You can use this to transport yourself between other pads sharing the same remote access code"

	Level=1
	pixel_x=-1
	pixel_y=-13
	layer=3
	Savable = 1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B) if(B!=src)
			if(B.Password==Password&&B.z)
				A+=B
				var/restricted = list(13,16)
				var/al = list(10,11)
				var/lr = list(1,2,3,4,5,6,7,8,12,14,15)
				var/travel_al = 0
				if(B.z in al) travel_al = 1
				if(B.z in restricted) A-=B
				if(usr.z in al) if(travel_al == 0) A-=B
				if(usr.z in lr) if(travel_al) A-=B
				if(Level<2&&B.z!=usr.z&&B.z) A-=B
				if(B.Level<2&&B.z!=usr.z&&B.z) A-=B
			else

		if(!A) return
		A+="Cancel"
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		if(C=="Cancel") return
		usr.overlays+='SBombGivePower.dmi'
		sleep(30)
		if(usr)
			usr.overlays-='SBombGivePower.dmi'
			usr.overlays-='SBombGivePower.dmi'
			if(C) usr.loc=C.loc
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) \n")
	verb/Set()
		set src in oview(1)
		if(!Password)
			Password=input("Set the indentification code, you can only transport to \
			other pads using the same code") as text
			name=input("Name the transporter pad, preferably name it after the location it will take you \
			to") as text
			if(!name) name=initial(name)
		else usr<<"It is already initialized"
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

			return
	verb/Upgrade()
		set src in view(1)
		var/Cost=500000000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
		if(Level>=2)
			usr<<"This is already fully upgraded."
			return
		if(!usr.Confirm("Upgrade [src]? This will cost [Cost]")) return
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				src.cost += Cost
				Level++
				usr<<"[src] upgraded!"
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between \
			planets."
obj/items/Transporter_Watch
	icon='Transporter Watch.dmi'
	desc="You can use this to transport yourself to any transporter pad that matches your watch's \
	remote access code"
	Level=1

	Savable = 1
	proc/Transport()
		var/list/A=new
		for(var/obj/items/Transporter_Pad/B)
			if(Level<2&&B.z!=usr.z&&B.z)
			else if(B.Password==Password&&B.z)
				A+=B
				var/restricted = list(13,16)
				if(B.z in restricted)
					A-=B
				if(B.z!=usr.z) A-=B
		var/obj/items/Transporter_Pad/C=input("Go to which transporter?") in A
		usr.overlays+='SBombGivePower.dmi'
		var/OldHP=usr.Health
		sleep(120)
		usr.overlays-='SBombGivePower.dmi'
		usr.overlays-='SBombGivePower.dmi'
		if(usr.Health<OldHP)
			usr<<"Interrupted due to damage."
			return
		if(C)
			if(usr.isGrabbing)
				usr.GrabRelease()
			usr.loc=C.loc
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses [src] to teleport to [C] ([C.x],[C.y],[C.z]) \n")
	verb/Use()
		if(usr.Int_Level < 80|| usr.Int_Mod < 2)
			usr << "You need an intelligence level of at least 80 and Int Mod of 2+ in order to understand how to operate the complex piece of equipment!"
			return
		if(usr.KOd==1)
			usr << "You do not have the energy required to do this..."
			return
		Transport()
	verb/Set()
		if(usr.Int_Level < 80|| usr.Int_Mod < 2)
			usr << "You need an intelligence level of at least 80 and Int Mod of 2+ in order to understand how to operate the complex piece of equipment!"
			return
		Password=input("Set the remote identification code.") as text
/*	verb/Upgrade()
		set src in view(1)
		if(Level>=2)
			usr<<"This is already fully upgraded."
			return
		var/Cost=20000000/usr.Int_Mod
		for(var/obj/Resources/A in usr)
			if(A.Value>=Cost)
				A.Value-=Cost
				src.cost += Cost
				Level++
			else usr<<"Only with [Commas(Cost)] resources can you upgrade this, allowing to to travel between planets."*/


obj/items/layer=4



obj/items/Moon
	icon='Moon.dmi'

	desc="Using this may be unhealthy."
	var/Emitter
	verb/Use()
		set src in oview(1)
		if(icon_state=="On") return
		if(usr)
			view(usr)<<"[usr] activates the [src]!"
			icon_state="On"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates the [src]!\n")
			for(var/mob/A in view(12,src))
				if(Emitter&&A.HasSSj >= 1) A.Golden()
				else
					if(locate(/obj/items/Mark_Of_The_Beast) in A) A.Werewolf()
					else if(A.HasWerewolf) A.Werewolf()
					else A.Oozaru()
			//spawn(10) if(src&&Emitter) for(var/mob/A in view(12,src)) if(A.SSjDrain>=300&&usr.Race=="Saiyan"&&usr.HasSSj > 0) A.Golden()
			src.Despawn()
	proc/Despawn()
		spawn(100) if(src) del(src)
	verb/Upgrade()
		set src in view(1)
		if(Emitter>=1)
			usr<<"This is already fully upgraded."
			return
		var/obj/Resources/A
		for(var/obj/Resources/B in usr) A=B
		var/list/Choices=new
		if(A.Value>=80000000*Tech/usr.Int_Mod&&!Emitter) if(usr.Int_Mod>=2.5) Choices.Add("Turn into Emitter ([80000000*Tech/usr.Int_Mod])")
		if(!Choices)
			usr<<"You do not have enough resources"
			return
		var/Choice=input("Change what?") in Choices
		if(Choice=="Turn into Emitter ([80000000*Tech/usr.Int_Mod])")
			if(A.Value<80000000*Tech/usr.Int_Mod) return
			A.Value-=80000000*Tech/usr.Int_Mod
			Emitter=1

		//Tech++
	Emitter
		name="Emitter"
		icon='Moon2.dmi'

obj/items/PDA
	icon='Cell Phone.dmi'
	desc="This can be used to store information."

	var/notes={"<html>
<head><title>Notes</title><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
</body><html>"}
	verb/Name()
		var/n=input("Naming PDA") as text
		if(n&&n!=" ") name=n
	verb/View()
		usr<<browse(notes,"window= ;size=700x600")
	verb/Input()
		notes=input(usr,"Notes","Notes",notes) as message
/*		notes=sanitize_n(notes)
		if( length(notes) > 800 )
			debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] client: [usr.client ? usr.client : "null"] message([length(notes)]): [notes]"
*/
obj/items/MPDA
	icon='Magic Items.dmi'
	icon_state = "spell book"
	name="Magic Journal"
	desc="This can be used to store information."

	var/notes={"<html>
<head><title>Notes</title><body>
<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
</body><html>"}
	verb/Name()
		var/n=input("Naming MPDA") as text
		if(n&&n!=" ") name=n
	verb/View()
		usr<<browse(notes,"window= ;size=700x600")
	verb/Input()
		notes=input(usr,"Notes","Notes",notes) as message
/*		notes=sanitize_n(notes)
		if( length(notes) > 800 )
			debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] client: [usr.client ? usr.client : "null"] message([length(notes)]): [notes]"
*/
var/AndroidRes=1000000
obj/items
	Main_Frame
		icon = 'Technology64x64.dmi'
		icon_state = "LargeConsole1"
		Health = 10000000000000000000
		//var/Res=3000000
		Bolted = 1
		Grabbable = 0
		density = 1
		Click()
			usr<<"The Android Ship has [AndroidRes] remaining resources."
			if(src in range(1,usr))
				for(var/obj/items/I in src)
					I.loc = usr.loc
					view(6,usr) << "[usr] removes a [I] from [src]."
					alertAdmins("[key_name(usr)] removed a [I] from [src]</b>!")
//					hearers(6,usr) << 'pop.wav'
					break
		verb/Use()
			set src in range(1,usr)
			if(usr.Race == "Android")
				switch(input(usr, "Placing 10'000'000 resources into the mainframe will produce an Android Upgrade Component and the mothership will store 5'000'000. Are you sure you want to continue?") in list("No", "Yes"))
					if("Yes")
						for(var/obj/Resources/R in usr)
							if(R.Value >= 10000000)
								R.Value -= 10000000
								AndroidRes+=5000000
								var/obj/items/Android_Upgrade/AU = new
								AU.loc = usr.loc
								alertAdmins("[key_name(usr)] placed 10'000'000 resources into the [src] and it created a [AU].</b>!")
								view(6)<<"<font color=red> [usr] placed 10'000'000 resources into the [src] and it created a [AU]."
								usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] placed 10'000'000 resources into the [src] and it created a [AU]..\n")
								return
	Android_Build_Module
		icon = 'Technology64x64.dmi'
		icon_state = "LargeConsole2"
		Health = 10000000000000000000
		//var/Res=3000000
		Bolted = 1
		Grabbable = 0
		density = 1
		verb/Use()
			var/DroidNumber = rand(1,1000)
			set src in range(1,usr)
			if(usr.Race == "Android"|| usr.Rank== "Mainframe")
				switch(input(usr, "Placing 10'000'000 resources into the mainframe will produce an Android and the mothership will store 5'000'000. Are you sure you want to continue?") in list("No", "Yes"))
					if("Yes")
						for(var/obj/Resources/R in usr)
							if(R.Value >= 10000000)
								R.Value -= 10000000
								AndroidRes+=5000000
								var/obj/items/Android_Chassis/AC = new
								AC.name = "Android - [DroidNumber]"
								AC.loc = locate(146,466,9)
								alertAdmins("[key_name(usr)] placed 10'000'000 resources into the [src] and it created an [AC].</b>!")
								view(6)<<"<font color=red> [usr] placed 10'000'000 resources into the [src] and it created a [AC]."
								usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] placed 10'000'000 resources into the [src] and it created a [AC]..\n")
								return
	Weights
		icon='Clothes_ShortSleeveShirt.dmi'

		Savable=0
		Flammable = 1
		var/Weight=1
		New()
			name="[round(Weight)]lb Weights"

		Click() if(locate(src) in usr)
			var/CurrentWeight=0
			var/Weights=0
			if(suffix)
				suffix=null
				usr.overlays-=icon
				view(20,usr) << "[usr] takes off the [src]."
				usr<<"You take off the [src]. Your max lift is [Commas(round((usr.BaseStr+usr.BaseEnd)*2))] pounds"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes the [src].\n")
				return
			for(var/obj/items/Weights/A in usr) if(A.suffix)
				CurrentWeight+=A.Weight
				Weights++
			if(!suffix&&Weights>=3)
				usr<<"You cannot wear more than 3 of these at once"
				return
			if(!suffix&&(CurrentWeight+Weight)>((usr.BaseStr+usr.BaseEnd)*2))
				usr<<"Putting this on would exceed your maximum lift of [Commas(round((usr.BaseStr+usr.BaseEnd)*2))] pounds. You cannot use it."
				return
			if(!suffix)
				suffix="*Equipped*"
				usr.overlays+=icon
				view(20,usr) << "[usr] puts on the [src]."
				usr<<"You put on the [src]. Your max lift is [Commas(round((usr.BaseStr+usr.BaseEnd)*2))] pounds"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] puts on the [src].\n")
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
	Regenerator
		Grabbable = 1
		Savable=1
		desc="Stepping into this will accelerate your healing rate. It heals faster the more upgraded \
		it is. It will break in the strain of high gravity."
		icon = 'New regen tank.dmi'
		layer=MOB_LAYER+1
		New()
			..()
			src.pixel_x = -32
			src.pixel_y = -16
			spawn if(src) Regenerator_Loop()
		proc/Regenerator_Loop()
			set waitfor=0
			while(src)
				if(z) if(icon_state!="ez")
					if(z==0&&isnull(loc)) del(src)
					for(var/turf/A in range(0,src)) if(A.Gravity>25)if(prob(50))
						icon_state="middlebroke"
						view(src)<<"The [src] is crushed by the force of the gravity!"
						del(src)
					for(var/mob/A in range(0,src))
						if(A.Willpower<=0) if(!A.LethalCombatTracker) A.WillpowerRestore()
						if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower+=0.05
						if(A.LethalCombatTracker) A.LethalCombatTracker--
						if(A.Health<A.MaxHealth)
							A.Health+= 0.3*Level*A.Regeneration
							if(A.KOd&&A.Health>=A.MaxHealth) A.Un_KO()
						for(var/BodyPart/P in A) if(P.Health<P.MaxHealth)
							A.Injure_Heal(Level*0.01*A.Regeneration,P)
							if(prob(Level*0.02)) P.InjuryHealed(A)
						if(A.Willpower>A.MaxWillpower) A.Willpower=A.MaxWillpower
						if(A.Health>A.Willpower) A.Health=A.Willpower
						for(var/Skill/Support/Send_Energy/SE in A) SE.Active=0
						break
					for(var/obj/items/Regenerator/R in range(0,src)) if(R!=src)
						view(src)<<"You hear glass begin to crack..."
						sleep(1)
						del(src)
				sleep(60)
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

				return
		verb/Upgrade()
			set src in view(1)
			if(usr.Int_Level<Tech)
				usr<<"This is too advanced for you to mess with."
				return
			var/obj/Resources/A
			for(var/obj/Resources/B in usr) A=B
			var/Cost=20000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
			var/Max_Upgrade=(A.Value/Cost)+Tech
			if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
			if(usr.Int_Level>80&&!CapsuleTech) if(usr.Confirm("Add capsule tech for [Cost*10]?"))
				if(Cost*10>A.Value)
					usr<<"You do not have enough resources to add capsule tech."
					return
				A.Value-=Cost*10
				src.cost += Cost*10
				CapsuleTech=1
				usr<<"Capsule Tech added! You may now add this item to your inventory!"
				return
			var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
			if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
			if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
			if(Upgrade<1) Upgrade=1
			Upgrade=round(Upgrade)
			if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
				if("No") return
			Cost*=Upgrade-Tech
			if(Cost<0) Cost=0
			if(Cost>A.Value)
				usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
				return
			view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
			for(var/mob/player/M in view(src))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades [src] to level [Upgrade].\n")
			A.Value-=Cost
			src.cost += Cost
			Tech=Upgrade
			icon_state="middle"
			Level=0.1*Upgrade*0.01*rand(50,200)
			desc="Level [Tech] [src]"




obj/var/Special_Ball = 0
obj/items
	Crystal_Ball
		icon='Magic Items.dmi'
		icon_state = "crystal ball"
		Health=100

		New()
			desc="<br>Clicking this will let you observe people....for a time...for a cost.."

		Click()
			if(src in usr.client.screen)
				for(var/mob/player/M in Players) if(M.Observer==usr.key) M.Observer=null
				usr.client.screen.Remove(src)
				usr.client.eye=usr
				usr << "View returned to normal."
				return
		verb/Watch_Someone(var/obj/Contact/X in usr.Contacts)
			set src in view(1)
			if(src.Special_Ball)
				view(6,usr) << "[usr] activates their crystal ball..."
				var/list/P = list()
				for(var/mob/M in Players) if(M.z == 1|M.z==16|M.z==11&&M.y<=320)
					P += M
				var/mob/O=input(usr,"Choose someone to observe.") as mob in P
				usr << "You are now watching [O] through your crystal ball."
				usr.Get_Observe(O)
				src.screen_loc = "1,1"
				usr.client.screen.Add(src)
				return
			else if(usr.Magic_Level >= 55&&usr.Magic_Potential>=3)
				if(src.Health < 100000)
					usr << "The crystal ball must have at least 100,000 mana to work!"
					return
				if(src.Health >= 100000)
					var/mob/A = null
					for(var/mob/M in Players)
						if(M.ckey == X.pkey)
							if(M.Race == "Android")
								usr << "Androids do not have an energy signature!"
								return
							if(X.familiarity >= 5)
								A = M
								break
							else
								usr << "You're not familiar enough with that energy signature to find it. (5 Familiarity)"
								return
							if(M.BP<1000)
								usr<<"You can't seem to find their energy. (BP too low)"
								return
							if(!RealmTeleport) if(M.z==8||z==11||z==10)
								usr<<"You can not see them."
								return
					if(A.HelmetOn<3)
						usr << "You are now watching [A] through your crystal ball."
						usr.Get_Observe(A)
						src.Health -= 100000
						desc="<br>Clicking this will let you observe people....for a time...for a cost..<br>[Commas(Health)] Durability Crystal Ball"
						src.screen_loc = "1,1"
						usr.client.screen.Add(src)
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] uses observe on [key_name(A)].\n")
			else
				usr << "You do not possess enough magic skill to use that item."
				return
		verb/Enhance()
			set src in oview(1)
			var/obj/Mana/A
			for(var/obj/Mana/B in usr) A=B
			var/Amount=round(input("Add how much mana to this crystal ball?") as num)
			if(Amount>A.Value) Amount=A.Value
			if(Amount<0) Amount=0
			A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
			Amount*=usr.Magic_Potential
			Health+=Amount
			desc="<br>Clicking this will let you observe people....for a time...for a cost..<br>[Commas(Health)] Durability Crystal Ball"
			view(usr)<<"[usr] adds +[Commas(Amount)] to the [src]"
			for(var/mob/player/M in view(usr))
				if(!M.client) return
				M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds +[Commas(Amount)] to the [src].\n")

	Boxing_Gloves
		icon='Boxing Gloves.dmi'
		Health=100

		Flammable = 1
		New()
			desc="<br>Equipping these make your hits a lot less powerful, good for sparring. This will increase the rate at which you gain Unarmed."

		Click()
			if(src in usr)
				for(var/obj/items/Boxing_Gloves/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a set of boxing gloves equipped."
					return
				if(!suffix)
					if(usr.Lethality)
						usr<<"You shouldn't use these in lethal combat."
						return
					suffix="*Equipped*"
					var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays += _overlay
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					winset(usr.client,"GLOVES","is-visible=true")
					return
				else
					suffix=null
					winset(usr.client,"GLOVES","is-visible=false")
					var/image/_overlay = image(icon) // not sure if the equipped thing is an icon/object so
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays -= _overlay
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

	Helmet
		Basic_Helmet
			desc="This will make it so people can not reach you with telepathy."
			HelmetLevel=1
		Copper_Helmet
			desc="This will make it so people can not reach you with telepathy."
			HelmetLevel=2
		Iron_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars."
			HelmetLevel=3
			New()
				..()
				icon+=rgb(30,10,0)
		Mythril_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars and you can not be observed and you can not be sensed."
			HelmetLevel=4
			icon='HelmetMask.dmi'
			New()
				..()
				icon-=rgb(30,10,0)
				icon+=rgb(0,0,10)
		Masterwork_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars and you can not be observed and you can not be sensed and your BP is hidden."
			HelmetLevel=5
			icon='BucketMask.dmi'

		Bronze_Helmet
			desc="This will make it so people can not reach you with telepathy and they can not see your status bars and you can not be observed."
			HelmetLevel=3
			icon='HelmetMask.dmi'



		icon='Iron_Helmet.dmi'
		Health=150000

		var/HelmetLevel=1
		Click()
			if(src in usr)
				/*for(var/obj/items/Helmet/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a helmet equipped."
					return*/
				/**/
				if(!suffix)
					if(usr.HelmetOn)
						usr<<"You already have a helmet equipped."
						return
					if(usr.ArmorOn||usr.PowerArmorOn)if(!usr.HasHeavyArmorTraining)
						usr<<"You can not wear armor and a helmet at the same time."
						return
					suffix="*Equipped*"
					usr.HelmetOn=HelmetLevel
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.HelmetOn)
						usr<<"You are not currently wearing a helmet."
						return
					suffix=null
					usr.HelmetOn=0
					usr.Equip_Magic(src,"Remove")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return




	var/MaxBPAdd=30
	var/CanCrit=0
	var/AvoidsCrits=0
	Sword
		var/Off=0.75
		icon='Sword_Trunks.dmi'
		Health=1000

		Savable = 1
		MaxBPAdd=60
		New()
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed +[MaxBPAdd]% your own BP, reduces your Offense to [Off*100]%."

		Click()


			if(src in usr)
				if(usr.Redoing_Stats) return
				for(var/obj/items/Sword/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a sword equipped."
					return
				for(var/Skill/Buff/Bound_Weapon/B in usr) if(B.Using)
					usr<<"You already have a weapon equipped."
					return
				if(Durability<=1)
					usr<<"[src] has 0 Durability. Repair it first."
					return
				if(!suffix)
					if(usr.SwordOn)
						usr<<"You are already wearing a sword."
						return
					if(usr.HammerOn)
						usr<<"You are already wearing a hammer."
						return
					if(usr.GlovesOn)
						usr<<"You are already wearing gauntlets."
						return
					usr.SwordOn=1+CanCrit
					if(usr.HasSwordsman) usr.OffMult*=(Off+0.08)
					else usr.OffMult*=Off
					suffix="*Equipped*"
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					//usr.StrMult*=1.1
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.SwordOn)
						usr<<"You are not currently wearing a sword."
						return
					suffix=null
					usr.SwordOn=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.1
					if(usr.HasSwordsman) usr.OffMult/=(Off+0.08)
					else usr.OffMult/=Off
					usr.Equip_Magic(src,"Remove")
					for(var/Skill/Buff/Armament/SF in usr) if(SF.Using) SF.use(usr)
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in view(1)
			var/R=input("Resources or Mana?") in list("Resources","Mana","Cancel")
			if(R=="Resources")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Int_Mod
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				src.EquipmentDescAssign()
			if(R=="Mana")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Magic_Potential
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				src.EquipmentDescAssign()
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
				view(usr)<<"[usr] repairs [src]."


			if(R=="Magic")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Cost=800000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
				if(!usr.Confirm("Repair [src] for [Cost] mana?")) return
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough mana to repair [src]"
					return
				A.Value-=Cost
				Durability=MaxDurability
				view(usr)<<"[usr] repairs [src]."

		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
		Normal_Sword
			MaxBPAdd=50
		Copper_Sword
			MaxBPAdd=65
		Iron_Sword
			MaxBPAdd=85
			Off=0.7
			Durability=150
			MaxDurability=150
		Bronze_Sword
			Off=0.8
			MaxBPAdd=60
			Durability=150
			MaxDurability=150
		Mythril_Sword
			MaxBPAdd=50
			Off=0.9
			Durability=200
			MaxDurability=200
		Masterwork_Sword
			MaxBPAdd=80
			Durability=250
			MaxDurability=250
		Practice_Sword
			icon='Great Oar.dmi'
			MaxBPAdd=1
			Durability=100
			MaxDurability=100
		Silver_Sword
			MaxBPAdd=60
			Off=0.8
			Durability=200
			MaxDurability=200
			CanCrit=1
		Auracite_Sword
			MaxBPAdd=65
			Off=0.8
			Durability=250
			MaxDurability=250
			CanCrit=2
	Magic_Mask
		icon='Ichigo.dmi'
		Health=1000

		Savable = 1
		New()
			desc="<br>+[Commas(Health)] BP to each ki attack. However this bonus cannot exceed +33% your own BP, additionally you lose 25% Offense. This only affects Force based Ki attacks."

		Click()
			if(src in usr)
				if(usr.Redoing_Stats) return
				for(var/obj/items/Magic_Mask/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a sword equipped."
					return
				if(Durability<=1)
					usr<<"[src] has 0 Durability. Repair it first."
					return
				if(!suffix)
					if(usr.MaskOn)
						usr<<"You are already wearing a mask."
						return
					usr.MaskOn=1
					//usr.OffMult*=0.75
					usr.OffMult*=0.75
					suffix="*Equipped*"
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					//usr.StrMult*=1.1
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.MaskOn)
						usr<<"You are not currently wearing a mask."
						return
					suffix=null
					usr.MaskOn=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.1
					usr.OffMult/=0.75
					usr.Equip_Magic(src,"Remove")
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in view(1)
			var/R=input("Resources or Mana?") in list("Resources","Mana","Cancel")
			if(R=="Resources")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Int_Mod
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				desc="<br>+[Commas(Health)] BP to each ki attack. However this bonus cannot exceed +33% your own BP, additionally you lose 25% Offense."
			if(R=="Mana")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Amount=round(input("Add how much BP to this sword's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Magic_Potential
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				desc="<br>+[Commas(Health)] BP to each ki attack. However this bonus cannot exceed +33% your own BP, additionally you lose 25% Offense."
		verb/Repair()
			set src in oview(1)
			var/R=input("Intelligence or Magic?") in list("Intelligence","Magic","Cancel")
			if(R=="Intelligence")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=cost/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
				if(!usr.Confirm("Repair [src] for [Cost] resources?")) return
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough resources to repair [src]"
					return
				A.Value-=Cost
				Durability=MaxDurability
				view(usr)<<"[usr] repairs [src]."


			if(R=="Magic")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Cost=800000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
				if(!usr.Confirm("Repair [src] for [Cost] mana?")) return
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough mana to repair [src]"
					return
				A.Value-=Cost
				Durability=MaxDurability
				view(usr)<<"[usr] repairs [src]."

		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

	Hammer
		icon='Sledgehammer.dmi'
		Health=1000

		Savable = 1
		MaxBPAdd=70
		var/Spd=0.85
		var/Off=0.75
		New()
			if(prob(50)) icon='Hammer.dmi'
		//	else if(prob(25)) icon='Great Oar.dmi'
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed +[MaxBPAdd]% your own BP. [Spd*100]% Speed and [Off*100]% Offense."

		Click()
			if(src in usr)
				if(usr.Redoing_Stats) return
				for(var/obj/items/Sword/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a sword equipped."
					return
				for(var/Skill/Buff/Bound_Weapon/B in usr) if(B.Using)
					usr<<"You already have a weapon equipped."
					return
				if(Durability<=1)
					usr<<"[src] has 0 Durability. Repair it first."
					return
				if(!suffix)
					if(usr.HammerOn)
						usr<<"You are already wearing a hammer."
						return
					if(usr.SwordOn)
						usr<<"You are already wearing a sword."
						return
					if(usr.GlovesOn)
						usr<<"You are already wearing gauntlets."
						return
					usr.HammerOn=1+CanCrit
					//usr.StrMult*=1.1
					if(usr.HasHammerTime) usr.SpdMult*=(Spd+0.06)
					else usr.SpdMult*=Spd
					if(usr.HasHammerTime) usr.OffMult*=(Off+0.06)
					else usr.OffMult*=Off
					suffix="*Equipped*"
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					//usr.StrMult*=1.1
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.HammerOn)
						usr<<"You are not currently wearing a hammer."
						return
					suffix=null
					usr.HammerOn=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.1
					if(usr.HasHammerTime) usr.SpdMult/=(Spd+0.06)
					else usr.SpdMult/=Spd
					if(usr.HasHammerTime) usr.OffMult/=(Off+0.06)
					else usr.OffMult/=Off
					usr.Equip_Magic(src,"Remove")
					for(var/Skill/Buff/Armament/SF in usr) if(SF.Using) SF.use(usr)
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in view(1)
			var/R=input("Resources or Mana?") in list("Resources","Mana","Cancel")
			if(R=="Resources")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Amount=round(input("Add how much BP to this hammer's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Int_Mod
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")

				src.EquipmentDescAssign()
			if(R=="Mana")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Amount=round(input("Add how much BP to this hammer's attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Magic_Potential
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				src.EquipmentDescAssign()
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
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
				view(usr)<<"[usr] repairs [src]."


			if(R=="Magic")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Cost=800000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
				if(!usr.Confirm("Repair [src] for [Cost] mana?")) return
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough mana to repair [src]"
					return
				A.Value-=Cost
				Durability=MaxDurability
				view(usr)<<"[usr] repairs [src]."


		Normal_Hammer
			MaxBPAdd=65
		Copper_Hammer
			MaxBPAdd=80
		Iron_Hammer
			MaxBPAdd=100
			Spd=0.8
			Durability=150
			MaxDurability=150
		Bronze_Hammer
			MaxBPAdd=70
			Off=0.8
			Durability=150
			MaxDurability=150
		Mythril_Hammer
			Off=0.8
			Spd=0.9
			MaxBPAdd=75
			Durability=200
			MaxDurability=200
		Masterwork_Hammer
			MaxBPAdd=100
			Durability=250
			MaxDurability=250
		Silver_Hammer
			MaxBPAdd=70
			Off=0.8
			Durability=200
			MaxDurability=200
			CanCrit=1
		Auracite_Hammer
			MaxBPAdd=75
			Off=0.8
			Durability=250
			MaxDurability=250
			CanCrit=2
	Digging
		var/DigMult=1
		var/ExtraDigMult=0
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

		Shovel
			icon='Shovel.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=5
			Flammable = 1
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Equips" : "Unqequips"] the [src]\n")
		Hand_Drill
			icon='Drill Hand 2.dmi'
			desc="This will help increase the speed at which you can dig up resources."
			DigMult=15
			New()
				name="Level [DigMult] Hand Drill (+[ExtraDigMult])"
				..()
			Click() if(src in usr)
				for(var/obj/items/Digging/A in usr) if(A!=src&&A.suffix)
					usr<<"You already have one equipped."
					return
				if(!suffix) suffix="*Equipped*"
				else suffix=null
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [suffix ? "Unequips" : "Equips"] the [src]\n")
			verb/Upgrade()
				set src in view(1)
				if(usr.Int_Level<DigMult)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=200000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
				var/Max_Upgrade=(A.Value/Cost)+DigMult
				if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
				if(DigMult>=Max_Upgrade)
					usr<<"It is already upgraded beyond what you can manage."
					return
				var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence (Max Upgrade cannot exceed intelligence), and how much resources you have. So if the maximum is less than your int skill then it is instead due to not having enough res to upgrade it higher than the said maximum.") as num
				if(Upgrade>usr.Int_Level) Upgrade=usr.Int_Level
				if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
				if(Upgrade<1) Upgrade=1
				if(Upgrade<DigMult)
					usr<<"You must upgrade it to at least [DigMult+1]x."
				Upgrade=round(Upgrade)
				if(Upgrade<DigMult) return
				Cost*=Upgrade-DigMult
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
					return
				view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] upgrades the [src] to level [Upgrade]. \n")
				A.Value-=Cost
				DigMult=Upgrade
				name="Level [DigMult] Hand Drill (+[ExtraDigMult])"
				//desc="Level [DigMult] Hand Drill"
	Gauntlets
		icon='Clothes_Gloves.dmi'
		Health=1000

		Savable = 1
		MaxBPAdd=15
		var/Firearm=0
		New()
			desc="<br>+[Commas(Health)] BP to each melee attack. However this bonus cannot exceed +[MaxBPAdd]% your own BP. Can be enchanted to enhance your power."

		Click()
			if(src in usr)
				if(usr.Redoing_Stats) return
				for(var/obj/items/Sword/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a sword equipped."
					return
				for(var/Skill/Buff/Bound_Weapon/B in usr) if(B.Using)
					usr<<"You already have a weapon equipped."
					return
				if(Durability<=1)
					usr<<"[src] has 0 Durability. Repair it first."
					return
				if(!suffix)
					if(usr.HammerOn)
						usr<<"You are already wearing a hammer."
						return
					if(usr.SwordOn)
						usr<<"You are already wearing a sword."
						return
					if(usr.GlovesOn)
						usr<<"You are already wearing gauntlets."
						return
					usr.GlovesOn=1+CanCrit
					//usr.StrMult*=1.2
					suffix="*Equipped*"
					usr.Equip_Magic(src,"Add")
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					if(!usr.GlovesOn)
						usr<<"You are not currently wearing a sword."
						return
					suffix=null
					usr.GlovesOn=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					//usr.StrMult/=1.2
					usr.Equip_Magic(src,"Remove")
					for(var/mob/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return
		verb/Upgrade()
			set src in view(1)
			var/list/Cs=list("Resources","Mana","Cancel")
			//if(usr.Int_Level>=70&&usr.Int_Mod>=3&&!Firearm) Cs+="Add Firearm Attachment"
			var/R=input("Resources or Mana?") in Cs
			/*if(R=="Add Firearm Attachment")
				if(usr.Confirm("Would you like to add a firearm attachment to [src]? It will empower your Blast and Charge by causing them to use the higher of your strength or force stat and will decrease the drain by 50% but requires the NRA Membership MP for these benefits."))
					if(GCost>A.Value)
						usr<<"You do not have enough resources to upgrade it to level [Upgrade]"
						return
					A.Value-=Cost
					cost += GCost
					Firearm=1*/

			if(R=="Resources")
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Amount=round(input("Add how much BP to [src]'s attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Int_Mod
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")

				src.EquipmentDescAssign()
			if(R=="Mana")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Amount=round(input("Add how much BP to [src]'s attack power?") as num)
				if(Amount>A.Value) Amount=A.Value
				if(Amount<0) Amount=0
				A.Value-=Amount*(1-(0.15*usr.HasDeepPockets))
				src.cost += Amount
				Amount*=usr.Magic_Potential
				Health+=Amount
				view(usr)<<"[usr] adds [Commas(Amount)] to the [src]"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] adds [Commas(Amount)] to the [src]\n")
				src.EquipmentDescAssign()

		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
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
				view(usr)<<"[usr] repairs [src]."


			if(R=="Magic")
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Cost=800000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
				if(!usr.Confirm("Repair [src] for [Cost] mana?")) return
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough mana to repair [src]"
					return
				A.Value-=Cost
				Durability=MaxDurability
				view(usr)<<"[usr] repairs [src]."

		Normal_Gauntlets
			MaxBPAdd=10
		Copper_Gauntlets
			MaxBPAdd=15
		Bronze_Gauntlets
			MaxBPAdd=20
			Durability=150
			MaxDurability=150
		Iron_Gauntlets
			MaxBPAdd=23
			Durability=150
			MaxDurability=150
		Mythril_Gauntlets
			MaxBPAdd=26
			Durability=200
			MaxDurability=200
		Masterwork_Gauntlets
			MaxBPAdd=30
			Durability=250
			MaxDurability=250
		Silver_Gauntlets
			MaxBPAdd=22
			CanCrit=1
			Durability=200
			MaxDurability=200
		Auracite_Gauntlets
			MaxBPAdd=25
			CanCrit=2
			Durability=250
			MaxDurability=250


	Disguise
		icon='Shinji.dmi'
		Health=150000

		Click()
			if(src in usr)
				for(var/obj/items/Disguise/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a Disguise equipped."
					return
				/**/
				if(!suffix)
					suffix="*Equipped*"
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					if(usr.name==usr.real_name)
						usr.name="?"
						var/DD=rand(0,12)
						while(DD>0)
							usr.name="[usr.name]?"
							DD--
					return
				else
					suffix=null
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					if(usr.name!=usr.real_name)usr.name=usr.real_name
					return





	Utility_Belt
		desc="This will increase your maximum inventory space."
		Normal_Utility_Belt BeltLevel=4
		Copper_Utility_Belt BeltLevel=5
		Iron_Utility_Belt BeltLevel=6
		Mythril_Utility_Belt BeltLevel=7
		Masterwork_Utility_Belt BeltLevel=8
		icon='Clothes_Sash.dmi'
		Health=150000

		var/BeltLevel=3
		Click()
			if(src in usr)
				for(var/obj/items/Utility_Belt/A in usr) if(A!=src) if(A.suffix)
					usr<<"You already have a belt equipped."
					return
				if(!suffix)
					if(usr.HasBelt)usr.HasBelt=0
					suffix="*Equipped*"
					usr.HasBelt=BeltLevel
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays+=_overlay
					view(20,usr) << "[usr] puts on the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] equips [src]\n")
					return
				else
					/*(!usr.HasBelt)
						usr<<"You are not currently wearing a belt."
						return*/
					suffix=null
					usr.HasBelt=0
					var/image/_overlay = image(src.icon)
					_overlay.pixel_x = src.pixel_x
					_overlay.pixel_y = src.pixel_y
					_overlay.layer= src.layer
					usr.overlays-=_overlay
					view(20,usr) << "[usr] removes the [src]."
					usr.saveToLog("[key_name(usr)] ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] removes [src]\n")
					return

/*
obj/items/Gun
	Turret
		var/multitrack = 0 //Allows multiple targets.
		var/homing = 0 // Allows homing projectiles.
		var/lethal = 0 // Allows turret to KO or Kill.
		var/tmp/mob/target // For single-targeting.
		var/refire = 10 // Delay in ticks, between shots.
		Force = 500 // Damage Calculation purposes.
		var/activated = 0 // Allows turrets to be enabled or disabled.
		var/explosive = 0 // Allows explosive rounds.
		var/shockwave = 0 // Allows rounds with knockback.
		Damage_Percent = 20
		density=1
		Health=5000
		Deviation = 3
		Precision = 100000
		icon='Turret.dmi'
		New()
			..()
			Turret_AI()
obj/items/Gun/Turret
	verb
		Toggle_Power()
			set src in oview(1)
			for(var/obj/items/Door_Pass/O in usr.contents)
				if(O.Password == src.Password)
					if(src.activated)
						src.activated = 0
						usr << "Turret deactivated."
					else
						src.activated = 1
						usr << "WARNING: Turret activated."

		Set_Password()
			set src in oview(1)
			if(!src.Password)
				src.Password = input(usr,"Please specify the password for the turret.","Password") as text
				usr << "Password set."
			else
				for(var/obj/items/Door_Pass/O in usr.contents)
					if(O.Password == src.Password)
						src.Password = input(usr,"Please specify the password for the turret.","Password") as text
						usr << "Password changed."

	proc
		Turret_AI()
			set background = 1
			while(src)
				if(src.activated)
					var/tmp/list/friendlies = new
					for(var/mob/M in range(5+(src.Level/10),src))

						for(var/obj/items/Door_Pass/O in M.contents)
							if(O.Password == src.Password)
								if(!friendlies.Find(M))
									friendlies += M

						if(!friendlies.Find(M))
							src.dir = get_dir(src,M)
							if(src.multitrack)
								spawn()
									src.LockOn(M)
							else
								if(!src.target)
									src.target = M
									spawn()
										src.LockOn()
				sleep(10)


		LockOn(mob/M)
			if(src.activated)
				if(src.multitrack)
					spawn()
						while (M in range(5+(src.Level/10),src))
							if(lethal)
								if(homing)
									src.HS(M)
									sleep(refire)
								else
									src.SS(get_dir(src,M))
									sleep(refire)
							else
								if(M.KOd==0)
									if(homing)
										src.HS(M)
										sleep(refire)
									else
										src.dir = get_dir(src,M)
										src.SS()
										sleep(refire)
				else
					if(src.target)
						spawn()
							while(src.target in range(5+(src.Level/10),src))
								if(lethal)
									if(homing)
										src.HS(src.target)
										sleep(refire)
									else
										src.SS(get_dir(src,src.target))
										sleep(refire)
								else
									if(M.KOd==0)
										if(homing)
											src.HS(src.target)
											sleep(refire)
										else
											src.dir = get_dir(src,src.target)
											src.SS()
											sleep(refire)
									else
										src.target = null
							if(!src.target in range(5+(src.Level/10),src))
								src.target = null



		HS(mob/M)
			var/obj/ranged/Blast/A=new
			A.density=0
			A.Belongs_To=src
			A.icon='1.dmi'
			A.loc=get_step(src,turn(src.dir,pick(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)))
			if(src.explosive)
				A.Explosive=1
			if(src.shockwave)
				A.Shockwave=1
			var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**4)
			var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**4)
			A.Damage=Damage_Formula
			A.Power=Power_Formula
			A.Offense=src.Precision
			if(A) A.dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
			spawn while(prob(90))
				if(prob(80)) if(A) step(A,A.dir)
				else step_rand(A)
			spawn(rand(90,110)/2) if(A)
				A.density=1
				if(M) walk_towards(A,M)
		SS()
			var/obj/ranged/Blast/A=new
			A.Belongs_To=src
			A.pixel_x=rand(-Deviation,Deviation)
			A.pixel_y=rand(-Deviation,Deviation)
			A.icon='1.dmi'
			var/Damage_Formula=0.1*Damage_Percent*Battle_Power*Force*(Tech**4)
			var/Power_Formula=0.1*Damage_Percent*Battle_Power*(Tech**4)
			A.Damage=Damage_Formula
			A.Power=Power_Formula
			A.Offense=src.Precision
			A.Shockwave=src.explosive
			A.Explosive=src.shockwave
			A.dir=usr.dir
			A.loc=usr.loc
			walk(A,A.dir,Velocity)


obj/items/Gun/Turret
	New()
		..()
		Turret_AI()


*/


obj/items/Bookcase
	icon='Lab.dmi'
	icon_state="Books"
	Flammable = 1
	New()
		var/image/A=image(icon='Lab.dmi',icon_state="BooksTop",layer=layer,pixel_y=32,pixel_x=0)
		overlays.Add(A)
	Health=1000

	Grabbable=1
	density=1
	layer=4
	desc="It's a book-case.  This will boost intelligence and magic gains by 10% for those within 1 tile."

obj/items/Medicine_Cabinet
	icon='Lab.dmi'
	icon_state="Cabnit"
	New()
		var/image/A=image(icon='Lab.dmi',icon_state="CabnitTop",layer=layer,pixel_y=32,pixel_x=0)
		overlays.Add(A)
	Health=1000
	Grabbable=1

	Flammable = 1
	density=1
	layer=4
	desc="This will increase the Regeneration rate of those within 1 tile."
