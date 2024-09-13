//We defining in this bitch


mob
	verb
		RedoBodySize()
			set name=".RedoBodySize"
			set hidden=1
			if(BodySizing) return
			if(Race=="Undefined")
				usr<<"You must choose Race first."
				return
			if(!(winget(usr,"CharacterCreator","is-visible")=="true")) return
			if(HasCreated==1&&!Redoing_Stats) return
			if(!ImDoingStats) return
			BodySizing=1
			ImDoingStats=0
			Total_Stats_Energy=0
			Total_Stats_Strength=0
			Total_Stats_Endurance=0
			Total_Stats_Speed=0
			Total_Stats_Off=0
			Total_Stats_Def=0
			Total_Stats_Regen=0
			Total_Stats_Recov=0
			AssignRaceStats()
			Stat_Point_Window_Refresh()
			Set_Minimum_Stats()
			Body_Sizes()
			BodyStatGive()
			KiMod=Minimum_Stats["Eff"]
			SpdMod=Minimum_Stats["Spd"]
			StrMod=Minimum_Stats["Str"]
			EndMod=Minimum_Stats["End"]
			OffMod=Minimum_Stats["Off"]
			DefMod=Minimum_Stats["Def"]
			BaseRegeneration=Minimum_Stats["Reg"]
			BaseRecovery=Minimum_Stats["Rec"]
			if(Race == "Alien")
				Points=65
				Max_Points = 65
			else
				Points = 15
				Max_Points = 15
			if(Offspring) Points=0
			PointsSpent=0
			BodySizing=0
			ImDoingStats=1
			Stat_Point_Window_Refresh()
	var
		Size = "Medium"
		tmp/BodySizing=0
	proc
		Body_Sizes()	//In leiu of changing stats directly here, it's done in races.dm in each race proc.. :(
			if(Offspring) return
			switch(Size)
				if("Small")
					src.Size = "Medium"
				if("Medium")
					src.Size = "Large"
				if("Large")
					src.Size = "Small"
			Stat_Point_Window_Refresh()
		BodyStatGive()
			if(Offspring) return
			switch(src.Size)
				if("Small")
					Minimum_Stats["End"]*=0.9
					Minimum_Stats["Spd"]*=1.1
				if("Medium")
					Minimum_Stats["Reg"]*=1.1
				if("Large")
					Minimum_Stats["End"]*=1.1
					Minimum_Stats["Spd"]*=0.9

			KiMod=Minimum_Stats["Eff"]
			SpdMod=Minimum_Stats["Spd"]
			StrMod=Minimum_Stats["Str"]
			EndMod=Minimum_Stats["End"]
			OffMod=Minimum_Stats["Off"]
			DefMod=Minimum_Stats["Def"]
			BaseRegeneration=Minimum_Stats["Reg"]
			BaseRecovery=Minimum_Stats["Rec"]

			KiMod=round(KiMod,0.01)
			StrMod=round(StrMod,0.01)
			EndMod=round(EndMod,0.01)
			SpdMod=round(SpdMod,0.01)
			OffMod=round(OffMod,0.01)
			DefMod=round(DefMod,0.01)
			BaseRegeneration=round(BaseRegeneration,0.01)
			BaseRecovery=round(BaseRecovery,0.01)

/*
			src<<{"
KiMod=[Minimum_Stats["Eff"]]
SpdMod=[Minimum_Stats["Spd"]]
StrMod=[Minimum_Stats["Str"]]
EndMod=[Minimum_Stats["End"]]
OffMod=[Minimum_Stats["Off"]]
DefMod=[Minimum_Stats["Def"]]
BaseRegeneration=[Minimum_Stats["Reg"]]
BaseRecovery=[Minimum_Stats["Rec"]]
"}*/


		GiveBodyParts()
			set background=1
			set waitfor=0
			
			if(!locate(/BodyPart/Head) in src) src.contents+=new/BodyPart/Head(src)
			if(!locate(/BodyPart/Eyes) in src) src.contents+=new/BodyPart/Eyes(src)
			if(!locate(/BodyPart/Throat) in src) if(Race!="Android")  if(Race!="Majin") src.contents+=new/BodyPart/Throat(src)
			if(!locate(/BodyPart/Chest) in src) src.contents+=new/BodyPart/Chest(src)
			if(!locate(/BodyPart/Ears) in src) if(Race!="Android") if(Race!="Majin") src.contents+=new/BodyPart/Ears(src)
			if(!locate(/BodyPart/Left_Arm) in src) src.contents+=new/BodyPart/Left_Arm(src)
			if(!locate(/BodyPart/Left_Leg) in src) src.contents+=new/BodyPart/Left_Leg(src)
			if(!locate(/BodyPart/Right_Arm) in src) src.contents+=new/BodyPart/Right_Arm(src)
			if(!locate(/BodyPart/Right_Leg) in src) src.contents+=new/BodyPart/Right_Leg(src)
			if(!locate(/BodyPart/Reproduction) in src) contents+=new/BodyPart/Reproduction(src)
			if(!locate(/BodyPart/Tail) in src) if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Primal") contents+=new/BodyPart/Tail(src)
			if(!locate(/BodyPart/TailChangeling) in src) if(Race=="Changeling") contents+=new/BodyPart/TailChangeling(src)
			if(!locate(/obj/Resources) in src) contents+=new/obj/Resources
			if(!locate(/obj/Mana) in src) contents+=new/obj/Mana
//			if(!locate(/obj/RPMode) in src) contents+=new/obj/RPMode

/*
mob/verb/CheckMySize()
	var/mSize=5
	if(Total_Stats_Strength) mSize+=Total_Stats_Strength
	if(Total_Stats_Endurance) mSize+=Total_Stats_Endurance

	if(Total_Stats_Speed) mSize-=Total_Stats_Speed
	if(Total_Stats_Def) mSize-=Total_Stats_Def

	if(mSize<=2) Size="Agile"
	else if(mSize>=8) Size="Muscular"
	else Size="Skilled"
	usr<<"mSize [mSize] Size [Size]"

mob/proc/BodySizeCheck()
	var/mSize=5
	if(Total_Stats_Strength) mSize+=Total_Stats_Strength
	if(Total_Stats_Endurance) mSize+=Total_Stats_Endurance

	if(Total_Stats_Speed) mSize-=Total_Stats_Speed
	if(Total_Stats_Def) mSize-=Total_Stats_Def

	if(mSize<=2) Size="Agile"
	else if(mSize>=8) Size="Muscular"
	else Size="Skilled"
	winset(src.client,"BodySizeLabel","text=\"[Size]\"")
*/
mob/verb/Check_Stat_Points()
	set category="Other"
	if(Total_Stats_Recov) usr<<"[Total_Stats_Recov] points in Energy"
	if(Total_Stats_Strength) usr<<"[Total_Stats_Strength] points in Strength"
	if(Total_Stats_Endurance) usr<<"[Total_Stats_Endurance] points in Endurance"
	if(Total_Stats_Speed) usr<<"[Total_Stats_Speed] points in Speed"
	if(Total_Stats_Off) usr<<"[Total_Stats_Off] points in Offense"
	if(Total_Stats_Def) usr<<"[Total_Stats_Def] points in Defense"
	
