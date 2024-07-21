//obj/var/Grabbable

obj/items/Security_Monitor
	icon='Monitor.dmi'
	Health=1000
	Grabbable=1
	density=1
	desc="You've discovered the worlds greatest time waster!"
	Frequency="TV"
	Savable = 1
	verb/Frequency()
		set category="Other"
		set src in view(1)
		if(Frequency!="TV") if(!usr.Confirm("Change the channel?")) return
		Frequency=input("Choose a frequency. This will let you watch cameras on that frequency. Default is TV") as text
		if(Frequency == "Communication Matrix") //if(usr.AS_Droid == 0)
			usr << "This Frequency seems to be entirely blocking off your access."
			Frequency = "1"
	verb/Tune_In()
		set category="Other"
		set src in view(1)
		if(Frequency) //if(src in view(usr))
			var/Choices=list("Cancel")
			for(var/obj/items/Security_Camera/SC in world) if(SC.Frequency==src.Frequency) Choices+=SC
			var/VC=input(usr, "Choose a camera to view on this frequency") in Choices
			if(VC!="Cancel")
				usr.reset_view(VC)
				usr << "Now viewing [VC]. Click the camera to reset your view."
	verb/Bolt()
		set src in oview(1)
		if(x&&y&&z&&!Bolted)
			Bolted=1
			Shockwaveable=0
			range(20,src)<<"[usr] bolts the [src] to the ground."

			return
		if(Bolted) if(src.Builder=="[usr.real_name]")
			range(20,src)<<"[usr] unbolts the [src] from the ground."
			Bolted=0
			Shockwaveable=1
			return
			