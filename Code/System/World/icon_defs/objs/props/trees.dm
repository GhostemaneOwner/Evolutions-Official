obj
	Props
		Trees
			Savable=0
			layer=4
			density=1
//			Spawn_Timer=180000
			Flammable = 1
			Dead_Tree_1
				icon='turfs66.dmi'
				icon_state="42"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='turfs66.dmi',icon_state="2",pixel_x=0,pixel_y=0,layer=layer)
					var/image/B=image(icon='turfs66.dmi',icon_state="3",pixel_x=-32,pixel_y=32,layer=MOB_LAYER+1)
					var/image/C=image(icon='turfs66.dmi',icon_state="42",pixel_x=0,pixel_y=32,layer=MOB_LAYER+1)
					var/image/D=image(icon='turfs66.dmi',icon_state="31",pixel_x=32,pixel_y=32,layer=MOB_LAYER+1)
					overlays.Add(A,B,C,D)
			Dead_Tree_2
				icon='turfs66.dmi'
				icon_state="d3"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='turfs66.dmi',icon_state="d1",pixel_x=0,pixel_y=0,layer=layer)
					var/image/B=image(icon='turfs66.dmi',icon_state="d2",pixel_x=-32,pixel_y=32,layer=MOB_LAYER+1)
					var/image/C=image(icon='turfs66.dmi',icon_state="d3",pixel_x=0,pixel_y=32,layer=MOB_LAYER+1)
					var/image/D=image(icon='turfs66.dmi',icon_state="d4",pixel_x=32,pixel_y=32,layer=MOB_LAYER+1)
					overlays.Add(A,B,C,D)
			Dark_Tree
				icon='turfs66.dmi'
				icon_state="treetopleft"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='turfs66.dmi',icon_state="treebotleft",pixel_x=-16,pixel_y=0,layer=layer)
					var/image/B=image(icon='turfs66.dmi',icon_state="treebotright",pixel_x=16,pixel_y=0,layer=layer)
					var/image/C=image(icon='turfs66.dmi',icon_state="treetopleft",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
					var/image/D=image(icon='turfs66.dmi',icon_state="treetopright",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
					overlays.Add(A,B,C,D)
			Strange_Pine
				icon='turfs66.dmi'
				icon_state="treelefttop1"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='turfs66.dmi',icon_state="treeleftbot1",pixel_x=-16,pixel_y=0,layer=layer)
					var/image/B=image(icon='turfs66.dmi',icon_state="treerightbot1",pixel_x=16,pixel_y=0,layer=layer)
					var/image/C=image(icon='turfs66.dmi',icon_state="treelefttop1",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
					var/image/D=image(icon='turfs66.dmi',icon_state="treerighttop1",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
					overlays.Add(A,B,C,D)
			Nice_Tree
				icon='turfs66.dmi'
				icon_state="treelefttop2"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='turfs66.dmi',icon_state="treeleftbot2",pixel_x=-16,pixel_y=0,layer=layer)
					var/image/B=image(icon='turfs66.dmi',icon_state="treerightbot2",pixel_x=16,pixel_y=0,layer=layer)
					var/image/C=image(icon='turfs66.dmi',icon_state="treelefttop2",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
					var/image/D=image(icon='turfs66.dmi',icon_state="treerighttop2",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
					overlays.Add(A,B,C,D)
			SmallPine
				icon='Turf 58.dmi'
				icon_state="2"
				density=1
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Turf 58.dmi',icon_state="1",pixel_y=0,pixel_x=-32,layer=50)
					var/image/B=image(icon='Turf 58.dmi',icon_state="0",pixel_y=-32,pixel_x=0,layer=50)
					var/image/C=image(icon='Turf 58.dmi',icon_state="3",pixel_y=32,pixel_x=-32,layer=50)
					var/image/D=image(icon='Turf 58.dmi',icon_state="4",pixel_y=32,pixel_x=0,layer=50)
					overlays.Remove(A,B,C,D)
					overlays.Add(A,B,C,D)
					new/obj/Props/Trees/LargePine(loc)
					del(src)

			RedTree
				density=1
				icon='Turf 55.dmi'
				icon_state="3"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Turf 55.dmi',icon_state="1",pixel_y=32,pixel_x=-32,layer=50)
					var/image/B=image(icon='Turf 55.dmi',icon_state="2",pixel_y=0,pixel_x=0,layer=50)
					var/image/C=image(icon='Turf 55.dmi',icon_state="3",pixel_y=32,pixel_x=32,layer=50)
					var/image/D=image(icon='Turf 55.dmi',icon_state="4",pixel_y=0,pixel_x=-32,layer=50)
					var/image/E=image(icon='Turf 55.dmi',icon_state="5",pixel_y=32,pixel_x=0,layer=50)
					var/image/F=image(icon='Turf 55.dmi',icon_state="6",pixel_y=0,pixel_x=32,layer=50)
					overlays.Remove(A,B,C,D,E,F)
					overlays.Add(A,B,C,D,E,F)

			Tall_Tree
				density=1
				icon='treee.dmi'
				icon_state="bottom"
				New()
					var/image/A=image(icon='treee.dmi',icon_state="top",layer=MOB_LAYER+1,pixel_y=32)
					overlays+=A

			Oak
				density=1
				icon='turfs.dmi'
				icon_state="3"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='turfs.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=50)
					var/image/B=image(icon='turfs.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=50)
					var/image/C=image(icon='turfs.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=50)
					var/image/D=image(icon='turfs.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=50)
					var/image/E=image(icon='turfs.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=50)
					var/image/F=image(icon='turfs.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=50)
					overlays.Remove(A,B,C,D,E,F)
					overlays.Add(A,B,C,D,E,F)

			RoundTree
				density=1
				icon='turfs.dmi'
				icon_state="03"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='turfs.dmi',icon_state="01",pixel_y=0,pixel_x=-16,layer=50)
					var/image/B=image(icon='turfs.dmi',icon_state="02",pixel_y=0,pixel_x=16,layer=50)
					var/image/C=image(icon='turfs.dmi',icon_state="03",pixel_y=32,pixel_x=-16,layer=50)
					var/image/D=image(icon='turfs.dmi',icon_state="04",pixel_y=32,pixel_x=16,layer=50)
					overlays.Remove(A,B,C,D)
					overlays.Add(A,B,C,D)

			Tree
				density=1
				icon='turfs.dmi'
				icon_state="bottom"
				New()
					var/image/B=image(icon='turfs.dmi',icon_state="middle",pixel_y=32,pixel_x=0,layer=50)
					var/image/C=image(icon='turfs.dmi',icon_state="top",pixel_y=64,pixel_x=0,layer=50)
					overlays.Remove(B,C)
					overlays.Add(B,C)

			Palm
				density=1
				icon='Trees2.dmi'
				icon_state="3"
				pixel_y=-32
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Trees2.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=5)
					var/image/B=image(icon='Trees2.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=5)
					var/image/C=image(icon='Trees2.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=5)
					var/image/D=image(icon='Trees2.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=5)
					var/image/E=image(icon='Trees2.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=5)
					var/image/F=image(icon='Trees2.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=5)
					var/image/G=image(icon='Trees2.dmi',icon_state="7",pixel_y=96,pixel_x=-16,layer=5)
					var/image/H=image(icon='Trees2.dmi',icon_state="8",pixel_y=96,pixel_x=16,layer=5)
					overlays.Remove(A,B,C,D,E,F,G,H)
					overlays.Add(A,B,C,D,E,F,G,H)



			LargePine
				density=1
				icon='Tree Good.dmi'
				icon_state="2"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Tree Good.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=5)
					var/image/B=image(icon='Tree Good.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=5)
					var/image/C=image(icon='Tree Good.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=5)
					var/image/D=image(icon='Tree Good.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=5)
					var/image/E=image(icon='Tree Good.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=5)
					var/image/F=image(icon='Tree Good.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=5)
					overlays.Remove(A,B,C,D,E,F)
					overlays.Add(A,B,C,D,E,F)

			LargePineSnow
				density=1
				icon='Tree GoodSnow.dmi'
				icon_state="3"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Tree GoodSnow.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=5)
					var/image/B=image(icon='Tree GoodSnow.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=5)
					var/image/C=image(icon='Tree GoodSnow.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=5)
					var/image/D=image(icon='Tree GoodSnow.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=5)
					var/image/E=image(icon='Tree GoodSnow.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=5)
					var/image/F=image(icon='Tree GoodSnow.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=5)
					overlays.Remove(A,B,C,D,E,F)
					overlays.Add(A,B,C,D,E,F)

			RedPine
				density=1
				icon='Tree Red.dmi'
				icon_state="3"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Tree Red.dmi',icon_state="1",pixel_y=0,pixel_x=-16,layer=50)
					var/image/B=image(icon='Tree Red.dmi',icon_state="2",pixel_y=0,pixel_x=16,layer=50)
					var/image/C=image(icon='Tree Red.dmi',icon_state="3",pixel_y=32,pixel_x=-16,layer=50)
					var/image/D=image(icon='Tree Red.dmi',icon_state="4",pixel_y=32,pixel_x=16,layer=50)
					var/image/E=image(icon='Tree Red.dmi',icon_state="5",pixel_y=64,pixel_x=-16,layer=50)
					var/image/F=image(icon='Tree Red.dmi',icon_state="6",pixel_y=64,pixel_x=16,layer=50)
					overlays.Remove(A,B,C,D,E,F)
					overlays.Add(A,B,C,D,E,F)

			NamekTree
				density=1
				icon='Trees Namek.dmi'
				icon_state="1 Top"
				New()
					icon=null
					icon_state=null
					switch(pick(1,2,3,4))
						if(1)
							var/image/A=image(icon='turfs.dmi',icon_state="nt2",pixel_y=32,layer=50)
							var/image/B=image(icon='turfs.dmi',icon_state="nt1")
							overlays.Add(A,B)
						if(2)
							var/image/A=image(icon='Trees Namek.dmi',icon_state="1 Bottom")
							var/image/B=image(icon='Trees Namek.dmi',icon_state="1 Middle",pixel_y=32)
							var/image/C=image(icon='Trees Namek.dmi',icon_state="1 Top",pixel_y=64)
							overlays.Add(A,B,C)
						if(3)
							var/image/A=image(icon='Trees Namek.dmi',icon_state="2.0")
							var/image/B=image(icon='Trees Namek.dmi',icon_state="2.1",pixel_y=32)
							var/image/C=image(icon='Trees Namek.dmi',icon_state="2.2",pixel_y=64)
							var/image/D=image(icon='Trees Namek.dmi',icon_state="2.3",pixel_y=64,pixel_x=32)
							overlays.Add(A,B,C,D)
						if(4)
							var/image/A=image(icon='Trees Namek.dmi',icon_state="1")
							var/image/B=image(icon='Trees Namek.dmi',icon_state="2",pixel_y=32)
							var/image/C=image(icon='Trees Namek.dmi',icon_state="3",pixel_y=64)
							var/image/D=image(icon='Trees Namek.dmi',icon_state="4",pixel_y=32,pixel_x=32)
							var/image/E=image(icon='Trees Namek.dmi',icon_state="5",pixel_y=64,pixel_x=32)
							overlays.Add(A,B,C,D,E)
