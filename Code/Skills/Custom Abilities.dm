
Skill/Misc/Leave_Planet/verb/Leave_Planet()
	set category="Other"
	CDOverride=7200
	if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
	if(usr.Ki<125) return
	var/lr = list(1,2,3,4,5,6,7,14,15)
	if(usr.z in lr)
		if(SpaceTravel == 0)
			usr << "You feel a force preventing you from leaving."
			return
		if(!usr.Confirm("Are you sure you want to use Leave Planet? (30 second delay and 2 hour cooldown)")) return
		if(usr.HasFlightMaster) CDOverride=1800
		CDTick(usr)
		usr<<"Leaving in 30 seconds."
		spawn(300)
			Liftoff(usr)
			spawn(10) if(usr.z!=12) usr.z=12
	else usr<<"You may not Leave Planet from here."


//obj/Restore_Planet/

proc/Shockwave(mob/Origin,Range=7,Icon='Shockwave.dmi')
	for(var/turf/T in range(Range,Origin)) missile(Icon,Origin,T)

mob/proc/Screen_Shake(Amount=10,Offset=8) if(client)
	while(Amount)
		Amount-=1
		client.pixel_x=rand(-Offset,Offset)
		client.pixel_y=rand(-Offset,Offset)
		sleep(1)



/*Skill/Support/Send_Energy
	Experience=100
	var/tmp/Active
	verb/Send_Energy()
		set category="Skills"
		if(usr.RPMode) return
		if(Active) Active=0
		else
			var/list/Choices=new
			Choices+="Cancel"
			for(var/mob/P in view(10,usr)) if(P.client&&P!=usr) Choices+=P
			var/mob/P=input(usr,"Choose who to send energy to") in Choices
			if(!P||P=="Cancel") return
			Active=1
			spawn while(P&&Active&&!usr.RPMode)
				if(!Active) return
				missile('Spirit.dmi',usr,P)
				usr.RecovMult/=2
				sleep(1)
			spawn while(P&&Active&&!usr.RPMode)
				if(!Active) return
				if(usr.Ki>usr.MaxKi*0.01)
					usr.Ki=max(0,usr.Ki-usr.MaxKi*0.01)
					P.Ki+=usr.MaxKi*0.01
				else
					Active = 0
				if(usr.Health>=10)
					usr.Health-=1
					P.Health+=0.5
				else
					Active = 0
				sleep(10)
				*/


mob/var/RecentSendEnergy/*
Skill/Support/Send_Energy
	UB2="Channel"
	UB1="Arcane Power"
	Tier=3
	desc="Using this will cause you to send a continous stream of energy from you to your target.  It will heal them a small amount and drain your HP and energy as it goes."
	Experience=100
	var/tmp/Active
	verb/Send_Energy()
		set category="Skills"
		if(usr.RPMode) return
		if(Active) Active=0
		else
			var/list/Choices=new
			Choices+="Cancel"
			for(var/mob/P in view(10,usr)) if(P.client&&P!=usr) Choices+=P
			var/mob/P=input(usr,"Choose who to send energy to") in Choices
			if(!P||P=="Cancel") return
			Active=1
			spawn while(P&&Active&&!usr.RPMode&&!usr.KOd)
				if(!Active) return
				missile('Spirit.dmi',usr,P)
				sleep(2)
			spawn while(P&&Active&&!usr.RPMode&&!usr.KOd)
				if(!Active) return
				if(usr.Ki>usr.MaxKi*0.05)
					usr.DrainKi("Send Energy", "Percent", 1,show=1)
					P.Ki+=usr.MaxKi*0.01
				else Active = 0
				if(usr.Health>=10)
					usr.TakeDamage(usr, 0.5, "Sending Energy to [P]")
					P.HealDamage("Send Energy", 1)
				else Active = 0
				if(usr.icon_state=="Meditate") Active=0
				sleep(10)
			usr.RecentSendEnergy=300
*/

Skill/Support/Send_Energy
	UB2="Channel"
	UB1="Arcane Power"
	Tier=3
	desc="Using this will cause you to send a continous stream of energy from you to your target.  It will heal them a small amount and drain your HP and energy as it goes."
	Experience=100
	var/tmp/Active
	verb/Send_Energy()
		set category="Skills"
		if(usr.RPMode) return
		if(Active) Active=0
		else
			var/list/Choices=new
			Choices+="Cancel"
			for(var/mob/P in view(10,usr)) if(P.client&&P!=usr) Choices+=P
			var/mob/P=input(usr,"Choose who to send energy to") in Choices
			if(!P||P=="Cancel") return
			Active=1
			spawn while(P&&Active&&!usr.RPMode&&!usr.KOd)
				if(!Active) return
				missile('Spirit.dmi',usr,P)
				sleep(2)
			spawn while(P&&Active&&!usr.RPMode&&!usr.KOd)
				if(!Active) return
				if(usr.Ki>usr.MaxKi*0.05)
					usr.DrainKi("Send Energy", "Percent", 1,show=1)//usr.Ki=max(0,usr.Ki-usr.MaxKi*0.01)
					P.Ki+=usr.MaxKi*0.01
				else Active = 0
				if(usr.Health>=10)
					usr.TakeDamage(usr, 0.5, "Sending Energy to [P]")
					P.HealDamage("Send Energy", 1)
				else Active = 0
				if(usr.icon_state=="Meditate") Active=0
				sleep(10)
			usr.RecentSendEnergy=300
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
