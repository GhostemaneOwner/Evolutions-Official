mob
	Del() // Makes it so any mob, including NPC, execute the following commands when deleted from the game world.
	//	if(src.client) // Check if it's a player.
		src.Cancel_Training() // Checks if the player was training upon deletion, and if they were, removes that task from the scheduler.
		src.Cancel_PowerControl()
		src.Stop_TrainDig_Schedulers()
		src.RevertAll()
		sleep(0)
			//Add the other Cancel() proc's here, like Cancel_Digging() for example.
		..()
//The isnull med timer bug probably initiates from fixing stack bugs.  Check it out when I have a chance. - 10/6/2013
Event/Timer/TrainTimer
	var/tmp/mob/trainer
	var/id

	New(var/EventScheduler/scheduler, var/mob/player/D, var/_id)
		src.trainer = D
		src.id = _id
		if(trainer.training_event) // If they spammed a macro to spam hundreds of triggers, let's spam them back in turn.
			trainer << "<span class=announce>SYSTEM: Multiple training instances found. Canceling your current actions. (macro spam?)</span>"
			trainer.Cancel_Training()
			return
		..(scheduler, 20)
	fire()
		..()
		if(isnull(trainer) || isnull(trainer.client)) {training_scheduler.cancel(src);return} // if trainer has no client then the player is no longer logged in
		if(id!=trainer.training_id){training_scheduler.cancel(src);return} // if the id the player has mismatches the id for the scheduled event, the event will cancel.
		if(isnull(trainer.training_event) ){trainer.Cancel_Training();return}

		if(trainer.CurrentAction=="Training"&&trainer.Ki>=0.5*(trainer.Weight**2.5))
			if(trainer.HasBoundlessStamina) trainer.Ki=max(0,trainer.Ki-0.05*(trainer.Weight**2.5))
			else trainer.Ki=max(0,trainer.Ki-0.5*(trainer.Weight**2.5))//if(!trainer.HasBoundlessStamina)
//			trainer.EZCleanse()
//injure
		//	if(trainer.z==10) trainer.Ki-=9*(1/trainer.Recovery)*(trainer.Weight**3)
			var/N = 3 * trainer.GravMulti
			var/TrainingInc=1
			if(trainer.HasBodyBuilder) TrainingInc=1+(trainer.HasBodyBuilder*0.5)
			N*=TrainingInc
			trainer.BaseGain(N)//var/NE=1
			//if(trainer.BaseMaxKi>EnergySoftCap*trainer.KiMod) NE=0.6
			//if(trainer.BaseMaxKi<EnergyHardCap*trainer.KiMod) trainer.BaseMaxKi+=0.001*trainer.KiMod*EnergyGainSpeed*trainer.EnergyCapCheck(trainer.BaseMaxKi/trainer.KiMod)
			var/OffDefGains=0
			if(trainer.pfocus=="Skills")OffDefGains=1
			trainer.StatGains(Rate=TrainingInc,Energy=1,Might=1-OffDefGains,Endurance=1-OffDefGains,Speed=0.7,Offense=OffDefGains,Defense=OffDefGains)

			trainer.Increase_GainMultiplier(1)
//			if(trainer.GodKi&&Global_GodKiTrain) if(prob(10)) if(trainer.GodKi<trainer.MaxGodKi&&trainer.GodKi<Global_GodKiCap) trainer.GodKi+=0.005
			if(trainer.SwordOn||trainer.HammerOn) trainer.PassiveSkillsIncrease(0,0.05,0,0.025)//ki,sword,unarmed,evasion
			else if(trainer.KiBlade||trainer.KiHammer) trainer.PassiveSkillsIncrease(0.05,0,0,0.025)//ki,sword,unarmed,evasion
			else if(trainer.KiFists) trainer.PassiveSkillsIncrease(0.025,0,0.025,0.025)//ki,sword,unarmed,evasion
			else trainer.PassiveSkillsIncrease(0,0,0.05,0.025)//ki,sword,unarmed,evasion

		else
			trainer.Cancel_Training()
			trainer=null
			/*
			* Trainer=null Is a dirty trick intent to make sure \
			* the proc actually shuts down when you're KO'd.
			* Else it'll wait until you're back up until it actually STOPS the proc.
			*/

mob/var/tmp/Event/Timer/TrainTimer/training_event = null

mob/proc/Cancel_Training() // Cancel training is used for both meditating AND training.

	if(!istype(src,/mob/player)) return
	if (src.training_event)
		training_scheduler.cancel(src.training_event)
		spawn(2) src.training_event = null
	if( src.Flying || src.KOd || src.attacking ) return
	else
		src.icon_state = ""
		src.move=1
	training_id=null
	CurrentAction=null

mob/verb/Train()
	set category="Other"
	if(CurrentAction=="Meditating" || Flying||KOd|| icon_state=="KB"|| attacking ) return
	if(ActionCheck) return
	if(adminDensity)
		src << "You're currently in Ghost Form. Disable it first."
		return
//	if(getCooldown("Train")>world.time) return 0
//	else setCooldown("Train",10)
	ActionCheck=1
	spawn(10)ActionCheck=0
	if(usr.InAutoAttack) usr.Toggle_Auto_Attack()
	BeginTrain()

mob/proc/BeginTrain()
	if(isnull(src.training_event))
		if(isnull(src.meditating_event)) // This is just so the 'you stop training' shit doesnt show when it's still waiting to cancel and/or meditate.
			if(icon_state!="Train"&&Ki>=1&&move)
				dir=SOUTH
				icon_state="Train"
				training_id="[src][rand()]"
				CurrentAction="Training"
				src.training_event = new(training_scheduler, src, training_id)
				training_scheduler.schedule(src.training_event, 20)
	else
		Cancel_Training()
		src << "You stop training."

mob/var/tmp/CurrentAction
