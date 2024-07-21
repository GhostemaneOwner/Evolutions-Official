turf/Terrain
	Sky
		Sky1
			icon='Misc.dmi'
			icon_state="Sky"
	//		luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying|!M.density) return ..()
				else return ..()
		Sky2
			icon='Misc.dmi'
			icon_state="Clouds"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying|!M.density) return ..()
				else return ..()
/*		Sky3
			icon='Misc.dmi'
			icon_state="Clouds"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying) M.loc=locate(M.x,1,8)
				return ..()*/
		Sky4
			icon='Misc.dmi'
			icon_state="Clouds"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying) M.loc=locate(M.x,235,10)
				return ..()
		Sky5
			icon='NewTurfs.dmi'
			icon_state="56"
			Buildable=0
    //        luminosity=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying) M.loc=locate(min(243,M.x),223,11)
				return ..()

		RingOutSensor
			icon='Indoor Tiles.dmi'
			icon_state="Kitchen Tile"
			var/RCD=0
			Entered(mob/A)
				if(!RCD&&ismob(A))
					view(A)<<"[A] ring out."
					RCD=1
				spawn(120) RCD=0
				..()


	Majin
		Wall1
			icon='Majin_Walls.dmi'
			icon_state="Wall1"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Wall2
			icon='Majin_Walls.dmi'
			icon_state="Wall2"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Wall3
			icon='Majin_Walls.dmi'
			icon_state="Wall3"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Wall4
			icon='Majin_Walls.dmi'
			icon_state="Wall4"
			Health=100000000000000000000
			density=1
			opacity=1
			Enter(atom/A)
				if(FlyOverAble||ghostDens_check(A)||(!A.density&&istype(A,/obj/items/Bomb))) return ..()
				else return
		Floor
			icon='Majin_Walls.dmi'
			icon_state="Floor"
		Stairs
			icon='Majin_Walls.dmi'
			icon_state="Stairs"
		BigCrater
			icon='Craters.dmi'
			icon_state="Center"
			Health=1.#INF
