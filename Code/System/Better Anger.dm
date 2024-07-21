
mob/var/tmp/DeathAnger=0
mob/var/Emotion="<font color=#FFFFCC>Calm</font>"
mob/var/FirstTransWP=0

mob/proc/FirstTransWPRestore(mob/P,check=1) if(P.FirstTransWP<check)
	for(var/mob/player/M in view(P)) M.BuffOut("[P] has their willpower restored as they transend to new heights!")
	if(P.Willpower<P.MaxWillpower-20)P.Willpower=P.MaxWillpower-20
	P.FirstTransWP++
	if(P.Health<P.Willpower)P.Health=P.Willpower
mob/proc/Anger(DA=0) if(!Anger_Restoration)
	Anger_Restoration=1
	if(Anger<MaxAnger+(DeathAnger*35)) Anger=MaxAnger+(DeathAnger*35)
	EmotionCheck()
	if(DA)
		BeenDeathAngry++

		if(Race=="Saiyan"||Race=="Half-Saiyan"||Race=="Part-Saiyan") if(Base/BPMod>=SSjAt&&!HasSSj)
			HasSSj=1
			usr<<"You can feel your body growing to a new level of power and you can feel a surge of energy deep within you. (SSj Unlocked)"
			alertAdmins("[src] unlocked SSj")
		if(Race=="Heran"||Race=="Half-Heran")if(Base/BPMod>=SSjAt&&!HasBojack)
			HasBojack=1
			usr<<"You can feel your body growing to a new level of power and you can feel a surge of energy deep within you. (Bojack Unlocked)"
			alertAdmins("[src] unlocked Bojack")
		if(Race=="Alien"||Race=="Kanassan"||Race=="Half-Alien") if(!HasAlienTrans&&Base/BPMod>=Tier1Req)
			HasAlienTrans=1
			usr<<"You can feel your body growing to a new level of power and you can feel a surge of energy deep within you. (Transformation Unlocked)"
			alertAdmins("[src] unlocked Alien Trans")

		if(HasSSj==1&&SSjDrain>=300&&Base/BPMod>=Tier2Req)
			HasSSj=2
			usr<<"You have awakened the ability to tap into a power even greater than Super Saiyan! (SSj 2 Unlocked)"
			alertAdmins("[src] unlocked SSj 2")
		if(HasBojack==1&&SSjDrain>=300&&Base/BPMod>=Tier2Req)
			HasBojack=2
			usr<<"You have awakened the ability to tap into a power even greater than Bojack! (Super Bojack Unlocked)"
			alertAdmins("[src] unlocked Super Bojack")

		if(HasSSj==2&&SSj2Drain>=300&&HasSSj<3&&Base/BPMod>=Tier3Req)
			HasSSj=3
			usr<<"You have awakened the ability to tap into a power even further beyond a Super Saiyan! (SSj 3 Unlocked)"
			alertAdmins("[src] unlocked SSj 3")

mob/proc/Calm()
	if(RPMode) return
	Anger=100
	Emotion="<font color=#FFFFCC>Calm</font>"
	if(!LethalCombatTracker)DeathAnger=0
	Anger_Restoration=0

mob/proc/Add_Anger(DamageTaken) if(Anger<MaxAnger+(DeathAnger*35))
	if(HasSaltOfTheEarth) DamageTaken*=2
	Anger+=(DamageTaken)*(MaxAnger/100)
	if(Anger>MaxAnger+(DeathAnger*35))Anger=MaxAnger+(DeathAnger*35)

mob/var/SecondWindCD=0
mob/var/RefuseToDieCD=0
mob/var/BurningDesireCD=0
mob/var/BurningDesireAttacks=0
mob/var/tmp/SWTF=0
mob/proc/DecisiveRegen()
	var/HH=0.05*(MaxHealth)
	HealDamage("Decisive Blow Dealt", HH)

mob/proc/SecondWind()
	if(!SecondWindCD)
		Anger()
		if(Health<50) Health=50
		if(Ki<MaxKi*0.5) Ki=MaxKi*0.5
		if(HasAsLongAsMyHeartBeats) SecondWindCD=450
		else SecondWindCD=600
		for(var/mob/M in view(src)) M.BuffOut("[src] steadies themselves and catches a second wind!")
		spawn(5) if(Health<50) Health=50
		spawn(10) if(Health<50) Health=50
		spawn(15) if(Health<50) Health=50
//	else src<<"You are too injured to ready yourself for combat. (Second Wind on CD)"

mob/proc/RefuseToDie()
	if(!RefuseToDieCD&&LethalCombatTracker)
		Anger()
		if(Willpower<50) Willpower=50
		if(Health<50) Health=50
		if(Ki<MaxKi*0.5) Ki=MaxKi*0.5
		RefuseToDieCD=6000
		HasRefusedToDie++
		if(HasRefuseToLose) RefuseToDieCD-=600
		for(var/mob/M in view(src)) M.BuffOut("[src] gathers the last of their willpower and refuses to die!")
		spawn(5) if(Health<50) Health=50
		spawn(10) if(Health<50) Health=50
		spawn(15) if(Health<50) Health=50
mob/proc/BurningDesireForVictory()
	if(!BurningDesireCD&&LethalCombatTracker)
		Anger()
		if(Willpower<50) Willpower=50
		Health=30
		if(Ki<MaxKi*0.5) Ki=MaxKi*0.5
		BurningDesireCD=60000
		if(HasRefuseToLose) BurningDesireCD-=6000
		BurningDesireAttacks=3
		HasBurnedForVictory++
		for(var/mob/M in view(src)) M.BuffOut("[src]'s burning desire for victory allows them to continue fighting! Their resolve will empower their next few attacks!")
		spawn(5) if(Health<30) Health=30
		spawn(10) if(Health<30) Health=30
		spawn(15) if(Health<30) Health=30
mob/proc/EmotionCheck()
	var/OldEmotion=Emotion
	if(Anger<(((MaxAnger-100)/5)+100)) Emotion="<font color=#FFFFCC>Calm</font>"
	if(Anger>(((MaxAnger-100)/5)+100)) Emotion="<font color=#FF6699>Annoyed</font>"
	if(Anger>(((MaxAnger-100)/2.5)+100)) Emotion="<font color=#FF6600>Slightly Angry</font>"
	if(Anger>(((MaxAnger-100)/1.66)+100)) Emotion="<font color=#CC3300>Angry</font>"
	if(Anger>(((MaxAnger-100)/1.25)+100)) Emotion="<font color=#FF0000>Very Angry</font>"
	if(Anger>100) if(AndroidLevel||Race=="Android") Emotion="<font color=#00FFFF>Erratic and Unpredictable</font>"
	if(OldEmotion!=Emotion)
		for(var/mob/player/M in view(src)) M.CombatOut("[src] has become [Emotion]!")
		src.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(src)] gets angry!\n")
