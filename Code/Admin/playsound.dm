/client/proc/play_sound(S as sound)
	set category = "Admin"
	set name = "Play Sound"

	if(!src.holder)
		src << "Only administrators may use this command."
		return

	var/sound/uploaded_sound = sound(S,0,1,0)
	uploaded_sound.priority = 255
	uploaded_sound.wait = 1

	if(src.holder.level >= 3)
		log_admin({"[key_name(src)] played sound [S]"})
		alertAdmins("[key_name_admin(src)] played sound [S]", 1)
		world << uploaded_sound
	else
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return
		