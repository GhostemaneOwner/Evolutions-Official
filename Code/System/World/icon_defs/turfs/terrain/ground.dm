turf/Terrain
	Ground

		Lava
			icon='turfs.dmi'
			icon_state="lava"
	//		luminosity=2
			Water=1
			Enter(mob/M)
				if(ismob(M)) if(M.Flying|!M.density) return ..()
				else return ..()

		GroundDirtSand
			icon='Turfs 96.dmi'
			icon_state="dirt"
		GroundDirt
			icon='Future_Tilesheet_1.dmi'
			icon_state="Ground1"
		//	edge_weight=5
			         //icon_state="Dirt"
		Ground4
			icon='Turfs 12.dmi'
			icon_state="desert"
		Ground10
			icon='Turf1.dmi'
			icon_state="light desert"
		GroundFire
			icon='FireFloor.dmi'
		Ground17
			icon='Turfs1.dmi'
			icon_state="dirt2"
		GroundIcy
			icon='IceFloor.dmi'
		GroundMoss
			icon='MossFloor.dmi'
			Flammable = 1
		GroundIce
			icon='Turf 57.dmi'
			icon_state="8"
		GroundIce2
			icon='Turf 55.dmi'
			icon_state="ice"
		GroundSnow
			icon='Turf Snow.dmi'
		//	edge_weight=4
		Ground18
			icon='turfs.dmi'
			icon_state="hellfloor"
		GroundMoon
			icon='Turf 50.dmi'
			icon_state="moon"
		GroundAlien
			icon='Turf 50.dmi'
			icon_state="strange ground"
		Ground19
			icon='Turfs 96.dmi'
			icon_state="darktile"
		GroundIce3
			icon='Turfs 12.dmi'
			icon_state="ice"
		GroundHell
			icon='Turf 57.dmi'
			icon_state="hellturf1"
		Ground16
			icon='FloorsLAWL.dmi'
			icon_state="Flagstone"
		Ground12
			icon='Turfs 1.dmi'
			icon_state="dirt"
		/*Ground13
			icon='Turfs 1.dmi'
			icon_state="rock"
			density=1*/
		GroundPebbles
			icon='Turfs 7.dmi'
			icon_state="Sand"
		/*Ground11
			icon='Turfs 1.dmi'
			icon_state="crack"
			density=1*/
		GroundSandDark
			icon='Turf1.dmi'
			icon_state="dark desert"
			density=0
		Ground3
			icon='Turf1.dmi'
			icon_state="very dark desert"                      //icon_state="very dark desert"
			density=0



		Urban_Sidewalk
			icon='Sidewalk.dmi'
			icon_state=""
		Urban_Street
			icon='Street.dmi'
			icon_state=""
		Urban_Street_Crack_Variant_1
			icon='Street.dmi'
			icon_state="crack1"
		Urban_Street_Crack_Variant_2
			icon='Street.dmi'
			icon_state="crack2"
		Urban_Street_Crack_Variant_3
			icon='Street.dmi'
			icon_state="crack3"
		Urban_Street_Crack_Variant_4
			icon='Street.dmi'
			icon_state="crack4"
		Urban_Street_Crack_Variant_5
			icon='Street.dmi'
			icon_state="crack5"
		Urban_Street_Crack_Variant_6
			icon='Street.dmi'
			icon_state="crack6"
