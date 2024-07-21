/*This way of viewing logs is slow.
If anybody has any suggestions on the speed/efficiency while keeping the ability to go through offline logs, then please improve it. -- Vale*/
mob/Admin4/verb/viewerrors()
	set name = "Error Log"
	set category = "Admin Other"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	src << ftp("Data/Logs/errors.log","errors.log")
	return

/client/proc/get_log(log,portion)
	src<< "The logfile is being downloaded. Please be patient. Any lag is due to the download and is limited to just you."
	src<< "If you want the HTML to WORK, save the .log extension to .html (so it'll be something like SuperCuck.html)."
	src<<browse(file(log), "window=Log;size=600x600")  ///   <<----- This is what makes the pop up src<<browse(file(log)) is with no pop up
	src<<ftp(file(log))

mob/Admin1/verb/check_log()
	set category = "Admin"
	set name = "Check Player Logs"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!fexists("Data/Players/"))
		alert("No world logs found!")
		return
	var/filedialog/F = new(usr.client, /client/proc/get_log)
	F.msg = "Choose a logfile."   // message in the window
	F.title = "Load Player Log"      // popup window title
	F.root = "Data/Players/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
	F.ext = ".log"                  // default extension
	F.filter = ".log"
	usr << ftp(F)
	F.Create(usr.client)            // now display the dialog
	usr << ftp(F)//"Data/Players/errors.log","errors.log")

/client/proc/read_world_log(log,portion)
	src<< "The logfile is being downloaded. Please be patient. Any lag is due to the download and is limited to just you."
	src<<browse(file(log), "window=Log;size=600x600")  ///   <<----- This is what makes the pop up src<<browse(file(log)) is with no pop up
	src<<ftp(file(log))

/obj/admins/proc/check_world_logs()
	set category = "Admin"
	set name = "Check World Logs"
	if(!usr.client.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return
	if(!fexists("Data/Logs/"))
		alert("No world logs found!")
		return
	var/filedialog/F = new(usr.client, /client/proc/read_world_log)
	F.msg = "Choose a logfile."   // message in the window
	F.title = "Load World Log"      // popup window title
	F.root = "Data/Logs/"               // directory to use
	F.saving = 0                    // saving? (false is default)
	//F.default_file = "./[time2text(world.realtime, "YYYY/Month")]"    // default file name
	F.ext = ".log"                  // default extension
	F.filter = ".log"
	usr << ftp(F)
	F.Create(usr.client)            // now display the dialog
	usr << ftp(F)
