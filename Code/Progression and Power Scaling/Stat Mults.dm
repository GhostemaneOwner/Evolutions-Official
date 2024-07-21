


mob/verb/Reset_Stat_Multipliers()
	set category=null//"Other"
	if(usr.Confirm("Remove all buffs and reset stat mults to 1x?"))
		RemoveBuffs()
		Reset_StatMultipliers()

mob/proc/Reset_StatMultipliers()
	if(src)
		animate(src, transform = null)
		RemoveBuffs()
		if(GodKiActive)
//		winset(src.client,"GODKI","is-visible=false")
			usr<<"You will now hide your God Ki from others."
			GodKiActive=0
			suffix="[usr.GodKiActive ? "\[Enabled\]":"\[Hidden\]"]"
		BPMult=1
		KiMult=1
		PowMult=1
		StrMult=1
		SpdMult=1
		EndMult=1
		OffMult=1
		DefMult=1
		RegenMult=1
		RecovMult=1
		AngerMult=1
		BuffNumber=0
		Pantheon=null
		Stance=null
		StanceLevel=null
		StanceCore=0
		for(var/Skill/MartialArt/MA in src) MA.Using=0
		Buffs=list()
		if(Ki>MaxKi) Ki=MaxKi


Skill/Technology/Cybernetic_Limb
	desc="Replace someone's limb with an upgraded, cybernetic version. (Limb becomes to damage. Cybernetic Eyes grant 3% Offense at the cost of 10% Regen. Cybernetic Legs give 2.5% speed at the cost of 5% Regen. Cybernetic Arms give 2.5% Strength and Force at the cost of 7.5% Regen.)"


mob/Admin1/verb/Reset_Stat_Mults(var/mob/M in Players)
	set category="Admin"
	M.RemoveBuffs()
	M.Reset_StatMultipliers()
/*
mob/var/tmp
	OldBP
	OldStr
	OldEnd
	OldSpd
	OldPow
	OldDef
	OldOff
	OldEnergy
	OldRegen
	OldRecov
	list/OldBuffs=list()
*/
var/BaseRefireDiv=22
mob/proc
	Available_Stats()
		KBResist=HasSturdyBuild*2.5+HasUnflinching*2.5
		var/SpdOffset=1
		if(Wing_Clipped)SpdOffset=0.6
		MaxKi=BaseMaxKi*KiMult
		if(HasBoundlessStamina) MaxKi*=1.25
		if(HasKeyRing) MaxKi*=1.1
		Pow=BaseStr*PowMult
		if(HasForcefulNegotiator)Pow*=1.13
		Str=BaseStr*StrMult
		if(HasWayOfTheFist&&!HammerOn&&!SwordOn) Str*=1.1
		if(HasBeastOfBurden) Str*=1.03
		Spd=BaseSpd*SpdMult*SpdOffset
		if(HasAgileMastery&&!ArmorOn&&!PowerArmorOn&&!HelmetOn) Spd*=1.25
		if(HasRapidDeployment) Spd*=1.05
		End=BaseEnd*EndMult
		if(HasAdamantineSkeleton) End*=1.08
		if(HasSturdyBuild)
			End*=1+(HasSturdyBuild*0.03)
			for(var/BodyPart/BP in src)
				BP.MaxHealth = 100 + (HasSturdyBuild*10) + (HasAdamantineSkeleton*25)
		if(HasUsedBookOfFortitude) if(HasUsedBookOfFortitude+1>=WipeDay) End*=1.125
		if(GuardBroken) End*=0.9
		Off=BaseOff*OffMult
		Def=BaseDef*DefMult
		if(GuardBroken)Def*=0.9
		if(HasRangeOfMotion&&!ArmorOn&&!PowerArmorOn&&!HammerOn&&!SwordOn&&!HelmetOn)
			Off*=1.1
			Def*=1.1
		Regeneration=(BaseRegeneration+(HasWillOfFire*0.5))*RegenMult
		if(RoidPower) Regeneration*=0.9
		var/CyberRegen=1
		var/CyberStr=1
		var/CyberPow=1
		var/CyberSpd=1
		if(Cyber_Left_Arm)
			CyberStr+=0.025+(0.025*HasEmbraceTheFuture)
			CyberPow+=0.025+(0.025*HasEmbraceTheFuture)
			CyberRegen-=0.05
		if(Cyber_Left_Leg)
			CyberSpd+=0.025+(0.025*HasEmbraceTheFuture)
			CyberRegen-=0.05
		if(Cyber_Right_Leg)
			CyberSpd+=0.025+(0.025*HasEmbraceTheFuture)
			CyberRegen-=0.05
		if(Cyber_Right_Arm)
			CyberStr+=0.025+(0.025*HasEmbraceTheFuture)
			CyberPow+=0.025+(0.025*HasEmbraceTheFuture)
			CyberRegen-=0.05
		if(Cyber_Sight)
			Off*=1.03+(0.03*HasEmbraceTheFuture)
			Def*=1.03+(0.03*HasEmbraceTheFuture)
			CyberRegen-=0.05
		if(Cyber_Torso)
			End*=1.03+(0.03*HasEmbraceTheFuture)
			MaxKi*=1.03+(0.03*HasEmbraceTheFuture)
			CyberRegen-=0.05
		Regeneration*=CyberRegen
		Str*=CyberStr
		Pow*=CyberPow
		Spd*=CyberSpd
		if(RoidPower)
			Regeneration*=0.9
			if(RoidPower>=Base*0.15) Regeneration*=0.9
		Recovery=(BaseRecovery+(HasPCExpert*0.4))*RecovMult
		if(RoidPower)
			Recovery*=0.9
			if(RoidPower>=Base*0.15) Recovery*=0.9
		//var/AngM=1
		if(Blocking)
			Def*=0.8
			Spd*=0.8
			End*=1.4

		if(GodKiActive)
			Str*=1.5
			Pow*=1.5
			End*=1.5
//			Regeneration*=1.5
//			Recovery*=1.5

		if(PSand)
			Off*=0.9
			Def*=0.9
		if(HasMoralCompass)
			if(AlignmentNumber<-1)Off*=1.075
			else if(AlignmentNumber>1)Def*=1.075
			else
				Def*=1.05
				Off*=1.05


		if(!IgnoresBrokenLimbs&&!HasMorphine)
			if(Critical_Torso)
				MaxKi*=Injury_Max
				End*=Injury_Max
			if(Critical_Left_Leg)
				Spd*=Injury_Max
			if(Critical_Right_Leg)
				Spd*=Injury_Max
			if(Critical_Right_Arm)
				Str*=Injury_Max
				Pow*=Injury_Max
			if(Critical_Left_Arm)
				Str*=Injury_Max
				Pow*=Injury_Max
			if(Critical_Sight)
				Off*=Injury_Max
				Def*=Injury_Max

		if(HasDesperateStruggle&&Willpower<51) Off*=1.2
		var/WAM=1
		if(HasWildAnimal&&Willpower<86)
			WAM+=0.05
			if(HasWildAnimal&&Willpower<71)
				WAM+=0.05
				if(HasWildAnimal&&Willpower<56)
					WAM+=0.05
					if(HasWildAnimal&&Willpower<41)
						WAM+=0.05
		Str*=WAM
		Pow*=WAM

		if(issupermajin) End*=1.2
		if(issupermystic) Spd*=1.2
		if(HasBerserking) Regeneration*=0.9
		if(ismajin)
			MaxAnger=10+((BaseMaxAnger)*AngerMult)
		else
			MaxAnger=((BaseMaxAnger)*AngerMult)//MaxAnger=100+((BaseMaxAnger*AngerMult)-100)
		if(Anger>MaxAnger+(DeathAnger*35))Anger=MaxAnger+(DeathAnger*35)
		var/WepSpd=1
		if(KiHammer)
			if(HasBladeOfLight)
				Spd*=0.85
				Off*=0.85
				WepSpd*=0.85
			else
				Spd*=0.8
				Off*=0.8
				WepSpd*=0.8
		if(SpiritSword)
			if(HasBladeOfLight)
				Spd*=0.8
				Off*=0.9
				WepSpd*=0.8
			else
				Spd*=0.7
				Off*=0.9
				WepSpd*=0.7


		//if(Anger>100&&Anger<MaxAnger) Anger=MaxAnger
		WeightedStats=((BaseStr/StrMod)+(BaseEnd/EndMod)+(BaseSpd/SpdMod)+(BaseOff/OffMod)+(BaseDef/DefMod))
		//Refire
		var/RefY=SpdMult*SpdOffset*WepSpd
		if(RefY<0.1) RefY=0.1
		if(RefY>3.5) RefY=3.5
		var/RefZ=sqrt(SpdMod)
		//if(RefZ<0.1) RefZ=0.1
		//if(RefZ>3.5) RefZ=3.5
		if(HasAgileMastery&&!ArmorOn&&!PowerArmorOn&&!HelmetOn) RefZ*=1.2
		Refire=(((BaseRefireDiv/RefZ)/RefY)*Weight)/(Base/(Base+RoidPower))
		//RefX
		var/RefX=1+(HasFireKeeper*0.1)
		if(StanceCore==4) RefX+=0.1
		Refire/=RefX
		Refire=max(3,Refire)
		//Refire=max(1,Refire-(HasFireKeeper*0.5))

		if(HasThrowYourWeight)Str+=End*0.05

		//base attack speed of 0.66 attacks per second @ 1.8x speed mod and 1.3x spd mult (15 refire) down to 1 attack per second w/ 4 one two punch(3 per second with combo on), about 1-1.2 attack per second at 2x mod 1.3x mult

		//HPTick assign
		var/PS=0
		if(locate(/obj/items/Philosophers_Stone) in src) PS=0.5//add to Regen Mod

		var/HH=(Regeneration+PS)*(1+Senzu+(HealthPotion/3))*(MaxHealth/100)
		if(HasFoodRegen)
			if(HasHyperEnzymes) HH*=1.25
			else HH*=1.1
		if(GodKiActive) HH*=1.3
		if(IsBandaged) HH*=1.2
		if(locate(/obj/items/Medicine_Cabinet) in oview(2,src)) HH*= 1.5// Multiplies tick
		if(ismajin) HH*=1.1//Multiplies tick
		if(CurrentAction=="Meditating") HH*=3
		if(CurrentAction=="Training") HH*=0.2
		if(Vampire)HH*=0.8
		if(Werewolf)HH*=0.8
		if(HasCialis)HH*=0.7
		HPTick=0.15*HH

	/* Absorb reducing regen was disabled, saved this incase we want to turn it back on
	var/AbsorbReduction=1
	if(Absorb)
		var/Absorb_Max = Base*0.3
		AbsorbReduction=(Absorb/Absorb_Max)*0.75
	HH*=AbsorbReduction
		*/

		//KiTick assign
		var/KMult=MaxKi*Recovery*max(0.5,min(2,100/BPpcnt))//powering down improves recovery ticks capped at 2x and 0.5x normal rate
		KMult*=1+(HasDeepBreathing*0.125)
		if(HasFoodRecov)
			if(HasHyperEnzymes>0) KMult*=1.25
			else KMult*=1.1
		if(GodKiActive) KMult*=1.3
		if(Race=="Spirit Doll") KMult*=1.3
		if(HasControlOfPower) KMult*=1.5
		if(StanceCore==5) KMult*=1.5
		if(RecentSendEnergy) KMult*=0.5
		if(HasPercocet) KMult*=0.6
		if(KiDoesNotAffectBP==2) KMult*=0.7 // recov nerf from Machine Force
		if(ChakraBlocked) KMult*=0.5
		KMult*=(1+Senzu)
		KiTick=0.005*KMult


