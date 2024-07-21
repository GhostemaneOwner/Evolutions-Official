
proc/log_admin(text)
	text=html_decode(text)
	var/logfile = "Data/Logs/Admin/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log"
	var/log =  "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]<br> [text]"
	text2file(log,logfile)
//	LogHook(text)

proc/log_errors(text)
	text=html_decode(text)
	var/log = "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")] | [text]"
	text2file(log,errors)

// NEW LOG SYSTEM


// NEW LOG SYSTEM

mob/proc/saveToLog(var/text)
	if(!client) return
	if(!(text || src))
		return
	//Almost put it under Data/Logs/blabla, but ehh

// I'm using Stephen001's EventScheduler library /
// I'm hoping this will help reduce the lag caused by massive saveToLog calls

	var/Event/E = new/Event/writeToLog(text, lastKnownKey)
	LOGscheduler.schedule(E, rand(2,12))

Event/writeToLog

	New(var/T, var/K)
		src.text = T
		src.lastKnownKey = K

	fire()
		..()

		var/logfile = "Data/Players/[lastKnownKey]/Logs/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log"
		var/log= "<hr>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]<br> [text]"
		text2file(log,logfile)
	var/lastKnownKey
	var/text




mob/proc
	SaveToEmoteLog(var/text)
		if(!(text||src)) return
		var/emote_logfile = "Data/Players/[src.lastKnownKey]/Logs/Emote_[src.real_name].log"
		var/log = "<br>Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")] [src] [text]"
		text2file(log,emote_logfile)
