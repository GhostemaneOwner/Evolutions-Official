mob/var/Super_Bebi_event
mob/var/Super_Bebi_Clicks
obj/Super_Bebi
    desc="You don't care anymore and would rather use Destruction energy to fight for you, You become Almost Untouchable but at the cost of your life"
    verb/Super_Bebi()
        set category="Skills"
        if(!Using)
            if(isnull(usr.Super_Bebi_event))
               // usr.Ego_event = new(skills_scheduler, usr)
                skills_scheduler.schedule(usr.Super_Bebi_event, 20)
                usr.Super_Bebi_Clicks += 1
                Using=1
                view(usr)<<"[usr] is overwhelmed with Destruction Energy as they unlock there Ultra Ego!"
                for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] begins Egoing their energy.\n")
                usr.BP=12
                usr.End=30
                usr.Str=30
                usr.Def=2
                usr.DefMod=1.5
                usr.BaseRegeneration/=10
     //   else {usr.Cancel_Ego()}

mob/proc/Super_Bebi_Revert() for(var/obj/Super_Bebi/A in src) if(A.Using)
    A.Using=0
    view(src)<<"[src] releases there Super Bebi Form!"
    for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] stops Egoing their energy.\n")
    BP/=12
    usr.End/=30
    usr.Str/=30
    Def/=2
    DefMod/=1.5
    BaseRegeneration=10

Skill/Attacks
	BlueCometSpecial
		UB1="Godspeed"
		UB2="Fists of Fury"
		var/On=0
		var/tmp/Blue_Comet_Special=0
		desc="This attack causes you to summon several split forms around target location that then dash towards your target and attack. Deals damage based on speed."
		Experience=0
		Level=3
		Tier=4
		verb/Ki_Settings()
			set category="Other"
			var/Max=round(Experience/10)
			if(Max>6) Max=6
			Level=input("This will increase the attack radius. Current is [Level]. Minimum is 3. Max is [Max]") as num
			if(Level<3) Level=3
			if(Level>Max) Level=Max
			Level=round(Level)
		verb/Blue_Comet_Special()
			set category="Skills"
			if(!On)
				usr<<"Blue Comet Special activated, click the ground to trigger."
				On=1
			else
				usr<<"Blue Comet Special deactivated."
				On=0
		verb/Teach(mob/player/A in view(usr))
			set category="Other"
			Teachify(usr,A,"Ki")

obj/ranged/Blast/BCS
	density=1
	