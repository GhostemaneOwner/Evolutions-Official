
var
	list/object_pools = list()

proc
	unpool(var/pool,var/type=null)
		var/list/l = object_pools[pool]
		if(!l)
			if(!type)
				return null
			l = createPool(pool,type)
		if(l.len==1)
			var/v = l[1]
			return new v()
		var/atom/movable/a = l[2]
		l.Remove(a)
		a.unpooled(pool)
		return a

	createPool(var/pool,var/type)//createPool("Explosions",/Icon_Obj/Effects/explosion)
		if(!object_pools[pool])
			object_pools[pool] = list(type)
		return object_pools[pool]

	pool(var/pool,var/atom/movable/object)
		if(!object_pools[pool])
			createPool(pool,object.type)
		object_pools[pool] += object
		object.pooled(pool)

atom/movable
	proc
		pooled(var/poolname)
			src.loc = null
		unpooled(var/poolname)


world/New()
	..()
	createPool("Slash", /Icon_Obj/Effects/Slash)
	createPool("SweepingBlade", /Icon_Obj/Effects/SweepingBlade)
	createPool("SweepingKick", /Icon_Obj/Effects/SweepingKick)
	createPool("HitEffect2", /Icon_Obj/Effects/HitEffect2)
	createPool("WolfFangFist", /Icon_Obj/Effects/WolfFangFist)
	createPool("UppercutUser", /Icon_Obj/Effects/UppercutUser)
	createPool("VerticalDust", /Icon_Obj/Effects/VerticalDust)
	createPool("ImpactDust", /Icon_Obj/Effects/ImpactDust)
	createPool("KiHitEffect", /Icon_Obj/Effects/Ki_Hit)
	createPool("ShockwaveScaler", /Icon_Obj/Effects/ShockwaveScaler)
	createPool("SlashUser", /Icon_Obj/Effects/SlashUser)
	createPool("StabUser", /Icon_Obj/Effects/StabUser)
	createPool("OilTrail", /Icon_Obj/Effects/OilTrail)
	createPool("BloodTrail", /Icon_Obj/Effects/BloodTrail)
	createPool("HeadBlood", /Icon_Obj/Effects/HeadBlood)
	createPool("Crater", /Icon_Obj/Effects/Crater)
	createPool("SmallCrater", /Icon_Obj/Effects/SmallCrater)
	createPool("DustCloud", /Icon_Obj/Effects/dustcloud)
	createPool("DustCloudOrigin", /Icon_Obj/Effects/dustcloudOrigin)
	createPool("smalldust", /Icon_Obj/Effects/smalldust)
	createPool("largedust", /Icon_Obj/Effects/largedust)
	createPool("bigshockwave", /Icon_Obj/Effects/bigshockwave)
	createPool("Ash", /Icon_Obj/Effects/Ash)
	createPool("ZanzoDust", /Icon_Obj/Effects/ZanzoDust)
	createPool("IceyGrip", /Icon_Obj/Effects/IceyGrip)
	createPool("DrownWaterOver", /Icon_Obj/Effects/DrownWaterOver)
	createPool("explosion", /Icon_Obj/Effects/explosion)
	createPool("Smoke", /Icon_Obj/Effects/Smoke)
	createPool("KBHole1", /Icon_Obj/Effects/KBHole1)
	createPool("KBHole2", /Icon_Obj/Effects/KBHole2)
	createPool("AfterImage", /Icon_Obj/Effects/After_Image)
	createPool("explosioncenter", /Icon_Obj/Effects/explosioncenter)
	createPool("FightingDirt", /Icon_Obj/Effects/FightingDirt)
	createPool("BlockEffect", /Icon_Obj/Effects/BlockEffect)
	createPool("Blasts", /obj/ranged/Blast/)
	createPool("SGKA", /obj/ranged/Blast/SGKA)
	createPool("BCS",/obj/ranged/Blast/BCS)
	createPool("Beams", /obj/ranged/Beam)
	createPool("SpiritBall", /obj/ranged/Blast/SpiritBall)
	createPool("Genki_Dama", /obj/ranged/Blast/SpiritBall/Genki_Dama)
	createPool("SaySpark", /Icon_Obj/Effects/SaySpark)

