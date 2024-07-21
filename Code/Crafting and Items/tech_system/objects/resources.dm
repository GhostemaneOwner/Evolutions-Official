

obj/Resources
	icon='Misc.dmi'
	icon_state="ZenniBag"
	Savable=1
	Click()
		..()
		if(src in usr) view(usr)<<"[usr] reveals [src.Value] resources."
//	var/Value=0
	verb/Drop()
		var/Money=input("Drop how much Resources? ([Commas(Value)])") as num
		if(Money>Value) Money=Value
		if(Money<=0) usr<<"You must atleast drop 1"
		if(Money>=1) if(isturf(usr.loc))
			Money=round(Money)
			Value-=Money
			var/obj/Resources/A=new
			A.loc=usr.loc
			A.Value=Money
			A.name="[Commas(A.Value)] Resources"
			view(usr)<<"<font size=1><font color=teal>[usr] drops [A]."
			step(A,usr.dir)
			usr.saveToLog("<font color=red>|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [Commas(Money)] Resources</font>\n")
		usr.Save()
//		usr.InventoryCheck()


	Treasure
		icon = 'treasure.dmi'
		New()
			src.Value = rand(1000,50000)*max(1,WipeDay)
			src.name = "Treasure - [Commas(src.Value)]"
	Radiant_Treasure
		icon = 'treasure.dmi'
		New()
			icon+=rgb(35,35,35)
			src.Value = rand(700000,1000000)*max(1,WipeDay)
			src.name = "Radiant Treasure - [Commas(src.Value)]"

//*(1-(0.15*usr.HasArcaneBrokerage))
obj/Mana
	icon='Mana.dmi'
	Savable=1
	Click()
		..()
		if(src in usr) view(usr)<<"[usr] reveals [src.Value] mana."
//	var/Value=0
	verb/Drop()
		var/Money=input("Drop how much Mana? ([Commas(Value)])") as num
		if(Money>Value) Money=Value
		if(Money<=0) usr<<"You must atleast drop 1"
		if(Money>=1) if(isturf(usr.loc))
			Money=round(Money)
			Value-=Money
			var/obj/Mana/A=new
			A.loc=usr.loc
			A.Value=Money
			A.name="[Commas(A.Value)] Mana"
			view(usr)<<"<font size=1><font color=teal>[usr] drops [A]."
			step(A,usr.dir)
			usr.saveToLog("<font color=red>|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] drops [Commas(Money)] Mana</font>\n")
		usr.Save()
//		usr.InventoryCheck()

	Mana_Crystal
		icon = 'Magic Items.dmi'
		icon_state = "crystal"
		New()
			src.Value = rand(1000,50000)*max(1,WipeDay)
			src.name = "Mana Crystal - [Commas(src.Value)]"
	Radiant_Mana_Crystal
		icon = 'Magic Items.dmi'
		icon_state = "crystal"
		New()
			icon+=rgb(35,35,35)
			src.Value = rand(700000,1000000)*max(1,WipeDay)
			src.name = "Radiant Mana Crystal - [Commas(src.Value)]"



