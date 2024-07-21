
mob/var
	FBMAchieved=0
	HybridFBM=0
	FBMMult=1
	AscensionMult=1



mob/proc/FBMCheck()

	if(Race=="Changeling"||Race=="Half-Changeling") if(Base/BPMod>=CoolerForm1&&HasForm==0&&Class!="Frieza")
		src<<"You have awoken a dormant power deep within yourself."
		contents+=new/Skill/Buff/ChangelingTransformation
		HasForm=1
		alertAdmins("[src] has unlocked Form 1")

	if(Race=="Changeling"||Race=="Half-Changeling") if(Base/BPMod>=KingKoldForm1&&HasForm==0&&Class=="King Kold")
		src<<"You have awoken a dormant power deep within yourself."
		contents+=new/Skill/Buff/ChangelingTransformation
		HasForm=1
		alertAdmins("[src] has unlocked Form 1")

	if("Third Eye" in LearnList) if(Base/BPMod>=ThirdEyeAt&&!locate(/Skill/Buff/Third_Eye) in src)
		contents+=new/Skill/Buff/Third_Eye
		src<<"You acquired the ability to unlock your third eye chakra."
		alertAdmins("[src] has unlocked Third Eye")

	if(Race=="Changeling"||Race=="Half-Changeling") if(Base/BPMod>=CoolerForm2&&HasForm==1&&Class!="King Kold")
		src<<"Your aptitude for power has increased."
		HasForm=2
		alertAdmins("[src] has unlocked Form 2")

	if(Base/BPMod>=EarlyALReq)
		if(Race=="Demigod") if(!locate(/Skill/Buff/Pantheon) in src)
			contents+=new/Skill/Buff/Pantheon
			src<<"You have awoken your inner God. You can channel the power of your ancestors!"
			alertAdmins("[src] has unlocked Pantheon")
		if("Giant Mode" in LearnList) if(!locate(/Skill/Buff/Giant_Mode) in src)
			src<<"You have awakened your race's hidden technique... Use it wisely."
			contents+=new/Skill/Buff/Giant_Mode
			alertAdmins("[src] has unlocked Giant Mode")

	if(Global_Trans&&Base/BPMod>=Tier1Req) // global trans on and BP > tier1req
		//Learn list
		if("Makyo Transform"in LearnList) if(!locate(/Skill/Buff/Makyo_Form) in src)
			contents+=new/Skill/Buff/Makyo_Form
			src<<"You have learned your races transformation."
			alertAdmins("[src] has unlocked Makyo Form")
		if("Foresight"in LearnList) if(!locate(/Skill/Buff/Foresight) in src)
			contents+=new/Skill/Buff/Foresight
			src<<"You have learned your races transformation."
			alertAdmins("[src] has unlocked Foresight")
		if("Physics Simulation" in LearnList) if(!locate(/Skill/Buff/Physics_Simulation) in src)
			contents+=new/Skill/Buff/Physics_Simulation
			src<<"...Your mind is your most powerful weapon. Through extensive wisdom and intelligence, you have earned the ability to simulate battles within your mind. The process is taxing and can only be done for so long, but its power is virtually unrivaled."
			alertAdmins("[src] has unlocked Physics Simulation")
/*
		if("Mystic" in LearnList) if(!locate(/Skill/Buff/Mystic) in src)
			contents+=new/Skill/Buff/Mystic
			src<<"You have awoken your race's natural ability. (Mystic)"
			alertAdmins("[src] has unlocked Mystic")
		if("Majin" in LearnList) if(!locate(/Skill/Buff/Majin) in src)
			contents+=new/Skill/Buff/Majin
			src<<"You have awoken your race's natural ability. (Majin)"
			alertAdmins("[src] has unlocked Majin")
*/
		if("Super Maximum Light Speed Mode" in LearnList) if(!locate(/Skill/Buff/Super_Maximum_Light_Speed_Mode)in src)
			contents+=new/Skill/Buff/Super_Maximum_Light_Speed_Mode
			src<<"You feel as though you can push your limits even further..."
			alertAdmins("[src] has unlocked Super Maximum Light Speed Mode")
		if("Spell Force" in LearnList) if(!locate(/Skill/Buff/Spell_Force)in src)
			contents+=new/Skill/Buff/Spell_Force
			src<<"You awaken a hidden power through the magic innately within you."
			alertAdmins("[src] has unlocked Spell Force")
		if("Weapon Force" in LearnList) if(!locate(/Skill/Buff/Weapon_Force)in src)
			contents+=new/Skill/Buff/Weapon_Force
			src<<"You have awoken the potential buried in your soul."
			alertAdmins("[src] has unlocked Weapon Force")
		//Racial specific
		if(Race=="Spirit Doll") if(!locate(/Skill/Buff/Soul_Doll) in src)
			contents+=new/Skill/Buff/Soul_Doll
			src<<"<span class=announce>You have awakened to the true power of the Doll. You have survived through hardship and have EARNED true power."
			alertAdmins("[src] has unlocked Soul Doll")
		if(Race=="Android") if(!locate(/Skill/Buff/Overdrive) in src)
			contents+=new/Skill/Buff/Overdrive
			src<<"You have learned to push your processor past its limits."
			alertAdmins("[src] has unlocked Overdrive")
		if(Race=="Alien"||Race=="Half-Alien") if(!HasAlienTrans)
			HasAlienTrans=1
			src<<"You have awoken a dormant power deep within yourself."
			contents+=new/Skill/Buff/AlienTransformation
			alertAdmins("[src] has unlocked Alien Transformation")
		if(Race=="Changeling"||Race=="Half-Changeling") if(HasForm==2&&Class!="King Kold")
			src<<"Your aptitude for power has increased even further."
			HasForm=3
			alertAdmins("[src] has unlocked Form 3")

	if(Global_Trans&&Base/BPMod>=SNjAt&&!HasSNj)
		if("Super Namekian" in LearnList) if(!locate(/Skill/Buff/Super_Namekian) in src)
			contents+=new/Skill/Buff/Super_Namekian
			HasSNj=1
			src<<"You have tapped into potential long thought lost to your people. While your immediate combat prowess has not improved by much, your awareness of your surroundings has dramatically increased. (SNj Unlocked.)"
			alertAdmins("[src] has unlocked Super Namekian")



	if(!FBMAchieved&&Base/BPMod>FBMAt)
		BPMod*=FBMMult
		FBMAchieved=1
		src<<"You are not sure how, but something is different about you now..."
		alertAdmins("[src] has achieved FBM")
		if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan") if(!HasSSj)
			src<<"Your body has awakened to a great new power.  You can feel your body using your natural aptitude for rage and channeling it into something greater..."
			HasSSj=1
			alertAdmins("[src] has unlocked SSj")
		if(Race=="Heran"||Race=="Half-Heran") if(!HasBojack)
			HasBojack=1
			src<<"Your body has awakened to a great new power.  You can feel your body using your natural aptitude for rage and channeling it into something greater..."
			alertAdmins("[src] has unlocked Bojack")
		if(Race=="Tuffle")
			src.Int_Mod+=0.5
			src<<"Your intelligence soars to super-human heights!"
		if(Race=="Puar")
			src.Magic_Potential+=0.5
			src<<"Your skill with the arcane grows higher than ever before!"
		if(Race=="Shinjin") for(var/Skill/Buff/Mystic/M in src)
			M.Super=1
			src<<"Your Mystic form has evolved into something greater. (Super Mystic unlocked. Your Mystic now grants 1.2x backend speed)"
			alertAdmins("[src] has achieved Super Mystic")
		if(Race=="Demon") for(var/Skill/Buff/Majin/M in src)
			M.Super=1
			src<<"Your Majin form has evolved into something greater. (Super Majin unlocked. Your Majin now grants 1.2x backend endurance)"
			alertAdmins("[src] has achieved Super Majin")

	if(Race=="Changeling"||Race=="Half-Changeling") if(Base/BPMod>=CoolerForm4&&HasForm==3&&Class=="Cooler")
		if(Race=="Changeling"||Race=="Half-Changeling")
			src<<"You have ascended to a new peak of power."
			HasForm=4
			alertAdmins("[src] has unlocked Form 4")

	if(Global_SSJ2&&Base/BPMod>Tier2Req)
		if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan") if(HasSSj<2&&SSjDrain>=300)
			src<<"You have managed to achieve the next level of Super Saiyan."
			HasSSj=2
			alertAdmins("[src] has unlocked SSj 2")
		if(Race=="Heran"||Race=="Half-Heran") if(HasBojack<2&&SSjDrain>=300)
			HasBojack=2
			src<<"Your body has awakened to an even greater power.  You have unlocked Super Bojack."
			alertAdmins("[src] has unlocked Bojack 2")
		if(Perfect_Form==1&&!(locate(/Skill/Buff/Super_Perfect_Form) in src))
			contents+=new/Skill/Buff/Super_Perfect_Form
			src<<"You have utterly shattered your limitations. Due to your extreme training and high levels of power, you have awakened another evolution...."
			alertAdmins("[src] has unlocked Super Perfect Form")

	if(Global_SSJ3&&Base/BPMod>Tier3Req)
		if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan") if(HasSSj<3&&SSj2Drain>=300)
			src<<"You have managed to achieve another level even further beyond Super Saiyan."
			HasSSj=3
			alertAdmins("[src] has unlocked SSj3")
		if(Race=="Shinjin"&&!locate(/Skill/Buff/Angelic_Grace) in src)
			contents+=new/Skill/Buff/Angelic_Grace
			src<<"You feel as though you can nearly unlock the true depths of your power..."
			alertAdmins("[src] has unlocked Angelic Grace")
		if(Race=="Demon"&&!locate(/Skill/Buff/Demonic_Fury) in src)
			contents+=new/Skill/Buff/Demonic_Fury
			src<<"You feel as though you can nearly unlock the true depths of your power..."
			alertAdmins("[src] has unlocked Demonic Fury")
		if("Humanism" in LearnList) if(!locate(/Skill/Buff/Humanism) in src)
			contents+=new/Skill/Buff/Humanism
			src<<"Your humanity has lead to an even greater power..."
			alertAdmins("[src] has unlocked Humanism")

	if(Global_Ascension==1&&Base/BPMod>=AscensionAt)
		if(Race=="Changeling"&&FBMAchieved==1) if(HasForm<5)
			src<<"You feel as though you can tap into the true depths of your power..."
			src.HasForm=5
			alertAdmins("[src] has unlocked Golden Form")
		if(AscensionMult>1&&FBMAchieved==1)
			BPMod*=AscensionMult
			FBMAchieved=2
			src<<"You have achieved a power beyond your previous limits. You have ascended even further beyond!"
			alertAdmins("[src] has unlocked their ascension!")
	if(Global_GodKi==1&&Base/BPMod>=AscensionAt)
		if(Race=="Changeling"&&FBMAchieved==1) if(HasForm<5)
			src<<"You feel as though you can tap into the true depths of your power..."
			src.HasForm=7
			alertAdmins("[src] has unlocked Black Frieza Form")

//	if(Global_GodKi==1&&MaxGodKi>=1)



