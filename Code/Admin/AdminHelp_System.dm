
//var/AdminApplys[0]
var/AdminHelps[0]
mob/var/AdminHelpsFinished=0
mob/Admin1/verb/showAdminHelpList()
	set category = "Admin Other"
	set name = "Show Admin Helps"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	winshow(usr.client,"AdminHelpWindow",1)
	usr.RefreshListAhelp()

Admin_Help_Object
	parent_type=/obj
	name = "Test Name"
	var/
		Character_Key = "New Key"
		Character_Name = "New Name"
		AdminHelp_Message = "IC Reason Here"
		UniqueID = "Unique ID"
		TimeSubmitted = "None"
		tmp/ActionLink = "(X)"
	//	ChatLog=""
	Click()
		usr.RefreshListAhelp()
		usr.submitAhelp(src)

var/AHelpIDCounter=0
mob/var/tmp/AdminHelpMute=0

mob/verb/SendAHelp()
	//set name = "Admin Help"
	set hidden=1
	var/txt=winget(usr, "AhelpW.AHELPin", "text")
	if(AdminHelpMute)
		src<<"You may only send one AHelp every two minutes."
		return
	AdminHelpMute=1
	spawn(1600) AdminHelpMute=0
	var/Admin_Help_Object/AHelp = new()
	AHelp.name = "[usr.key]     "
	AHelp.Character_Key = usr.key
	AHelp.Character_Name = usr.name
	AHelpIDCounter++
	AHelp.UniqueID = "ID [AHelpIDCounter]"
	AHelp.TimeSubmitted = "[time2text(world.realtime,"Day, hh : mm")]"
	AHelp.icon = usr.icon
	AHelp.overlays = usr.overlays
	usr<<"Message sent!"
	txt=html_decode(txt)
	txt=copytext(txt,1,10000)
	AHelp.AdminHelp_Message = txt
	AdminHelps.Add(AHelp)
	for(var/mob/M in Players) if(M.client && M.client.holder)
		if(NitroBooster)
			M.AdminOut("<b><font color=red>(PRIORITY HELP)</font color> <font size = 3><u><A HREF='?src=\ref[M.client.holder];privatemessage=\ref[usr]'>[usr.key]</a href>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>) (<A HREF='?src=\ref[M.client.holder];adminhelpresolve=\ref[AHelp.UniqueID]'>Mark Resolved</A>): [txt]</b></u>")
		else
			M.AdminOut("<b><font color=red>(PLAYER HELP)</font color> <A HREF='?src=\ref[M.client.holder];privatemessage=\ref[usr]'>[usr.key]</a href>(<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[src]'>X</A>) (<A HREF='?src=\ref[M.client.holder];adminhelpresolve=\ref[AHelp.UniqueID]'>Mark Resolved</A>): [txt]</b>")
		M.RefreshListAhelp()
	alertAdmins("AdminPM (Admin Help from [usr.key]): [txt]")
	client.HttpPost("https://discordapp.com/api/webhooks/1205043469614317578/XLJpoNx_OGxnrC7RBllh5hr3HbCr_1RdfpCUgRKtBmwZM4AQCheAw9tVlBbRdCY3Flkx",
		list(content = "**__[usr.name]/[usr.key]__** : \n \n```[txt]```",username = "[AHelp.UniqueID]"))
	usr<<"Your message:\n\n[txt]\n\nhas been sent to the admin!"
	winset(usr.client, "AhelpW.AHELPin", "text=")
	winshow(client,"AhelpW",0)

mob/verb/DeleteAdminHelp()
	set hidden=1
	if(!client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/inID = winget(usr,"Help_Unique_ID","text")
	var/inWho=winget(usr,"Help_Character_Name","text")
	inWho="[inWho] ([winget(usr,"Help_Character_Key","text")])"
	for(var/Admin_Help_Object/O in AdminHelps) if(O.UniqueID == "[inID]")
		var/mob/B
		for(var/mob/M in Players) if(M.key==O.Character_Key) B=M
		if(usr.Confirm("Player Journal Entry for [B]?")) B.mind.show_memory(usr)
		AdminHelps.Remove(O)
	src << output(null, "Help_Character_Key")
	src << output(null, "Help_Character_Name")
	src << output(null, "Help_Message")
	src << output(null, "Help_Unique_ID")
	src << output(null, "TimeSubmitted")
	src << output(null, "ActionLink")
	AdminHelpsFinished++
	usr.RefreshListAhelp()
	client.HttpPost(
			// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
			"https://discordapp.com/api/webhooks/1205043469614317578/XLJpoNx_OGxnrC7RBllh5hr3HbCr_1RdfpCUgRKtBmwZM4AQCheAw9tVlBbRdCY3Flkx",
			list(
				content = "``RESOLVED [inWho]``",
				username = "[inID]"
			)
		)
	src<<"You should consider filling out a Player Journal for this."
mob/verb/AdminHelpEscalate()
	set hidden=1
	if(!client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/inID = winget(usr,"Help_Unique_ID","text")
	var/inWho=winget(usr,"Help_Character_Name","text")
	inWho="[inWho] ([winget(usr,"Help_Character_Key","text")])"
	alertAdmins("[usr] escalated admin help [inID] from [inWho]")
	usr.RefreshListAhelp()
	client.HttpPost(
			// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
			"https://discordapp.com/api/webhooks/1205043469614317578/XLJpoNx_OGxnrC7RBllh5hr3HbCr_1RdfpCUgRKtBmwZM4AQCheAw9tVlBbRdCY3Flkx",
			list(
				content = "**__Escalation:[inWho] from [usr.key]__** : \n \n<@&1120828746501455942><@&1117676466373664849>\n \n ",
				username = "[inID]"
			)
		)
	src<<"You should consider filling out a Player Journal for this."
/*
mob/verb/Escalate()
	set hidden=1
	var/inID = winget(usr,"Help_Unique_ID","text")
	var/inWho=winget(usr,"Help_Character_Name","text")
	inWho="[inWho] ([winget(usr,"Help_Character_Key","text")])"
	for(var/Admin_Help_Object/O in AdminHelps) if(O.UniqueID == "[inID]")
		var/mob/B
		for(var/mob/M in Players) if(M.key==O.Character_Key) B=M
		if(usr.Confirm("Player Journal Entry for [B]?")) B.mind.show_memory(usr)
		AdminHelps.Remove(O)
	src << output(null, "Help_Character_Key")
	src << output(null, "Help_Character_Name")
	src << output(null, "Help_Message")
	src << output(null, "Help_Unique_ID")
	src << output(null, "TimeSubmitted")
	src << output(null, "ActionLink")
	AdminHelpsFinished++
	usr.RefreshListAhelp()
	client.HttpPost(
			// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
			"https://discordapp.com/api/webhooks/1205043469614317578/XLJpoNx_OGxnrC7RBllh5hr3HbCr_1RdfpCUgRKtBmwZM4AQCheAw9tVlBbRdCY3Flkx",
			list(
				content = "``ESCALATION [inWho]``",
				username = "[inID]"
			)
		)
	src<<"You should consider filling out a Player Journal for this."
*/

mob/proc/submitAhelp(var/Admin_Help_Object/O)
	src << output(null, "Help_Message")
	src << output(O.Character_Key, "Help_Character_Key")
	src << output(O.Character_Name, "Help_Character_Name")
	src << output(O.AdminHelp_Message, "Help_Message")
	src << output(O.UniqueID, "Help_Unique_ID")
	src << output(O.TimeSubmitted,"TimeSubmitted")
	var/mob/Char
	for(var/mob/M in Players) if(M.key==O.Character_Key) Char=M
	src << output("<A HREF='?src=\ref[client.holder];privatemessage=\ref[Char]'>Message</a href> <A HREF='?src=\ref[client.holder];observe=\ref[Char]'>Watch</a href> <A HREF='?src=\ref[client.holder];assess=\ref[Char]'>Assess</a href> <A HREF='?src=\ref[client.holder];jumpto=\ref[Char]'>Jump</a href> <A HREF='?src=\ref[src];sendToSpawn=\ref[Char]'>Send to Spawn</A>  (<A HREF='?src=\ref[client.holder];adminplayeropts=\ref[Char]'>X</A>)", "ActionLink")

mob/verb/RefreshListAhelp()
	set name=".RefreshAHelp"
	set hidden=1
	if(!client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	var/items = 0
	winset(usr.client,"Help_OutPutMessages","cells=0x0")
	for(var/Admin_Help_Object/O in AdminHelps)
		winset(src.client, "Help_OutPutMessages", "current-cell=[++items]")
		++items
		usr << output(O, "Help_OutPutMessages")
	winset(src.client, "Help_OutPutMessages", "cells=[items]")



