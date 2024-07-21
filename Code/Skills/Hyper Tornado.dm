


Skill/Attacks/HyperTornado
	UB1="Godspeed"
///	Fatal=1
	Tier=4
	Experience=10
	pixel_x=-32
	pixel_y=-16
	icon='Twister_Aura-2.dmi'
	desc="This attack unleashes several tornados that after a short delay will spin up and then home towards your target. Damage based on Speed."
	verb/Hyper_Tornado()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<300) return
		if(!usr.CanAttack(300,src)) return
		CDTick(usr)
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
		//usr.DrainKi(src,"Percent",20)//usr.Ki=max(0,usr.Ki-300)
		usr.DrainKi(src, 1, 200,show=1)
		usr.attacking=3
		charging=1
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		var/Delay = usr.Refire*3
		Delay += 500 / Experience
		var/amount=1
		if(Experience>=30) amount=2
		if(Experience>=60) amount=3
		if(Experience>=90) amount=4
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
//		hearers(6,usr) << 'Charge_Fire.wav'
		usr.overlays-=ChargeOver
		charging=0
		while(amount)
			var/obj/ranged/Blast/A=unpool("Blasts")
			A.Belongs_To=usr
			A.density=1
			//A.Radius=1
			A.Shockwave=1
			A.name=src.name
			A.pixel_x=pixel_x
			A.pixel_y=pixel_y
			A.icon=icon
			A.Damage=10*usr.BP*usr.Spd*Ki_Power  //200
			A.Power=(usr.BP)*Ki_Power
			A.Offense=usr.Off*1.2
			if(amount==1) A.dir=usr.dir
			if(amount==2) A.dir=turn(usr.dir,90)
			if(amount==3) A.dir=turn(usr.dir,-90)
			if(amount==4) A.dir=turn(usr.dir,180)
			A.loc=get_step(get_step(usr,A.dir),A.dir)
			if(A) walk(A,A.dir,1)
			spawn(4) if(usr.Target) walk_towards(A,usr.Target,1)
			amount-=1
			//spawn(40*(round(Experience/20))) if(A) del(A)
		usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
