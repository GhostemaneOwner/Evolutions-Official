

mob
	verb/Custom_Hair()
		set category=null//"Other"
		set desc = "Change hair icon"
		var/ICO = input("Select an icon to use.","Custom Hair Icon") as null|icon
		if(!ICO) return
		var/list/HairList=list("Base")
		if(HasSSj>=1) HairList+="SSj"
		if(HasSSj>=2) HairList+="SSj 2"
		if(HasSSj>=3) HairList+="SSj 3"
		if(HasSSj4) HairList+="SSj 4"
		if(HasBojack) HairList+="Bojack"
		if(Race=="Saiyan"&&GodKi) HairList+="SSG"
		if(MaxGodKi) HairList+="SSGSS" 
		HairList+="Cancel"
		var/HC=input(usr,"Which hair do you want to change?","Custom Hair") in HairList
		var/size = length(ICO)
		Size(size)
		if(length(ICO) > iconsize)
			alert(usr,"[ICO] ([filemsg]) is above the maximum icon size ([iconsize].)","Change Icon")
			return
		else
			usr << "Icon accepted!"
			if(usr.Confirm("Select a custom Hair X/Y?"))
				usr.HairX=input("Hair X") as num
				usr.HairY=input("Hair Y") as num
				if(usr.HairX<-64)usr.HairX=-64
				if(usr.HairX>64)usr.HairX=64
				if(usr.HairY<-64)usr.HairY=-64
				if(usr.HairY>64)usr.HairY=64
			usr.HairAdd()
			switch(HC)
				if("Base")
					usr.hair=ICO
					usr.Hair_Base=usr.hair
				if("SSj")
					usr.SSjHair=ICO
					usr.SSjFPHair=ICO
				if("USSj") usr.USSjHair=ICO
				if("SSj 2") usr.SSj2Hair=ICO
				if("SSj 3") usr.SSj3Hair=ICO
				if("SSj 4") usr.SSj4Hair=ICO
				if("Bojack")
					usr.SSGHair=ICO
					usr.SSjHair=ICO
				if("SSG")
					usr.SSGHair=ICO
				if("SSGSS")
					usr.SSRHair=ICO
					usr.SSRHair=ICO
					usr.SSGFPHair=ICO

HairType
	parent_type=/obj

	var/hair=null
	var/SSjHair='Hair_GokuSSj.dmi'
	var/USSjHair='Hair_GokuUSSj.dmi'
	var/SSjFPHair='Hair_GokuSSjFP.dmi'
	var/SSj2Hair='Hair_GokuUSSj.dmi'
	var/SSj3Hair='Hair_GokuSSj3.dmi'
	var/SSj4Hair='Hair_SSj4.dmi'
	var/SSGSSHair='Hair_GokuSSB.dmi'
	var/SSGFPHair='Hair_GokuSSBFP.dmi'
	var/SSRHair='Hair_GokuSSR.dmi'
		//SSGHair
	New()
		icon=hair
		..()
	Bald
		hair=null
		SSjHair=null
		USSjHair=null
		SSjFPHair=null
		SSj2Hair=null
		SSj3Hair=null
	Custom_Hair
		hair='Hair_GokuSSj.dmi'
		Click()
			usr.Custom_Hair()
			return
	Randley
		hair='Maleek Hair.dmi'
		New()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			..()
	Shaggy
		hair='Hair, Shaggy.dmi'
		New()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			..()
	Afro
		hair='Hair Afro.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	HairGelLover
		hair='Hair_Vegeta.dmi'
		New()
			..()
			SSjHair='Hair_VegetaSSj.dmi'
			USSjHair='Hair_VegetaUSSj.dmi'
			SSjFPHair='Hair_VegetaSSjFP.dmi'
			SSj2Hair='Hair_VegetaSSj.dmi'
			SSGSSHair='Hair_VegetaSSB.dmi'
			SSGFPHair='Hair_VegetaSSBFP.dmi'
			SSRHair='Hair_VegetaSSR.dmi'
	Extreme
		hair='Hair_Raditz.dmi'
		New()
			..()
			SSjHair='Hair_RaditzSSj.dmi'
			USSjHair='Hair_GokuSSj3.dmi'
			SSjFPHair='Hair_RaditzSSjFP.dmi'
			SSj2Hair='Hair_RaditzSSj.dmi'
			SSj3Hair='Hair_GokuSSj3.dmi'
			SSGSSHair='Hair_RaditzSSB.dmi'
			SSGFPHair='Hair_RaditzSSBFP.dmi'
			SSRHair='Hair_RaditzSSR.dmi'
	Player
		hair='Hair_Yamcha.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,20)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair='Hair_LongSSB.dmi'
			SSGFPHair='Hair_LongSSBFP.dmi'
			SSRHair='Hair_LongSSR.dmi'
	Suave
		hair='Hair_FutureGohan.dmi'
		New()
			..()
			SSjHair='Hair_GohanSSj.dmi'
			USSjHair='Hair_GohanUSSj.dmi'
			SSjFPHair='Hair_GohanSSjFP.dmi'
			SSj2Hair='Hair_GohanSSj.dmi'
			SSGSSHair='Hair_GohanSSB.dmi'
			SSGFPHair='Hair_GohanSSBFP.dmi'
			SSRHair='Hair_GohanSSR.dmi'
	Everyman
		hair='Hair_Gohan.dmi'
		New()
			..()
			SSjHair='Hair_GohanSSj.dmi'
			USSjHair='Hair_GohanUSSj.dmi'
			SSjFPHair='Hair_GohanSSjFP.dmi'
			SSj2Hair='Hair_GohanSSj.dmi'
			SSGSSHair='Hair_GohanSSB.dmi'
			SSGFPHair='Hair_GohanSSBFP.dmi'
			SSRHair='Hair_GohanSSR.dmi'
	Long
		hair='Hair_Long.dmi'
		New()
			..()
			SSjHair='Hair_LongSSj.dmi'
			USSjHair='Hair_LongUSSj.dmi'
			SSjFPHair='Hair_LongSSjFP.dmi'
			SSj2Hair='Hair_LongSSj.dmi'
			SSGSSHair='Hair_LongSSB.dmi'
			SSGFPHair='Hair_LongSSBFP.dmi'
			SSRHair='Hair_LongSSR.dmi'
	TheKid
		hair='Hair_KidGohan.dmi'
		New()
			..()
			SSjHair='Hair_KidGohanSSj.dmi'
			USSjHair='Hair_KidGohanUSSj.dmi'
			SSjFPHair='Hair_KidGohanSSjFP.dmi'
			SSj2Hair='Hair_KidGohanUSSj.dmi'
			SSGSSHair='Hair_KidGohanUSSB.dmi'
			SSGFPHair='Hair_KidGohanSSBFP.dmi'
			SSRHair='Hair_KidGohanSSRFP.dmi'
	ThePunk
		hair='Hair_Goten.dmi'
		New()
			..()
			SSjHair='Hair_GokuSSj.dmi'
			USSjHair='Hair_GokuUSSj.dmi'
			SSjFPHair='Hair_GokuSSjFP.dmi'
			SSj2Hair='Hair_GokuSSj.dmi'
			SSGSSHair='Hair_GokuSSB.dmi'
			SSGFPHair='Hair_GokuSSBFP.dmi'
			SSRHair='Hair_GokuSSR.dmi'
	Bowlcut
		hair='Hair_GTTrunks.dmi'
		New()
			..()
			SSjHair='Hair_LongSSj.dmi'
			USSjHair='Hair_GokuUSSj.dmi'
			SSjFPHair='Hair_LongSSjFP.dmi'
			SSj2Hair='Hair_LongSSj.dmi'
			SSGSSHair='Hair_LongSSB.dmi'
			SSGFPHair='Hair_LongSSBFP.dmi'
			SSRHair='Hair_LongSSR.dmi'
	Spike
		hair='Hair_GTVegeta.dmi'
		New()
			..()
			SSjHair='Hair_GTVegetaSSj.dmi'
			USSjHair='Hair_LongUSSj.dmi'
			SSjFPHair=hair+rgb(150,150,50)
			SSj2Hair='Hair_GTVegetaSSj.dmi'
			SSGSSHair='Hair_GTVegetaSSB.dmi'
			SSGFPHair='Hair_GTVegetaSSB.dmi'
			SSRHair='Hair_GTVegetaSSR.dmi'
			SSGFPHair+=rgb(18,18,18)
	Mohawk
		hair='Hair_Mohawk.dmi'
		New()
			..()
			SSjHair='Hair_MohawkSSj.dmi'
			USSjHair='Hair_LongUSSj.dmi'
			SSjFPHair=hair+rgb(150,150,50)
			SSj2Hair='Hair_MohawkSSj.dmi'
			SSGSSHair='Hair_MohawkSSB.dmi'
			SSGFPHair='Hair_MohawkSSB.dmi'
			SSRHair='Hair_MohawkSSR.dmi'
			SSGFPHair+=rgb(18,18,18)
	Freak
		hair='Hair_Spike.dmi'
		New()
			..()
			SSjHair='Hair_SpikeSSj.dmi'
			USSjHair='Hair_LongUSSj.dmi'
			SSjFPHair=hair+rgb(150,150,50)
			SSj2Hair='Hair_SpikeSSj.dmi'
			SSGSSHair='Hair_SpikeSSB.dmi'
			SSGFPHair='Hair_SpikeSSB.dmi'
			SSGFPHair+=rgb(18,18,18)
			SSRHair='Hair_SpikeSSR.dmi'
	MiniGelled
		hair='Hair Vegeta Junior.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,20)
			USSjHair='Hair_VegetaUSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(150,150,20)
			SSGSSHair='Hair_VegetaUSSB.dmi'
			SSGFPHair='Hair_VegetaSSBFP.dmi'
			SSRHair='Hair_VegetaSSR.dmi'
	Anime2
		hair='Hair Lan.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,20)
			USSjHair=hair+rgb(100,150,20)
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
	Protaganist
		hair='Hair_Goku.dmi'
		New()
			..()
			SSjHair='Hair_GokuSSj.dmi'
			USSjHair='Hair_GokuUSSj.dmi'
			SSjFPHair='Hair_GokuSSjFP.dmi'
			SSj2Hair='Hair_GokuUSSj.dmi'
			SSj3Hair='Hair_GokuSSj3.dmi'
			SSGSSHair='Hair_GokuSSB.dmi'
			SSGFPHair='Hair_GokuSSBFP.dmi'
			SSRHair='Hair_GokuSSR.dmi'
	Unkempt
		hair='Hair Muse.dmi'
		New()
			..()
			SSjHair='Hair_GokuSSj.dmi'
			USSjHair='Hair_GokuUSSj.dmi'
			SSjFPHair='Hair_GokuSSjFP.dmi'
			SSj2Hair='Hair_GokuUSSj.dmi'
			SSj3Hair='Hair_GokuSSj3.dmi'
			SSGSSHair='Hair_GokuSSB.dmi'
			SSGFPHair='Hair_GokuSSBFP.dmi'
			SSRHair='Hair_GokuSSR.dmi'
	Bowl
		hair='Hair Kidd.dmi'
		New()
			..()
			SSjHair='Hair_LongSSj.dmi'
			USSjHair='Hair_LongUSSj.dmi'
			SSjFPHair='Hair_LongSSjFP.dmi'
			SSj2Hair='Hair_LongSSj.dmi'
			SSGSSHair='Hair_LongSSB.dmi'
			SSGFPHair='Hair_LongSSBFP.dmi'
			SSRHair='Hair_LongSSR.dmi'
	Nerd
		hair='Hair Super 17.dmi'
		New()
			..()
			SSjHair='Hair_LongSSj.dmi'
			USSjHair='Hair_LongUSSj.dmi'
			SSjFPHair='Hair_LongSSjFP.dmi'
			SSj2Hair='Hair_LongSSj.dmi'
			SSGSSHair='Hair_LongSSB.dmi'
			SSGFPHair='Hair_LongSSBFP.dmi'
			SSRHair='Hair_LongSSR.dmi'
	Anime3
		hair='BlackSSJhair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,20)
			USSjHair='Hair_GokuSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(150,150,20)
			SSGSSHair='Hair_GokuUSSB.dmi'
			SSGFPHair='Hair_GokuSSBFP.dmi'
			SSRHair='Hair_GokuSSR.dmi'
	Gelled2
		hair='GT Goten Hair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,20)
			USSjHair='GT Gotens Hair ASsj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(150,150,20)
			SSGSSHair='GT_Gotens_Hair_ASSB.dmi'
			SSGFPHair='GT_Gotens_Hair_ASSB.dmi'
			SSRHair='GT_Gotens_Hair_ASSR.dmi'
			SSGSSHair-=rgb(18,18,18)
	Spikey
		hair='New Hair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,20)
			USSjHair='Hair_VegetaUSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(150,150,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	SuperCurled
		hair='SSJ4.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,20)
			USSjHair='Hair_GokuSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(150,150,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	Female
		hair='Hair_FemaleLong2.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair+=rgb(18,18,18)
			SSRHair='Hair_FemaleLongSSR.dmi'
	Female2
		hair='Hair_FemaleLong.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair+=rgb(18,18,18)
			SSRHair='Hair_FemaleLongSSR.dmi'
	Female3
		hair='Hair Kylin 1.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair+=rgb(18,18,18)
			SSRHair='Hair_FemaleLongSSR.dmi'
	Female4
		hair='Hair Kylin 3.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair='Hair_FemaleLongSSB.dmi'
			SSRHair='Hair_FemaleLongSSR.dmi'
			SSGFPHair+=rgb(18,18,18)
	Chick
		hair='Hair Kylin 2.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair='Hair_FemaleLongSSB.dmi'
			SSGFPHair='Hair_FemaleLongSSB.dmi'
			SSRHair='Hair_FemaleLongSSR.dmi'
			SSGFPHair+=rgb(18,18,18)
	Anime
		hair='Hair, Cloud.dmi'
		New()
			..()
			SSjHair=hair
			USSjHair=hair
			SSjFPHair=hair
			SSj2Hair=hair
			SSj3Hair=hair
			SSGSSHair='Hair_SpikeSSB.dmi'
			SSGFPHair='Hair_SpikeSSB.dmi'
			SSRHair='Hair_SpikeSSR.dmi'
			SSGFPHair+=rgb(18,18,18)
	BlueHairMale
		hair='Hair, Blue, Male.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	Bushy
		hair='Hair, Bushy.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	HairHeadband
		hair='Hair, Brown, Headband.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	FemalePonytail
		hair='Hair, Female, Ponytail.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
	Messy
		hair='Hair, Messy.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	MalePonytail
		hair='Hair, Ponytail.dmi'
		New()
			..()
			SSjHair='Hair, Ponytail, SSJ.dmi'
			USSjHair=SSjHair
			SSjFPHair='Hair, Ponytail, SSJFP.dmi'
			SSj2Hair=SSjHair
			SSRHair='Hair_Ponytail_SSR.dmi'
	ShortFemale
		hair='Hair, Short Female.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	Ren
		hair='Hair, Ren.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	//80s hair='Zangya Hair.dmi'
	Goldilocks
		hair='Blonde hair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	Stylist
		hair='Brown flicky hair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	HairBun
		hair='BUN.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	HairBob
		hair='CHEGWEG BOB.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	PonytailLeft
		hair='CHEGWEG left side ponytail.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_Ponytail_SSR.dmi'
	PonytailBack
		hair='CHEGWEG ponytail.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_Ponytail_SSR.dmi'
	PonytailRight
		hair='CHEGWEG right side ponytail.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_Ponytail_SSR.dmi'
	Pigtails
		hair='CHEGWEG PIGTAILS.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_FemaleLongSSR.dmi'
	PigtailsHigh
		hair='High pigtails.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_FemaleLongSSR.dmi'
	PinnedBack
		hair='cosmic blue pinned back hair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_FemaleLongSSR.dmi'
	Emo
		hair='Emo hair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	LongHairHeadband
		hair='Female hair with pink alice band long.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	BlueHairAnime
		hair='Large blue hair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	Fop
		hair='GenesisHair.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	Mullet
		hair='HairBroly.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair=SSjHair
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
	Teaparty_Short
		hair='MalevolentTeaparty_Female_Short.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_FemaleLongSSR.dmi'
	Xander_Female
		hair='Xander_Female_Short.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_FemaleLongSSR.dmi'
	Xander_Terra
		hair='Xander_Terra.dmi'
		New()
			..()
			SSjHair=hair+rgb(150,150,0)
			USSjHair='Hair_FemaleLongSSj.dmi'
			SSjFPHair=hair+rgb(160,160,80)
			SSj2Hair=hair+rgb(160,160,20)
			SSGSSHair=SSjHair-rgb(150,0,0)
			SSGFPHair=SSjFPHair-rgb(155,0,0)
			SSGSSHair+=rgb(0,20,155)
			SSGFPHair+=rgb(0,20,155)
			SSRHair='Hair_FemaleLongSSR.dmi'

	Click()
		if(usr.HairChoose) return
		usr.HairChoose=1
		usr.HairRemove()
		usr.HairRemove()
		usr.overlays-=usr.hair
		usr.hair=hair
		usr.Hair_Base=hair
		usr.Hair_Age=usr.Age
		usr.SSjHair=SSjHair
		usr.USSjHair=USSjHair
		usr.SSjFPHair=SSjFPHair
		usr.SSj2Hair=SSj2Hair
		usr.SSj3Hair=SSj3Hair
		if(usr.gender=="female") usr.SSj4Hair='FemaleSSj4.dmi'
		else usr.SSj4Hair=SSj4Hair
		usr.SSGSSHair=SSGSSHair
		usr.SSGFPHair=SSGFPHair
		usr.SSRHair=SSRHair
		usr.SSGHair=usr.hair
		usr.HairX=0
		usr.HairY=0
		if(usr.hair)
			usr.SSGHair+=rgb(100,0,0)
			usr.SSGHair-=rgb(0,15,15)
			if(usr.Class=="Legendary")
				usr.SSjHair+=rgb(-5,30,0)
				usr.USSjHair+=rgb(-5,30,0)
				usr.SSjFPHair+=rgb(-5,30,0)
				usr.SSj2Hair+=rgb(-5,30,0)
				usr.SSj3Hair+=rgb(-5,30,0)
				usr.SSj4Hair+=rgb(0,30,0)
				usr.SSGSSHair+=rgb(0,30,-20)
				usr.SSGFPHair+=rgb(0,30,-20)
				usr.SSGHair+=rgb(90,15,0)
				usr.SSGHair-=rgb(0,0,15)
		if((usr.Race!="Saiyan"&&usr.hair)||(usr.Race=="Saiyan"&&usr.HasCreated)) if(usr.hair)
			usr.HairColor=input("Choose your hair color") as color|null
			if(usr.HairColor) usr.hair+=usr.HairColor
			if(usr.HairColor) usr.SSj4Hair+=usr.HairColor
		if(usr.Class=="Heran")if(usr.SSjHair)
			SSjHair-=rgb(0,155,0)
			usr.USSjHair-=rgb(0,155,0)
		if(usr.hair) usr.overlays+=usr.hair
		//usr.Waiter=0
		usr.HairChoose=0
		..()


mob
	var/HairX=0
	var/HairY=0
	var/HairLayer=9



mob/proc/HairRemove()
	overlays.Remove(hair,SSjHair,USSjHair,SSjFPHair,SSj2Hair,SSj3Hair,SSj4Hair,SSGFPHair,SSGSSHair,SSGHair,SSRHair)
	overlays-=hair

	var/hairselect=hair
	var/bighair=0
	if(!ssj&&GodKiActive&&Race=="Saiyan") hairselect=SSGHair
	//else if(!ssj&&GodKiActive&&Class=="Legendary") hairselect=SSj2Hair
	else if(!ssj|ismystic&&ssj<3) hairselect=hair
	else if(ssj&&ssj<3&&bighair) hairselect=USSjHair
	else if(ssj==1&&SSjDrain<300) hairselect=SSjHair
	else if(ssj==1) hairselect=SSjFPHair
	else if(ssj==2) hairselect=SSj2Hair
	else if(ssj==3) hairselect=SSj3Hair
	else if(ssj==4) hairselect=SSj4Hair
	else if(ssj==5)
		if(SSGSSColor=="Rose") hairselect=SSRHair
		else if(ssj==5&&SSGSSDrain<300) hairselect=SSGSSHair
		else if(ssj==5) hairselect=SSGFPHair
	var/image/_overlay = image(hairselect) // not sure if the equipped thing is an icon/object so
	_overlay.pixel_x = HairX
	_overlay.pixel_y = HairY
	_overlay.layer= HairLayer
	overlays -= _overlay

mob/proc/HairAdd()
	overlays.Remove(hair,SSjHair,USSjHair,SSjFPHair,SSj2Hair,SSj3Hair,SSj4Hair,SSGFPHair,SSGSSHair,SSGHair,SSRHair)
	overlays-=hair
	HairRemove()
	var/hairselect=hair
	var/bighair=0
	if(!ssj&&GodKiActive&&Race=="Saiyan") hairselect=SSGHair
	//else if(!ssj&&GodKiActive&&Class=="Legendary") hairselect=SSj2Hair
	else if(!ssj|ismystic&&ssj<3) hairselect=hair
	else if(ssj&&ssj<3&&bighair) hairselect=USSjHair
	else if(ssj==1&&SSjDrain<300) hairselect=SSjHair
	else if(ssj==1) hairselect=SSjFPHair
	else if(ssj==2) hairselect=SSj2Hair
	else if(ssj==3) hairselect=SSj3Hair
	else if(ssj==4) hairselect=SSj4Hair
	else if(ssj==5)
		if(SSGSSColor=="Rose") hairselect=SSRHair
		else if(ssj==5&&SSGSSDrain<300) hairselect=SSGSSHair
		else if(ssj==5) hairselect=SSGFPHair
	else if(Bojack) hairselect=SSGHair
	var/image/_overlay = image(hairselect) // not sure if the equipped thing is an icon/object so
	_overlay.pixel_x = HairX
	_overlay.pixel_y = HairY
	_overlay.layer= HairLayer
	overlays += _overlay
	