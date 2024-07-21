/proc/alertAdmins(var/text, var/admin_ref = 0)
	if(!text) return 0	//Failed
	var/rendered = "<font color = #FFA500><span class=\"admin\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message\">[text]</span></span>"
	for (var/mob/player/M in Players)
		if(M.client) if(M.client.holder && M.client.holder.listen_Alerts)
			//if(admin_ref)
			//	if(M.client.holder.listen_Alerts) M.AdminOut(dd_replaceText(rendered, "%admin_ref%", "\ref[M]"))
			//	else M.HelpOut(dd_replaceText(rendered, "%admin_ref%", "\ref[M]"))
			//else
			if(M.client.holder.listen_Alerts) M.AdminOut(rendered)
			else M.HelpOut(rendered)
	LogHook(rendered)

/proc/logAndAlertAdmins(var/text)
	if(!text) return
	log_admin(text)
	alertAdmins(text)
	LogHook(text)

/proc/alertAdminsLogin(var/text,var/color="green")
	if(!text) return 0	//Failed
	var/rendered = "<span class=\"admin\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message\"><font color=\"[color]\">[text]</font></span></span>"
	for(var/mob/player/M in Players) if(M.client) if(M.client.holder) if(M.client.holder && M.client.holder.listen_Logins) M.HelpOut(rendered)
