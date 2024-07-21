obj
	Props
		Misc
			layer = 3
			Glass
				icon='Space.dmi'
				icon_state="glass1"
				density=1
				layer=MOB_LAYER+1
			Flag_Red_Demon
				icon='RPG Icons.dmi'
				icon_state = "flag"
				Flammable = 1
			Glass_Solid
				icon='Space.dmi'
				icon_state="glass1"
				density=1
			Curtains_Purple_Open
				icon='OpenPurpleCurtain.dmi'
				Flammable = 1
			Curtains_Red_Left
				icon='RedCurtainLeft.dmi'
				layer = 5
				Flammable = 1
			Curtains_Red_Right
				icon='RedCurtainRight.dmi'
				layer = 5
				Flammable = 1
				pixel_x=16
			Curtains_Purple_Closed
				icon='ClosedPurpleCurtain.dmi'
				layer = 5
				Flammable = 1
			Curtains_Red_Closed
				icon='RedClosedCurtains.dmi'
				layer = 5
				Flammable = 1
			Grate
				icon='Grate.dmi'
			Metal_Floor_Panel
				icon='MetalFloorPanel.dmi'
			Floor_Wires
				icon='FloorWires.dmi'
			Produce1
				icon='Produce1.dmi'
				density = 1
				Flammable = 1
			Produce2
				icon='Produce2.dmi'
				density = 1
				Flammable = 1
			Produce3
				icon='Produce3.dmi'
				density = 1
				Flammable = 1
			Produce4
				icon='Produce4.dmi'
				density = 1
				Flammable = 1
			ProduceBox
				icon='ProduceBox.dmi'
				density = 1
				Flammable = 1
			TechScreen
				icon='TechScreen.dmi'
				density = 1
				pixel_x = -16
			TechComputer
				icon='TechComputer.dmi'
				density = 1
				pixel_x = -16
			Wall_Damage
				icon='WallDamage.dmi'
			Wall_Wires
				icon='Wall Wires.dmi'
				Flammable = 1
			Toilet
				icon='Toilet.dmi'
			TV
				icon='TV.dmi'
				density = 1
			TVStand
				icon='TVStand.dmi'
				density = 1
			Teddy
				icon='TeddyBear.dmi'
			Stump
				icon='Stump.dmi'
				density = 1
				Flammable = 1
			Shrine
				icon='Shrine1.dmi'
				density = 1
				pixel_x = -32
			Altar
				icon='Altar.dmi'
				density = 1
				pixel_x = -23
			Clothes
				icon='Clothesline.dmi'
				density = 1
				pixel_x = -16
				Flammable = 1
			MetalStool
				icon='MetalStool.dmi'
			BrokenPlinth
				icon='BrokenPlinth.dmi'
				density = 1
			Plinth
				icon='Plinth1.dmi'
				density = 1
			Piano
				icon='Piano.dmi'
				pixel_x = -16
			Log2
				icon='Log.dmi'
				density = 1
				Flammable = 1
			Monolith
				icon='Monolith.dmi'
				density = 1
				pixel_x = -16
			Kitchen_Stove
				icon='KitchenStove.dmi'
				density = 1
			Kitchen_Cupboard
				icon='KitchenCupboard.dmi'
				density = 1
				Flammable = 1
			Kitchen_Fridge
				icon='KitchenFridge.dmi'
				density = 1
			Kitchen_Sink
				icon='KitchenSink.dmi'
				density = 1
			Heaven_Statue
				icon='HeavenStatue.dmi'
				density = 1
				pixel_x = -32
				layer = 5
			Glowing_Shrine
				icon='Glowing Shrine.dmi'
				density = 1
				pixel_x = -16
			Factory
				icon='Factory.dmi'
				density = 1
				pixel_x = -16
				pixel_y = -18
			Dragon_Statue
				icon='DragonStatue.dmi'
				density = 1
				pixel_x = -16
			DemonSkull
				icon='DemonSkull.dmi'
			AngelStatue2
				icon='AngelStatue.dmi'
				density = 1
				pixel_x = -6
			Vending_Machine
				icon='Vending_machine.dmi'
				pixel_x=-16
			White_Sofa
				icon='WhiteSofa.dmi'
			White_Sofa_Left
				icon='WhiteSofaLeft.dmi'
			White_Sofa_Right
				icon='WhiteSofaRight.dmi'
			White_Sofa_Up
				icon='WhiteSofaUp.dmi'
			Black_Sofa
				icon='BlackSofa.dmi'
			Black_Sofa_Left
				icon='BlackSofaLeft.dmi'
			Black_Sofa_Right
				icon='BlackSofaRight.dmi'
			Black_Sofa_Up
				icon='BlackSofaUp.dmi'
			Bookcase
				icon='Bookcase.dmi'
				density = 1
				Flammable = 1
			Cabinet_Books
				icon='Cabinet Books.dmi'
				density = 1
			Cabinet_Empty
				icon='Cabinet Empty.dmi'
				density = 1
			Cabinet_Glass
				icon='Cabinet Glass.dmi'
				density = 1
			Cabinet_Locker
				icon='Cabinet Locker.dmi'
				density = 1
			Chest
				icon='Turf3.dmi'
				icon_state="161"
				Flammable = 1

			Tech_Console
				icon='customtiles1.dmi'
				icon_state="Walldisplay1"
				density=1
				luminosity=1
			Tech_Console2
				icon='customtiles1.dmi'
				icon_state="Walldisplay2"
				density=1
				luminosity=1
			Tech_Console3
				icon='customtiles1.dmi'
				icon_state="Walldisplay3"
				luminosity=1
				density=1

			HellPot
				icon='turfs.dmi'
				icon_state="flamepot2"
				density=1
				luminosity=8
				New()
					var/image/A=image(icon='turfs.dmi',icon_state="flamepot1",pixel_y=32)
					overlays.Remove(A)
					overlays.Add(A)
//					spawn if(src) Fire_Cook(100)
					..()

			Giant_Statue
				density=1
				icon='Turfs Temple.dmi'
				icon_state="force7"
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Turfs Temple.dmi',icon_state="force",pixel_x=-16)
					var/image/B=image(icon='Turfs Temple.dmi',icon_state="force2",pixel_x=16)
					var/image/C=image(icon='Turfs Temple.dmi',icon_state="force5",pixel_x=-16,pixel_y=32,layer=MOB_LAYER+1)
					var/image/D=image(icon='Turfs Temple.dmi',icon_state="force6",pixel_x=16,pixel_y=32,layer=MOB_LAYER+1)
					var/image/E=image(icon='Turfs Temple.dmi',icon_state="force7",pixel_x=-16,pixel_y=64,layer=MOB_LAYER+1)
					var/image/F=image(icon='Turfs Temple.dmi',icon_state="force8",pixel_x=16,pixel_y=64,layer=MOB_LAYER+1)
					overlays.Add(A,B,C,D,E,F)

			RugLarge
				icon='Turfs 96.dmi'
				icon_state="spawnrug1"
				Flammable = 1
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Turfs 96.dmi',icon_state="spawnrug1",pixel_x=-16,pixel_y=16,layer=2)
					var/image/B=image(icon='Turfs 96.dmi',icon_state="spawnrug2",pixel_x=16,pixel_y=16,layer=2)
					var/image/C=image(icon='Turfs 96.dmi',icon_state="spawnrug3",pixel_x=-16,pixel_y=-16,layer=2)
					var/image/D=image(icon='Turfs 96.dmi',icon_state="spawnrug4",pixel_x=16,pixel_y=-16,layer=2)
					overlays.Remove(A,B,C,D)
					overlays.Add(A,B,C,D)

			Apples
				icon='Turf3.dmi'
				icon_state="163"
			Angel_Statue
				icon='zzzz.dmi'
				icon_state="statuebottom"
				New()
					var/image/A=image(icon='zzzz.dmi',icon_state="statuetop",layer=MOB_LAYER+1,pixel_y=32)
					overlays+=A
			Book
				icon='Turf3.dmi'
				icon_state="167"
				Flammable = 1
			Bones
				icon='Turf 52.dmi'
				icon_state="bones1"
				New()
					var/I = rand(1,4)
					src.icon_state = "bones[I]"
					src.pixel_x = rand(-6,6)
					src.pixel_y = rand(-6,6)
			Captive
				icon='Turf 52.dmi'
				icon_state="captive"
				Flammable = 1
			Fence
				density=1
				icon='Turf 55.dmi'
				icon_state="woodenfence"
				Flammable = 1
			Hell_Skull
				density=1
				icon='Hell turf.dmi'
				icon_state="h7"
			Whirlpool
				icon='Whirlpool.dmi'

			Log
				density=1
				icon='Turf 57.dmi'
				icon_state="log1"
				Flammable = 1
				New()
					icon=null
					icon_state=null
					var/image/A=image(icon='Turf 57.dmi',icon_state="log1",pixel_x=-16)
					var/image/B=image(icon='Turf 57.dmi',icon_state="log2",pixel_x=16)
					overlays.Remove(A,B)
					overlays.Add(A,B)


			Jugs
				icon='Turf 52.dmi'
				icon_state="jugs"
				density=1
			Hay
				icon='Turf 52.dmi'
				icon_state="hay"
				density=1
				Flammable = 1
			Clock
				icon='Turf 52.dmi'
				icon_state="clock"
				density=1
				Flammable = 1
			Waterpot
				icon='Turf 52.dmi'
				icon_state="water pot"
				density=1

			Stove
				icon='Turf 52.dmi'
				icon_state="stove"
				density=1

			Drawer
				icon='Turf 52.dmi'
				icon_state="drawers"
				Flammable = 1
				density=1
				New()
					var/image/A=image(icon='Turf 52.dmi',icon_state="drawers top",pixel_y=32)
					overlays.Remove(A)
					overlays.Add(A)

			Turret_Prop
				Buildable=0
				New()
					var/image/A=image(icon='Turret.dmi', icon_state="",pixel_x=-5)
					overlays.Remove(A)
					overlays.Add(A)

			Food_Plates
				icon = 'FoodPlates.dmi'
				layer = 4.1
				pixel_y = 12
			Food_Prep
				icon = 'FoodPrep.dmi'
				layer = 4.1
				pixel_y = 5
			Food_Tea
				icon = 'FoodTea.dmi'
				layer = 4.1
				pixel_y = 3
			Food_TeaCup
				icon = 'FoodTeacup.dmi'
				layer = 4.1
			Food_Turkey
				icon = 'FoodTurkey.dmi'
				layer = 4.1
				pixel_y = 6
			Food_Wine
				icon = 'FoodWine.dmi'
				layer = 4.1
				pixel_y = 8
			Food_WineGlasses
				icon = 'FoodWineGlasses.dmi'
				layer = 4.1
			Food_VendingMachine
				icon = 'FoodVendingMachine.dmi'
				layer = 4.1
			barrel
				icon='Turfs 2.dmi'
				icon_state="barrel"
				density=1
				Flammable = 1
			Waterfall
				icon='waterfall.dmi'
				layer=MOB_LAYER+1
			box2
				icon='Turfs 5.dmi'
				icon_state="box"
				density=1
				Flammable = 1

			Light
				icon='Space.dmi'
				icon_state="light"
				density=1
				luminosity=10

			firewood
				icon='roomobj.dmi'
				icon_state="firewood"
				density=1
				Flammable = 1

			Yellow_Road_Markings_Top
				icon='Street.dmi'
				icon_state="Top"

			Yellow_Road_Markings_Bottom
				icon='Street.dmi'
				icon_state="Bottom"

			Yellow_Road_Markings_Left
				icon='Street.dmi'
				icon_state="Left"

			Yellow_Road_Markings_Right
				icon='Street.dmi'
				icon_state="Right"

			Yellow_Road_Markings_Top_Center
				icon='Street.dmi'
				icon_state="TopC"

			Yellow_Road_Markings_Left_Center
				icon='Street.dmi'
				icon_state="LeftC"

			Yellow_Road_Markings_Bottom_Center
				icon='Street.dmi'
				icon_state="BottomC"

			Yellow_Road_Markings_Right_Center
				icon='Street.dmi'
				icon_state="RightC"

			Yellow_Road_Markings_TLV_Right
				icon='Street.dmi'
				icon_state="TLV_R"

			Yellow_Road_Markings_TLV_Left
				icon='Street.dmi'
				icon_state="TLV_L"

			Yellow_Road_Markings_TLH_Bottom
				icon='Street.dmi'
				icon_state="TLH_B"

			Yellow_Road_Markings_TLH_Top
				icon='Street.dmi'
				icon_state="TLH_T"

			White_Road_Markings_Center_Horizontal
				icon='Street.dmi'
				icon_state="C_Horiz"

			White_Road_Markings_Center_Vertical
				icon='Street.dmi'
				icon_state="C_Vert"


			Solid_White_Road_Markings_Right_Line
				icon='Street.dmi'
				icon_state="LW_R"

			Solid_White_Road_Markings_Left_Line
				icon='Street.dmi'
				icon_state="LW_L"

			Solid_White_Road_Markings_Top_Line
				icon='Street.dmi'
				icon_state="LW_T"

			Solid_White_Road_Markings_Bottom_Line
				icon='Street.dmi'
				icon_state="LW_B"


			Dotted_White_Road_Markings_Right_Line
				icon='Street.dmi'
				icon_state="LWE_R"

			Dotted_White_Road_Markings_Left_Line
				icon='Street.dmi'
				icon_state="LWE_L"

			Dotted_White_Road_Markings_Top_Line
				icon='Street.dmi'
				icon_state="LWE_T"

			Dotted_White_Road_Markings_Bottom_Line
				icon='Street.dmi'
				icon_state="LWE_B"

			Stop_Sign
				icon='Urban.dmi'
				icon_state="StopB"
				New()
					var/image/A=image(icon='Urban.dmi',icon_state="StopT",pixel_y=16)
					overlays+=A
			Urban_Traffic_Light
				icon='Urban.dmi'
				icon_state="TrafficLight"
			Urban_TrafficPost_Left
				icon='Urban.dmi'
				icon_state="LeftPost"
				density=1
			Urban_TrafficPost_Top
				icon='Urban.dmi'
				icon_state="TopPost"
				density=1
			Urban_TrafficPost_Right
				icon='Urban.dmi'
				icon_state="RightPost"
				density=1
			Urban_TrafficPost_Left2
				icon='Urban.dmi'
				icon_state="LeftPost2"
				density=1
			Urban_TrafficPost_Right2
				icon='Urban.dmi'
				icon_state="RightPost2"
				density=1
			Urban_TrafficPost_LConnector
				icon='Urban.dmi'
				icon_state="LeftConnectPost"
				density=1
			Urban_TrafficPost_RConnector
				icon='Urban.dmi'
				icon_state="RightConnectPost"
				density=1
			Urban_Traffic_Stop
				icon='Urban.dmi'
				icon_state="TrafficStop"
			Urban_Traffic_Slow
				icon='Urban.dmi'
				icon_state="TrafficSlow"
			Urban_Traffic_Go_
				icon='Urban.dmi'
				icon_state="TrafficGo"
		/*	Urban_Stop_Post_Left_Starter
				icon='Urban.dmi'
				icon_state="LeftPost2"
				density=1
				New()
					var/image/A=image(icon='Urban.dmi',icon_state="LeftPost",pixel_y=16)
					var/image/B=image(icon='Urban.dmi',icon_state="TopPost",pixel_y=16,pixel_x=16)
					overlays+=A
					overlays+=B
			Urban_stop_Post_Left_Starter*/
			Urban_Debris_Small_1
				icon='Debris.dmi'
				icon_state="D_Small"
				density=1
			Urban_Debris_Medium_1
				icon='Debris.dmi'
				icon_state="D_Medium"
				density=1
			Urban_Debris_Large_1
				icon='Debris.dmi'
				icon_state="D_Big"
				density=1
			Urban_Barrel_Basic
				icon='Cans.dmi'
				icon_state="Can_A"
				density=1
			Urban_Damage_1
				icon='Damage.dmi'
				icon_state="crack1"
			Urban_Damage_2
				icon='Damage.dmi'
				icon_state="crack2"
			Urban_Damage_3
				icon='Damage.dmi'
				icon_state="crack3"
			Urban_Damage_4
				icon='Damage.dmi'
				icon_state="W_Busted"
			Urban_Dumpster_Animated
				icon='Dumpster Animated.dmi'
				icon_state="Dumpster"
				density=1
				