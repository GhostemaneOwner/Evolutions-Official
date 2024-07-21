datum/mind
	var/key
	var/mob/current
	var/memory

	proc/store_memory(new_text)
		var/newMemory = "[new_text]<BR>"
		newMemory += memory
		memory = newMemory	//This way we add new memories to the top
		if(length(memory) > MAX_MESSAGE_LEN*100) dd_limittext(memory,MAX_MESSAGE_LEN*100)	//Large limit but still a limit

	proc/show_memory(mob/recipient)
		var/output = "<B>[current.real_name]'s Memory</B><HR>"
		output += "<A HREF='?src=\ref[src];refreshmemory=\ref[src.current]'>Refresh Memory</A>"
		if(usr.client.holder && usr.client.holder.level >= 1 && src.current)
			//output += " - <A HREF='?src=\ref[src];scramblememory=\ref[src.current]'>Scramble Memory</A> - "
			//output += "<A HREF='?src=\ref[src];wipememory=\ref[src.current]'>Wipe Memory</A> - "
			output += "- <A HREF='?src=\ref[src];addmemory=\ref[src.current]'>Add Memory</A>"
			//if(usr.client.holder.level >= 4)	//Lets admin do mobchanges :v
			//	output += " - <A HREF='?src=\ref[src];transfermemory=\ref[src.current]'>Transfer Mind</A>"
		output += "<HR>"
		output += memory
		recipient << browse(output,"window=memory")


	Topic(href, href_list)
		..()
		if(href_list["refreshmemory"]) src.show_memory(usr)
		if(href_list["addmemory"])
			var/addedMemory = input("Add what to their memory?") as message
			addedMemory = copytext(addedMemory, 1, MAX_MESSAGE_LEN)
			addedMemory= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm")]<br> ([usr.key])<hr> [addedMemory]<br><hr>"
			if(!addedMemory) return
			else
				src.store_memory(addedMemory)
				src.show_memory(usr)
				alertAdmins({"[key_name(usr)] added to [key_name(src.current)]'s <a HREF='?src=\ref[src];refreshmemory=\ref[src.current]'>memory</A></div>"})
				log_admin("[key_name(usr)] added to [key_name(src.current)]'s memory")

