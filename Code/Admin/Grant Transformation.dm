mob/var/HasSSJ3=0

client/proc/Grant_Transformation(mob/M as mob in Players)
	set category="Admin"
	if(M.Race=="Saiyan")
		if(M.HasSSj<3) usr.client.ForceSSJ(M)
		else if(!M.MaxGodKi && !M.HasSSj4) usr.client.ForceSSJ(M)
		//else if(M.MaxGodKi) usr.client.Grant_SSGSS(M)
	else if(M.Race=="Half-Saiyan"||M.Race=="Part-Saiyan") if(M.HasSSj<2) usr.client.ForceSSJ(M)
	else if(M.Race=="Alien"||M.Race=="Heran"||M.Race=="Kanassan") usr.client.Grant_Alien_Trans(M)
	else if(M.Race=="Changeling")
		if(M.HasForm<1) usr.client.ForceChangeling(M)
		else if(M.HasForm < 3&&M.Class!="King Kold") usr.client.ForceChangeling(M)
		else if(M.HasForm < 4&&M.Class=="Cooler") usr.client.ForceChangeling(M)
		else usr.client.ForceGodChangeling(M)
	//else if("Namekian")
	else if(M.Race=="Bio-Android") usr.client.ForceBio(M)
	else if(M.Race=="Namekian") M.contents+=new/Skill/Buff/Super_Namekian
	else if(M.Race=="Yardrat") M.contents+=new/Skill/Buff/Super_Maximum_Light_Speed_Mode
	else if(M.Race=="Human") M.contents+=new/Skill/Buff/Humanism
	else if(M.Race=="Tuffle") M.contents+=new/Skill/Buff/Physics_Simulation
	else if(M.Race=="Spirit Doll") M.contents+=new/Skill/Buff/Soul_Doll
	else if(M.Race=="Konatsian") M.contents+=new/Skill/Buff/Weapon_Force
	else if(M.Race=="Puar") M.contents+=new/Skill/Buff/Spell_Force
	else if(M.Race=="Oni") M.contents+=new/Skill/Buff/Giant_Mode
	else if(M.Race=="Shinjin") M.contents+=new/Skill/Buff/Angelic_Grace
	else if(M.Race=="Demon") M.contents+=new/Skill/Buff/Demonic_Fury
	else if(M.Race=="Demigod") M.contents+=new/Skill/Buff/Pantheon
	else if(M.Race=="Makyo") M.contents+=new/Skill/Buff/Makyo_Form
	else if(M.Race=="Kanassan") M.contents+=new/Skill/Buff/Foresight
	else usr<<"No transformations to grant."
	log_admin("[key_name(src)] granted [key_name(M)] their transformation!")
	alertAdmins("[key_name(src)] granted [key_name(M)] their transformation!")


/client/proc/ForceGodChangeling(mob/M in Players)
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Changeling") return
	if(usr.Confirm("Give [M] Golden Form?"))// return
		if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
		if(M && M.client)	//Do the checks in the reverse of what you'd assume
			if(M.HasForm < 5)
				M.HasForm = 5
				usr<<"Unlocked [M]s Form [M.HasForm]"
			else
				alert("[M] already has their forms fully unlocked!")
				return
			log_admin("[key_name(src)] granted [key_name(M)] Golden Form")
			alertAdmins("[key_name(src)] granted [key_name(M)] Golden Form!")

/client/proc/ForceBio(mob/M in Players)

	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Bio-Android") return
	if(usr.Confirm("Give [M] the next Bio Form?"))// return
		if(M && M.client)	//Do the checks in the reverse of what you'd assume
			if(!M.Perfect_Form)
				M.Bio_Forms()
				usr<<"Unlocked [M]s Bio Trans!"
			else
				alert("[M] already has their forms fully unlocked!")
				return
			log_admin("[key_name(src)] granted [key_name(M)] Bio Trans!")
			alertAdmins("[key_name(src)] granted [key_name(M)] Bio Trans!")

/client/proc/ForceChangeling(mob/M in Players)
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Changeling") return
	if(usr.Confirm("Give [M] Form [M.HasForm+1]?"))// return
		if(M && M.client)	//Do the checks in the reverse of what you'd assume
			if(M.HasForm < 1)
				M.HasForm = 1
				usr<<"Unlocked [M]s Form [M.HasForm]."
			else if(M.HasForm < 2&&M.Class!="King Kold")
				M.HasForm = 2
				usr<<"Unlocked [M]s Form [M.HasForm]."
			else if(M.HasForm < 3&&M.Class!="King Kold")
				M.HasForm = 3
				usr<<"Unlocked [M]s Form [M.HasForm]."
			else if(M.HasForm < 4&&M.Class=="Cooler")
				M.HasForm = 4
				usr<<"Unlocked [M]s Form [M.HasForm]"
			else
				alert("[M] already has their forms fully unlocked!")
				return
			log_admin("[key_name(src)] granted [key_name(M)] Form [M.HasForm]")
			alertAdmins("[key_name(src)] granted [key_name(M)] Form [M.HasForm]!")
/*
client/proc/Grant_SSGSS(mob/M as mob in Players)
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Saiyan") return
	if(M.HasSSGSS) if(usr.Confirm("[M] has SSGSS, remove it?"))
		M.HasSSGSS=0
		M<<"You have lost the ability to transform into SSGSS."
		for(var/Skill/Buff/SSGSS/SS in M) del(SS)
		logAndAlertAdmins("[src.key] has taken away [M]'s SSGSS.",2)
		return
	else if(usr.Confirm("Grant [M] SSGSS?"))
		if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
		M.HasSSGSS=1
		if(!M.MaxGodKi<1) M.MaxGodKi=1
		if(!M.SparGodKi) M.SparGodKi=1
		M<<"You have been granted SSGSS. Use it wisely."
		M.contents+=new/Skill/Buff/SSGSS
		for(var/mob/player/MM in view(15,M)) MM<<'Carl_Orff_35_SEC.wav'
		logAndAlertAdmins("[M] has unlocked SSGSS.",2)
*/
/client/proc/ForceSSJ(mob/M in Players)
	/*if(!src.holder)
		alert("You cannot perform this action. You must be of a higher administrative rank!")
		return*/
	if(M.Race!="Saiyan") if(M.Race!="Half-Saiyan") if(M.Race!="Part-Saiyan") return
	if(usr.Confirm("Give [M] the next SSj level? (They have [M.HasSSj])"))// return
		if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
		var/Gave="SSj"
		if(M && M.client)	//Do the checks in the reverse of what you'd assume
			if(M.HasSSj < 1)
				M.HasSSj = 1
				usr<<"Unlocked [M]s SSj."
			else if(M.HasSSj < 2)
				M.HasSSj = 2
				Gave="SSj 2"
				usr<<"Unlocked [M]s SSj 2."
			else if(M.Class!="Legendary")
				var/list/SSjs=list()
				if(!M.HasSSj4) SSjs+="SSj4"
				if(M.HasSSj<3) SSjs+="SSj3"
				SSjs+="Cancel"
				var/C=input("Give them...") in SSjs
				switch(C)
					if("Cancel")return
					if("SSj3")
						Gave="SSj 3"
						M.HasSSj = 3
						usr<<"Unlocked [M]s SSj 3."
					if("SSj4")
						M.HasSSj4=1
						Gave="SSj 4"
						M.SSj4()
						usr<<"Unlocked [M]s SSj 4. (Perm)"
			else
				alert("[M] already has their forms fully unlocked!")
				return
			log_admin("[key_name(src)] granted [key_name(M)] [Gave]")
			alertAdmins("[key_name(src)] granted [key_name(M)] [Gave]!")
			if(!First_SSJ) if(usr.Confirm("Unleash the Hell Gates of the First SSj?"))
				First_SSJ="[M.name] ([M.key])"
				for(var/mob/K in Players) if(K.MaxKi>=5000) K.ICOut("You feel a great wave of power somewhere in the universe.")
				alertAdmins("[key_name(src)] unleashed the first SSj, [M]!")
			else if(!First_SSJ2&&M.HasSSj==2) if(usr.Confirm("Unleash the Hell Gates of the First SSj2?"))
				First_SSJ2="[M.name] ([M.key])"
				for(var/mob/K in Players) if(K.MaxKi>=5000) K.ICOut("You feel a great wave of power somewhere in the universe.")
				alertAdmins("[key_name(src)] unleashed the first SSj2, [M]!")
			else if(!First_SSJ3&&M.HasSSj==3) if(usr.Confirm("Unleash the Hell Gates of the First SSj3?"))
				First_SSJ3="[M.name] ([M.key])"
				for(var/mob/K in Players) if(K.MaxKi>=5000) K.ICOut("You feel a great wave of power somewhere in the universe.")
				alertAdmins("[key_name(src)] unleashed the first SSj3, [M]!")


/client/proc/Grant_Alien_Trans(mob/M as mob in Players)
	/*if(!src.holder)
		alert("You cannot perform this action.  You must be of a higher administrative rank!")
		return*/
	if(M.HasBojack)
		if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
		if(usr.Confirm("Grant [M] Super Bojack? (SSj2)"))
			M.HasBojack=2
			M.BojackSSj2()
			M<<"You have achieved a power beyond your previous limits. You have unlocked the power of Super Bojack. (SSj2)"
			log_admin("[key_name(src)] has granted [M] Super Bojack 2.")
			alertAdmins("[key_name(src)] has granted [M] Super Bojack 2.")
			return
	else if(M.Race=="Heran")
		if(usr.Confirm("Give [M] Bojack Transformation?")) M.HasBojack=1
	else M.HasAlienTrans = 1
	if(usr.Confirm("Make it drainless?")) M.FirstTransDrainless=1
	log_admin("[key_name(src)] has granted [M] their Alien Transformation.")
	alertAdmins("[key_name(src)] has granted [M] their Alien Transformation.")


