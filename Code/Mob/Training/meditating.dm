Event/Timer/MedTimer
	var/tmp/mob/trainer
	var/id
	var/ManaTicks=0
	var/FatigueTicks=0

	New(var/EventScheduler/scheduler, var/mob/player/D, var/_id)
		src.trainer = D
		src.id = _id
		if(trainer.meditating_event) // If they spammed a macro to spam hundreds of triggers, let's spam them back in turn.
			trainer << "<span class=announce>SYSTEM: Multiple meditate instances found. Canceling your current actions. (macro spam?)</span>"
			trainer.Cancel_Meditation()
			return
		..(scheduler, 20)
	fire()
		..()
		if(isnull(trainer) || isnull(trainer.client)){training_scheduler.cancel(src);return}
		if(id!=trainer.training_id && id!="reward"){training_scheduler.cancel(src);return} // if the id the player has mismatches the id for the scheduled event, the event will cancel.
		if(isnull(trainer.meditating_event) ){trainer.Cancel_Meditation();return}
		if(trainer.CurrentAction=="Meditating"&&trainer.BPpcnt>=101){trainer.BPpcnt=100;return}
		if(trainer.CurrentAction=="Meditating"&&trainer.Fatigue > 0)
			var/hasBed = 0
			var/current = FatigueTicks
			for(var/obj/Props/Chairs/C in range(0,trainer)) hasBed=1
			for(var/obj/items/Bedroll/B in range(0,trainer))
				if(B in trainer.contents) continue
				hasBed=2
			for(var/obj/Props/Beds/Q in range(1,trainer)) hasBed=3
			for(var/obj/Turfs/Bed/C in range(1,trainer)) hasBed=3
			for(var/obj/Turfs/LargeBed/C in range(1,trainer)) hasBed=3
			if(hasBed)
				FatigueTicks++
				if(FatigueTicks>=9)
					FatigueTicks = 0
					var/drain = (rand(25,50)*hasBed)/100
					trainer.Fatigue -= drain
					if(trainer.Fatigue < 0)
						trainer.Fatigue = 0
			/*else
				FatigueTicks++
				if(FatigueTicks>=9)
					FatigueTicks = 0
					var/drain = rand(25,50)/100
					trainer.Fatigue -= drain
					if(trainer.Fatigue < 0)
						trainer.Fatigue = 0*/
			if(FatigueTicks != current)
				return
		if(trainer.CurrentAction=="Meditating"||trainer.medreward||trainer.medrewardmagic)
//			trainer.EZCleanse()
			var/TrainingInc=1
			if(trainer.HasStateOfZen) TrainingInc=1+(trainer.HasStateOfZen*0.5)
			trainer.Increase_GainMultiplier(0.5)
			if(prob(0.001*(trainer.BaseRegeneration+trainer.BaseRecovery))) trainer.Decline+=0.1
			if(trainer.Ki<trainer.MaxKi) // Ki regeneration while meditating
				trainer.Ki+=0.009*trainer.MaxKi*trainer.Recovery*(trainer.Base/(trainer.Base+(trainer.RoidPower*2)))
				if(trainer.Ki>trainer.MaxKi) trainer.Ki=trainer.MaxKi
			if(trainer.ifocus=="Intelligence")
				var/N = 1 * trainer.GravMulti
				var/NI= trainer.IntCapCheck(trainer.Int_Level,trainer.Int_Mod)
				N*=TrainingInc
				trainer.BaseGain(N*trainer.MedMod)
				var/NBC=1
				for(var/obj/items/Bookcase/C in range(2,trainer)) NBC = 50
				trainer.Int_XP+=(10+NBC)*Admin_Int_Setting*NI*trainer.IntCatchUp()
				trainer.StatGains(Rate=1,Energy=1,Might=0,Endurance=0,Speed=0,Offense=0,Defense=0)
				//if(trainer.BaseMaxKi<EnergyHardCap*trainer.KiMod) trainer.BaseMaxKi+=0.0015*trainer.KiMod*EnergyGainSpeed*trainer.EnergyCapCheck(trainer.BaseMaxKi/trainer.KiMod)
				if(trainer.Int_Level_Up_Check(trainer.Int_XP)) trainer.Int_Level_Up()
			if(trainer.magicfocus=="Magical Skill")
				var/N = 1 * trainer.GravMulti
				var/NI= trainer.IntCapCheck(trainer.Magic_Level,trainer.Magic_Potential)
				N*=TrainingInc
				trainer.BaseGain(N*trainer.MedMod)
				var/NBC=1
				for(var/obj/items/Bookcase/C in range(2,trainer)) NBC = 50
				trainer.Magic_XP+=(10+NBC)*Admin_Int_Setting*NI*trainer.MagicCatchUp()
				trainer.StatGains(Rate=1,Energy=1,Might=0,Endurance=0,Speed=0,Offense=0,Defense=0)
//				if(trainer.BaseMaxKi<EnergyHardCap*trainer.KiMod) trainer.BaseMaxKi+=0.0015*trainer.KiMod*EnergyGainSpeed*trainer.EnergyCapCheck(trainer.BaseMaxKi/trainer.KiMod)
				if(trainer.Magic_Level_Up_Check(trainer.Magic_XP)) trainer.Magic_Level_Up()
				ManaTicks++
			else if(trainer.ifocus == 0&&trainer.magicfocus == 0)
				trainer.StatGains(Rate=0.5*TrainingInc,Energy=1,Might=0,Endurance=0,Speed=0,Offense=0,Defense=0)
				var/N = 2 * trainer.GravMulti
				N*=TrainingInc
				trainer.BaseGain(N*trainer.MedMod)
			if(trainer.medreward>0)
				trainer.medreward-- // Medreward determines how many levels are left
				trainer.Int_XP = 40*(trainer.Int_Next/trainer.Int_Mod)
				if(trainer.Int_Level_Up_Check(trainer.Int_XP)) trainer.Int_Level_Up()
			else if(trainer.medrewardmagic>0)
				trainer.medrewardmagic-- // Medreward determines how many levels are left
				trainer.Magic_XP = 40*(trainer.Magic_Next/trainer.Magic_Potential)
				if(trainer.Magic_Level_Up_Check(trainer.Magic_XP)) trainer.Magic_Level_Up()

			if(trainer.BPpcnt>100)
				trainer.BPpcnt-=trainer.Recovery
				if(trainer.BPpcnt<100) trainer.BPpcnt=100
			if(trainer.magicfocus==5&&trainer.ifocus==5) ManaTicks++
			if(ManaTicks>=9)
				ManaTicks=0
				var/DigPower = rand(5,10)
				var/obj/items/Spell_Book/Book
				if(locate(/obj/items/Spell_Book) in trainer)Book=locate(/obj/items/Spell_Book) in trainer// for(var/obj/items/Spell_Book/B in trainer) Book = B
				if(locate(/obj/items/Magic_Circle) in trainer) DigPower += 5
				if(Book) DigPower*=Book.ManaMult+Book.ExtraManaMult
				if(trainer.HasManaExpert) DigPower*=1.5
				if(trainer.RestedTime>world.realtime)DigPower*=1.25
				if(trainer.InspiredTime>world.realtime)DigPower*=1.5
				if(trainer.Race=="Space Pirate") DigPower*=1.5
				DigPower = round(DigPower)
				var/Taxes=0
				switch(trainer.z)
					if(1)Taxes=(Z1Tax/100)*DigPower
					if(2)Taxes=(Z2Tax/100)*DigPower
					if(3)Taxes=(Z3Tax/100)*DigPower
					if(4)Taxes=(Z4Tax/100)*DigPower
					if(5)Taxes=(Z5Tax/100)*DigPower
					if(6)Taxes=(Z6Tax/100)*DigPower
					if(7)Taxes=(Z7Tax/100)*DigPower
				var/TPerc=round(Taxes/DigPower)*100
				Taxes=round(Taxes)
				for(var/obj/Mana/ManaBag in trainer)
					if(Taxes)
						if(trainer.IgnoreTaxes&&trainer.Race!="Heran")
							switch(trainer.z)
								if(1)
									Z1MTaxEvaders["[trainer.name]"]+=Taxes
								//	else Z1MTaxEvaders.Add("[trainer.name]"=Taxes)
								if(2)
									Z2MTaxEvaders["[trainer.name]"]+=Taxes
								//	else Z2MTaxEvaders.Add("[trainer.name]"=Taxes)
								if(3)
									Z3MTaxEvaders["[trainer.name]"]+=Taxes
								//	else Z3MTaxEvaders.Add("[trainer.name]"=Taxes)
								if(4)
									Z4MTaxEvaders["[trainer.name]"]+=Taxes
								//	else Z4MTaxEvaders.Add("[trainer.name]"=Taxes)
								if(5)
									Z5MTaxEvaders["[trainer.name]"]+=Taxes
								//	else Z5MTaxEvaders.Add("[trainer.name]"=Taxes)
								if(6)
									Z6MTaxEvaders["[trainer.name]"]+=Taxes
							//		else Z6MTaxEvaders.Add("[trainer.name]"=Taxes)
								if(7)
									Z7MTaxEvaders["[trainer.name]"]+=Taxes
							//		else Z7MTaxEvaders.Add("[trainer.name]"=Taxes)
							Taxes=0
						else if(trainer.Race=="Oni")
							trainer.MTaxPaid=Taxes
					ManaBag.Value+=DigPower-Taxes
					switch(trainer.z)
						if(1)Z1ReserveMana+=Taxes
						if(2)Z2ReserveMana+=Taxes
						if(3)Z3ReserveMana+=Taxes
						if(4)Z4ReserveMana+=Taxes
						if(5)Z5ReserveMana+=Taxes
						if(6)Z6ReserveMana+=Taxes
						if(7)Z7ReserveMana+=Taxes
					if(trainer.ToggleViewResMana) trainer.CombatOut("Gained [DigPower-Taxes] Mana ([Taxes] Taxed, [TPerc] %)")
					break

			trainer.PassiveSkillsIncrease(0.05,0,0,0.025)//ki,sword,unarmed,evasion

			if(trainer.GodKiActive==0) if(trainer.GodKi<trainer.MaxGodKi)
				trainer.GodKi+=0.05
				if(trainer.GodKi>trainer.MaxGodKi)trainer.GodKi=trainer.MaxGodKi
		else
			trainer.Cancel_Meditation()
			trainer=null

mob/var/tmp/Event/Timer/MedTimer/meditating_event = null

mob/proc/Cancel_Meditation()
	if(!istype(src,/mob/player)) return
	if(src.meditating_event)
		training_scheduler.cancel(src.meditating_event)
		spawn(2) src.meditating_event = null
	//Cancel_Mana()
	if( src.Flying || src.KOd || src.attacking ) return
	else
		src.icon_state = ""
		src.move=1
	training_id=null
	CurrentAction=null

mob/proc/Int_Level_Up_Check(IntXP) if(IntXP>40*(Int_Next/Int_Mod)) return 1
mob/proc/Magic_Level_Up_Check(MagXP) if(MagXP>40*(Magic_Next/Magic_Potential)) return 1
mob/proc/Int_Level_Up() //while(Int_Level_Up_Check(Int_XP)) // I've uncommented the while as it makes no sense to keep leveling while it returns 1. 
							//They should just meditate for this and Meditate actively checks IF they've leveled up assuming they're focused on intelligence.
	var/ADD = src.Int_Mod
	if(src.Critical_Head) ADD = src.Int_Mod*2
	Int_XP-=40*(Int_Next/ADD)
	Int_Next=round(Int_Next*1.03)
	Int_Level++
mob/proc/Magic_Level_Up() //while(Int_Level_Up_Check(Int_XP)) // I've uncommented the while as it makes no sense to keep leveling while it returns 1. 
							//They should just meditate for this and Meditate actively checks IF they've leveled up assuming they're focused on intelligence.
	var/POTENT = src.Magic_Potential
	if(src.Critical_Head) POTENT = src.Magic_Potential*2
	Magic_XP-=40*(Magic_Next/POTENT)
	Magic_Next=round(Magic_Next*1.03)
	Magic_Level++



mob/proc/Med()
	if(src.Flying || src.KOd|| src.icon_state=="KB"|| src.attacking ||src.CurrentAction=="Training") return
	if(adminDensity)
		src << "You're currently in Ghost Form. Disable it first."
		return
	if(isnull(src.meditating_event)&&isnull(src.training_event))
		training_id="[src][rand()]"
		if(src.medreward || src.medrewardmagic)
			src.icon_state="Meditate"
			src.meditating_event = new(training_scheduler, src, "reward") // we're assigning a different id so that rewards in this manner actually do NOT get killed.
			training_scheduler.schedule(src.meditating_event, 20)
		else if(src.icon_state!="Meditate") if(src.move) //&&!Smoke_Form())
			src.dir=SOUTH
			src.icon_state="Meditate"
			src.CurrentAction="Meditating"
			if(src.magicfocus=="Magical Skill") usr << "You begin to draw ambient magical energy into yourself."
			if(src.ifocus=="Intelligence") usr << "You begin to study and improve your knowledge and intelligence."
			src.meditating_event = new(training_scheduler, src, training_id)
			training_scheduler.schedule(src.meditating_event, 20)
/*
			if(src.magicfocus=="Magical Skill"||src.magicfocus==5&&src.ifocus==5)
				src.mana_event = new(training_scheduler, src, training_id)
				training_scheduler.schedule(src.mana_event, 60)*/
	else src.Cancel_Meditation()

mob/var/tmp/ActionCheck=0
mob/verb/Meditate()
	set category="Other"
	if(ActionCheck) return
//	if(getCooldown("Meditate")>world.time) return 0
//	else setCooldown("Meditate",10)
	ActionCheck=1
	spawn(10)ActionCheck=0
	if(usr.InAutoAttack) usr.Toggle_Auto_Attack()
	usr.Med()

