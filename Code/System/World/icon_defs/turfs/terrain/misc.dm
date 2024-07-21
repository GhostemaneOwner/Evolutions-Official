turf/Terrain

	Misc
		MetalFloor
			icon='metaltiles1.dmi'
			icon_state="metalfloora"
		MetalFloorDirty
			icon='metaltiles1.dmi'
			icon_state="metalfloorsn"
		MetalFloorDark
			icon='metaltiles1.dmi'
			icon_state="metalfloorb"
		MetalGrating1
			icon='Future_Tilesheet_1.dmi'
			icon_state="Tile20"
		MetalGrating2
			icon='Future_Tilesheet_1.dmi'
			icon_state="Tile16"

		Bridge1V
			icon='Turf 50.dmi'
			icon_state="1.8"
		Bridge1H
			icon='Turf 50.dmi'
			icon_state="3.3"
		Bridge2V
			icon='Turf 57.dmi'
			icon_state="26"
		Bridge2H
			icon='Turf 57.dmi'
			icon_state="123"
		Bridge1V
			icon='Turf 50.dmi'
			icon_state="1.8"
		Bridge1H
			icon='Turf 50.dmi'
			icon_state="3.3"
		Bridge2V
			icon='Turf 57.dmi'
			icon_state="26"
		Bridge2H
			icon='Turf 57.dmi'
			icon_state="123"
		TechBridge_1_Vertical_Left
			icon='Future_Tilesheet_1.dmi'
			icon_state="2,11"
		TechBridge_1_Vertical_Right
			icon='Future_Tilesheet_1.dmi'
			icon_state="3,11"
		TechBridge_1_Horizontal_Bottom
			icon='Future_Tilesheet_1.dmi'
			icon_state="Tech_Bridge1_Horizontal"
		TechBridge_1_Horizontal_Top
			icon='Future_Tilesheet_1.dmi'
			icon_state="Tech_Bridge_1_Horizontal2"
		CaveEntrance
			icon='Turf 57.dmi'
			icon_state="13"

		MountainCave
			density=1
			icon='Turf1.dmi'
			icon_state="mtn cave"
			Buildable=0

		Orb
			icon='Turf1.dmi'
			icon_state="spirit"
			density=0
			Buildable=0
		Ladder
			icon='Turf1.dmi'
			icon_state="ladder"
			density=0
			Buildable=0

		Urban_Sidewalk_Top_Border
			icon='Sidewalk.dmi'
			icon_state="STop"

		Abyss
			icon='Hell turf.dmi'
			Water=1
			Buildable=0
			Enter(mob/M)
				if(ismob(M)) if(M.Flying||!M.density) return ..()
				else return ..()

		UndergroundTunnelable1
			icon='Turfs 4.dmi'
			icon_state="wall"
			density=1
			opacity=1
			FlyOverAble=0
			Buildable=0
			Health=100000
			Enter(mob/M)
				if(ismob(M))
					if(M.client && M.client.holder) return ..()
					else return

		Glass_Unflyable
			icon='Space.dmi'
			icon_state="glass1"
			density=1
			FlyOverAble=0
			Buildable=0
			layer=MOB_LAYER+1
			Health=1.#INF

		Paved_Road
			icon='Future_Tilesheet_1.dmi'
			icon_state="Road1"

		Paved_Road_With_White_Lines
			icon='Future_Tilesheet_1.dmi'
			icon_state="Road2"

		Paved_Road_With_White_Lines_2
			icon='Future_Tilesheet_1.dmi'
			icon_state="Road3"
		Paved_Road_Cross_Walk
			icon='Future_Tilesheet_1.dmi'
			icon_state="Road4"
		Paved_Road_Cross_Walk_2
			icon='Future_Tilesheet_1.dmi'
			icon_state="Road5"
