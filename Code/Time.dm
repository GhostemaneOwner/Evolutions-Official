mob/var/Throttle

var/list/months = list("January", "February", "March", "April", "May",
"June", "July", "August", "September", "October", "November", "December")

mob
	Login()
		..()
		Time.tellDate(client)

area
	icon = 'Weather.dmi'
	//alpha = 0
	//plane = 5
	//layer = 1
	//blend_mode = BLEND_MULTIPLY
	//mouse_opacity = 0

	var/Day_Cycle = 1 // if the cycle should happen

var/DataObject/Time/Time

DataObject/Time
//	name = "Time"
//	path = "Data/Wipe_Specific/Time.sav"
	var/Year = 0
	var/Date = 1 // shouldnt exceed 360
	var/textdate // will read like January 1st of Age 365
	var/Speed = 1080 // default speed is 8 days every day
	var/Day_Position = 1
	var/cycles = 8

	New()
		..()
		if(istype(Time)) del Time
		Time = src
		spawn() clock()

	proc
		clock()
			setDate()
			while(src)
				for(var/area/a in world)
					if(a.Day_Cycle)
						spawn() effects(a)
				sleep(Speed * world.fps / cycles)
				if(Day_Position >= 8)
					Day_Position = 1
					day()
				else Day_Position++

		effects(area/a)
			if(!istype(a)) return
			var/at = Speed * world.fps / cycles
			switch(Day_Position)
				if(1) animate(a, alpha = 255 * 0.8, color = rgb(0, 0, 255), time = at, loop = 1, easing = LINEAR_EASING)
				if(2) animate(a, alpha = 200 * 0.7, color = rgb(0, 0, 255), time = at, loop = 1, easing = LINEAR_EASING)
				if(3) animate(a, alpha = 100 * 0.4, color = rgb(210, 70, 0), time = at, loop = 1, easing = LINEAR_EASING)
				if(4) animate(a, alpha = 50 * 0.2, color = rgb(210, 70, 0), time = at, loop = 1, easing = LINEAR_EASING)
				if(5) animate(a, alpha = 25 * 0.1, color = rgb(210, 70, 0), time = at, loop = 1, easing = LINEAR_EASING)
				if(6) animate(a, alpha = 0, color = null, time = at, loop = 1, easing = LINEAR_EASING)
				if(7) animate(a, alpha = 255 * 0.4, color = rgb(0, 0, 255), time = at, loop = 1, easing = LINEAR_EASING)
				if(8) animate(a, alpha = 255 * 0.7, color = rgb(0, 0, 255), time = at, loop = 1, easing = LINEAR_EASING)

		day()
			Date++
			if(Date > 360)
				Date = 1
				Year++
			//	spawn() Throttle.checkThrottle()
			setDate()
			announce()

		setDate()
			var/month = "[months[Date % 30 ? round(Date / 30 + 1) : round(Date / 30)]]"
			var/year = "Age [Year]"
			textdate = "[month] [Date % 30 == 0 ? 30 : Date % 30]\th of [year]"

		tellDate(client/c)
			if(!istype(c)) return
			var/string = "<font class='date'>It is now [textdate]</font>"
			c << output(string, "alloutput")
			c << output(string, "ooc")
			c << output(string, "looc")
			c << output(string, "ic")

		announce()
			var/string = "<font class='date'>It is now [textdate]</font>"
			for(var/client/c)
				c << output(string, "alloutput")
				c << output(string, "ooc")
				c << output(string, "looc")
				c << output(string, "ic")
				