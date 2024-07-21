




mob/verb/SkillPurchase()
	set category=null
	var/list/ListOfSkills=list()

//Tier 1 > 2 175
//Tier 2 > 3 350
//Tier 3 > 4 700
	if(!HasCustomStance)ListOfSkills+="Custom Stance(400)"

//Tier 2
	if(!(locate(/Skill/Attacks/Barrage)in usr)&&(locate(/Skill/Attacks/Blast)in usr)) ListOfSkills+="Blast -> Barrage (220 XP)(Force)"

	if(!(locate(/Skill/Attacks/GuideBomb)in usr)&&(locate(/Skill/Attacks/Charge)in usr)) ListOfSkills+="Charge -> Guide Bomb (220 XP)(Force)"
	if(!(locate(/Skill/Attacks/SpiritBall)in usr)&&(locate(/Skill/Attacks/Charge)in usr)) ListOfSkills+="Charge -> Spirit Ball (220 XP)(Force)"
	if(!(locate(/Skill/Attacks/ExplosiveWave)in usr)&&(locate(/Skill/Attacks/Charge)in usr)) ListOfSkills+="Charge -> Explosive Wave (220 XP)(Force)"
	if(!(locate(/Skill/Attacks/Mortar_Charge)in usr)&&(locate(/Skill/Attacks/Charge)in usr)) ListOfSkills+="Charge -> Mortar Charge (220 XP)(Force)"
	if(!(locate(/Skill/Attacks/DestructoDisc)in usr)&&(locate(/Skill/Attacks/Charge)in usr)) ListOfSkills+="Charge -> Destructo Disc (220 XP)(Force)"

	if(!(locate(/Skill/Weapon/Riposte)in usr)&&(locate(/Skill/Misc/Block)in usr)) ListOfSkills+="Block -> Riposte (220 XP)"
	if(!(locate(/Skill/Unarmed/CatchTheBlade)in usr)&&(locate(/Skill/Misc/Block)in usr)) ListOfSkills+="Block -> Catch The Blade (220 XP)(Unarmed)"


	if(!(locate(/Skill/Attacks/RockSlide)in usr)&&(locate(/Skill/Attacks/RockThrow)in usr)) ListOfSkills+="Rock Throw -> Rock Slide (220 XP)(Strength)"

	if(!(locate(/Skill/Misc/KiBlade)in usr)&&(locate(/Skill/Misc/KiFists)in usr)) ListOfSkills+="Ki Fists -> Ki Blade (220 XP)(Force)"
	if(!(locate(/Skill/Misc/KiBow)in usr)&&(locate(/Skill/Misc/KiFists)in usr)) ListOfSkills+="Ki Fists -> Ki Bow (220 XP)(Force)"

	if(!(locate(/Skill/Melee/Headbutt)in usr)&&(locate(/Skill/Weapon/Bash)in usr)) ListOfSkills+="Bash -> Headbutt (220 XP)(Strength)"

	if(!(locate(/Skill/Melee/PressurePunch)in usr)&&(locate(/Skill/Attacks/Shockwave)in usr)) ListOfSkills+="Shockwave -> Pressure Punch (220 XP)(Strength)"

	if(!(locate(/Skill/Weapon/SwordStab)in usr)&&(locate(/Skill/Weapon/Slice)in usr)) ListOfSkills+="Slice -> Sword Stab (220 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/CleaveAttack)in usr)&&(locate(/Skill/Weapon/Slice)in usr)) ListOfSkills+="Slice -> Cleave Attack (220 XP)(Weapon)"
	if(!(locate(/Skill/Attacks/EchoingSlash)in usr)&&(locate(/Skill/Weapon/Slice)in usr)) ListOfSkills+="Slice -> Echoing Slash (220 XP)(Weapon)"

	if(!(locate(/Skill/Unarmed/UppercutCombo)in usr)&&(locate(/Skill/Melee/DashAttack)in usr)) ListOfSkills+="Dash Attack -> Uppercut Combo (220 XP)(Unarmed)"
	if(!(locate(/Skill/Melee/PressurePunch)in usr)&&(locate(/Skill/Melee/RoundhouseKick)in usr)) ListOfSkills+="Roundhouse Kick -> Pressure Punch (220 XP)(Strength)"
	if(!(locate(/Skill/Unarmed/MegatonThrow)in usr)&&(locate(/Skill/Melee/RoundhouseKick)in usr)) ListOfSkills+="Roundhouse Kick -> Megaton Throw (220 XP)(Unarmed)"

	if(!(locate(/Skill/Melee/TelekineticPull)in usr)&&(locate(/Skill/Melee/WarpAttack)in usr)) ListOfSkills+="Warp Attack -> Telekinetic Pull (220 XP)(Strength)"
	if(!(locate(/Skill/Zanzoken)in usr)&&(locate(/Skill/Melee/WarpAttack)in usr)) ListOfSkills+="Warp Attack -> Zanzoken (220 XP)"

	if(!(locate(/Skill/Support/Heal)in usr)&&(locate(/Skill/Buff/Power_Control)in usr)) ListOfSkills+="Power Control -> Heal (220 XP)"



//Tier 3
	if(!(locate(/Skill/Attacks/Homing_Finisher)in usr)&&(locate(/Skill/Attacks/Barrage)in usr)) ListOfSkills+="Barrage -> Homing Finisher (440 XP)(Force)"

	if(!(locate(/Skill/Attacks/MegaBurst)in usr)&&(locate(/Skill/Attacks/GuideBomb)in usr)) ListOfSkills+="Guide Bomb -> MegaBurst (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)&&(locate(/Skill/Attacks/GuideBomb)in usr)) ListOfSkills+="Guide Bomb -> Custom Beam (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/SolarFlare)in usr)&&(locate(/Skill/Attacks/GuideBomb)in usr)) ListOfSkills+="Guide Bomb -> Solar Flare (440 XP)"
//
	if(!(locate(/Skill/Attacks/MegaBurst) in usr)&&(locate(/Skill/Attacks/SpiritBall)in usr)) ListOfSkills+="Spirit Ball -> MegaBurst (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/SolarFlare) in usr)&&(locate(/Skill/Attacks/SpiritBall)in usr)) ListOfSkills+="Spirit Ball -> Solar Flare (440 XP)"
	if(!(locate(/Skill/Attacks/Beams/Ray) in usr)&&(locate(/Skill/Attacks/SpiritBall)in usr)) ListOfSkills+="Spirit Ball -> Ray (440 XP)(Force)"

	if(!(locate(/Skill/Attacks/MegaBurst) in usr)&&(locate(/Skill/Attacks/ExplosiveWave)in usr)) ListOfSkills+="Explosive Wave -> MegaBurst (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/Explosion) in usr)&&(locate(/Skill/Attacks/ExplosiveWave)in usr)) ListOfSkills+="Explosive Wave -> Explosion (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/Self_Destruct) in usr)&&(locate(/Skill/Attacks/ExplosiveWave)in usr)) ListOfSkills+="Explosive Wave -> Self Destruct (440 XP)(Offense)"

	if(!(locate(/Skill/Attacks/MegaBurst) in usr)&&(locate(/Skill/Attacks/Mortar_Charge)in usr)) ListOfSkills+="Mortar Charge -> MegaBurst (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/Explosion) in usr)&&(locate(/Skill/Attacks/Mortar_Charge)in usr)) ListOfSkills+="Mortar Charge -> Explosion (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/SolarFlare) in usr)&&(locate(/Skill/Attacks/Mortar_Charge)in usr)) ListOfSkills+="Mortar Charge -> Solar Flare (440 XP)"

	if(!(locate(/Skill/Attacks/MegaBurst) in usr)&&(locate(/Skill/Attacks/DestructoDisc)in usr)) ListOfSkills+="Destructo Disc -> MegaBurst (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/SolarFlare) in usr)&&(locate(/Skill/Attacks/DestructoDisc)in usr)) ListOfSkills+="Destructo Disc -> Solar Flare (440 XP)"
	if(!(locate(/Skill/Attacks/Beams/Ray) in usr)&&(locate(/Skill/Attacks/DestructoDisc)in usr)) ListOfSkills+="Destructo Disc -> Ray (440 XP)(Force)"


	if(!(locate(/Skill/Melee/Guard_Break) in usr)&&(locate(/Skill/Unarmed/CatchTheBlade)in usr)) ListOfSkills+="Catch The Blade -> Guard Break (440 XP)(Melee)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Unarmed/CatchTheBlade)in usr)) ListOfSkills+="Catch The Blade -> Expand (440 XP)"
	if(!(locate(/Skill/Melee/Guard_Break) in usr)&&(locate(/Skill/Weapon/Riposte)in usr)) ListOfSkills+="Riposte -> Guard Break (440 XP)(Melee)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Weapon/Riposte)in usr)) ListOfSkills+="Riposte -> Expand (440 XP)"

	if(!(locate(/Skill/Unarmed/PileDriver) in usr)&&(locate(/Skill/Weapon/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Pile Driver (440 XP)(Unarmed)"
	if(!(locate(/Skill/Weapon/Iai_Slash) in usr)&&(locate(/Skill/Weapon/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Iai Slash (440 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/Colossal_Impact)in usr)&&(locate(/Skill/Weapon/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Colossal Impact (440 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/Overhead_Smash)in usr)&&(locate(/Skill/Weapon/SwordStab)in usr)) ListOfSkills+="Sword Stab -> Overhead Smash (440 XP)(Weapon)"

	if(!(locate(/Skill/Weapon/Wind_Howl) in usr)&&(locate(/Skill/Weapon/CleaveAttack)in usr)) ListOfSkills+="Cleave Attack -> Wind Howl (440 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/Colossal_Impact)in usr)&&(locate(/Skill/Weapon/CleaveAttack)in usr)) ListOfSkills+="Cleave Attack -> Colossal Impact (440 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/Overhead_Smash)in usr)&&(locate(/Skill/Weapon/CleaveAttack)in usr)) ListOfSkills+="Cleave Attack -> Overhead Smash (440 XP)(Weapon)"

	if(!(locate(/Skill/Weapon/Colossal_Impact)in usr)&&(locate(/Skill/Attacks/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Colossal Impact (440 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/Wind_Howl) in usr)&&(locate(/Skill/Attacks/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Wind Howl (440 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/Overhead_Smash)in usr)&&(locate(/Skill/Attacks/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Overhead Smash (440 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/Iai_Slash) in usr)&&(locate(/Skill/Attacks/EchoingSlash)in usr)) ListOfSkills+="Echoing Slash -> Iai Slash (440 XP)(Weapon)"

	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Attacks/RockSlide)in usr)) ListOfSkills+="Rock Slide -> Expand (440 XP)"
	if(!(locate(/Skill/Attacks/RockTomb) in usr)&&(locate(/Skill/Attacks/RockSlide)in usr)) ListOfSkills+="Rock Slide -> Rock Tomb (440 XP)(Strength)"

	if(!(locate(/Skill/Unarmed/PileDriver) in usr)&&(locate(/Skill/Unarmed/UppercutCombo)in usr)) ListOfSkills+="Uppercut Combo -> Pile Driver (440 XP)(Unarmed)"
	if(!(locate(/Skill/Melee/Kickback_Combo) in usr)&&(locate(/Skill/Unarmed/UppercutCombo)in usr)) ListOfSkills+="Uppercut Combo -> Kickback Combo (440 XP)(Melee)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Unarmed/UppercutCombo)in usr)) ListOfSkills+="Uppercut Combo -> Expand (440 XP)"

	if(!(locate(/Skill/Attacks/Earthquake) in usr)&&(locate(/Skill/Unarmed/MegatonThrow)in usr)) ListOfSkills+="Megaton Throw -> Earthquake (440 XP)(Strength)"
	if(!(locate(/Skill/Unarmed/PileDriver) in usr)&&(locate(/Skill/Unarmed/MegatonThrow)in usr)) ListOfSkills+="Megaton Throw -> Pile Driver (440 XP)(Unarmed)"
	if(!(locate(/Skill/Buff/Expand) in usr)&&(locate(/Skill/Unarmed/MegatonThrow)in usr)) ListOfSkills+="Megaton Throw -> Expand (440 XP)"

	if(!(locate(/Skill/Melee/Wing_Clip) in usr)&&(locate(/Skill/Melee/TelekineticPull)in usr)) ListOfSkills+="Telekinetic Pull -> Wing Clip (440 XP)(Melee)"
	if(!(locate(/Skill/Melee/Wing_Clip) in usr)&&(locate(/Skill/Melee/PressurePunch)in usr)) ListOfSkills+="Pressure Punch -> Wing Clip (440 XP)(Melee)"
	if(!(locate(/Skill/Melee/Kickback_Combo) in usr)&&(locate(/Skill/Melee/PressurePunch)in usr)) ListOfSkills+="Pressure Punch -> Kickback Combo (440 XP)(Melee)"

	if(!(locate(/Skill/Support/Splitform) in usr)&&(locate(/Skill/Support/Heal)in usr)) ListOfSkills+="Heal -> Splitform (440 XP)"
	if(!(locate(/Skill/Support/Send_Energy) in usr)&&(locate(/Skill/Support/Heal)in usr)) ListOfSkills+="Heal -> Send Energy (440 XP)"



	if(!(locate(/Skill/Misc/KiHammer)in usr)&&(locate(/Skill/Misc/KiBlade)in usr)) ListOfSkills+="Ki Blade -> Ki Hammer (440 XP)(Force)"
	if(!(locate(/Skill/Misc/KiBow2)in usr)&&(locate(/Skill/Misc/KiBow)in usr)) ListOfSkills+="Ki Bow -> Ki Bow 2 (440 XP)(Force)"
	if(!(locate(/Skill/Attacks/Block_The_Sky)in usr)&&(locate(/Skill/Misc/KiBow)in usr)) ListOfSkills+="Ki Bow -> Block The Sky (440 XP)(Ki Bow)"
	if(!(locate(/Skill/Attacks/Exploding_Bolt)in usr)&&(locate(/Skill/Misc/KiBow)in usr)) ListOfSkills+="Ki Bow -> Exploding Bolt (440 XP)(Ki Bow)"


//Tier 4

	if(!(locate(/Skill/Attacks/Blaster_Meteor) in usr)&&(locate(/Skill/Attacks/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Blaster Meteor (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/Genocide) in usr)&&(locate(/Skill/Attacks/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Genocide (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/Hellzone_Grenade) in usr)&&(locate(/Skill/Attacks/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Hellzone Grenade (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/ExplosiveDemonWave) in usr)&&(locate(/Skill/Attacks/Homing_Finisher)in usr)) ListOfSkills+="Homing Finisher -> Explosive Demon Wave (880 XP)(Force)"


	if(!(locate(/Skill/Attacks/Dragon_Nova) in usr)&&(locate(/Skill/Attacks/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Dragon Nova (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/Death_Ball) in usr)&&(locate(/Skill/Attacks/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Death Ball (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/SpiritBomb) in usr)&&(locate(/Skill/Attacks/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Spirit Bomb (880 XP)(Offense)"
	if(!(locate(/Skill/Attacks/WallofFlame) in usr)&&(locate(/Skill/Attacks/MegaBurst)in usr)) ListOfSkills+="MegaBurst -> Wall Of Flame (880 XP)"

	if(!(locate(/Skill/Attacks/WallofFlame) in usr)&&(locate(/Skill/Attacks/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Wall Of Flame (880 XP)"
	if(!(locate(/Skill/Unarmed/PocketSand) in usr)&&(locate(/Skill/Attacks/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Pocket Sand (880 XP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/Exploding_Heart_Strike) in usr)&&(locate(/Skill/Attacks/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Exploding Heart Strike (880 XP)(Unarmed)"


	if(!(locate(/Skill/Attacks/TriBeam) in usr)&&(locate(/Skill/Attacks/Explosion)in usr)) ListOfSkills+="Explosion -> TriBeam (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/SuperExplosiveWave) in usr)&&(locate(/Skill/Attacks/Explosion)in usr)) ListOfSkills+="Explosion -> Super Explosive Wave (880 XP)(Offense)"
	if(!(locate(/Skill/Attacks/ExplosiveDemonWave) in usr)&&(locate(/Skill/Attacks/Explosion)in usr)) ListOfSkills+="Explosion -> Explosive Demon Wave (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/Hellzone_Grenade) in usr)&&(locate(/Skill/Attacks/Explosion)in usr)) ListOfSkills+="Explosion -> Hellzone Grenade (880 XP)(Force)"

	if(!(locate(/Skill/Unarmed/WolfFangFist) in usr)&&(locate(/Skill/Melee/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Wolf Fang Fist (880 XP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/ConsecutiveNormalPunches) in usr)&&(locate(/Skill/Melee/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Consecutive Normal Punches (880 XP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/Texas_Smash) in usr)&&(locate(/Skill/Melee/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Texas Smash (880 XP)(Unarmed)"
	if(!(locate(/Skill/Melee/AxeKick) in usr)&&(locate(/Skill/Melee/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Axe Kick (880 XP)(Melee)"
	if(!(locate(/Skill/Unarmed/Lions_Roar) in usr)&&(locate(/Skill/Melee/Kickback_Combo)in usr)) ListOfSkills+="Kickback Combo -> Lions Roar (880 XP)(Unarmed)"


	if(!(locate(/Skill/Attacks/TriBeam) in usr)&&(locate(/Skill/Attacks/Self_Destruct)in usr)) ListOfSkills+="Self Destruct -> TriBeam (880 XP)(Force)"
	if(!(locate(/Skill/Unarmed/Lions_Roar) in usr)&&(locate(/Skill/Attacks/Self_Destruct)in usr)) ListOfSkills+="Self Destruct -> Lions Roar (880 XP)(Unarmed)"


	if(!(locate(/Skill/Unarmed/ConsecutiveNormalPunches) in usr)&&(locate(/Skill/Melee/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Consecutive Normal Punches (880 XP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/Texas_Smash) in usr)&&(locate(/Skill/Melee/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Texas Smash (880 XP)(Unarmed)"
	if(!(locate(/Skill/Melee/CriticalEdge) in usr)&&(locate(/Skill/Melee/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Critical Edge (880 XP)(Melee)"
	if(!(locate(/Skill/Melee/AxeKick) in usr)&&(locate(/Skill/Melee/Guard_Break)in usr)) ListOfSkills+="Guard Break -> Axe Kick (880 XP)(Melee)"


	if(!(locate(/Skill/Unarmed/Texas_Smash) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Texas Smash (880 XP)(Unarmed)"
	if(!(locate(/Skill/Melee/CriticalEdge) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Critical Edge (880 XP)(Melee)"
	if(!(locate(/Skill/Melee/AxeKick) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Axe Kick (880 XP)(Melee)"
	if(!(locate(/Skill/Unarmed/Lions_Roar) in usr)&&(locate(/Skill/Buff/Expand)in usr)) ListOfSkills+="Expand -> Lions Roar (880 XP)(Unarmed)"

	if(!(locate(/Skill/Unarmed/BurningShot) in usr)&&(locate(/Skill/Unarmed/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Burning Shot (880 XP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/WolfFangFist) in usr)&&(locate(/Skill/Unarmed/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Wolf Fang Fist (880 XP)(Unarmed)"
	if(!(locate(/Skill/Melee/MarchOfFury) in usr)&&(locate(/Skill/Unarmed/PileDriver)in usr)) ListOfSkills+="Pile Driver -> March Of Fury (880 XP)(Melee)"
	if(!(locate(/Skill/Unarmed/Exploding_Heart_Strike) in usr)&&(locate(/Skill/Unarmed/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Exploding Heart Strike (880 XP)(Unarmed)"


	if(!(locate(/Skill/Attacks/SkyBreak) in usr)&&(locate(/Skill/Weapon/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Sky Break (880 XP)(Weapon)"
	if(!(locate(/Skill/Melee/MarchOfFury) in usr)&&(locate(/Skill/Weapon/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> March Of Fury (880 XP)(Melee)"
	if(!(locate(/Skill/Weapon/Flourish) in usr)&&(locate(/Skill/Weapon/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Flourish (880 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/BurningSlash) in usr)&&(locate(/Skill/Weapon/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Burning Slash (880 XP)(Weapon)"


	if(!(locate(/Skill/Attacks/SkyBreak) in usr)&&(locate(/Skill/Weapon/Colossal_Impact)in usr)) ListOfSkills+="Colossal Impact -> Sky Break (880 XP)(Weapon)"
	if(!(locate(/Skill/Attacks/HyperTornado) in usr)&&(locate(/Skill/Weapon/Colossal_Impact)in usr)) ListOfSkills+="Colossal Impact -> Hyper Tornado (880 XP)(Speed)"
	if(!(locate(/Skill/Weapon/Flourish) in usr)&&(locate(/Skill/Weapon/Colossal_Impact)in usr)) ListOfSkills+="Colossal Impact -> Flourish (880 XP)(Weapon)"


	if(!(locate(/Skill/Attacks/KillDriver) in usr)&&(locate(/Skill/Melee/Wing_Clip)in usr)) ListOfSkills+="Wing Clip  -> Kill Driver (880 XP)"
	if(!(locate(/Skill/Attacks/HyperTornado) in usr)&&(locate(/Skill/Melee/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Hyper Tornado (880 XP)(Speed)"
	if(!(locate(/Skill/Melee/CriticalEdge) in usr)&&(locate(/Skill/Melee/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Critical Edge (880 XP)(Melee)"
	if(!(locate(/Skill/Unarmed/PocketSand) in usr)&&(locate(/Skill/Melee/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Pocket Sand (880 XP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/Exploding_Heart_Strike) in usr)&&(locate(/Skill/Melee/Wing_Clip)in usr)) ListOfSkills+="Wing Clip -> Exploding Heart Strike (880 XP)(Unarmed)"


	if(!(locate(/Skill/Melee/MarchOfFury) in usr)&&(locate(/Skill/Attacks/Earthquake)in usr)) ListOfSkills+="Earthquake -> March Of Fury (880 XP)(Melee)"
	if(!(locate(/Skill/Unarmed/WolfFangFist) in usr)&&(locate(/Skill/Attacks/Earthquake)in usr)) ListOfSkills+="Earthquake -> Wolf Fang Fist (880 XP)(Unarmed)"
	if(!(locate(/Skill/Unarmed/PocketSand) in usr)&&(locate(/Skill/Attacks/Earthquake)in usr)) ListOfSkills+="Earthquake -> Pocket Sand (880 XP)(Unarmed)"

	if(!(locate(/Skill/Attacks/SkyBreak) in usr)&&(locate(/Skill/Weapon/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Sky Break (880 XP)(Weapon)"
	if(!(locate(/Skill/Attacks/HyperTornado) in usr)&&(locate(/Skill/Weapon/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Hyper Tornado (880 XP)(Speed)"
	if(!(locate(/Skill/Weapon/Flourish) in usr)&&(locate(/Skill/Weapon/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Flourish (880 XP)(Weapon)"
	if(!(locate(/Skill/Weapon/BurningSlash) in usr)&&(locate(/Skill/Weapon/Wind_Howl)in usr)) ListOfSkills+="Wind Howl -> Burning Slash (880 XP)(Weapon)"


	if(!(locate(/Skill/Attacks/SuperGhostKamikazeAttack) in usr)&&(locate(/Skill/Support/Splitform)in usr)) ListOfSkills+="Splitform -> Super Ghost Kamikaze (880 XP)(Strength)"
	if(!(locate(/Skill/Attacks/BlueCometSpecial) in usr)&&(locate(/Skill/Support/Splitform)in usr)) ListOfSkills+="Splitform -> Blue Comet Special (880 XP)(Speed)"

//	if(!(locate(/Skill/Support/PlantSenzu) in usr)&&(locate(/Skill/Support/Send_Energy)in usr)) ListOfSkills+="Send Energy -> Plant Senzu Bean (880 XP)"
	if(!(locate(/Skill/Support/Give_Power) in usr)&&(locate(/Skill/Support/Send_Energy)in usr)) ListOfSkills+="Send Energy -> Give Power (880 XP)"

	if(!(locate(/Skill/Misc/SpiritSword) in usr)&&(locate(/Skill/Misc/KiHammer)in usr)) ListOfSkills+="Ki Hammer -> Spirit Sword (880 XP)(Force)"
	if(!(locate(/Skill/Misc/KiBow3)in usr)&&(locate(/Skill/Misc/KiBow2)in usr)) ListOfSkills+="Ki Bow 2 -> Ki Bow 3 (880 XP)(Force)"
	if(!(locate(/Skill/Attacks/IceArrow)in usr)&&(locate(/Skill/Misc/KiBow2)in usr)) ListOfSkills+="Ki Bow 2 -> Ice Arrow (880 XP)(Ki Bow/Slows)"


	if(!(locate(/Skill/Melee/Torrential_Strike) in usr)&&(locate(/Skill/Melee/Wing_Clip)in usr)) ListOfSkills+="Wing Clip  -> Torrential Strike (880 XP)(Melee)"
	if(!(locate(/Skill/Melee/Torrential_Strike) in usr)&&(locate(/Skill/Weapon/Overhead_Smash)in usr)) ListOfSkills+="Overhead Smash -> Torrential Strike (880 XP)(Melee)"
	if(!(locate(/Skill/Melee/Torrential_Strike) in usr)&&(locate(/Skill/Unarmed/PileDriver)in usr)) ListOfSkills+="Pile Driver -> Torrential Strike (880 XP)(Melee)"
	if(!(locate(/Skill/Melee/Torrential_Strike) in usr)&&(locate(/Skill/Attacks/SolarFlare)in usr)) ListOfSkills+="Solar Flare -> Torrential Strike (880 XP)(Melee)"




	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Dodompa (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Dodompa (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Final Flash (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Final Flash (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Galic Gun (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Galic Gun (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Kamehameha (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Kamehameha (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Masenko (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Masenko (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Piercer (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Piercer (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Double Sunday (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Double Sunday (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Photon Flash (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Photon Flash (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Tyrant Lancer (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Tyrant Lancer (880 XP)(Force)"

	if((locate(/Skill/Attacks/Beams/CustomEnergyWave)in usr)) ListOfSkills+="Custom Beam -> Buster Cannon (880 XP)(Force)"
	if((locate(/Skill/Attacks/Beams/Ray)in usr)) ListOfSkills+="Ray -> Buster Cannon (880 XP)(Force)"
//Fixed


	ListOfSkills+="Cancel"
	var/Choice=input("Which skill would you like to purchase?") in ListOfSkills
	var/Cost=220
	if(Choice=="Cancel") return
	if(findtext(Choice,"220")) Cost=220
	if(findtext(Choice,"440")) Cost=440
	if(findtext(Choice,"880")) Cost=880

	var/SkillChoice
	if(findtext(Choice,"> Barrage")) SkillChoice=/Skill/Attacks/Barrage

	if(findtext(Choice,"> Guide Bomb")) SkillChoice=/Skill/Attacks/GuideBomb
	if(findtext(Choice,"> Spirit Ball")) SkillChoice=/Skill/Attacks/SpiritBall
	if(findtext(Choice,"> Explosive Wave")) SkillChoice=/Skill/Attacks/ExplosiveWave
	if(findtext(Choice,"> Mortar Charge")) SkillChoice=/Skill/Attacks/Mortar_Charge
	if(findtext(Choice,"> Destructo Disc")) SkillChoice=/Skill/Attacks/DestructoDisc

	if(findtext(Choice,"> Ki Bow")) SkillChoice=/Skill/Misc/KiBow
	if(findtext(Choice,"> Ki Bow 2")) SkillChoice=/Skill/Misc/KiBow2
	if(findtext(Choice,"> Ki Bow 3")) SkillChoice=/Skill/Misc/KiBow3

	if(findtext(Choice,"> Block The Sky")) SkillChoice=/Skill/Attacks/Block_The_Sky
	if(findtext(Choice,"> Ice Arrow")) SkillChoice=/Skill/Attacks/IceArrow
	if(findtext(Choice,"> Exploding Bolt")) SkillChoice=/Skill/Attacks/Exploding_Bolt

	if(findtext(Choice,"> Torrential Strike")) SkillChoice=/Skill/Melee/Torrential_Strike



	if(findtext(Choice,"> Ki Blade")) SkillChoice=/Skill/Misc/KiBlade
	if(findtext(Choice,"> Ki Hammer")) SkillChoice=/Skill/Misc/KiHammer

	if(findtext(Choice,"> Texas Smash")) SkillChoice=/Skill/Unarmed/Texas_Smash

	if(findtext(Choice,"> Iai Slash")) SkillChoice=/Skill/Weapon/Iai_Slash

	if(findtext(Choice,"> Spirit Sword")) SkillChoice=/Skill/Misc/SpiritSword

	if(findtext(Choice,"> Burning Slash")) SkillChoice=/Skill/Weapon/BurningSlash

	if(findtext(Choice,"> Kickback Combo")) SkillChoice=/Skill/Melee/Kickback_Combo

	if(findtext(Choice,"> Headbutt")) SkillChoice=/Skill/Melee/Headbutt

	if(findtext(Choice,"> Consecutive Normal Punches")) SkillChoice=/Skill/Unarmed/ConsecutiveNormalPunches
	if(findtext(Choice,"> Flourish")) SkillChoice=/Skill/Weapon/Flourish


	if(findtext(Choice,"> Catch The Blade")) SkillChoice=/Skill/Unarmed/CatchTheBlade
	if(findtext(Choice,"> Riposte")) SkillChoice=/Skill/Weapon/Riposte

	if(findtext(Choice,"> Sword Stab")) SkillChoice=/Skill/Weapon/SwordStab
	if(findtext(Choice,"> Overhead Smash")) SkillChoice=/Skill/Weapon/Overhead_Smash
	if(findtext(Choice,"> Colossal Impact")) SkillChoice=/Skill/Weapon/Colossal_Impact
	if(findtext(Choice,"> Cleave Attack")) SkillChoice=/Skill/Weapon/CleaveAttack
	if(findtext(Choice,"> Echoing Slash")) SkillChoice=/Skill/Attacks/EchoingSlash

	if(findtext(Choice,"> Rock Slide")) SkillChoice=/Skill/Attacks/RockSlide
	if(findtext(Choice,"> Rock Tomb")) SkillChoice=/Skill/Attacks/RockTomb

	if(findtext(Choice,"> Pressure Punch")) SkillChoice=/Skill/Melee/PressurePunch
	if(findtext(Choice,"> Uppercut Combo")) SkillChoice=/Skill/Unarmed/UppercutCombo
	if(findtext(Choice,"> Megaton Throw")) SkillChoice=/Skill/Unarmed/MegatonThrow

	if(findtext(Choice,"> Telekinetic Pull")) SkillChoice=/Skill/Melee/TelekineticPull

	if(findtext(Choice,"> Zanzoken")) SkillChoice=/Skill/Zanzoken

	if(findtext(Choice,"> Heal")) SkillChoice=/Skill/Support/Heal

	if(findtext(Choice,"> Homing Finisher")) SkillChoice=/Skill/Attacks/Homing_Finisher

	if(findtext(Choice,"> MegaBurst")) SkillChoice=/Skill/Attacks/MegaBurst

	if(findtext(Choice,"> Custom Beam")) SkillChoice=/Skill/Attacks/Beams/CustomEnergyWave

	if(findtext(Choice,"> Solar Flare")) SkillChoice=/Skill/Attacks/SolarFlare

	if(findtext(Choice,"> Ray")) SkillChoice=/Skill/Attacks/Beams/Ray

	if(findtext(Choice,"> Explosion")) SkillChoice=/Skill/Attacks/Explosion

	if(findtext(Choice,"> Self Destruct")) SkillChoice=/Skill/Attacks/Self_Destruct

	if(findtext(Choice,"> Guard Break")) SkillChoice=/Skill/Melee/Guard_Break
	if(findtext(Choice,"> Critical Edge")) SkillChoice=/Skill/Melee/CriticalEdge

	if(findtext(Choice,"> Pile Driver")) SkillChoice=/Skill/Unarmed/PileDriver

	if(findtext(Choice,"> Expand")) SkillChoice=/Skill/Buff/Expand

	if(findtext(Choice,"> Earthquake")) SkillChoice=/Skill/Attacks/Earthquake

	if(findtext(Choice,"> Wind Howl")) SkillChoice=/Skill/Weapon/Wind_Howl

	if(findtext(Choice,"> Wing Clip")) SkillChoice=/Skill/Melee/Wing_Clip

	if(findtext(Choice,"> Splitform")) SkillChoice=/Skill/Support/Splitform

	if(findtext(Choice,"> Send Energy")) SkillChoice=/Skill/Support/Send_Energy

	if(findtext(Choice,"> Give Power")) SkillChoice=/Skill/Support/Give_Power

	if(findtext(Choice,"> Blaster Meteor")) SkillChoice=/Skill/Attacks/Blaster_Meteor

	if(findtext(Choice,"> Genocide")) SkillChoice=/Skill/Attacks/Genocide

	if(findtext(Choice,"> Hellzone Grenade")) SkillChoice=/Skill/Attacks/Hellzone_Grenade

	if(findtext(Choice,"> Dragon Nova")) SkillChoice=/Skill/Attacks/Dragon_Nova

	if(findtext(Choice,"> Death Ball")) SkillChoice=/Skill/Attacks/Death_Ball

	if(findtext(Choice,"> Spirit Bomb")) SkillChoice=/Skill/Attacks/SpiritBomb

	if(findtext(Choice,"> Wall Of Flame")) SkillChoice=/Skill/Attacks/WallofFlame

	if(findtext(Choice,"> TriBeam")) SkillChoice=/Skill/Attacks/TriBeam

	if(findtext(Choice,"> Explosive Demon Wave")) SkillChoice=/Skill/Attacks/ExplosiveDemonWave

	if(findtext(Choice,"> Super Explosive Wave")) SkillChoice=/Skill/Attacks/SuperExplosiveWave

	if(findtext(Choice,"> Burning Shot")) SkillChoice=/Skill/Unarmed/BurningShot

	if(findtext(Choice,"> Wolf Fang Fist")) SkillChoice=/Skill/Unarmed/WolfFangFist

	if(findtext(Choice,"> Kill Driver")) SkillChoice=/Skill/Attacks/KillDriver

	if(findtext(Choice,"> March Of Fury")) SkillChoice=/Skill/Melee/MarchOfFury

	if(findtext(Choice,"> Hyper Tornado")) SkillChoice=/Skill/Attacks/HyperTornado

	if(findtext(Choice,"> Super Ghost Kamikaze")) SkillChoice=/Skill/Attacks/SuperGhostKamikazeAttack

	if(findtext(Choice,"> Blue Comet Special")) SkillChoice=/Skill/Attacks/BlueCometSpecial

	if(findtext(Choice,"> Plant Senzu")) SkillChoice=/Skill/Support/PlantSenzu

	if(findtext(Choice,"> Sky Break")) SkillChoice=/Skill/Attacks/SkyBreak

	if(findtext(Choice,"> Dodompa")) SkillChoice=/Skill/Attacks/Beams/Dodompa
	if(findtext(Choice,"> Final Flash")) SkillChoice=/Skill/Attacks/Beams/Final_Flash
	if(findtext(Choice,"> Galic Gun")) SkillChoice=/Skill/Attacks/Beams/Galic_Gun
	if(findtext(Choice,"> Kamehameha")) SkillChoice=/Skill/Attacks/Beams/Kamehameha
	if(findtext(Choice,"> Masenko")) SkillChoice=/Skill/Attacks/Beams/Masenko
	if(findtext(Choice,"> Piercer")) SkillChoice=/Skill/Attacks/Beams/Piercer
	if(findtext(Choice,"> Double Sunday")) SkillChoice=/Skill/Attacks/Beams/Double_Sunday
	if(findtext(Choice,"> Photon Flash")) SkillChoice=/Skill/Attacks/Beams/Photon_Flash
	if(findtext(Choice,"> Tyrant Lancer")) SkillChoice=/Skill/Attacks/Beams/Tyrant_Lancer
	if(findtext(Choice,"> Buster Cannon")) SkillChoice=/Skill/Attacks/Beams/Buster_Cannon


	if(findtext(Choice,"> Pocket Sand")) SkillChoice=/Skill/Unarmed/PocketSand

	if(findtext(Choice,"> Axe Kick")) SkillChoice=/Skill/Melee/AxeKick
	if(findtext(Choice,"> Exploding Heart Strike")) SkillChoice=/Skill/Unarmed/Exploding_Heart_Strike
	if(findtext(Choice,"> Lions Roar")) SkillChoice=/Skill/Unarmed/Lions_Roar

	if(findtext(Choice,"Custom Stance(400)"))
		if(!usr.Confirm("Learn a custom stance for 400 XP?")) return
		if(XP<400)
			usr<<"This requires 400 XP"
			return
		usr.XP-=400
		BuffOut("You spent 400 XP on a Martial Art.")
		saveToLog("| [usr] spent 400 XP on a Martial Art. |")
		alertAdmins("[key_name(usr)] spent 400 XP on a Martial Art!")
		var/Skill/MartialArt/MA=new
		MA.Builder="[usr.ckey] ([usr.real_name])"
		MA.YearDeveloped=round(Year)
		contents+=MA
		MA.desc += "You learned this at year [Year] from using your XP."
		return

/*

exp tiers and it slowly goes lower and lower


*/
	if(XP<Cost)
		usr<<"You need [Cost] for [Choice]."
		return
	if(usr.Confirm("[Choice]?"))
		XP-=Cost
		SpentXP+=Cost
		contents+=new SkillChoice
		BuffOut("You spent [Cost] XP on [Choice].")
		saveToLog("| [usr] spent [Cost] XP on [Choice]. |")
		alertAdmins("[key_name(usr)] spent [Cost] XP on [Choice]!")

mob/proc/UBCheck(showme=0)
	var/list/rrL=list()
	var/list/rL=list()
	for(var/Skill/S in src)
		if(S.Tier==2)
			if(S.UB2) rrL[S.UB2]+=1
			if(S.UB1) rrL[S.UB1]+=2
		if(S.Tier==3)
			if(S.UB2) rrL[S.UB2]+=2
			if(S.UB1) rrL[S.UB1]+=4
		if(S.Tier==4)
			if(S.UB2) rrL[S.UB2]+=4
			if(S.UB1) rrL[S.UB1]+=8
		if(showme) src<<"[S] tier [S.Tier] [S.UB1] is the UB1 and it is at [rrL[S.UB1]] points"
	for(var/Milestone/M in src)
		if(M.PointsCost==1)
			if(M.UB2) rrL[M.UB2]+=0.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=1*M.Ranks
		if(M.PointsCost==2)
			if(M.UB2) rrL[M.UB2]+=1*M.Ranks
			if(M.UB1) rrL[M.UB1]+=2*M.Ranks
		if(M.PointsCost==3)
			if(M.UB2) rrL[M.UB2]+=1.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=3*M.Ranks
		if(M.PointsCost==4)
			if(M.UB2) rrL[M.UB2]+=2*M.Ranks
			if(M.UB1) rrL[M.UB1]+=4*M.Ranks
		if(M.PointsCost==5)
			if(M.UB2) rrL[M.UB2]+=2.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=5*M.Ranks
		if(M.PointsCost==6)
			if(M.UB2) rrL[M.UB2]+=3*M.Ranks
			if(M.UB1) rrL[M.UB1]+=6*M.Ranks
		if(M.PointsCost==7)
			if(M.UB2) rrL[M.UB2]+=3.5*M.Ranks
			if(M.UB1) rrL[M.UB1]+=7*M.Ranks
		if(M.PointsCost==8)
			if(M.UB2) rrL[M.UB2]+=4*M.Ranks
			if(M.UB1) rrL[M.UB1]+=8*M.Ranks
	if(WitnessedDeath)rrL["Death"]+=5
	if(BeenDeathAngry)rrL["Bestial Wrath"]+=15
	if(AteCorpse)rrL["Death"]+=min(10,5*AteCorpse)
	if(AteRottenCorpse)rrL["Fungal Plague"]+=min(10,5*AteCorpse)
	if(ControledCP)rrL["Shadow King"]+=min(10,5*ControledCP)
	if(DeadZoneBeen)rrL["Shadow King"]+=5
	if(UsedDrugs)rrL["Fungal Plague"]+=min(7,1*ShownMercy)
	if(ShownMercy)rrL["Shadow King"]+=min(7,1*ShownMercy)
	if(Humiliated)rrL["War"]+=min(7,1*Humiliated)
	if(CausedInjury)rrL["Fists of Fury"]+=min(7,1*CausedInjury)
	if(HasBurnedForVictory)rrL["Kaioken"]+=7
	if(HasRefusedToDie)rrL["Kaioken"]+=7
	if(HasRobbed)rrL["Fungal Plague"]+=min(10,5*HasRobbed)
	if(MadeAnAndroid)rrL["Machine Force"]+=min(15,MadeAnAndroid*5)
	if(MadeADoll)rrL["Arcane Power"]+=min(15,MadeADoll*5)
	if(HasStruggled)rrL["Bestial Wrath"]+=10
	if(HasStruggled)rrL["High Tension"]+=5
	if(HasStruggled)rrL["Death"]+=10
	if(Total_Stats_Energy>=5)rrL["Arcane Power"]+=5
	if(Total_Stats_Strength>=5)rrL["High Tension"]+=5
	if(Total_Stats_Endurance>=5)rrL["Bestial Wrath"]+=5
	if(Total_Stats_Speed>=5)rrL["Godspeed"]+=5
	if(Total_Stats_Off>=5)rrL["Fists of Fury"]+=5
	if(Total_Stats_Def>=5)rrL["Fungal Plague"]+=5
	if(Kills)rrL["Death"]+=min(15,3*Kills)
	if(Kills)rrL["War"]+=min(5,Kills)
	if(TotalDeaths)rrL["Death"]+=min(10,5*TotalDeaths)
	for(var/obj/Faction/F in src)
		rrL["Shadow King"]+=2
		break
	if(HammerOn||SwordOn) rrL["Armament"]+=5
	if(ArmorOn) rrL["Armament"]+=5
	if(GlovesOn) rrL["Fists of Fury"]+=5
	if(Weight>100)rrL["High Tension"]+=5
	if(HasUsedEmpowerment)rrL["High Tension"]+=5
	if(Cyber_Left_Arm) rrL["Machine Force"]+=1
	if(Cyber_Left_Leg) rrL["Machine Force"]+=1
	if(Cyber_Right_Leg) rrL["Machine Force"]+=1
	if(Cyber_Right_Arm) rrL["Machine Force"]+=1
	if(Cyber_Sight) rrL["Machine Force"]+=1
	if(Cyber_Torso) rrL["Machine Force"]+=1
	if(Z1ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z2ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z3ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z4ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z5ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z6ControllingRuler==name)rrL["Shadow King"]+=7
	if(Z7ControllingRuler==name)rrL["Shadow King"]+=7
	if(MadeBio)rrL["Machine Force"]+=10
	if(MadeMajin)rrL["Arcane Power"]+=10
	if(PowerArmorOn)rrL["Machine Force"]+=5
	if(AndroidLevel)rrL["Machine Force"]+=5
	if(MadeSSj4)rrL["Machine Force"]+=5

//UBs Check now

	for(var/L in rrL) rL+="[L]([5000-(min(40,rrL[L])*100)])"

//	src<<"Checked Unique Buff eligibility."


	UBList= rL/*
mob/verb/ForceUBCheck()
	UBCheck()*/

/*
Armament
Godspeed
Machine Force
Shadow King
Arcane Power
Bestial Wrath
Kaioken
Death
War
Pestilence
Channel
High Tension
Fists of Fury
*/
mob/var/list/UBList=list()

mob/verb/Spend_XP()
	set category=null//"Other"
	if(usr)
		var/list/L = list("Unlock A Skill","Unlock A Milestone","Faction Charter(100) (Faction Leader Commands)","Master a Skill","Increase Passive Skill","Profession Experience (Up to Cap)")
//,"Purchase Resources/Mana" removed to prevent muling and abuse. Extremely unlikely that players would choose this over Skills or MP
//,"Energy (Up to Cap)","Magic/Int/Profession Experience (Up to Cap)"
		for(var/Skill/MartialArt/MA in usr) if(MA.MasteryLevel=="Novice")
			L+="Train Martial Art(100)"
			break

		for(var/Skill/Buff/Bound_Weapon/MA in usr) if(MA.PointsCan<8)
			L+="Deepen Weapon Bond(100)"
			break
//Added back Revive someone too
		if(usr.Int_Mod>=4) L+="Revive Someone(750)"
		else if(usr.Magic_Potential>=4) L+="Revive Someone(750)"

		if(usr.Int_Mod>=4&&WipeDay>=35) L+="Create an SSJ4(1000)"
		else if(usr.Magic_Potential>=4&&WipeDay>=35) L+="Create an SSJ4(1000)"

		if(usr.Int_Mod>=4&&WipeDay>=19) L+="Story Alteration(???) (Send Ahelp)"
		else if(usr.Magic_Potential>=4&&WipeDay>=19) L+="Story Alteration(???) (Send Ahelp)"

		if(locate(/obj/Faction) in usr&&(!locate(/Skill/Misc/FactionLeaderCommands) in usr))
			L+="Faction Charter(100) (Faction Leader Commands)"


	//	if(!(locate(/Skill/Buff/Limit_Breaker) in usr)) L+="Limit Breaker(2200)"

	//	if(usr.Int_Mod>=4&&WipeDay>=20) L+="Create a Bio-Android(1000)"
//		if(usr.Magic_Potential>=4&&WipeDay>=30) L+="Create a Majin(1000)"

		if(!(locate(/Skill/Buff/Ascend) in usr)&&FBMAchieved)
			L+="Ascend(1200)"
		if(!(locate(/Skill/FusionDance) in usr)) L+="Fusion Dance(2000)"

		L+="Cancel"
		var/C=input("Spend your XP on what? [CustomXPOptions]") in L
		if(C=="Cancel") return

		switch(C)
			if("Fusion Dance(2000)")
				if(XP<2000)
					usr<<"This requires 2000 XP"
					return
				usr.XP-=2000
				usr.BuffOut("You spent 2000 XP on Fusion Dance.")
				usr.saveToLog("| [usr] spent 2000 XP on Fusion Dance. |")
				alertAdmins("[key_name(usr)] spent 2000 XP on Fusion Dance!")
				usr.contents+= new/Skill/FusionDance


			if("Revive Someone(750)")
				var/list/deadfolk=list()
				for(var/mob/player/MM in Players) if(MM.Dead&&MM!=usr&&Year>MM.Died+Dead_Time) deadfolk+=MM
				deadfolk+="Cancel"
				var/mob/M=input("Revive who for 750 XP?") in deadfolk
				if(M=="Cancel") return
				else if(M.Dead)
					if(XP<750)
						usr<<"This requires 750 XP"
						return
					usr.XP-=750
					M.Revive()
					if(M.KOd) M.Un_KO()
					M.Health = M.MaxHealth
					M.Calm()
					M.loc=usr.loc
					M.Ki = M.MaxKi
					alertAdmins("[key_name(usr)] has revived [M] for 750 XP!")


			if("Purchase Resources/Mana")
				var/CC = input("Resources or Mana?") in list("Resources","Mana","Cancel")
				if(CC=="Cancel") return
				if(CC=="Resources")
					var/Amount = input(src,"How much XP would you like to spend on Resources?") as num
					if(Amount<=0 || Amount>XP) return
					var/gain = Amount*10000
					switch(input("Are you sure you want to spend [Amount] XP on [gain] Resources?") in list ("Yes","No"))
						if("Yes")
							src.XP-=Amount
							for(var/obj/Resources/R in src) R.Value+=gain
							alertAdmins("[key_name(usr)] has spent [Amount] XP on [gain] Resources!")
							return
						if("No")
							return
				else if(CC=="Mana")
					var/Amount = input(src,"How much XP would you like to spend on Mana?") as num
					if(Amount<=0 || Amount>XP) return
					var/gain = Amount*10000
					switch(input("Are you sure you want to spend [Amount] XP on [gain] Mana?") in list ("Yes","No"))
						if("Yes")
							src.XP-=Amount
							for(var/obj/Mana/M in src) M.Value+=gain
							alertAdmins("[key_name(usr)] has spent [Amount] XP on [gain] Mana!")
							return
						if("No")
							return

			if("Unlock A Skill")
				usr.SkillPurchase()
			if("Unlock A Milestone")
				usr.Buy_Milestones()


			if("Create a Majin(1000)")
				if(usr.Confirm("Create a Majin for 1000 XP?"))
					if(XP<1000)
						usr<<"This requires 1000 XP"
						return
					usr.XP-=1000
					view(src)<<"[usr] begins to create a majin!"
					var/obj/Baby/A=new
					A.Race="Majin"
					A.loc=usr.loc
					A.icon='fx.dmi'
					A.icon_state="chaos gate"
					A.name="Majin ([usr])"
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Majin",null) as text
					alertAdmins("[key_name(usr)] has made a Majin for 1000 XP!")

			if("Revive Someone(750)")
				var/list/DeadP=list()
				for(var/mob/player/P in Players) if(P.Dead) DeadP+=P
				DeadP+="Cancel"
				var/mob/CC=input("Revive someone for 750 XP") in DeadP
				if(CC=="Cancel") return
				if(XP<750)
					usr<<"This requires 750 XP"
					return
				usr.XP-=750
				if(Year<CC.Died+Dead_Time)
					usr<<"This can't be used on someone not attuned to the realm of the dead, their incorporeal form hasn't been deceased long enough. This process usually takes [Dead_Time] years."
					return
				CC.Revive()
				if(CC.KOd) CC.Un_KO()
				CC.Health = CC.MaxHealth
				CC.Calm()
				CC.Ki = CC.MaxKi
				CC.loc=usr.loc



			if("Create a Bio-Android(1000)")
				if(usr.Confirm("Create a Bio-Android for 1000 XP?"))
					if(XP<1000)
						usr<<"This requires 1000 XP"
						return
					usr.XP-=1000
					view(src)<<"[usr] begins to create an biological android!"
					var/obj/Baby/A=new
					A.Race="Bio-Android"
					A.loc=usr.loc
					A.icon='Lab.dmi'
					A.icon_state="Cell"
					A.name="Bio-Android ([usr])"
					if(usr.Confirm("Add a password?")) A.Password=input(usr,"[A] Password","Bio-Android",null) as text
					alertAdmins("[key_name(usr)] has made a Bio Android for 1000 XP!")


//HasCustomStance

			if("Faction Charter(100) (Faction Leader Commands)")
				var/Choice = input("Are you Sure?") in list("Yes","Cancel")
				if(Choice=="Cancel") return
				if(Choice=="Yes")
					if(XP<100)
						usr<<"This requires 100 XP"
						return
					if(!locate(/obj/Faction) in usr)
						usr<<" Need a Faction!"
						return
					for(var/obj/Faction/A in usr) if(A.leader != 1)
						usr<<"You need to own a faction."
						return
					if(locate(/Skill/Misc/FactionLeaderCommands) in usr)
						usr<<"You already have one!"
						return
					usr.XP-=100
					usr.BuffOut("You spent 100 XP on a Faction Charter.")
					usr.saveToLog("| [usr] spent 100 XP on a Faction Charter. |")
					usr.contents+= new/Skill/Misc/FactionLeaderCommands
					alertAdmins("[key_name(usr)] has purchased Faction Charter for 100 XP!")

			if("Ascend(1200)")
				if(XP<1200)
					usr<<"This requires 1200 XP"
					return
				usr.XP-=1200
				usr.BuffOut("You spent 1200 XP on Ascend.")
				usr.saveToLog("| [usr] spent 1200 XP on Ascend. |")
				alertAdmins("[key_name(usr)] spent 1200 XP on Ascend!")
				usr.contents+= new/Skill/Buff/Ascend


			if("Create an SSJ4(1000)")
				if(usr.MadeSSj4)
					usr<<"You've already created an SSJ4."
					return
				if(XP<1000)
					usr<<"This requires 1000 XP"
					return
				var/list/Saiyans=list()
				for(var/mob/player/P in view(usr)) if(P.Race=="Saiyan"&&P.HasSSj>=2&&P.HasSSj4==0) Saiyans+=P
				Saiyans+="Cancel"
				var/mob/player/SS = input("Who do you want to make an SSJ4?") in Saiyans
				if(SS=="Cancel") return
				else SS.HasSSj4=1
				usr.MadeSSj4++
				usr.XP-=1000
				usr.BuffOut("You spent 1000 XP on making [SS] an SSJ4.")
				usr.saveToLog("| [usr] spent 1000 XP on making [SS] an SSJ4. |")
				SS<<"[usr] has made you an SSJ4!"
				alertAdmins("[key_name(usr)] has made [SS] an SSj4 using 1000 XP!")




			if("Master a Skill")
				if(XP<250)
					usr<<"This requires 250 XP"
					return
				var/list/PC=list()
				for(var/Skill/S in usr) if(S.Experience<100) PC+=S
				PC+="Cancel"
				var/Skill/Align=input("Which skill would you like to master? (This will master a skill at the cost of 250 XP)") in PC
				if(Align=="Cancel")return
				Align.Experience=100
				usr.XP-=250
				usr.BuffOut("You spent 250 experience on [Align]. (Mastered [Align])")
				usr.saveToLog("| [usr] spent 250 experience on [Align]. (Mastered [Align]) |")

			if("Increase Passive Skill")
				var/Align=input("Which passive? (XP Invested x max(1,Year/30) = Passive Bonus)") in list("Weapon Skill","Ki Manipulation","Unarmed Skill","Evasion","Cancel")
				if(Align=="Cancel")return
				var/Incr=input("Invest how much XP into [Align]? (0-[XP]) (XP Invested x max(1,Year/40) = Passive Bonus)") as num
				if(Incr>XP) Incr=XP
				if(Incr<0) Incr=0
				Incr=round(Incr)
				if(Incr)
					switch(Align)
						if("Weapon Skill") usr.SwordSkillAdd+=(Incr)
						if("Ki Manipulation") usr.KiManipulationAdd+=(Incr)
						if("Unarmed Skill") usr.UnarmedSkillAdd+=(Incr)
						if("Evasion") usr.AthleticismAdd+=(Incr)
					usr.XP-=Incr
					usr.BuffOut("You spent [Incr] XP on [Align]. (+ [Incr*max(0.025,Year/30)] [Align])")
					usr.saveToLog("| [usr] spent [Incr] XP on [Align]. (+ [Incr*max(0.025,Year/30)] [Align]) |")
			if("Profession Experience (Up to Cap)")
				var/Align=input("Increase which?") in list("Mining","Smithing","Fishing","Cooking","Cancel")
				if(Align=="Cancel")return
				if(Align=="Magic") if(usr.Magic_Level>TechCap)
					usr<<"Your Magic is already at the cap."
					return
				if(Align=="Intelligence") if(usr.Int_Level>TechCap)
					usr<<"Your Intelligence is already at the cap."
					return
				var/Incr=input("Buy how many levels of [Align]? (0-[round(XP/100)] 100 XP : 1 level) Only do Mining/Smithing/Fishing/Cooking 1 level at a time or you will miss out on XP.") as num
				if(Incr>XP/100) Incr=XP/100
				if(Incr<0) Incr=0
				Incr=round(Incr)
				if(Incr)
					switch(Align)
					/*	if("Magic")
							var/diff=TechCap - Magic_Level
							if(Incr>diff) Incr=round(diff)
							usr.medrewardmagic+=Incr
						if("Intelligence")
							var/diff=TechCap - Int_Level
							if(Incr>diff) Incr=round(diff)
							usr.medreward+=Incr*/
						if("Mining")
							usr.Mining_XP+=Mining_Next*Incr
							MiningLevelCheck()
						if("Smithing")
							usr.Smithing_XP+=Smithing_Next*Incr
							SmithingLevelCheck()
						if("Fishing")
							usr.Fishing_XP+=Fishing_Next*Incr
							FishingLevelCheck()
						if("Cooking")
							usr.Cooking_XP+=Cooking_Next*Incr
							CookingLevelCheck()
					usr.XP-=Incr*100
					usr.BuffOut("You spent [Incr*100] XP on [Align]. (+ [Incr] levels)")
					usr.saveToLog("| [usr] spent [Incr*100] XP on [Align]. (+ [Incr] levels) |")
			if("Energy (Up to Cap)")
				if(BaseMaxKi/KiMod>=SoftStatCap)
					usr<<"You have already hit the energy cap."
					return
				var/diff=SoftStatCap - BaseMaxKi/KiMod
				var/Incr=input("Invest how much experience into Energy? (0-[diff])") as num
				Incr=round(Incr)
				if(Incr>diff) Incr=round(diff)
				if(Incr>XP) Incr=XP
				if(Incr<0) Incr=0
				if(Incr)
					usr.BaseMaxKi+=Incr
					usr.XP-=Incr
					usr.BuffOut("You spent [Incr] experience on Energy. (+ [Incr] Max Energy)")
					usr.saveToLog("| [usr] spent [Incr] experience on Energy. (+ [Incr] Max Energy) |")

			if("Train Martial Art(100)") if(usr.Confirm("Train Martial Art for 100 XP?"))
				if(usr.XP >= 100)
					var/list/Clist=list()
					usr.XP -= 100
					for(var/Skill/MartialArt/MA in usr) if(MA.MasteryLevel=="Novice") Clist+=MA
					Clist+="Cancel"
					var/Skill/MartialArt/MAC=input("Train in which martial art?") in Clist
					if(MAC=="Cancel")
						usr.XP += 100
						return
					else
						if(MAC.MasteryLevel=="Novice")
							//MAC.PointsCan=4
							MAC.MasteryLevel="Intermediate"
						/*else if(MAC.MasteryLevel=="Intermediate")
							MAC.PointsCan=5
							MAC.MasteryLevel="Master"*/
					usr << "<font color = teal>You have been rewarded mastery in the [MAC] martial art for 100 XP, congratulations!"
				else usr<<"You need 100 XP to train a stance."

			if("Deepen Weapon Bond(100)") if(usr.Confirm("Deepen Weapon Bond for 100 XP?"))
				if(usr.XP >= 100)
					usr.XP -= 100
					for(var/Skill/Buff/Bound_Weapon/MA in usr)
						if(MA.PointsCan<8)
							MA.PointsCan++
							MA.PointsHas++
							usr << "<font color = teal>You have been rewarded mastery in [MA] 100 XP, congratulations!"
				else usr<<"You need 100 XP to bond with a weapon."


	else usr<<"You have no rewarded XP to spend. You can earn this by interacting with ranks and RPing or completing quests, participating in events and defeating event villains and by participating in the Roleplay Rewards quota."


mob
	var/EvasionTeaches=0
	var/WeaponTeaches=0
	var/UnarmedTeaches=0
	var/KiManipTeaches=0

mob/verb/Teach_Passive()
	set category ="Other"
	var/Align=input("Allow others to train which passive with you? (Allows people sparring with you to leech up to 80% of your skill but only allows you to train them in one at a time.)") in list("Weapon","Unarmed","Ki Manipulation","Evasion","Cancel")
	if(Align=="Cancel")return
	EvasionTeaches=0
	WeaponTeaches=0
	UnarmedTeaches=0
	KiManipTeaches=0
	switch(Align)
		if("Weapon")
			if(WeaponTeaches)
				usr<<"You are no longer training people in passives."
				WeaponTeaches=0
				return
			else WeaponTeaches=1
		if("Unarmed")
			if(UnarmedTeaches)
				usr<<"You are no longer training people in passives."
				UnarmedTeaches=0
				return
			else UnarmedTeaches=1
		if("Ki Manipulation")
			if(KiManipTeaches)
				usr<<"You are no longer training people in passives."
				KiManipTeaches=0
				return
			else KiManipTeaches=1
		if("Evasion")
			if(EvasionTeaches)
				usr<<"You are no longer training people in passives."
				EvasionTeaches=0
				return
			else EvasionTeaches=1
	usr<<"You are now training people in [Align] skill and no longer training them in any other."


var/list/HumanLearnList=list("Humanism","Focus","Sense Energy")
var/list/SaiyanLearnList=list("Muscle Force","Expand")
var/list/NamekianLearnList=list("Counterpart","Super Namekian","Namekian Fusion","Ki Force","Power Control","Sense Energy")
var/list/AncientNamekianLearnList=list("Super Namekian","Muscle Force","Expand")
var/list/AndroidLearnList=list("Shield","Grand Explosion","Focus","Power Control","Ki Fists")
var/list/AlienLearnList=list("Heal","Ki Force","Muscle Force","Power Control")
var/list/DemonLearnList=list("Imitate","Invisibility","Muscle Force","Expand")
var/list/HeranLearnList=list("Shield","Muscle Force","Expand")
var/list/ShinjinLearnList=list("Heal","Ki Force","Power Control","Focus","Sense Energy")
var/list/MakyoLearnList=list("Makyo Transform","Muscle Force","Expand")
var/list/OniLearnList=list("Giant Mode","Muscle Force","Expand")
var/list/TuffleLearnList=list("Physics Simulation","Focus","Power Control")
var/list/YardratLearnList=list("Super Maximum Light Speed Mode","Zanzoken","Focus")
var/list/DollLearnList=list("Heal","Self Destruct","Ki Force","Power Control","Telekinesis")
var/list/ChangelingLearnList=list("Shield","Ki Force","Muscle Force","Power Control","Telekinesis","Expand")
var/list/DemiLearnList=list("Pantheon","Muscle Force","Expand")
var/list/PuarLearnList=list("Heal","Send Energy","Spell Force","Ki Force","Power Control")
var/list/SaibaLearnList=list("Self Destruct","Grand Explosion","Focus","Expand")
var/list/KanassanLearnList=list("Foresight","Heal","Power Control","Telekinesis","Ki Force")
var/list/KonatLearnList=list("Weapon Force","Zanzoken","Muscle Force")
var/list/CerealianLearnList=list("Shield","Muscle Force","Expand")
var/list/HeeterLearnList=list("Shield","Muscle Force","Expand")
var/list/Roswell_GreyLearnList=list("Shield","Muscle Force","Expand","Sense Energy")
var/list/DragonLearnList=list("Shield","Muscle Force","Expand")
var/list/PrimalApeLearnList=list("Shield","Muscle Force","Expand")
var/list/MasterLearnList=list("Jump","Block","Slash","Bash","Fly","Blast","Charge","Beam","Rock Throw","Roundhouse Kick","Warp Attack","Dash Attack","Kiai")

mob/proc/FixLearnList()
	LearnList=MasterLearnList+GeneticLearnList
	switch(Race)
		if("Human") LearnList=MasterLearnList+HumanLearnList
		if("Saiyan") LearnList=MasterLearnList+SaiyanLearnList
		if("Namekian")LearnList=MasterLearnList+NamekianLearnList
		if("Android")LearnList=MasterLearnList+AndroidLearnList
		if("Alien")LearnList=MasterLearnList+AlienLearnList
		if("Demon")LearnList=MasterLearnList+DemonLearnList
		if("Heran")LearnList=MasterLearnList+HeranLearnList
		if("Shinjin")LearnList=MasterLearnList+ShinjinLearnList
		if("Makyojin")LearnList=MasterLearnList+MakyoLearnList
		if("Kanassan")LearnList=MasterLearnList+KanassanLearnList
		if("Oni")LearnList=MasterLearnList+OniLearnList
		if("Tuffle")LearnList=MasterLearnList+TuffleLearnList
		if("Yardrat")LearnList=MasterLearnList+YardratLearnList
		if("Spirit Doll")LearnList=MasterLearnList+DollLearnList
		if("Changeling") LearnList=MasterLearnList+ChangelingLearnList
		if("Demigod")LearnList=MasterLearnList+DemiLearnList
		if("Puar")LearnList=MasterLearnList+PuarLearnList
		if("Saibaman")LearnList=MasterLearnList+SaibaLearnList
		if("Konatsian")LearnList=MasterLearnList+KonatLearnList
		if("Cerealian")LearnList=MasterLearnList+CerealianLearnList
		if("Heeter")LearnList=MasterLearnList+HeeterLearnList
		if("Greys")LearnList=MasterLearnList+Roswell_GreyLearnList
		if("Dragon")LearnList=MasterLearnList+DragonLearnList
		//if("Primal")LearnList=MasterLearnList+PrimalApeLearnList
	if(Class=="Triclop")
		LearnList += "Third Eye"
		ThirdEyeAt=ThirdEyeReq*(rand(50,150)/100)
	if("Super Namekian" in LearnList) SNjAt=SNjReq*(rand(75,125)/100)
	if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan"||Race=="Heran"||Race=="Half-Heran") SSjAt=SSjReq*(rand(80,120)/100)
	if(Class=="Ancient"||Class=="Legendary" || Class=="Primal")LearnList+="Shield"
	if(Class=="Low") if(prob(10)) LearnList += "False Moon"
//	src<<"Learn List: [LearnList.Join(", ")]"


mob/verb/LearnListCheck()
	set hidden=1
	src<<"[LearnList.Join(", ")]"

mob/proc/Learn() if(world.maxz!=1) while(src)
	set background=1
	set waitfor=0
	sleep(200)
	FBMCheck()
	var/Lrned=0

	if(LastLearn!=null && LastLearn<WipeDay && LearnSlots<2 && LastLearnSlotRefresh!=WipeDay)
		LearnSlots=min(2,LearnSlots+1)
		if(LearnSlots == 2)
			LastLearn = null
		LastLearnSlotRefresh=WipeDay
		src<<"You feel ready to tackle learning another technique."

//Racial Specific Skills
	if(Race=="Demon"&&!(locate(/Skill/Misc/Absorb)in src)) contents+=new/Skill/Misc/Absorb
	if("Invisibility" in LearnList)
		if(MaxKi>1500&&!(locate(/Skill/Support/Invisibility) in src))
			src<<"You acquired the invisibility skill"
			contents+=new/Skill/Support/Invisibility
			Lrned++
	if("Imitate" in LearnList)
		if(MaxKi>=1500&&!(locate(/Skill/Support/Imitation)in src))
			contents+=new/Skill/Support/Imitation
			Lrned++
			src<<"<span class=announce>You have learned how to imitate another person's physical features through the usage of your ki and dark magic!"
	if("False Moon" in LearnList)
		if(MaxKi>1500&&SaveAge>1&&!(locate(/Skill/Buff/False_Moon) in src))
			src<<"You acquired the False Moon skill"
			contents+=new/Skill/Buff/False_Moon
			Lrned++
	if("Heal" in LearnList)
		if(MaxKi>=1500&&!(locate(/Skill/Support/Heal)in src))
			contents+=new/Skill/Support/Heal
			Lrned++
			src<<"<span class=announce>Through intensive ki training you have learned to Heal others!"


	if("Send Energy" in LearnList)
		if(MaxKi>=2000&&SaveAge>1&&!(locate(/Skill/Support/Send_Energy) in src))
			contents+=new/Skill/Support/Send_Energy
			Lrned++
			src<<"<span class=announce>You have learned to share your energy with others."
	if("Counterpart" in LearnList)
		if(MaxKi>=2000&&SaveAge>1&&!(locate(/Skill/Support/Counterpart) in src))
			contents+=new/Skill/Support/Counterpart
			Lrned++
			src<<"<span class=announce>You automatically learned how to designate another of your race as your counterpart."
	if("Grand Explosion" in LearnList)
		if(MaxKi>=2000&&SaveAge>1&&!(locate(/Skill/Attacks/Grand_Explosion) in src))
			contents+=new/Skill/Attacks/Grand_Explosion
			Lrned++
			src<<"<span class=announce>You have learned to harness your power and unleash a massive explosion!"
	if("Self Destruct" in LearnList)
		if(MaxKi>=2000&&SaveAge>1&&!(locate(/Skill/Attacks/Self_Destruct) in src))
			contents+=new/Skill/Attacks/Self_Destruct
			Lrned++
			src<<"<span class=announce>You have learned to harness your power and explode!"
	if("Telekinesis" in LearnList)
		if(MaxKi>=2000&&!(locate(/Skill/Support/Telekinesis) in src))
			src << "Through dedicated study of the arcane, you have unlocked the ability to move objects via your energy. Click and drag items and people to move them."
			contents+=new/Skill/Support/Telekinesis
			Lrned++
	if("Zanzoken" in LearnList) if(!(locate(/Skill/Zanzoken) in src))
		if(MaxKi>2000&&Zanzoken>=250)
			contents+=new/Skill/Zanzoken
			Lrned++
			src<<"<span class=announce>Your speed rivals that of sound! You can now zanzoken to another tile!</span>"
	if("Shield" in LearnList)
		if(MaxKi>=2000&&!(locate(/Skill/Buff/Shield) in src))
			contents+=new/Skill/Buff/Shield
			Lrned++
			src<<"<span class=announce>You automatically learned Shield on your own because of your immense energy"


//Generic Learns
	if("Focus" in LearnList)
		if(Base/BPMod>=GenericReq&&!(locate(/Skill/Buff/Focus)in src))
			contents+=new/Skill/Buff/Focus
			Lrned++
			src<<"<span class=announce>Through intensive ki training, force training, and luck, you have learned to use Focus.  By doing so, you take your senses to a super-human level!"
	if("Ki Force" in LearnList)
		if(Base/BPMod>=GenericReq&&!(locate(/Skill/Buff/Ki_Force) in src))
			contents+=new/Skill/Buff/Ki_Force
			Lrned++
			src<<"<span class=announce>Your utter to Ki manipulation has awakened a newfound power within you!</span>"
	if("Muscle Force" in LearnList)
		if(Base/BPMod>=GenericReq&&!(locate(/Skill/Buff/Muscle_Force)in src))
			contents+=new/Skill/Buff/Muscle_Force
			Lrned++
			src<<"<span class=announce>Through intensive endurance training, strength training, and luck, you have learned to use Muscle Force.  By doing so, you take your strength to a super-human level!"
/*	if("Limit Breaker" in LearnList)
		if(Base/BPMod>=ThirdEyeReq&&!(locate(/Skill/Buff/Limit_Breaker)in src))
			contents+=new/Skill/Buff/Limit_Breaker
			Lrned++
			src<<"<span class=announce>My skill with other powerful skills have allowed me to break past my bodies limits to even higher levels!"
*/
	if("Expand" in LearnList)
		if(Base/BPMod>GenericReq2&&!(locate(/Skill/Buff/Expand)in src))
			contents+=new/Skill/Buff/Expand
			Lrned++
			src<<"<span class=announce>Through strength and ki training, you have learned how to expand your body to a gargantuan size!"
	if("Namekian Fusion" in LearnList||Race=="Namekian")
		if(Base/BPMod>GenericReq2&&!(locate(/Skill/Support/NamekianFusion) in src)&&SaveAge>=3)
			src<<"You have awakened your race's hidden technique... Use it wisely."
			Lrned++
			contents+=new/Skill/Support/NamekianFusion

//Unarmed
	if("Block" in LearnList)
		if(MaxKi>=500&&UnarmedSkill>75&&!locate(/Skill/Misc/Block) in src)
			contents+=new/Skill/Misc/Block
			src<<"<span class=announce>You feel as though you can reliably block an attack with your hands!</span>"
	if("Roundhouse Kick" in LearnList)
		if(MaxKi>=750&&UnarmedSkill>75&&!locate(/Skill/Melee/RoundhouseKick) in src)
			contents+=new/Skill/Melee/RoundhouseKick
			Lrned++
			src<<"<span class=announce>Your training and dedication have paid off.  You have mastered the ability to use a round house kick in combat and knock away anyone that surrounds you!</span>"
	if("Dash Attack" in LearnList)
		if(MaxKi>=1500&&UnarmedSkill>150&&!locate(/Skill/Melee/DashAttack) in src)
			contents+=new/Skill/Melee/DashAttack
			Lrned++
			src<<"<span class=announce>You have learned to use your incredible speed in combat. As such, you can now dash at your opponent and strike several times!</span>"
	if("Warp Attack" in LearnList)
		if(MaxKi>=2000&&UnarmedSkill>300&&!locate(/Skill/Melee/WarpAttack) in src)
			contents+=new/Skill/Melee/WarpAttack
			Lrned++
			src<<"<span class=announce>Your impressive speed has lead to the ability to perform high-paced follow up attacks!</span>"

//Ki Manip
	if("Blast" in LearnList)
		if(MaxKi>=750&&KiManipulation>75&&!(locate(/Skill/Attacks/Blast) in src))
			contents+=new/Skill/Attacks/Blast
			Lrned++
			src<<"<span class=announce>You automatically learned Blast on your own because of your immense energy"
	if("Charge" in LearnList)
		if(MaxKi>=1500&&KiManipulation>150&&!(locate(/Skill/Attacks/Charge) in src))
			contents+=new/Skill/Attacks/Charge
			Lrned++
			src<<"<span class=announce>You automatically learned Charge on your own because of your immense energy"
	if("Ki Fists" in LearnList)
		if(MaxKi>=2000&&UnarmedSkill>225&&KiManipulation>225&&!(locate(/Skill/Misc/KiFists) in src))
			contents+=new/Skill/Misc/KiFists
			Lrned++
			src<<"<span class=announce>You automatically learned Ki Fists on your own because of your immense energy"
	if("Beam" in LearnList)
		if(MaxKi>=2500&&KiManipulation>300&&!(locate(/Skill/Attacks/Beams/Beam) in src))
			contents+=new/Skill/Attacks/Beams/Beam
			Lrned++
			src<<"<span class=announce>You automatically learned Beam on your own because of your immense energy"
	if("Power Control" in LearnList)
		if(MaxKi>=2000&&!(locate(/Skill/Buff/Power_Control) in src)&&KiManipulation>=250&&SaveAge>=2)
			contents+=new/Skill/Buff/Power_Control
			Lrned++
			src<<"<span class=announce>You automatically learned Power Control on your own because of your immense energy and ki manipulation."
	if("Sense Energy" in LearnList)
		if(MaxKi>=1500&&KiManipulation>=150&&!(locate(/Skill/Support/Sense_Energy) in src))
			contents+=new/Skill/Support/Sense_Energy
			Lrned++
			src<<"<span class=announce>You automatically learned to sense energy on your own because of your immense energy"


//Weapon
	if("Block" in LearnList)
		if(MaxKi>=500&&SwordSkill>75&&!locate(/Skill/Misc/Block) in src)
			contents+=new/Skill/Misc/Block
			src<<"<span class=announce>You feel as though you can reliably block an attack with your weapon!</span>"
	if("Slash" in LearnList)
		if(MaxKi>=1000&&SwordSkill>150&&!locate(/Skill/Weapon/Slice) in src)
			contents+=new/Skill/Weapon/Slice
			src<<"<span class=announce>Your use of a weapon in combat has helped you to learn to launch a fast attack!</span>"
	if("Bash" in LearnList)
		if(MaxKi>=1500&&SwordSkill>300&&!locate(/Skill/Weapon/Bash) in src)
			contents+=new/Skill/Weapon/Bash
			src<<"<span class=announce>Your use of a weapon in combat has helped you to learn to launch an attack that will stun your opponent!</span>"


//No Passive
	if("Rock Throw" in LearnList)
		if(MaxKi>=500&&!(locate(/Skill/Attacks/RockThrow) in src))
			contents+=new/Skill/Attacks/RockThrow
			Lrned++
			src<<"<span class=announce>You automatically learned Rock Throw because you can lift rocks and throw them."
	if("Kiai" in LearnList)
		if(MaxKi>=1500&&!(locate(/Skill/Attacks/Shockwave) in src))
			contents+=new/Skill/Attacks/Shockwave
			Lrned++
			src<<"<span class=announce>You automatically learned Shockwave on your own because of your immense energy"
	if("Fly" in LearnList)
		if(MaxKi>=2000&&!(locate(/Skill/Misc/Fly) in src)&&WipeDay>=3)
			contents+=new/Skill/Misc/Fly
			Lrned++
			src<<"<span class=announce>You automatically learned Fly on your own because of your immense energy"
	if("Jump" in LearnList)
		if(MaxKi>=250&&!(locate(/Skill/Misc/Jump_Backwards) in src))
			contents+=new/Skill/Misc/Jump_Backwards
			Lrned++
			src<<"<span class=announce>You automatically learned to Jump Backwards in combat to evade an attack."
	if(MaxKi>=5000&&!(locate(/Skill/Misc/Resist) in src))
		contents+=new/Skill/Misc/Resist
		Lrned++
		src<<"<span class=announce>You automatically learned to resist control effects on your own because of your immense energy"
	if(Race=="Saiyan"&&Class=="Legendary"&&MaxGodKi&&SparGodKi&&!(locate(/Skill/Buff/BestialWrath) in src))
		contents+=new/Skill/Buff/BestialWrath
		Lrned++
		src<<"<span class=announce>Your muscles bulge with an untamed energy, and a feral roar escapes your lips as you unleash the primal force within... (Bestial Wrath Unlocked)"



//Magic
	if(Magic_Level>=12&&!(locate(/Skill/Spell/Rejuvenate) in src))
		src << "You have learned Rejuvenate due to your magical skill."
		contents+=new/Skill/Spell/Rejuvenate
		Lrned++
	if(Magic_Level>=25&&!(locate(/Skill/Spell/Lightning_Bolt) in src))
		src << "You have learned Lightning Bolt due to your magical skill."
		contents+=new/Skill/Spell/Lightning_Bolt
		Lrned++
	if(Magic_Level>=35&&Magic_Potential>=2&&!(locate(/Skill/Support/Materialization) in src))
		src << "Through hard work and practice you have managed to learn to materialize weighted clothing before you!"
		contents+=new/Skill/Support/Materialization
		Lrned++
	if(Magic_Level>=38&&Magic_Potential>=2&&!(locate(/Skill/Buff/Adaptive) in src))
		src<<"You have learned to use your magic to help you improve your defensiveness. (Adaptive)"
		contents+=new/Skill/Buff/Adaptive
		Lrned++
	if(Magic_Level>=43&&Magic_Potential>=3&&!(locate(/Skill/Spell/Frost_Bolt) in src))
		src << "You have learned Frost Bolt due to your magical skill."
		contents+=new/Skill/Spell/Frost_Bolt
		Lrned++
	if(Magic_Level>=45&&Magic_Potential>=2&&!(locate(/Skill/Support/Telepathy) in src))
		src << "You have learned telepathy due to your magical skill."
		contents+=new/Skill/Support/Telepathy
		Lrned++
	if(Magic_Level>=50&&!(locate(/Skill/Spell/Telekinesis_Magic) in src))
		src << "Through dedicated study of the arcane, you have unlocked the ability to move objects via magic. Click and drag items and people to move them. Each movement will cost mana."
		contents+=new/Skill/Spell/Telekinesis_Magic
		Lrned++
	if(Magic_Level>=53&&!(locate(/Skill/Spell/Enchant) in src)&&Magic_Potential>2)
		src << "You have learned how to enchant equipment due to your magical skill."
		contents+=new/Skill/Spell/Enchant
		Lrned++
	if(Magic_Level>=53&&!(locate(/Skill/Spell/Enchant) in src)&&Magic_Potential>3.5)
		src << "You have learned how to cast Fireball due to your magical skill."
		contents+=new/Skill/Spell/Fireball
		Lrned++

	if(Magic_Level>=55&&!(locate(/Skill/Spell/Construct_Doll) in src)&&Magic_Potential>2)
		src << "You have learned how to create Dolls you can control remotely with your magic."
		contents+=new/Skill/Spell/Construct_Doll
		Lrned++
	if(Magic_Level>=58&&!(locate(/Skill/Spell/Empowered_Defenses) in src)&&Magic_Potential>2)
		src << "You have learned how to empower your allies defenses due to your magical skill."
		contents+=new/Skill/Spell/Empowered_Defenses
		Lrned++
	if(Magic_Level>=58&&!(locate(/Skill/Technology/MakeStatue) in src)&&Magic_Potential>2)
		src << "You have learned how to make statues of people."
		contents+=new/Skill/Technology/MakeStatue
		Lrned++
	if(Magic_Level>=59&&!(locate(/Skill/Spell/DeadZone) in src)&&Magic_Potential>2)
		src << "You have learned how to open a portal to the Dead Zone."
		contents+=new/Skill/Spell/DeadZone
		Lrned++
	if(Magic_Level>=60&&!(locate(/Skill/Spell/Gravity_Well) in src)&&Magic_Potential>2.5)
		src << "You have learned how to make wells of gravity using magic."
		contents+=new/Skill/Spell/Gravity_Well
		Lrned++
	if(Magic_Level>=60&&Magic_Potential>2&&!(locate(/Skill/Spell/Seance) in src))
		src << "You have learned Seance due to your magical skill."
		contents+=new/Skill/Spell/Seance
		Lrned++
	if(Magic_Level>=62&&!(locate(/Skill/Spell/Empowered_Attacks) in src)&&Magic_Potential>=3)
		src << "You have learned how to empower your allies attacks due to your magical skill."
		contents+=new/Skill/Spell/Empowered_Attacks
		Lrned++
	if(Magic_Level>=65&&!(locate(/Skill/Spell/Ritual_Of_Power) in src)&&HasMagicMiles>1)
		src << "You now have the ability to perform a ritual of power."
		contents+=new/Skill/Spell/Ritual_Of_Power
		Lrned++
	if(Magic_Level>=65&&!(locate(/Skill/Spell/Accelerate) in src)&&Magic_Potential>=5)
		src << "You now have the ability to perform a ritual of acceleration."
		contents+=new/Skill/Spell/Accelerate
		Lrned++

	if(Magic_Level>=70&&!(locate(/Skill/Spell/Earth_Prison) in src)&&Magic_Potential>2)
		src << "You have learned Earth Prison due to your magical skill."
		contents+=new/Skill/Spell/Earth_Prison
		Lrned++
	if(Magic_Level>=75&&!(locate(/Skill/Spell/Frost_Nova) in src)&&Magic_Potential>2)
		src << "You have learned Frost Nova due to your magical skill."
		contents+=new/Skill/Spell/Frost_Nova
		Lrned++
	if(Magic_Level>=15&&Magic_Potential>3.5&&!(locate(/Skill/Spell/Conjure) in src))
		src << "You have learned Conjure due to your magical skill."
		contents+=new/Skill/Spell/Conjure
		Lrned++
	if(Magic_Level>=80&&!(locate(/Skill/Spell/Create_Portal) in src)&&Magic_Potential>3)
		src << "You have learned Create Portal due to your magical skill."
		contents+=new/Skill/Spell/Create_Portal
		Lrned++
/*	if(Magic_Level>=85&&!(locate(/Skill/Attacks/MegaBurst) in src)&&Magic_Potential>2)
		contents+=new/Skill/Attacks/MegaBurst
		Lrned++
		src<<"<span class=announce>Congratulations! Through mastery of the arcane and a masssive energy store, you have learned to produce a mighty beam!</span>"*/
	if(Magic_Level>=90&&Magic_Potential>4&&!(locate(/Skill/Spell/Seance) in src))
		src << "You have learned Advanced Seance due to your magical skill."
		contents+=new/Skill/Spell/Advanced_Seance
		Lrned++
	if(Magic_Level>=125&&Magic_Potential>5&&!(locate(/Skill/Spell/Dark_Bargain) in src))
		src << "You have learned Dark Bargain due to your magical skill."
		contents+=new/Skill/Spell/Dark_Bargain
		Lrned++
	if(Magic_Level>=60&&!(locate(/Skill/Spell/Alter_Perception) in src)&&Magic_Potential>2)
		contents+=new/Skill/Spell/Alter_Perception
		Lrned++
		src<<"<span class=announce>Congratulations! You can now assist someone in crafting a new identity!</span>"


//Tech
/*
	if(Int_Level>=30&&!(locate(/Skill/Technology/Plant_Saiba) in src))
		src << "You can now plant Saibamen"
		contents+=new/Skill/Technology/Plant_Saiba
		Lrned++
*/
	if(Int_Level>=40&&Int_Mod>2&&!(locate(/Skill/Technology/MakeWeights) in src))
		src << "You can now create weighted clothing."
		contents+=new/Skill/Technology/MakeWeights
		Lrned++
	if(Int_Level>=49&&Int_Mod>1&&!(locate(/Skill/Technology/Replace_Limb)in src))
		contents+=new/Skill/Technology/Replace_Limb
		Lrned++
		src<<"You learned how to use your technology to replace someone's limb."
	if(Int_Level>=55&&!(locate(/Skill/Technology/Construct_Robot)in src)&&Int_Mod>2)
		contents+=new/Skill/Technology/Construct_Robot
		Lrned++
		src<<"Your intelligence has lead to you discovering the process needed to create an automated drone."
	if(Int_Level>=55&&Int_Mod>2&&!(locate(/Skill/Technology/Nanite_Burst)in src))
		contents+=new/Skill/Technology/Nanite_Burst
		Lrned++
		src<<"You learned how to use Nanites to heal those around you."
	if(Int_Level>=57&&!(locate(/Skill/Technology/Calculated_Strikes)in src)&&Int_Mod>2)
		contents+=new/Skill/Technology/Calculated_Strikes
		Lrned++
		src<<"You have awoken your race's natural ability to analyze the paces of combat and target specific points."
	if(Int_Level>=58&&!(locate(/Skill/Technology/MakeStatue) in src)&&Int_Mod>2)
		src << "You have learned how to make statues of people."
		contents+=new/Skill/Technology/MakeStatue
		Lrned++
	if(Int_Level>=60&&!(locate(/Skill/Technology/Upgrade_Android) in src)&&Int_Mod>2)
		src << "You now have the ability to upgrade Androids."
		contents+=new/Skill/Technology/Upgrade_Android
		Lrned++
	if(Int_Level>=38&&!(locate(/Skill/Buff/Combat_Mathematics)in src)&&Int_Mod>=2)
		contents+=new/Skill/Buff/Combat_Mathematics
		Lrned++
		src<<"You have awoken your race's natural ability to analyze the paces of combat and respond accordingly."
	if(Int_Level>=65&&!(locate(/Skill/Technology/Cyberize) in src)&&HasIntMiles>1)
		src << "You now have the ability to cyberize people."
		contents+=new/Skill/Technology/Cyberize
		Lrned++
	if(Int_Level>=68&&Int_Mod>2&&!(locate(/Skill/Technology/Energy_Infusion)in src))
		contents+=new/Skill/Technology/Energy_Infusion
		Lrned++
		src<<"You learned how to use an Energy Infusion to empower someone."
	if(Int_Level>=78&&Int_Mod>3&&!(locate(/Skill/Technology/Cybernetic_Limb)in src))
		contents+=new/Skill/Technology/Cybernetic_Limb
		Lrned++
		src<<"You learned how to use your technology to replace someone's limb with an upgraded version!"
	if(Int_Level>=52&&!(locate(/Skill/Technology/Cosmetic_Surgery) in src)&&HasIntMiles>1)
		src << "You now have the ability to perform cosmetic surgery on someone."
		contents+=new/Skill/Technology/Cosmetic_Surgery
		Lrned++
	if(Int_Level>=61&&!(locate(/Skill/Technology/Stungun) in src)&&Int_Mod>2.5)
		src << "You have learned how to stun people with your tech."
		contents+=new/Skill/Technology/Stungun
		Lrned++
//	if(Int_Level>=15&&Int_Mod>3.5&&!(locate(/Skill/Technology/Create_Artificial_Angel) in src))
//		src << "You have learned to create an artificial divine being."
//		contents+=new/Skill/Technology/Create_Artificial_Angel
//		Lrned++



//	if(Mining_Level>=5&&!(locate(/obj/Mine_Deep)in src))
//		contents+= new/obj/Mine_Deep
//		src<<"You have learned to mine a tunnel into the underground!"


	if(FBMAchieved&&MaxKi>3000&&!(locate(/Skill/Misc/Leave_Planet)in src))
		contents+=new/Skill/Misc/Leave_Planet
		src<<"Your great power and energy have lead to you developing the power to leave a planet's orbit by flight alone, though it will have a cooldown."
	if(HasFlightMaster&&MaxKi>2000&&WipeDay>19&&!(locate(/Skill/Misc/Leave_Planet)in src))
		contents+=new/Skill/Misc/Leave_Planet
		src<<"Your great power and energy have lead to you developing the power to leave a planet's orbit by flight alone, though it will have a cooldown."

	if(Lrned)
		Remove_Duplicate_Moves()

Skill/proc/Teachify(mob/use,mob/A,var/Passive=null)
	if(Tier==3 && !use.Rank)
		use<<"Only a rank may teach this skill."
		return
	if(Tier==5 && A.EnablementSlot && use.Rank && !A.Rank)
		use<<"They can only learn one tier 5 buff."
		return
	if(Tier==4 && !use.Rank && !A.Rank)
		use<<"Tier 4 can be taught by Teachers"
		return
/*	if(Tier>3&&Tier!=5)
		usr<<"Tier 3 and 4 skills may no longer be taught directly and instead the person must develop it on their own using XP."
		return*/
	if(use.TeachCD>=use.TeachLimit)
		use<<"You have already taught everyone you can this month and must wait."
		return 0
	if(!A.LearnSlots)
		use<<"[A] is not ready to learn another technique."
		return 0
	if(TeachDay>WipeDay)
		use<<"You may not teach this until day [TeachDay]."
		return 0
	for(var/Skill/SS in A) if(SS.type==type)
		use<<"They already have this ability."
		return 0
	if(Experience!=100)
		usr<<"You must master this first."
		return 0
	switch(Tier)
		if(1)
			if(A.MaxKi<800)
				view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough energy. (800)"
				return 0
			if(Passive)switch(Passive)
				if("Melee")
					if(A.UnarmedSkill+(A.HasUnarmed*50)<50)//
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Unarmed Skill. (50)"
						return 0
				if("Weapon")
					if(A.SwordSkill+(A.HasWeapon*50)<50)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Weapon Skill. (50)"
						return 0
				if("Ki")
					if(A.KiManipulation+(A.HasKiManip*50)<50)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Ki Manipulation. (50)"
						return 0
		if(2)
			if(A.MaxKi<1400)
				view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough energy. (1400)"
				return 0
			if(Passive)switch(Passive)
				if("Melee")
					if(A.UnarmedSkill+(A.HasUnarmed*50)<250)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Unarmed Skill. (250)"
						return 0
				if("Weapon")
					if(A.SwordSkill+(A.HasWeapon*50)<250)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Weapon Skill. (250)"
						return 0
				if("Ki")
					if(A.KiManipulation+(A.HasKiManip*50)<250)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Ki Manipulation. (250)"
						return 0
		if(3)
			if(A.MaxKi<2500)
				view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough energy. (2500)"
				return 0
			if(Passive)switch(Passive)
				if("Melee")
					if(A.UnarmedSkill+(A.HasUnarmed*50)<500)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Unarmed Skill. (500)"
						return 0
				if("Weapon")
					if(A.SwordSkill+(A.HasWeapon*50)<500)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Weapon Skill. (500)"
						return 0
				if("Ki")
					if(A.KiManipulation+(A.HasKiManip*50)<500)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Ki Manipulation. (500)"
						return 0
		if(4)
			if(A.MaxKi<4000)
				view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough energy. (4000)"
				return 0
			if(Passive)switch(Passive)
				if("Melee")
					if(A.UnarmedSkill+(A.HasUnarmed*50)<1000)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Unarmed Skill. (1000)"
						return 0
				if("Weapon")
					if(A.SwordSkill+(A.HasWeapon*50)<1000)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Weapon Skill. (1000)"
						return 0
				if("Ki")
					if(A.KiManipulation+(A.HasKiManip*50)<1000)
						view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough Ki Manipulation. (1000)"
						return 0
		if(5)
			if(A.MaxKi<6000)
				view(use)<<"[use] tried to teach [A] the [src] ability, but [A] did not have enough energy. (7000)"
				return 0
			if(A.EnablementSlot)
				usr<<"They already possess great skill."
				return 0
	if(src.Teach < 1)
		view(use)<<"[use] tried to teach [A] the [src] ability, but [use] is not able to teach it yet. ([round(10/usr.TeachLimit)] Months per recharge)"
		return 0
	if(RequiresApproval&&usr.Rank)
		if(HasApproval["[A.real_name]"]&&HasApproval["[A.real_name]"]<=WipeDay)
			TeachingHook(use,A,src)
			HasApproval.Remove("[A.real_name]")
		else
			use<<"You must first mark this person as a student of [src] 1 day before teaching."
			return 0
	src.Teach --
	if(src.Teach<0) src.Teach = 0
	if(WaitTime)
		TeachDay=WipeDay+WaitTime
		use<<"You will be ready to teach this again on day [TeachDay]."
	use.TeachCD+=1
	if(A.AlignmentNumber>1&&use.AlignmentNumber>1) use.AlignmentNumber+=0.3
	view(use)<<"[use] taught [A] the [src] ability."
	//("[key_name(use)] taught [key_name(A)] [src]")
	A.saveToLog("|  | ([A.x], [A.y], [A.z]) | [key_name(A)] was taught [src] by [key_name(use)]")
	use.saveToLog("| ([use.x], [use.y], [use.z]) | [key_name(use)] taught [key_name(A)] [src]")
	var/Skill/NA=new type(A)
	A.contents+=NA
	NA.desc += "<br>You were taught this at year [Year] from [use]."
	//NA.LearnedYear=Year
	logAndAlertAdmins("[key_name(use)] successfully taught [key_name(A)] the [src] ability.",2)
	A.LearnSlots--
	A.LastLearn=WipeDay
//	A.Teach--

	if(Tier==5)
		A.EnablementSlot=1
		NA.NotTeachable=1
	return 1
	
