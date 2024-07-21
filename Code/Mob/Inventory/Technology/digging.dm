Event/Timer/DigTimer
	var/tmp/mob/digger
	var/tmp/id
	var/tmp/LastTick
	var/tmp/LastTickR

	New(var/EventScheduler/scheduler, var/mob/D, var/_id)
		src.digger = D
		src.id = _id
		if(digger.digging_event) // If they're spamming the macro and they already triggered a dig macro, kill it.
			digger << "<span class=announce>SYSTEM: Multiple dig instances found. Canceling dig. (macro spam?)</span>"
			digger.Cancel_Digging()
			return

		..(scheduler, 100)

	fire()
		..()
		if(isnull(digger) || isnull(digger.client)){technology_scheduler.cancel(src);return} // sanity, it is important.
		if(id!=digger.training_id) digger.Cancel_Digging()
		if(id!=digger.training_id){technology_scheduler.cancel(src);return} // Still some dig events scheduled that dont belong to the current digging event? Kill them.
		if(isnull(digger.digging_event)){digger.Cancel_Digging();return}
		if(digger.icon_state=="Meditate"&&digger.digging)
			if(digger.Dig_Clicks > 2)
				digger.Dig_Clicks -= 1
				return
			digger.Increase_GainMultiplier(0.5)
			var/N = 1 * digger.GravMulti
			digger.BaseGain(N)
			digger.StatGains(Rate=1,Energy=1,Might=0,Endurance=0,Speed=0,Offense=0,Defense=0)

			var/DigPower = rand(5,20)
			var/obj/items/Digging/DT
			//if(locate(/obj/items/Digging) in digger)DT=
			for(var/obj/items/Digging/digging_tool in digger) if(digging_tool.suffix) DT=digging_tool//DigPower *= digging_tool.DigMult+digging_tool.ExtraDigMult
			if(DT) DigPower*=DT.DigMult
			if(digger.HasMiningExpert) DigPower*=1.5
			if(digger.RestedTime>world.realtime)DigPower*=1.25
			if(digger.InspiredTime>world.realtime)DigPower*=1.5
			if(digger.Race=="Space Pirate") DigPower*=1.5
			DigPower = round(DigPower)


			var/Taxes=0
			switch(digger.z)
				if(1)Taxes=(Z1Tax/100)*DigPower
				if(2)Taxes=(Z2Tax/100)*DigPower
				if(3)Taxes=(Z3Tax/100)*DigPower
				if(4)Taxes=(Z4Tax/100)*DigPower
				if(5)Taxes=(Z5Tax/100)*DigPower
				if(6)Taxes=(Z6Tax/100)*DigPower
				if(7)Taxes=(Z7Tax/100)*DigPower
			Taxes=round(Taxes)
			var/TPerc=round(Taxes/DigPower)*100
			/*switch(digger.z)
				if(1)if(Z1FactionTax)if(digger.FactionApproved(Z1FactionCode,Z1FactionTax))Taxes=0
				if(2)if(Z2FactionTax)if(digger.FactionApproved(Z2FactionCode,Z2FactionTax))Taxes=0
				if(3)if(Z3FactionTax)if(digger.FactionApproved(Z3FactionCode,Z3FactionTax))Taxes=0
				if(4)if(Z4FactionTax)if(digger.FactionApproved(Z4FactionCode,Z4FactionTax))Taxes=0
				if(5)if(Z5FactionTax)if(digger.FactionApproved(Z5FactionCode,Z5FactionTax))Taxes=0
				if(6)if(Z6FactionTax)if(digger.FactionApproved(Z6FactionCode,Z6FactionTax))Taxes=0
				if(7)if(Z7FactionTax)if(digger.FactionApproved(Z7FactionCode,Z7FactionTax))Taxes=0*/
			for(var/obj/Resources/resource_bag in digger)
				if(Taxes)
					if(digger.IgnoreTaxes&&digger.Race!="Heran")
						switch(digger.z)
							if(1)
								Z1TaxEvaders["[digger.name]"]+=Taxes
						//		else Z1TaxEvaders.Add("[digger.name]"=Taxes)
							if(2)
								Z2TaxEvaders["[digger.name]"]+=Taxes
						//		else Z2TaxEvaders.Add("[digger.name]"=Taxes)
							if(3)
								Z3TaxEvaders["[digger.name]"]+=Taxes
						//		else Z3TaxEvaders.Add("[digger.name]"=Taxes)
							if(4)
								Z4TaxEvaders["[digger.name]"]+=Taxes
						//		else Z4TaxEvaders.Add("[digger.name]"=Taxes)
							if(5)
								Z5TaxEvaders["[digger.name]"]+=Taxes
						//		else Z5TaxEvaders.Add("[digger.name]"=Taxes)
							if(6)
								Z6TaxEvaders["[digger.name]"]+=Taxes
							//	else Z6TaxEvaders.Add("[digger.name]"=Taxes)
							if(7)
								Z7TaxEvaders["[digger.name]"]+=Taxes
								//else Z7TaxEvaders.Add("[digger.name]"=Taxes)
						Taxes=0
					else if(digger.Race=="Oni")
						digger.TaxPaid+=Taxes
				resource_bag.Value+=DigPower-Taxes
				switch(digger.z)
					if(1)Z1ReserveResources+=Taxes
					if(2)Z2ReserveResources+=Taxes
					if(3)Z3ReserveResources+=Taxes
					if(4)Z4ReserveResources+=Taxes
					if(5)Z5ReserveResources+=Taxes
					if(6)Z6ReserveResources+=Taxes
					if(7)Z7ReserveResources+=Taxes
				if(digger.ToggleViewResMana) digger.CombatOut("Gained [DigPower-Taxes] Resources ([Taxes] Taxed, [TPerc] %)")
				break
		else
			digger.Cancel_Digging()
			digger = null

mob/var/tmp/Event/Timer/DigTimer/digging_event = null
mob/var/tmp/digging = 0
mob/var/tmp/Dig_Clicks = 0
mob/proc/Cancel_Digging()
	if(!istype(src,/mob/player)) return
	if(src.digging_event)
		technology_scheduler.cancel(src.digging_event)
		src.icon_state = ""
		//spawn(15)
		digging=0
		src.digging_event = null
	training_id=null

mob/verb/Dig()
	set category = "Other"
	if(ActionCheck) return
	ActionCheck=1
	spawn(15)ActionCheck=0
	BeginDig()


mob/proc/BeginDig()
	if(isturf(src.loc))
		if(src.digging)
			src << "Wait a while before trying to dig again."
			src.Cancel_Digging()
			src.icon_state = ""
			return
		if(KOd || icon_state=="Train"|| icon_state=="Meditate" ) return
	//	sleep(5)
		if(icon_state!="") return
		if(isnull(src.digging_event))
			var/turf/TT = src.loc
			if(TT.Inside)
				src << "You will not find any resources in this area..."
				return
			src.digging = 1
			src << "You begin digging for resources."
			src.Dig_Clicks += 1
			icon_state = "Meditate"
			Cancel_Digging()
			//sleep(10) // Sleep for 1.5 seconds to allow previous digging to be canceled.
					// This is required because apparently, setting a macro on repeat allows you to stack them regardless.
			spawn()
				src.training_id="[src][rand()]"
				src.digging_event = new(technology_scheduler, src, training_id)
				technology_scheduler.schedule(src.digging_event, 60)
		else Cancel_Digging()
