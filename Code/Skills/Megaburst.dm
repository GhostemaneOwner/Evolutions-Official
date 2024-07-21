


Skill/Attacks/MegaBurst
	UB1="Arcane Power"
	UB2="Channel"
	Tier=3
	Experience=1
	icon='Ki MegaBurst.dmi'
	desc="This attack packs huge single hit power, but takes a while to charge and is easy to dodge, it is very big though and very draining."
	New()
		icon+=rgb(rand(0,225),rand(0,225),rand(0,225))
		..()
	verb/Mega_Burst()
		set category="Skills"
		if(usr.Ki<500) return
		if(!usr.CanAttack(usr.MaxKi*0.1,src)) return
		if(Experience<100) Experience+=rand(2,6)
		if(Experience>100) Experience=100
		CDTick(usr)
		usr.attacking=3
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		charging=1
		var/Delay = usr.Refire * 2.4
		Delay += 500 / Experience
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
		sleep(Delay)
		//usr.DrainKi(src,"Percent",30)//usr.Ki=max(0,usr.Ki-500)
		usr.DrainKi(src, 1, 300,show=1)
		usr.Frozen=1
		spawn(Delay/2)
			usr.attacking=0
			usr.Frozen=0
//		hearers(6,usr) << 'Charge_Fire.wav'
		usr.overlays-=ChargeOver
		charging=0
		var/MasterIcon=icon
		var/amount=50
		var/distance=10
		flick("Blast",usr)
		if(usr.KOd==0&&!usr.KB)
			while(amount)
				var/obj/ranged/Blast/A=unpool("Blasts")
				A.Belongs_To=usr
				A.name=src.name
				var/MaskDamage=0
				if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
					MaskDamage=MM.Health
					MM.DurabilityCheck(usr)
					break
				if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
				A.Damage=14*(usr.BP+MaskDamage)*usr.Pow*Ki_Power  //200
				A.Power=(usr.BP+MaskDamage)*Ki_Power
				A.DoNotTrack=1
				A.Offense=usr.Off
				A.layer=MOB_LAYER+10
				A.icon=MasterIcon
				A.icon_state="center"
				A.density=0
				//positioning / appearance
				A.loc=locate(usr.x,usr.y,usr.z)
				if(amount<=40&&amount>30)
					A.icon_state="outer1" //Middle Right
					if(usr.dir==NORTH) A.x+=1
					if(usr.dir==SOUTH) A.x-=1
					if(usr.dir==EAST) A.y-=1
					if(usr.dir==WEST) A.y+=1
					if(usr.dir==NORTHWEST)
						A.x+=1
						A.y+=1
					if(usr.dir==SOUTHWEST)
						A.x-=1
						A.y+=1
					if(usr.dir==NORTHEAST)
						A.x+=1
						A.y-=1
					if(usr.dir==SOUTHEAST)
						A.x-=1
						A.y-=1
					if(amount==40) A.icon_state="outer1head"
					else if(amount==31)
						A.icon=turn(A.icon,180)
						A.icon_state="outer1origin"
				else if(amount<=30&&amount>20)
					A.icon_state="outer2" //Outer Right
					if(usr.dir==NORTH) A.x+=2
					if(usr.dir==SOUTH) A.x-=2
					if(usr.dir==EAST) A.y-=2
					if(usr.dir==WEST) A.y+=2
					if(usr.dir==NORTHWEST)
						A.x+=2
						A.y+=1
					if(usr.dir==SOUTHWEST)
						A.x-=2
						A.y+=1
					if(usr.dir==NORTHEAST)
						A.x+=2
						A.y-=1
					if(usr.dir==SOUTHEAST)
						A.x-=2
						A.y-=1
					if(amount==30) A.icon_state="outer2head"
					else if(amount==21)
						A.icon=turn(A.icon,180)
						A.icon_state="outer2origin"
				else if(amount<=20&&amount>10)
					A.icon_state="outer1" //Middle Left
					if(usr.dir==NORTH) A.x-=1
					if(usr.dir==SOUTH) A.x+=1
					if(usr.dir==EAST) A.y+=1
					if(usr.dir==WEST) A.y-=1
					if(usr.dir==NORTHWEST)
						A.x-=1
						A.y-=1
					if(usr.dir==SOUTHWEST)
						A.x+=1
						A.y-=1
					if(usr.dir==NORTHEAST)
						A.x-=1
						A.y+=1
					if(usr.dir==SOUTHEAST)
						A.x+=1
						A.y+=1
					if(amount==20) A.icon_state="outer3head"
					else if(amount==11)
						A.icon=turn(A.icon,180)
						A.icon_state="outer3origin"
				else if(amount<=10)
					A.icon_state="outer2" //Outer Left
					if(usr.dir==NORTH) A.x-=2
					if(usr.dir==SOUTH) A.x+=2
					if(usr.dir==EAST) A.y+=2
					if(usr.dir==WEST) A.y-=2
					if(usr.dir==NORTHWEST)
						A.x-=2
						A.y-=1
					if(usr.dir==SOUTHWEST)
						A.x+=2
						A.y-=1
					if(usr.dir==NORTHEAST)
						A.x-=2
						A.y+=1
					if(usr.dir==SOUTHEAST)
						A.x+=2
						A.y+=1
					if(amount==10) A.icon_state="outer4head"
					else if(amount==1)
						A.icon=turn(A.icon,180)
						A.icon_state="outer4origin"
				//---
				spawn(50) if(A) del(A)
				var/distance2=distance-1
				while(distance&&A)
					step(A,usr.dir)
					if(amount==50&&A) A.icon_state="centerorigin"
					else if(amount==41&&A)
						A.icon=turn(A.icon,180)
						A.icon_state="centerorigin"
					distance-=1
				distance=distance2
				if(!distance) distance=10
				amount-=1
				for(var/mob/M in view(0,A)) if(M!=usr) if(!M.afk)
					var/Damage=(usr.Pow*(usr.BP))/(M.End*M.BP)*14
					M.TakeDamage(usr, Damage, "[src]")
			spawn(60/usr.SpdMod) usr.Frozen=0
		spawn(80/usr.SpdMod) usr.attacking=0
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")

