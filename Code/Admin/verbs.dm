//Toot toot admin definitions
#define Owner 6
#define ProjectManager 5
#define HeadAdministrator 4
#define SeniorAdministrator 3
#define Administrator 2
#define Moderator 1
//Toot toot 6 levels of admin
//The only issue is that event admins are considered higher then moderators
//But honestly if we trust them to run an event they can ban/mute people too

/client/proc/update_admins(var/rank)
	if(!src.holder) src.holder = new /obj/admins(src)
	src.holder.rank = rank
	switch (rank)
		if ("Owner")
			src.holder.level = 6
			//verbs
		if("ProjectManager")
			src.holder.level = 5
			//verbs 
		if("HeadAdministrator")
			src.holder.level = 4
			//verbs
		if ("SeniorAdministrator")
			src.holder.level = 3
			//verbs
		if ("Administrator")
			src.holder.level = 2
			//derp
		if ("Moderator")
			src.holder.level = 1
			//berp
		if ("Banned")
			del(src)
			return
		else
			del(src.holder)
			return


	if (src.holder)
		src.holder.owner = src


		if (src.holder.level >= 1)
			src.verbs += typesof(/mob/Admin1/verb)
			src.verbs += typesof(/mob/AdminToggles/verb)
			src.verbs += /client/proc/Give_Other
			src.verbs += /client/proc/Delete
			src.verbs += /client/proc/jumptomob
			src.verbs += /client/proc/Jump
			src.verbs += /client/proc/unban_panel
			src.verbs += /client/proc/stealth
			src.verbs += /client/proc/cmd_admin_pm
			src.verbs += /client/proc/cmd_admin_say
			src.verbs += /client/proc/cmd_admin_mute
			src.verbs += /client/proc/Narrate_World
			src.verbs += /client/proc/narrate
			src.verbs += /client/proc/Watch
			src.verbs += /client/proc/Knockout
			src.verbs += /client/proc/Kill
			src.verbs += /client/proc/returnmob
			src.verbs += /obj/admins/proc/Create_Object_Menu
			src.verbs += /obj/admins/proc/check_world_logs

		if (src.holder.level >= 2)
			src.verbs += typesof(/mob/Admin2/verb)
			src.verbs += /obj/admins/proc/Edit
			src.verbs += /obj/admins/proc/Saveserver
			src.verbs += /client/proc/allow_rares

		if(src.holder.level >= 3)
			src.verbs += typesof(/mob/Admin3/verb)
			src.verbs += /client/proc/Set_Spawns

			src.verbs += /obj/admins/proc/Replace

		if(src.holder.level >= 4)
			src.verbs += /client/proc/Hubtext
			src.verbs += /obj/admins/proc/Shutdown
			src.verbs += /obj/admins/proc/immreboot
			src.verbs += typesof(/mob/Admin4/verb)
			src.verbs += /client/proc/Toggle_Global_Rares
			src.verbs += /client/proc/play_sound
			src.verbs += /client/proc/Delete_Player_save

		if(src.holder.level >= 5)
		//	src.verbs += typesof(/mob/Debug/verb)
//			src.verbs += /client/proc/Unactivate_Server
			src.verbs += /obj/admins/proc/spawn_atom
			src.verbs += /client/proc/Update_So_Far

if(src.holder.level >= 6)
			src.verbs += typesof(/mob/Debug/verb)
//			src.verbs += /client/proc/Unactivate_Server
			src.verbs += /obj/admins/proc/spawn_atom
			src.verbs += /client/proc/Update_So_Far

/client/proc/clear_admin_verbs()
	src.verbs -= /obj/admins/proc/Shutdown
	src.verbs -= /obj/admins/proc/spawn_atom
	src.verbs -= /obj/admins/proc/Create_Object_Menu
	src.verbs -= /obj/admins/proc/immreboot
	src.verbs -= /obj/admins/proc/Edit
	src.verbs -= /obj/admins/proc/check_world_logs
	src.verbs -= /obj/admins/proc/Saveserver
	src.verbs -= /client/proc/Give_Other
	src.verbs -= /client/proc/cmd_admin_pm
	src.verbs -= /client/proc/cmd_admin_say
	src.verbs -= /client/proc/cmd_admin_mute
	src.verbs -= /client/proc/unban_panel
	src.verbs -= /client/proc/stealth
	src.verbs -= /client/proc/Watch
//	src.verbs -= /client/proc/Unactivate_Server
	src.verbs -= /client/proc/play_sound
	src.verbs -= /client/proc/jumptomob
	src.verbs -= /client/proc/Jump
	src.verbs -= /client/proc/Toggle_Global_Rares
	src.verbs -= /client/proc/Kill
	src.verbs -= /client/proc/Knockout
	src.verbs -= /client/proc/Hubtext
	src.verbs -= /client/proc/narrate
	src.verbs -= /client/proc/Set_Spawns
	src.verbs -= /client/proc/Delete
	src.verbs -= /client/proc/returnmob
	src.verbs -= /client/proc/Delete_Player_save
	src.verbs -= /client/proc/Narrate_World
	src.verbs -= /client/proc/Update_So_Far
	src.verbs -= /client/proc/allow_rares
	src.verbs -= typesof(/mob/AdminToggles/verb)
	src.verbs -= typesof(/mob/Debug/verb)
	src.verbs -= typesof(/mob/Admin1/verb)
	src.verbs -= typesof(/mob/Admin2/verb)
	src.verbs -= typesof(/mob/Admin3/verb)
	src.verbs -= typesof(/mob/Admin4/verb)
 src.verbs -= types of(/mob/Admin5/verb)

	if(src.holder) src.holder.level = 0
	