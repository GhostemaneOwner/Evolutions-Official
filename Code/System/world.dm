#define DEBUG
world
	hub = "SRTeam.DragonEvolutions"
	hub_password = "LRSJjZqzQNq9DFf5"
	name = "Evolutions"
	map_format = TOPDOWN_MAP
	turf = /turf/Special/Blank
	tick_lag = 1 // Don't fuck with tick_lag. Seriously, it screws up sleep, the scheduler and other things.
	cache_lifespan = 999
	loop_checks = 0
	status="<font color=#000000><b><font size=1>"
	mob = /mob/player // the player mob
	icon_size = 32
	fps = 20


var/global/RadiantEnergy=6

proc/RadiantEnergySpawn()
	RadiantEnergy=rand(1,7)
	world<<"Radiant Energy occurring on [RadiantEnergy==1?"Earth":RadiantEnergy==2?"Namek":RadiantEnergy==3?"Vegeta":RadiantEnergy==4?"Icer":RadiantEnergy==5?"Arconia":RadiantEnergy==6?"Dark Planet":RadiantEnergy==7?"Space Station":"???"]."


proc/GainsTrackerTick()
//	set background=1
	LastGainsTick=WipeUpTimer
	var/WipeDayTier=0
	if(WipeDay<1)WipeDay=1
	WipeDayProgress++
	TrueBPCap=150
	DayScaler=1.362924645
	TechCap=25
	if(WipeDayProgress>=12)
		WipeDay+=0.5
		WipeDayProgress=0
		if(WipeDay==round(WipeDay)) RadiantEnergySpawn()
	if(WipeDay>=21)
		DayScaler=1.258925412
		WipeDayTier=21
		TrueBPCap=100000
	if(WipeDay>=31)
		DayScaler=1.258925412
		WipeDayTier=31
		TrueBPCap=1000000
	if(WipeDay>=41)
		DayScaler=1.128837892
		WipeDayTier=41
		TrueBPCap=10000000
	if(WipeDay>=70)
		DayScaler=1.1
		WipeDayTier=70
		TrueBPCap=100000000
	GainMultRate=(WipeDay/20)
	Gain_Mult_Cap=min(15000,(500*WipeDay)+500)
	MinGainMult=(Gain_Mult_Cap/100)
	var/WipeDayRound=round(WipeDay)
	TrueBPCap=TrueBPCap*(DayScaler**(WipeDayRound-WipeDayTier))
	StarterBoostBP=TrueBPCap*0.3
//	SoftStatCap=450+(StatSoft*round(WipeDay,5))
	if(WipeDay>=0)  SoftStatCap=450+(StatSoft*round(1))
	if(WipeDay>=5)  SoftStatCap=450+(StatSoft*round(5))
	if(WipeDay>=10) SoftStatCap=450+(StatSoft*round(10))
	if(WipeDay>=15) SoftStatCap=450+(StatSoft*round(15))
	if(WipeDay>=20) SoftStatCap=450+(StatSoft*round(20))
	if(WipeDay>=25) SoftStatCap=450+(StatSoft*round(25))
	if(WipeDay>=30) SoftStatCap=450+(StatSoft*round(30))
	if(WipeDay>=35) SoftStatCap=450+(StatSoft*round(35))
	if(WipeDay>=40) SoftStatCap=450+(StatSoft*round(40))
	if(WipeDay>=45) SoftStatCap=450+(StatSoft*round(45))
	if(WipeDay>=50) SoftStatCap=450+(StatSoft*round(50))
	if(WipeDay>=55) SoftStatCap=450+(StatSoft*round(55))
	if(WipeDay>=60) SoftStatCap=450+(StatSoft*round(60))
	if(WipeDay>=65) SoftStatCap=450+(StatSoft*round(65))
	if(WipeDay>=70) SoftStatCap=450+(StatSoft*round(70))
	if(WipeDay>=75) SoftStatCap=450+(StatSoft*round(75))

// TECH CAP
	if(WipeDay>=3) TechCap=30
	if(WipeDay>=5) TechCap=35
	if(WipeDay>=7) TechCap=40
	if(WipeDay>=9) TechCap=45
	if(WipeDay>=11) TechCap=50
	if(WipeDay>=13) TechCap=55
	if(WipeDay>=15) TechCap=60
	if(WipeDay>=17) TechCap=65
	if(WipeDay>=19) TechCap=70
	if(WipeDay>=21) TechCap=75
	if(WipeDay>=23) TechCap=80
	if(WipeDay>=25) TechCap=85
	if(WipeDay>=27) TechCap=90
	if(WipeDay>=29) TechCap=95
	if(WipeDay>=31) TechCap=100
	if(WipeDay>=33) TechCap=105
	if(WipeDay>=35) TechCap=110
	if(WipeDay>=37) TechCap=115
	if(WipeDay>=39) TechCap=120
	if(WipeDay>=41) TechCap=125
	if(WipeDay>=43) TechCap=130
	if(WipeDay>=45) TechCap=135
	if(WipeDay>=47) TechCap=140
	if(WipeDay>=49) TechCap=145
	if(WipeDay>=51) TechCap=150
	if(WipeDay>=53) TechCap=155
	if(WipeDay>=55) TechCap=160
	if(WipeDay>=57) TechCap=165
	if(WipeDay>=59) TechCap=170
	if(WipeDay>=61) TechCap=175
	if(WipeDay>=63) TechCap=180
	if(WipeDay>=65) TechCap=185
	if(WipeDay>=67) TechCap=190
	if(WipeDay>=69) TechCap=195
	if(WipeDay>=71) TechCap=200
	if(WipeDay>=73) TechCap=205
	if(WipeDay>=75) TechCap=210

proc/YearTracker()
	set background=1
	set waitfor=0
	while(1)
		MonthCycle++
		if(MonthCycle>=5)
			Resources()
			Mana()
			MonthCycle=1
			Month++
			if(Month>12)
				Year++
				Month=1
				for(var/obj/Magic_Ball/A in DragonBalls)
					if(A.BallsAreInert>0) A.BallsAreInert-=1
					if(A.BallsAreInert<=0) A.Active()
			if(round(Year,0.1)==round(Year,5))
				if(!MakyoStar) world<<"<span class=\"narrate\">The Makyo Star approaches our galaxy...</span>"
				MakyoStar=1
			else if(Year>round(Year,5)+1&&MakyoStar)
				MakyoStar=0
				world<<"<span class=\"narrate\">The Makyo Star leaves our galaxy...</span>"
			for(var/mob/player/A in Players) if(A)
				A.Yearly_Update()
				if(A.HasPrayerTPd&&A.z!=11) A.PrayerTPDrain()
				sleep(0)
			spawn
				for(var/area/UndergroundMine/UM in Mines) for(var/turf/Terrain/Ground/G in UM) if(prob(1)) G.OreGenerate2()
				for(var/turf/Terrain/Ground/G in world) if(prob(5)) G.OreGenerate()
				for(var/turf/Terrain/Grass/G in world) if(prob(2.5)) G.OreGenerate()
				sleep(1)
			spawn
				for(var/turf/Terrain/Water/G in world) if(G.z&&prob(5)) G.GenerateFish()
				for(var/obj/NPCSpawner/TotalNPCs in world)
					SpawnNPCs()
		else world<<"<span class=\"narrate\">[YearOutput()]</span>"
		sleep(600*Year_Speed)//18000


//client
//fps=30
// This variable keeps track of how long a player has to be AFK in order for afk() to trigger. 600 seconds would be a minute.

var/global/
	GG=0.00001
	StatGain=5
	autoannounce
	autoannouncedelay=10
	CustomXPOptions
	RealmTeleport=1
	SpaceTravel=1
	GainMultRate = 1
	GlobalObjective
	MinGainMult = 1
	StarterBoostBP=500
	afk_time=10000 // 10 minutes
	DebugOn=1
	Year=0
	StatSoft=50
	SoftStatCap=500
	MonthCycle=1
	Month=1
	Global_GodKiCap=1
	HubText = null
	TestServerOn = 0//1// If the server isn't an official server some things are changed. 0 if NOT a Test Server!
	Version = "[world.name] - [global.HubText]"   //- [HubText]"
	Portals = list(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48)
	Admin_Int_Setting = 1
	Gain_Mult_Cap=1000
	Year_Speed = 90 //210 minutes = 3.5 hours
	TrueBPCap=150
	DayScaler=1.36
	WipeDay=1
	WipeDayProgress=0
	Ki_Power=0.8 //This is a multiplier of the overall damage of all ki attacks to balance them out.


	const/Gain_Divider = 0.0000001
	const/Stat_Gain_Divider=0.05
	const/MAX_MESSAGE_LEN = 6144	//6kb per text wall
	const/MIN_MESSAGE_LEN = 25
	const/MAX_PROFILE_LEN = 530
	const/MAX_DISCORD_LEN = 1200
	const/MAX_NAME_LENGTH = 50		//Set this in one fucking place gd
	const/INFINITY = 1e31 //closer then enough to be near to close
	const/SPACE_Z_LEVEL = 12	//used in checks

	//startRuin = 0 // Used to see if this server should be Ruined. Default should be 0

	list/admins = list("srteam"="Owner","sr_team"="Owner","blackclaw185"="Owner","saizetsu"="Owner","gamefire"="SeniorAdministrator","warhorse67"="SeniorAdministrator","nildsx"="Administrator",""="Moderator")


	list/Mines = new

	tmp/list/Players = list()
	list/cardinal = list( NORTH, SOUTH, EAST, WEST )
	list/alldirs = list(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)

	list/AllowRares = new

	list/MajinAbsorbRemove=new
	list/MutedList = new
	list/given[0] //a list for whoose been given a hash for their bans
	list/NoMove = list(/Language,/BodyPart,/Language,/Skill,/obj/Planets/Alien,/obj/Planets/SpaceStation,/obj/Planets/Arconia,/obj/Planets/Desert,/obj/Planets/Earth,/obj/Planets/Ice,/obj/Planets/Jungle,/obj/Planets/Namek,/obj/Planets/Vegeta,/obj/Planets/Ocean,/obj/Planets/DarkPlanet,/obj/Controls,/obj/Controls/PodControls,/obj/Airlock,/obj/AndroidAirlock,/obj/AndroidShip,/obj/Warper)



	list/NoCloak = list(/Language,/BodyPart,/Language,/Skill,/obj/Magic_Ball,/obj/items/Phylactery,/obj/items/Bomb,/obj/items/Cloning_Tank,/obj/Ships/ShipMKIII,/obj/Ships/ShipMKII,/obj/Ships/Ship,/obj/Ships/Ship/Ardent,/obj/Ships/Ship/Icebreaker,/obj/AndroidShip,/obj/Controls,/obj/Controls/PodControls,/obj/Airlock,/obj/AndroidAirlock,/obj/Controls/MKIControls,/obj/Controls/MKIIControls,/obj/Controls/MKIIIControls)

	diary = null
	errors = null

	ooc_allowed = 1

		//LOOC



	looc_1=1
	looc_2=1
	looc_3=1
	looc_4=1
	looc_5=1
	looc_6=1
	looc_7=1
	looc_8=1
	looc_9=1
	looc_10=1
	looc_11=1
	looc_12=1
	looc_13=1
	looc_14=1
	looc_15=1
	looc_16=1
	looc_17=1
	looc_18=1


	WorldLoaded = 0	//Dynamic lighting doesn't take effect until 1
	ItemsLoaded=0
	MapsLoaded=0
	CanSave = 0
	debuglog = file("Data/Logs/debuglog.log")
	topiclog = file("topiclog.log")

//	list/Reward_Key_List = list()
//	list/Reward_List = list()
	list/Rankings = list()
//	Rewards_Active = 0
	Dead_Time = 3
	Allow_Save = 0
	Allow_Rares = "Off"
	Androids = 0
	Security = 0
	MainFrame = 0
	BuildModule = 0
	First_SSJ = 0
	First_SSJ2 = 0
	First_SSJ3 = 0

	Injury_Max =0.8 // 20% reduction in stats for a broken arm or leg.
	rebooting = 0
	//Password = "Lappens"
	Server_Activated = 1//0
	Smokes = 0

//Race Toggles
	AllowSaiyan=1
	AllowTuffle=1
	AllowHuman=1
	AllowMakyo=1
	AllowSD=1
	AllowNamek=1
	AllowChangeling=1
	AllowAndroid=1
	AllowOni=1
	AllowDemon=1
	AllowShinjin=1
	AllowDemigod=1
	AllowAlien=1
	AllowElite=1
	AllowHeran=1
	AllowYardrat=1
	AllowKanassan=1
	AllowPuar=1
	AllowSaibaman=1
	AllowKonatsian=1
	AllowCerealian=1
	AllowHeeter=1
	AllowGreys=0
	AllowDragon=0
	AllowPrimal=0

	Global_SSJ= 0
	Global_SSJ2= 0
	Global_SSJ3= 0
	Global_Trans=0
	Global_Ascension= 0

	Global_GodKi=0
	Global_GodKiTrain=0

//	CyberizeLimit=200000
	TechCap=25

	YardratSpawn="450,25,3"
	DemigodSpawn="175,80,11"
	HeranSpawn="420,300,2"
	OniSpawn="175,80,11"
	AlienSpawn="180,265,2"
	KanassanSpawn="180,265,2"
	HumanSpawn="241,171,1"
	TuffleSpawn="400,255,3"
	NamekianSpawn="180,265,2"
	SaiyanSpawn="460,490,3"
	IcerSpawn="76,292,3"
	MakyoSpawn="228,218,1"
	PuarSpawn="241,171,1"
	KonatsianSpawn="420,300,2"
	DemonSpawn="175,80,11"
	ShinjinSpawn="86,396,10"
	CerealianSpawn="420,300,2"
	HeeterSpawn="420,300,2"
	GreysSpawn="420,300,2"
	DragonSpawn="420,300,2"
	PrimalSpawn="458,492,3"

	DEADX=244
	DEADY=131
	DEADZ=11



/world/New()
	LoadHubText()
	LoadActivation()
//	ActivatePixelMovement()
	..()
	diary = file("Data/Logs/world/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log")
	diary << ""
	diary << ""
	diary << "Starting up. [time2text(world.timeofday, "hh:mm.ss")]"
	diary << "---------------------"
	diary << ""

	errors = file("Data/Logs/errors.log")
	errors << ""
	errors << ""
	errors << "Starting up. [time2text(world.timeofday, "hh:mm.ss")]"
	errors << "---------------------"
	errors << ""
	log = errors
	spawn(1) Initialize()
	world.status="[world.status] [Version]<br> [HubText]"


/world/Del()

	diary << ""
	diary << "Shutting down. [time2text(world.timeofday, "hh:mm.ss")]"
	diary << "---------------------"
	diary << ""

	errors << ""
	errors << "Shutting down. [time2text(world.timeofday, "hh:mm.ss")]"
	errors << "---------------------"
	errors << ""
	..()



var/SaveLoop=0
proc/Save_Loop()
	if(SaveLoop)return
	while(1)
		SaveLoop=1
		//We update what file diary is writing to every time we iterate over the save loop
		diary = file("Data/Logs/world/[time2text(world.realtime, "YYYY/MM-Month/DD-Day")].log")
		//world.log = diary	//Man I'm in a daze, walkin round round in a maze
		if(global.TestServerOn){diary << "[time2text(world.timeofday, "hh:mm.ss")] Server is still running.";if(Players.len){spawn(16000) world << "<span class=announce>Dont forget to use the discord for any Bugs/Suggestions you might have!</span>"}}
		sleep(1800) //1200
		//if(DebugOn) log_errors("Save Loop Start [time2text(world.timeofday, "hh:mm.ss")]")
		for(var/mob/player/A in Players)
			if(!A.lastKnownKey) continue
			if(!A.client) continue
			spawn if(A) A.StatRank()
			//spawn if(A) A.Save()
			sleep(-1) //1
		//if(DebugOn) log_errors("Save Loop Success [time2text(world.timeofday, "hh:mm.ss")]")

proc/Security()
	if(Security == 0)
		Security = 1
		var/Pass = rand(11111,99999)
		var/obj/items/Security_Camera/S1 = new(locate(96,411,9))
		S1.name = "Bridge"
		S1.Password = "[Pass]"
		S1.Bolted = 1
		S1.Savable=0
		S1.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S2 = new(locate(134,466,9))
		S2.name = "Mainframe and Build Module"
		S2.Password = "[Pass]"
		S2.Bolted = 1
		S2.Savable=0
		S2.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S3 = new(locate(93,458,9))
		S3.name = "Creation Station"
		S3.Password = "[Pass]"
		S3.Bolted = 1
		S3.Savable=0
		S3.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S4 = new(locate(83,458,9))
		S4.name = "Creation Station"
		S4.Password = "[Pass]"
		S4.Bolted = 1
		S4.Savable=0
		S4.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S5 = new(locate(96,484,9))
		S5.name = "Airlock"
		S5.Password = "[Pass]"
		S5.Bolted = 1
		S5.Savable=0
		S5.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S6 = new(locate(98,484,9))
		S6.name = "Airlock"
		S6.Password = "[Pass]"
		S6.Bolted = 1
		S6.Savable=0
		S6.Frequency = "Communication Matrix"
//
		var/obj/items/Security_Camera/S7 = new(locate(104,459,9))
		S7.name = "Storage"
		S7.Password = "[Pass]"
		S7.Bolted = 1
		S7.Savable=0
		S7.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S8 = new(locate(123,487,9))
		S8.name = "Training Room"
		S8.Password = "[Pass]"
		S8.Bolted = 1
		S8.Savable=0
		S8.Frequency = "Communication Matrix"

		var/obj/items/Security_Camera/S9 = new(locate(66,459,9))
		S9.name = "Training Room"
		S9.Password = "[Pass]"
		S9.Bolted = 1
		S9.Savable=0
		S9.Frequency = "Communication Matrix"

		world << "<font color = grey>All Android Security placed."

proc/MainFrame() if(!locate(/obj/items/Main_Frame) in world)
	var/obj/items/Main_Frame/X=locate(/obj/items/Main_Frame) in worldObjectList
	if(!X)
		world << "<font color = grey>Android Mainframe placed."
		X = new
		X.loc = locate(133,465,9)
		X.name = "Android Ship Main Frame"
		worldObjectList += X
	MainFrame = 1

proc/BuildModule()/* if(!locate(/obj/items/Android_Build_Module) in world)
	var/obj/items/Android_Build_Module/Y=locate(/obj/items/Android_Build_Module) in worldObjectList
	if(!Y)
		world << "<font color = grey>Android Build Module placed."
		Y = new
		Y.loc = locate(135,465,9)
		Y.name = "Android Ship Build Module"
		worldObjectList += Y
	BuildModule = 1*/

proc/Androids()
	if(Androids == 0)
		Androids = 1
		var/Droids = 8
		var/Y = 255
		var/X = 235
		while(Droids)
			var/obj/items/Android_Chassis/A = new
			A.name = "Android - [Droids]"
			A.loc = locate(X,Y,7)
			A.AS_Droid=1
			if(X == 94)
				Y -= 4
				X = 82
			else
				X += 4
			Droids -= 1
		world << "<font color = grey>All Android Chassis placed."

proc/Initialize()
	set waitfor=0
	if(WorldLoaded)
		world.log << "Attempted to Initialize World when World was already initialized!"
		diary << "Attempted to Initialize World when World was already initialized!"
		return
	WorldLoaded = 1

	if(global.TestServerOn)
		Version_Notes={"
	<body bgcolor="#000000"><font size=2><font color="#CCCCCC">
	<html><head><title>Spiritus Roleplay</title></head>
	<body>Discord: https://discord.gg/h6J5CHGBg2<br><hr>
	Welcome friends, we are testing!
	<br><br>
	Post bug reports and feedback to the discord!
	<br><br>
	</body></html>
	"}

	LoadBanHashes()
	LoadBans()	//Da-yum
	load_admins()	//HEH
	LoadPlanets()
	LoadScalingPower()
	spawn StartGlobalSchedulers()
	LoadBans()
	LoadYear()
	sleep(0)
	Load_Gain()
	sleep(0)
	LoadNotes()
	LoadLogin()
	sleep(0)
	Load_Spawns()
	sleep(0)
	world << "Gains and Etc loaded..."
	world.log << "Gains and Etc loaded..."
	spawn(15)
		Load_Turfs()//MapLoad()
		world.log << "Turf loaded..."
		LoadItems()
		world.log << "Items loaded..."
	AddBuilds()
	spawn Planet_Destroyed()
	spawn SaveWorldRepeat()
	spawn Save_Loop()
	Load_Area()

	SetMPList()
	fill_techlist() // fill global tech list


	for(var/obj/items/A in world) if(isnull(A.loc)&&A.z==0) del(A)
	log_errors("World Opened Successfully [time2text(world.timeofday, "hh:mm.ss")]")
//	HTF_Update()
	AutoAnnounce()
	YearTracker()
	TimerLoop()
//	CheckXPEarned()
//	GainsTracker()
	Allow_Save = 1



proc/CleanUpLoop()
	set waitfor=0
	for(var/obj/TrainingEq/M) if(M.Health<=0 && M.loc && M.z!=0) del(M)
	Clear_Stray_Clothes()
	CleanDrops()

proc/Clear_Stray_Clothes()
	set waitfor=0
	for(var/obj/items/Clothes/C in world) if(C.loc && C.z!=0 && C.Savable==0) del(C)
	for(var/obj/items/Weights/W in world) if(W.loc && W.z!=0) del(W)



/world/OpenPort()
	..()
	spawn(30)
		world<<"World Link<br>[world.url]"

/world/IsBanned(key,address,computer_id)
	..()	//Do default checks


/world/Reboot(var/reason)
	for(var/client/C in world)
		C << link("byond://[world.internet_address]:[world.port]")
		spawn(rand(100,300)) C.mob.Login()
	..(reason)

/world/Import()
	Banlist.dir.Add(src.address)
	return
/client/Import()
	return

