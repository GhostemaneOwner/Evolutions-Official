


var/TotalNPCs=0
//mob/var/Grabbable

var/list/NPCSpawnerList=list()

obj/NPCSpawner
	Grabbable=0
	Health=1.#INF
	Savable = 1
	New()
		..()
		NPCSpawnerList+=src
	proc/SpawnNPC()
		var/howMany=rand(50,100)
		while(howMany)
			var/mob/NewNPC=pick(typesof(/mob/NPC) - /mob/NPC - /mob/NPC/Peaceful - /mob/NPC/Predators)
			new NewNPC
			NewNPC.loc=src.loc
			TotalNPCs++
			howMany--

proc/SpawnNPCs()
	set waitfor=0
	for(var/obj/NPCSpawner/N in NPCSpawnerList)
		N.SpawnNPC()
		sleep(-1)


mob/NPC/proc/AI() if(!AICycle)
	set background =1
	set waitfor=0
	AICycle=1
	Base=NPCBaseMod*200
	BP=Base
	Str=300*NPCSkill
	End=300*NPCSkill
	SpdMod=3
	Spd=300*NPCSkill
	Pow=300*NPCSkill
	Off=300*NPCSkill
	Def=100*NPCSkill
	if(HostileNPC)
		Base=NPCBaseMod*TrueBPCap
		BP=Base
		Str=SoftStatCap*NPCSkill
		End=SoftStatCap*NPCSkill
		SpdMod=4
		Spd=SoftStatCap*NPCSkill
		Def=SoftStatCap*NPCSkill*0.25
		Off=SoftStatCap*NPCSkill
		if(Warp) NPCSpeed=2
	while(src)
		if(Health<=0) KO("?!?!")
		if(Target) TargetCheck()
		icon_state=iconS
		if(!src.KOd) if(!src.KB)
			if(Target)
				for(var/mob/player/MM in get_step(src,dir)) src.MeleeAttack()
				step_towards(src,Target)
				if(prob(10)) step_rand(src)
			else
				if(HostileNPC&&!Target) for(var/mob/player/P in view(src,5))
					Target=P
					break
				else step_rand(src)
		if(Target) sleep(NPCSpeed)
		else sleep(rand(30,150))
/*
proc/GenerateNewNPC(HostileNPC,ZZ)
	set waitfor=0
	if(TotalNPCs>100) return
	if(ZZ>5) return
	sleep(rand(300,600))
	var/spawnNPC
	spoot
	spawnNPC= pick(typesof(/mob/NPC/Predators))
	if(spawnNPC==/mob/NPC||spawnNPC==/mob/NPC/Predators||spawnNPC==/mob/NPC/Peaceful||spawnNPC==/mob/NPC/Predators/Weakest_Version||spawnNPC==/mob/NPC/Predators/Weaker_Version) goto spoot
	var/mob/NPC/NewNPC= new spawnNPC
	switch(ZZ)
		if(1)
			if(EarthNPCs>30)
				del(src)
				return
			EarthNPCs++
			NewNPC.loc=locate(/area/UndergroundMine/Earth)
		if(2) NewNPC.loc=locate(/area/UndergroundMine/Namek)
		if(3)
			if(VegetaNPCs>30)
				del(src)
				return
			VegetaNPCs++
			NewNPC.loc=locate(/area/UndergroundMine/Vegeta)
		if(4) NewNPC.loc=locate(/area/UndergroundMine/Ice)
		if(5)
			if(ArconiaNPCs>30)
				del(src)
				return
			ArconiaNPCs++
			NewNPC.loc=locate(/area/UndergroundMine/Arconia)*/

mob/NPC
	icon='Animals.dmi'
	UnarmedSkill=50000
	Athleticism=50000
	SpdMod=3
	var/AICycle=0
	//luminosity = 1
	var/HostileNPC=0
	var/NPCBaseMod=3
	var/NPCSkill=3
	var/NPCSpeed=10
	var/Drops=0
	var/DropsWool=0
	var/DropsBlood=0
	var/iconS
	New()
		var/Ns=0
		for(var/mob/NPC/N in world) Ns++
		if(Ns>500)
			del(src)
			return
		if(prob(2))
			NPCSkill=5
			NPCBaseMod=5
			NPCSpeed=8
			Drops+=10
			name="Hlinwyrd"
			icon='Hlinwyrd.dmi'
			pixel_x=-16
			pixel_y=-16
			HasSwiftReflexes=4
			contents+=new/Skill/Zanzoken


		if(prob(25))
			NPCSkill*=1.3
			NPCSpeed-=2
			Drops++
			name="Veteran [name]"
			HasDeftHands=rand(2,4)
		if(prob(15))
			NPCBaseMod*=1.3
			NPCSpeed-=2
			Drops++
			name="Elite [name]"
			MaxHealth=150
			Health=150
		if(prob(15))
			NPCSpeed-=4
			Drops++
			name="Rabid [name]"
			Zanzoken=1000
			Warp=1
			contents+=new/Skill/Zanzoken
		if(WipeDay>5)NPCBaseMod++
		if(WipeDay>10)NPCSkill++
		if(WipeDay>15)
			NPCBaseMod+=1.5
			NPCSpeed--
		if(WipeDay>20)NPCSkill++
		if(WipeDay>25)NPCBaseMod++
		if(WipeDay>30)NPCSkill+=1.5
		if(WipeDay>35)NPCBaseMod++
		if(WipeDay>40)NPCSkill++
		if(NPCSpeed<1)NPCSpeed=1
		spawn if(src) AI()
		..()
		iconS=icon_state
	Del()
		if(DropsWool) new/obj/items/Wool(src.loc)
		if(DropsBlood) if(prob(50)) new/obj/items/Blood_Vial(src.loc)
		if(prob(50))
			if(prob(50)) new/obj/Resources/Treasure(src.loc)
			else new/obj/Mana/Mana_Crystal(src.loc)
		if(prob(Drops*10)) new/obj/items/rawfood/Rare_Ingredients(src.loc)
		if(prob(Drops*1.1))
			var/Drop=pick(/obj/items/Ring_Of_Smithing,/obj/items/Anglers_Lure,/obj/items/How_To_Serve_Saiba)
			new Drop(src.loc)
		if(Drops>10&&prob(Drops/2)) new/obj/items/relic/Old_World_Relic(src.loc)
		TotalNPCs--
		..()



	Peaceful
		Bump(mob/A)
			if(Health<100) MeleeAttack()
			..()
		Frog
			icon='Frog.dmi'
		Dino_Bird
			icon_state="DinoBird"
			DropsBlood = 1
		Cat
			icon='Cat.dmi'
			DropsBlood = 1
		Bat
			icon='Bat.dmi'
		Cow
			icon='Cow.dmi'
			DropsBlood = 1
		Turtle
			icon='Turtle.dmi'
		Horse
			icon='Horse.dmi'
			DropsBlood=1
		Sheep
			icon='Sheep.dmi'
			DropsWool = 1
			DropsBlood = 1
		Dog
			icon_state="Dog"
			DropsBlood = 1
		Fly
			icon_state="Fly"
		Del()
			if(prob(70)) new/obj/items/rawfood/Animal_Meat(src.loc)
			..()
	Predators
		NPCBaseMod=3.5
		NPCSkill=3.5
		P_BagG=5
		HostileNPC=1
		//Lethality=1
		Bump(mob/A)
			MeleeAttack()
			..()

		Weakest_Version
			NPCBaseMod=2
			NPCSkill=2
			Robot
				icon_state="Bot1"
			Big_Robot
				icon_state="Bot2"
			Hover_Robot
				icon_state="Bot3"
			Gremlin
				icon_state="Gremlin"
				DropsBlood = 1
			Evil_Entity
				icon_state="EvilMan"
				DropsBlood = 1
			Bandit
				icon_state="Bandit"
				DropsBlood = 1
			Tiger_Bandit
				icon='Tiger.dmi'
				DropsBlood = 1
			Wolf
				icon='Wolf.dmi'
				DropsWool = 1
				DropsBlood = 1

		Weaker_Version
			NPCBaseMod=3
			NPCSkill=3
			Robot
				icon_state="Bot1"
			Big_Robot
				icon_state="Bot2"
			Hover_Robot
				icon_state="Bot3"
			Gremlin
				icon_state="Gremlin"
				DropsBlood = 1
			Evil_Entity
				icon_state="EvilMan"
				DropsBlood = 1
			Bandit
				icon_state="Bandit"
				DropsBlood = 1
			Tiger_Bandit
				icon='Tiger.dmi'
				DropsBlood = 1
			Wolf
				icon='Wolf.dmi'
				DropsWool = 1
				DropsBlood = 1
			Small_Saibaman
				icon_state="SaibamanSmall"

		Hornet
			icon_state="Fly"
			Zanzoken=1000
			Warp=1
			New()
				contents+=new/Skill/Zanzoken
				..()
		Dino_Munky
			icon_state="OozaruDino"
			DropsBlood = 1
		Robot
			icon_state="Bot1"
		Big_Robot
			NPCBaseMod=4
			icon_state="Bot2"
		Hover_Robot
			icon_state="Bot3"
		Gremlin
			icon_state="Gremlin"
			DropsBlood = 1
		Evil_Entity
			NPCBaseMod=4
			icon_state="EvilMan"
			DropsBlood = 1
		Bandit
			icon_state="Bandit"
			DropsBlood = 1
		Tiger_Bandit
			NPCBaseMod=4.5
			icon='Tiger.dmi'
			DropsBlood = 1
		Wolf
			icon='Wolf.dmi'
			DropsWool = 1
			DropsBlood = 1
		Giant_Robot
			NPCBaseMod=3.5
			icon_state="Robot"
		Ice_Dragon
			NPCBaseMod=4
			icon_state="IceDragon"
			DropsBlood = 1
		Ice_Flame
			NPCBaseMod=5
			icon_state="IceFlame"
		Saibaman
			NPCBaseMod=3.5
			icon_state="Saibaman"
		Small_Saibaman
			icon_state="SaibamanSmall"
		Black_Saibaman
			NPCBaseMod=4.5
			icon_state="SaibamanBlack"
		Mutated_Saibaman
			NPCBaseMod=4
			icon_state="SaibamanGreen"
