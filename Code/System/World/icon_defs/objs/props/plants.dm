obj
	Props
		Plants
			Flammable = 1
			Plant12
				icon='Plants.dmi'
				icon_state="plant1"
				density=1
			Plant11
				icon='Plants.dmi'
				icon_state="plant2"
				density=1
			PlantAlien1
				icon='plants alien.dmi'
				icon_state="plant1"
				density=1
			PlantAlien2
				icon='plants alien.dmi'
				icon_state="plant2"
				density=1
			PlantAlien3
				icon='plants alien.dmi'
				icon_state="plant3"
				density=1
				New()
					src.pixel_x = rand(-6,6)
					src.pixel_y = rand(-6,6)
			Plant10
				icon='Plants.dmi'
				icon_state="plant3"
				density=1
			Plant16
				icon='roomobj.dmi'
				icon_state="flowers"
			Plant15
				icon='roomobj.dmi'
				icon_state="flowers2"
			Plant2
				icon='Turf3.dmi'
				icon_state="plant"
				density=1
			Plant3
				icon='turfs.dmi'
				icon_state="groundplant"
			Plant4
				icon='Turf2.dmi'
				icon_state="plant2"
			Plant5
				icon='Turf2.dmi'
				icon_state="plant3"
			Plant13
				icon='turfs.dmi'
				icon_state="bush"
			Plant14
				icon='Turfs 1.dmi'
				icon_state="frozentree"
				density=1
			Plant18
				icon='Trees.dmi'
				icon_state="Dead Tree1"
				density=1
			Plant6
				icon='Turfs1.dmi'
				icon_state="1"
				density=1
			Plant20
				icon='Turfs1.dmi'
				icon_state="2"
				density=1
			Plant19
				icon='Turfs1.dmi'
				icon_state="3"
				density=1
			Plant7
				icon='Trees.dmi'
				icon_state="Tree1"
				density=1
			Plant8
				icon='Turfs 1.dmi'
				icon_state="smalltree"
				density=1
			Plant9
				icon='Turfs 2.dmi'
				icon_state="treeb"
				density=1
			Flowers
				icon='Turf 52.dmi'
				icon_state="flower bed"
			Cabbages
				icon='PlantsCabbage.dmi'
			BigHousePlant
				density=1
				icon='Turf 52.dmi'
				icon_state="plant bottom"
				New()
					var/image/A=image(icon='Turf 52.dmi',icon_state="plant top",pixel_y=32,pixel_x=0,layer=50)
					overlays.Remove(A)
					overlays.Add(A)

			TallBush
				density=1
				icon='Turf3.dmi'
				icon_state="tallplantbottom"
				density=1
				New()
					var/image/A=image(icon='Turf3.dmi',icon_state="tallplanttop",pixel_y=32,layer=50)
					overlays.Remove(A)
					overlays.Add(A)
