


obj/items
	var
		Durability=100
		MaxDurability=100

	proc/DurabilityCheck(mob/user)
		if(Durability>1) if(prob(10))
			Durability--
		if(Durability<=1||Health<=1)
			user<<"[src] is broken."
			if(istype(src,/obj/items/Sword))user.SwordRemove()
			if(istype(src,/obj/items/Hammer))user.HammerRemove()
			if(istype(src,/obj/items/Gauntlets))user.GlovesRemove()
			if(istype(src,/obj/items/Armor))user.ArmorRemove()

			if(istype(src,/obj/items/Boxing_Gloves))
				suffix=null
				var/image/_overlay = image(icon) // not sure if the equipped thing is an icon/object so
				_overlay.pixel_x = pixel_x
				_overlay.pixel_y = pixel_y
				_overlay.layer= layer
				user.overlays -= _overlay
				user<<"[src] falls apart."
				del(src)

	proc/EquipmentDescAssign()
		if(istype(src,/obj/items/Armor))
			var/obj/items/Armor/A=src
			A.desc="<br>[Commas(A.Health)] Health Armor. Wearing it will trade [A.Spd*100]% Speed for [A.End*100]% Endurance. (Armor Mastery adds +7% End)."
			if(A.KineticBarrier) A.desc="<br>[Commas(A.Health)] Health Armor. Wearing it will trade [A.Spd*100]% Speed for [A.End*100]% Endurance and [A.KineticBarrier+100]% BP towards endurance calculations. (Armor Mastery adds +7% End)."
			if(AvoidsCrits)A.desc+="<br> This armor will block critical strikes[AvoidsCrits>1?" and prevent weapon energy drain.":"."]"

		if(istype(src,/obj/items/Gauntlets))
			var/obj/items/Gauntlets/A=src
			A.desc="<br>+[Commas(A.Health)] BP to each melee attack. However this bonus cannot exceed +[A.MaxBPAdd]% your own BP. Can be enchanted to enhance your power."
			if(CanCrit)A.desc+="<br>This weapon will sometimes score critical strikes[CanCrit>1?" and drain energy.":"."]"

		if(istype(src,/obj/items/Hammer))
			var/obj/items/Hammer/A=src
			A.desc="<br>+[Commas(A.Health)] BP to each melee attack. However this bonus cannot exceed +[A.MaxBPAdd]% your own BP. [A.Spd*100]% Speed and [A.Off*100]% Offense."
			if(CanCrit)A.desc+="<br>This weapon will sometimes score critical strikes[CanCrit>1?" and drain energy.":"."]"

		if(istype(src,/obj/items/Sword))
			var/obj/items/Sword/A=src
			A.desc="<br>+[Commas(A.Health)] BP to each melee attack. However this bonus cannot exceed +[A.MaxBPAdd]% your own BP, reduces your Offense to [A.Off*100]%."
			if(CanCrit)A.desc+="<br>This weapon will sometimes score critical strikes[CanCrit>1?" and drain energy.":"."]"

