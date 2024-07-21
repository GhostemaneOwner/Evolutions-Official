#ifndef SWIMMING
#warn swimming.dm file is NOT included. It's in the Mob folder. Please include it. =)
#endif

turf/Terrain
	Water
		var/HasFresh=0
		var/tmp/HasFish=0
		var/timer
		New()
			..()
			GenerateFish()
		proc/GenerateFish()
			if(prob(3) && !HasFish)
				timer=((600*Year_Speed)*4) // Lasts a month in-game
				HasFish=1
				overlays+='Whirlpool.dmi'
				spawn(timer)
					HasFish=0
					overlays=null
		Entered(mob/M)
			if(ismob(M))  // If they're a mob
				if(M.Flying|!M.density)  return ..() // And they're flying or not dense, let them go through water.
				else
					if(istype(M,/mob/player))
						if(M.isSwimming==0)
							spawn() M.goSwimming(src.name) // If they're a player, THEY GO SWIMMING. Send the name of the turf along so it can assign the proper overlay.
							return ..()
						else
							return ..()
			else return ..()
		verb
			Collect_Water()
				set src in view(1)
				if(!usr.KOd)
					if(src.HasFresh&&src.z==2)
						var/obj/items/Fresh_Water/W = new/obj/items/Fresh_Water
						W.loc = usr
						usr << "You gather some fresh water!"
						return
					else
						var/obj/items/Salt_Water/W = new/obj/items/Salt_Water
						W.loc = usr
						usr << "You gather some salt water!"
						return

			Fish()
				set src in view(1)
				if(src.HasFish&&!usr.IsFishing&&!usr.IsMining&&!usr.IsCooking&&!usr.KOd)
					var/HasBoost=0
					if(locate(/obj/items/Anglers_Lure) in usr) HasBoost=15
					var/obj/items/rawfood/ResultingFish=/obj/items/rawfood/Small_Fish
					if(usr.Fishing_Level+HasBoost>10&&prob(usr.Fishing_Level))ResultingFish=/obj/items/rawfood/Medium_Fish
					else if(usr.Fishing_Level+HasBoost>30&&prob(usr.Fishing_Level))ResultingFish=/obj/items/rawfood/Large_Fish
					else if(usr.Fishing_Level+HasBoost>40&&prob(usr.Fishing_Level-30))ResultingFish=/obj/items/rawfood/Crab
					else if(usr.Fishing_Level+HasBoost>50&&prob(usr.Fishing_Level))ResultingFish=/obj/items/rawfood/Baby_Shark
					else if(usr.Fishing_Level+HasBoost>15&&prob(5))ResultingFish=/obj/items/rawfood/Mana_Fish
					else if(usr.Fishing_Level+HasBoost>15&&prob(5))ResultingFish=/obj/items/rawfood/Gold_Fish
					else if(usr.Fishing_Level+HasBoost>25&&prob(0.5))ResultingFish=/obj/items/rawfood/BP_Fish
					else if(usr.Fishing_Level+HasBoost>25&&prob(0.5))ResultingFish=/obj/items/rawfood/Energy_Fish
					else if(usr.Fishing_Level+HasBoost>25&&prob(0.5))ResultingFish=/obj/items/rawfood/Stat_Fish
					else if(usr.Fishing_Level+HasBoost>40&&prob(0.5))ResultingFish=/obj/items/rawfood/Magic_Fish
					view(usr)<<"[usr] starts to fish in [src]."
					var/R=rand(1,1000)
					usr.IsFishing=R
					var/FishSpeed=rand(300,600)
					var/CookSpeed=rand(300,600)
					var/usingrod=0
					var/cansmelt=0
					for(var/obj/items/fishingpole/FP in usr)
						if(istype(FP,/obj/items/fishingpole/Old_Rod))
							if(usingrod < 1)
								usingrod = 1
								if(FP.autosmelt)
									cansmelt=FP.autosmelt
									FishSpeed=((rand(300,600))-75) + (CookSpeed-(CookSpeed*cansmelt))
								else
									FishSpeed=(rand(300,600))-75
						if(istype(FP,/obj/items/fishingpole/Good_Rod))
							if(usingrod < 2)
								usingrod = 2
								if(FP.autosmelt)
									cansmelt=FP.autosmelt
									FishSpeed=((rand(300,600))-140) + (CookSpeed-(CookSpeed*cansmelt))
								else
									FishSpeed=(rand(300,600))-140
						if(istype(FP,/obj/items/fishingpole/Super_Rod))
							if(usingrod < 3)
								usingrod = 3
								if(FP.autosmelt)
									cansmelt=FP.autosmelt
									FishSpeed=((rand(300,600))-200) + (CookSpeed-(CookSpeed*cansmelt))
								else
									FishSpeed=((rand(300,600))-200)
					if(usr.Fishing_Level+HasBoost>=15) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=30) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=45) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=60) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=75) FishSpeed*=0.9
					if(usr.Fishing_Level+HasBoost>=90) FishSpeed*=0.9
					spawn(FishSpeed) if(src&&usr&&usr.IsFishing==R&&HasFish)
						if(prob(1))
							usr<<"You manage to find some tangled fishing line as well."
							usr.contents+= new /obj/items/ingredients/Fishing_Line
						var/XPG
						var/result
						if(cansmelt)
							var/obj/items/rawfood/A=new ResultingFish
							XPG=A.GivesXP
							ResultingFish=A.ResultingFood
							del(A)
							var/obj/items/cookedfood/B=new ResultingFish
							result=B.name
							usr.contents+=B
						else
							var/obj/items/rawfood/A=new ResultingFish
							XPG=A.GivesXP
							result=A.name
							usr.contents+=A
						if(usr.RestedTime>world.realtime)XPG*=1.5
						if(usr.InspiredTime>world.realtime)XPG*=1.5
						usr.Fishing_XP+=XPG
						if(cansmelt)
							usr.Cooking_XP+=XPG
							usr.CookingLevelCheck()
						if(usr.HasLiberalArtsDegree)
							usr.Int_XP+=(XPG/4)*usr.IntCapCheck(usr.Int_Level,usr.Int_Mod)
							usr.Magic_XP+=(XPG/4)*usr.IntCapCheck(usr.Magic_Level,usr.Magic_Potential)
						usr.FishingLevelCheck()
						usr.IsFishing=0
//						usr.InventoryCheck()
						view(usr)<<"[usr] has caught a [result]!"
						if(!prob(usr.Fishing_Level-10))
							src.HasFish=0
							src.overlays=null
							src.timer=null
							view(usr)<<"[usr] has scared away the fish."
		Water6
			icon='Turfs 1.dmi'
			icon_state="water"
			Water=1

		WaterReal
			icon='Turfs 96.dmi'
			icon_state="water1"
			Water=1

		Water5
			icon='Turfs 4.dmi'
			icon_state="kaiowater"
			Water=1

		LavaFall
			icon='LavaFall.dmi'
			density=1
			layer=MOB_LAYER+1
		WaterFall
			icon='Turfs 1.dmi'
			icon_state="waterfall"
			density=1
			layer=MOB_LAYER+1
			Water=1

		Water3
			icon='Misc.dmi'
			icon_state="Water"
			Water=1

		WaterFast
			icon='water.dmi'
			Water=1

		Water8
			icon='turfs.dmi'
			icon_state="nwater"
			Water=1
			HasFresh=1

		Water1
			icon='Turfs 12.dmi'
			icon_state="water3"
			Water=1

		Water11
			icon='Turfs 12.dmi'
			icon_state="water1"
			Water=1

		Water7
			icon='turfs.dmi'
			icon_state="lava"
	//		luminosity=2

		Water2
			icon='Turfs 96.dmi'
			icon_state="stillwater"
			Water=1

		Water12
			icon='Turfs 12.dmi'
			icon_state="water4"
			Water=1

		Water9
			icon='Turfs 12.dmi'
			icon_state="water1"
			Water=1

		Water10
			icon='Turf 50.dmi'
			icon_state="9.1"
			Water=1

		Water13
			icon='Waters.dmi'
			Water=1
			icon_state="13"

