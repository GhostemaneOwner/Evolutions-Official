
mob/var
	RainbowCookie=0
	NewYearsGift=0

obj/items
	var/Frequency = 1
	var/detections
	var/saved_data
	Security_Camera
		desc="This is a Security Camera. A frequency can be set, along with a password. Can be observed using a Security Monitor."
		layer=MOB_LAYER+10
		Health=100000
		icon='tech security systems.dmi'
		icon_state="camera"
		//var/display = 1
		Frequency=100
		Savable = 1
		Click()
			if(usr.client.eye==src)
				usr.reset_view()
				return
			/*if(src.Bolted)
				for(var/obj/items/Scanner/B in usr)
					if(B.Frequency&&B.Frequency==src.Frequency&&B.suffix)
						switch(input(usr, "Do you want to snap your view to this camera or toggle the display on the contacts it has saved?") in list("View Camera", "Toggle Contacts"))
							if("View Camera")
								usr.reset_view(src)
								usr << "Now viewing [src]. Click the camera to reset your view."
								return
							if("Toggle Contacts")
								if(src.display)
									src.display = 0
									usr << "Contacts for this camera have been toggled off."
									return
								else
									src.display = 1
									usr << "Contacts for this camera have been toggled on."
									return*/
		New()
			..()
			src.detections = list()
			spawn(10) if(src) src.Sweep()
		proc/Sweep()
			set waitfor=0
			if(src.z)if(src.Bolted)
				for(var/mob/M in view(20,src))
					var/Logged = 0
					for(var/obj/items/A in M)
						if(A.Password==src.Frequency) Logged = 1
						if(A.Frequency==src.Frequency) Logged = 1
					for(var/obj/Contact/O in src.detections)
						if(O.Signature == M.Signature) Logged = 1
					if(Logged == 0)
						var/obj/Contact/X = new
						X.suffix = null
						X.Signature = M.Signature
						X.name = "Intruder Detected [YearOutput()]"
						if(M.icon)
							X.appearance=M.appearance
						src.detections += X
			sleep(150)
			if(src) src.Sweep()
		verb/Review_Stored_Footage()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.Password)
				winclone(usr, "GenericSheet", "StoredFootage")
				winshow(usr.client,"StoredFootage",1)
				winset(usr.client,"StoredFootage.Grid","cells=0x0;title=\"Stored Footage\"")
				var/Row=0
				for(var/obj/Contact/S in src.detections)
					Row++
					usr << output(S, "StoredFootage.Grid:1,[Row]")
			else
				usr << "Wrong password."

		verb/Set_Password()
			set src in oview(1)
			if(!Password)
				Password=input("Choose a password for this device.") as text
				usr << "Password set."
				return
			else
				usr << "This device already has a password set."
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
		verb/Frequency()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.Password)
				Frequency=input("Choose a frequency. It can be text and/or numbers. When someone is detected near the Security Camera it will send a notification to this frequency alerting those on the channel that someone is near by.") as text
				usr << "Frequency set for [Frequency]."
				return
			else
				usr << "Wrong password."
				return
	Motion_Detector
		desc="This is a Motion Detector. A frequency can be set, along with a password. When someone is detected near this device, a message is sent to the frequency alerting those on the frequency channel about the intruder. It is able to detect cloaked people also, since the laser motion trackers are disturbed when the light is bent around the cloaker."
		layer=MOB_LAYER+10

		icon='tech security systems.dmi'
		icon_state="motion tracker"
		density=1
		Savable = 1
		var/Max=1
		Frequency=100
		var/cd = 0
		New()
			spawn(10) if(src) src.Scan()
		proc/Scan()
			if(src.z)
				for(var/mob/player/M in view(15,src)) if(!M.afk)
					var/Check=1
					for(var/obj/items/A in M)
						if(A.Password==src.Frequency) Check=0
						if(A.Frequency==src.Frequency) Check=0
					if(Check) for(var/mob/player/A in Players)
						for(var/obj/items/Scanner/B in A)
							if(B.Frequency) if(B.Frequency==src.Frequency) if(M != A)
								A<<"<font color=#FFFFFF>(Scanner Channel [src.Frequency])<font color=[A.TextColor]>[src] says, 'Warning! Intruder detected at [M.x],[M.y],[M.z]!' [YearOutput()]"
								A.saveToLog("|  | ([src.x], [src.y], [src.z]) | [key_name(A)] SCANNER: Warning! Intruder detected at [M.x],[M.y],[M.z]!\n")
						for(var/obj/items/Communicator/B in A)
							if(B.Frequency) if(B.Frequency==src.Frequency) if(M != A)
								A<<"<font color=#FFFFFF>(Scanner Channel [src.Frequency])<font color=[A.TextColor]>[src] says, 'Warning! Intruder detected at [M.x],[M.y],[M.z]!' [YearOutput()]"
								A.saveToLog("|  | ([src.x], [src.y], [src.z]) | [key_name(A)] SCANNER: Warning! Intruder detected at [M.x],[M.y],[M.z]!\n")
					break//src.cd = 30
			spawn(450) if(src) src.Scan()
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
		verb/Set_Password()
			set src in oview(1)
			if(!Password)
				Password=input("Choose a password for this device.") as text
				usr << "Password set."
				return
			else
				usr << "This device already has a password set."
				return
		verb/Frequency()
			set src in oview(1)
			var/p=input("Input password.") as text
			if(p == src.Password)
				Frequency=input("Choose a frequency. It can be text and/or numbers. When someone is detected near the Motion Tracker it will send a notification to this frequency alerting those on the channel that someone is near by.") as text
				usr << "Frequency set for [Frequency]."
				return
			else
				usr << "Wrong password."
				return
	Communicator
		icon='Cell Phone.dmi'
		desc="Use this to communicate with anyone else that has a scouter or communicator on the same frequency.  It will also speak out of any cameras on the same frequency."

		New()
			src.detections = list()
			src.Frequency = "[rand(1,1000)]"
		verb/Transmit(msg as text)
			var/AL=0
			if(usr.z in list(8,11,10,17,16)) AL=1
			for(var/mob/player/A in Players) if(!A.afk)
				var/TAL=0
				if(A.z in list(8,11,10,17,16)) TAL=1
				if(TAL==AL)
					for(var/obj/items/Scanner/B in A)
						if(B.suffix&&B.Frequency==Frequency)
							A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]'")
							A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
					for(var/obj/items/Communicator/B in A)
						if(B.Frequency==Frequency)
							A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]'")
							A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
			for(var/mob/player/C in view(10,usr.loc)) if(!C.afk)
				C.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: [usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,C)]</span>")
			for(var/obj/items/Security_Camera/Ca in world) if(Ca.Frequency==Frequency)
				var/TAL=0
				if(Ca.z in list(6,18,19)) TAL=1
				if(TAL==AL)
					for(var/mob/player/CC in view(10,Ca)) CC.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: <b>\[[usr.lan]\]</b>[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,CC)]</span>")
		verb/Frequency()
			Frequency=input("Choose a frequency, it can be anything. It lets you talk to others on the same frequency. Default is 1") as text
			if(Frequency == "Communication Matrix") //if(usr.AS_Droid == 0)
				usr << "This Frequency seems to be entirely blocking off your access."
				Frequency = "1"

	Locator
		icon='Cell Phone.dmi'
		desc="Use this to detect where your drills or pylons are located."
		verb/Locate()
			if(usr.CanPing)
				usr.CanPing=0
				spawn(100) usr.CanPing=1
				for(var/obj/Mana_Pylon/MP) if(MP.Builder=="[ckey(usr.key)]") usr<<"Pylon located at: [MP.x], [MP.y], [MP.z]"
				for(var/obj/Drill/MP) if(MP.Builder=="[ckey(usr.key)]") usr<<"Drill located at: [MP.x], [MP.y], [MP.z]"
			else usr<<"You must wait."

	Translator
		icon='Cell Phone.dmi'
		desc="Having this in your inventory will cause your speech to be fully understandable by anyone who is listening."

	Christmas_Gift
		icon='GiftBox.dmi'
		desc="This is a mysterious gift that materialized in to your possession."
		verb/Unwrap()
			set src in usr
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] opens a [src].\n")
			view(usr)<<"[usr] opens a [src]!"
			usr.contents+=new/obj/items/Rainbow_Sprinkle_Cookie
			usr.contents+=new/obj/items/Cookie
			del(src)


	Rainbow_Sprinkle_Cookie
		icon='Rainbow_Cookie.dmi'
		desc="This is a delicious looking cookie. You feel as though eating it would brighten your day."
		verb/Eat()
			set src in usr
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
			view(usr)<<"[usr] eats a [src]!"
			if(!usr.RainbowCookie)
				usr.XP+=XPRate*10 //10 hours of XP award
				usr.RainbowCookie=1
				usr<<"You gained some XP!"
			else logAndAlertAdmins("[key_name(usr)] has seemingly tried to abuse the christmas gift. BAN THE SCROOGE!.", 1)
			del(src)

	Cookie
		icon='Cookie.dmi'
		desc="This is a delicious looking cookie. You feel as though eating it would give you quite the energy rush."
		verb/Eat()
			set src in usr
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] eats a [src].\n")
			view(usr)<<"[usr] eats a [src]!"
			usr.RestedTime=world.realtime+280000
			usr<<"You feel well rested and full of energy!"
			del(src)

	gifts
		New_Years_Gift
			icon='GiftBox.dmi'
			desc="This is a mysterious gift that materialized in to your possession."
			verb/Unwrap()
				set src in usr
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] opens a [src].\n")
				view(usr)<<"[usr] opens a [src]!"
				usr.contents+=new/obj/items/gifts/Firework
				del(src)
		Firework
			icon='Firework.dmi'
			desc="This is a mysterious firework that came from an unknown person. It says 'Best Enjoyed With Friends' on it."
			verb/Fire()
				set src in usr
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] fires off a [src].\n")
				view(usr)<<"[usr] fires off a [src]!"
				if(!usr.NewYearsGift)
					usr.XP+=XPRate*10 //6 hours of XP award
					usr.NewYearsGift=1
					usr<<"You gained some XP!"
				for(var/mob/player/P in view(usr))
					P<<"The firework explodes in the sky and gives you a feeling of awe and excitement. (Inspired)"
					P.InspiredTime=world.realtime+200000
				ExplosionEffect(usr)
					//else logAndAlertAdmins("[key_name(usr)] has seemingly tried to abuse the new years gift.", 1)
				del(src)


	Stone_Of_Understanding
		icon='enchantmenticons.dmi'
		icon_state="ArcanEar"
		desc="Having this in your inventory will cause you to understand all speech nearby."

	Magic_Scanner
		icon='Kensei.dmi'
		var/Scan=1
		var/Range=5
		layer=6
		//var/Detects
		//var/CanDetect

		desc="Equipping this will open a tab that allows you to see the battle power of all people within the scanner's range and detection capabilities."
		Click()
			if(locate(src) in usr)
				for(var/obj/items/Magic_Scanner/X in usr) if(X!=src) if(X.suffix) return
				for(var/obj/items/Scanner/X in usr) if(X!=src) if(X.suffix) return
				if(!suffix)
					usr<<"You put on the [src]."
					var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays += _overlay
					suffix="*Equipped*"
					usr.ScouterOn=Scan
				else
					usr<<"You take off the [src]."
					var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays -= _overlay
					suffix=null
					usr.ScouterOn=0
		verb
			Upgrade()
				set src in view(1)
				if(usr.Magic_Level<Tech)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Mana/A
				for(var/obj/Mana/B in usr) A=B
				var/Cost=20000/usr.Magic_Potential*(1-(0.15*usr.HasDeepPockets))
				var/Max_Upgrade=(A.Value/Cost)+Tech
				if(Max_Upgrade>usr.Magic_Level) Max_Upgrade=usr.Magic_Level
				var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your magic (Max Upgrade cannot exceed Magic), and how much mana you have. So if the maximum is less than your magic then it is instead due to not having enough mana to upgrade it higher than the said maximum. Max Scan BP is based upon the Magic Mod of the person who upgrades it.") as num
				if(Upgrade>usr.Magic_Level) Upgrade=usr.Magic_Level
				if(Upgrade>Max_Upgrade) Upgrade=Max_Upgrade
				if(Upgrade<1) Upgrade=1
				Upgrade=round(Upgrade)
				if(Upgrade<Tech) switch(input("You wish to bring this Level [Tech] [src] to Level [Upgrade]?") in list("Yes","No"))
					if("No") return
				Cost*=Upgrade-Tech
				if(Cost<0) Cost=0
				if(Cost>A.Value)
					usr<<"You do not have enough mana to upgrade it to level [Upgrade]"
					return
				view(src)<<"[usr] upgrades the [src] to level [Upgrade]"
				A.Value-=Cost
				Tech=Upgrade
				if(Scan<(1.75*Upgrade)**(usr.Magic_Potential*0.85)) Scan=(1.75*Upgrade)**(usr.Magic_Potential*0.85)
				if(Scan<50*Upgrade) Scan=50*Upgrade
				Range=5*Upgrade
				desc="Level [Tech] [src] ([Commas(Scan)] BP)"

	Scanner
		icon='Scouter-Color.dmi'
		var/Scan=1
		var/Range=5
		var/Detects
		var/CanDetect
		var/Implant = 0
		desc="Equipping this will open a tab that allows you to see the battle power of all people within the scanner's range and detection capabilities. You can also use this to communicate with anyone else that has a scouter or communicator on the same frequency.  It will also speak out of any cameras on the same frequency."
		New()
			src.detections = list()
			src.Frequency = "[rand(1,1000)]"
		//	Scan=0.001*rand(450,710)
		Click()
			if(src.Implant)
				usr << "You can't remove that, it's part of you!"
				return
			if(locate(src) in usr)
				for(var/obj/items/Scanner/X in usr) if(X!=src) if(X.suffix) return
				for(var/obj/items/Magic_Scanner/X in usr) if(X!=src) if(X.suffix) return
				if(!suffix)
					usr<<"You put on the [src]."
					var/image/_overlay = image(icon) // In order to get pixel offsets to stick to overlays we create an image
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays += _overlay
					suffix="*Equipped*"
					usr.ScouterOn=Scan
				else
					usr<<"You take off the [src]."
					var/image/_overlay = image(icon) // not sure if the equipped thing is an icon/object so
					_overlay.pixel_x = pixel_x
					_overlay.pixel_y = pixel_y
					_overlay.layer= layer
					usr.overlays -= _overlay
					suffix=null
					usr.ScouterOn=0
		verb/Destroy()
			set category=null
			if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src

		verb
			Transmit(msg as text)
				var/AL=0
				if(usr.z in list(8,10,11,16,17)) AL=1
				for(var/mob/player/A in Players)if(!A.afk)
					var/TAL=0
					if(A.z in list(8,10,11,16,17)) TAL=1
					if(TAL==AL)
						for(var/obj/items/Scanner/B in A)
							if(B.suffix&&B.Frequency==Frequency)
								A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]''")
								A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
						for(var/obj/items/Communicator/B in A)
							if(B.Frequency==Frequency)
								A.ICOut("<font color=#FFFFFF>(Scanner Channel [Frequency])<font color=[usr.TextColor]>[usr] says, <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,A)]'")
								A.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] SCANNER: [msg]\n")
				for(var/mob/player/C in view(10,usr.loc))if(!C.afk)
					C.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: [usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,C)]</span>")
				for(var/obj/items/Security_Camera/Ca in world) if(Ca.Frequency==Frequency)
					var/TAL=0
					if(Ca.z in list(8,10,11,16,17)) TAL=1
					if(TAL==AL)
						for(var/mob/player/CC in view(10,Ca)) CC.ICOut("<span class=\"say\"><font size=2 color=[usr.TextColor]> <b>[usr.name]</b>: <b>\[[usr.lan]\]</b>'[usr.LanguageSay(msg,usr.lan,usr.lan.Mastery,CC)]'</span>")
			Frequency()
				Frequency=input("Choose a frequency, it can be anything. It lets you talk to \
								others on the same frequency. Default is 1") as text
				if(Frequency == "Communication Matrix") //if(usr.AS_Droid == 0)
					usr << "This Frequency seems to be entirely blocking off your access."
					Frequency = "1"

			Detect()
				if(!CanDetect)
					usr<<"This feature is not installed. It can only be installed by a very intelligent person."
					return
				if(Detects) switch(input("Are you sure you want to reset detecting?") in list("No","Yes"))
					if("Yes") Detects=null
					if("No") return
				var/list/A=new
				for(var/obj/B in oview(1,usr)) A+=B
				if(!A)
					usr<<"You are not near an object to set the scanner to."
					return
				A+="Cancel"
				var/obj/B=input("Set to detect what type of object?") in A
				if(B=="Cancel") return
				Detects=B.type
				usr<<"Set to detect [B]"

			Upgrade()
				set src in view(1)
				if(usr.Int_Level<Tech)
					usr<<"This is too advanced for you to mess with."
					return
				var/obj/Resources/A
				for(var/obj/Resources/B in usr) A=B
				var/Cost=20000/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets))
				var/Max_Upgrade=(A.Value/Cost)+Tech
				if(Max_Upgrade>usr.Int_Level) Max_Upgrade=usr.Int_Level
				var/Upgrade=input("Upgrade it to what level? (1-[round(Max_Upgrade)]). The maximum amount you can upgrade is determined by your intelligence and int mod (Max Upgrade cannot exceed Intelligence), and how much resources you have. So if the maximum is less than your intelligence then it is instead due to not having enough resources to upgrade it higher than the said maximum.") as num
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
				A.Value-=Cost
				Tech=Upgrade
				if((2*Upgrade)**(usr.Int_Mod*0.8)>Scan) Scan=(2*Upgrade)**(usr.Int_Mod*0.8)
				if(Scan<50*Upgrade) Scan=50*Upgrade
				Range=5*Upgrade
				if(Upgrade>=60) CanDetect=1
				desc="Level [Tech] [src] ([Commas(Scan)] BP)"
				