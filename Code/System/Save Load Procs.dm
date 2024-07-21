


proc/SaveScalingPower()
	var/savefile/S=new("Data/ScalingPower.bdb")
	S["WipeDay"]<<WipeDay
	S["WipeDayProgress"]<<WipeDayProgress
	S["Ki_Power"]<<Ki_Power
//	S["MaxXPReward"] << MaxXPReward
	S["BaseRefireDiv"]<<BaseRefireDiv
	S["WipeUpTimer"]<<WipeUpTimer


proc/LoadScalingPower() if(fexists("Data/ScalingPower.bdb"))
	var/savefile/S=new("Data/ScalingPower.bdb")
	S["WipeDay"]>>WipeDay
	S["WipeDayProgress"]>>WipeDayProgress
	S["Ki_Power"]>>Ki_Power
//	S["MaxXPReward"] >> MaxXPReward
	S["BaseRefireDiv"]>>BaseRefireDiv
	S["WipeUpTimer"]>>WipeUpTimer

/*


proc/SaveRankings()
	var/savefile/S=new("Data/Rankings.bdb")
	S["Rankings"]<<Rankings
proc/LoadRankings()
	var/savefile/S=new("Data/Rankings.bdb")
	S["Rankings"]>>Rankings
	var/Empty = 1
	for(var/X in Rankings) Empty = 0
	if(Empty) Rankings = list()

*/
proc/SaveActivation()
	var/savefile/S=new("Data/x76dgfshd.bdb")
	S["Activated"]<<Server_Activated
proc/LoadActivation() if(fexists("Data/x76dgfshd.bdb"))
	var/savefile/S=new("Data/x76dgfshd.bdb")
	S["Activated"]>>Server_Activated

proc/SaveYear()
	var/savefile/S=new("Data/Year.bdb")
	S["Year"]<<Year
	S["Month"]<<Month
	S["Speed"]<<Year_Speed
	S["Androids"]<<Androids
	S["Security"]<<Security
	S["MainFrame"]<<MainFrame
	S["BuildModule"]<<BuildModule
	S["First SSJ"]<<First_SSJ
	S["Global SSJ"]<<Global_SSJ
	S["First SSJ2"]<<First_SSJ2
	S["Global SSJ2"]<<Global_SSJ2
	S["First SSJ3"]<<First_SSJ3
	S["Global SSJ3"]<<Global_SSJ3
	S["Global_Trans"]<<Global_Trans
	S["Global Ascension"]<<Global_Ascension
	S["God Ki"]<<Global_GodKi
	S["God Ki Train"]<<Global_GodKiTrain
	S["Global GodKiCap"]<<Global_GodKiCap
	S["Day"]<<MonthCycle
	S["MakyoStar"]<<MakyoStar
	S["AllowSaiyan"]<<AllowSaiyan
	S["AllowTuffle"]<<AllowTuffle
	S["AllowHuman"]<<AllowHuman
	S["AllowMakyo"]<<AllowMakyo
	S["AllowSD"]<<AllowSD
	S["AllowNamek"]<<AllowNamek
	S["AllowChangeling"]<<AllowChangeling
	S["AllowAndroid"]<<AllowAndroid
	S["AllowOni"]<<AllowOni
	S["AllowDemigod"]<<AllowDemigod
	S["AllowAlien"]<<AllowAlien
	S["AllowElite"]<<AllowElite
	S["AllowHeran"]<<AllowHeran
	S["AllowYardrat"]<<AllowYardrat
	S["AllowKanassan"]<<AllowKanassan
	S["AllowPuar"]<<AllowPuar
	S["AllowSaibaman"]<<AllowSaibaman
	S["AllowKonatsian"]<<AllowKonatsian
	S["AllowShinjin"]<<AllowShinjin
	S["AllowDemon"]<<AllowDemon
	S["AllowCerealian"]<<AllowCerealian
	S["AllowHeeter"]<<AllowHeeter
	S["AllowGreys"]<<AllowGreys
	S["AllowDragon"]<<AllowDragon
	S["AllowPrimal"]<<AllowPrimal
	S["autoannounce"]<<autoannounce
	S["autoannounced"]<<autoannouncedelay
	S["AndroidRes"]<<AndroidRes
	S["DragonBalls"]<<DragonBalls
//	S["WorldBugReports"]<<WorldBugReports


proc/LoadYear() if(fexists("Data/Year.bdb"))
	var/savefile/S=new("Data/Year.bdb")
	S["Year"]>>Year
	S["Month"]>>Month
	S["Speed"]>>Year_Speed
	S["Androids"]>>Androids
	S["Security"]>>Security
	S["MainFrame"]>>MainFrame
	S["BuildModule"]>>BuildModule
	S["First SSJ"]>>First_SSJ
	S["Global SSJ"]>>Global_SSJ
	S["First SSJ2"]>>First_SSJ2
	S["Global SSJ2"]>>Global_SSJ2
	S["First SSJ3"]>>First_SSJ3
	S["Global SSJ3"]>>Global_SSJ3
	S["Global_Trans"]>>Global_Trans
	S["Global Ascension"]>>Global_Ascension
	S["God Ki"]>>Global_GodKi
	S["God Ki Train"]>>Global_GodKiTrain
	S["Global GodKiCap"]>>Global_GodKiCap
	S["Day"]>>MonthCycle
	S["MakyoStar"]>>MakyoStar
	S["AllowSaiyan"]>>AllowSaiyan
	S["AllowTuffle"]>>AllowTuffle
	S["AllowHuman"]>>AllowHuman
	S["AllowMakyo"]>>AllowMakyo
	S["AllowSD"]>>AllowSD
	S["AllowNamek"]>>AllowNamek
	S["AllowChangeling"]>>AllowChangeling
	S["AllowAndroid"]>>AllowAndroid
	S["AllowOni"]>>AllowOni
	S["AllowDemigod"]>>AllowDemigod
	S["AllowAlien"]>>AllowAlien
	S["AllowElite"]>>AllowElite
	S["AllowHeran"]>>AllowHeran
	S["AllowYardrat"]>>AllowYardrat
	S["AllowKanassan"]>>AllowKanassan
	S["AllowPuar"]>>AllowPuar
	S["AllowSaibaman"]>>AllowSaibaman
	S["AllowKonatsian"]>>AllowKonatsian
	S["AllowShinjin"]>>AllowShinjin
	S["AllowDemon"]>>AllowDemon
	S["AllowCerealian"]>>AllowCerealian
	S["AllowHeeter"]>>AllowHeeter
	S["AllowGreys"]>>AllowGreys
	S["AllowDragon"]>>AllowDragon
	S["AllowPrimal"]>>AllowPrimal
	S["autoannounce"]>>autoannounce
	S["autoannounced"]>>autoannouncedelay
	S["AndroidRes"]>>AndroidRes
	S["DragonBalls"]>>DragonBalls
//	S["WorldBugReports"]>>WorldBugReports







proc/LoadPlanets() if(fexists("Data/PlanetSave.bdb"))
	var/savefile/S=new("Data/PlanetSave.bdb")
	S["Earth"]>>Earth
	S["Namek"]>>Namek
	S["Vegeta"]>>Vegeta
	S["Arconia"]>>Arconia
	S["Ice"]>>Ice
	S["Desert"]>>Desert
	S["Jungle"]>>Jungle
	S["Android"]>>Android
	S["Alien"]>>Alien
	S["SpaceStation"]>>SpaceStation
	S["Ocean"]>>Ocean
	S["DarkPlanet"]>>DarkPlanet
	S["EarthMoon"]>>EarthMoon
	S["VegetaMoon"]>>VegetaMoon
	S["ArconiaMoon"]>>ArconiaMoon
	S["AlienMoon"]>>AlienMoon
	S["IceMoon"]>>IceMoon
	S["WorldFactionList"]>>WorldFactionList
	S["DragonBalls"]>>DragonBalls
proc/SavePlanets()
	var/savefile/S=new("Data/PlanetSave.bdb")
	S["Earth"]<<Earth
	S["Namek"]<<Namek
	S["Vegeta"]<<Vegeta
	S["Arconia"]<<Arconia
	S["Ice"]<<Ice
	S["Desert"]<<Desert
	S["Jungle"]<<Jungle
	S["Android"]<<Android
	S["Alien"]<<Alien
	S["SpaceStation"]<<SpaceStation
	S["Ocean"]<<Ocean
	S["DarkPlanet"]<<DarkPlanet
	S["EarthMoon"]<<EarthMoon
	S["VegetaMoon"]<<VegetaMoon
	S["ArconiaMoon"]<<ArconiaMoon
	S["AlienMoon"]<<AlienMoon
	S["IceMoon"]<<IceMoon
	S["WorldFactionList"]<<WorldFactionList
	S["DragonBalls"]<<DragonBalls



proc/Save_Gain()
	var/savefile/S=new("Data/GAIN.bdb")
	S["GAIN"]<<GG
	S["STAT GAIN"]<<StatGain
//	S["GenericReq"]<<GenericReq
	S["PORTALS"]<<Portals
	S["Gain Cap"]<<Gain_Mult_Cap
	S["Gain_Mult_Cap"]<<Gain_Mult_Cap
	S["Tech Cap"]<<TechCap
//	S["NextRPReward"]<<NextRPReward
	S["CustomXPOptions"]<<CustomXPOptions
	S["GlobalResourceRate"]<<GlobalResourceRate
	S["RealmTeleport"]<<RealmTeleport
	S["SpaceTravel"]<<SpaceTravel
	S["GainMultRate"]<<GainMultRate
	S["MinGainMult"]<<MinGainMult
	S["GlobalObjective"]<<GlobalObjective
	S["StarterBoostBP"]<<StarterBoostBP
	S["EarthGrav"]<<EarthGrav
	S["NamekGrav"]<<NamekGrav //z=2
	S["ArconiaGrav"]<<ArconiaGrav //z=5
	S["VegetaGrav"]<<VegetaGrav //z=3
	S["DarkPlanetGrav"]<<DarkPlanetGrav //z=6
	S["IceGrav"]<<IceGrav //z=4
	S["HellGrav"]<<HellGrav //z=19
	S["PowerControlCap"]<<PowerControlCap
	S["StatSoft"]<<StatSoft
	S["UPDATE_VERSION"]<<UPDATE_VERSION
	S["intgain"]<<Admin_Int_Setting


proc/Load_Gain() if(fexists("Data/GAIN.bdb"))
	var/savefile/S=new("Data/GAIN.bdb")
	S["GAIN"]>>GG
	S["STAT GAIN"]>>StatGain
//	S["GenericReq"]>>GenericReq
	S["PORTALS"]>>Portals
	S["Gain Cap"]>>Gain_Mult_Cap
	S["Gain_Mult_Cap"]>>Gain_Mult_Cap
	S["Tech Cap"]>>TechCap
//	S["NextRPReward"]>>NextRPReward
	S["CustomXPOptions"]>>CustomXPOptions
	S["GlobalResourceRate"]>>GlobalResourceRate
	S["RealmTeleport"]>>RealmTeleport
	S["SpaceTravel"]>>SpaceTravel
	S["GainMultRate"]>>GainMultRate
	S["GlobalObjective"]>>GlobalObjective
	S["MinGainMult"]>>MinGainMult
	S["StarterBoostBP"]>>StarterBoostBP
	S["EarthGrav"]>>EarthGrav
	S["NamekGrav"]>>NamekGrav //z=2
	S["ArconiaGrav"]>>ArconiaGrav //z=5
	S["VegetaGrav"]>>VegetaGrav //z=3
	S["DarkPlanetGrav"]>>DarkPlanetGrav //z=6
	S["IceGrav"]>>IceGrav //z=4
	S["HellGrav"]>>HellGrav //z=19
	S["PowerControlCap"]>>PowerControlCap
	S["StatSoft"]>>StatSoft
	S["UPDATE_VERSION"]>>UPDATE_VERSION
	S["intgain"]>>Admin_Int_Setting

/proc/save_admins()
	var/savefile/temps = new("Data/savedAdmins.bdb")
	temps["admins"] << admins	//Does this work?
	temps["AHelpIDCounter"] <<AHelpIDCounter
/proc/load_admins()
	var/savefile/temps = new("Data/savedAdmins.bdb")
	if(length(temps["admins"]))	//Only load if uhh there is something to load. null otherwise
		temps["admins"] >> admins
	for(var/i in admins) diary << ("ADMIN: [i] = [admins[i]]")
	temps["AHelpIDCounter"] >>AHelpIDCounter

proc/SaveHubText()
	var/savefile/S=new("Data/Hubtext.bdb")
	S["HubText"]<<global.HubText
proc/LoadHubText()
	var/savefile/S=new("Data/Hubtext.bdb")
	S["HubText"]>>global.HubText


proc/Save_Spawns()
	var/savefile/F = new("Data/Spawns.sav")
	F["DEADX"]<<DEADX
	F["DEADY"]<<DEADY
	F["DEADZ"]<<DEADZ
	F["YardratSpawn"]<<YardratSpawn
	F["DemigodSpawn"]<<DemigodSpawn
	F["OniSpawn"]<<OniSpawn
	F["AlienSpawn"]<<AlienSpawn
	F["HumanSpawn"]<<HumanSpawn
	F["TuffleSpawn"]<<TuffleSpawn
	F["NamekianSpawn"]<<NamekianSpawn
	F["SaiyanSpawn"]<<SaiyanSpawn
	F["IcerSpawn"]<<IcerSpawn
	F["MakyoSpawn"]<<MakyoSpawn
	F["HeranSpawn"]<<HeranSpawn
	F["ShinjinSpawn"]<<ShinjinSpawn
	F["DemonSpawn"]<<DemonSpawn
	F["PuarSpawn"]<<PuarSpawn
	F["CerealianSpawn"]<<CerealianSpawn
	F["HeeterSpawn"]<<HeeterSpawn
	F["GreysSpawn"]<<GreysSpawn
	F["DragonSpawn"]<<DragonSpawn
	F["PrimalSpawn"]<<PrimalSpawn
	F["KonatsianSpawn"]<<KonatsianSpawn

proc/Load_Spawns()
	if(fexists("Data/Spawns.sav"))
		var/savefile/F = new("Data/Spawns.sav")
		F["DEADX"]>>DEADX
		F["DEADY"]>>DEADY
		F["DEADZ"]>>DEADZ
		F["YardratSpawn"]>>YardratSpawn
		F["DemigodSpawn"]>>DemigodSpawn
		F["HeranSpawn"]>>HeranSpawn
		F["OniSpawn"]>>OniSpawn
		F["AlienSpawn"]>>AlienSpawn
		F["HumanSpawn"]>>HumanSpawn
		F["TuffleSpawn"]>>TuffleSpawn
		F["NamekianSpawn"]>>NamekianSpawn
		F["SaiyanSpawn"]>>SaiyanSpawn
		F["IcerSpawn"]>>IcerSpawn
		F["MakyoSpawn"]>>MakyoSpawn
		F["ShinjinSpawn"]>>ShinjinSpawn
		F["DemonSpawn"]>>DemonSpawn
		F["PuarSpawn"]>>PuarSpawn
		F["KonatsianSpawn"]>>KonatsianSpawn
		F["CerealianSpawn"]>>CerealianSpawn
		F["HeeterSpawn"]>>HeeterSpawn
		F["GreysSpawn"]>>GreysSpawn
		F["DragonSpawn"]>>DragonSpawn
		F["PrimalSpawn"]>>PrimalSpawn


proc/SaveLogin()
	var/savefile/S=new("Login Menu")
	S["VERSION"]<<Version_Notes
proc/LoadLogin() if(fexists("Login Menu"))
	var/savefile/S=new("Login Menu")
	S["VERSION"]>>Version_Notes




proc/Save_Area()
	var/savefile/F=new("Data/Areas.bdb")
	F["Z1Tax"]<<Z1Tax
	F["Z1ControllingFaction"]<<Z1ControllingFaction
	F["Z1ControllingRuler"]<<Z1ControllingRuler
	F["Z1FactionCode"]<<Z1FactionCode
	F["Z1ReserveResources"]<<Z1ReserveResources
	F["Z1ReserveMana"]<<Z1ReserveMana
	F["Z1TaxEvaders"]<<Z1TaxEvaders
	F["Z1MTaxEvaders"]<<Z1MTaxEvaders
	F["Z2Tax"]<<Z2Tax
	F["Z2ControllingFaction"]<<Z2ControllingFaction
	F["Z2ControllingRuler"]<<Z2ControllingRuler
	F["Z2FactionCode"]<<Z2FactionCode
	F["Z2ReserveResources"]<<Z2ReserveResources
	F["Z2ReserveMana"]<<Z2ReserveMana
	F["Z2TaxEvaders"]<<Z2TaxEvaders
	F["Z2MTaxEvaders"]<<Z2MTaxEvaders
	F["Z3Tax"]<<Z3Tax
	F["Z3ControllingFaction"]<<Z3ControllingFaction
	F["Z3ControllingRuler"]<<Z3ControllingRuler
	F["Z3FactionCode"]<<Z3FactionCode
	F["Z3ReserveResources"]<<Z3ReserveResources
	F["Z3ReserveMana"]<<Z3ReserveMana
	F["Z3TaxEvaders"]<<Z3TaxEvaders
	F["Z3MTaxEvaders"]<<Z3MTaxEvaders
	F["Z4Tax"]<<Z4Tax
	F["Z4ControllingFaction"]<<Z4ControllingFaction
	F["Z4ControllingRuler"]<<Z4ControllingRuler
	F["Z4FactionCode"]<<Z4FactionCode
	F["Z4ReserveResources"]<<Z4ReserveResources
	F["Z4ReserveMana"]<<Z4ReserveMana
	F["Z4TaxEvaders"]<<Z4TaxEvaders
	F["Z4MTaxEvaders"]<<Z4MTaxEvaders
	F["Z5Tax"]<<Z5Tax
	F["Z5ControllingFaction"]<<Z5ControllingFaction
	F["Z5ControllingRuler"]<<Z5ControllingRuler
	F["Z5FactionCode"]<<Z5FactionCode
	F["Z5ReserveResources"]<<Z5ReserveResources
	F["Z5ReserveMana"]<<Z5ReserveMana
	F["Z5TaxEvaders"]<<Z5TaxEvaders
	F["Z5MTaxEvaders"]<<Z5MTaxEvaders
	F["Z6Tax"]<<Z6Tax
	F["Z6ControllingFaction"]<<Z6ControllingFaction
	F["Z6ControllingRuler"]<<Z6ControllingRuler
	F["Z6FactionCode"]<<Z6FactionCode
	F["Z6ReserveResources"]<<Z6ReserveResources
	F["Z6ReserveMana"]<<Z6ReserveMana
	F["Z6TaxEvaders"]<<Z6TaxEvaders
	F["Z6MTaxEvaders"]<<Z6MTaxEvaders
	F["Z7Tax"]<<Z7Tax
	F["Z7ControllingFaction"]<<Z7ControllingFaction
	F["Z7ControllingRuler"]<<Z7ControllingRuler
	F["Z7FactionCode"]<<Z7FactionCode
	F["Z7ReserveResources"]<<Z7ReserveResources
	F["Z7ReserveMana"]<<Z7ReserveMana
	F["Z7TaxEvaders"]<<Z7TaxEvaders
	F["Z7MTaxEvaders"]<<Z7MTaxEvaders
	F["Z1FactionTax"]<<Z1FactionTax
	F["Z2FactionTax"]<<Z2FactionTax
	F["Z3FactionTax"]<<Z3FactionTax
	F["Z4FactionTax"]<<Z4FactionTax
	F["Z5FactionTax"]<<Z5FactionTax
	F["Z6FactionTax"]<<Z6FactionTax
	F["Z7FactionTax"]<<Z7FactionTax


proc/Load_Area() if(fexists("Data/Areas.bdb"))
	var/savefile/F=new("Data/Areas.bdb")
	F["Z1Tax"]>>Z1Tax
	F["Z1ControllingFaction"]>>Z1ControllingFaction
	F["Z1ControllingRuler"]>>Z1ControllingRuler
	F["Z1FactionCode"]>>Z1FactionCode
	F["Z1ReserveResources"]>>Z1ReserveResources
	F["Z1ReserveMana"]>>Z1ReserveMana
	F["Z1TaxEvaders"]>>Z1TaxEvaders
	F["Z1MTaxEvaders"]>>Z1MTaxEvaders
	F["Z2Tax"]>>Z2Tax
	F["Z2ControllingFaction"]>>Z2ControllingFaction
	F["Z2ControllingRuler"]>>Z2ControllingRuler
	F["Z2FactionCode"]>>Z2FactionCode
	F["Z2ReserveResources"]>>Z2ReserveResources
	F["Z2ReserveMana"]>>Z2ReserveMana
	F["Z2TaxEvaders"]>>Z2TaxEvaders
	F["Z2MTaxEvaders"]>>Z2MTaxEvaders
	F["Z3Tax"]>>Z3Tax
	F["Z3ControllingFaction"]>>Z3ControllingFaction
	F["Z3ControllingRuler"]>>Z3ControllingRuler
	F["Z3FactionCode"]>>Z3FactionCode
	F["Z3ReserveResources"]>>Z3ReserveResources
	F["Z3ReserveMana"]>>Z3ReserveMana
	F["Z3TaxEvaders"]>>Z3TaxEvaders
	F["Z3MTaxEvaders"]>>Z3MTaxEvaders
	F["Z4Tax"]>>Z4Tax
	F["Z4ControllingFaction"]>>Z4ControllingFaction
	F["Z4ControllingRuler"]>>Z4ControllingRuler
	F["Z4FactionCode"]>>Z4FactionCode
	F["Z4ReserveResources"]>>Z4ReserveResources
	F["Z4ReserveMana"]>>Z4ReserveMana
	F["Z4TaxEvaders"]>>Z4TaxEvaders
	F["Z4MTaxEvaders"]>>Z4MTaxEvaders
	F["Z5Tax"]>>Z5Tax
	F["Z5ControllingFaction"]>>Z5ControllingFaction
	F["Z5ControllingRuler"]>>Z5ControllingRuler
	F["Z5FactionCode"]>>Z5FactionCode
	F["Z5ReserveResources"]>>Z5ReserveResources
	F["Z5ReserveMana"]>>Z5ReserveMana
	F["Z5TaxEvaders"]>>Z5TaxEvaders
	F["Z5MTaxEvaders"]>>Z5MTaxEvaders
	F["Z6Tax"]>>Z6Tax
	F["Z6ControllingFaction"]>>Z6ControllingFaction
	F["Z6ControllingRuler"]>>Z6ControllingRuler
	F["Z6FactionCode"]>>Z6FactionCode
	F["Z6ReserveResources"]>>Z6ReserveResources
	F["Z6ReserveMana"]>>Z6ReserveMana
	F["Z6TaxEvaders"]>>Z6TaxEvaders
	F["Z6MTaxEvaders"]>>Z6MTaxEvaders
	F["Z7Tax"]>>Z7Tax
	F["Z7ControllingFaction"]>>Z7ControllingFaction
	F["Z7ControllingRuler"]>>Z7ControllingRuler
	F["Z7FactionCode"]>>Z7FactionCode
	F["Z7ReserveResources"]>>Z7ReserveResources
	F["Z7ReserveMana"]>>Z7ReserveMana
	F["Z7TaxEvaders"]>>Z7TaxEvaders
	F["Z7MTaxEvaders"]>>Z7MTaxEvaders
	F["Z1FactionTax"]>>Z1FactionTax
	F["Z2FactionTax"]>>Z2FactionTax
	F["Z3FactionTax"]>>Z3FactionTax
	F["Z4FactionTax"]>>Z4FactionTax
	F["Z5FactionTax"]>>Z5FactionTax
	F["Z6FactionTax"]>>Z6FactionTax
	F["Z7FactionTax"]>>Z7FactionTax

proc/SaveNotes()
	var/savefile/S=new("Data/Notes.bdb")
	S["Notes"]<<Notes
	S["Story"]<<Story
	S["Rules"]<<Rules
proc/LoadNotes()
	if(fexists("Data/Notes.bdb"))
		var/savefile/S=new("Data/Notes.bdb")
		S["Notes"]>>Notes
		S["Story"]>>Story
		S["Rules"]>>Rules

