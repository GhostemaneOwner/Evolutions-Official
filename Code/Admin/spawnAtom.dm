/obj/admins/proc/spawn_atom(var/object as text)
	set category = "Admin"
	set desc="(atom path) Spawn an atom"
	set name="Spawn Atom"

	if(usr.client.holder.level >= 4)
		var/list/types = typesof(/atom)

		var/list/matches = new()

		for(var/path in types)
			if(findtext("[path]", object))
				matches += path

		if(matches.len==0)
			return

		var/chosen
		if(matches.len==1)
			chosen = matches[1]
		else
			chosen = input("Select an atom type", "Spawn Atom", matches[1]) as null|anything in matches
			if(!chosen)
				return

		new chosen(usr.loc)
		log_admin({"[key_name(usr)] spawned [chosen] at ([usr.x],[usr.y],[usr.z])"})


	else
		alert("You cannot perform this action. You must be of a higher administrative rank!", null, null, null, null, null)
		return
		