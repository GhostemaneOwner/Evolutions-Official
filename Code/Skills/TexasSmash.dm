

mob
	proc
		SmashCheck(var/add=1)
			var/tellthem=0
			if(Smashing<5)tellthem=1
			Smashing+=add
			if(Smashing>50)Smashing=50
			if(Smashing>=5&&tellthem) BuffOut("Your Texas Smash is now ready to fire.")

		TexasSmash()
			if(src.Smashing<1) src.Smashing=1
			if(src.Smashing>49||src.BurningDesireAttacks) for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: <span style='color:#FF0000;'>U</span><span style='color:#FF1717;'>n</span><span style='color:#FF2E2E;'>i</span><span style='color:#FF4545;'>t</span><span style='color:#FF5C5C;'>e</span><span style='color:#FF7373;'>d</span> <span style='color:#FFA2A2;'>S</span><span style='color:#FFB9B9;'>t</span><span style='color:#FFD0D0;'>a</span><span style='color:#FFE7E7;'>t</span><span style='color:#FFFFFF;'>e</span><span style='color:#E7E7FF;'>s</span> <span style='color:#B9B9FF;'>o</span><span style='color:#A2A2FF;'>f</span> <span style='color:#7373FF;'>S</span><span style='color:#5C5CFF;'>m</span><span style='color:#4545FF;'>a</span><span style='color:#2E2EFF;'>s</span><span style='color:#1717FF;'>h</span><span style='color:#0000FF;'>!</span>")
			else for(var/mob/player/teleg in view(src)) teleg.BuffOut("[src]: Texas Smash!")
			if(src.client) usr.DrainKi("Texas Smash", 1, 100,show=1)//src.DrainKi("Texas Smash","Percent",17.5)//src.Ki=max(0,src.Ki-100)
			if(src.Smashing>50)src.Smashing=50
			var/SmashDamage=min(10,max(1,src.Smashing/5))
			src.SmashHole()
			for(var/mob/M in get_step(src,src.dir)) if(!M.adminDensity&&M.attackable)
				if(!src.attacking) if(M.afk == 0&&!M.RPMode) //
					flick("Attack",src)
					var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=70)
					var/Damage=DamageFormula(src,M,Strength=1.5,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=SmashDamage+3,UsesWeapon=0,IgnoresEnd=0)
					if(Experience<100) Experience+=rand(3,6)
					if(Experience>100) Experience=100
					if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
						src.attacking=1
						flick("Attack",src)
						if(M.attacking==1) src.Opp(M)
						if(!prob(Evasion))
							flick(M.CustomZanzokenIcon,M)
							M.CombatOut("You dodge [src].")
							src.CombatOut("[M] dodges you.")
						else //Successful hit
							if(!prob(Evasion))
								ShockwaveScale(M,src.BP,1)
								Damage = Damage * 0.35
							if(prob(75))ImpactDust(M,src.dir)//ShockwaveIcon(null,"Impact",M.loc)
							ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
							if(M)
								if(!isnum(M.Health)) return
								M.TakeDamage(src, Damage, "Texas Smash")
								M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
								if(M.KB>20) M.KB=20
								if(Warp&&M.KB) M.KB=M.KB/2
								if(HammerOn) if(prob(max(25,SwordSkill/25))) SmallCrater(M)
								//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(prob(25))
									if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
									if(SwordSkill>1500&&SwordOn) DustCloud(M)
									if(SwordSkill>1500&&HammerOn) DustCloud(M)
								if(SwordOn||HammerOn)
									if(prob(50)) StabUser(src)
									else SlashUser(src)
								spawn M.KnockBack(src)

					else
						flick("Attack",src)
						if(!isnum(M.Life)) return
						M.Life-=3*((src.BP*src.Str)/(M.Base*M.Body*M.End))
						//src.CombatOut("You attack [M]. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//M.CombatOut("[src] attacks you. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
						//if(M&&M.Life<=0) M.Death(src)
			for(var/turf/T in view(0,get_step(src,src.dir))) if(!T.density)
				for(var/mob/M in get_step(get_step(src,src.dir),src.dir)) if(!M.adminDensity&&M.attackable)
					if(M.afk == 0&&!M.RPMode) //
						var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=70)
						var/Damage=DamageFormula(src,M,Strength=1.5,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=SmashDamage+3,UsesWeapon=0,IgnoresEnd=0)
						if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
							flick("Attack",src)

							if(M.attacking==1) src.Opp(M)
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
								M.CombatOut("You dodge [src].")
								src.CombatOut("[M] dodges you.")
							else //Successful hit
								if(!prob(Evasion))
									ShockwaveScale(M,src.BP,1)
									Damage = Damage * 0.35
								if(prob(75))ImpactDust(M,src.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(src, Damage, "Texas Smash")
									M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
									if(M.KB>20) M.KB=20
									if(Warp&&M.KB) M.KB=M.KB/2
									if(HammerOn) if(prob(max(25,SwordSkill/25))) SmallCrater(M)
									//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
									if(prob(25))
										if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
										if(SwordSkill>1500&&SwordOn) DustCloud(M)
										if(SwordSkill>1500&&HammerOn) DustCloud(M)
									if(SwordOn||HammerOn)
										if(prob(50)) StabUser(src)
										else SlashUser(src)
									spawn M.KnockBack(src)
						else
							flick("Attack",src)
							if(!isnum(M.Life)) return
							M.Life-=3*((src.BP*src.Str)/(M.Base*M.Body*M.End))
							//src.CombatOut("You attack [M]. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//M.CombatOut("[src] attacks you. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//if(M&&M.Life<=0) M.Death(src)
			for(var/turf/T in view(0,get_step(get_step(src,src.dir),src.dir))) if(!T.density)
				for(var/mob/M in get_step(get_step(get_step(src,src.dir),src.dir),src.dir)) if(!M.adminDensity&&M.attackable)
					if(M.afk == 0&&!M.RPMode) //
						var/Evasion=AccuracyFormula(src,M,KiManip=0,Chance=70)
						var/Damage=DamageFormula(src,M,Strength=1.5,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=3,FlatDamage=SmashDamage+3,UsesWeapon=0,IgnoresEnd=0)
						if((M.KOd==0&&M.client)||(!M.Frozen&&!M.client))
							flick("Attack",src)

							if(M.attacking==1) src.Opp(M)
							if(!prob(Evasion))
								flick(M.CustomZanzokenIcon,M)
								M.CombatOut("You dodge [src].")
								src.CombatOut("[M] dodges you.")
							else //Successful hit
								if(!prob(Evasion))
									ShockwaveScale(M,src.BP,1)
									Damage = Damage * 0.35
								if(prob(75))ImpactDust(M,src.dir)//ShockwaveIcon(null,"Impact",M.loc)
								ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
								if(M)
									if(!isnum(M.Health)) return
									M.TakeDamage(src, Damage, "Texas Smash")
									M.KB=round(Damage*0.5)//if(incoolattack<2&&M.incoolattack<2)
									if(M.KB>20) M.KB=20
									if(Warp&&M.KB) M.KB=M.KB/2
									if(HammerOn) if(prob(max(25,SwordSkill/25))) SmallCrater(M)
									//ASSERT(M)  //  NULL VAR BUG FIX  -  Apparently Byond places errors in whiles occurring at the end of the while in this case?
									if(prob(25))
										if(UnarmedSkill>1500&&!SwordOn&&!HammerOn) DustCloud(M)
										if(SwordSkill>1500&&SwordOn) DustCloud(M)
										if(SwordSkill>1500&&HammerOn) DustCloud(M)
									if(SwordOn||HammerOn)
										if(prob(50)) StabUser(src)
										else SlashUser(src)
									spawn M.KnockBack(src)

						else
							flick("Attack",src)
							if(!isnum(M.Life)) return
							M.Life-=3*((src.BP*src.Str)/(M.Base*M.Body*M.End))
							//src.CombatOut("You attack [M]. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//M.CombatOut("[src] attacks you. ([round(3*((src.BP*src.Str)/(M.Base*M.Body*M.End)),0.1)] Life Damage)")
							//if(M&&M.Life<=0) M.Death(src)
			src.Smashing=0
			spawn(src.Refire) src.attacking=0

