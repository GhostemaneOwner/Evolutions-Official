


mob/proc
	ArmorCheck(CheckType=1)
		if(CheckType==1)
			if(src.ArmorOn) return ArmorOn
			if(src.PowerArmorOn) return PowerArmorOn
//		if(CheckType==2)
	WeaponCheck(CheckType=1)
		if(CheckType==1)
			if(src.Disarmed) return 0
			if(src.SwordOn) return SwordOn
			if(src.HammerOn) return HammerOn
			if(src.KiBlade&&src.HasBladeOfLight) return 1
			if(src.KiHammer&&src.HasBladeOfLight) return 1
			if(src.SpiritSword&&src.HasBladeOfLight) return 1
		if(CheckType==2)
			if(src.Disarmed) return 0
			if(src.SwordOn) return SwordOn
			if(src.HammerOn) return HammerOn
			if(src.GlovesOn) return GlovesOn
			if(src.KiBlade&&src.HasBladeOfLight) return 1
			if(src.KiHammer&&src.HasBladeOfLight) return 1
			if(src.SpiritSword&&src.HasBladeOfLight) return 1
	MagicCheck(CheckType=1)
		if(CheckType==1)
			if(src.Disarmed) return 0
			if(src.BoundWeaponOn) return 1
			if(src.SwordOn) for(var/obj/items/Sword/A in src) if(A.suffix) if(A.magical) return 1
			if(src.HammerOn) for(var/obj/items/Hammer/A in src) if(A.suffix) if(A.magical) return 1
			if(src.GlovesOn) for(var/obj/items/Gauntlets/A in src) if(A.suffix) if(A.magical) return 1
			if(src.KiBlade&&src.HasBladeOfLight) return 1
			if(src.KiHammer&&src.HasBladeOfLight) return 1
			if(src.SpiritSword&&src.HasBladeOfLight) return 1


var/WorldDefaultAcc=55

proc/AccuracyFormula(mob/Offender,mob/Defender,KiManip=0,Chance=WorldDefaultAcc)
	if(Offender&&Defender)

		var/Offense=(Offender.BP*((Offender.Off)+(Offender.Spd*(0.15+(max(Offender.HasPrecognition,Offender.Precognition)*0.1)))))
		var/Defense=(Defender.BP*((Defender.Def)+(Defender.Spd*(0.15+(max(Defender.HasPrecognition,Defender.Precognition)*0.1)))))

		if(Offender.Race=="Yardrat")
			Offense=(Offender.BP*((Offender.Off)+(Offender.Spd*(0.20+(max(Offender.HasPrecognition,Offender.Precognition)*0.1)))))
		if(Defender.Race=="Yardrat")
			Defense=(Defender.BP*((Defender.Def)+(Defender.Spd*(0.20+(max(Defender.HasPrecognition,Defender.Precognition)*0.1)))))

		var/YourSkill=max(1,Offender.UnarmedSkill)  + (Defender.HasUnarmed * 50) + (Offender.UnarmedSkillAdd*max(0.025,Year/30))
		if(Offender.SwordOn||Offender.HammerOn)YourSkill=max(1,Offender.SwordSkill)  + (Offender.HasWeapon * 50) + (Offender.SwordSkillAdd*max(0.025,Year/30))
		if(KiManip==1)YourSkill=max(1,Offender.KiManipulation)  + (Defender.HasKiManip * 50) + (Offender.KiManipulationAdd*max(0.025,Year/30))
		if(KiManip==2)YourSkill=max(1,(Offender.KiManipulation*0.5)+(Offender.UnarmedSkill*0.5))  + (Offender.HasKiManip * 25) + (Offender.HasUnarmed * 25) + (Offender.KiManipulationAdd*0.5*max(0.025,Year/30)) + (Offender.UnarmedSkillAdd*0.5*max(0.025,Year/30))


		var/TheirSkill=max(1,Defender.Athleticism) + (Defender.HasEvasion * 50) + (Defender.AthleticismAdd*max(0.025,Year/30))

		var/SkillCompare=YourSkill/TheirSkill
		if(SkillCompare>1.05) SkillCompare=1.05
		if(SkillCompare<0.95) SkillCompare=0.95

		var/TotalAccuracy= Chance*(SkillCompare*((Offense/max(Defense,0.01))))


		//Offender<<"Total Accuracy: [(TotalAccuracy)]"

		if(Offender.dir==Defender.dir)
			TotalAccuracy+=25
			if(Offender.HasExploitWeakness)
				TotalAccuracy+=25
		if(Offender.HasSideSwipe)
			if(Offender.dir==turn(Defender.dir,90))TotalAccuracy+=30
			if(Offender.dir==turn(Defender.dir,-90))TotalAccuracy+=30
		if(Defender.attacking) TotalAccuracy+=10

		if(Defender.Slow) TotalAccuracy+=Defender.Slow
		if(Offender.Slow) TotalAccuracy-=Offender.Slow

		if(Offender.BonusSpeed) TotalAccuracy+=Offender.BonusSpeed
		if(Defender.BonusSpeed) TotalAccuracy-=Defender.BonusSpeed

		if(Offender.StanceLevel=="Novice")TotalAccuracy-=5
		if(Offender.StanceCore==1)TotalAccuracy+=3
		if(Defender.StanceCore==1)TotalAccuracy-=3
		if(Offender.HasDeftHands)TotalAccuracy+=2.5*Offender.HasDeftHands
		if(Defender.HasSwiftReflexes)TotalAccuracy-=2.5*Defender.HasSwiftReflexes


		//Offender<<"Total Accuracy: [(TotalAccuracy)]"


		if(TotalAccuracy>=99) TotalAccuracy=99
		if(TotalAccuracy<=1) TotalAccuracy=1
		if(Defender.icon_state=="Meditate"||Defender.KOd) TotalAccuracy=100
		//Offender<<"Your attack had an accuracy of [TotalAccuracy]"

		return TotalAccuracy

proc/DamageFormula(mob/Offender,mob/Defender,Strength=1,Force=0,Speed=0,Offense=0,DamageType="Physical",BaselineDamage=2,FlatDamage=0,UsesWeapon=1,IgnoresEnd=0)
	if(Offender&&Defender)

		var/Sword_Damage=0
		var/MaxSwordPercent=0

//		for(var/obj/items/Boxing_Gloves/A in Offender) if(A.suffix) A.DurabilityCheck(Offender)
		if(UsesWeapon)
			if(!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Sword/A in Offender) if(A.suffix&&A.Durability>0)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				A.DurabilityCheck(Offender)
				break
			if(!Sword_Damage&&!Offender.KiFists&&!Offender.Disarmed) for(var/obj/items/Hammer/A in Offender) if(A.suffix&&A.Durability>0)
				Sword_Damage=A.Health
				MaxSwordPercent=A.MaxBPAdd
				A.DurabilityCheck(Offender)
				break
		if(!Sword_Damage) for(var/obj/items/Gauntlets/A in Offender) if(A.suffix&&A.Durability>0)
			Sword_Damage=A.Health
			MaxSwordPercent=A.MaxBPAdd
			A.DurabilityCheck(Offender)
			break
		if(Defender.ArmorOn) for(var/obj/items/Armor/A in Defender) if(A.suffix&&A.Durability>0)
			A.DurabilityCheck(Defender)
			break
		if(Sword_Damage>Offender.BP*(MaxSwordPercent/100)) Sword_Damage=Offender.BP*(MaxSwordPercent/100)


		if(Offender.BoundWeaponOn)
			Offender.BWWillpowerDrain()
			Sword_Damage=Offender.BP*0.2 + Offender.BP*((Offender.BoundWeaponOn-1)*0.1)
			UsesWeapon=1

		if(Offender.SpiritSword)
			Sword_Damage=Offender.BP*0.5
			UsesWeapon=1
		if(Offender.KiBlade)
			if(Offender.HasBladeOfLight) Sword_Damage=Offender.BP*0.4
			else Sword_Damage=Offender.BP*0.3
			UsesWeapon=1
		if(Offender.KiHammer)
			Sword_Damage=Offender.BP*0.6
			UsesWeapon=1
		if(Offender.KiFists) if(Sword_Damage<=Offender.BP*0.18)
			Sword_Damage=Offender.BP*0.18
			UsesWeapon=1
		var/EMPBP=0
		if(Defender.ArmorOn) for(var/obj/items/Armor/A in Defender) if(A.suffix&&A.Durability>0) if(A.KineticBarrier) EMPBP=Defender.BP*(A.KineticBarrier/100)
		if(Defender.EmpoweredDefenseTicks) EMPBP=Defender.BP*0.5
		if(Offender.HasThisDrill)IgnoresEnd=10


		var/Dam=((Offender.BP+(Sword_Damage*UsesWeapon))*((Offender.Str*Strength)+(Offender.Spd*Speed)+(Offender.Pow*Force)+(Offender.Off*Offense)))
		var/Res=((Defender.BP+(EMPBP))*(Defender.End-(Defender.End*(IgnoresEnd/100))))
		if(Offender.dir==Defender.dir)
			if(Offender.HasExploitWeakness)Dam+=Dam*0.1
			if(Defender.HasTurtleShell)Res+=Res*(Defender.HasTurtleShell*0.1)
		var/YourSkill=Offender.UnarmedSkill
		if(Offender.SwordOn||Offender.HammerOn)YourSkill=Offender.SwordSkill
		if(DamageType=="Ki")YourSkill=Offender.KiManipulation
		if(DamageType=="KiFist")YourSkill=(Offender.KiManipulation*0.5)+(Offender.UnarmedSkill*0.5)
		YourSkill/=20000
		if(YourSkill>0.5)YourSkill=0.5
		BaselineDamage+=YourSkill

		var/TotalDamage=FlatDamage+((BaselineDamage*(rand(50,150)/100))*((Dam/max(Res,0.01))))

		if(Offender.WeaponCheck()>=2) if(Defender.Werewolf||Defender.Vampire) TotalDamage*=1.1
		else if(Offender.WeaponCheck()<2&&Offender.MagicCheck()) if(Defender.Werewolf||Defender.Vampire) TotalDamage*=1.05
		if(Offender.StanceLevel=="Novice") TotalDamage*=0.95

		for(var/obj/items/Boxing_Gloves/G in usr) if(G.suffix)
			TotalDamage /= 20
			break

		if(Defender.ArmorOn) for(var/obj/items/Armor/A in Defender) if(A.suffix&&A.Health>0)
			A.DurabilityCheck(Defender)
			A.TakeDamage(Offender, TotalDamage, "Attack")
			A.EquipmentDescAssign()
			/*if(A.Health<=0)
				A.Health=0
				view(Defender)<<"[Defender]'s [A] is destroyed"
				Defender.ArmorRemove()
				break*/
		if(Defender.PowerArmorOn) for(var/obj/items/Power_Armor/A in Defender) if(A.suffix&&A.Health>0)
			A.DurabilityCheck(Defender)
			A.TakeDamage(Offender, TotalDamage, "Attack")
			A.EquipmentDescAssign()
			if(A.Health<=0)
				A.Health=0
				view(Defender)<<"[Defender]'s [A] is destroyed"
				Defender.Eject(A)
				A.EquipmentDescAssign()
				break

		return TotalDamage



proc/KiAccuracyFormula(obj/ranged/Blast/BB,mob/Offender,mob/Defender,Chance=60)
	if(Offender&&Defender)

		var/Offense=(BB.Power/global.Ki_Power*((BB.Offense)+(Offender.Spd*(0.15+(Offender.Precognition*0.1)))))
		var/Defense=(Defender.BP*((Defender.Def)+(Defender.Spd*(0.15+(Defender.Precognition*0.1)))))

		var/YourSkill=Offender.KiManipulation + (Offender.KiManipulationAdd*max(0.025,Year/30))

		if(Offender.HasEnergyMarksmanship) Chance+=10
		if(Offender.HasBullsEye) Chance+=Offender.HasBullsEye*3

		var/TheirSkill=Defender.Athleticism + (Defender.HasEvasion * 50) + (Defender.AthleticismAdd*max(0.025,Year/30))

		var/SkillCompare=YourSkill/TheirSkill
		if(SkillCompare>1.25) SkillCompare=1.25
		if(SkillCompare<0.8) SkillCompare=0.8

		var/TotalAccuracy= Chance*(SkillCompare*((Offense/max(Defense,0.01))))
		if(Offender.dir==Defender.dir) TotalAccuracy+=25
		if(Offender.StanceLevel=="Novice")TotalAccuracy-=5
		if(Offender.StanceCore==1)TotalAccuracy+=3
		if(Defender.StanceCore==1)TotalAccuracy-=3
		if(TotalAccuracy>=99) TotalAccuracy=99
		if(TotalAccuracy<=1) TotalAccuracy=1
		if(Defender.icon_state=="Meditate"||Defender.KOd) TotalAccuracy=100
	//	Offender<<"Your [BB] had an accuracy of [TotalAccuracy]"
		return TotalAccuracy

