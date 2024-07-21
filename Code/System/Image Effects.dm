/*
var/obj/particle/red/p = unpool("particle_red")
            p.loc = src.loc
            animate(p, pixel_x=rand(-64,64), pixel_y=rand(-64,64), alpha=0, time=rand(3,8))
            spawn(9) pool("particle_red",p)*/

proc
	Slash(atom/movable/M)
		var/Icon_Obj/Effects/Slash/P = unpool("Slash")
		//P.loc=M.loc
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("Slash",P)
	HitEffect2(atom/movable/M)
		var/Icon_Obj/Effects/HitEffect2/P = unpool("HitEffect2")
		//P.loc=M.loc
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("HitEffect2",P)
	BlockEffect(atom/movable/M)
		var/Icon_Obj/Effects/BlockEffect/P = unpool("BlockEffect")
		//P.loc=M.loc
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("BlockEffect",P)
	SweepingKick(atom/movable/M)
		var/Icon_Obj/Effects/SweepingKick/P = unpool("SweepingKick")
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("SweepingKick",P)
	SweepingBlade(atom/movable/M)
		var/Icon_Obj/Effects/SweepingBlade/P = unpool("SweepingBlade")
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("SweepingBlade",P)
	WolfFangFist(atom/movable/M)
		var/Icon_Obj/Effects/WolfFangFist/P = unpool("WolfFangFist")
		P.dir=M.dir
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("WolfFangFist",P)
	SlashUser(atom/movable/M)
		var/Icon_Obj/Effects/SlashUser/P = unpool("SlashUser")
		P.dir=M.dir
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("SlashUser",P)
	StabUser(atom/movable/M)
		var/Icon_Obj/Effects/StabUser/P = unpool("StabUser")
		P.dir=M.dir
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("StabUser",P)
	UppercutUser(atom/movable/M)
		var/Icon_Obj/Effects/UppercutUser/P = unpool("UppercutUser")
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("UppercutUser",P)
	VerticalDust(atom/movable/M)
		var/Icon_Obj/Effects/VerticalDust/P = unpool("VerticalDust")
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("VerticalDust",P)
	UppercutUser2(atom/movable/M)
		var/Icon_Obj/Effects/UppercutUser/P = unpool("UppercutUser")
		animate(P,transform = turn(matrix(), 180), time = 0)
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("UppercutUser",P)
	VerticalDust2(atom/movable/M)
		var/Icon_Obj/Effects/VerticalDust/P = unpool("VerticalDust")
		animate(P,transform = turn(matrix(), 180), time = 0)
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("VerticalDust",P)
	ImpactDust(atom/movable/M,Direc)
		var/Icon_Obj/Effects/ImpactDust/P = unpool("ImpactDust")
		P.dir=Direc
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("ImpactDust",P)
	KiHitEffect(atom/movable/M,mob/C)
		var/Icon_Obj/Effects/Ki_Hit/P = unpool("KiHitEffect")
		if(C&&ismob(C)) P.icon=C.KiHitEffect
		P.Target=M
		P.Target_Watch()
		spawn(5) pool("KiHitEffect",P)
	ShockwaveScale(atom/movable/M,var/CreatorBP,var/Size=1)
		if(Size>3)Size=3
		if(Size<0.2)Size=0.2
		var/Icon_Obj/Effects/ShockwaveScaler/P = unpool("ShockwaveScaler")
		var/Type=1
		if(CreatorBP)
			Type=1
			if(CreatorBP>1000) Type=2
			if(CreatorBP>5000) Type=3
			if(CreatorBP>25000) Type=4
			if(CreatorBP>125000) Type=5
			if(CreatorBP>625000) Type=6
			if(CreatorBP>1250000) Type=7
			if(CreatorBP>2500000) Type=8
			Type+=rand(-1,1)
			if(prob(25))Type+=rand(-1,1)
			if(Type<1)Type=1
			if(Type>8)Type=8
		P.icon_state=null
		switch(Type)
			if(1)
				P.icon='Impact.dmi'
				P.icon_state = "shock"
			if(2)
				P.icon='Shockwavecustom64.dmi'
				P.pixel_x=-16
				P.pixel_y=-16
			if(3)
				P.icon='Shockwavecustom128.dmi'
				P.pixel_x=-64
				P.pixel_y=-64
			if(4)
				P.icon='Shockwavecustom256.dmi'
				P.pixel_x=-128
				P.pixel_y=-128
			if(5)
				P.icon='Shockwavecustom512.dmi'
				P.pixel_x=-256
				P.pixel_y=-256
			if(6)
				P.icon='fevKiai.dmi'
				P.pixel_x=-120
				P.pixel_y=-120
			if(7)
				P.icon='KenShockwave.dmi'
				P.pixel_x=-120
				P.pixel_y=-120
			if(8)
				P.icon='Shockwave2016.png'
				P.pixel_x=-180
				P.pixel_y=-140
		P.pixel_x+=rand(-16,16)
		P.pixel_y+=rand(-16,16)
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=locate(M.x,M.y,M.z)
		var/SizeTo=rand(70,160)/100
		animate(P,transform = matrix()*SizeTo*Size,alpha=0,time=rand(5,15))
		spawn(rand(1,3)) if(prob(10)&&Size>=0.5) ShockwaveScale(M,CreatorBP*0.5,Size*0.5)
		spawn(15) pool("ShockwaveScaler",P)
	HeadBlood(atom/movable/M)
		var/Icon_Obj/Effects/HeadBlood/P = unpool("HeadBlood")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(400) pool("HeadBlood",P)
	BloodTrail(atom/movable/M)
		var/Icon_Obj/Effects/BloodTrail/P = unpool("BloodTrail")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(400) pool("BloodTrail",P)
	OilTrail(atom/movable/M)
		var/Icon_Obj/Effects/OilTrail/P = unpool("OilTrail")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(400) pool("OilTrail",P)
	Crater(atom/movable/M)
		var/Icon_Obj/Effects/Crater/P = unpool("Crater")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(400) pool("Crater",P)
	SmallCrater(atom/movable/M)
		var/Icon_Obj/Effects/SmallCrater/P = unpool("SmallCrater")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(400) pool("SmallCrater",P)
	DustCloud(atom/movable/M)
		if(prob(50))
			DustCloudOrigin(M)
			return
		var/Icon_Obj/Effects/dustcloud/P = unpool("DustCloud")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(15) pool("DustCloud",P)
	DustCloudOrigin(atom/movable/M)
		var/Icon_Obj/Effects/dustcloudOrigin/P = unpool("DustCloudOrigin")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(15) pool("DustCloudOrigin",P)
	LargeDust(atom/movable/M)
		var/Icon_Obj/Effects/largedust/P = unpool("largedust")
		P.Target=M
		P.Target_Watch()
		spawn(10) pool("largedust",P)
	SmallDust(atom/movable/M)
		var/Icon_Obj/Effects/smalldust/P = unpool("smalldust")
		P.Target=M
		P.Target_Watch()
		spawn(10) pool("smalldust",P)
	BigShockwave(atom/movable/M)
		var/Icon_Obj/Effects/bigshockwave/P = unpool("bigshockwave")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(10) pool("bigshockwave",P)
	Ash(atom/movable/M)
		var/Icon_Obj/Effects/Ash/P = unpool("Ash")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(400) pool("Ash",P)


	DrownWaterOver(atom/movable/M)
		var/Icon_Obj/Effects/DrownWaterOver/P = unpool("DrownWaterOver")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(5) pool("DrownWaterOver",P)

	ZanzoDust(atom/movable/M)
		var/Icon_Obj/Effects/ZanzoDust/P = unpool("ZanzoDust")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(5) pool("ZanzoDust",P)
	IceyGrip(atom/movable/M)
		var/Icon_Obj/Effects/IceyGrip/P = unpool("IceyGrip")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(5) pool("IceyGrip",P)
	ExplosionEffect(atom/movable/M)
		var/Icon_Obj/Effects/explosion/P = unpool("explosion")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		if(prob(10)) ExplosionEffect(M)
		spawn(5) pool("explosion",P)
	SmokeEffect(atom/movable/M)
		var/Icon_Obj/Effects/Smoke/P = unpool("Smoke")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(60) pool("Smoke",P)
	KBHole1(atom/movable/M,Direc,SE=0)
		var/Icon_Obj/Effects/KBHole1/P = unpool("KBHole1")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		P.dir=Direc
		if(SE==1)P.icon_state="begin"
		if(SE==2)P.icon_state="end"
		spawn(400) pool("KBHole1",P)
	KBHole2(atom/movable/M,Direc,SE=0)
		var/Icon_Obj/Effects/KBHole2/P = unpool("KBHole2")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		P.dir=Direc
		if(SE==1)P.icon_state="begin"
		if(SE==2)P.icon_state="end"
		spawn(400) pool("KBHole2",P)
	ExplosionCEffect(atom/movable/M)
		var/Icon_Obj/Effects/explosioncenter/P = unpool("explosioncenter")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(3) pool("explosioncenter",P)
	FightingDirt(atom/movable/M)
		var/Icon_Obj/Effects/FightingDirt/P = unpool("FightingDirt")
		if(ismob(M)||isobj(M)) P.loc=M.loc
		else if(isturf(M)) P.loc=M
		spawn(400) pool("FightingDirt",P)





mob/proc/Say_Spark()
	var/Icon_Obj/Effects/SaySpark/SS=unpool("SaySpark")
	SS.Target=src
	SS.Target_Watch()
	spawn(15) pool("SaySpark",SS)
Icon_Obj/Effects
//	Bolted=1
//	Shockwaveable=0
	density=0
	Health=1.#INF
//	Grabbable=0
	Savable=0
	layer=MOB_LAYER+EFFECTS_LAYER
	var/Target
	var/InUse=0
	pooled()
		InUse=0
		filters=list()
		animate(src,transform = null,alpha=initial(alpha),time=0)
		..()
	unpooled()
		InUse=1
		..()
	proc
		Target_Watch()
			loc=Target:loc
			pixel_z=Target:pixel_z
			goto1
			spawn(1)
				if(Target&&InUse&&z)
					pixel_z=Target:pixel_z
					loc=Target:loc
					goto goto1
	SaySpark
		icon='Say Spark.dmi'
		layer=MOB_LAYER+10
		pixel_y=5
		unpooled()
			..()
			animate(src,transform = matrix()*2,pixel_z=20,time=15)
			spawn(15) if(InUse) pool("SaySpark",src)
	WolfFangFist
		icon='WolfFang3.dmi'
		pixel_x=-66
		pixel_y=-66
		layer=MOB_LAYER+5
		unpooled()
			..()
			spawn(1) flick("Attack",src)
			animate(src,alpha=0,time=15)
	//		spawn(10) del src
	SweepingKick
		icon='SweepingKick.dmi'
		pixel_x=-32
		pixel_y=-32
		layer=MOB_LAYER+5
		unpooled()
			..()
			animate(src,transform = matrix()*2,alpha=155,time=8)
	SweepingBlade
		icon='CircleWind.dmi'
		pixel_x=-32
		pixel_y=-32
		layer=MOB_LAYER+5
		unpooled()
			..()
			animate(src,transform = matrix()*2,alpha=155,time=8)
	Slash
		icon='hitovers3.dmi'
		icon_state="1"
		layer=MOB_LAYER+5
		unpooled()
			..()
			icon_state="[rand(1,2)]"
			pixel_x=rand(-4,4)
			pixel_y=rand(-4,4)
			animate(src, transform = turn(matrix(), pick(45,-45,0,-90,90,135.-135,180)),time=0)
			//animate(src,transform = matrix()*1.5,time=5)
	HitEffect2
		icon='HitEffectCollection.dmi'
		layer=MOB_LAYER+5
		unpooled()
			..()
			pixel_x=rand(-4,4)
			pixel_y=rand(-4,4)
			icon_state="[rand(1,12)]"
			animate(src, transform = turn(matrix(), pick(45,-45,0,-90,90,135.-135,180)),time=0)
	BlockEffect
		icon='HitEffectCollection.dmi'
		icon_state="parry"
		layer=MOB_LAYER+5
		unpooled()
			..()
			pixel_x=rand(-4,4)
			pixel_y=rand(-4,4)
			animate(src, transform = turn(matrix(), pick(45,-45,0,-90,90,135.-135,180)),time=0)
	ShockwaveScaler
		icon='Impact.dmi'
		icon_state = "shock"
		layer=MOB_LAYER+5
		unpooled()
			..()
			animate(src, transform = matrix()*0.1, time=0)
		New()
			..()
			animate(src, transform = matrix()*0.1, time=0)
	Ki_Hit
		icon='fevExplosion.dmi'
		icon_state="kihit1"
		pixel_x=-32
		pixel_y=-32
		layer=MOB_LAYER+5
		unpooled()
			..()
			pixel_x=rand(-40,-24)
			pixel_y=rand(-40,-24)
			icon_state="kihit[rand(1,3)]"
			animate(src, transform = matrix()*0.5,time=0)
			animate(src,alpha=0,time=6)
		New()
			..()
			animate(src, transform = matrix()*0.5,time=0)
	SlashUser
		icon='SlashV2.dmi'
		pixel_x=-16
		pixel_y=-16
		layer=MOB_LAYER+5
		unpooled()
			..()
			animate(src,transform = matrix()*1.8,alpha=155,time=8)
	StabUser
		icon='StabV2.dmi'
		pixel_x=-16
		pixel_y=-16
		layer=MOB_LAYER+5
		unpooled()
			..()
			animate(src,transform = matrix()*1.8,alpha=155,time=8)
	ImpactDust
		icon='ImpactB1.dmi'
		icon_state = "1"
		layer=MOB_LAYER+5
		pixel_x=-44
		pixel_y=-18
		unpooled()
			..()
			icon_state = pick("1","2")
	UppercutUser
		icon='UppercutEffect.dmi'
		pixel_x=-32
		pixel_y=-64
		layer=MOB_LAYER+5
		unpooled()
			..()
			animate(src,transform = matrix()*1.8,alpha=155,time=8)
	VerticalDust
		icon='SlashDust.dmi'
		pixel_x=-64
		pixel_y=-96
		layer=MOB_LAYER+5
		unpooled()
			..()
			animate(src,transform = matrix()*1.8,alpha=155,time=8)
	HeadBlood
		icon='ExplodedHead.dmi'
		layer=MOB_LAYER-1
		unpooled()
			..()
			animate(src, alpha = 0, time = 400)
	BloodTrail
		icon='Bloodspray.dmi'
		icon_state="1"
		layer=MOB_LAYER-1
		pixel_x=-32
		pixel_y=-32
		unpooled()
			..()
			icon_state="[rand(1,16)]"
			pixel_x=rand(-40,-24)
			pixel_y=rand(-40,-24)
			animate(src, transform = turn(matrix(), pick(45,-45,0,-90,90,135.-135,180)),time=0)
			animate(src, alpha = 0, time = 400)
	OilTrail
		icon='Oilleak1.dmi'
		icon_state="1"
		layer=MOB_LAYER-1
		unpooled()
			..()
			icon_state="[rand(1,3)]"
			pixel_x=rand(-8,8)
			pixel_y=rand(-8,8)
			animate(src, transform = turn(matrix(), pick(45,-45,0,-90,90,135.-135,180)),time=0)
			animate(src, alpha = 0, time = 400)
	Crater
		icon='Crater2stretch2019.png'
		layer=MOB_LAYER-1
		pixel_x=-152
		pixel_y=-75
		unpooled()
			..()
			if(prob(50))
				icon='Kikohocrater.dmi'
				pixel_x=-42
				pixel_y=-42
			else
				icon='Crater2stretch2019.png'
				pixel_x=-152
				pixel_y=-75
			animate(src, transform = matrix()*0.3, time=0)
			animate(src, transform = matrix()*(rand(50,100)/100), time=1)
			animate(src, alpha = 0, time = 400)
	SmallCrater
		icon='Craters.dmi'
		icon_state="small crater"
		layer=MOB_LAYER-1
		unpooled()
			..()
			animate(src, alpha = 0, time = 400)
	dustcloud//1280 720
		icon='dustcloud2018.png'
		pixel_x=-610
		pixel_y=-330
		layer=MOB_LAYER
		unpooled()
			..()
			if(prob(60))
				icon='DamagedGround.dmi'
				icon_state=null
				pixel_x=rand(-8,8)
				pixel_y=rand(-8,8)
				if(prob(50))icon_state="1"
			else
				icon='dustcloud2018.png'
				icon_state=null
				pixel_x=-610
				pixel_y=-330
			animate(src, transform = matrix()*0.1, time=0)
			animate(src,transform = matrix()*0.7,pixel_x+=rand(-32,32),pixel_y+=rand(-32,32), alpha = 50, time = 15)
		New()
			..()
			animate(src, transform = matrix()*0.1, time=0)
	dustcloudOrigin//1280 720
		icon='SwirlingSmokeEffect.dmi'
		pixel_x=-112
		pixel_y=-112
		layer=MOB_LAYER
		unpooled()
			..()
			pixel_x=-112
			pixel_y=-112
			animate(src, transform = matrix()*0.2, time=0)
			animate(src,transform = matrix()*1,pixel_x+=rand(-32,32),pixel_y+=rand(-32,32), alpha = 50, time = 15)
	largedust
		icon='largedust.dmi'
		pixel_x=-92
		pixel_y=-20
		layer=MOB_LAYER
		unpooled()
			..()
			animate(src, alpha = 0, time = 15)
	smalldust
		icon='KikohoDust.dmi'
		icon_state="1"
		pixel_x=-42
		pixel_y=-4
		layer=MOB_LAYER
		unpooled()
			..()
			icon_state=pick("1","2","3")
	bigshockwave
		icon='Shockwave2016.png'
		pixel_x=-160
		pixel_y=-128
		layer=MOB_LAYER+1
		unpooled()
			..()
			if(prob(50))
				icon='KenShockwave.dmi'
				pixel_x=-120
				pixel_y=-120
			else
				icon='Shockwave2016.png'
				pixel_x=-160
				pixel_y=-128
			animate(src, transform = matrix()*0.1, time=0)
			animate(src,transform = matrix()*1.5, alpha = 0, time = 15)
		New()
			..()
			animate(src, transform = matrix()*0.1, time=0)
	explosion
		icon='Explosion Collection.dmi'
		layer=MOB_LAYER+10
		icon_state="1"
		pixel_x=-16
		pixel_y=-16
		unpooled()
			..()
			icon_state="[rand(1,7)]"
			animate(src, transform = matrix()*0.5, time=0)
			animate(src, transform = matrix()*1.5, alpha = 0, time = 8)
	explosioncenter
		icon='Explosion1.dmi'
		layer=MOB_LAYER+10
		pixel_x=-102
		pixel_y=-90
		unpooled()
			..()
			animate(src, alpha = 0, time = 5)

	DrownWaterOver
		icon = 'WaterCreation.dmi'
		pixel_x=-32
		pixel_y=-32
		unpooled()
			..()
			animate(src, transform = matrix()*0.5, time=0)
			animate(src, transform = matrix()*1.5, alpha = 0, time = 8)

	ZanzoDust
		icon = 'Floor Effect.dmi'
		unpooled()
			..()
			animate(src, transform = matrix()*2, alpha = 0, time = 8)
	IceyGrip
		icon = 'IceyGrip.dmi'
		unpooled()
			..()
			animate(src, transform = matrix()*1.5, alpha = 0, time = 5)
	Ash
		icon = 'fx.dmi'
		icon_state="ash"
		unpooled()
			..()
			animate(src, alpha = 0, time = 400)
	KBHole1
		icon='KBTrail.dmi'
		pixel_x=-32
		pixel_y=-32
		layer=MOB_LAYER-2
		unpooled()
			..()
			icon_state=null
			animate(src, alpha = 0, time = 400)
	KBHole2
		icon='KB 1b.dmi'
		layer=MOB_LAYER-2
		pixel_x=-28
		pixel_y=-28
		unpooled()
			..()
			icon_state=null
			animate(src, alpha = 0, time = 400)
	Smoke
		icon = 'smoke.dmi'
		icon_state = "1"
		layer = MOB_LAYER+100
		unpooled()
			..()
			Smokes += 1
			icon_state = "[rand(1,3)]"
			animate(src, transform = matrix()*0.25)
			animate(src, transform = matrix()*1.5, alpha = 0, time = 60)
			src.Smoke()
		pooled()
			..()
			Smokes -= 1
		proc/Smoke()
			src.dir = NORTH
			step_rand(src)
			spawn(5) if(InUse) src.Smoke()
	FightingDirt
		icon = 'DirtPatchOverlays.dmi'
		icon_state="1"
		layer=MOB_LAYER-2
		unpooled()
			..()
			icon_state = "[rand(1,10)]"
			pixel_x=rand(-10,10)
			pixel_y=rand(-10,10)
			animate(src, transform = turn(matrix(), pick(45,-45,0,-90,90,135.-135,180)),time=0)
			animate(src, alpha = 0, time = 400)


atom/proc/BreakOverlay()
	set waitfor=0
	overlays+='WallDamage.dmi'
	sleep(rand(300,600))
	overlays-='WallDamage.dmi'

atom/proc/HitOverlay(var/SparkType,var/mob/C=null)
	if(SparkType=="sharp") Slash(src)
	else if(SparkType=="energy") KiHitEffect(src,C)
	else HitEffect2(src)
	if(prob(40)) ImpactDust(src,get_dir(C.loc,src))
/*
mob/proc/TransOutline()
	filters += filter(type = "outline", size = 0.1, color="#FFFFFF")
	spawn(30)filters -= filter(type = "outline", size = 0.1, color="#FFFFFF")
*/

atom
	var/obj/Shadow
proc
	Shadow_Chase(atom/movable/a)if(a)//Made to clean up the code a bit
		if(a.Shadow)
			a.Shadow.loc=a.loc
			a.Shadow.dir=a.dir
			a.Shadow.icon_state=a.icon_state
			a.Shadow.invisibility=a.invisibility
	Create_Shadow(atom/movable/a,Pixel=0)
		if(a.Shadow)
			Shadow_Chase(a)
		else
			var/obj/Shadow/s=new
			a.Shadow=s
			s.pixel_z=-8
			s.icon=a.icon
			var/matrix/M=matrix()
			M.Scale(1,0.5)
			animate(s,transform=M)
			s.icon-=rgb(1000,1000,1000,200)
			//s.icon:Scale(s.icon:Width(),s.icon:Height()/2)
			a.Shadow.loc=a.loc

			a.Shadow.pixel_x=a.pixel_x
			a.Shadow.pixel_y=a.pixel_y

			a.Shadow.step_x=a.step_x
			a.Shadow.step_y=a.step_y
			a.Shadow.dir=a.dir
			a.Shadow.icon_state=a.icon_state
			s.invisibility=a.invisibility
obj/Shadow
	//Grabbable=0

proc
	RemoveShadow(mob/m)
		if(m.Shadow)
			del m.Shadow
	Flight(mob/m) //Handles Shadow Transformations and player flight 'bobbing'
		sleep(1)
		ASSERT(m)
		if(ismob(m))
			if(m.Flying)
				if(!m.Shadow) Create_Shadow(m)
				animate(m,pixel_z=12,time=3)
				var/matrix/State1=matrix()
				State1.Scale(0.85,0.425)
				if(m.Shadow) animate(m.Shadow,alpha=190,transform=State1,time=3)
				spawn(5)
					var/matrix/State2=matrix()
					State2.Scale(0.95,0.475)
					animate(m,pixel_z=9,time=3)
					if(m.Shadow) animate(m.Shadow,alpha=216,transform=State2,time=3)
					spawn(4)
						Flight(m)
						Shadow_Chase(m)
			else
				animate(m,pixel_z=0,time=3)
				if(m.Shadow)
					var/matrix/LandingState=matrix()
					LandingState.Scale(1,0.5)
					animate(m.Shadow,alpha=255,transform=LandingState,time=3)
					spawn(3) RemoveShadow(m)



/*#define WAVE_COUNT 7
turf/proc/WaterEffect()
	var/start = filters.len
	var/X,Y,rsq,i,f
	for(i=1, i<=WAVE_COUNT, ++i) // choose a wave with a random direction and a period between 10 and 30 pixels
		do
			X = 60*rand() - 30
			Y = 60*rand() - 30
			rsq = X*X + Y*Y
		while(rsq<100 || rsq>900) // keep distortion small, from 0.5 to 3 pixels // choose a random phase
		filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
	for(i=1, i<=WAVE_COUNT, ++i) // animate phase of each wave from its original phase to phase-1 and then reset; // this moves the wave forward in the X,Y direction
	f = filters[start+i]
	animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
	animate(offset=f:offset-1, time=rand()*20+10)
	spawn(10) .()


mob/verb/SpeSay(msg as text)
	new /obj/speech_bubble(usr,msg)
obj/speech_bubble/New(newloc, msg)
    icon = 'bubble.dmi'

    var/obj/O = new
    O.maptext = msg
    O.maptext_width = width
    O.maptext_height = height
    overlays = O

    // start below final position and jump into place
    pixel_z = -100
    alpha = 0
    animate(src, pixel_z = 0, alpha = 255, time = 10, easing = ELASTIC_EASING)

	*/
/*mob/verb/ftest()
	usr.filters += filter(type="drop_shadow",x=-4,y=2)*/
/*mob/verb/ttest()
	for(var/turf/T in view(5)) T.WaterEffect()*/
/*
mob/verb/SpinT()
    var/matrix/M = matrix()
    M.Scale(-1, 1)  // flip horizontally
    animate(src, transform = M, time = 5, loop = 5, easing = SINE_EASING)
    animate(transform = null, time = 5, easing = SINE_EASING)*/

mob/var/tmp/InQuake=0
mob/proc/Quake_Effect(duration)
	if(InQuake) return
	if(!src.client)return
	InQuake=1
	spawn(1)
		var/oldeye=src.client.eye
		var/x
		for(x=0;x<duration,x++)
			src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
			sleep(1)
		src.client.eye=oldeye
		InQuake=0


