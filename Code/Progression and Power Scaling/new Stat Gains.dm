


mob/proc


	StatGains(Rate=1,Energy=0,Might=0,Endurance=0,Speed=0,Offense=0,Defense=0)
		Rate*=HTFGain
		var/StatRankMod=3*Rate*Weight
		if(z==11||z==10) StatRankMod*=1.2
		if(pfocus=="Balanced")
			if(prob(20)) BaseStr+=0.0065*StrMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseStr/StrMod)*Might
			if(prob(20)) BaseEnd+=0.0065*EndMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseEnd/EndMod)*Endurance
		else if(pfocus=="Might")
			if(prob(20)) BaseStr+=0.012*StrMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseStr/StrMod)*Might
			if(prob(20)) BaseEnd+=0.0025*EndMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseEnd/EndMod)*Endurance
		else if(pfocus=="Endurance")
			if(prob(20)) BaseStr+=0.0025*StrMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseStr/StrMod)*Might
			if(prob(20)) BaseEnd+=0.012*EndMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseEnd/EndMod)*Endurance

	//	Spiritual

		if(prob(20)) BaseSpd+=0.0065*SpdMod*StatRankMod*StatGain*GravMulti*CatchUp()*StatCapCheck(BaseSpd/SpdMod)*Speed

		if(prob(20)) BaseMaxKi+=0.01*KiMod*StatRankMod*StatGain*GravMulti*CatchUp()*StatCapCheck(BaseMaxKi/KiMod)*Energy


		if(MaxGodKi&&MaxGodKi<BaseMaxKi) MaxGodKi+=0.1*StatCapCheck(MaxGodKi/KiMod)*Energy

	//	Ability
		if(mfocus=="Balanced")
			if(prob(20)) BaseOff+=0.0065*OffMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseOff/OffMod)*Offense
			if(prob(20)) BaseDef+=0.0065*DefMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseDef/DefMod)*Defense
		else if(mfocus=="Offense")
			if(prob(20)) BaseOff+=0.012*OffMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseOff/OffMod)*Offense
			if(prob(20)) BaseDef+=0.0025*DefMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseDef/DefMod)*Defense
		else if(mfocus=="Defense")
			if(prob(20)) BaseOff+=0.0025*OffMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseOff/OffMod)*Offense
			if(prob(20)) BaseDef+=0.012*DefMod*StatRankMod*StatGain*CatchUp()*StatCapCheck(BaseDef/DefMod)*Defense


	BaseGain(var/Rate,var/wasZenkai=0)//include MedMod
		var/increase=Rate*GG*HTFGain*BPMod*GainMultiplier*(sqrt(BPRank))*BPCapCheck()
		Base+=increase
		if(RacialPowerAdd) RacialPowerAdd=max(0,RacialPowerAdd-(increase*0.45))
		if(DEBUGMATH) src<<"Base + [increase][wasZenkai?"(Zenkai)":""]"
		if(wasZenkai) ZenkaiPower+=increase

mob/proc/PassiveSkillsIncrease(amount1=0,amount2=0,amount3=0,amount4=0)//ki,sword,unarmed,evasion
	var/HasSword=1
	var/HasBG=1
	var/HasKiOrb=1
	var/HasNinjaSash=1
	if(locate(/obj/items/Ninja_Scarf) in src) HasNinjaSash=1.25
	if(locate(/obj/items/Boxing_Gloves) in src) HasBG=1.25
	if(locate(/obj/items/Orb_Of_Mastery) in src) HasKiOrb=1.25
	if(locate(/obj/items/Sword/Practice_Sword) in src) HasSword=1.25
	if(RestedTime>world.realtime)
		HasSword+=0.25
		HasBG+=0.25
		HasKiOrb+=0.25
		HasNinjaSash+=0.25
	if(InspiredTime>world.realtime)
		HasSword+=0.5
		HasBG+=0.5
		HasKiOrb+=0.5
		HasNinjaSash+=0.5
	if(amount1&&KiManipulation<(WipeDay*25)+50)
		KiManipulation+=(amount1)*(1+(HasKiManip*0.25))*0.2*HasKiOrb
		if(KiManipulation>(WipeDay*25)+50)KiManipulation=(WipeDay*25)+50

	if(amount2&&SwordSkill<(WipeDay*25)+50)
		SwordSkill+=(amount2)*(1+(HasWeapon*0.25))*0.2*HasSword
		if(SwordSkill>(WipeDay*25)+50)SwordSkill=(WipeDay*25)+50

	if(amount3&&UnarmedSkill<(WipeDay*25)+50)
		UnarmedSkill+=(amount3)*(1+(HasUnarmed*0.25))*0.2*HasBG
		if(UnarmedSkill>(WipeDay*25)+50)UnarmedSkill=(WipeDay*25)+50

	if(amount4&&Athleticism<(WipeDay*25)+50)
		Athleticism+=(amount4)*(1+(HasEvasion*0.25))*0.2*HasNinjaSash
		if(Athleticism>(WipeDay*25)+50)Athleticism=(WipeDay*25)+50

//Passive Skills are Governed by Wipe Days now - SR Team