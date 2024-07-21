



Skill/Attacks/SuperGhostKamikazeAttack
	UB1="Arcane Power"
	UB2="Shadow King"
	Tier=4
	desc="Makes splitforms of yourself that after a short delay attack your target and deal strength based damage."
	Experience=10
	NoMove=1
	verb/Super_Ghost_Kamikaze_Attack()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<300)
			usr << "You are unable to utilize this attack!"
			return
		if(!usr.Target)
			usr << "You need to have a target!"
			return
		if(!usr.CanAttack(300,src)) return
		CDTick(usr)
		var/mob/B
		if(usr.Target.z==usr.z) B=usr.Target
		else return
		usr.attacking=3
		if(Experience<100) Experience+=rand(6,9)
		if(Experience>100) Experience=100
		var/amount=2+round(Experience/25)
		usr.DrainKi(src, 1, 300*amount,show=1)//usr.DrainKi(src,"Percent",30)//usr.Ki=max(0,usr.Ki-400)
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		spawn() while(usr&&B&&amount)
			if(!amount||usr.KOd||(B.z!=usr.z)) break
			sleep(1)
			if(!amount) break
			usr.attacking=3
			amount-=1
			flick("Blast",usr)
			var/obj/ranged/Blast/SGKA/A=unpool("SGKA")
			A.Belongs_To=usr
			A.density=0
			A.pixel_x=usr.pixel_x
			A.pixel_y=usr.pixel_y
			A.icon=usr.icon
			A.overlays=usr.overlays
			A.underlays=usr.underlays
			A.icon+=rgb(0,0,0,155)
			A.overlays+=rgb(0,0,0,155)
			A.name="Super Ghost Kamikaze"
			A.loc = get_step(usr.loc,pick(usr.dir,turn(usr.dir,-90),turn(usr.dir,90)))
			step(A,usr.dir)
			if(A)
				A.dir=usr.dir
				if(prob(5*(Experience/20))) A.Explosive=1
				A.Shockwave=1
				A.Damage=usr.BP*usr.Str*Ki_Power*5
				A.Power=(usr.BP)*Ki_Power
				A.Offense=usr.Off*1.3
				spawn(12-amount)
					if(A)
						A.density=1
						if(B) walk_towards(A,B,1)
		spawn(usr.Refire*2)usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Melee")

obj/ranged/Blast/SGKA
	Explosive=1
	density=1
	