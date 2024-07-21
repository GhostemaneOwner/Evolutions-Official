





Skill/Unarmed/PileDriver
	UB1="High Tension"
	desc="This move requires you to have the opponent grabbed. Deals 2x the damage of a regular attack. Always hits."
	Experience=100
	Tier=3
	verb/Pile_Driver()
		set category="Skills"
		if(usr.RPMode) return
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.WeaponCheck())
			usr<<"You must be unarmed to use this skill."
			return
		if(!usr.GrabbedMob) usr.Grab()
		CDTick(usr)
		if(usr.GrabbedMob&&usr.GrabbedMob in view(usr)) if(ismob(usr.GrabbedMob))
			if(!usr.attacking)
				//usr.DrainKi(src,"Percent",15)
				usr.DrainKi(src, 1, 150,show=1)
				var/mob/B
				B=usr.GrabbedMob
				usr.isGrabbing=1 //Check if failure occurs
				B.grabberSTR=usr.Str*usr.BP
				B.InFullNelson=1
				spawn usr.fullnelson()
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")

mob/var/tmp/InFullNelson=0
mob/proc/fullnelson()
	if(GrabbedMob && isGrabbing)
		GrabbedMob.loc = loc
		if(!GrabbedMob.InFullNelson)
			if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
			src.GrabbedMob = null
			src.isGrabbing = null
			return
		if(ismob(GrabbedMob))
			GrabbedMob.grabberSTR=Str*BP
			GrabbedMob.dir=turn(dir,180)
		if(KOd)
			view()<<"[usr] is forced to release [GrabbedMob]!"
			if(ismob(GrabbedMob)) GrabbedMob.grabberSTR=null
			attacking=0
			src.isGrabbing=null
		else if(!GrabbedMob.KOd)
			var/Damage=DamageFormula(src,GrabbedMob,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=4,FlatDamage=1.5,UsesWeapon=0,IgnoresEnd=0)
			animate(GrabbedMob, transform = turn(matrix(), 180), time = 2)

			GrabbedMob.TakeDamage(src, Damage, "Pile Driver")
			GrabbedMob.Injure_Hurt(rand(15,25)/10*Damage,"Head",src)
			GrabbedMob.InFullNelson--
			spawn(2)
				animate(GrabbedMob, transform = null)
				GrabbedMob.grabberSTR=null
				src.GrabbedMob = null
				src.isGrabbing = null
