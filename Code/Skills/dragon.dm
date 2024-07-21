Skill/Attacks/Dragon_Nova
	Tier=4
	UB1="Channel"
//	Fatal=1
	icon='16.dmi'
	desc="A giant charged energy ball. It is very powerful, and very explosive. It is very similar to \
	TriBeam but does not drain health, and due to that, it is a bit weaker, but still much stronger \
	than charge. It is quite a good finishing attack."
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		if(A.Rank)
			usr<<"You may not teach them this."
			return
		if(!usr.Rank)
			usr<<"You must be a Rank in order to teach this move."
			return
		Teachify(usr,A,"Ki")
	verb/Dragon_Nova()
		set category="Skills"
		if(usr.RPMode) return
		if((usr.icon_state in list("Meditate","Train","KO"))||usr.Frozen) return
		if(usr.attacking|usr.Ki<100) return
		if(!usr.CanAttack(200,src)) return
		if(Experience<100) Experience+=rand(8,13)
		if(Experience>100) Experience=100
		CDTick(usr)
		usr.DrainKi(src, 1, 200,show=1)//usr.DrainKi(src,"Percent",20)//usr.Ki=max(0,usr.Ki-300)
		usr.attacking=3
		charging=1
		var/image/ChargeOver = image(usr.BlastCharge,layer=EFFECTS_LAYER+10)
		usr.overlays+=ChargeOver
		for(var/mob/M in range(20,usr)) M.CombatOut("[usr] begins to charge a [src]!")
		sleep((usr.Refire)/(max(1,Experience/25)))
		usr.overlays-=ChargeOver
		var/obj/ranged/Blast/A=unpool("Blasts")
		A.Belongs_To=usr
		A.icon=icon
		A.Explosive=1
		A.density=1
		A.Radius=1
		A.name=src.name
		var/MaskDamage=0
		if(usr.MaskOn) for(var/obj/items/Magic_Mask/MM in usr) if(MM.suffix&&MM.Durability>0)
			MaskDamage=MM.Health
			MM.DurabilityCheck(usr)
			break
		if(MaskDamage>usr.BP*0.33)MaskDamage=usr.BP*0.33
		A.Damage=12*(usr.BP+MaskDamage)*usr.Pow*Ki_Power
		A.Power=(usr.BP+MaskDamage)*Ki_Power
		A.Offense=usr.Off
		A.loc=usr.loc
		walk(A,usr.dir,1)
		usr.attacking=0
		charging=0
		
