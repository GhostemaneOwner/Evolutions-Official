



Icon_Obj
	parent_type=/obj
	Savable=0
	Grabbable=0
	Health=1.#INF

Icon_Obj/Customization
	Alien_Icons
		Click()
			usr.icon=icon
			..()
			usr<<"Base icon chosen, you can double click an icon to select that as your transformation icon."
		DblClick()
			..()
			usr.Form2Icon=icon
		verb/Form2Icon()
			usr.Form2Icon=icon
		Alien1 icon='Alien (1).dmi'//'Alien (1).dmi'
		Alien2 icon='Alien (2).dmi'//'Alien (1).dmi'
		Alien3 icon='Alien (3).dmi'//'Alien (1).dmi'
		Alien4 icon='Alien (4).dmi'//'Alien (1).dmi'
		Alien5 icon='Alien (5).dmi'//'Alien (1).dmi'
		Alien6 icon='Alien (6).dmi'//'Alien (1).dmi'
		Alien7 icon='Alien (7).dmi'//'Alien (1).dmi'
		Alien8 icon='Alien (8).dmi'//'Alien (1).dmi'
		Alien9 icon='Alien (9).dmi'//'Alien (1).dmi'
		Alien10 icon='Alien (10).dmi'//'Alien (1).dmi'
		Alien11 icon='Alien (11).dmi'//'Alien 3.dmi'
		Alien12 icon='Alien (12).dmi'//'Immecka.dmi'
		Alien13 icon='Alien (13).dmi'//'Yukenojin.dmi'
		Alien14 icon='Alien (14).dmi'//'Baseniojin.dmi'
		Alien15 icon='Alien (15).dmi'//'Konatsu.dmi'
		Alien18 icon='Alien (16).dmi'//'Makyojin 2.dmi'
		Alien19 icon='Alien (17).dmi'//'Alien 5.dmi'
		Alien20 icon='Alien (18).dmi'//'Alien 4.dmi'
		Alien21 icon='Alien (19).dmi'//'Alien 6.dmi'
		Alien22 icon='Alien (20).dmi'//'Alien7.dmi'
		Alien23 icon='Alien (21).dmi'//'Alien 8.dmi'
		Alien24 icon='Alien (22).dmi'//'Alien 9.dmi'
		Alien25 icon='Alien (23).dmi'//'Alien 10.dmi'
		Alien26 icon='Alien (24).dmi'//'Alien, Frog.dmi'
		Alien27 icon='Alien (25).dmi'//'Hive Soldier.dmi'
		Alien28 icon='Alien (26).dmi'//'Hit_Race_1.0.dmi'
		Alien29 icon='Alien (27).dmi'//'Caveman_Alien.dmi'
		Alien30 icon='Alien (28).dmi'//'Doodooree-ah.dmi'
		Alien31
			Click()
				usr.pixel_x = -32
				usr.adjustedX=-32
				usr.HealthBar.pixel_x=32
				usr.EnergyBar.pixel_x=32
				..()
			icon='Alien (29).dmi'//'Asphault Basetan.dmi' pixel x = -32
		Alien32
			Click()
				usr.pixel_x = -32
				usr.adjustedX=-32
				usr.HealthBar.pixel_x=32
				usr.EnergyBar.pixel_x=32
				..()
			icon='Alien (30).dmi'//'Asphault Base.dmi' pixel x = -32
		Alien33
			Click()
				usr.pixel_x = -32
				usr.adjustedX=-32
				usr.HealthBar.pixel_x=32
				usr.EnergyBar.pixel_x=32
				..()
			icon='Alien (31).dmi'//'Base Metamori.dmi' pixel x = -32
		Alien34 icon='Alien (32).dmi'//'Base Jeice.dmi'
		Alien35 icon='Alien (33).dmi'//'Zarbon Female.dmi'
		Alien36 icon='Alien (34).dmi'//'SPOILER_Nutter.dmi'
		Alien37 icon='Alien (35).dmi'//'Harpy Base.dmi'
		Alien38 icon='Alien (36).dmi'//'Xenomorph.dmi'
		Alien39 icon='Alien (37).dmi'//'Werewolf.dmi'
		Alien40 icon='Alien (38).dmi'//'Manwolf.dmi'
		Alien41 icon='Alien (39).dmi'//'Manwolf.dmi'
		Alien42 icon='Alien (40).dmi'//'Manwolf.dmi'
		Alien43 icon='Alien (41).dmi'//'Manwolf.dmi'
		Alien44 icon='Alien (42).dmi'//'Alien (1).dmi'
		Alien45 icon='Alien (43).dmi'//'Alien (1).dmi'
		//Alien46 icon='Alien (44).dmi'//'Alien (1).dmi'
		Alien47 icon='Alien (45).dmi'//'Alien (1).dmi'
		Alien48 icon='Alien (46).dmi'//'Alien (1).dmi'
		//Alien49 icon='Alien (48).dmi'//'Alien (1).dmi'
		Alien50 icon='Alien (49).dmi'//'Alien (1).dmi'
		Alien51 icon='Alien (50).dmi'//'Alien (1).dmi'
		Alien52 icon='Alien (51).dmi'//'Alien (1).dmi'



	SpacePirate_Icons
		Click()
			usr.icon=icon
		SpacePirate1 icon='Space Pirate.dmi'
		SpacePirate2 icon='Green Musc.dmi'
		SpacePirate3
			icon='Space Pirate.dmi'
			New()
				..()
				icon-=rgb(35,35,35)
		SpacePirate4
			icon='Green Musc.dmi'
			New()
				..()
				icon+=rgb(35,35,35)
		SpacePirateF1 icon='Female_Heran_Base.dmi'
		SpacePirateF2 icon='Female_Heran_Base_Blue.dmi'
		SpacePirateF3 icon='Female_Heran_Base_2.dmi'


	Demon_Icons
		Click()
			usr.icon=icon
		Demon1 icon='Demon (1).dmi'
		Demon2 icon='Demon (2).dmi'
		Demon3 icon='Demon (3).dmi'
		Demon6 icon='Demon (4).dmi'
		Demon7 icon='Demon (5).dmi'
		Demon8 icon='Demon (6).dmi'
		Demon9 icon='Demon (7).dmi'
		Demon10 icon='Demon (8).dmi'
		Demon11 icon='Demon (9).dmi'
		Demon12 icon='Demon (10).dmi'
		Demon13 icon='Demon (11).dmi'
		Demon14 icon='Demon (12).dmi'
		Demon15 icon='Demon (13).dmi'
		Demon16 icon='Demon (14).dmi'
		Demon17 icon='Demon (15).dmi'
		Demon18 icon='Demon (16).dmi'
		Demon19 icon='Demon (17).dmi'
		Demon20 icon='Demon (18).dmi'
		Demon23 icon='Demon (19).dmi'
		Demon24 icon='Demon (20).dmi'
		Demon21 icon='Alien (26).dmi'
		Demon22 icon='Alien (25).dmi'



	Android_Icons
		Click()
			usr.icon=icon
		Android6 icon='Android (1).dmi'
		Android7 icon='Android (2).dmi'
		Android8 icon='Android (3).dmi'
		Android9 icon='Android (4).dmi'
		Android10 icon='Android (5).dmi'
		Android11 icon='Android (6).dmi'
		Android12 icon='Android (7).dmi'
		Android13 icon='Android (8).dmi'
		Android14 icon='Android (9).dmi'
		Android15 icon='Android (10).dmi'

	Yardrat_Icons
		Click()
			usr.icon=icon
		Yardrat1 icon='Alien (48).dmi'
		Yardrat2 icon='Alien (47).dmi'

	Makyo_Icons
		Click()
			usr.icon=icon
		Makyo1 icon='Makyo (1).dmi'
		Makyo2 icon='Makyo (2).dmi'
		Makyo3 icon='Makyo (3).dmi'
		Makyo4 icon='Makyo (4).dmi'
		Makyo5 icon='Makyo (5).dmi'
		Makyo6 icon='Makyo (6).dmi'
		Makyo7 icon='Makyo (7).dmi'
		MakyoF icon='Female_Heran_Base.dmi'
		MakyoF2 icon='Female_Heran_Base_Blue.dmi'

	SD_Icons
		Click()
			usr.icon=icon
		SD1 icon='SpiritDollHatless.dmi'
		SD2 icon='Spirit Doll.dmi'
		SD4 icon='Synthetic Human.dmi'
		FSD1 icon='FSD1.dmi'
		FSD2 icon='FSD2.dmi'
		FSD3 icon='FSD3.dmi'


	Oni_Icons
		Click()
			usr.icon=icon
		Oni1 icon='Red Oni.dmi'
		Oni2 icon='Blue Oni.dmi'
		Oni3 icon='Demon (3).dmi'
		Oni4 icon='Demon (4).dmi'
		Oni5 icon='Oni_Male_Base1.dmi'
		FOni1 icon='Female_Oni_Base1.dmi'
		FOni2 icon='Female_Oni_Base2.dmi'
		FOni3 icon='Female_Oni_Base3.dmi'
		FOni4 icon='Female_Oni_Base4.dmi'

	Kaio_Icons
		Click()
			usr.icon=icon
		Kaio1 icon='Alien (26).dmi'
		Kaio2 icon='Alien (25).dmi'
		Kaio3 icon='Alien (39).dmi'
		Kaio4 icon='Alien (4).dmi'
		Kaio5 icon='Alien (40).dmi'
		Kaio6 icon='Alien (50).dmi'
		Kaio7 icon='Alien (51).dmi'
		Kaio8 icon='Alien (37).dmi'


	Human_IconsM
		Click()
			usr.icon=icon
			if(usr.Race=="Demigod") usr.icon+=rgb(35,35,35)
		NewHuman1 icon='DSbaseMaleW.dmi'
		NewHuman2 icon='DSbaseMaleT.dmi'
		NewHuman3 icon='DSbaseMaleB.dmi'
		NewFHuman1 icon='DSFemaleBaseW.dmi'
		NewFHuman2 icon='DSFemaleBaseT.dmi'
		NewFHuman3 icon='DSFemaleBaseB.dmi'
		Human1 icon='Human (1).dmi'
		Human2 icon='Human (2).dmi'
		Human3 icon='Human (3).dmi'
		Human4 icon='Human (4).dmi'
		Human5 icon='Human (5).dmi'
		Human6 icon='Human (6).dmi'
		Human7 icon='Human (7).dmi'
		Human8 icon='Human (8).dmi'
		Human10 icon='Human (9).dmi'
		Human11 icon='Human (10).dmi'
		Human12 icon='Human (11).dmi'
		Human13 icon='Human (12).dmi'
		Human14 icon='Human (13).dmi'
		FHuman4 icon='Human (14).dmi'
		FHuman5 icon='Human (15).dmi'
		FHuman6 icon='Human (16).dmi'
		FHuman7 icon='Human (17).dmi'
		FHuman8 icon='Human (18).dmi'
		FHuman9 icon='Human (19).dmi'
		FHuman10 icon='Human (20).dmi'


	Namekian_Icons
		Click()
			usr.icon=icon
		Namek1 icon='Namek.dmi'
		Namek2
			icon='Namek.dmi'
			New()
				..()
				icon+=rgb(35,35,35)
		Namek3
			icon='Namek.dmi'
			New()
				..()
				icon-=rgb(35,35,35)
		Namek4 icon='Namek Young.dmi'
		Namek5 icon='Namek 2.dmi'
		Namek6 icon='NamekianLongAntennae.dmi'
		Namek7 icon='Namek Adult.dmi'
		Namek8 icon='Namek Old.dmi'
		Namek9 icon='Namek_Adult2.dmi'
		Namek10 icon='NamekBaseScar.dmi'


	Bio_Icons
		Click()
			usr.icon=icon
			..()
		Bio1 icon='Bio Android 1.dmi'
		Bio2 icon='Bio1.dmi'
		Bio3 icon='Bio Android 1yellow.dmi'
		Bio4
			Click()
				..()
				usr<<"You will get the chance to choose a new icon at incline."
			icon='updated_baby_cell.dmi'
		Bio5 icon='BioAndroid1(Spore).dmi'
		Bio6 icon='BioAndroid1r.dmi'

	MajinIcons
		Click()
			usr.icon=icon
			..()
		Majin1 icon='Majin.dmi'
		Majin2 icon='DB Majin.dmi'
		Majin3 icon='Blue Majin.dmi'
		Majin4 icon='FeMajin.dmi'
		Majin5 icon='Majin1.dmi'
		Majin6 icon='Majin2.dmi'
		Majin7 icon='Majin3.dmi'
		Majin8 icon='Majin4.dmi'
		Majin9 icon='Female Majin Base.dmi'
	Aquatian
		Click()
			if(!usr.icon)
				usr<<"First Form icon chosen"
				usr.icon=src.icon
				usr.Form1Icon=src.icon
			else if(!usr.Form2Icon)
				usr<<"Second Form icon chosen."
				usr.Form2Icon=src.icon
			else if(!usr.Form3Icon)
				usr<<"Third Form icon chosen."
				usr.Form3Icon=src.icon
			else if(!usr.Form4Icon)
				usr<<"Final Form icon chosen."
				usr.Form4Icon=src.icon
				//usr.Form8Icon=icon
		C30 icon='C1.dmi'
		C31 icon='C2.dmi'
		C32 icon='C3.dmi'
		C33 icon='C4.dmi'
		C34 icon='C5.dmi'
		C35 icon='C6.dmi'
		C36 icon='C7.dmi'
		C37 icon='C8.dmi'
		C38 icon='C9.dmi'
		C39 icon='C10.dmi'
		C40 icon='C11.dmi'
		C1 icon='Changeling Frieza 100% 2.dmi'
		C2 icon='Changeling Frieza 100%.dmi'
		C3 icon='Changeling Frieza 100% 3.dmi'
		C4 icon='Changeling Frieza 2.dmi'
		C5 icon='Changeling Frieza Form 2, 2.dmi'
		C6 icon='Changeling Frieza Form 2.dmi'
		C7 icon='Changeling Frieza Form 3, 2.dmi'
		C8 icon='Changeling Frieza Form 3.dmi'
		C9 icon='Changeling Frieza Form 4, 2.dmi'
		C10 icon='Changeling Frieza Form 4.dmi'
		C11 icon='Changeling Frieza.dmi'
		C12 icon='Changeling Kold 2.dmi'
		C13 icon='Changeling Kold Form 2.dmi'
		C14 icon='Changeling Kold.dmi'
		C15 icon='Changeling Koola 2.dmi'
		C16 icon='Changeling Koola Form 2.dmi'
		C17 icon='Changeling Koola Form 3, 2.dmi'
		C18 icon='Changeling Koola Form 3.dmi'
		C19 icon='Changeling Koola Form 4, 3.dmi'
		C20 icon='Changeling Koola Form 4.dmi'
		C21 icon='Changeling Koola.dmi'
		C22 icon='Changeling Kuriza.dmi'
		C23 icon='Changeling Koola Expand.dmi'
		C24 icon='Changeling Koola Expand 2.dmi'
		C25 icon='Changeling 1 Large.dmi'
		C26 icon='Changeling 5 Frieza.dmi'
		C27 icon='Changeling 5 Kold.dmi'
		C28 icon='Changeling Frieza Form 4, 3.dmi'
		C29 icon='Changeling Frieza BE.dmi'
		C43 icon='Chilled.dmi'
		C44 icon='Chilled2.dmi'
		C45 icon='Chilled3.dmi'


	PuarIcons
		Click()
			usr.icon=icon
		Puar1 icon='Puar.dmi'

	SaibamanIcons
		Click()
			usr.icon=icon
		Saibaman1 icon='Playable-Saibaman.dmi'

	KonatsianIcons
		Click()
			usr.icon=icon
		Konatsian1 icon='Konatsu.dmi'
		