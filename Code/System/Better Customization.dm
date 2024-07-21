
mob/verb/Show_Contacts()
	set category=null//"Other"
	src=usr
	winclone(src, "GenericSheet", "Contacts")
	winshow(client,"Contacts",1)
	winset(client,"Contacts.Grid","cells=0x0")
	var/Row=0
	for(var/obj/Contact/S in src.Contacts)
		Row++
		src << output(S, "Contacts.Grid:1,[Row]")
		src << output("[S.familiarity] ([S.relation])","Contacts.Grid:2,[Row]")
		src << output("[S.Notes]","Contacts.Grid:3,[Row]")


mob/verb/Show_Milestones()
	set category=null//"Other"
	src=usr
	winclone(src, "GenericSheet", "Milestones")
	winshow(client,"Milestones",1)
	winset(client,"Milestones.Grid","cells=0x0;title=\"Milestones\"")
	var/Row=0
	for(var/Milestone/MP in src)
		Row++
		src << output("[MP] [MP.MaxRanks>1?"Rank [MP.Ranks]/[MP.MaxRanks]":""]", "Milestones.Grid:1,[Row]")
		src << output("[MP.desc] ([MP.UB1] / [MP.UB2]) <br>(Cost [MP.PointsCost] MP[MP.Refundable==0?" Non-Refundable!":""])<br>(Year Acquired: [MP.YearAcquired])","Milestones.Grid:2,[Row]")


mob/verb/Skill_Sheet()
	Get_PlayerAssess()


mob/var/tmp/HairChoose
mob/proc

	Grid(var/Z,var/X,var/E)
		winshow(client,"Grid",0)
		winshow(client,"Grid",1)
		winset(client,"GridX","cells=0x0")
		sleep()
		var/Row=0
		if(Z=="Clothes")
			Clothing=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Clothing\"")
			for(var/A in typesof(/obj/items/Clothes)) if(A!=/obj/items/Clothes) Clothing+=new A
			for(var/A in Clothing)
				Row++
				src<<output(A,"GridX:1,[Row]")

		if(Z=="CreationKanassan")
			Kanassan_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Kanassan Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Alien_Icons)) if(B!=/Icon_Obj/Customization/Alien_Icons) Kanassan_List+=new B
			for(var/A in Kanassan_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationYardrat")
			Yardrat_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Yardrat Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Yardrat_Icons)) if(B!=/Icon_Obj/Customization/Yardrat_Icons) Yardrat_List+=new B
			for(var/A in Yardrat_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationChangeling")
			Changeling_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Changeling Forms\"")
			for(var/B in typesof(/Icon_Obj/Customization/Aquatian)) if(B!=/Icon_Obj/Customization/Aquatian) Changeling_List+=new B
			src<<"Select your first, second, third and final form icons."
			for(var/A in Changeling_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationAndroid")
			Android_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Android Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Human_IconsM)) if(B!=/Icon_Obj/Customization/Human_IconsM) Android_List+=new B
			for(var/B in typesof(/Icon_Obj/Customization/Android_Icons)) if(B!=/Icon_Obj/Customization/Android_Icons) Android_List+=new B
			for(var/A in Android_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationMakyo")
			Makyo_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Makyo Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Makyo_Icons)) if(B!=/Icon_Obj/Customization/Makyo_Icons) Makyo_List+=new B
			for(var/A in Makyo_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationSD")
			SpiritDoll_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Spirit Doll Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/SD_Icons)) if(B!=/Icon_Obj/Customization/SD_Icons) SpiritDoll_List+=new B
			for(var/A in SpiritDoll_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationDemon")
			Demon_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Demon Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Demon_Icons)) if(B!=/Icon_Obj/Customization/Demon_Icons) Demon_List+=new B
			for(var/A in Demon_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationOni")
			Oni_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Oni Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Oni_Icons)) if(B!=/Icon_Obj/Customization/Oni_Icons) Oni_List+=new B
			for(var/A in Oni_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationMajin")
			Oni_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Majin Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/MajinIcons)) if(B!=/Icon_Obj/Customization/MajinIcons) Oni_List+=new B
			for(var/A in Oni_List)
				Row++
				src<<output(A,"GridX:1,[Row]")

		if(Z=="CreationPuar")
			Puar_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Puar Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/PuarIcons)) if(B!=/Icon_Obj/Customization/PuarIcons) Puar_List+=new B
			for(var/A in Puar_List)
				Row++
				src<<output(A,"GridX:1,[Row]")

		if(Z=="CreationSaibaman")
			Saibaman_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Saibaman Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/SaibamanIcons)) if(B!=/Icon_Obj/Customization/SaibamanIcons) Saibaman_List+=new B
			for(var/A in Saibaman_List)
				Row++
				src<<output(A,"GridX:1,[Row]")

		if(Z=="CreationKonatsian")
			Konatsian_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Konatsian Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/KonatsianIcons)) if(B!=/Icon_Obj/Customization/KonatsianIcons) Konatsian_List+=new B
			for(var/A in Konatsian_List)
				Row++
				src<<output(A,"GridX:1,[Row]")


		if(Z=="CreationNamekian")
			Namekian_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Namekian Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Namekian_Icons)) if(B!=/Icon_Obj/Customization/Namekian_Icons) Namekian_List+=new B
			for(var/A in Namekian_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationBio")
			Bio_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Bio Android Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Bio_Icons)) if(B!=/Icon_Obj/Customization/Bio_Icons) Bio_List+=new B
			for(var/A in Bio_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationAlien")
			Alien_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Alien Icon\"")
			if(Class=="Heran") for(var/B in typesof(/Icon_Obj/Customization/SpacePirate_Icons)) if(B!=/Icon_Obj/Customization/SpacePirate_Icons) Alien_List+=new B
			else for(var/B in typesof(/Icon_Obj/Customization/Alien_Icons)) if(B!=/Icon_Obj/Customization/Alien_Icons) Alien_List+=new B
			for(var/A in Alien_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationHumanM")
			Human_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Human Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Human_IconsM)) if(B!=/Icon_Obj/Customization/Human_IconsM) Human_List+=new B
			for(var/A in Human_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationKaio")
			Kaio_List=list()
			winset(src.client,"Grid.SelectedCustomize","text=\"Kaio Icon\"")
			for(var/B in typesof(/Icon_Obj/Customization/Human_IconsM)) if(B!=/Icon_Obj/Customization/Human_IconsM) Kaio_List+=new B
			for(var/B in typesof(/Icon_Obj/Customization/Kaio_Icons)) if(B!=/Icon_Obj/Customization/Kaio_Icons) Kaio_List+=new B
			for(var/A in Kaio_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="Blasts")
			winset(src.client,"Grid.SelectedCustomize","text=\"Customize Ki\"")
			Blast_List=list()
			for(var/A in typesof(/Icon_Obj/Customization/Blasts)) if(A!=/Icon_Obj/Customization/Blasts) Blast_List+=new A
			for(var/A in Blast_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(X=="Auras")
			Aura_List=list()
			for(var/A in typesof(/Icon_Obj/Customization/Auras)) if(A!=/Icon_Obj/Customization/Auras) Aura_List+=new A
			for(var/A in Aura_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(E=="Charges")
			Charge_List=list()
			for(var/A in typesof(/Icon_Obj/Customization/Charges)) if(A!=/Icon_Obj/Customization/Charges) Charge_List+=new A
			for(var/A in Charge_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="Hair")
			winset(src.client,"Grid.SelectedCustomize","text=\"Hair\"")
			Hair_List=list()
			for(var/A in typesof(/HairType)) if(A!=/HairType) Hair_List+=new A
			for(var/A in Hair_List)
				Row++
				src<<output(A,"GridX:1,[Row]")

		if(Z=="Create")
			winset(src.client,"Grid.SelectedCustomize","text=\"Create\"")
			Row++
			src << output("Technology", "GridX:1,[Row]")
			src << output("Intelligence: [Int_Level] ([Int_Mod])", "GridX:2,[Row]")
			for(var/obj/Resources/A in src)
				Row++
				src << output(A, "GridX:1,[Row]")
				src << output("[Commas(A.Value)]", "GridX:2,[Row]")
			for(var/obj/Technology/_tech in globTechlist)
				if(src.Int_Level >= _tech.Level&&src.Int_Mod>=_tech.Mod)
					Row++
					src << output(_tech, "GridX:1,[Row]")
					src << output("[Commas(round(initial(_tech.Cost)/src.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]", "GridX:2,[Row]")

			Row++
			src << output("Magic", "GridX:1,[Row]")
			src << output("Magic Level: [Magic_Level] ([Magic_Potential])", "GridX:2,[Row]")
			for(var/obj/Mana/A in src)
				Row++
				src << output(A, "GridX:1,[Row]")
				src << output("[Commas(A.Value)]", "GridX:2,[Row]")
			for(var/obj/Magic/_mag in globMagiclist)
				if(src.Magic_Level >= _mag.Level&&src.Magic_Potential>=_mag.Mod)
					Row++
					src << output(_mag, "GridX:1,[Row]")
					src << output("[Commas(round(initial(_mag.Cost)/src.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))]", "GridX:2,[Row]")



		if(Z=="Tech")
			winset(src.client,"Grid.SelectedCustomize","text=\"Technology\"")
			for(var/obj/Resources/A in src)
				Row++
				src << output(A, "GridX:1,[Row]")
				src << output("[Commas(A.Value)]", "GridX:2,[Row]")
			for(var/obj/Technology/_tech in globTechlist)
				if(src.Int_Level >= _tech.Level&&src.Int_Mod>=_tech.Mod)
					Row++
					src << output(_tech, "GridX:1,[Row]")
					src << output("[Commas(round(initial(_tech.Cost)/src.Int_Mod)*(1-(0.15*usr.HasDeepPockets)))]", "GridX:2,[Row]")
		if(Z=="Magic")
			winset(src.client,"Grid.SelectedCustomize","text=\"Magic\"")
			for(var/obj/Mana/A in src)
				Row++
				src << output(A, "GridX:1,[Row]")
				src << output("[Commas(A.Value)]", "GridX:2,[Row]")
			for(var/obj/Magic/_mag in globMagiclist)
				if(src.Magic_Level >= _mag.Level&&src.Magic_Potential>=_mag.Mod)
					Row++
					src << output(_mag, "GridX:1,[Row]")
					src << output("[Commas(round(initial(_mag.Cost)/src.Magic_Potential)*(1-(0.15*usr.HasDeepPockets)))]", "GridX:2,[Row]")




var/list/Hair_List=new
var/list/Human_List=new
var/list/Alien_List=new
var/list/Demon_List=new
var/list/Namekian_List=new
var/list/Oni_List=new
var/list/Makyo_List=new
var/list/Changeling_List=new
var/list/SpiritDoll_List=new
var/list/Kaio_List=new
var/list/Android_List=new
var/list/Bio_List=new
var/list/Blast_List=new
var/list/Charge_List=new
var/list/Aura_List=new
var/list/Yardrat_List=new
var/list/Kanassan_List=new
var/list/Puar_List=new
var/list/Saibaman_List=new
var/list/Konatsian_List=new
