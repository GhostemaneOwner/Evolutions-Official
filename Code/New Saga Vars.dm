var/custom_powerup
var/customPUnameInclude

/mob/verb/customizePU()
    set name = "Customize: PU Charging"
    set category = "Other"
    if(!src.client)
        return
    var/choice = input(src, "Change PU Charging", "PU Charging Style") as text
    if(length(choice)>200)
        return
    if(length(choice)<1)
        return
    custom_powerup = choice
    choice = input(src, "Do you want to include your name in the PU charging?") in list("Yes", "No")
    if(choice == "Yes")
        customPUnameInclude = TRUE
    else
        customPUnameInclude = FALSE


mob
	var/SagaLevel=0//Level for all tier s.
	var/SagaEXP=0//holds rpp investment
	var/SagaAdminPermission //allows override of rpp requirements and is required for tier 7/8

	var/list/SagaAscension=list("Str"=0, "End"=0, "Spd"=0, "For"=0)

	//Tier S variables.

	//WEAPON SOUL
	var/WeaponSoulType
	var/BoundLegend//GIVE ME MY SWORD BACK NO JUTSU

	//PERSONA!!!
	var/PersonaName
	var/PersonaAction
	var/PersonaType
	var/PersonaStrength
	var/PersonaEndurance
	var/PersonaSpeed
	var/PersonaForce
	var/PersonaOffense
	var/PersonaDefense
	var/PersonaRegeneration
	var/PersonaRecovery

	//JAGAN EYE
	var/JaganPowerNerf

	//UNLIMITED BLADE WORKS
	var/UBWReinforce//Adds extra reinforcement stats.
	var/UBWTrace//When this is marked, you can trace legendary weapons.
	var/KanshouBakuyaProject
	var/HolyBladeProject
	var/CorruptEdgeProject
	var/ProjectExcalibur
	var/ProjectLightbringer
	var/ProjectMuramasa
	var/ProjectDeathbringer
	var/MadeOfSwords
	var/PerfectProjection
	var/InUBW

	//ANSATSUKEN
	var/AnsatsukenPath
	var/AnsatsukenAscension

	//EIGHT GATES
	var/GatesActive=0
	var/Gate8Used=0
	var/Gate8Getups=0

	//VAIZARD
	var/VaizardRage//TODO: REMOVE
	var/VaizardHealth//You become immune to damage while this is up.
	var/VaizardType//Physical, Spiritual, Technical, Balanced
	var/VaizardIcon
	var/VaizardCounter//The more you get knocked out, the more likely vaizard is to trigger.

	//SHARINGAN
	var/SharinganEvolution

	//JINCHUURIKI
	var/JinchuuType

	//KAMUI
	var/KamuiType//Purity or Impulse
	var/KamuiBuffLock//Disallows active slot buffs

	//KEYBLADES
	var/KeybladeType
	var/KeybladeColor
	var/list/Keychains=list()
	var/KeychainAttached
	var/SyncAttached
	var/LimitCounter=0//Add one each form use; used to determine when antiform happens.

	//SAINT SEIYA
	var/SenseUnlocked=5
	var/ClothBronze
	var/ClothGold
	