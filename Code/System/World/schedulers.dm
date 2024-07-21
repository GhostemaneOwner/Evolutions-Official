

var/tmp/EventScheduler/skills_scheduler = new()
var/tmp/EventScheduler/technology_scheduler = new()
var/tmp/EventScheduler/training_scheduler = new()
var/tmp/EventScheduler/LOGscheduler = new()
/**
 * Starts global schedulers for things like technology events etc. Break this and
 * you break digging, technology, training and meditation.
 */
proc/StartGlobalSchedulers()
	technology_scheduler.start() // Digging
	training_scheduler.start() // Training and meditation
	skills_scheduler.start() // Manages skills that require a loop of sorts.
	LOGscheduler.start()

//	Weather()


	//status_scheduler.start() // Status proc

/*
* Stop_Train_Dig_Schedulers()
* As the name suggests, it cancels training and digging,
* this isn't JUST for logging out, but for other events such as being KO'd as well.
*/

mob/proc/Stop_TrainDig_Schedulers()
	set waitfor=0
	set background=1
	src.Cancel_Training()
	src.Cancel_Digging()
	src.Cancel_Meditation()

/*
* All important schedulers that are required to be stopped upon logout.
* Just call the Cancel_ procs in here, less of a hassle to go through the code
* since it's already placed properly.
*/

mob/proc/Cancel_Sched_OnLogout(var/mob/player/M)
	if(!M)
		//spawn src.Cancel_Status_Scheduler() // Status loop that checks health, etc, for that player.
		src.Stop_TrainDig_Schedulers()
		src.RevertAll()

	else if(M)
		//spawn M.Cancel_Status_Scheduler() // Status loop that checks health, etc, for that player.
		M.Stop_TrainDig_Schedulers()
		M.RevertAll()
