atom
	proc
		Burn(var/H,originHP)
			H=Health
			var/orgHealth = 0
			var/rate = 100 
			//Xiathyl Note: Adjust this number up or down to change amount of burn damage taken per tick. 
			//50 = 2% of Total HP per tick
			//100 = 1% of Total HP per tick
			//200 = 0.5% of Total HP per tick
			if (!originHP)
				orgHealth = H
			else
				orgHealth = originHP
			if(src.Burning)
				for(var/atom/A in range(0,src))
					if(A.Burning) if(A != src)
						src.Burning = 0
						return
				if(isobj(src))
					src.overlays -= 'fire obj.dmi'
					src.overlays -= 'large fire.dmi'
					if(prob(!H)) src.overlays += 'fire obj.dmi'
					else src.overlays += 'large fire.dmi'
					if(Smokes < 100) SmokeEffect(src)
				if(isturf(src))
					src.overlays -= 'fire turf.dmi'
					src.overlays -= 'large fire.dmi'
					src.overlays += 'fire turf.dmi'
					if(Smokes < 100) SmokeEffect(src)

				if(H)
					var/dmg = orgHealth / rate
					//var/dmgpc = (dmg/orgHealth *100)
					//usr <<("HP: [H]/[orgHealth], [dmgpc]% of total HP lost.") // Debug Text
					src.TakeDamage(src, dmg, "Fire")
				if(src.Health <= 0)
					if(isobj(src))
						Ash(src)
						del(src)
					if(isturf(src))
						src.overlays -= 'fire turf.dmi'
						new /turf/Terrain/Ground/Ground17(src)
			spawn(5) if(src) src.Burn(H,orgHealth) //Default tick is 5
