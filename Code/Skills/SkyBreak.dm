


Skill/Attacks/SkyBreak
	UB1="Armament"
//	Fatal=1
	Tier=4
	pixel_x=-32
	icon='blackslash.dmi'
	desc="A massive and wickedly destructive technique that uses a weapon to break the speed of sound and unleash a terrifying blast. Strength based damage, requires a weapon."
	verb/Sky_Break()
		set category="Skills"
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		if(!usr.CanAttack(usr.MaxKi*0.06,src)) return
		if(usr.Ki<200) return
		if(Experience<100) Experience+=rand(2,8)
		if(Experience>100) Experience=100
		usr.DrainKi(src, 1, 200,show=1)//usr.DrainKi(src,"Percent",20)//usr.Ki=max(0,usr.Ki-200)
		CDTick(usr)
		usr.attacking=3
		charging=1
		usr.overlays+='blackflameaura.dmi'
		var/Delay = usr.Refire
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		usr.overlays-='blackflameaura.dmi'
		flick("Blast",usr)
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.Explosive=1
		A.icon=icon
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.dir=usr.dir
		A.loc=usr.loc
		spawn(2)A.Radius=1
		A.Damage=10*usr.BP*usr.Str*Ki_Power
		A.Power=(usr.BP)*Ki_Power
		A.Offense=usr.Off*1.2
		if(Experience>69) A.Explosive=1
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0

	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")


Skill/Attacks/EchoingSlash
//	Fatal=1
	Tier=2
	UB1="Armament"
	icon='BlastKiShuriken.dmi'
	desc="You use your weapon to launch an attack that creates a shockwave.  If the shockwave hits an enemy they will begin to bleed."
	verb/Echoing_Slash()
		set category="Skills"
		if(!usr.WeaponCheck())
			usr<<"A weapon is required for this skill."
			return
		if(!usr.CanAttack(usr.MaxKi*0.1,src)) return
		if(usr.Ki<100) return
		if(Experience<100) Experience+=rand(2,8)
		if(Experience>100) Experience=100
		usr.DrainKi(src, 1, 100,show=1)//usr.DrainKi(src,"Percent",10)//usr.Ki=max(0,usr.Ki-200)
		CDTick(usr)
		usr.attacking=3
		charging=1
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		usr.overlays+='blackflameaura.dmi'
		var/Delay = usr.Refire
		Delay += 100 / Experience
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		//sleep(30/usr.SpdMod)
//		hearers(6,usr) << 'Charge_Fire.wav'
		usr.overlays-='blackflameaura.dmi'
		flick("Blast",usr)
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.icon=icon
		A.name=src.name
		A.ChainTrigger=1
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.dir=usr.dir
		A.loc=usr.loc
		A.Damage=3.5*usr.BP*usr.Str*Ki_Power
		A.Power=(usr.BP)*Ki_Power
		A.Offense=usr.Off*1.3
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Weapon")

