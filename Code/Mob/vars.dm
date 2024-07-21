
//mob/luminosity=4

mob/var/tmp
	AdminSenseToggle=0
	move=1
	//Spell_CD = 0
	BuildOpen = 0
	BuildTab = "Roofs"

	DEBUGMATH
	TestChar=null // TestChar variable, used for looping the Status() proc on mobs with no clients.
					// Its specific use is stress testing.

	Weight=1
	//obj/Save_Loc = null
	mob/Target
	//Using_Explosion
	transing
	RaceDescription="Undefined Race Desc"  //Was nothing  null.var bug

	lastKnownIP
	computer_id
	lastKnownKey
	Logged_Out_Body
	adminObserve
	onThrowCD = 0
	Gravity=1
	KB
	mob/GrabbedMob
	isGrabbing

	WishPower=0
	attacking
	Beam_Refire_Delay_Active
	mob/Opp         // Leeching STATS
	Went_Afk = 0
	afk=0
	TK_Last = null
	Delete = null

	obj/Ships/S=null
	Element
	ElementTicks
	EmpoweredDefenseTicks

	Redoing_Stats=0
	Points=15
	Max_Points=15
	Reformation_LastUse=0
	DontDisconnect=0

	//Logo="<img src=['discord.png']>"
	adminDensity=0 // Admin density, allows admins to pass through walls and such unscathed
	immortal = 0 // temporary var that disables death checks on the mob, it's for a system to check if we can prevent people from dying multiple times from one attack
	training_id // id to make sure the scheduled event belongs to the current action. we dont want it saved so its a tmp
/* To elaborate, every time somebody meditates/trains/digs a new event is thrown into the timer.
 * Now, this event is simply recycled, consider it a fancy loop.
 * What spamming the train/dig/meditate macro is meant to do (when they want to abuse it) is start multiples
 * of this loop so that they gain, much, much more than they are supposed to.
 * The training_id ensures that whatever other loops they attempted to schedule are killed before they're actually
 * giving any stats to the player.

 * training_id is used for digging, meditate and training because they cannot use either of these at the same time anyway
 * so there is no reason to use a unique id for these events.
*/

mob/var

	Total_Stats_Energy = 0
	Total_Stats_Strength = 0
	Total_Stats_Endurance = 0
	Total_Stats_Speed = 0
	Total_Stats_Off = 0
	Total_Stats_Def = 0
	Total_Stats_Regen = 0
	Total_Stats_Recov = 0

/* General Stats */


	//Born = 0
	Offspring=0
	HybridBaby=0
	DoesNotAffectStatRank=0
	HasCreated=0 // Prevent people from stacking statpoints to increase their mods.
	SelectingRace=0 //Prevents people from changing race after being spawned
	AgreedtoTerms=0 // Prevents people from spending XP on the creation window
	NitroBooster=0
	SelectedAge=0
	BodySwap=0
	Font="name"
	Race="Undefined"  //Was nothing  null.var bug
	Class="Undefined Class"  //Was nothing  null.var bug

	BP=1
	Base=1
	Body=1
	Ki=1
	MaxKi=1
	Pow=1
	Str=1
	Spd=1
	End=1
	Off=1
	Def=1
	Anger=100
	MaxAnger=120

	BPMult=1
	KiMult=1
	PowMult=1
	StrMult=1
	SpdMult=1
	EndMult=1
	OffMult=1
	DefMult=1
	RegenMult=1
	RecovMult=1
	AngerMult=1

	BaseMaxAnger=120
	BaseMaxKi=1
//	BasePow=1
	BaseStr=1
	BaseSpd=1
	BaseEnd=1
	BaseOff=1
	BaseDef=1
	BaseRegeneration=1
	BaseRecovery=1

	BPMod=1
	KiMod=1
//	PowMod=1
	StrMod=1
	SpdMod=1
	EndMod=1
	OffMod=1
	DefMod=1
	Regeneration=1
	Recovery=1

	GravMastered=1
	GravMulti = 1
	GravMod=1
	Zenkai=1
	MedMod=1

	Hunger=0
	Thirst=0
	Fatigue=0

	Age=0
	Real_Age=0
	Immortal=0
	InclineAge=18
	Decline=30

	TK_Magic = 0
	TK = 0
	Kills = 0
	Signature_True = 0
	RPs = 0


	Blindness = null
	x_view = 15
	y_view = 15

	Destroy_Walls = 0
	HPDoesNotAffectBP = 0
	KiDoesNotAffectBP = 0
	IgnoresBrokenLimbs = 0
	IgnoresGodKi=0
	NoBreak = 0

// Character Profile Vars

	Height="N/A"
	BodyWeight="N/A"
	Backstory="N/A"
	ImageLink="http://pngimg.com/uploads/question_mark/question_mark_PNG141.png"
	Portrait
	radarChart

	//Alignment = 0
	//AlignmentTxt = "Neutral"


/* Variables required for UnTeleport and ReturnMob */

	unSummonX=1
	unSummonY=1
	unSummonZ=1

/* Unsorted as of yet */

	datum/mind/mind
	real_name

	undelayed
	stretch=0
	ViewX=15
	ViewY=15
	//Decimals=0
	TextSize=2
	seetelepathy=1

	hair

	HairColor
	BPpcnt=100
	attackable=1

	BreathInSpace=0


	RoidPower=0
	HBTCPower=0
	BlackWaterPower=0
	RPPower=1
	RPPowerAdd=0
	RacialPowerAdd=0

	AndroidLevel=0
	oicon=" "
	Warp=0
//	HasSuperTuffle=0 //Was nothing  null.var bug

	Regenerate=0 //Death Regen Var
	Regenerating//Death regen temp var

	Refire=20
	Dead=0
	Died = 0
	Life=100
	Anger_Restoration=0
	//Last_Anger=0 //So you can't get angry again til enough time passes


/* Saiyan variables */
	OozaruIcon='DSOozaru.dmi'
	Oozaru=0
	OozaruMastery = 50
	OozaruTimer=0

	ssj = 0

	HasSSj = 0
	HasSSj4 = 0
	HasSSj6 = 0
//	SSjAt=0
//	SSjAdd=0
//	SSj2At=0
//	SSj2Add=0
//	SSj3At=0
//	SSj3Add=0
//	SSj4At=0

	SSjMult=1.5
	SSjDrain=100
	SSjMod=1

	SSj2Mult=1.3
	SSj2Drain=100
	SSj2Mod=1

	SSj3Mult=1.2
	SSj3Drain=100
	SSj3Mod=1

	SSj4Mult=4
	SSj6Mult=4.25
	SSj6Mod=1


	SSGSSColor
	SSGSSDrain=50

	SSjHair='Hair_GokuSSj.dmi'
	USSjHair='Hair_GokuUSSj.dmi'
	SSjFPHair='Hair_GokuSSjFP.dmi'
	SSj2Hair='Hair_GokuUSSj.dmi'
	SSj3Hair='Hair_GokuSSj3.dmi'
	SSj4Hair='Hair_SSj4.dmi'
	SSGSSHair='Hair_GokuSSB.dmi'
	SSGFPHair='Hair_GokuSSBFP.dmi'
	SSRHair='Hair_GokuSSR.dmi'
	SSGHair

/* Changeling variables */
	Form=0

	HasForm=0
	Form2Mult = 1.1
	Form3Mult = 1.1
	Form4Mult = 1.5
	Form5Mult = 1.1
	Form6Mult = 1.2
	Form7Mult = 1.4
/*
	Form2Add = 0
	Form3Add = 0
	Form4Add = 0
	Form5Add = 0
	Form6Add = 0*/
	Form1Icon
	Form2Icon
	Form3Icon
	Form4Icon
	Form5Icon='Changeling Koola Expand.dmi'
	Form6Icon='FriezaGold.dmi'
	Form7Icon='BlackFrieza.dmi'
	Form6Drain=50
	Form7Drain = 100

	//Enlarged
//	AlienBuild="Melee"
	HasAlienTrans=0
	AlienTrans=0
	TransDrain = 100
	//TransReq=100000

	HasBojack=0
	Bojack=0
	BojackMult=1.5
	SuperBojackMult=1.25
	//SuperBojackAt=0


	WeightedStats=0

	HadStarBoost=0
	MakyoPower=0


	CanPilotAS=0

	snj = 0
	SNjAt=0
	HasSNj=0



	SparSSj=0
	SparAscended=0




	Rank


	list/Buffs=list()
	BuffLimit=3
	BuffNumber=0


/* Time Freeze */

//	Temperature


	obj/GodKiAura=new/Icon_Obj/Cloak/GodAura//'Aura_godtest.dmi'




	FlightAura='Aura Fly.dmi'
	BlastCharge='Charge1.dmi'
	KiHitEffect='fevExplosion.dmi'
	//Burst='Burst.dmi'

	Modules=0

	//Temperature

	Counterpart

//	forbidMovement

	FlySkill=1
	FlyMod=1
	SuperFly=0
	Zanzoken=1
	ZanzoMod=1

	Build=1
	RP_Total = 0
	AS_Droid = 0 //Is this player a Android ship android


	Fusions=0


	ismajin=0
	ismystic=0
	Precognition=0 //for the blast avoidance...


	PotentialUnlocked=0
	//Potential=1


	//ITMod=1
	Absorb=0
//	Absorb_Max = 0
	Semiperfect_Form=0
	Perfect_Form=0
	Fruits=0
	KeepsBody=0 //If this is 1 you keep your body when Dead.
	GavePower=0
	GotPower=0


	Spar = 1
	Critical_Left_Arm = 0
	Critical_Left_Leg = 0
	Critical_Right_Leg = 0
	Critical_Right_Arm = 0
	Critical_Head = 0
	Critical_Sight = 0
	Critical_Throat = 0
	Critical_Torso = 0
	Critical_Hearing = 0
	Critical_Mate = 0
	Critical_Tail = 0


	Conjured=0
	Conjurer=""
	ConjureX=1
	ConjureY=1
	ConjureZ=1
	ConjuredKey=""

	list/Overlays=new


//	Flyer
	Asexual
	HBTC_Enters=0


//	Kaioken=1
//	KaiokenBP=0
	KaiokenCycle=0
	Senzu=0
	HealthPotion=0

//	Immunity=0
//	Poisoned=0


	Hair_Base
	Hair_Age=1
	BirthYear=0
	BirthMonth=0
	DayCreated=0
	SaveAge=0
	LogYear=0



	Majin_By = null //For majin to check who gave them it.


	pfocus="Balanced"
//	sfocus="Balanced"
	mfocus="Balanced"
	ifocus=0
	magicfocus=0

	Mining_Level=1
	Mining_XP=0
	Mining_Next=500

	Smithing_Level=1
	Smithing_XP=0
	Smithing_Next=500

	Fishing_Level=1
	Fishing_XP=0
	Fishing_Next=500

	Cooking_Level=1
	Cooking_XP=0
	Cooking_Next=500

	Int_Level=1
	Int_XP=0
	Int_Next=1000
	Int_Mod=1

	Magic_Level=1
	Magic_XP=0
	Magic_Next=1000
	Magic_Potential = 1

	GainMultiplier=1

	P_BagG=5
	ZenkaiPower=0


	StatRank=1
	BPRank=1
	list/Minimum_Stats=new
	list/LearnList=list()//new

	medreward // Variable to allow an admin to reward and raise their levels WITHOUT forcing the player to meditate
	medrewardmagic

	Contacts = list()
	Ignores = list()

/* CLONING TANK related */

	TotalDeaths=0


	insideTank=0
	insidePhylactery=0
	Phylactery = 0

// Swimming related

	isSwimming = 0
	swimSkill = 100







//New wipe variables
	BoosterTag
	OOCTag

	CanLimbRegen=0
	KOd=0
	BirthDate="None"
	Signature = 0
//	GoldStarsTotal=0
	Stance=null
	StanceLevel=null
	//HasSSG=0
	SwordOn=0
	HammerOn=0
	GlovesOn=0
	MaskOn=0
	ArmorOn=0
	Willpower=100
	SwordSkill=1
	UnarmedSkill=1
	KiManipulation=1
	Athleticism=1
	SwordSkillAdd=0
	UnarmedSkillAdd=0
	KiManipulationAdd=0
	AthleticismAdd=0
	IsBandaged=0
	Sterile=0
	ScouterOn=0
	BuildInSpace=0

// Gain System Vars

//	GainCap=0
//	Rested=0
//	StartingStat=1
//	CurrentStat=1
//	StartingBP=1
//	CurrentBP=1
//	TotalStart=1
//	TotalCurrent=1
//	TotalChange=1

	Racial_Stats=2
	list/Mutations=list()
	MutationNumber
	UniqueMutation=0
	EnablementSlot=0
	MaxHealth=100
	MaxWillpower=100
	GotStarterBoost=0
	Old_Sight=0
	CatchUpXPs=0
	BeenGivenStartingGrav=0

	Alignment="Neutral"
	AlignmentNumber=0
	GoodKills=0
	BadKills=0
	Vampire=0

	Infection=0


	GotRE=0

	TaxPaid=0
	MTaxPaid=0

	HelmetOn=0
	VillainTrain=0


	CustomZanzokenIcon='Zanzoken.dmi'

	ThirdEyeAt=0
	SSjAt=0

	HPTick=0
	KiTick=0
