


/*
mob/verb/Donate()
	set name = ".Donate"
	set hidden = 1
	usr << "https://www.paypal.me/RTPro"
	usr << link("https://www.paypal.me/RTPro")
*/
mob/proc/Colorizee(obj/O)
	if(O)
		switch(input("") in list("Add","Subtract","Multiply"))
			if("Multiply")
				if(O)
					var/icon/A=new(O.icon)
					var/B=input("Choose a color") as color|null
					if(B) A.MapColors(B,"#ffffff","#000000")
					if(A) O.icon=A
			if("Add") O.icon+=rgb(input("Red") as num,input("Green") as num,input("Blue") as num)
			if("Subtract") O.icon-=rgb(input("Red") as num,input("Green") as num,input("Blue") as num)

mob/var
	adjustedX=0
	adjustedY=0
mob/verb/AdjustXY()
	var/C=input("Adjust your own Pixel X/Y or an objects?") in list("Self","Object")
	if(C=="Self")
		pixel_x=input("Input your pixel x") as num
		if(pixel_x>128)pixel_x=128
		if(pixel_x<-128)pixel_x=-128
		adjustedX=pixel_x
		pixel_y=input("Input your pixel y") as num
		if(pixel_y>128)pixel_y=128
		if(pixel_y<-128)pixel_y=-128
		adjustedY=pixel_y
	else
		var/obj/O=input("Choose the object") as obj in view(usr)
		if(istype(O,/obj/items/Magic_Circle)) return
		if(istype(O,/obj/items/Phylactery)) return
		if(istype(O,/obj/Magic_Ball)) return
		if(istype(O,/obj/items/Cloning_Tank)) return
		if(istype(O,/obj/items/Bomb)) return
		if(istype(O,/obj/items/Senzu)) return
		if(istype(O,/BodyPart/)) return
		if(istype(O,/Language/)) return


		O.pixel_x=input("Input [O]s pixel x") as num
		if(O.pixel_x>128)O.pixel_x=128
		if(O.pixel_x<-128)O.pixel_x=-128
		O.pixel_y=input("Input [O]s pixel y") as num
		if(O.pixel_y>128)O.pixel_y=128
		if(O.pixel_y<-128)O.pixel_y=-128
		var/layP=input("Choose a layer for [O] 1-10 0 for default") as num
		if(layP) O.layer=layP
		if(O.layer>10) O.layer=10
		if(O.layer<1) O.layer=1


obj
	verb/Change_Object_Name(obj/O as obj in view(usr),ID as text)
		set category=null//"Other"
		set src=usr.contents
		if(!O||!ID) return
		if(istype(O,/Language/)) return
		if(istype(O,/obj/items/Magic_Circle)) return
		if(istype(O,/obj/items/Phylactery)) return
		if(istype(O,/obj/Magic_Ball)) return
		if(istype(O,/obj/items/Cloning_Tank)) return
		if(istype(O,/obj/items/Bomb)) return
		if(istype(O,/obj/items/Senzu)) return
		if(istype(O,/obj/items/Fruit)) return
		if(istype(O,/obj/items/Steroid_Injection)) return
		if(istype(O,/obj/items/Stun_Controls)) return
		if(istype(O,/obj/items/Magic_Vault)) return
		if(istype(O,/obj/items/Safe)) return
		if(istype(O,/obj/Stun_Chip)) return
		if(istype(O,/obj/items/Elixir_Of_Empowerment))return
		if(istype(O,/obj/items/Elixir_Of_Health))return
		if(istype(O,/obj/items/Elixir_Of_Life))return
		if(istype(O,/obj/items/Elixir_Of_Replenishment))return
		if(istype(O,/obj/items/Elixir_Of_Respec))return
		if(istype(O,/BodyPart/)) return
		if(istype(O,/Language/)) return
		if(istype(O,/Skill/)) return
		if(istype(O,/Language/)) return
		if(istype(O,/obj/items/Magic_Circle)) return
		if(istype(O,/obj/items/Phylactery)) return
		if(istype(O,/obj/Magic_Ball)) return
		if(istype(O,/obj/items/Cloning_Tank)) return
		if(istype(O,/obj/items/Bomb)) return
		if(istype(O,/obj/items/Senzu)) return
		if(istype(O,/obj/items/Magic_Vault)) return
		if(istype(O,/obj/items/Safe)) return
		if(istype(O,/obj/items/Phylactery)) return
		if(istype(O,/obj/items/Regenerator)) return
		if(istype(O,/obj/Magical_Portal)) return
		if(istype(O,/obj/Magical_Portal)) return
		if(istype(O,/BodyPart/)) return
		if(istype(O,/Skill/MartialArt/)) return
		if(usr)
			usr<<"Do not use this to give yourself a name that is against the rules. Or somehow blank names."
			if(O!=usr&&istype(O,/mob/player)) switch(input(O,"[usr.name] wants to change your name to [ID], accept?") in list("No","Yes"))
				if("No")
					usr<<"[O] declined the name change to [ID]"
					return
			O.name = strip_html(ID,MAX_NAME_LENGTH)
			if(O.name=="Air Mask"||O.name=="Space mask"||O.name=="Air mask"||O.name=="Space Mask") O.name=initial(O.name)
			usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes [key_name(O)] 's name to [ID].\n")

mob/verb/Change_Color(obj/O as obj in view(usr))
	if(istype(O,/obj/items/Magic_Circle)) return
	if(istype(O,/obj/items/Phylactery)) return
	if(istype(O,/obj/Magic_Ball)) return
	if(istype(O,/obj/items/Cloning_Tank)) return
	if(istype(O,/obj/items/Bomb)) return
	if(istype(O,/obj/items/Senzu)) return
	if(istype(O,/BodyPart/)) return
	if(istype(O,/Language/)) return
	usr.Colorizee(O)

obj/var/ChangeIconOwner
mob
	verb/Copy_Icon(mob/A in view(usr))
		set category=null//"Other"
//		set src=usr.contents
		if(ismob(A))
			if(!A.client)
				usr << "Error: Not a player."
				return
			switch(input(A,"[usr.name] wants to copy your icon, accept?") in list("No","Yes"))
				if("No")
					usr << "[A] declined your request to copy their icon"
					return
		usr.icon = A.icon

	verb/Change_Object_XY_Or_Layer(obj/O as obj in view(usr))
		set category=null//"Other"
		if(istype(O,/obj/items/Magic_Circle)) return
		if(istype(O,/obj/items/Phylactery)) return
		if(istype(O,/obj/Magic_Ball)) return
		if(istype(O,/obj/items/Cloning_Tank)) return
		if(istype(O,/obj/items/Bomb)) return
		if(istype(O,/obj/items/Senzu)) return
		if(istype(O,/BodyPart/)) return
		if(istype(O,/Language/)) return
		O.pixel_x=input("Input [O]s pixel x") as num
		if(O.pixel_x>128)O.pixel_x=128
		if(O.pixel_x<-128)O.pixel_x=-128
		O.pixel_y=input("Input [O]s pixel y") as num
		if(O.pixel_y>128)O.pixel_y=128
		if(O.pixel_y<-128)O.pixel_y=-128
		var/layP=input("Choose a layer for [O] 1-10 0 for default") as num
		if(layP) O.layer=layP
		else O.layer=initial(O.layer)
		if(O.layer>10) O.layer=10
		if(O.layer<1) O.layer=1
	verb/Change_Object_Icon(obj/A as obj in view(usr))
		set category=null//"Other"
		set desc = "Change an object's icon"
		var/ICO = input("Select an icon to use.","Change Icon") as null|icon
		if(!ICO)
			return 0
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return 0
		else
			if(!A) A=input(usr,"") as obj in view(usr)
//			if(istype(A,/Activity)) return
			if(istype(A,/Language/)) return

			if(istype(A,/obj/items/Magic_Circle)) return
			if(istype(A,/obj/items/Phylactery)) return
			if(istype(A,/obj/Magic_Ball)) return
			if(istype(A,/obj/items/Cloning_Tank)) return
			if(istype(A,/obj/items/Bomb)) return
			if(istype(A,/obj/items/Senzu)) return
			if(istype(A,/obj/items/Magic_Vault)) return
			if(istype(A,/obj/items/Safe)) return
			if(istype(A,/obj/items/Phylactery)) return
			if(istype(A,/obj/items/Regenerator)) return
			if(istype(A,/obj/TrainingEq/Magic_Goo)) return
			if(istype(A,/obj/TrainingEq/Punching_Bag)) return
			if(istype(A,/obj/Magical_Portal)) return
			if(istype(A,/obj/Magical_Portal)) return
			if(istype(A,/BodyPart/)) return
			if(istype(A,/turf/Upgradeable)) return

			var/X_Offset=input("Choose pixel_x offset, each tile is 32 pixels.") as num
			var/Y_Offset=input("Choose pixel_y offset") as num
			A.ChangeIconOwner = usr.lastKnownKey
			//A.ChangeIconIP = usr.lastKnownIP
			if(!A)
				return
			else if(isicon(ICO))
				A.icon=ICO
				A.icon_state=input("icon state") as text
				A.pixel_x = X_Offset
				A.pixel_y = Y_Offset
				if(usr.Confirm("Change it's default layer?"))
					A.layer=input("Choose a layer for [A] 1-10 (1-2 are below your character ") as num
					if(A.layer>10) A.layer=10
					if(A.layer<1) A.layer=1
				usr << "Icon accepted!"
				usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes the icon of object [A] to [A.icon].\n")

	verb/Change_IconP()
		set category = null
		var/Choice=alert(usr,"Mob or Object","Change Icon","Mob","Object")
		switch(Choice)
			if("Mob") Change_Icon()
			if("Object") Change_Object_Icon()
	verb/Change_Icon()
		set category = null//"Other"
		set name = "Change Icon"
		set desc = "Select a new icon to use."
		var/mob/player/A=input("") as mob in view(usr)
		if(!usr || !A)
			return 0
		else
			var/ICO = input("Select an icon to use.","Change Icon") as null|icon
			if(!ICO)
				return 0
			var/size = length(ICO)
			Size(size)
			if(length(ICO) > iconsize)
				alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
				return 0
			else
				var/X_Offset=input("Choose pixel_x offset, each tile is 32 pixels.") as num
				var/Y_Offset=input("Choose pixel_y offset") as num
				if(A == usr||!A.client)
					A.icon = ICO
					A.pixel_x = X_Offset
					A.pixel_y = Y_Offset
					A.adjustedX=X_Offset
					A.adjustedY=Y_Offset
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes their own icon to [ICO].\n")
				else switch(input(A,"[usr.name] wants to change your icon into \icon[ICO], accept?") in list("Yes","No"))
					if("Yes")
						A.icon=ICO
						A.pixel_x = X_Offset
						A.pixel_y = Y_Offset
						A.adjustedX=X_Offset
						A.adjustedY=Y_Offset
						usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] changes [key_name(A)]'s icon to [ICO]\n")
					else
						usr<<"[A] denies to change their icon"
				if(A.Dead) if(!A.KeepsBody)
					var/icon/I=new(A.icon)
					I.Blend(rgb(0,0,0,195),ICON_ADD)
					A.icon=I




mob/proc
	Pick_Icon_State()
		var/list/states = list()
		for(var/L in icon_states(src.icon))
			states+=L
		if(states.Find(""))
			states+="Default Icon State"
		var/pick = input("Select an icon state to use.","Change Icon State") as null|anything in states
		if(!pick)
			return 0
		if(pick == "Default Icon State")
			src.icon_state = null
		else
			src.icon_state = pick

//Supplemental Stuff
var/filesize
var/filemsg
var/iconsize = 524000 //~~500 KB
proc	//-- Filesize Message
	Size(file as num)
		filemsg = "[file] Bytes"
		if(file >= 1024)
			var/n = file / 1024
			filemsg = "[n] KB"
			if(n >= 1024)
				var/o = n / 1024
				filemsg = "[o] MB"
				