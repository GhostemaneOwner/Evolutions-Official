turf
	Upgradeable
		CustomTurf
			var/Roof=0
			icon='ArtificalObj.dmi'
			icon_state="QuestionMark"
			Enter(atom/A)
				if(Roof==1)
					if(FlyOverAble||ghostDens_check(A))
						return ..()
					else
						return 0
				else
					return ..()
		Roofs
			FlyOverAble=0
			StripedRoof
				icon='StripedRoof.dmi'
				density=1
				opacity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Roof
				icon='Roof2.dmi'
				density=1
				opacity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			MetalRoof4
				icon='Roof1.dmi'
				density=1
				opacity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Magicial_Roof
				icon='Magic Items.dmi'
				icon_state="magical roof"
				density=1
				opacity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			RoofTech
				icon='Space.dmi'
				icon_state="top"
				density=1
				opacity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Grey_Roof
				icon='GreyRoof.dmi'
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Green_Roof
				icon='Green Roof.dmi'
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Thatch_Roof
				icon='ThatchRoof.dmi'
				density=1
				opacity=1
				luminosity=1
				Flammable = 1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Red_Roof
				icon='RedRoof.dmi'
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Blue_Roof
				icon='BlueRoof.dmi'
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0


			Hell_Roof
				icon='GreyRoof.dmi'
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Roof1
				icon='Turfs 96.dmi'
				icon_state="roof3"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Roof2
				icon='Turfs.dmi'
				icon_state="roof2"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Roof3
				icon='Turfs 96.dmi'
				icon_state="roof4"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			RoofWhite
				icon='turfs.dmi'
				icon_state="block_wall1"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			MetalRoof1
				icon='metaltiles1.dmi'
				icon_state="metalroofa"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			MetalRoof2
				icon='metaltiles1.dmi'
				icon_state="metalroofb"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			MetalRoof3
				icon='metaltiles1.dmi'
				icon_state="metalroofc"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Tech_Wall_1
				icon='Future_Tilesheet_1.dmi'
				icon_state="Roof1"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Tech_Wall_2
				icon='Future_Tilesheet_1.dmi'
				icon_state="Roof5"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Tech_Wall_3
				icon='Future_Tilesheet_1.dmi'
				icon_state="Roof4"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Tech_Wall_4
				icon='Future_Tilesheet_1.dmi'
				icon_state="Roof2"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Tech_Wall_5
				icon='Futuristic Sheet 1 Test.dmi'
				icon_state="Roof1"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Tech_Wall_6
				icon='Futuristic Sheet 1 Test.dmi'
				icon_state="Roof2"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0


			Urban_Glass_Roof
				icon='Skyscraper.dmi'
				icon_state="Glass"
				density=1
				opacity=0
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			RoofGlass
				icon='Objects.dmi'
				icon_state="Glass"
				density=1
				opacity=0
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
			Country_Roof_1
				icon='Future_Tilesheet_1.dmi'
				icon_state="Wall6.2"
				density=1
				opacity=1
				luminosity=1
				Enter(atom/A)
					if(FlyOverAble||ghostDens_check(A)) return ..()
					else return 0
					