

/proc/text2dir(direction)
	switch(uppertext(direction))
		if("NORTH")
			return 1
		if("SOUTH")
			return 2
		if("EAST")
			return 4
		if("WEST")
			return 8
		if("NORTHEAST")
			return 5
		if("NORTHWEST")
			return 9
		if("SOUTHEAST")
			return 6
		if("SOUTHWEST")
			return 10
		else
	return

/proc/reverseDir(direction)
	switch(uppertext(direction))
		if("NORTH")
			return 2
		if("SOUTH")
			return 1
		if("EAST")
			return 8
		if("WEST")
			return 4
		if("NORTHEAST")
			return 10
		if("NORTHWEST")
			return 6
		if("SOUTHEAST")
			return 9
		if("SOUTHWEST")
			return 5
		else
	return
/proc/get_turf(turf/location as turf)
	while (location)
		if (istype(location, /turf))
			return location

		location = location.loc
	return null

/proc/get_turf_or_move(turf/location as turf)
	location = get_turf(location)
	return location

/proc/dir2text(direction)
	switch(direction)
		if(1.0)
			return "North"
		if(2.0)
			return "South"
		if(4.0)
			return "East"
		if(8.0)
			return "West"
		if(5.0)
			return "NorthEast"
		if(6.0)
			return "SouthEast"
		if(9.0)
			return "NorthWest"
		if(10.0)
			return "SouthWest"
		else
	return

/proc/hex2num(hex)
	if (!( istext(hex) ))
		CRASH("hex2num not given a hexadecimal string argument (user error)")
		return
	var/num = 0
	var/power = 0
	var/i = null
	i = length(hex)
	while(i > 0)
		var/char = copytext(hex, i, i + 1)
		switch(char)
			if("0")
				power++
				goto Label_290
			if("9", "8", "7", "6", "5", "4", "3", "2", "1")
				num += text2num(char) * 16 ** power
			if("a", "A")
				num += 16 ** power * 10
			if("b", "B")
				num += 16 ** power * 11
			if("c", "C")
				num += 16 ** power * 12
			if("d", "D")
				num += 16 ** power * 13
			if("e", "E")
				num += 16 ** power * 14
			if("f", "F")
				num += 16 ** power * 15
			else
				CRASH("hex2num given non-hexadecimal string (user error)")
				return
		power++
		Label_290:
		i--
	return num

/proc/num2hex(num, placeholder)

	if (placeholder == null)
		placeholder = 2
	if (!( isnum(num) ))
		CRASH("num2hex not given a numeric argument (user error)")
		return
	if (!( num ))
		return "0"
	var/hex = ""
	var/i = 0
	while(16 ** i < num)
		i++
	var/power = null
	power = i - 1
	while(power >= 0)
		var/val = round(num / 16 ** power)
		num -= val * 16 ** power
		switch(val)
			if(9.0, 8.0, 7.0, 6.0, 5.0, 4.0, 3.0, 2.0, 1.0, 0.0)
				hex += text("[]", val)
			if(10.0)
				hex += "A"
			if(11.0)
				hex += "B"
			if(12.0)
				hex += "C"
			if(13.0)
				hex += "D"
			if(14.0)
				hex += "E"
			if(15.0)
				hex += "F"
			else
		power--
	while(length(hex) < placeholder)
		hex = text("0[]", hex)
	return hex

/proc/invertHTML(HTMLstring)

	if (!( istext(HTMLstring) ))
		CRASH("Given non-text argument!")
		return
	else
		if (length(HTMLstring) != 7)
			CRASH("Given non-HTML argument!")
			return
	var/textr = copytext(HTMLstring, 2, 4)
	var/textg = copytext(HTMLstring, 4, 6)
	var/textb = copytext(HTMLstring, 6, 8)
	var/r = hex2num(textr)
	var/g = hex2num(textg)
	var/b = hex2num(textb)
	textr = num2hex(255 - r)
	textg = num2hex(255 - g)
	textb = num2hex(255 - b)
	if (length(textr) < 2)
		textr = text("0[]", textr)
	if (length(textg) < 2)
		textr = text("0[]", textg)
	if (length(textb) < 2)
		textr = text("0[]", textb)
	return text("#[][][]", textr, textg, textb)

/proc/shuffle(var/list/shufflelist)
	if(!shufflelist)
		return
	var/list/new_list = list()
	var/list/old_list = shufflelist.Copy()
	while(old_list.len)
		var/item = pick(old_list)
		new_list += item
		old_list -= item
	return new_list

/proc/uniquelist(var/list/L)
	var/list/K = list()
	for(var/item in L)
		if(!(item in K))
			K += item
	return K

/proc/sanitize(var/t)
	var/index = findtext(t, "\n")
	while(index)
		t = copytext(t, 1, index) + "#" + copytext(t, index+1)
		index = findtext(t, "\n")

	index = findtext(t, "\t")
	while(index)
		t = copytext(t, 1, index) + "#" + copytext(t, index+1)
		index = findtext(t, "\t")

	return html_encode(t)

/proc/sanitize_n(var/t)
	var/index = findtext(t, "\t")
	while(index)
		t = copytext(t, 1, index) + "#" + copytext(t, index+1)
		index = findtext(t, "\t")

	return html_encode(t)

/proc/strip_html(var/t,var/limit=MAX_MESSAGE_LEN)
	t = copytext(t,1,limit)
	var/index = findtext(t, "<")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "<")
	index = findtext(t, ">")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, ">")
	return sanitize(t)


//Yeah we duplicate code CAUSE I AM LAZY DOG
/proc/sanitize_name(var/t,var/limit=MAX_MESSAGE_LEN)
	t = copytext(t,1,limit)
	var/index = findtext(t, "\\")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "\\")
	index = findtext(t, "/")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "/")
	index = findtext(t, "<")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "<")
	index = findtext(t, ">")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, ">")
	index = findtext(t, "?")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "?")
	index = findtext(t, ".")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, ".")
	index = findtext(t, "!")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "!")
	index = findtext(t, "(")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "(")
	index = findtext(t, ")")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, ")")
	index = findtext(t, "~")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "~")
	index = findtext(t, "@")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "@")
	index = findtext(t, "$")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "$")
	index = findtext(t, "%")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "%")
	index = findtext(t, "^")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "^")
	index = findtext(t, "&")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "&")
	index = findtext(t, "*")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "*")
	index = findtext(t, "#")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "#")
	index = findtext(t, ";")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, ";")
	index = findtext(t, ":")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, ":")
	return html_encode(t)
//forgive me father for I have sinned


/proc/say_quote(var/text)
	var/ending = copytext(text, length(text))
	//OOC first
	if(findtext(text,"(")||findtext(text,"\[")||findtext(text,"{")) return "(OOC) says,";
	if(findtext(text,")")||findtext(text,"\]")||findtext(text,"}")) return "(OOC) says,";
	if(findtext(text,"\<")|findtext(text,"\>")) return "thinks,";
	if (ending == "?") return "asks,";
	if (ending == "!") return "exclaims,";
	return "says,";

/proc/adminscrub(var/t,var/limit=MAX_MESSAGE_LEN)
	t = copytext(t,1,limit)
	var/index = findtext(t, "<")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, "<")
	index = findtext(t, ">")
	while(index)
		t = copytext(t, 1, index) + copytext(t, index+1)
		index = findtext(t, ">")
	return html_encode(t)

/proc/add_zero(t, u)
	while (length(t) < u)
		t = "0[t]"
	return t

/proc/add_lspace(t, u)
	while(length(t) < u)
		t = " [t]"
	return t

/proc/add_tspace(t, u)
	while(length(t) < u)
		t = "[t] "
	return t

/proc/trim_left(text)
	for (var/i = 1 to length(text))
		if (text2ascii(text, i) > 32)
			return copytext(text, i)
	return ""

/proc/trim_right(text)
	for (var/i = length(text), i > 0, i--)
		if (text2ascii(text, i) > 32)
			return copytext(text, 1, i + 1)

	return ""

/proc/trim(text)
	return trim_left(trim_right(text))

/proc/capitalize(var/t as text)
	return uppertext(copytext(t, 1, 2)) + copytext(t, 2)

/proc/sortList(var/list/L)
	if(L.len < 2)
		return L
	var/middle = L.len / 2 + 1 // Copy is first,second-1
	return mergeLists(sortList(L.Copy(0,middle)), sortList(L.Copy(middle))) //second parameter null = to end of list

/proc/sortNames(var/list/L)
	var/list/Q = new()
	for(var/atom/x in L)
		Q[x.name] = x
	return sortList(Q)

/proc/mergeLists(var/list/L, var/list/R)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	while(Li <= L.len && Ri <= R.len)
		if(sorttext(L[Li], R[Ri]) < 1)
			result += R[Ri++]
		else
			result += L[Li++]

	if(Li <= L.len)
		return (result + L.Copy(Li, 0))
	return (result + R.Copy(Ri, 0))

/proc/dd_range(var/low, var/high, var/num)
	return max(low,min(high,num))

/*

/proc/dd_file2list(file_path, separator)
	var/file
	if(separator == null)
		separator = "\n"
	if(isfile(file_path))
		file = file_path
	else
		file = file(file_path)
	return dd_text2list(file2text(file), separator)

/proc/dd_replacetext(text, search_string, replacement_string)
	var/textList = dd_text2list(text, search_string)
	return dd_list2text(textList, replacement_string)

/proc/dd_replaceText(text, search_string, replacement_string)
	var/textList = dd_text2list(text, search_string)
	return dd_list2text(textList, replacement_string)

/proc/dd_hasprefix(text, prefix)
	var/start = 1
	var/end = length(prefix) + 1
	return findtext(text, prefix, start, end)

/proc/dd_hasPrefix(text, prefix)
	var/start = 1
	var/end = length(prefix) + 1
	return findtext(text, prefix, start, end) //was findtextEx

/proc/dd_hassuffix(text, suffix)
	var/start = length(text) - length(suffix)
	if(start)
		return findtext(text, suffix, start, null)
	return

/proc/dd_hasSuffix(text, suffix)
	var/start = length(text) - length(suffix)
	if(start)
		return findtext(text, suffix, start, null) //was findtextEx

/proc/dd_text2list(text, separator, var/list/withinList)
	var/textlength = length(text)
	var/separatorlength = length(separator)
	if(withinList && !withinList.len) withinList = null
	var/list/textList = new()
	var/searchPosition = 1
	var/findPosition = 1
	while(1)
		findPosition = findtext(text, separator, searchPosition, 0)
		var/buggyText = copytext(text, searchPosition, findPosition)
		if(!withinList || (buggyText in withinList)) textList += "[buggyText]"
		if(!findPosition) return textList
		searchPosition = findPosition + separatorlength
		if(searchPosition > textlength)
			textList += ""
			return textList
	return

/proc/dd_list2text(var/list/the_list, separator)
	var/total = the_list.len
	if(!total)
		return
	var/count = 2
	var/newText = "[the_list[1]]"
	while(count <= total)
		if(separator)
			newText += separator
		newText += "[the_list[count]]"
		count++
	return newText

*/



/proc/english_list(var/list/input, nothing_text = "nothing", and_text = " and ", comma_text = ", ", final_comma_text = "," )
	var/total = input.len
	if (!total)
		return "[nothing_text]"
	else if (total == 1)
		return "[input[1]]"
	else if (total == 2)
		return "[input[1]][and_text][input[2]]"
	else
		var/output = ""
		var/index = 1
		while (index < total)
			if (index == total - 1)
				comma_text = final_comma_text

			output += "[input[index]][comma_text]"
			index++

		return "[output][and_text][input[index]]"

/*
/proc/dd_centertext(message, length)
	var/new_message = message
	var/size = length(message)
	var/delta = length - size
	if(size == length)
		return new_message
	if(size > length)
		return copytext(new_message, 1, length + 1)
	if(delta == 1)
		return new_message + " "
	if(delta % 2)
		new_message = " " + new_message
		delta--
	var/spaces = add_lspace("",delta/2-1)
	return spaces + new_message + spaces

/proc/dd_limittext(message, length)
	var/size = length(message)
	if(size <= length)
		return message
	return copytext(message, 1, length + 1)
*/


/proc/angle2dir(var/degree)
	degree = ((degree+22.5)%365)
	if(degree < 45)		return NORTH
	if(degree < 90)		return NORTH|EAST
	if(degree < 135)	return EAST
	if(degree < 180)	return SOUTH|EAST
	if(degree < 225)	return SOUTH
	if(degree < 270)	return SOUTH|WEST
	if(degree < 315)	return WEST
	return NORTH|WEST

/proc/anglee2text(var/degree)
	return dir2text(angle2dir(degree))

/proc/text_input(var/Message, var/Title, var/Default, var/length=MAX_MESSAGE_LEN)
	return sanitize(input(Message, Title, Default) as text, length)

/proc/scrub_input(var/Message, var/Title, var/Default, var/length=MAX_MESSAGE_LEN)
	return strip_html(input(Message,Title,Default) as text, length)

/proc/InRange(var/A, var/lower, var/upper)
	if(A < lower) return 0
	if(A > upper) return 0
	return 1

/proc/sign(x) //Should get bonus points for being the most compact code in the world!
	sleep(0)
	return x!=0?x/abs(x):0 //((x<0)?-1:((x>0)?1:0))



mob/verb/checkworldtime()
	usr<<"world time: [world.time]"

/*
mob
	var
		list/cooldowns
	proc
		getCooldown(id)
			if(!cooldowns) return -1#INF
			return cooldowns[id]||-1#INF

		onCooldown()
			if(!cooldowns) return 0
			. = -1#INF
			for(var/id in args)
				. = max(cooldowns[id],.)
			return .>world.time

		getCooldowns()
			if(!cooldowns) return -1#INF
			. = -1#INF
			for(var/id in args)
				. = max(cooldowns[id]||-1#INF,.)
			return .

		setCooldown(id,duration)
			if(!cooldowns)
				cooldowns = list()
			cooldowns[id] = (world.time+duration)

		CDUpdate()
			var/list/cdl = cooldowns
			for(var/id in cdl) if(cdl[id]<world.time) cdl -= id
			if(!cdl.len) cooldowns = null

	verb
		CDTest()
			setCooldown("Blast",100)
			usr<<"onCD B [onCooldown("Blast")]" return 1
			usr<<"getCD [getCooldowns("Blast",1,"3")]" returns CD
			usr<<"get CD B [getCooldown("Blast")]" returns CD
*/
mob
	Read(savefile/F)
		..()
		for(var/id in cooldowns) if(cooldowns[id]<world.time) cooldowns -= id
		if(!cooldowns.len) cooldowns = null

mob
	var
		save_worldtime

	Write(savefile/F)
		save_worldtime = world.time //store the current world time right before saving
		..() //default action causes the mob to be written to the savefile.


/proc/getline(atom/M,atom/N)
	var/px=M.x		//starting x
	var/py=M.y
	var/line[] = list(locate(px,py,M.z))
	var/dx=N.x-px	//x distance
	var/dy=N.y-py
	var/dxabs=abs(dx)//Absolute value of x distance
	var/dyabs=abs(dy)
	var/sdx=sign(dx)	//Sign of x distance (+ or -)
	var/sdy=sign(dy)
	var/x=dxabs>>1	//Counters for steps taken, setting to distance/2
	var/y=dyabs>>1
	var/j			//Generic integer for counting
	if(dxabs>=dyabs)	//x distance is greater than y
		for(j=0;j<dxabs;j++)//It'll take dxabs steps to get there
			y+=dyabs
			if(y>=dxabs)	//Every dyabs steps, step once in y direction
				y-=dxabs
				py+=sdy
			px+=sdx		//Step on in x direction
			if(isnull(M)) continue
			line+=locate(px,py,M.z)//Add the turf to the list
	else
		for(j=0;j<dyabs;j++)
			x+=dxabs
			if(x>=dyabs)
				x-=dyabs
				px+=sdx
			py+=sdy
			if(isnull(M)) continue
			line+=locate(px,py,M.z)
	return line


/proc/IsGuestKey(key)
	if (findtext(key, "Guest-", 1, 7) != 1) //was findtextEx
		return 0

	var/i, ch, len = length(key)

	for (i = 7, i <= len, ++i)
		ch = text2ascii(key, i)
		if (ch < 48 || ch > 57)
			return 0

	return 1

/proc/allmobs()
	var/list/L = new
	for(var/mob/M in world)
		L += M
	return L

/proc/sortmobs()
	var/list/mob_list = getmobs()
	mob_list = sortNames(mob_list)

	return mob_list

/proc/getmobs()

	var/list/mobs = allmobs()
	var/list/names = list()
	var/list/creatures = list()
	var/list/namecounts = list()
	for(var/mob/M in mobs)
		var/name = M.name
		if (name in names)
			namecounts[name]++
			name = "[name] ([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		if (M.real_name && M.real_name != M.name)
			name += " \[[M.real_name]\]"
		creatures[name] = M

	return creatures

/proc/modulus(var/M)
	if(M >= 0)
		return M
	if(M < 0)
		return -M
/*
/proc/findname(msg)
	for(var/mob/M in world)
		if (M.real_name == text("[msg]"))
			return 1
	return 0
*/
/proc/key_name(var/whom, var/include_link = null, var/include_name = 1)
	var/mob/the_mob = null
	var/client/the_client = null
	var/the_key = ""

	if (isnull(whom))
		return "*null*"
	else if (istype(whom, /client))
		the_client = whom
		the_mob = the_client.mob
		the_key = the_client.key
	else if (ismob(whom))
		the_mob = whom
		the_client = the_mob.client
		the_key = the_mob.key
	else if (istype(whom, /datum))
		var/datum/the_datum = whom
		return "*invalid:[the_datum.type]*"
	else
		return "*invalid*"

	var/text = ""

	if (!the_key)
		text += "*no client*"
	else
		if (include_link && !isnull(the_mob))
			if (istext(include_link))
				text += "<a href=\"byond://?src=[include_link];priv_msg=\ref[the_mob]\">"
			else
				text += "<a href=\"byond://?src=\ref[include_link];priv_msg=\ref[the_mob]\">"

		text += "[the_key]"

		if (!isnull(include_link) && !isnull(the_mob))
			text += "</a>"

	if (include_name && !isnull(the_mob))
		if (the_mob.real_name)
			text += "/([the_mob.real_name])"
		else if (the_mob.name)
			text += "/([the_mob.name])"

	return text

/proc/key_name_admin(var/whom, var/include_name = 1)
	return key_name(whom, "%admin_ref%", include_name)

// Registers the on-close verb for a browse window (client/verb/.windowclose)
// this will be called when the close-button of a window is pressed.
//
// This is usually only needed for devices that regularly update the browse window,
//
// windowid should be the specified window name
// e.g. code is	: user << browse(text, "window=fred")
// then use 	: onclose(user, "fred")
//
// Optionally, specify the "ref" parameter as the controlled atom (usually src)
// to pass a "close=1" parameter to the atom's Topic() proc for special handling.

/proc/onclose(mob/user, windowid, var/atom/ref=null)

	var/param = "null"
	if(ref)
		param = "\ref[ref]"

	winset(user, windowid, "on-close=\".windowclose [param]\"")

	//world << "OnClose [user]: [windowid] : ["on-close=\".windowclose [param]\""]"

/proc/reverselist(var/list/input)
	var/list/output = new/list()
	for(var/A in input)
		output += A
	return output

/proc/get_turf_loc(var/mob/M)
	var/atom/loc = M.loc
	while(!istype(loc, /turf/))
		loc = loc.loc
	return loc

// returns the turf located at the map edge in the specified direction relative to A
/proc/get_edge_target_turf(var/atom/A, var/direction)

	var/turf/target = locate(A.x, A.y, A.z)
		//since NORTHEAST == NORTH & EAST, etc, doing it this way allows for diagonal mass drivers in the future
		//and isn't really any more complicated

		// Note diagonal directions won't usually be accurate
	if(direction & NORTH)
		target = locate(target.x, world.maxy, target.z)
	if(direction & SOUTH)
		target = locate(target.x, 1, target.z)
	if(direction & EAST)
		target = locate(world.maxx, target.y, target.z)
	if(direction & WEST)
		target = locate(1, target.y, target.z)

	return target

// returns turf relative to A in given direction at set range
// result is bounded to map size
// note range is non-pythagorean
// used for disposal system
/proc/get_ranged_target_turf(var/atom/A, var/direction, var/range)

	var/x = A.x
	var/y = A.y
	if(direction & NORTH)
		y = min(world.maxy, y + range)
	if(direction & SOUTH)
		y = max(1, y - range)
	if(direction & EAST)
		x = min(world.maxx, x + range)
	if(direction & WEST)
		x = max(1, x - range)

	return locate(x,y,A.z)


// returns turf relative to A offset in dx and dy tiles
// bound to map limits
/proc/get_offset_target_turf(var/atom/A, var/dx, var/dy)
	var/x = min(world.maxx, max(1, A.x + dx))
	var/y = min(world.maxy, max(1, A.y + dy))
	return locate(x,y,A.z)

/proc/get_cardinal_step_away(atom/start, atom/finish) //returns the position of a step from start away from finish, in one of the cardinal directions
	//returns only NORTH, SOUTH, EAST, or WEST
	var/dx = finish.x - start.x
	var/dy = finish.y - start.y
	if(abs(dy) > abs (dx)) //slope is above 1:1 (move horizontally in a tie)
		if(dy > 0)
			return get_step(start, SOUTH)
		else
			return get_step(start, NORTH)
	else
		if(dx > 0)
			return get_step(start, WEST)
		else
			return get_step(start, EAST)

/turf/proc/GetAdjacent()
	var/list/L = list()
	for(var/turf/T in oview(1,src))
		L += T
	return L

/turf/var/pathweight = 1
/turf/proc/Distance(turf/t)
	if(get_dist(src,t) == 1)
		var/cost = (src.x - t.x) * (src.x - t.x) + (src.y - t.y) * (src.y - t.y)
		cost *= (pathweight+t.pathweight)/2
		return cost
	else
		return get_dist(src,t)

/proc/get_area(O)
	if(!O)
		return 0
	var/location = O

	for(var/i=1, i<=20, i++)
		if(!isarea(location))
			location = location:loc
		else
			return location
	return 0

/atom/proc/getIconImage()	//Returns your icon as a static image, sort've
	if(!istype(src, /atom/))
		return 0
	var/icon/I = new /icon(src.icon,src.icon_state)
	for(var/obj/O in src)
		if(O.suffix && O.suffix == "*Equipped*")
			I.Blend(new /icon(O.icon, O.icon_state), ICON_OVERLAY)
	return I

/proc/blink(atom/A)
	A.icon += rgb(0,75,75)
	spawn(10) A.icon = initial(A.icon)

/proc/get_areas(var/areatype)
	//Takes: Area type as text string or as typepath OR an instance of the area.
	//Returns: A list of all areas of that type in the world.
	//Notes: Simple!
	if(!areatype) return null
	if(istext(areatype)) areatype = text2path(areatype)
	if(isarea(areatype))
		var/area/areatemp = areatype
		areatype = areatemp.type

	var/list/areas = new/list()
	for(var/area/N in world)
		if(istype(N, areatype)) areas += N
	return areas

/proc/get_area_turfs(var/areatype)
	//Takes: Area type as text string or as typepath OR an instance of the area.
	//Returns: A list of all turfs in areas of that type of that type in the world.
	//Notes: Simple!
	if(!areatype) return null
	if(istext(areatype)) areatype = text2path(areatype)
	if(isarea(areatype))
		var/area/areatemp = areatype
		areatype = areatemp.type
	var/list/turfs_local = new/list()
	for(var/area/N in world)
		if(istype(N, areatype))
			for(var/turf/T in N) turfs_local += T
	return turfs_local

/proc/get_area_all_atoms(var/areatype)
	//Takes: Area type as text string or as typepath OR an instance of the area.
	//Returns: A list of all atoms	(objs, turfs, mobs) in areas of that type of that type in the world.
	//Notes: Simple!

	if(!areatype) return null
	if(istext(areatype)) areatype = text2path(areatype)
	if(isarea(areatype))
		var/area/areatemp = areatype
		areatype = areatemp.type

	var/list/atoms = new/list()
	for(var/area/N in world)
		if(istype(N, areatype))
			for(var/atom/A in N)
				atoms += A
	return atoms

/proc/File_Size(file)
	var/size=length(file)
	if(!size|!isnum(size)) return
	var/ending="Byte"
	if(size>=1024)
		size/=1024
		ending="KB"
		if(size>=1024)
			size/=1024
			ending="MB"
			if(size>=1024)
				size/=1024
				ending="GB"
	var/end=round(size)
	return "[Commas(end)] [ending]\s"

/proc/Value(A)
	if(isnull(A)) return "Nothing"
	else if(isnum(A)) return "[num2text(round(A,0.01),20)]"
	else return "[A]"

/proc/Commas(A)
	var/Number=num2text(round(A,1),20)
	for(var/i=length(Number)-2,i>1,i-=3) Number="[copytext(Number,1,i)]'[copytext(Number,i)]"
	return Number

/proc/blankBlocked(var/atom/A,var/atom/B)
	for(var/turf/T in getline(A,B))
		if(istype(T, /turf/Special/Blank))
			return 1
		if(istype(T, /turf/Other/Blank))
			return 1
	return 0

/proc/blankBlocked2(var/atom/A,var/atom/B)
	for(var/turf/T in getline(A,B))
		if(istype(T, /turf/Special/Blank))
			return 1
		if(istype(T, /turf/Other/Blank))
			return 1
		if(T.density)
			return 1
	for(var/mob/M in getline(A,B))
		if(M.Flying) return 1
	return 0

proc/Mob_Range(atom/A,range) if(A)
	var/startx=A.x-range
	var/starty=A.y-range
	var/endx=A.x+range
	var/endy=A.y+range
	if(startx<1) startx=1
	if(starty<1) starty=1
	if(endx>world.maxx) endx=world.maxx
	if(endy>world.maxy) endy=world.maxy
	var/list/Mobs=new
	for(var/mob/player/B in Players)
		if(!B.client) if(!A) return
		if(B.client) if (A) //Second sanity check that I added in.  - Arch
			if(B.z==A.z&&B.x>=startx&&B.x<=endx&&B.y>=starty&&B.y<=endy)
				var/Max_Distance=((B.BP)/1000)+100 //The max distance this individual can be sensed from.
				if(B.AndroidLevel>50) Max_Distance=0
				if(Max_Distance)
					if(B.BP>100&&B.x>A.x-Max_Distance&&B.x<A.x+Max_Distance&&B.y>A.y-Max_Distance&&B.y<A.y+Max_Distance&&!blankBlocked(B,A))
						Mobs+=B //If they are strong enough to be sensed long range.
					else if(B.x<A.x+10&&B.x>A.x-10&&B.y<A.y+10&&B.y>A.y-10) Mobs+=B //Or they are in very short range
	return Mobs-A

proc/Mob_Range_Scanner(atom/A,range) if(A)
	var/startx=A.x-range
	var/starty=A.y-range
	var/endx=A.x+range
	var/endy=A.y+range
	if(startx<1) startx=1
	if(starty<1) starty=1
	if(endx>world.maxx) endx=world.maxx
	if(endy>world.maxy) endy=world.maxy
	var/list/Mobs=new
	for(var/mob/player/B in Players)
		if(B==null)return
		if(A==null)return
		if(!ismob(B)) continue // Sanity check? Apparently, while looping through the list it can sometimes STILL be null?
		if(B.adminDensity) continue
		if(B.z==A.z&&B.x>=startx&&B.x<=endx&&B.y>=starty&&B.y<=endy)
			var/Max_Distance=((B.BP)/1000)+100 //The max distance this individual can be sensed from.
			if(Max_Distance)
				if(B.BP>100&&B.x>A.x-Max_Distance&&B.x<A.x+Max_Distance&&B.y>A.y-Max_Distance&&B.y<A.y+Max_Distance&&!blankBlocked(B,A))
					Mobs+=B //If they are strong enough to be sensed long range.
				else if(B.x<A.x+10&&B.x>A.x-10&&B.y<A.y+10&&B.y>A.y-10) Mobs+=B //Or they are in very short range
	return Mobs
