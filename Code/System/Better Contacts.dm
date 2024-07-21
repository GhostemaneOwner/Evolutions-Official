

Skill/Support/Counterpart
	Experience=100
	desc="This is something only Namekians can do. It forms a Piccolo and Kami type relationship \
	with you and one other person. The effect is permanent and irreversible. If one of you die both \
	die. The counterpart with the lowest training experience will match the other counterpart's \
	training experience at all times. You can only have one counterpart."
	verb/Set_Counterpart(mob/A in oview(1))
		set category="Other"
		set src=usr.contents
		if(!A.client) return
		if(A.Race!=usr.Race)
			usr<<"They arent the same race as you"
			return
		if(A.Counterpart)
			usr<<"They already have a counterpart"
			return
		switch(input(A,"[usr] wants to be your counterpart. Do you want this?") in list("No","Yes"))
			if("Yes")
				view(A)<<"[A] accepts [usr] as their counterpart"
				A.Counterpart="[usr]([usr.key])"
				usr.Counterpart="[A]([A.key])"
				for(var/Skill/Support/Counterpart/B in A) del(B)
				del(src)

obj/Contact
	var/familiarity=0
	var/pkey // short for player key
	var/relation="Neutral"
	var/Signature = 0
	var/positiverelation=0
	var/Notes="None"
	suffix="0 / Neutral"
	verb/Change_Notes()
		set src in world
		if(src in usr.Contacts) if(usr.Confirm("Change notes for [src]?")) Notes=input("Notes for [src]") as message

	Click()
		if(src in usr.Contacts)
			usr.AllOut(Notes)
			var/list/Choices=new
			if(usr.Rank) Choices+="Disciple(+)"
			Choices.Add("Family","Friend","Sibling","Rival","Neutral","Enemy","Hated","Mentor","Spouse","Child","Delete Contact")
			var/RC=input("Choose a relationship") in Choices
			if(RC=="Delete Contact")
				if(usr.Confirm("Delete [src] contact?")) del(src)
			else
				relation=RC
				//suffix="[round(familiarity)] / [relation]"
				if(relation!="Enemy"&&relation!="Hated"&&relation!="Neutral") positiverelation=1
				else positiverelation=0

mob/verb/Introduce_Self(mob/M in oview())
	if(!Confirm("Introduce yourself to [M]?")) return
	else M.MakeContact(usr,1)
	usr<<"You introduced yourself to [M]."
	M<<"[usr] introduced themselves."

mob/verb/Mass_Introduce_Self()
	set category="Other"
	if(!Confirm("Introduce yourself to everyone in sight?")) return
	for(var/mob/player/M in oview())if(!M.adminDensity)
		M.MakeContact(usr,1)
		if(!M.invisibility) usr<<"You introduced yourself to [M]."
		M<<"[usr] introduced themselves."

mob/proc/MakeContact(mob/M,fam=1)
	set background=1
	set waitfor=0
	var/disapproved=0
	if(M==src)
		disapproved=1
		return
	if(Signature == M.Signature)
		disapproved=1
		return
	for(var/obj/Contact/A in src.Contacts) if(A.Signature == M.Signature) disapproved=1 // if they already have this person as a contact, skip
	if(!disapproved)
		var/obj/Contact/C = new
		if(M.Race!="Android") C.name = "[M.name] - [M.Signature]"
		else C.name = "[M.name] - Not Found"
		C.pkey = "[M.ckey]"
		C.Signature = M.Signature
		C.familiarity=fam
		C.suffix="[round(C.familiarity,0.05)] / [C.relation]"
		C.Notes="You met [M.name] on [YearOutput()]."
		src.Contacts += C
		src<<"You have established a new contact with [M.name]! Make sure to set the proper relationship under the Contacts window."

obj/items/FriendshipBracelet
	icon='Bracelet.dmi'
	desc="This will increase the rate your contact points with the maker increase."
	verb/Destroy()
		set category=null
		if(!src.suffix) if(usr.Confirm("Delete [src]? (You will not be refunded)")) if(!src.suffix) if(src in usr) del src
obj/items/Philosophers_Stone
	icon='enchantmenticons.dmi'
	icon_state="PhiloStone"
	desc="This will increase your regeneration. (+0.5 Regeneration)"
obj/items/Ring_Of_Smithing
	icon='enchantmenticons.dmi'
	icon_state="RoS"
	desc="This will increase your Mining and Smithing skills. (+10 Mining, +10 Smithing)"
obj/items/Anglers_Lure
	icon='enchantmenticons.dmi' 
	icon_state="Witheroot"
	desc="This will increase your Fishing skill. (+15 Fishing)"
obj/items/How_To_Serve_Saiba
	icon='enchantmenticons.dmi'
	icon_state="BoFB"
	desc="This will increase your Cooking skill. (+15 Cooking)"
obj/items/Aspect_of_Flight
	icon='enchantmenticons.dmi'
	icon_state="ArcanOrb"//Yep
	desc="This tome increases your agility. (+3 Flee/Chase Rolls)"
obj/items/Orb_Of_Mastery //Fixed
	icon='enchantmenticons.dmi'
	icon_state="PhiloStone"
	desc="This will increase the rate at which you gain Ki Manipulation."
	New()
		icon-=rgb(100,0,0)
		..()
obj/items/Ninja_Scarf
	icon='Scarf White.dmi'
	desc="This will increase the rate at which you gain Evasion."
	Click()
		if(src in usr)
			if(!suffix)
				suffix="*Equipped*"
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays+=_overlay
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] puts on the [src].")
				return
			else
				suffix=null
				var/image/_overlay = image(src.icon)
				_overlay.pixel_x = src.pixel_x
				_overlay.pixel_y = src.pixel_y
				_overlay.layer = src.layer
				usr.overlays-=_overlay
				for(var/mob/player/P in view(20,usr)) P.ICOut("[usr] removes the [src].")
				return

mob/var/tmp/ContactsLoop=0
mob/proc/Contacts()
	set background=1
	set waitfor=0
	if(!ContactsLoop) while(src)
		ContactsLoop=1
		for(var/mob/player/M in oview(6,src))
			if(M.client)
				if(!M.afk) if(!src.afk)
					for(var/obj/Contact/A in src.Contacts) if(A.Signature == M.Signature) if(A.familiarity<25||A.positiverelation)
						A.familiarity+= 0.05
						if(src.Race=="Namekian")A.familiarity+= 0.1
						if(TicksOfMerriment)A.familiarity+= 0.1
						for(var/obj/items/FriendshipBracelet/FS in src) if(FS.Level==M.Signature) A.familiarity+= 0.05
						//A.suffix="[round(A.familiarity,0.05)] / [A.relation]"
						/*if(M.icon)
							A.icon=M.icon
							A.overlays+=M.overlays*/
						break
		sleep(600)


mob/proc/ContactsPurge()
	for(var/obj/Contact/A in src.Contacts)
		A.icon=null
		A.overlays=null

