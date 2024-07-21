obj
	Props
		Chairs

			Throne_1
				icon='Throne 2.dmi'
				icon_state="white"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="white top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_2
				icon='Throne 2.dmi'
				icon_state="jade"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="jade top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_3
				icon='Throne 2.dmi'
				icon_state="pink"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="pink top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_4
				icon='Throne 2.dmi'
				icon_state="snow"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="snow top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_5
				icon='Throne 2.dmi'
				icon_state="evil"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="evil top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_6
				icon='Throne 2.dmi'
				icon_state="tie-dye2"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="tie-dye2 top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_7
				icon='Throne 2.dmi'
				icon_state="dragon"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="dragon top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_8
				icon='Throne 2.dmi'
				icon_state="gold"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="gold top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_9
				icon='Throne 2.dmi'
				icon_state="light blue"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="light blue top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_10
				icon='Throne 2.dmi'
				icon_state="bronze"
				New()
					var/image/A=image(icon='Throne 2.dmi',icon_state="bronze top",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_11
				icon='zzzz.dmi'
				icon_state="zarchair1"
				New()
					var/image/A=image(icon='zzzz.dmi',icon_state="zarchair4",pixel_y=32,layer=MOB_LAYER+1)
					overlays+=A
			Throne_12
				icon='New Throne.dmi'
				icon_state=""
				layer=3
			FancyCouch
				icon='Turf 52.dmi'
				icon_state="couch left"
				Flammable = 1
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Turf 52.dmi',icon_state="couch left",pixel_x=-16)
					var/image/B=image(icon='Turf 52.dmi',icon_state="couch right",pixel_x=16)
					overlays.Remove(A,B)
					overlays.Add(A,B)
			chair
				icon='turfs.dmi'
				icon_state="Chair"
				Flammable = 1


