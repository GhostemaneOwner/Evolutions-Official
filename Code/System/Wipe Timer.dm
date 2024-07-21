
var/global
	WipeUpTimer=0 //saved in SaveScalingPower
	LastGainsTick=0
proc/TimerLoop()//tracks each 6 second interval
	set background=1
	set waitfor=0
	if(!WipeUpTimer)WipeUpTimer=0
	while(1)
		sleep(60)//6 seconds, 10 per minute, 600 per hour/xp check
		WipeUpTimer++
		//world<<"DEBUG timer tick"
		if(WipeUpTimer>LastGainsTick+600) GainsTrackerTick()


mob/var
	XP=0
	TotalXP=0
	SpentXP=0

	MinutesOnline=0
	MinutesOffline=0

	LastMinute=0//WipeUpTimer value of last recorded online minute
	LastXPReward=0//value of MinutesOnline at the last reward
	TotalOfflineRewards=0
	LogOffWipeTimer//used to keep track of hours online
/*
mob/verb/SeeXPvars()
	set category="XP Testing"
	src<<{"
MinutesOnline [MinutesOnline]
MinutesOffline [MinutesOffline]
LastMinute [LastMinute]

LastXPReward [LastXPReward]
TotalOfflineRewards [TotalOfflineRewards]
LogOffWipeTimer [LogOffWipeTimer]
"}

mob/verb/MoveWipeTracker()
	set category="XP Testing"
	WipeUpTimer+=600
	src<<"Wipe Up timer moved forward 1 hour."
mob/verb/GiveOfflineTime()
	set category="XP Testing"
	MinutesOffline+=600
	src<<"Added 10 hours to offline time."
mob/verb/GiveOnlineTime()
	set category="XP Testing"
	MinutesOnline+=600
	src<<"Added 10 hours to online time."
mob/verb/LoseXP()
	XP=0
	TotalXP=0
	SpentXP=0
	LastXPReward=0
	LastMinute=0

*/
mob/proc
	getOnlineMinutes()
		//src<<"Checked minutes"
		if(LastMinute+10<(WipeUpTimer))//assigns minutes of play
			MinutesOnline++
			LastMinute=WipeUpTimer
			if(MinutesOnline> LastXPReward+59) //more than 59 minutes since last reward
				getXPReward(1,0)

	getOfflineMinutes()
		var/x = round(((WipeUpTimer-LogOffWipeTimer)/10),1)//assigns minutes logged off
		if(x<0) x=0
		MinutesOffline+=x
		if(round(MinutesOffline/60,1)>TotalOfflineRewards)//hours offline less than OfflineRewards
			var/Checks=round(MinutesOffline/60,1)-TotalOfflineRewards
			getXPReward(Checks,1)

	getXPReward(var/TimesChecked=1,var/offline=0)
		var/OfflineGiven
		var/OfflineCatchUp
		while(TimesChecked>0)

			if(TotalXP<round((WipeUpTimer/600),1)*XPRate)//if total xp is less than server maximum xp by more than 1 rewards
				TotalXP+=XPRate
				XP+=XPRate
				if(offline==0)
					LastXPReward=MinutesOnline
					src<<"You have been logged in for [round(MinutesOnline/60,1)] hours total. XP reward earned."
				else
					TotalOfflineRewards++
					OfflineGiven++



			if(TotalXP+XPRate<round((WipeUpTimer/600),1)*XPRate)//if total xp is less than server maximum xp by more than 2 rewards
				TotalXP+=XPRate
				XP+=XPRate
				if(offline==0)
					src<<"Catch up XP reward earned."
					LastXPReward=MinutesOnline
				else  OfflineCatchUp++

			TimesChecked--
		LogOffWipeTimer=0
		if(OfflineGiven>0) src<<"[OfflineGiven] hours of offline XP reward earned.[OfflineCatchUp>0?" [OfflineCatchUp] catch up rewards.":""]"
