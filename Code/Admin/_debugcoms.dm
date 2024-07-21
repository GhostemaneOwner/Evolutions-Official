/*
 * Every admin command that has no actual administration function other than to test things and/or potentially break the server
 * should be categorized as a debug function and as such declared HERE.
*/
mob/Debug/verb

	Make_Empty_Mobs()
		set category = "Admin Other"
		if(!usr.client.holder)
			alert("You cannot perform this action. You must be of a higher administrative rank!")
			return
		if(!usr.client.holder||usr.client.holder.level<5) return
		var/amount = input("How many clientless player mobs do you want to create?") as num
		if(!amount) return

		log_errors("\n\n### CREATING [amount] TEST PLAYER MOBS AT: [time2text(world.realtime,"Day DD hh:mm")]  ###\n\n")
		src << "Creating [amount] player mobs"

		for(var/i, i<amount, i++)
			var/mob/player/M = new/mob/player
			M.loc = locate(usr.x+i,usr.y,usr.z)
			M.icon = usr.icon
			M.TestChar = 1
			spawn M.Update_Player()
			M.name = "TESTCHAR #[i]"
			Players += M.name
			M.client = "rand(1,10)rand(a,z1)rand(1,10)"
			M.ckey = M.client


		src << "DONE! Created [amount] player mobs"
		log_errors("\n\n### DONE CREATING [amount] TEST PLAYER MOBS AT: [time2text(world.realtime,"Day DD hh:mm")]  ###\n\n")

