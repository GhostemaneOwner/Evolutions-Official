




mob/proc/Tail_Add()
	Tail_Remove()
	for(var/BodyPart/Tail/O in src)
		var/image/_overlay = image('DSSaiyanTail.dmi') // not sure if the equipped thing is an icon/object so
		_overlay.pixel_x = O.pixel_x
		_overlay.pixel_y = O.pixel_y
		_overlay.layer= 9
		overlays += _overlay


mob/proc/Tail_Remove()
	for(var/BodyPart/Tail/O in src)
		var/image/_overlay = image('DSSaiyanTail.dmi') // not sure if the equipped thing is an icon/object so
		_overlay.pixel_x = O.pixel_x
		_overlay.pixel_y = O.pixel_y
		_overlay.layer= 9
		overlays -= _overlay


mob/proc/Oozaru_Revert(reset=0) if(Oozaru) for(var/BodyPart/Tail/O in src)
	Oozaru=0
	BPMult/=O.BP
	DefMult/=O.Def
	icon=oicon
	pixel_x = O.StoredX
	pixel_y = O.StoredY
	overlays=null
	Oozaru=0
	BuffNumber-=3
	Buffs-="Oozaru"
	overlays.Add(Overlays)
	Overlays.Remove(Overlays)
	HealthBar.pixel_x=0
	EnergyBar.pixel_x=0
	setCooldown("Oozaru",72000)

mob/proc/Oozaru() if(!afk)  if(!Oozaru&&!ssj&&!Werewolf) for(var/BodyPart/Tail/O in src) if(O.Status=="Healthy") if(O.Setting)
	if(getCooldown("Oozaru")>world.time)
		src << "The effect of the moons rays don't seem to do anything for you at the moment, [round((getCooldown("Oozaru")-world.time)/600,0.1)] minutes cooldown remaining!"
		return
	if(Dead) if(!KeepsBody) return
	for(var/obj/items/Power_Armor/A in src) if(A.suffix) src.Eject(A)
	RemoveBuffs()
	if(BuffNumber>0)
		src<<"You are already using too many buffs. (Oozaru counts as 3 buffs)"
		return
	Oozaru=1
	setCooldown("Oozaru",72000)//2
	oicon=icon
	Overlays.Add(overlays)
	overlays.Remove(overlays)
	icon=OozaruIcon//image(icon='Oozaru.dmi')
	O.StoredX=pixel_x
	O.StoredY=pixel_y
	pixel_x = O.OozX
	pixel_y = O.OozY
	HealthBar.pixel_x=-O.OozX
	EnergyBar.pixel_x=-O.OozX
	spawn(10) icon_state=""
	OozaruMastery+=rand(10,20)
	if(OozaruMastery>100) OozaruMastery=100
	BPMult*=O.BP
	DefMult*=O.Def
	BuffNumber+=3
	Buffs+="Oozaru"
	OozaruTimer=OozaruMastery*4.5
	//spawn(4000*(OozaruMastery/50)) if(Oozaru) Oozaru_Revert()
	break

obj/items/Ring_Of_Power
	desc="Possessing this will increase your BP by +10%."
	icon='enchantmenticons.dmi'
	icon_state="RoS"

obj/items/Ring_Of_Experience
	desc="Possessing this will cause you to earn +75 XP once a year."
	icon='enchantmenticons.dmi'
	icon_state="RoA"

mob/proc/Golden() if(!afk) if(!Oozaru) for(var/BodyPart/Tail/O in src) if(O.Status=="Healthy")
	if(Dead) if(!KeepsBody) return
	for(var/obj/items/Power_Armor/A in src) if(A.suffix) src.Eject(A)
	RemoveBuffs()
	if(ssj) if(ssj!=4) if(ssj!=5) Cancel_Transformation()
	if(BuffNumber>0)
		src<<"You are already using too many buffs. (Oozaru counts as 3 buffs)"
		return
	Oozaru_Revert()
	OozaruMastery+=rand(18,32)
	if(OozaruMastery>100) OozaruMastery=100
	Oozaru=1
	setCooldown("Oozaru",72000)//2
	oicon=icon
	Overlays.Add(overlays)
	overlays.Remove(overlays)
	spawn(rand(5,55)) for(var/mob/A in view(20,src))
	//	var/sound/S=sound('Roar.wav')
		A<<S
	var/image/A=image(icon='Oozarou Gold.dmi',icon_state="head",pixel_y=32)
	icon='Oozarou Gold.dmi'
	A.pixel_y=32
	overlays+=A
	BPMult*=O.BP
	BuffNumber+=3
	Buffs+="Oozaru"
	spawn while(src&&Oozaru&&!HasSSj4)
		if(prob(1)) if(SSj3Drain>=300)
			Oozaru_Revert()
			HasSSj4=1
			SSj4()
		sleep(10)
	OozaruTimer=OozaruMastery*3


