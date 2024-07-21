#define SWIMMING

/mob/proc
	RemoveWaterOverlay()
		var/list/icon_states=list("1","2","3","4","5","6","7","8","9","10","11","12","waterfall")
		for(var/x in icon_states)
			overlays-=image('WaterOverlay.dmi',"[x]",layer=9,pixel_x=src.pixel_x,pixel_y=src.pixel_y)

	goSwimming(var/watertype = "Water")
		var/swimOverlay
		var/mob/grabbedPlayer
		if(GrabbedMob && ismob(GrabbedMob)&& isGrabbing==1) // If the player is holding someone ..
			grabbedPlayer=GrabbedMob
			if(grabbedPlayer.client) // If it has a client, it must be a player.
				if(!grabbedPlayer.Flying) // If this player is NOT flying
					grabbedPlayer.goSwimming(watertype) // Then they're being dragged (face first) across the ocean floor.
		switch(watertype)
			if("Water")
				swimOverlay = "6"
			if("WaterReal")
				swimOverlay = "4"
			if("Water5")
				swimOverlay = "5"
			if("WaterFall")
				swimOverlay = "waterfall"
			if("Water3")
				swimOverlay = "3"
			if("WaterFast")
				swimOverlay = "4" // Need a custom one for this actually
			if("Water8")
				swimOverlay = "8"
			if("Water1")
				swimOverlay = "1"
			if("Water11")
				swimOverlay = "11"
			if("Water7")//lava
				swimOverlay = "7"
			if("Water2")
				swimOverlay = "2"
			if("Water12")
				swimOverlay = "12"
			if("Water9")
				swimOverlay = "9"
			if("Water10")
				swimOverlay = "10"

		overlays += image('WaterOverlay.dmi', "[swimOverlay]",layer=9,pixel_x=src.pixel_x,pixel_y=src.pixel_y)
		isSwimming = 1
		checkSwimming()


	checkSwimming() // This is a recursive proc. Checks if they're swimming, drains energy, adds skill, repeat
		set waitfor=0
	//	var/rolldice = roll("1d6") // I just felt like using dice

		if(!istype(loc,/turf/Terrain/Water)) // If the terrain they're on is NOT water
			isSwimming = 0 // Then they're not swimming. (this proc takes care of the rest)
			RemoveWaterOverlay()

		while(isSwimming == 1)
			if(!KOd && !Flying)
				var/swimdrain = (MaxKi*3)/(swimSkill)
				if(swimdrain > (MaxKi/3) ) // If the drain is above 50% of the maxKi of a user.
					swimdrain = MaxKi/3 // Then put it back to 50%
				if(MaxKi < 100 && swimdrain > 10) // 100 and no drain higher than the maxki for a grace
					swimdrain = 10 // It's so players have a small 'grace period' before the salty deathtrap kicks in hard.
				else if(Ki > swimdrain && !KOd)
					Ki -= swimdrain
					if(swimSkill < 2000) // 2k = no drain
						if(prob(10))
							src.swimSkill += 10
							src << "Swimming Skill Gain(+10)"//debug use
						else if(prob(15))
							src.swimSkill += 5
							src << "Swimming Skill Gain!(+5)"//debug use

					StatGains(Rate=1,Energy=1,Might=0,Endurance=0,Speed=0,Offense=0,Defense=0)//for some energy gains

					if(istype(loc,/turf/Terrain/Water/Water7)) // in lava
						if(Race != "Demon" ) // Lava don't hurt Demons
							swimHealthDown(10) // Lava does more damage than  just drowning, but only by a little.

					if(!istype(loc,/turf/Terrain/Water))
						isSwimming = 0
						RemoveWaterOverlay()
//Drowning
				else
					if(Ki <= 0 || swimdrain >= Ki)
						KO("drowning")//we knock them out

			else
				if(Flying)
					RemoveWaterOverlay()
					isSwimming = 0
				if(KOd==1) swimHealthDown()//

			sleep(15) // Call itself again after 1.5 seconds



	swimHealthDown(lava=0)
		if(!lava) if(!BreathInSpace&&!RPMode&&!Vampire)
			view(src)<<"[src] is drowning!"
			BPDamage("drowning", 0.1)
			Injure_Hurt(0.1,"Throat","Water!")
		else
			view(src)<<"[src] is being burned by the lava!"
			BPDamage("lava",rand(1,3))

