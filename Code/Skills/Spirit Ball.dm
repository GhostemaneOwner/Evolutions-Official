


Skill/Attacks/SpiritBall
	UB1="Channel"
	UB2="Arcane Power"
	Tier=2
	Experience=5
//	Fatal=0
	icon='17.dmi'
	desc="Very similar to sokidan except it is controlled by clicking the map."
	//var/Sokidan_Delay=50
	verb/Spirit_Ball()
		set category="Skills"
		if(usr.RPMode) return
		if(Using) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(!usr.move|usr.attacking|usr.Ki<100) return
		if(!usr.Target||usr.Target.z!=usr.z)
			usr<<"You must have a target on the same plane."
			return
		if(!usr.CanAttack(100,src)) return
		if(Experience<100) Experience+=rand(4,9)
		if(Experience>100) Experience=100
		CDTick(usr)
		Using=1
		usr.attacking=3
		usr.DrainKi(src, 1, 75,show=1)//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-100)
		var/obj/ranged/Blast/SpiritBall/A=unpool("SpiritBall")
		A.Belongs_To=usr
		A.pixel_x=pixel_x
		A.pixel_y=pixel_y
		A.icon=icon
		A.name=src.name
		A.loc=get_step(usr,usr.dir)
		for(var/mob/M in range(20,usr))
			M.CombatOut("[usr] begins to charge a [src]!")
//		hearers(6,usr) << pick('Charging.wav','Charging2.wav')
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=6.25*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
		A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off
		spawn(usr.Refire*0.5) if(usr) usr.attacking=0
		Using=0
		var/Delay = usr.Refire
		Delay +=  500/ Experience
		sleep(Delay)
		if(A)
	//		A.SpiritBall=1
			flick("Blast",usr)
			walk_towards(A,usr.Target)
		spawn(80*(Experience/20))
			Using=0
			del(A)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A,"Ki")
obj/ranged/Blast/SpiritBall
	Explosive=1
	density=1
