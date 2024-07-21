/client/proc/cmd_admin_say(msg as text)
	set category = "Admin Other"
	set name = "Asay"
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(!src.mob || src.muted) return
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	//log_admin("[key_name(src)] : [msg]")
	if(!msg) return
	for (var/mob/M in world) if (M.client && M.client.holder && M.client.holder.listen_Chat) M.AdminOut("<font color=white><span class=\"prefix\">ADMIN:</span> <span class=\"name\">[key_name(usr, M)]:</span> <span class=\"message\">[msg]</span></font>")

