

/*

Limited Skills
 Custom Beam(Force Based)
*/
var/list

	BasicSkills=list(/Skill/Misc/Resist,/Skill/Support/Sense_Energy,/Skill/Buff/Focus,/Skill/Buff/Power_Control,/Skill/Misc/KiFists,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Attacks/RockThrow,/Skill/Misc/Block,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Misc/Fly,/Skill/Melee/RoundhouseKick,/Skill/Melee/DashAttack,/Skill/Melee/WarpAttack,/Skill/Buff/Shield,/Skill/Weapon/Slice,/Skill/Weapon/Bash,/Skill/Attacks/Shockwave)

	MeleeSkills=list(/Skill/Melee/Headbutt,/Skill/Unarmed/UppercutCombo,/Skill/Unarmed/CatchTheBlade,/Skill/Attacks/RockTomb,/Skill/Melee/PressurePunch,/Skill/Attacks/RockSlide,/Skill/Unarmed/MegatonThrow)

	KiSkills=list(/Skill/Attacks/DestructoDisc,/Skill/Attacks/Mortar_Charge,/Skill/Attacks/GuideBomb,/Skill/Attacks/SpiritBall,/Skill/Attacks/ExplosiveWave,/Skill/Attacks/Barrage)

	WeaponSkills=list(/Skill/Weapon/Riposte,/Skill/Weapon/SwordStab,/Skill/Weapon/Overhead_Smash,/Skill/Weapon/Colossal_Impact,/Skill/Weapon/CleaveAttack,/Skill/Attacks/EchoingSlash)

	LimitedSkills=list(/Skill/Melee/TelekineticPull,/Skill/Weapon/Iai_Slash,/Skill/Attacks/SolarFlare,/Skill/Melee/Kickback_Combo,/Skill/Attacks/Explosion,/Skill/Support/Heal,/Skill/Misc/KiBlade,/Skill/Melee/Wing_Clip,/Skill/Melee/Guard_Break,/Skill/Weapon/Wind_Howl,/Skill/Support/Splitform,/Skill/Support/Send_Energy,/Skill/Attacks/Homing_Finisher,/Skill/Buff/Expand,/Skill/Zanzoken,/Skill/Attacks/MegaBurst,/Skill/Attacks/Earthquake,/Skill/Unarmed/PileDriver,/Skill/Attacks/Self_Destruct)

//	UniqueBuffs=list(/Skill/FusionDance,/Skill/Buff/Death,/Skill/Buff/War,/Skill/Buff/Kaioken,/Skill/Buff/Channel,/Skill/Buff/High_Tension,/Skill/Buff/Godspeed,/Skill/Buff/Armament,/Skill/Buff/VerdantMiosis,/Skill/Buff/Shadow_King,/Skill/Buff/Fists_Of_Fury,/Skill/Buff/BestialWrath,/Skill/Buff/ArcanePower)

	UniqueAttacks=list(/Skill/Weapon/Flourish,/Skill/Melee/CriticalEdge,/Skill/Attacks/Blaster_Meteor,/Skill/Unarmed/Texas_Smash,/Skill/Attacks/BlueCometSpecial,/Skill/Attacks/Dragon_Nova,/Skill/Attacks/Genocide,/Skill/Attacks/Hellzone_Grenade,/Skill/Attacks/HyperTornado,/Skill/Attacks/SkyBreak,/Skill/Attacks/TriBeam,/Skill/Attacks/SuperGhostKamikazeAttack,/Skill/Attacks/WallofFlame,/Skill/Attacks/SuperExplosiveWave,/Skill/Unarmed/BurningShot,/Skill/Attacks/Death_Ball,/Skill/Attacks/SpiritBomb,/Skill/Attacks/KillDriver,/Skill/Melee/MarchOfFury)

	UniqueBeams=list(/Skill/Attacks/Beams/Dodompa,/Skill/Attacks/Beams/Photon_Flash,/Skill/Attacks/Beams/Tyrant_Lancer,/Skill/Attacks/Beams/Double_Sunday,/Skill/Attacks/Beams/Buster_Cannon,/Skill/Attacks/Beams/Final_Flash,/Skill/Attacks/Beams/Galic_Gun,/Skill/Attacks/Beams/Kamehameha,/Skill/Attacks/Beams/Masenko,/Skill/Attacks/Beams/Piercer,/Skill/Attacks/Beams/Ray)

	WerewolfSkills=list(/Skill/Zanzoken,/Skill/Buff/Expand,/Skill/Support/Sense_Energy,/Skill/Support/Pack_Telepathy)
	OGWerewolfSkills=list(/Skill/Support/Werewolf_Infect)

	VampireSkills=list(/Skill/Zanzoken,/Skill/Support/Invisibility,/Skill/Support/Telekinesis,/Skill/Support/Drain_Blood,/Skill/Support/Vampire_Telepathy)
	OGVampireSkills=list(/Skill/Support/Vampire_Infect,/Skill/Support/Send_Energy,/Skill/Support/Imitation)

	EarthGuardianRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Misc/Fly,/Skill/Support/Heal,/Skill/Support/Materialization,/Skill/Support/Give_Power,/Skill/Support/Unlock_Potential,/Skill/Attacks/GuideBomb,/Skill/Misc/KiFists,/Skill/Support/Telepathy,/Skill/Zanzoken,/obj/RankChat)

	KorinRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Support/PlantSenzu,/Skill/Buff/Shield,/Skill/Misc/Fly,/Skill/Misc/KiFists,/Skill/Support/Give_Power,/Skill/Zanzoken,/Skill/Buff/Focus,/Skill/Attacks/Shockwave,/Skill/Attacks/Mortar_Charge,/Skill/Attacks/RockTomb,/Skill/Unarmed/PileDriver,/obj/RankChat)

	TurtleHermitRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Charge,/Skill/Misc/KiFists,/Skill/Attacks/Beams/Beam,/Skill/Attacks/Beams/Kamehameha,/Skill/Buff/Expand,/Skill/Melee/PressurePunch,/Skill/Technology/MakeWeights,/obj/RankChat,/Skill/Unarmed/UppercutCombo,/Skill/Attacks/RockTomb)

	WolfHermitRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Charge,/Skill/Misc/KiFists,/Skill/Technology/MakeWeights,/Skill/Attacks/Beams/Beam,/obj/RankChat,/Skill/Attacks/GuideBomb,/Skill/Attacks/SpiritBall,/Skill/Melee/Guard_Break,/Skill/Attacks/Mortar_Charge)

	CraneHermitRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiBlade,/Skill/Attacks/Beams/Beam,/Skill/Attacks/Beams/Dodompa,/Skill/Technology/MakeWeights,/Skill/Attacks/SolarFlare,/Skill/Support/Splitform,/Skill/Attacks/TriBeam,/obj/RankChat,/Skill/Melee/Guard_Break,/Skill/Unarmed/PileDriver)

	BlackWaterMagicianRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/GuideBomb,/Skill/Attacks/Beams/Beam,/Skill/Spell/Conjure,/Skill/Support/Materialization,/Skill/Black_Water_Infect,/Skill/Misc/KiBlade,/Skill/Buff/Expand,/Skill/Attacks/Earthquake,/obj/RankChat)

	RedRibbonLeaderRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Buff/Shield,/Skill/Attacks/Explosion,/Skill/Attacks/Mortar_Charge,/Skill/Attacks/ExplosiveWave,/Skill/Attacks/Charge,/Skill/Unarmed/PileDriver,/Skill/Attacks/Beams/Beam,/Skill/Buff/Thugged_Rage,/Skill/Misc/Fly,/Skill/Attacks/Explosion,/obj/RankChat)

	ElderRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Charge,/Skill/Buff/Power_Control,/Skill/Support/Heal,/Skill/Support/Materialization,/Skill/Support/NamekianFusion,/Skill/Support/Unlock_Potential,/Skill/Attacks/Hellzone_Grenade,/Skill/Support/Telepathy,/Skill/Support/Give_Power,/Skill/Support/Telepathy,/obj/RankChat,/Skill/Support/Make_Magic_Balls,/Skill/Spell/Telekinesis_Magic,/Skill/Support/Telekinesis)

	NamekTeacherRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Masenko,/Skill/Attacks/Beams/Piercer,/Skill/Misc/Fly,/Skill/Zanzoken,/Skill/Melee/Guard_Break,/Skill/Buff/Power_Control,/Skill/Buff/Shield,/Skill/Unarmed/UppercutCombo,/Skill/Attacks/Homing_Finisher,/Skill/Support/Splitform,/Skill/Attacks/ExplosiveDemonWave,/Skill/Support/Materialization,/Skill/Support/NamekianFusion,/Skill/Buff/Expand,/obj/RankChat)

	KingVegetaRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Attacks/Beams/Final_Flash,/Skill/Buff/False_Moon,/obj/RankChat,/Skill/Attacks/Beams/Galic_Gun,/Skill/Attacks/Explosion,/Skill/Attacks/RockTomb,/Skill/Unarmed/UppercutCombo,/Skill/Buff/Expand,/Skill/Attacks/Shockwave,/Skill/Unarmed/MegatonThrow,/Skill/Attacks/Dragon_Nova,/Skill/Melee/Guard_Break)

	AlienKingRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Support/InstantTransmission,/Skill/Misc/Fly,/Skill/Zanzoken,/Skill/Attacks/Blast,/Skill/Attacks/Charge,/Skill/Support/Telepathy,/Skill/Support/Splitform,/Skill/Attacks/Beams/Beam,/Skill/Misc/KiBlade,/Skill/Misc/KiFists,/Skill/Attacks/RockTomb,/Skill/Unarmed/UppercutCombo,/Skill/FusionDance,/Skill/Attacks/Beams/Ray,/Skill/Attacks/GuideBomb,/Skill/Misc/Fly,/Skill/Buff/Expand,/Skill/Attacks/ExplosiveWave,/Skill/Melee/Guard_Break,/obj/RankChat)

	IceSkillMasterRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Attacks/Beams/Ray,/Skill/Attacks/Mortar_Charge,/Skill/Attacks/Death_Ball,/Skill/Misc/Fly,/Skill/Buff/Power_Control,/Skill/Attacks/Earthquake,/Skill/Attacks/ExplosiveWave,/Skill/Attacks/RockTomb,/Skill/Unarmed/PileDriver,/Skill/Attacks/GuideBomb,/Skill/Buff/Expand,/Skill/Buff/Shield,/Skill/Attacks/DestructoDisc,/obj/RankChat,/Skill/Attacks/RockSlide,/Skill/Attacks/Homing_Finisher,/Skill/Support/Telekinesis,/Skill/Melee/Guard_Break)

	KaioshinRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Support/Heal,/Skill/Misc/Fly,/Skill/Buff/Power_Control,/Skill/Support/Materialization,/Skill/Support/Mystify,/Skill/Support/Unlock_Potential,/Skill/Support/Keep_Body,/Skill/Support/Restore_Youth,/Skill/Support/Kaio_Revive,/Skill/Support/Reincarnate,/Skill/Buff/Mystic,/Skill/Support/Bind,/Skill/Support/Teleport,/Skill/Misc/KiBlade,/Skill/Attacks/GuideBomb,/Skill/Support/Telepathy,/Skill/Support/Observe,/obj/RankChat,/Skill/Support/Send_Energy,/Skill/Spell/Telekinesis_Magic,/Skill/Support/Telekinesis)

	NorthKaioRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Attacks/Beams/Beam,/Skill/Attacks/Charge,/Skill/Misc/KiFists,/Skill/Misc/Fly,/Skill/Support/Give_Power,/Skill/Support/Materialization,/Skill/Buff/Kaioken,/Skill/Attacks/RockTomb,/Skill/Attacks/Blaster_Meteor,/Skill/Attacks/SpiritBomb,/Skill/Support/Telepathy,/Skill/Support/Kaio_Revive,/obj/RankChat,/Skill/Buff/Power_Control)

	EastKaioRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Attacks/Genocide,/Skill/Attacks/ExplosiveDemonWave,/Skill/Buff/Channel,/Skill/Attacks/GuideBomb,/Skill/Support/Kaio_Revive,/Skill/Misc/Fly,/Skill/Buff/Shield,/Skill/Misc/KiBlade,/Skill/Support/Give_Power,/Skill/Buff/Power_Control,/Skill/Buff/Focus,/Skill/Support/Materialization,/Skill/Support/Telepathy,/obj/RankChat)

	WestKaioRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Unarmed/PileDriver,/Skill/Attacks/RockSlide,/Skill/Unarmed/BurningShot,/Skill/Buff/High_Tension,/Skill/Support/Kaio_Revive,/Skill/Misc/Fly,/Skill/Support/Heal,/Skill/Buff/Shield,/Skill/Support/Give_Power,/Skill/Buff/Power_Control,/Skill/Buff/Focus,/Skill/Support/Materialization,/Skill/Support/Telepathy,/obj/RankChat)

	SouthKaioRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/Skill/Attacks/BlueCometSpecial,/Skill/Attacks/HyperTornado,/Skill/Buff/Godspeed,/Skill/Support/Kaio_Revive,/Skill/Misc/Fly,/Skill/Buff/Shield,/Skill/Support/Give_Power,/Skill/Buff/Power_Control,/Skill/Buff/Focus,/Skill/Support/Materialization,/Skill/Support/Telepathy,/obj/RankChat)

	JudgeRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Buff/Giant_Mode,/Skill/Misc/KiFists,/Skill/Support/Keep_Body,/Skill/Support/Heal,/Skill/Support/Bind,/Skill/Support/Telepathy,/Skill/Support/Observe,/obj/JudgeControls,/Skill/Support/Reincarnate,/Skill/Attacks/Earthquake,/Skill/Attacks/ExplosiveWave,/Skill/Attacks/RockTomb,/obj/RankChat,/Skill/Unarmed/PileDriver,/Skill/Support/Make_Judgement,/Skill/Melee/Guard_Break)

	DaimaouRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Support/Observe_Majinizations,/Skill/Misc/KiFists,/Skill/Misc/Fly,/Skill/Buff/Shield,/Skill/Buff/Expand,/Skill/Support/Splitform,/Skill/Support/Majinize,/Skill/Support/Keep_Body,/Skill/Support/Restore_Youth,/Skill/Support/Materialization,/Skill/Support/Bind,/Skill/Support/Make_Fruit,/Skill/Support/Kaio_Revive,/Skill/Support/Telepathy,/Skill/Buff/Majin,/Skill/Support/Dark_Blessing,/Skill/Support/Observe,/Skill/Support/DemonTeleport,/Skill/Attacks/WallofFlame,/obj/RankChat)

	WarRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Buff/War,/Skill/Misc/KiFists,/Skill/Support/Kaio_Revive,/Skill/Attacks/Explosion,/Skill/Attacks/Blaster_Meteor,/Skill/Misc/Fly,/Skill/Buff/Expand,/Skill/Support/Keep_Body,/Skill/Attacks/SuperGhostKamikazeAttack,/Skill/Support/Materialization,/Skill/Buff/Shield,/Skill/Attacks/Mortar_Charge,/Skill/Unarmed/PileDriver,/Skill/Support/Imitation,/Skill/Buff/Majin,/Skill/Support/Restore_Youth,/Skill/Attacks/WallofFlame,/Skill/Attacks/SuperExplosiveWave,/obj/RankChat)

	DeathRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Buff/Death,/Skill/Support/Kaio_Revive,/Skill/Attacks/Explosion,/Skill/Attacks/Blaster_Meteor,/Skill/Misc/Fly,/Skill/Buff/Expand,/Skill/Support/Keep_Body,/Skill/Attacks/SuperGhostKamikazeAttack,/Skill/Support/Materialization,/Skill/Buff/Shield,/Skill/Misc/KiFists,/Skill/Attacks/RockTomb,/Skill/Unarmed/PileDriver,/Skill/Support/Imitation,/Skill/Buff/Majin,/Skill/Support/Restore_Youth,/Skill/Attacks/WallofFlame,/Skill/Attacks/SuperExplosiveWave,/obj/RankChat)

	PestilenceRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Support/Kaio_Revive,/Skill/Attacks/Explosion,/Skill/Attacks/Blaster_Meteor,/Skill/Misc/Fly,/Skill/Buff/Expand,/Skill/Support/Keep_Body,/Skill/Attacks/SuperGhostKamikazeAttack,/Skill/Support/Materialization,/Skill/Buff/Shield,/Skill/Misc/KiFists,/Skill/Attacks/GuideBomb,/Skill/Unarmed/PileDriver,/Skill/Attacks/RockTomb,/Skill/Support/Imitation,/Skill/Buff/Majin,/Skill/Support/Restore_Youth,/Skill/Attacks/WallofFlame,/Skill/Attacks/SuperExplosiveWave,/obj/RankChat)

	FamineRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/ExplosiveWave,/Skill/Support/Kaio_Revive,/Skill/Attacks/Explosion,/Skill/Attacks/Blaster_Meteor,/Skill/Misc/Fly,/Skill/Buff/Expand,/Skill/Support/Keep_Body,/Skill/Attacks/SuperGhostKamikazeAttack,/Skill/Support/Materialization,/Skill/Buff/Shield,/Skill/Misc/KiFists,/Skill/Attacks/GuideBomb,/Skill/Unarmed/PileDriver,/Skill/Attacks/Mortar_Charge,/Skill/Support/Imitation,/Skill/Buff/Majin,/Skill/Support/Restore_Youth,/Skill/Attacks/WallofFlame,/Skill/Attacks/SuperExplosiveWave,/obj/RankChat)

	SwordMasterRank=list(/Skill/Attacks/EchoingSlash,/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Weapon/SwordStab,/Skill/Buff/Shield,/Skill/Misc/KiFists,/Skill/Weapon/Overhead_Smash,/Skill/Weapon/Colossal_Impact,/Skill/Attacks/RockTomb,/Skill/Unarmed/PileDriver,/Skill/Attacks/Mortar_Charge,/Skill/Unarmed/UppercutCombo,/Skill/Weapon/CleaveAttack,/Skill/Misc/KiBlade,/Skill/Attacks/SkyBreak,/Skill/Zanzoken,/Skill/Buff/Armament,/Skill/Attacks/Earthquake,/Skill/Weapon/Wind_Howl,/obj/RankChat)

	AndroidMainframeRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Beam,/obj/MainframeControls,/Skill/Attacks/Barrage,/Skill/Attacks/Explosion,/Skill/Misc/Fly,/Skill/Buff/Fists_Of_Fury,/Skill/Attacks/GuideBomb,/Skill/Attacks/Mortar_Charge,/obj/RankChat)

	SpaceKingRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Charge,/Skill/Attacks/RockTomb,/Skill/Attacks/Beams/Beam,/Skill/Attacks/Explosion,/Skill/Misc/Fly,/Skill/Attacks/DestructoDisc,/Skill/Attacks/ExplosiveWave,/Skill/Buff/Expand,/Skill/Misc/KiBlade,/Skill/Unarmed/UppercutCombo,/Skill/Unarmed/MegatonThrow,/Skill/Attacks/Earthquake,/Skill/Melee/Guard_Break,/obj/RankChat)

	SkillMasterRank=list(/Skill/Buff/Focus,/Skill/Buff/Ki_Force,/Skill/Buff/Muscle_Force,/Skill/Attacks/Blast,/Skill/Misc/KiFists,/Skill/Attacks/Charge,/Skill/Attacks/Beams/Ray,/Skill/Misc/Fly,/Skill/Zanzoken,/Skill/Melee/Guard_Break,/Skill/Buff/Power_Control,/Skill/Buff/Shield,/Skill/Unarmed/UppercutCombo,/Skill/Support/Splitform,/Skill/Support/Materialization,/Skill/Buff/Expand,/obj/RankChat)



