Skill/Attacks/GuideBomb
	Tier=2
	UB1="Channel"
	Experience=5
//	Fatal=0
	icon='17.dmi'
	desc="This makes a very powerful guided bomb of energy that explodes on contact. If you can get it \
	to actually hit someone it is a very nice attack. It will move faster and faster as you master it."
	//var/Sokidan_Delay=50
	verb/Guide_Bomb()
		set category="Skills"
		if(usr.RPMode) return
		if(Using)
			for(var/obj/ranged/Blast/AA in range(20,usr)) if(AA.Sokidan&&AA.Belongs_To==usr) del(AA)
			Using=0
			for(var/mob/M in range(20,usr)) M.CombatOut("[usr] detonates their [src]!")
			return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<50) return
		if(!usr.CanAttack(100,src)) return
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
		CDTick(usr)
		Using=1
		usr.attacking=3
		var/Delay = usr.Refire
		spawn(Delay) usr.attacking=0
		//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-100)
		usr.DrainKi(src, 1, 100,show=1)
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.name=src.name
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.Sokidan=1
		A.icon=icon
		A.loc=get_step(usr,NORTH)
		A.Explosive=1
		A.Shockwave=1
		A.Piercer=0
		A.maxSteps=100
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")

//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=7.5*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
		A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off
		Delay =  200/ Experience
		sleep(Delay)
		if(A)
			A.density=0
			flick("Blast",usr)
			spawn(20) if(usr)
				usr.attacking=0
				Using=0
			while(A.z&&usr)
				Using=1
				step(A,usr.dir)
				if(A) A.density=1
				sleep((100/Experience)+pick(0,0,1))
			Using=0
		Using=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")


