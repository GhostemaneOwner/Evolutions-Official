

Skill/Technology/Energy_Infusion
	desc="This will grant someone +25% of their Ki reserves in one quick burst."
	var/LastUse=0
	verb/Energy_Infusion()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.KOd) return
		if(!usr.CanAttack(1,src)) return
		if(LastUse+0.5>WipeDay)
			usr<<"You must wait until day [LastUse+0.5] to use this again."
			return
		for(var/mob/M in get_step(usr,usr.dir)) if(M.client)
			var/Cost = 1000000
			var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
			usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
			if(usr.Confirm("Cast Energy Infusion on [M] for [Commas(Actual)]?"))
				for(var/obj/Resources/RR in usr)
					if(RR.Value > Actual)
						if(usr.Confirm("Use Energy Infusion on [M]?"))
							RR.Value-=Actual
							M.Ki+=M.MaxKi*0.25
							LastUse=WipeDay
							view(usr)<<"<font color=#FFFF00>[usr] uses [src] on [M]"
					else
						usr << "You do not have [Commas(Actual)] resources to spare in order to use the Energy Infusion."
						return
			break
Skill/Technology/Nanite_Burst
	CDOverride=45
	desc="This will heal team mates within a 3 tile radius by +15 Health."
	verb/Nanite_Burst()
		set category="Skills"
		if(usr.RPMode) return
		if(usr.KOd) return
		if(!usr.CanAttack(10,src)) return
		var/Cost = 3000000
		var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
		usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
		if(usr.Confirm("Cast Nanite Burst for [Commas(Actual)].")&&usr.CanAttack(10,src))
			for(var/obj/Resources/M in usr)
				if(M.Value > Actual)
					M.Value-=Actual
					for(var/mob/A in view(usr,3)) if(A.Team==usr.Team)
						if(A.Willpower<=0) A.WillpowerRestore()
						if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower++
						if(A.KOd) A.Un_KO()
						A.Health += 15
						if(A.Health>A.Willpower) A.Health=A.Willpower
						for(var/BodyPart/P in A)
							if(usr.Magic_Level>70)  if(P.Health<=P.MaxHealth) A.Injure_Heal(25,P,1)
							else  if(P.Health<=P.MaxHealth) A.Injure_Heal(20,P)
						A.Heal_Zenkai()
						view(usr)<<"<font color=#FFFF00>[usr] uses their nanites to heal [A]"
					CDTick(usr)
				else
					usr << "You do not have [Commas(Actual)] resources to spare in order to use the Nanite Burst."
					return




obj/items/HealingPylon
	desc="This will emit a healing burst once every minute."
	Health=1500
	density=1
	Savable=1
	Grabbable=0
	Grabbable = 1
	pixel_x=-66
	Bolted = 1
	layer = 2
	icon='Orb_of_Conquests-1.dmi'
	var/HealLoop=0
	verb/Activate()
		set src in view(1)
		if(!HealLoop)
			HealLoop=1
			HealingBurst()
			view(usr)<<"[src] activated."
	verb/Deactivate()
		set src in view(1)
		if(HealLoop)
			HealLoop=0
			view(usr)<<"[src] deactivated."
	proc/HealingBurst() while(HealLoop)
		view(src)<<"<font color=#FFFF00>[src] emits a healing burst."
		animate(src, icon_state="Capturing", time = 20)
		for(var/mob/A in view(src,5)) if(A.client)
			if(A.Willpower<=0) A.WillpowerRestore()
			if(A.Willpower<A.MaxWillpower&&A.Willpower>0) A.Willpower++
			if(A.KOd) A.Un_KO()
			A.Health += 2
			A.overlays+='Nanites.dmi'
			spawn(5) A.overlays-='Nanites.dmi'
			A.BuffOut("The [src] heals you.")
			if(A.Health>A.Willpower) A.Health=A.Willpower
			for(var/BodyPart/P in A)
				if(usr.Magic_Level>70)  if(P.Health<=P.MaxHealth) A.Injure_Heal(2.5,P,1)
				else  if(P.Health<=P.MaxHealth) A.Injure_Heal(2,P)
			A.Heal_Zenkai()
		animate(src, icon_state="", time = 0)
		sleep(600)




Skill/Technology/Stungun
	CDOverride=45
	Experience=100
	desc="Stun your opponent with a burst of electric shock. This will stun them for 3 ticks if it lands."
	verb/Stungun()
		set category="Skills"
		if(!usr.CanAttack(usr.MaxKi*0.05,src)) return
		if(usr.Ki<75) return


		for(var/mob/M in get_step(usr,usr.dir)) if(!M.adminDensity&&M.attackable&&usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.KOd==0)
			var/Cost = 1000000
			var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
			usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."
			if(!usr.attacking) if(M.afk == 0&&!M.RPMode)

				for(var/obj/Resources/RR in usr)
					if(RR.Value > Actual)
						flick("Attack",usr)
						CDTick(usr)
						//usr.DrainKi(src,"Percent",7.5)//usr.Ki=max(0,usr.Ki-rand(50,75))
						usr.DrainKi(src, 1, 75,show=1)
						RR.Value-=Actual


						var/Evasion=AccuracyFormula(usr,M,KiManip=0,Chance=65)
						var/Damage=DamageFormula(usr,M,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=1.5,UsesWeapon=0,IgnoresEnd=0)
		//				var/didBlock=0
						if((M.KOd==0&&M.client))
							flick("Attack",usr)
							if(M.attacking==1) usr.Opp(M)
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
		//							hearers(6,M) << pick('Melee_Dodge1.wav','Melee_Dodge2.wav','Melee_Dodge3.wav')
								//Stun(usr,0.5)
								M.CombatOut("You dodge [usr].")
								usr.CombatOut("[M] dodges you.")
							else //Successful hit
								if(!prob(Evasion))
									ShockwaveScale(M,usr.BP,1)
									Damage = Damage * 0.5
		//								hearers(6,M)<<pick('Melee_Block1.wav','Melee_Block2.wav')
		//							didBlock=1
								if(prob(25))
									ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",M.loc)
								M.KB=round(Damage*0.5)
								if(M.KB>5) M.KB=5
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								spawn() M.KnockBack(usr)
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(usr, Damage, "[src]")
									Stun(M,3)
									M.BuffOut("[usr] stuns [M] with their [src].")
									usr.BuffOut("[usr] stuns [M] with their [src].")
									ImpactDust(M,usr.dir)//ShockwaveIcon(null,"Impact",usr.loc)
						else
							flick("Attack",usr)
							if(!isnum(M.Life)) return
		//						M.BPDamage(usr,Damage,3)
							M.Life-=3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End))
							//usr.CombatOut("You attack [M]. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//M.CombatOut("[usr] attacks you. ([round(3*((usr.BP*usr.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							M.KB=round((usr.Str/M.End)*5)
							if(M.KB>5) M.KB=5
							M.KnockBack(usr)
							//if(M&&M.Life<=0) M.Death(usr)


					else
						usr << "You do not have [Commas(Actual)] resources to spare in order to use the [src]."
						return
			break

