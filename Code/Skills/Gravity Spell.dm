obj/GravityWell
	Health=1.#INF
	Savable=0
	Grabbable=0
	var/tmp/Grav_Setting = 1
	proc/GravityGen()
		var/image/I=image(icon='GSpell.dmi',layer=MOB_LAYER-1)
		for(var/turf/G in range(2,src))
			G.overlays.Remove(I,'GSpell.dmi',I)
			if(Grav_Setting>1)
				G.overlays+=I
				G.Gravity=Grav_Setting
	/*	spawn(7500)
			for(var/turf/G in view(2,src))
				G.overlays.Remove(I,'GSpell.dmi',I)
				G.Gravity=0
			del(src)*/
	New()
		..()
		spawn(10)GravityGen()
		spawn(12000) del(src)
	Del()
		var/image/I=image(icon='GSpell.dmi',layer=MOB_LAYER-1)
		for(var/turf/G in range(3,src))
			G.overlays.Remove(I,'GSpell.dmi',I)
			G.Gravity=0
		view(src)<<"The Gravity Well has expired."
		..()

	layer=MOB_LAYER+5


Skill/Spell
	Experience=100
	Gravity_Well
		desc="This will create a well of gravity that can be used for training. Lasts about 45 minutes."
		verb/Gravity_Well()
			set category = "Skills"
			if(usr.RPMode) return
			//if(!usr.CanAttack(1,src)) return
			if(usr.Magic_Level >= 10)
				var/Cost = 90000
				var/Actual = round(initial(Cost)/usr.Magic_Potential)*(1-(0.15*usr.HasDeepPockets))
				usr << "Base cost for this spell is [Commas(Cost)] mana per level. Your magic potential means it costs [Commas(Actual)] mana per level for you."
				var/Grav=input("Gravity Multiplier: Costs [Actual] mana per 1x  (Your Limit is [(usr.Magic_Level-50)*6])") as num
//				if(Grav>GravLimit) Grav=GravLimit
				if(Grav>(usr.Magic_Level-50)*6) Grav=(usr.Magic_Level-50)*6
				if(Grav<1) Grav=1
				if(!Grav) Grav=1
				if(Grav<=1) return
				Grav=round(Grav)
				Actual*=Grav
				for(var/obj/Mana/M in usr) if(M.Value > Actual) if(usr.Confirm("Make a [Grav]x Gravity Well for [Actual] mana?"))
					M.Value -= Actual
					view(src)<<"[usr] creates a gravity well using magic! ([Grav]x)"
					var/image/I=image(icon='GSpell.dmi',layer=MOB_LAYER-1)
					for(var/turf/G in range(3,usr))
						G.overlays.Remove(I,'GSpell.dmi',I)
						G.Gravity=0
					var/obj/GravityWell/A=new
					A.Grav_Setting=Grav
					A.loc=usr.loc
					//spawn() A.GravityGen()
			else usr<<"You need more magic level."


