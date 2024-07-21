



mob/var
	HasMorphine=0
	MorphineAddiction=0
	HasPercocet=0
	PercocetAddiction=0
	HasDrugs=0
	HasCialis=0
	HasVitamins=0
	HasMethyl=0
	HasEpinephrine=0
	EpinephrineAddiction=0
mob/proc/DrugLoss()
	if(HasMorphine>0)HasMorphine--
	if(HasPercocet>0)HasPercocet--
	if(HasCialis>0)HasCialis--
	if(HasVitamins>0)HasVitamins--
	if(HasMethyl>0)HasMethyl--
	if(HasEpinephrine>0)HasEpinephrine--
	if(!HasPercocet&&!HasMorphine&&!HasCialis&&!HasEpinephrine&&!HasVitamins&&!HasMethyl) HasDrugs=0
	else if(!HasDrugs) HasDrugs++
	if(!HasDrugs)
		HasMorphine=0
		MorphineAddiction=0
		HasPercocet=0
		PercocetAddiction=0
		HasDrugs=0
		HasCialis=0
		HasVitamins=0
		HasMethyl=0
		HasEpinephrine=0
		EpinephrineAddiction=0
		src<<"The drug's effects have worn off."

obj/items/drugs
	Morphine
		icon='enchantmenticons.dmi'
		icon_state="SilverCoin"
		desc="Causes you to ignore limb damage, but while you have broken limbs causes you to drain WP at 1.5x the rate for each regen tick. This may be addictive. (Lasts 5 minutes per dose)"
		Flammable = 1

		verb
			Use()
				if(usr.KOd==0)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
					view(usr)<<"[usr] takes a dose of [src]."
					usr.HasMorphine+=200
					usr.HasDrugs+=200
					usr.MorphineAddiction++
					usr.UsedDrugs++
					del(src)
	Percocet
		icon='enchantmenticons.dmi'
		icon_state="GoldCoin"
		desc="Causes low HP to only reduce BP to 70% instead of 30%, but reduces recovery ticks by 40%. This may be addictive. (Lasts 5 minutes per dose)"
		Flammable = 1

		verb
			Use()
				if(usr.KOd==0)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
					view(usr)<<"[usr] takes a dose of [src]."
					usr.HasPercocet+=200
					usr.HasDrugs+=200
					usr.PercocetAddiction++
					usr.UsedDrugs++
					del(src)

	Epinephrine
		icon='Roids.dmi'
		icon_state="2"
		desc="Causes you to gain the acceleration buff for the duration of the drug but lowers decline age on use. This may be addictive. (Lasts 5 minutes per dose)"
		Flammable = 1

		New()
			..()
			icon-=rgb(35,35,35)
		verb
			Use()
				if(usr.KOd==0)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
					view(usr)<<"[usr] takes a dose of [src]."
					usr.HasEpinephrine+=200
					usr.HasDrugs+=200
					usr.Decline-=0.2
					usr.EpinephrineAddiction++
					usr.UsedDrugs++
					del(src)


	Cialis
		icon='enchantmenticons.dmi'
		icon_state="GoldCoin"
		desc="Causes you to lose 30% HP regen but allows mating in decline. (Lasts 5 minutes per dose)"
		Flammable = 1

		New()
			..()
			icon-=rgb(75,75,75)
		verb
			Use()
				if(usr.KOd==0)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
					view(usr)<<"[usr] takes a dose of [src]."
					usr.HasCialis+=200
					usr.HasDrugs+=200
					usr.UsedDrugs++
					del(src)

	Vitamins
		icon='enchantmenticons.dmi'
		icon_state="GoldCoin"
		desc="Causes you to gain stats faster for a period of time."
		Flammable = 1

		New()
			..()
			icon-=rgb(75,75,75)
		verb
			Use()
				if(usr.KOd==0)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
					view(usr)<<"[usr] takes a dose of [src]."
					usr.HasVitamins+=1000
					usr.HasDrugs+=1000
					usr.UsedDrugs++
					del(src)


	Methylphenidate
		icon='enchantmenticons.dmi'
		icon_state="SilverCoin"
		desc="Causes you to gain Int and Magic EXP faster for a period of time."
		Flammable = 1

		New()
			..()
			icon-=rgb(0,0,75)
		verb
			Use()
				if(usr.KOd==0)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
					view(usr)<<"[usr] takes a dose of [src]."
					usr.HasMethyl+=1000
					usr.UsedDrugs++
					usr.HasDrugs+=1000
					del(src)

	Super_Anti_Virus
		icon='enchantmenticons.dmi'
		icon_state="GoldCoin"
		desc="Cures the infection."
		Flammable = 1

		New()
			..()
			icon-=rgb(0,100,25)
		verb
			Use()
				if(usr.KOd==0)
					usr.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] takes a dose of [src].\n")
					view(usr)<<"[usr] takes a dose of [src]."
					usr.Infection=0
					usr.UsedDrugs++
					usr.RemoveVampire_Skills()
					usr.RemoveWerewolf_Skills()
					del(src)









