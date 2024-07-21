//Bloody shoes/footprints
/// Minimum alpha of footprints
#define BLOODY_FOOTPRINT_BASE_ALPHA 20
/// How much blood a regular blood splatter contains
#define BLOOD_AMOUNT_PER_DECAL 50
/// How much blood an item can have stuck on it
#define BLOOD_ITEM_MAX 200
/// How much blood a blood decal can contain
#define BLOOD_POOL_MAX 300
/// How much blood a footprint need to at least contain
#define BLOOD_FOOTPRINTS_MIN 5

//Bloody shoe blood states
/// Red blood
#define BLOOD_STATE_HUMAN "blood"
/// Green xeno blood
#define BLOOD_STATE_XENO "xeno"
/// Black robot oil
#define BLOOD_STATE_OIL "oil"
/// No blood is present
#define BLOOD_STATE_NOT_BLOODY "no blood whatsoever"

// Bitflags for mob dismemberment and gibbing
/// Mobs will drop a brain
#define DROP_BRAIN (1<<0)
/// Mobs will drop organs
#define DROP_ORGANS (1<<1)
/// Mobs will drop bodyparts (arms, legs, etc.)
#define DROP_BODYPARTS (1<<2)
/// Mobs will drop items
#define DROP_ITEMS (1<<3)

/// Mobs will drop everything
#define DROP_ALL_REMAINS (DROP_BRAIN | DROP_ORGANS | DROP_BODYPARTS | DROP_ITEMS)



mob/var/tmp/list/bleedStacks = new/list
mob/var/tmp/bleedLooping = 0
bleed_stack
	proc/Apply(mob/M)
		if(!M || !ismob(M)) return
	//	if(M && M.bleedStacks.len >= 5 + M.GetTraitRank("Knife to a Fist Fight")) return
		M.bleedStacks += src
		spawn(60)
			if(M) M.bleedStacks -= src

mob/proc/ApplyBleed(chance = 20)
	if(Race == "Android" || Race == "Majin") chance = 0
//	if(Is_Cybernetic()) chance /= 2
//	chance /= GetArmorBleedDivider()
//	if(CheckForInjuries())
//		chance += GetInjuryTypeCount(/injury/laceration)
	if(prob(chance))
		var/bleed_stack/B = new
		B.Apply(src)

mob/proc/BleedDamage1()
	set background = TRUE
	set waitfor = FALSE
	if(bleedLooping) return
	bleedLooping = 1
	while(src && src.bleedStacks.len > 0)
		TakeDamage(bleedStacks.len * 0.2)
		sleep(1)
		