mob
	var/Choice
	var/Personality
	var/Historys
	var/History

mob/proc/Historys()
	if(Historys&&Historys!="Choosing") return
	else Historys="Choosing"
///mob/proc/Historys() 
	var/list/Historie=new/list
	Historie.Add("Average")
	Historie.Add("Amnesia")
	Historie.Add("Vagabond")
	if (Race=="Saiyan"|Race=="Primal Ape")
		Historie.Add("Dark Saiyan")
		Historie.Add("Energy Specialist")
	if (Class=="Legendary")
		Historie.Add("Berserker")
		Historie.Add("Cold")
		Historie.Add("Tsufurujin Experiment")
	if (Race=="Kanassan")
		Historie.Add("Royalty")
		Historie.Add("Elite Defect")
		Historie.Add("Super-soldier")
		Historie.Add("Warrior Elite")
		Historie.Add("Attempted Ruler")
		Historie.Add("Different Upbringing")
		Historie.Add("War Academy Trainer")
		Historie.Add("Bodyguard")
		Historie.Add("Paragon")
		Historie.Add("Elite Assassin")
	if (Class=="Low-Class")
		Historie.Add("Wild Thing")
		Historie.Add("Slave Labour")
		Historie.Add("Minor Status")
		Historie.Add("Underdog")
		Historie.Add("Downtrodden")
		Historie.Add("Not so harsh")
		Historie.Add("Trash")
		Historie.Add("Rebel")
		Historie.Add("Soldier")
		Historie.Add("Doctore")
	if (Class=="Normal")
		Historie.Add("Noble")
		Historie.Add("Standing Out")
		Historie.Add("Background Color")
		Historie.Add("Between the Lines")
		Historie.Add("Somehow Oppressed")
		Historie.Add("Born Soldier")
		Historie.Add("Thug")
		Historie.Add("Ex Military")
		Historie.Add("Brawler")
	if (Race=="Demigod")
		Historie.Add("Demi-God")
		Historie.Add("Guardian")
		Historie.Add("Demi Caretaker")
		Historie.Add("Asgardian")
		Historie.Add("Pantheon")
		Historie.Add("Channeler")
	if (Race=="Tuffle")
		Historie.Add("Less than a Lowie")
		Historie.Add("Technologic")
		Historie.Add("Tuffle Power!")
		Historie.Add("Magical Tuffle")
		Historie.Add("Damaged Goods")
	if (Race=="Human")
		Historie.Add("Capsule Degree")
		Historie.Add("Karate Kid")
		Historie.Add("School Jock")
		Historie.Add("Witchcraft and Wizardry")
		Historie.Add("Hunter by Lifestyle")
		Historie.Add("Bushido")
		Historie.Add("Ninja")
		Historie.Add("Bandit")
		Historie.Add("Street Rat")
		Historie.Add("Feral")
		Historie.Add("Warlord")
		Historie.Add("Cultist")
		Historie.Add("Super Hero")
	if (Race=="Demon")
		Historie.Add("Forged from Hell fire")
		Historie.Add("Survival Game")
		Historie.Add("Playing it Smarter")
		Historie.Add("Chaos Incarnate")
		Historie.Add("Greater Goal")
		Historie.Add("Primal")
		Historie.Add("Diabolically Insane")
		Historie.Add("Trickster")
		Historie.Add("Embodiment of Sin")
		Historie.Add("Sacred")
		Historie.Add("Lord of Pandemonium")
	if (Race=="Shinjin")
		Historie.Add("Universal Guardian")
		Historie.Add("Power of the Mind")
		Historie.Add("Mystical")
		Historie.Add("Caretaker")
		Historie.Add("Crusader")
		Historie.Add("Scholar")
		Historie.Add("Denizen Of The Light")
		Historie.Add("Despondent Kaio")
		Historie.Add("Ancient")
		Historie.Add("Judge")
	if (Race=="Android")
		Historie.Add("Bounty Hunter")
		Historie.Add("Project: Domination")
		Historie.Add("Biological Research")
		Historie.Add("Energy Experiment")
		Historie.Add("Upgrader")
		Historie.Add("Battledroid")
	if (Race=="Spirit Doll")
		Historie.Add("Combat Doll")
		Historie.Add("Revered")
		Historie.Add("Ki Specialist")
		Historie.Add("Pinocchio")
		Historie.Add("Spy")
		Historie.Add("Circus")
		Historie.Add("Drone")
	if (Race=="Namekian")
		Historie.Add("Warrior-type Namekian")
		Historie.Add("Dragon Clan Namekian")
		Historie.Add("Demon Clan Namekian")
		Historie.Add("Secluded Namekian")
	if (Race=="Changeling")
		Historie.Add("Born to Rule")
		Historie.Add("Seas run Red")
		Historie.Add("Sibling Issues")
		Historie.Add("Glacial Hunter")
		Historie.Add("Savage")
		Historie.Add("Exciled")
		Historie.Add("Scientific")
		Historie.Add("Runt")
		Historie.Add("Goon")
		Historie.Add("Frostdemon")
	if (Race=="Makyojin")
		Historie.Add("Cult Leader")
		Historie.Add("Sorcery")
		Historie.Add("Grunt")
		Historie.Add("Legacy")
		Historie.Add("Planetary Corrupter")
	if (Race=="Heran")
		Historie.Add("Road of Loss")
		Historie.Add("One of a Kind")
		Historie.Add("Ancient Civilization")
		Historie.Add("Enforcer")
		Historie.Add("Separated")
		Historie.Add("TOKUSENTAI")
		Historie.Add("Fabulous")
		Historie.Add("Technomancer")
	if (Race=="Hybrid")
		Historie.Add("Special Spawn")
		Historie.Add("Overly aggressive")
		Historie.Add("Primitive")
		Historie.Add("Demi-Hunter")
		Historie.Add("Pure Evil")
		Historie.Add("Honorable Warrior")
		Historie.Add("Tactician")
	if (Race=="Bio-Android")
		Historie.Add("Perfect Specimen")
		Historie.Add("Failed Experiment")
		Historie.Add("Corrupt Data")
		Historie.Add("Voidling")
		Historie.Add("Evil Hunter")
	if (Race=="Majin")
		Historie.Add("Enslaved")
		Historie.Add("Bringer of the end")
		Historie.Add("Glutton")
		Historie.Add("Genetic Experiment")
	if (Race=="Ancient")
		Historie.Add("Salamander")
		Historie.Add("God of War")
		Historie.Add("Ancestor")
		Historie.Add("Keeper")
		Historie.Add("Observer")
	if (Class=="Ancient")
		Historie.Add("Elder")
		Historie.Add("Scientist")
	if (Race=="Quarter-Saiyan")
		Historie.Add("Saiyan Heritage")
		Historie.Add("Academic")
		Historie.Add("Hidden Potential")
		Historie.Add("Ki Prodigy")
		Historie.Add("Treasure Hunter")
		Historie.Add("Ancient Bloodline")
		Historie.Add("Educated")
		Historie.Add("Enhanced")
	if (Race=="Half-Saiyan")
		Historie.Add("Best Of Both Worlds")
	if (Class=="Vegeta-Halfie")
		Historie.Add("Elite")
		Historie.Add("Living Weapon")
		Historie.Add("Royal Descendant")
		Historie.Add("Superior")
		Historie.Add("Half Blood Resentment Saiyan")
	if (Class=="Earth-Halfie")
		Historie.Add("Cursed")
		Historie.Add("Reluctant Scientist")
		Historie.Add("Centered")
		Historie.Add("Ki Prodigy")
		Historie.Add("Half Blood Resentment Human")


	switch(input("What kind of backstory does your character have, or best fits your character as the case may be?","",text) in Historie)
		if("Average")
			History="Average"
			Choice=alert(src,"An Average background means your character has lived the ordinary sort of life for a character of your race. It went to school where it probably had average grades, it's parents are still alive where applicable, and there was overall nothing really special about the way the character grew up. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					usr<<"Congratulations, Average character! You've chosen the Jack of all paths!"
		if("Amnesia")
			History="Amnesia"
			Choice=alert(src,"Due to some freak accident, experiment or otherwise unknown cause you do not recall who you are, where you come from and maybe even not -what- you are. You know face the challenges of rediscovering your old identity or forging a new one without any knowledge of the world around you or who you can or cannot trust. (You do need to pick a name at character creation, regardless of you rping that you don't know your name or not)r. Is this the type of History you want? ","","Yes","No")
			switch (Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=rand(80,110)/100
					StrMod*=rand(80,110)/100
					SpdMod*=rand(80,110)/100
					OffMod*=rand(80,110)/100
					DefMod*=rand(80,110)/100
		if ("Vagabond")
			History="Vagabond"
			Choice=alert(src, "You have trouble staying in one place for a long time, preferring to travel from place to place or even planet to planet if you can. Perhaps you're trying to prevent yourself from getting to tied to a place or perhaps you're trying to run from your past, either way people like you tend to prefer being secluded though you might seek out company every now and then for the sake of variationr. Is this the type of History you want? ","","Yes","No")
			switch (Choice)
				if("No")
					Historys()
				if("Yes")
					MedMod*=1.1
					EndMod*=1.1
		if("Dark Saiyan")
			History="Dark Saiyan"
			Choice=alert(src,"These are the saiyans that aren't so good. They're set up to be evil, conniving, the type that doesn't tend to make friends and kills without mercy. They tend to have dark, defining pasts that morph their psyche in ways that prepare them for a life of evil. That's not to say they can't repent eventually, just that it's unlikely. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.22
					SpdMod*=1.2
					StrMod*=1.2
					OffMod*=1.2
					DefMod*=1.2
					KiMod*=1.2
		if("Energy Specialist")
			History="Energy Specialist"
			Choice=alert(src,"You specialize in Energy rather than brute force, go figure. Your character tended to avoid getting into brawls and instead focused on Energy and how to manipulate it. This makes them terrible physical combatants despite their Saiyan Heritage, but excellent in the use of ki. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.85
					StrMod*=1.55
					SpdMod*=1.12
					OffMod*=2
					DefMod*=1.8
					Regeneration*=1.65
					Recovery*=2
					KiMod*=2
		if("Berserker")
			History="Berserker"
			Choice=alert(src, "Good old fashioned classic Broly, basically, you're bat shit crazy.  You're pretty introvert and controlled in your base state, once your anger triggers though and you go super saiyan all sanity and restraint are out the window. Due to having more power then you can possibly control odds are you'll end up blowing yourself and the planet you're standing on up sooner then that you'll tire out and revertr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.2
		if("Cold")
			History="Cold"
			Choice=alert(src, "A truly fear inspiring sight, this history is a completely different kind of crazy. Your base form is in perfect control, seemingly a normal saiyan for all means if somewhat powerful, once you transform however you turn into a cold hearted killer, you lose all emotion and interest in others or your personal history with them, instead focusing your full might on crushing each and everyone with devastating intent. Instead of going berserk you regain full control of your actions and power, but due to the massive personality difference once transformed there is simply no reasoning with you, no memories that can be summoned to calm you down, you -want- this to happen, you are the perfect warrior, cold and ruthless, you are the legendary super saiyanr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					DefMod*=1.2
					StrMod*=2
		if("Tsufurujin Experiment")
			History="Tsufurujin-experiment"
			Choice=alert(src, "As a new born baby you were taken away by tsufurujin scientists and experimented upon, their goal was to mold you into a perfect weapon for them to use against the saiyan race. However what they made was to powerful to control, you broke free and started destroying everything in sight, as a result of their experimentation you're able to transform into a super saiyan, effectively making you an 'artificial lssj' in the sense that you were made/altered to become one rather then being born as suchr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.55
					StrMod*=1.2
					OffMod*=1.2
		if("Royalty")
			History="Royalty"
			Choice=alert(src,"Your elite saiyan was born into a royal family- be they the king and queen themselves or a member of the higher court. This naturally comes with luxuries that other Saiyans can only dream of, access to advanced training methods that may counteract the pampering, and wealth that is the stuff of legend. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.15
					StrMod*=1.85
		if("Elite Defect")
			History="Elite Defect"
			Choice=alert(src,"Vegeta isn't Sparta, so occasionally this tends to happen: Your elite saiyan was born with a defect that has defined his/her life since they were born. Be they blind, mute, deaf, paraplegic, or even in some cases minor things such as colour blindness and dyslexia- they are usually treated like Low class Saiyans or in extreme cases, Tuffles, or ignored outright. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.25
					DefMod*=1.25
					OffMod*=1.8
					KiMod*=1.1
		if("Super-soldier")
			History="Super-soldier"
			Choice=alert(src,"Occasionally Vegeta is in need of a soldier beyond the others. In such circumstances an individual is trained in combat from birth. It isn't an easy life whatsoever, but the lifestyle gives the trainee immense combat ability though they are usually extremely lacking in social ability and hence loners. They are 'built to serve' usually and almost never seek positions of power outside the life of a soldier. Is this the history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.85
					DefMod*=1.85
					SpdMod*=1.15
				//	StrMod*=1.15
					EndMod*=1.75
					StrMod*=1.85
		if("Warrior Elite")
			History="Warrior Elite"
			Choice=alert(src,"The traditional Elite warrior- raised to fight and be strong on the concepts of saiyan pride. They usually have a knack for combat though their pride tends to get in their way of proper social interactions. Is this the history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.75
					StrMod*=1.65
		if("Attempted Ruler")
			History="Attempted Ruler"
			Choice=alert(src,"You are the Elite who always had his eyes on the throne, if not higher. The one who spent their life from the moment they could talk looking for support so they could gain positions of increasingly higher status. Your social skills are rivalled only by your lust for control. You prefer to spend your time plotting and scheming rather than fighting, though you're quite capable of physical combat when necessary. Is this the history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					//zenni+=rand(1000,5000)
					MedMod*=1.5
					StrMod*=1.85
		if("Different Upbringing")
			History="Different Upbringing"
			Choice=alert(src,"Your upbringing was... different from most. Whether you were raised by a family of lower-class saiyans for some reason, or your parents just didn't take the time to notice you were even alive, you grew up without the superiority complex. As a result you tend to train better with others and are generally stronger for it. Is this the history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					DefMod*=1.1
					StrMod*=1.9
					EndMod*=1.8
		if("War Academy Trainer")
			History="War Academy Trainer"
			Choice=alert(src,"Your job is to whip the saiyans into shape for combat, training them at a young age to fighting shape and you're good at your job. With your elite power it's your pleasure to personally train young elites and some upstanding normal class saiyans, you don't waste your time on low class saiyans though, they're a lost cause as far as you're concerned any whor. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.3
					DefMod*=1.3
					StrMod*=1.7
					Regeneration*=1.7

		if("Bodyguard")
			History="Bodyguard"
			Choice=alert(src,"A saiyan elite is as powerful as a saiyan can get, due to that the king, queen or any person of interest is more then interested in hiring you to protect either themselves or someone for them. Due to your job you don't have as much time to train, being ever vigilant for potential threats for your employer, after all if that person dies you don't get paidr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=0.7
					EndMod*=1.3
					DefMod*=1.3
					Regeneration*=1.2
		if("Paragon")
			History="Paragon"
			Choice=alert(src,"You are a powerful warrior, bound by pride and honour to do what you consider right. You're the type of warrior that would lower his power in a serious fight just to give the opponent a fair chance; making the fight more interesting for yourself in the process. You still consider low and normal class saiyans beneath you and prefer not to waste time on them, when you're forced to however you try to take them atleast somewhat seriousr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					//ResMod*=1.2
					DefMod*=1.2
					//PowMod*=0.7
					KiMod*=0.7
		if("Elite Assassin")
			History="Elite Assassin"
			Choice=alert(src,"You have been trained by the best of the best, molded into the perfect stealth killing machine. Your rigorous training started at birth and had tempered your spirit, your life is lived in service of the crown. Due to this you have no ambition to obtain the crown whatsoever (at least not starting out), instead your goals are aimed to be the most use you can be to your king/queen. Your liege often made use of your services by sending you out to assassinate those who would pose a threat to his rule, or perhaps even rulers of different countries or worldsr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					OffMod*=1.3
					SpdMod*=1.3
					//PowMod*=0.6
					//ResMod*=0.6
					DefMod*=1.6
		if("Wild Thing")
			History="Wild Thing"
			Choice=alert(src,"Wild thing! You make my heart sing~! Sometimes a Low-class saiyan is discarded or misplaced. Left to fend for itself in the wild as a baby. Sometimes they manage to survive on their own (miraculously). Other times they are taken in by animals and raised by them. Either way there's no doubting the power of a feral Saiyan. I don't think I need to mention that their english may not be too good. Is this the history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.15
					//ResMod*=0.5
					//PowMod*=1.15
					SpdMod*=1.15
					DefMod*=1.2
					OffMod*=1.75
					StrMod*=1.15
		if("Slave Labour")
			History="Slave Labour"
			Choice=alert(src,"Some Low-class saiyans are treated even less than others: treated as slaves or pets or servants without benefits. These Saiyans usually have the most bone to pick with the upper classes, though they are usually malnourished. They make up for this lack of strength with fairly good dexterity. Is this the history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.85
					StrMod*=1.85
					//ResMod*=1.1
					SpdMod*=1.3
					OffMod*=1.25
					Regeneration*=1.7
					Recovery*=1.7
					//zenni=0
					Int_Mod*=1.25
		if("Minor Status")
			History="Minor Status"
			Choice=alert(src,"You or your family have somehow managed to attain minor status in the world of saiyans despite your class. Be it for generations of loyal service to the ruler, friendship with a noble or otherwise, you are one of the few low-class saiyans who got to enjoy the luxuries of a moderately wealthy lifestyle. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.95
					StrMod*=1.95
					//ResMod*=1.1
					//zenni+=rand(500,7500)
		if("Underdog")
			History="Underdog"
			Choice=alert(src,"Everyone loves an underdog. Your entire life you were constantly told you would fail at whatever you did because of your class, and yet you somehow always managed to pull out (if not victorious) with your dignity intact. This defined your early life to the point where perhaps despite being put down you have more confidence in yourself. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					StrMod*=1.2
					SpdMod*=1.2
					OffMod*=1.9
					DefMod*=1.9
					//TrainMod*=1.2
					Regeneration*=1.85
					KiMod*=0.95
		if("Downtrodden")
			History="Downtrodden"
			Choice=alert(src,"Unlike your traditional Underdog you weren't quite so successful when people told you you would fail. In fact you usually did fail exactly like they said you would. This type of backstory can lead to severe confidence issues. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.1
					StrMod*=1.1
					SpdMod*=1.1
					//TrainMod*=1.1
					Regeneration*=1.9
					KiMod*=1.9
		if("Not so harsh")
			History="Not so harsh"
			Choice=alert(src,"Compared to the other member of your class you got off easy. You may not have been treated like royalty, but you avoided the more brutal histories that tend to encircle your class. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.85
					//ResMod*=0.95
					DefMod*=1.75
					StrMod*=1.1
					//PowMod*=1.3
					MedMod*=1.2
					KiMod*=1.35
		if("Trash")
			History="Trash"
			Choice=alert(src,"If you thought things were bad when Elites wind up with a defect, imagine what it's like for the class that is already treated like garbage. Because you were mute or deaf or whatever have you, your character was treated like absolute scum even by members of your own class. Naturally this can be very traumatizing, but on the bright side you tend to get used to the beatings. Usually. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.5
					DefMod*=1.4
					SpdMod*=1.1
					OffMod*=0.85
					//TrainMod*=0.95
					Regeneration*=1.5
		if("Rebel")
			History="Rebel"
			Choice=alert(src,"You have high ambitions, most people would call you an idiot for even thinking of the dreams you have let alone taking steps to making them happen. You serve the saiyan king/queen like just about every other saiyan, but in secret you hope that one day you'll be able to overthrow his/her regime and usher in a new age for the saiyan race. Untill that day though, you bide your time..r. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					//PowMod*=1.2
					EndMod*=1.2
					SpdMod*=1.2
					StrMod*=1.9
					//ResMod*=0.9
					Recovery*=2
		if("Soldier")
			History="Soldier"
			Choice=alert(src,"You're a soldier in the saiyan army, mostly you do grunt work but on rare occasions you get put on riskier missions. Most people would consider those moments to be suicidal but you see it as a chance to shine and prove your worth as a full fledged saiyan warriorr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.65
					EndMod*=1.65
					OffMod*=1.65
					//ResMod*=0.9
					SpdMod*=1.9
		if("Doctor")
			History="Doctor"
			Choice=alert(src,"Like the ancient trainers of gladiators on earth, you train your fellow saiyans. Even low class saiyans need some guidance from time to time, with the academy instructors busy catering to the elites and normal class saiyans you get stuck with the bottom of the barrel, teaching inexperienced low class warriors what they need to know to survive as long as you haver. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					//ResMod*=1.2
					DefMod*=1.1
					Regeneration*=1.7
					SpdMod*=1.7
		if("Noble")
			History="Noble"
			Choice=alert(src,"Slightly under the Royalty Elites can achieve, your family is in the upper-middle chaste as it were, and you gain all the benefits (and detriments) of a lavish lifestyle from birth including being taught you were better than everyone else. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					DefMod*=1.1
					Regeneration*=1.7
					SpdMod*=1.7
		if("Standing Out")
			History="Standing Out"
			Choice=alert(src,"In a class that usually involves backing up whatever Elites say in exchange for being treated like actual people, you somehow managed to stand out. Whether it was by going against the stream or taking on the properties of the elite, you drew attention to yourself even from behind the mask of mediocrity. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					MaxAnger*=1.25
					GravMod*=0.75
					KiMod*=1.2
					Int_Mod*=1.25
		if("Background Color")
			History="Background Color"
			Choice=alert(src,"Utilizing your position as middle-chaste you were one of those people who somehow managed to blend into the background. You didn't really get noticed by people and as a result you didn't tend to make many friends. Even your teachers sometimes blinked and asked who you were, which comes with advantages and disadvantages. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					//ResMod*=0.8
					StrMod*=1.9
					MedMod*=1.2
					//TrainMod*=1.2
		if("Between the Lines")
			History="Between the Lines"
			Choice=alert(src,"Your early life was defined by the social differences between Elites and Low-class saiyans. As a normal-saiyan you got a unique outside-looking-in perspective on the matter which enabled you to draw your own conclusions. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.25
					StrMod*=1.95
					//ResMod*=1.25
					KiMod*=1.9
		if("Somehow Oppressed")
			History="Somehow Oppressed"
			Choice=alert(src,"For whatever reason you were one of the normies who lived their life around elites who weren't so distinctive about low and normal class. In fact to them the normal class didn't even exist. As a result you may have been a bit more downtrodden than the rest of your class and tend to associate more with low-class saiyans than normies or elites. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.3
					StrMod*=1.1
					SpdMod*=1.75
		if("Born Soldier")
			History="Born Soldier"
			Choice=alert(src,"Normal-class saiyans tend to make excellent soldiers- they're weaker than elites so that they follow orders, and strong enough to keep the low-class saiyans in check. As a result it's popular to raise them to be soldiers- it tends to come with a bit of social pull and is the only saiyan career worth mentioning. Not that other Saiyans aren't soldiers- just these particular Normies tend to specialize. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.15
					StrMod*=1.15
					SpdMod*=1.15
					//TrainMod*=1.1
					//SparMod*=0.9
		if("Thug")
			History="Thug"
			Choice=alert(src,"You're a saiyan criminal, deciding that you only look after #1, yourself. To avoid trouble with the saiyan elites odds are you teamed up with several other thugs and serve a renegade elite for as long as it benefits you. You don't mind operating in a group, bullying others and taking what you want comes pretty natural to you. You don't enjoy being ordered around however, which was probably a major factor that led to you ending up as a thugr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.2
					//PowMod*=0.8
					//ResMod*=0.8
					Off=50
					Def=50
		if("Ex Military")
			History="Ex Military"
			Choice=alert(src,"You used to be a proud part and probably high ranking part of the saiyan military, however either due to an event you were dishonourably discharged, stripping you of your rank and influence. What actually happened is up to you, perhaps you disobeyed an order, got framed by an ambitious soldier that wanted your rank or simply made a bad call resulting in the loss of life of many saiyan warriors under your command. Whatever the reason however the discharge has made you bitter over the years, you wish nothing more then to clear your name or get evenr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					//PowMod*=1.2
					//ResMod*=1.2
					EndMod*=1.8
					SpdMod*=1.8
					OffMod*=1.8
					DefMod*=1.1
					Regeneration*=1.9
					Recovery*=1.9
		if("Brawler")
			History="Brawler"
			Choice=alert(src,"Most saiyans join the army and go out on missions to sate their lust for combat and violence, you however have found a more..financially sound way to scratch that particular itch. Your home is the ring, fighting opponents in winner take all tournaments that get hosted for the enjoyment of the spectators. Due to all your fights being in the ring you have a pretty good fighting style, unfortunately however the world is a lot bigger then the ring and you're not used to the different terrains and the effects they bring, but as a fighter in the ring that hardly mattersr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					EndMod*=1.3
					//ResMod*=1.3
					//PowMod*=0.6
					OffMod*=1.6
					DefMod*=1.6
					Off=80
					Def=80
		if("Demi-God")
			History="Demi-God"
			Choice=alert(src,"You are the offspring of a god, however many times removed. You could be the son of Zeus or the great, great, great, great granddaughter of Heracles. Either way, you posses the powers of a God and all the benefits that come with it. You generally don't fit in with a modern environment due to your mystical traits (which can include glowing skin in addition to super strength). Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					//PowMod*=1.3
					//ResMod*=1.5
					StrMod*=1.8
					EndMod*=1.8
					KiMod*=1.3
		if("Guardian")
			History="Guardian"
			Choice=alert(src,"You are a protector of the Heavens, an enforcer of the kaios. You've spent your life in service of the Heavens and pride yourself on your service. No day passes where you are not prepared to lay down your life for all that is good and to keep the souls in Heaven safer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					SpdMod*=1.2
					EndMod*=1.8
		if("Demi Caretaker")
			History="Demi Caretaker"
			Choice=alert(src,"Unlike your brothers and sisters you did not partake in combat training, nor did you show interest in it. Perhaps this was because you don't enjoy fighting, or perhaps you're simply not good at it. Because of this you decided to make yourself useful in other ways, now assisting the kaios and souls in heaven by taking care of structures, services or perhaps even by inventing things from time to timer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.5
					EndMod*=1.5
					Int_Mod*=3
		if("Asgardian")
			History="Asgardian"
			Choice=alert(src,"Your idea of fighting Evil is filled with enjoyment and friendship, brawling over something as small as a mug of ale is as natural to you as it is to shake a hand upon meeting someone for the first time. Because of your manners and habits many of the tales of old norse myth on Earth are based on your kind and though you never met the likes of 'Odin, Thor, Loki and all of them' you'd be sure all you would get along splendidly over a good old fashioned brawling sessionr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					EndMod*=1.3
					OffMod*=1.3
					DefMod*=1.7
		if("Pantheon")
			History="Pantheon"
			Choice=alert(src,"You served the forces of good by aligning yourself with a pantheon, declaring yourself things like 'the living embodiment of Zeus' thunder' or 'Thors Hammer' while you were fighting evil in the living realm. Now you have joined the kaios in the afterlife, securing Heaven together with the Guardians and Asgardians and fighting the forces of evil when they get out of handr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					OffMod*=1.2
					SpdMod*=1.8
					DefMod*=1.8
		if("Channeller")
			History="Channeller"
			Choice=alert(src,"You act as an instrument through which your god acts, due to this you have access to great power though it is inconsistent at best, your god helping you whenever it feels like it. The divine energy has eroded your body somewhat over time, leaving you physically weaker then the average demigod. Fortunately for you your god has provided you with a far greater reserve of energy to tap intor. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=2
					EndMod*=2

		if("Less than a Lowie")
			History="Less than a Lowie"
			Choice=alert(src,"Tuffles are the lowest chaste on Vegeta by a long shot. This traditionally leads to a lot of physical abuse for the tuffles in question. Those with this backstory got an even shorter end of this stick than normal and were usually brutalized from an early age. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.3
					//SparMod*=1.5
					SpdMod*=1.3
					//TrainMod*=1.2
					DefMod*=1.15
					//PowMod*=0.5
					//ResMod*=0.75
		if("Technologic")
			History="Technologic"
			Choice=alert(src,"Buy it, use it, break it, fix it, trash it, change it, mail - upgrade it. Your character was raised around technology to the point where their technology is practically an extension of themselves. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.65
					//ResMod*=0.8
					SpdMod*=1.8
					StrMod*=1.65
					OffMod*=1.65
					DefMod*=1.65
					//PowMod*=0.65
					Int_Mod*=2.5
		if("Tuffle Power!")
			History="Tuffe Power!"
			Choice=alert(src,"As hard as it is to believe your character was raised away from technology. Why? To be a warrior of course. Rather than build spaceships this character is destined to clash swords with saiyans and fear nothing. They are rare, but considered a necessary development since the enslavement of the tuffles. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.4
					StrMod*=1.3
					SpdMod*=1.2
					//TrainMod*=1.4
					DefMod*=1.2
					//ResMod*=0.8
					//PowMod*=0.8
					Int_Mod*=1.75
					Regeneration*=1.25
		if("Magical Tuffle")
			History="Magical Tuffle"
			Choice=alert(src,"Technology? Why spend time working with that when you're fairly sure there's a way to do with it ki? This is the tinkerer race turned wizard- studying volumes about ki-flow rather than technical manuals. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					//PowMod*=1.35
					//ResMod*=1.3
					SpdMod*=1.8
					DefMod*=1.8
					StrMod*=1.8
					EndMod*=1.8
					OffMod*=1.5
					Int_Mod*=0.75
					Regeneration*=1.9
					KiMod*=1.4
					//KimanipMod*=1.25
					//TrainMod*=0.75
					//SparMod*=0.75
					MedMod*=1.5
		if("Damaged Goods")
			History="Damaged Goods"
			Choice=alert(src,"A genius? Sure, all tsufurujin are, but something in your past has warped your mind. Be it brain-damage or some past trauma, you can't focus as well on your technical skills as well as your brethren, your interests frequently drifted to other thingsr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=1.5
					//KimanipMod*=1.6

		if("Capsule Degree")
			History="Capsule Degree"
			Choice=alert(src,"You got the best education money can buy at capsule corp: this gives you extraordinary ability with tech and the know-how to use it. However, the athletics program appears to still be lacking... is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.85
					//ResMod*=0.85
					SpdMod*=1.85
					StrMod*=1.85
					OffMod*=1.85
					DefMod*=1.85
					//PowMod*=0.85
					Int_Mod*=1.5
		if("Karate Kid")
			History="Karate Kid"
			Choice=alert(src,"You took to martial arts like Ninjas take to shadows. You were the kid on your block who could take down every bully in the city simultaneously without breaking a sweat. Your grades may have suffered due to your devotion, but there was no doubt in anyone's mind that you could do something with this kind of talent. Is this the kind of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.75
					//PowMod*=0.75
					Int_Mod*=1.5
					SpdMod*=1.3
					OffMod*=1.15
					DefMod*=1.15
					Regeneration*=1.1
					KiMod*=1.85
		if("School Jock")
			History="School Jock"
			Choice=alert(src,"You had an otherwise normal early life save for picking up sports at a young age. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.15
					OffMod*=1.15
					StrMod*=1.15
					//PowMod*=0.85
		if("Witchcraft and Wizardry")
			History="Witchcraft and Wizardry"
			Choice=alert(src,"Dear Mr. Potter, we are pleased to inform you... Yeah, it's already becoming a clich�, but rather than focus on athletics at your local high school, you took a different elective: Sorcery. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					//PowMod*=1.3
					//ResMod*=1.3
					KiMod*=1.5
					EndMod*=1.8
					SpdMod*=1.8
					DefMod*=1.8
					StrMod*=1.8
					//KimanipMod*=1.25
		if("Hunter by Lifestyle")
			History="Hunter by Lifestyle"
			Choice=alert(src,"Some people have crazy parents. Crazy parents who take them out into the woods under the age of four and teach them how to survive. Usually Military Style, but naturally this can happen with a red neck family too. Or someone who feels their family is being hunted by something rather nasty. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.35
					EndMod*=1.35
					Regeneration*=1.2
					//PowMod*=0.5
					//TrainMod*=1.3
					//SparMod*=1.2
					MedMod*=1.75
		if("Bushido")
			History="Bushido"
			Choice=alert(src,"The way of the warrior - You were trained and raised following a strict code of honour, wisdom and serenity. Due to your upbringing you may be serving under the president as a bodyguard, or perhaps you took what you have learned and became a stealthy ninja, dedicated to infiltrate and take down enemies before they become a threat. Though often considered the most dangerous are the 'fallen' Ronin, Warriors who have trained in the way of Bushido but have turned away from its teachings, betraying their masters or turning their back on the moral teachings, no longer bound by the rules of engagement these fallen warriors pose an even greater threat as they no longer have anything to loser. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					SpdMod*=1.2
					Regeneration*=1.9
					Recovery*=1.9
		if("Ninja")
			History="Ninja"
			Choice=alert(src,"The hidden blade is often the deadliest one. - Fast, deadly and unseen. You were trained in the arts of ninjitsu, subterfuge, assassination and infiltration. There are but few people who have an as flexible skill set as you do. Due to your intensive training from childbirth you have an unshakeable set of rules you stick to, unless you have of course gone rogue. Due to the extensive training you've become an opponent to be feared in any form of combat, but has left you fragile and stubborn when it comes to scientific advancesr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					//PowMod*=1.2
					SpdMod*=1.2
					EndMod*=1.7
					//ResMod*=0.7
					Int_Mod*=1.5
		if("Bandit")
			History="Bandit"
			Choice=alert(src,"You are a bandit, lurking in the shadows, waiting for unsuspecting victims to ambush and rob. Or perhaps you used to be a bandit and are now attempting to clear your name, regardless your history has put you at odds with the lawr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					OffMod*=1.2
					EndMod*=1.8
					//PowMod*=0.8
		if("Street rat")
			History="Street Rat"
			Choice=alert(src,"You had no parents to take care of you, no education to fall back on, you are a mere thief. Having spent your life on the street has made you tough, you learned not to count on anyone but yourself and have become pretty efficient at it, taking what you need to survive. A favourite catchphrase of you is I only steal what I can't afford, unfortunately that's everythingr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.2
					DefMod*=1.2
					StrMod*=1.8
					EndMod*=1.8
		if("Feral")
			History="Feral"
			Choice=alert(src,"You were born in the wild, you're not sure how you got there but you've lived in the wild almost your entire life. Recently you've been discovered and brought to the 'civilized' world. What strange wonders will you encounter, will you be able to comprehend what you see? One way to find outr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.2
					//ResMod*=1.2
					//PowMod*=0.5
					Regeneration*=1.3
		if("Warlord")
			History="Warlord"
			Choice=alert(src,"You are a self proclaimed ruler, annexing territory under your rule and subjugate those who dare stand in your way. You're most likely to get followers to fight for you though you more then likely prefer dominating your opponents personallyr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.4
					OffMod*=1.4
					//PowMod*=0.7
					Regeneration*=1.7
		if("Cultist")
			History="Cultist"
			Choice=alert(src,"A worshipper of mysterious and often infernal arts, you try to communicate with the afterlife in an attempt to gain their guidance, more often then not with demons in an attempt to gain more personal powerr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
				if("Yes")
					//PowMod*=1.3
					EndMod*=1.7
					//ResMod*=0.7
					StrMod*=1.7
		if("Super Hero")
			History="Super Hero"
			Choice=alert(src,"A brightly coloured cape, tight spandex suit and the obligatory underwear over your wants; a brief description of how you look in your costume. You are a super hero, be it self proclaimed or acknowledged by the world, and do your best to defend those in need. Your heroic poses are sure to strike fear into your enemies!")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.7
					StrMod*=1.7

		if("Forged from Hell fire")
			History="Forged from Hell fire"
			Choice=alert(src,"You are forged from the wicked flames of hell to be a ruthless killer, and that's exactly what you plan to do. A living embodiment of punishment, you're fairly certain you once ripped a guy's throat out for littering. You were born and raised to carry out the will of hell and the one who rules it. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.25
					StrMod*=1.25
					DefMod*=1.7
		if("Survival Game")
			History="Survival Game"
			Choice=alert(src,"Forget duty and intelligence. You've been in the Game to survive by any means necessary. Kaios offer you a deal to live in safety for the rest of eternity? Odds are you'll take it. Save a kid from being hit by a train to get in good with his strong parents? Sure thing. You're defined not so much by your morals as you are being raised to survive at any cost thanks to the harsh environment of Hell. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.5
					DefMod*=1.3
					StrMod*=1.6
					SpdMod*=1.3
		if("Playing it Smarter")
			History="Playing it Smarter"
			Choice=alert(src,"Rather than allow yourself to submit to the low intelligence and 'wild side' of the rest of your species, you've been playing it smarter since day one. You can trick a mortal out of his soul over the course of a single deal and even get yourself out of doing anything within the deal itself. You're Mephisto, the man (or in this case Demon) with the plan, though you have unfortunately sacrificed a bit of physical prowess in return. While you may think this is more of a personality, it has enough of an influence on history in Hell to stand here as well.  Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.8
					EndMod*=1.8
					SpdMod*=1.3
					Int_Mod*=1.25
		if("Chaos Incarnate")
			History="Chaos Incarnate"
			Choice=alert(src,"You are chaos incarnate, the balance between good and evil and life and death is but a toy for you to manipulate and disrupt for your personal amusement, of course you are completely unpredictable; you could be tearing down the balance one moment then drinking a cup of tea the next for no apparent reason other then feeling like itr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=rand(80,120)/100
					EndMod*=rand(80,120)/100
					SpdMod*=rand(80,120)/100
					OffMod*=rand(80,120)/100
					DefMod*=rand(80,120)/100
		if("Greater Goal")
			History="Greater Goal"
			Choice=alert(src,"Let your puny fellow demons cause chaos in the living realm or run around in the afterlife, you have bigger things to tend to. You were born or created for no other reason then furthering the cause of the greater evil. Every move you make is to to further that goal, you are quite literally the embodiment of true classic evilr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.7
					EndMod*=1.7
		if("Primal")
			History="Primal"
			Choice=alert(src,"You are a wild demonic beast, incapable of rational thought or basic communication. Perhaps as you grow older and more powerful you'll develop at least some lower level of these basic abilities but your savage nature and feral instinct will always be a distinct trait of yoursr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.3
					OffMod*=1.3
					Int_Mod*=1.5
		if("Diabolically Insane")
			History="Diabolically Insane"
			Choice=alert(src,"There is a fine line between brilliance and insanity, most often so fine its hard to see on which side a gifted person such as yourself resides. In your case however, it's pretty obvious. You're crazy, coocoo for cocoa puffs, completely and utterly insane. And yet, for all you're insanity, you produce brilliance, dangerous, lethal, brilliance. There is a distinct method in your chaos that only you can see, assuming you even see it at all. The only thing that everyone knows for sure is this: You never fail to invent some new horrible device or experiment to test out on new soulsr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=1.5
					EndMod*=1.8
					StrMod*=1.8
		if("Trickster")
			History="Trickster"
			Choice=alert(src,"When it comes to demons you're fairly innocent as far as pillaging and murdering goes. You prefer a much more entertaining side of being evil, sending heroes on a goose chase or luring them into a trap while they think you're helping them. You use your wits and cunning to entertain yourself, almost exclusively at the expense of othersr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.2
					DefMod*=1.2
					StrMod*=1.7
		if("Embodiment of Sin")
			History="Embodiment of Sin"
			Choice=alert(src, "You are the physical embodiment of one of the seven deadly sins; Lust, Gluttony, Greed, Sloth, Wrath, Envy and Pride. Your mere presence tends to be enough to make the particular sin you represent rise up in the mortals around you, making them easy for you to manipulate, control and predict. Your major goal is to corrupt souls to sin so they get sent to Hell when they dier. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.3
					SpdMod*=1.6
		if("Sacred")
			History="Sacred"
			Choice=alert(src,"You stand apart from your demon brothers and sisters, for your evil is of a whole other caliber. People worship you in the living realm, asking you to fulfill their selfish wishes like wealth or revenge. This is one of the more likely histories of a demon to go for Demon Lordr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.5
					EndMod*=1.5
					OffMod*=1.4
		if("Lord of Pandemonium")
			History="Lord of Pandemonium"
			Choice=alert(src, "Many demons claim to be a lord of demons, but when it comes to becoming the Lord of Pandemonium many try, but only one can succeed. The Lord of Pandemonium is a self proclaimed leader of demons, leading an army of a hundred demons to the living realm to cause havoc and destruction. Keep in mind that with this history odds are you are just but one of many aspiring to become the true lord of pandemonium and competition will be fiercer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					SpdMod*=1.3
					EndMod*=1.6
		if("Universal Guardian")
			History="Universal Guardian"
			Choice=alert(src,"You are a guardian of the Universe. You don't know quite how long you've stood watch over heaven, but it has been longer than most mortals have experienced in an entire family tree. You are a Guardian. A Sentinel. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					StrMod*=1.2
					SpdMod*=1.2
					DefMod*=1.2
		if("Power of the Mind")
			History="Power of the Mind"
			Choice=alert(src,"Your mind is a powerful thing. A force to be reckoned with by anyone's standards. Rather than spend your time fighting, you have spent it in quiet meditation where you have honed it into a powerful weapon. Is this the type of history you seek?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.75
					EndMod*=1.75
					SpdMod*=1.85
					MedMod*=1.75
		if("Mystical")
			History="Mystical"
			Choice=alert(src,"A kaio created from the energies of the universe. What you do and what you are is shrouded in mystery and divine confusion. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.8
					EndMod*=1.8
					KiMod*=1.25
					Recovery*=1.25
		if("Caretaker")
			History="Caretaker"
			Choice=alert(src,"While the other kaios maintain the balance and focus on training their students you focus on taking care of Heaven and the passed on souls, providing weights, planting gardens, setting up little inns and houses to make their afterlife as heavenly as possibler. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.3
					Recovery*=1.3
					StrMod*=1.8
					EndMod*=1.8
		if("Crusader")
			History="Crusader"
			Choice=alert(src,"There are few things demons fear as much as a crusader kaio, these kaios declare war on the forces of hell, deeming them a threat to the universal balance and set out to 'neutralize' this threat by any means necessary that doesn't involve freeing or helping demons. Most other kaios condemn these crusaders as violent and irresponsible as they actually do more damage to the balance then good. However a crusader, if properly restrained and directed by his fellow kaios can be one of the most valuable assets for the forces of goodr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.2
					StrMod*=1.2
					EndMod*=1.2
		if("Scholar")
			History="Scholar"
			Choice=alert(src,"You are obsessed by obtaining knowledge, the more you can learn the better. Due to living in Heaven you have the advantage of having plenty of subjects of different races to observe and study though if given the chance you'll be more then glad to take the opportunity to study them in their natural environment in the living realm. Depending on your sense of duty VS your desire to obtain knowledge you are a lot less likely to desire a position as a cardinal or the supreme kaio, instead choosing to spend the time that you'd otherwise spend maintaining the balance to obtaining more knowledge for the further benefits of the kaiosr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=2.5
					EndMod*=1.7
					StrMod*=1.7
		if("Denizen Of The Light")
			History="Denizen Of The Light"
			Choice=alert(src,"As a Kaio your already well attuned with the ways of your people, however be it from birth or maybe later in life you were either born with or have attained a level of purity that distinguishes yourself from your fellow kin and thus you are a being pure in all ways and forms. This suggests your type of upbringing may have swayed you to become a holy figure in order to spread the word of peace and love and as such you have steered clear of all forms of violent practice and thus whilst not trained much in the art of combat besides having a means of self defense your prowess in the mystical arts are top notch, there is no doubt in anyone�s mind you were created with a purpose to bring others to salvation although this firm belief might have made you somewhat na�ve to the outside worldr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					OffMod*=1.7
					DefMod*=1.7
		if("Despondent Kaio")
			History="Despondent Kaio"
			Choice=alert(src,"Once a caring and empathetic young being, who only wanted to help the universe and it's inhabitants. However, centuries of war, man made catastrophes and general hatred shown in the galaxy have caused you to be disappointed with pretty much all life forms outside of Heaven. You're still bound to your duties as a Kaio, though you don't deal with others with a smile on your face, and you pretty much resent them every step of the way, questioning why you even bother. (this however in no way entitles you to be an 'evil kaio' you can be a jerk about it, but you still do your job)r. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.4
					OffMod*=1.4
					EndMod*=0.8
		if("Ancient")
			History="Ancient"
			Choice=alert(src,"Kaios, like demons, live quite long. You are an elder among your race, experienced beyond comprehension of the fledglings of your species. You consider it your duty to educate them and guide them to a desirable future, teaching them the mysteries of the universer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					DefMod*=1.3
					SpdMod*=1.3
					StrMod*=0.7
					EndMod*=0.7
					OffMod*=0.7
		if("Judge")
			History="Judge"
			Choice=alert(src,"At one point in time and perhaps even now you were known as king/queen Yemma, passing judgement on the souls of the dead, sending them either to Heaven or Hell. You have a natural talent to see through lies and deceit which helps you sort out the 'bad weeds' that try to sneak into Heavenr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=0.7
					EndMod*=0.7
		if("Bounty Hunter")
			History="Bounty Hunter"
			Choice=alert(src,"You were built to hunt what the Android Ship deems to be a threat. A perfect machine that can blend into the shadows and strike when the time is right. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					MedMod*=0.75
					SpdMod*=1.4
					DefMod*=1.3
					Regeneration*=1.2
					KiMod*=1.25
		if("Project: Domination")
			History="Project: Domination"
			Choice=alert(src,"Crush the little races! Conquer the galaxy! Unlimited Rice Pudding! Etcetera! Etcetera! You were built for a single purpose- conquer the universe and crush what opposes you. If this were terminator you certainly aren't Arnold Schwarzenegger. It might be a good idea for those who stand against you to consider reprogramming you entirely rather than struggle against the power you have been granted. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.35
					StrMod*=1.35
					SpdMod*=1.3
					DefMod*=1.3
		if("Biological Research")
			History="Biological Research"
			Choice=alert(src,"Why destroy what should be properly analyzed and researched? After all, a couple million years of evolution has to have done something that the android ship hasn't thought of yet, right? Your goal is simple: Analyse various species and their odd habits; report the data back to the android ship. How you do this though, is up to you... Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.25
					SpdMod*=1.2
					DefMod*=1.2
					OffMod*=0.85
					StrMod*=0.85
					Regeneration*=1.15
		if("Energy Experiment")
			History="Energy Experiment"
			Choice=alert(src,"You are the Android ships gateway to an entire new fuel source- Ki energy. You have been built around it's manipulation and usage, and designed to learn more about it from other species when the time is right. By any means necessary. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=0.85
					Regeneration*=0.5
					KiMod*=1.25
					Recovery*=1.5
		if("Upgrader")
			History="Upgrader"
			Choice=alert(src,"The mothership created you to apply updates to existing systems and androids, as such your primary programming doesn't include much in terms of combat but your intelligence is far greater then your fellow androids, allowing you to even develop some form of free will unconnected to the mothership over timer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=2.5
					StrMod*=0.6
		if("Battledroid")
			History="Battledroid"
			Choice=alert(src,"You were programmed by the mothership to wage war, to go to worlds and conquer it so the worlds resources can be used to further benefit the sentient AI of the mothership. Battledroids are locked and loaded with a wide variation of weaponry, ranging from using built in arm lasers or overwhelming physical prowessr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					EndMod*=1.3
					KiMod*=0.7

		if("Combat Doll")
			History="Combat Doll"
			Choice=alert(src,"Contrary to the rest of your brethren, you are made for combat- raised for combat. Energy manipulation? Pfft. What's a ki blast Vs. a good punch to the face? This type of upbringing usually results in violent tendencies, though not always. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.35
					StrMod*=1.35
					SpdMod*=1.25
					DefMod*=1.25
					OffMod*=1.25
					Recovery*=0.75
					Regeneration*=1.3
					KiMod*=0.75
		if("Revered")
			History="Revered"
			Choice=alert(src,"Where you came from you have always been worshipped, something to be praised and adored. Because of this you might be frailer then some but the many tributes you have received have made you quite wealthy indeedr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=0.8
					OffMod*=0.8
					SpdMod*=1.3
		if("Ki Specialist")
			History="Ki Specialist"
			Choice=alert(src,"Normal spirit dolls are good with ki, but you, you are a specialist. With ki energy you can do things that others can only dream of, manipulating it as you see fit. Creating a giant ki dragon to entertain at a party? No problem. Using said dragon to destroy enemies? Why not?")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.2
					StrMod*=1.3
					EndMod*=1.4
		if("Pinocchio")
			History="Pinocchio"
			Choice=alert(src,"You may be a doll inhabited by a spirit, but what you really want to be is a real living creature! Your entire life you've spent trying to find of a way to shed this crafted body you inhabit and find a way to get a real body, due to this you've found yourself to be quite perseveringr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.1
					Regeneration*=0.8
					Recovery*=0.8
					DefMod*=1.2
					StrMod*=0.9
		if("Spy")
			History="Spy"
			Choice=alert(src,"Due to your low profile you make for an excellent spy, using fast and precise ki attacks to end a fight quickly if need be though you prefer to avoid fights entirely if possible, instead getting your objective and leaving without anyone becoming any the wiserr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					SpdMod*=1.2
					EndMod*=0.8
		if("Circus")
			History="Circus"
			Choice=alert(src,"Due to your size and look you were quickly recruited into the circus at a young age, performing agile tricks and using your natural ability for ki energy to astonish the crowds. You were the star attraction and proud of it, unfortunately the circus had to close down, leaving you home- and worklessr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.3
					OffMod*=1.3
					DefMod*=1.3
					EndMod*=0.5
					StrMod*=0.5
		if("Drone")
			History="Drone"
			Choice=alert(src,"You're practically stuck in a mindless husk you can't control, following the orders of the one that 'created' you by putting you in here. Once your objective is complete however you hope you'll receive your free will again, unfortunately you're not sure if this is actually the case..Only time will tellr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					Regeneration*=0.8
					Recovery*=0.8
		if("Warrior-type Namekian")
			History="Warrior-type Namekian"
			Choice=alert(src,"Naiillll. Gather the Dragonballs and wish for a Plasma TV! You are a warrior Namekian like Nail- strong and fast, Namek's number one son when it comes to combat! Raised in the ancient ways, but perhaps if you'd been raised in the NEW way you'd have stood a chance... is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.25
					StrMod*=1.25
					SpdMod*=1.3
					DefMod*=1.3
					OffMod*=1.3
		if("Dragon Clan Namekian")
			History="Dragon Clan Namekian"
			Choice=alert(src,"'Call me Super Kami... no wait, Super Kami Guru', this type of Namekian is most famous for the ability to create the mighty Dragonballs. And while the Namekian Elder and Earth Guardian posses this ability regardless of race, this is the most likely clan to make them just because. They aren't the greatest of fighters, but when left to their private thoughts long enough... is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=0.75
					EndMod*=0.75
					SpdMod*=0.75
					OffMod*=0.75
					DefMod*=0.75
					MedMod*=1.75
					KiMod*=2.5
		if("Demon Clan Namekian")
			History="Demon Clan Namekian"
			Choice=alert(src,"Are you a Yoshi? While Ancient Nameks as a race are based off King Picollo, this is for those who preferred the brighter green Z-version of the character. It works something like a combination between the Dragon Clan and Warrior-type without all the complex Dragonball and Duty stuff. This is the most likely Namekian clan to become evil. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.15
					EndMod*=1.15
					DefMod*=0.9
					Regeneration*=1.15
					KiMod*=1.25
					MedMod*=1.25
		if("Secluded Namekian")
			History="Secluded Namekian"
			Choice=alert(src,"This type of Namekian didn't grow up in a Namekian city or around any people whatsoever. They didn't have a clan or anyone to talk to in all likelihood- instead they were left to their own devices with unknown results. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=0.8
					StrMod*=0.8
					Recovery*=1.25
					MedMod*=1.15
		if("Born to Rule")
			History="Born to Rule"
			Choice=alert(src,"Every once in awhile there comes a Changeling on the wild icer planet that is raised to be above his brethren- a ruler in a den of thieves so to speak. You were that Changeling. While still most likely evil and cruel, you possess the training and thus most likely ability to unite your Changeling brethren. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					StrMod*=1.2
					SpdMod*=1.3
					OffMod*=1.3
					DefMod*=1.3
					KiMod*=0.95
					MedMod*=1.25
		if("Seas run Red")
			History="Seas run Red"
			Choice=alert(src,"How to put this... your history makes Jack the Ripper look like a productive and responsible member of society. In short- what didn't agree with you you killed, what did agree with you you still killed (just more quickly). Your history is as red as the entire history of the Roman empire combined, and that's just to date. Is this the type of history you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.4
					StrMod*=1.45
					DefMod*=0.75
					MedMod*=0.65
		if("Sibling issues")
			History="Sibling issues"
			Choice=alert(src,"As far as you can remember your parent(s?) were always going ooon and ooon about how good your brother or sister was, especially in comparison to you. This has left you frustrated and on a self set path to outshine your sibling in everythingr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=0.7
					StrMod*=1.2
					OffMod*=1.2
					DefMod*=0.9
		if("Glacial Hunter")
			History="Glacial Hunter"
			Choice=alert(src,"While the other Changelings fight over dominance you focus on what's important; surviving. You hunt the cold glacial domains of your world, taking down what scarce prey remains and changelings that dare try to take what you needr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.3
					OffMod*=1.2
					SpdMod*=1.2
		if("Savage")
			History="Savage"
			Choice=alert(src,"On a ruthless world like the changeling home world it's no surprise that certain tribes have remained barbaric despite the overall civilizations advancing to more modern methods. You live by might makes right, taking what you want, technology however is something you prefer to avoidr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.4
					SpdMod*=1.8
					OffMod*=1.2
					DefMod*=1.8
					Int_Mod*=1.5
		if("Exiled")
			History="Exiled"
			Choice=alert(src,"You were the leader of a group of changelings, perhaps of a small band of misfits, or perhaps even of the entire planet. Whatever you were however was short lived, you got stripped from your position and exiled to wander alone into the wastes of your home world. Due to your bad experience with your previous group you are hell bent on revenge, be this by recruiting the help of the more savage changeling tribes and start an empire or simply by taking them out one by one by yourself, you know one thing very well. As far as leaders go: There can be only oner. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					BPMod*=1.3
					DefMod*=1.8
		if("Scientific")
			History="Scientific"
			Choice=alert(src,"Unlike your changeling brethren you've decided that technology is the best way to gain power. As such you've devoted a lot of your time tinkering and inventing new gadgets, broadening your knowledge and intelligence every day until you can finally assume your rightful place as ruler of all you see fitr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					KiMod*=1.7
					Int_Mod*=2
		if("Runt")
			History="Runt"
			Choice=alert(src,"You've spent almost your entire life being picked on and beat up by the other changelings because you were weaker and different in some way. This abuse has left you particularly malicious and hateful towards the outside world, your fellow changelings especially. A changeling with this history is unlikely to work together with others though they'd probably enjoy dominating weaker races into servituder. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
				//	BPMod*=1.7
					SpdMod*=1.3
					OffMod*=1.3
		if("Goon")
			History="Goon"
			Choice=alert(src,"You've spent your life serving under someone else and you realized one thing: Steady work means steady pay. You're not the type to stand on top; following orders is easier than making them upr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.1
					MedMod*=1.8
					StrMod*=1.8
		if("Frostdemon")
			History="Frostdemon"
			Choice=alert(src,"Much like the demon clan namekians you consider yourself a physical embodiment of evil. You are no mear changeling but a demon born of the frost and death of the millions who had come before you. The one thing you seek above all else is glory and power, this type of history could easely try to obtain godhood/immortality and would be quite eager to try and take over the afterlife itself should it ever find out it existsr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.3
					OffMod*=1.3
					StrMod*=1.3
		if("Cult Leader")
			History="Cult Leader"
			Choice=alert(src,"You lead or have led a demonic cult, conjuration, contact with the dead, black magic, you've endeavoured it all in your search for power. Growing ever mightier an obtaining more and more support and influence as time goes onr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.8
		if("Sorcery")
			History="Sorcery"
			Choice=alert(src,"You wield black magic, using it to vanquish or torture your foes and victims. You take a special delight in testing out new spells/attacks on innocent bystanders, seeing them panic and writhe in pain simply brings a smile to your facer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.5
					EndMod*=1.7
					DefMod*=1.7
		if("Grunt")
			History="Grunt"
			Choice=alert(src,"You're not very ambitious, following orders and crushing things that stop you from executing those orders. You're more physically orientated then the leaders on the Makyo Star. That said, the influence of the Makyo Star when you're on another planet fills you with power and ambition, causing you to dominate all in your way as you see fitr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					EndMod*=1.3
					SpdMod*=1.8
					DefMod*=1.8
		if("Legacy")
			History="Legacy"
			Choice=alert(src,"You are the offspring of a great lord of the Makyo people, however as fate would have it your family was stolen away from you, never to be seen again. You are enraged by this injustice and seek out to destroy those who are responsible for what happened as compensation. For now you bide your time on the Makyo Star, plotting you revenger. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.2
					OffMod*=1.2
					DefMod*=1.2
					EndMod*=1.7
		if("Planetary corrupter")
			History="Planetary corrupter"
			Choice=alert(src,"You travel from world to world with the Makyo Star, bringing chaos and corruption wherever you arrive. You care nothing for the inhabitants of the planets you visit, nor the consequences of your actions for them. Planetary Corrupters can take the direct approach and cause trouble, but they're more likely to indirectly ruin a planet, for example by destroying the plant life rather then attacking fightingr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					DefMod*=1.8
		if("Road of Loss")
			History="Road of Loss"
			Choice=alert(src,"Slowly, steadily, your race has declined until only few remained. You've watched most of your friends and family die. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.25
					SpdMod*=1.75
					DefMod*=1.25
		if("One of a Kind")
			History="One of a Kind"
			Choice=alert(src,"You are pretty much the last of your race, and the only one of your kind that you've ever known. The most wonderful thing about you? You're the only one. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.25
					SpdMod*=1.75
					DefMod*=1.25
		if("Ancient Civilization")
			History="Ancient Civilization"
			Choice=alert(src,"You are part of a race who was civilized before most species in the universe were crawling out of the mud. Architecture and mathematics have been known for quite awhile. Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=1.25
					EndMod*=1.25
					StrMod*=1.75
		if("Enforcer")
			History="Enforcer"
			Choice=alert(src,"With a race as diverse and full of mutations as yours it only stands to reason that enforcers were appointed, its been your job, your duty, to evaluate if one of your kin is a threat to the throne or even the entire population of Hera, defending your very planet against the potential threat that might come from withinr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					BPMod*=1.2
		if("Seperated")
			History="Seperated"
			Choice=alert(src,"Your type of Heran have always been connected to a communal consciousness, your connection has somehow been severed though, perhaps through medical experimentation by an Heran scientist, or you are the last remaining. The point is that you now have to think for yourself and can no longer depend on the safety and comfort of the hive mindr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					DefMod*=1.1
					OffMod*=1.8
		if("TOKUSENTAI")
			History="TOKUSENTAI"
			Choice=alert(src,"TOKUSENTAI,TOKUSENTAI,TOKUSENTAI! You are part of an elite squad of Herans, fighting for the highest bidder, the crown, or just for the hell of it. You quickly made your name across the entire planet however what happens now is up to you, perhaps your squad has been killed when they went on an expedition without you, or you decided it was time to branch out and start your own elite squad, only time will tellr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=rand(80,120)/100
					EndMod*=rand(80,120)/100
					SpdMod*=rand(80,120)/100
					OffMod*=rand(80,120)/100
					DefMod*=rand(80,120)/100
		if("Fabulous")
			History="Fabulous"
			Choice=alert(src,"Just because you're a warrior doesn't mean you don't have to take care of your looks. You consider yourself drop dead gorgeous though others may describe you as flamboyant, they're obviously just jealous of your stunning looks and keen fashion sense though so there's no point in paying them much heed. This type of Heran is as narcissistic as an oozaru is bigr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					SpdMod*=1.2
					DefMod*=1.2
					StrMod*=0.5
		if("Technomancer")
			History="Technomancer"
			Choice=alert(src,"You're one crazy scientist, using the wonders of science to emulate things you've always wanted to be able to do that you've read about in fantasy books like using remote control planes to imitate throwing fireballs at people. Despite your lacking grip on reality however you're quite a genius when it comes to technology, pulling off things most people consider impossible and ridiculous through sheer randomnessr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=2
					StrMod*=1.7

		if("Special Spawn")
			History="Special Spawn"
			Choice=alert(src,"Your demon parent was interesting even for it's race, and may have passed some curious physical features on to you... Is this the type of History you want?","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.25
		if("Overly aggressive")
			History="Overly aggressive"
			Choice=alert(src,"You're the spawn of a saiyan and demon, what did you expect? The raw power you command is hard for you to control, as is your temper. In an argument you are not only most likely the first person to throw a punch, you're also the most likely to first kill someone to end it. The combination of saiyan and demon blood coursing through your blood has made you even more devastating and ruthless then a normal saiyan or demon would be able to pull offr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.5
					EndMod*=1.5
					SpdMod*=0.7
					DefMod*=0.7
		if("Primitive")
			History="Primitive"
			Choice=alert(src,"You saiyan, you demon, you don't know. It seems when it comes to intelligence you got the short end of the stick, basically ending up as a primitive, stronger then normal saiyan-caveman. The demonic blood coursing through your veins increasing your lust for blood and combat that your saiyan blood instils even furtherr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					OffMod*=1.3
					DefMod*=0.6
		if("Demi-Hunter")
			History="Demi-Hunter"
			Choice=alert(src,"You have dedicated your life to tracking and hunting down demi-gods, showing no mercy to your celestial counterparts. Why you this might be unclear, perhaps you're doing it to prove you're stronger, or to upset the balance like demons tend to enjoy doing, perhaps your saiyan blood sees them as a worthy challenge, who knows. Your history has put you at odds with kaios,who will be less likely to trust you if they hear of your exploits, demons however are more likely to take a shine to your. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.3
					SpdMod*=1.3
		if("Pure evil")
			History="Pure evil"
			Choice=alert(src,"You may have saiyan blood along side your demon blood but there's no doubt which of the two is dominant. You take great pleasure in the slaughtering of kaios, demigods and innocent bystanders, going out of your way if it will inflict extra misery or pain on themr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.2
					OffMod*=1.2
					EndMod*=0.9
					StrMod*=0.9
		if("Honorable warrior")
			History="Honorable warrior"
			Choice=alert(src,"Your blood does not define who you are. You focus on honourable combat against your foes and as long as it's a fair fight, show no mercy. You're likely to power down to equal the playing field against an opponent but once a fight starts against a demigod or kaio you're still in it till death, regardless of whatever age or power the opponent might haver. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					DefMod*=1.3
					Recovery*=1.3
		if("Tactician")
			History="Tactician"
			Choice=alert(src,"Your above average intelligence and keen sense of strategy makes you the perfect candidate to be a tactician for the Arbiter, or perhaps the Arbiter himself. You plan out the expected enemy forces and how best to handle them so that casualties stick to a bear minimumr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=1.5
		if("Perfect Specimen")
			History="Perfect Specimen"
			Choice=alert(src,"You have been tasked with the mission of becoming the perfect specimen by your creator. All life in the universe serves to sustain you and you long to complete yourself by absorbing all that you come across to reach your ultimate goal; perfectionr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.2
					StrMod*=1.2
					SpdMod*=1.1
					DefMod*=1.1
					EndMod*=0.7
		if("Failed Experiment")
			History="Failed Experiment"
			Choice=alert(src,"Your creator tried to create the ultimate life form, (s)he failed...Or so (s)he thought. You were discarded by your creator, (s)he probably even tried to dispose of you by destroying you. This betrayal has left you with a deep hatred for your creator and his race as a whole, leading you to set out on a path of vengeance and to prove you are indeed the ultimate life formr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.2
					SpdMod*=0.7
					Regeneration*=0.8
		if("Corrupt Data")
			History="Corrupt Data"
			Choice=alert(src,"Your mission is unclear. Something seems to have gone wrong during the final stages of your creation and has somehow resulted in a less than perfect being. Unknown to you, the purpose of your creation is shrouded in darkness and you yearn to complete the puzzler. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Recovery*=1.5
					StrMod*=0.8
		if("Voidling")
			History="Voidling"
			Choice=alert(src,"Instead of being created in a lab you were born like any other creature, far beyond the known universe on a planet possibly full of your species. For reasons known only to you, or perhaps not even by you, you were sent away and arrived in the known universe with only one desire; to devour everything to reach your mature, perfected stater. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=rand(80,120)/100
					EndMod*=rand(80,120)/100
					SpdMod*=rand(80,120)/100
					OffMod*=rand(80,120)/100
					DefMod*=rand(80,120)/100
		if("Evil Hunter")
			History="Evil Hunter"
			Choice=alert(src,"As a being manufactured to be the ultimate hunter, your creator was a true and good hearted person. You were not manufactured to be a weapon to harm, but preserve. With single minded devotion toward hunting all forms of evil, your initial mission has become unbalanced. Instead of hunting only evil, you seek to eliminate all who have the potential to be corruptedr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.3
					//PowMod*=1.3
					EndMod*=0.7
					//ResMod*=0.7
		if("Enslaved")
			History="Enslaved"
			Choice=alert(src,"You were created or summoned by an inferior being, only to end up enslaved by your now master. Perhaps you are still enslaved, or perhaps you have managed to break free and are now able to do what you want whenever you want without telling you what to do, ofcourse due to your nature, a lot of people are likely to sufferr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.1
					//ResMod*=1.1
					DefMod*=0.8
		if("Bringer of the end")
			History="Bringer of the end"
			Choice=alert(src,"You are an ancient creature of doom and demise, taking pleasure in destroying entire galaxies and empires for no other reason then your personal amusement. Wherever you go, only one thing is certain; death is sure to followr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					//PowMod*=1.3
					OffMod*=1.3
					DefMod*=0.7
					//ResMod*=0.7
		if("Glutton")
			History="Glutton"
			Choice=alert(src,"The hunger...you're so hungry..You devour everything and everyone in an attempt to sate your eternal hunger, unfortunately apart from a few seconds of satisfaction you gain little from it, apart from the power increase that you get for every person unfortunately enough to be absorbed by you of courser. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					//ResMod*=1.2
					DefMod*=0.6
					SpdMod*=0.6
		if("Genetic Experiment")
			History="Genetic Experiment"
			Choice=alert(src,"Long ago there was a bright young prodigy in an alien civilization of brilliant minds. In order to pass their extremely selective exams, mere four year old children are tasked with producing an experiment of value to society. The bright young mind in question created you as his invention. A chemically and genetically altered square of jello that somehow gained intelligence. In a cruel twist of fate, you devoured your creator and gained a more stable form. You know what it means to be weak. You know that even the most pathetic life form could end up a threat if unattended. Luckily they'll serve a better purpose once they've been absorbed by your. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.3
					DefMod*=1.3
					Int_Mod*=2
					EndMod*=0.7
					//ResMod*=0.7
		if("Salamander")
			History="Salamander"
			Choice=alert(src,"You are a creature of fire incarnate, associated with both life and death. Often mistaken for dragons due to their shape they're known to burn down entire worlds so their young can be born and grow up. Once the Salamanders leave though the planets tend to regrow more lush then ever. In the past your kind walked freely in the living realm next to the mortals, sometimes even getting worshipped for your affinity to flame. Nowadays however your kind has become more and more rare, as such your goals differ from the average Ancient, whereas the standard Ancient seeks to maintain his/her version of balance between good and evil throughout the universe you are something more primal, doing what you want because you want. Perhaps your goal is to reclaim a world for your kind or to spread the glorious warmth of fire throughout the universe until every single planet is reduced to charred earth. A Salamander is a lot stronger in terms of physical prowess then its standard Ancient counterparts, using its affinity to fire to supplement it's fighting with flame based ki attacksr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.5
					EndMod*=1.5
					SpdMod*=1.3
					OffMod*=1.2
					Regeneration*=1.4
					Recovery*=1.4
		if("God of War")
			History="God of War"
			Choice=alert(src,"You are an instrument of destruction throughout the universe, spurring mortals to fight each other via clever manipulation or straight out taunting, an alternative possibility is that you go around fighting everyone looking for a challenge in an attempt to find someone who can sate your lust for battle and can match you in terms of skill. A God of War is unlikely to show mercy, you dont care if people or planets die because they just dont matter to you. This history is based on Billsr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.4
					OffMod*=1.4
					DefMod*=1.4
					EndMod*=0.8
					Regeneration*=0.8
					Recovery*=0.8
		if("Ancestor")
			History="Ancestor"
			Choice=alert(src,"The original vision for the Ancient race, you are the ancestor of the kaios and demons come to the universe for reasons known only to you. The great great great great grandchildren of your people now run the universe and you feel that you shall decide if they are doing a good or bad job. As an Ancestor you poses both good and evil in relatively equal measure, though your character can lean more towards one then the other. If given the chance between taking a life and sparing it however you would generally decide to spare it so that the person you spared might better try to adapt his/her lifestyle to your visionr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.4
					StrMod*=0.8
					OffMod*=0.8
		if("Keeper")
			History="Keeper"
			Choice=alert(src,"You are a keeper of secrets, the knowledge locked deep away and unknown to others has been a subject of study for you for the entirety of existence. Dragonballs? You know about them. Super Saiyan? What variation, there's over six, seven if you count that fake form. Basically you know knowledge that hasn't been revealed yet in the wipe with as purpose to make stuff happen. Providing IC motivation or manoeuvring pawns into place for your plot to bear fruit. The Keeper is a difficult history to play due to the cunning it takes to manipulate the right people at the right moments but can easily push a wipe forward all by itselfr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.5
					DefMod*=1.5
					StrMod*=0.7
					EndMod*=0.7
		if("Observer")
			History="Observer"
			Choice=alert(src,"Whereas the other kind of Ancients take a rather direct approach in terms of interacting or influencing mortals and the descendants of your people, you decide to merely observe and learn. The observer specialises in learning as much as it can from a species simply by watching its decisions and movements, due to your intelligence and natural curiosity you're also a lot more inclined to dabble in science and inventions, giving you a unique niche compared to the other types of Ancients. Although you find other races, mortals in particular, to be extremely interesting, odds are you wouldn't make yourself known even when they died unless you believed you'd be able to acquire knowledge through the interaction that would've been lost had you just observed. (Via this way an Observer can become slowly more direct over time")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=3.3
		if("Elder")
			History="Elder"
			Choice=alert(src,"You are an elder namekian, far older then any of the young offspring that inhabit your home world now. You provide them with insight and advise, guiding the newer generations towards their futurer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Regeneration*=1.1
					Recovery*=1.1
					SpdMod*=0.7
					StrMod*=0.9
					EndMod*=0.9

		if("Scientist")
			History="Scientist"
			Choice=alert(src,"Unlike your younger namekian counterparts you've spent most of your life studying science, focussing on inventing new and discovering new things. Of course if you use this technology to help or sabotage your fellow namekians is entirely up to your. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=2
					Regeneration*=0.8
					Recovery*=0.8
					StrMod*=0.9
		if("Saiyan Heritage")
			History="Saiyan Heritage"
			Choice=alert(src,"Your saiyan blood might be diluted, but you can still feel it pulsing strongly deep within you! The very thought of potential combat gets your blood pumping, despite being sired by a half blood saiyan and a human you feel a strong connection to your saiyan heritager. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.1
					SpdMod*=1.1
					DefMod*=0.8
					OffMod*=0.8
		if("Academic")
			History="Academic"
			Choice=alert(src,"You have taken to studying, living a relative normal life compared to most others of you heritage you decided to embrace your human side and went out to sate your curiosity, taking to science rather then fightingr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=2
		if("Hidden Potential")
			History="Hidden Potential"
			Choice=alert(src,"Quarter saiyans have always been somewhat special, but you seem to gain even more power at an even faster rate then normal for one of your kind. Your family has either embraced you or shunned you for this, encouraging or fearing your developmentr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					BPMod*=1.5
		if("Ki prodigy")
			History="Ki prodigy"
			Choice=alert(src,"Potentially as a result from the human blood coursing through your veins, you have always been particularly good at ki energy manipulation, as a child this quickly became apparent to those around you, perhaps you fired off ki blasts whenever you had to burp, or created your own rattle of ki energy to amuse yourself. Point is, you're good with kir. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					SpdMod*=0.8
					DefMod*=0.8
		if("Treasure Hunter")
			History="Treasure Hunter"
			Choice=alert(src,"Your parents and grandparents have always told you tales about what wondrous things they found when they were still in the prime of their life, ancient relics, ruins, discovering long lost secrets on abandoned worlds, perhaps even the dragonballs. These exciting tales enthralled you, fascinated you to where you decided that when you had the chance, you'd set out for yourself so you could experience adventure, and maybe obtain some fortune in the processr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					SpdMod*=1.2
					Regeneration*=1.3
					Recovery*=1.3
					StrMod*=0.8
					EndMod*=0.8
		if("Ancient Bloodline")
			History="Ancient Bloodline"
			Choice=alert(src,"Your bloodline is shrouded in mystery, you have no idea who your parents were let alone your grandparents, what you do know however is that you stand out among the others around you. Your power is far greater then any human your age and you seem to have a natural talent for combat that would take most years of practise to matchr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					OffMod*=1.3
					DefMod*=1.3
		if("Educated")
			History="Educated"
			Choice=alert(src,"Your parents took a particularly keen interest in your education, doing their very best to get you in the highest ranking schools and day cares to assure that you'll get all the opportunities such a bright mind as yours deserves. Of course, if you are truly as intelligent as your parents think you are, let alone interested in the education their forcing you through is a different storyr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=3
					StrMod*=0.8
					EndMod*=0.8
		if("Enhanced")
			History="Enhanced"
			Choice=alert(src,"You were created in lab as a genetic experiment to see what would happen if one would combine a small amount of saiyan DNA with human DNA, in the hopes of creating an even more powerful merger then the half saiyans, they succeeded. Your power far exceeds expectations for a child your age, matching adult saiyan warriors from the olden days, and that at birth no less! How you got out into the world is up to you to decide, perhaps you were released, perhaps you broke out. Whatever the choice, you're free now and your saiyan instincts are starting to surfacer. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.3
					StrMod*=0.7
		if("Best Of Both Worlds")
			History="Best Of Both worlds"
			Choice=alert(src,"Lucky you, due to the differences in race between your parents you have been brought up with the principles of both Saiyans and Humans. Whilst you may have experienced the rough training regimen your Saiyan parent had outline for you from birth you have also come to enjoy the lighter side of living thanks to their human spouse ranging from anything to being spoilt rotten as a kid or maybe even attending school as others of your upbringing may have done. Although the combined style of parenting may have distanced you slightly from friends not of a similar background you�ve somehow still come out an aspiring fighter whilst not sacrificing your values of educationr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.2
					OffMod*=1.2
					DefMod*=0.8
		if("Elite")
			History="Elite"
			Choice=alert(src,"Your saiyan blood might be diluted with human blood but that wont stop you from proving that you're one of the strongest saiyans alive! At least one of your parents was a prideful saiyan elite and raised you with the values of a true saiyan. Your heritage fills you with pride (go figure) and you've been trained the saiyan way, making you far more aggressive then your human-dominant counterpartsr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					EndMod*=1.2
					DefMod*=0.8
		if("Living Weapon")
			History="Living Weapon"
			Choice=alert(src,"After the saiyans saw the result of mixing human and saiyan blood a splinter faction decided to weaponize this new crossbreed. You were either raised by members of this faction or created in a lab for this purpose, of course if you actually went along with the plans of your parents or creators is up to you, perhaps you broke free once you felt you had enough training and had nothing to gain any more, or perhaps you got sick of how they treated your. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					DefMod*=1.2
					EndMod*=0.5
		if("Royal Descendant")
			History="Royal Descendant"
			Choice=alert(src,"You hail from a lineage of Saiyans bearing royal blood. Perhaps the lineage is immediate or goes all the way back to your ancestors but because of this your Saiyan parent has raised you upon the ideals that you are a class above all else and as such you have made every effort to hone your skills to reflect this. Sure you may be a little too prideful, some might even say arrogant however your remaining Human parent may have raised you in such a way to balance this out with an easier side of living and kept all this from getting to your head, or who knows maybe they even further encouraged this belief and forced you more so to live up to your Royal Predecessorsr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					OffMod*=1.3
					BPMod*=1.2
					DefMod*=0.8
					EndMod*=0.8
		if("Superior")
			History="Superior"
			Choice=alert(src,"Following the saiyan pride of your heritage you consider yourself a near perfect warrior, but you take it a step further; you don't just consider yourself better then humans, but you consider yourself superior to pure blooded saiyans aswell. Has your combined heritage not made you stronger then either!? From a young age you decided your goal would be to prove your superiority to all who dare question it, let alone who dare to challenge itr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.2
					SpdMod*=1.2
					EndMod*=0.8
		if("Half blood resentment Saiyan")
			History="Half blood resentment Saiyan"
			Choice=alert(src,"You grew up a child of two worlds. The Elites looked down upon you for not being full blooded saiyan, you were beaten, made fun of, never respected by anyone for who you were. Over the years you grew to hate the human half of your heritage. You hated your parents and blamed them for what they made you. All you have is your abilities, you are determined to show the other saiyans that blood isn�t everythingr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.1
					DefMod*=0.8
					SpdMod*=0.8
		if("Cursed")
			History="Cursed"
			Choice=alert(src,"Your entire life you've felt like whatever form of a god or higher entity was out to get you and to make your life miserable, you have no idea what you did to anger this entity but even the golden glow of the sun seems to make you twist in fear, almost as if its bright shine was somehow related to this fearsome entity, probably some golden man in the sky or something. Due to your constant failure and bad luck you've become a lot more endurant then mostr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.5
					DefMod*=0.6
					SpdMod*=0.6
		if("Reluctant Scientist")
			History="Reluctant Scientist"
			Choice=alert(src,"Your parents always wanted you to become a brilliant scholar but they didn't keep your motivation or dreams in mind at all. Due to this you've been forced through the educational system with a lot of effort and know more then the typical earthling, that said your studies have held back your progress when it comes to martial arts and ki manipulation but who knows, its a new day and you might decide to finaly throw this around and do what you've always wanted to make up for lost time!")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					Int_Mod*=2
					OffMod*=0.9
					StrMod*=0.9
		if("Centered")
			History="Centered"
			Choice=alert(src,"You are cool, calm, collected. Trained since birth to be a prominent martial artist you have obtained more skill then most of your kind. Your methods tend to differ though the goal is almost always the same, pushing your abilities to the very limit to try and improve yourself even furtherr. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					MaxAnger*=0.2
					OffMod*=1.3
					DefMod*=1.3
					SpdMod*=1.3
		if("Ki prodigy")
			History="Ki prodigy"
			Choice=alert(src,"Potentially as a result from the human blood coursing through your veins, you have always been particularly good at ki energy manipulation, as a child this quickly became apparent to those around you, perhaps you fired off ki blasts whenever you had to burp, or created your own rattle of ki energy to amuse yourself. Point is, you're good with kir. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					StrMod*=1.3
					EndMod*=1.3
					SpdMod*=0.8
					DefMod*=0.8
		if("Half blood resentment Human")
			History="Half blood resentment Human"
			Choice=alert(src,"You grew up a child of two worlds. The humans never fully understood you. They picked on you and made fun of your tail. To them you weren�t human, and they feared that. You were greeted with fear, sometimes even anger. You loved your parents but you still blamed them for what they made you. From a young age you were able to run faster and hit harder than any of your peers. It made people shun you, but deep in your heart you always knew you were meant for great things. You are determined to earn the trust and respect of a race that has feared you their whole lives. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Historys()
				if("Yes")
					EndMod*=1.2
					OffMod*=1.2
					StrMod*=0.8
					DefMod*=0.8

///mob/verb/Historyman()
//	set name = "Set History"
//	set category="Other"
//	if(History == null)
//		Historys()
////	else
	//	src << "You already have a history"


mob/proc/Personality()
	var/list/Personalitie=new/list
	Personalitie.Add("Normal") //Anyone can be Average!
	if (Race=="Human"|Race=="Saiyan"|Race=="Makyojin"|Race=="Kanassan"|Race=="Namekian"|Race=="Spirit Doll"|Race=="Shinjin"|Race=="Tuffle"|Race=="Demigod"|Race=="Heran"|Race=="Alien"|Race=="Werewolf"|Race=="Primal Ape")
		Personalitie.Add("Pacifist")
		Personalitie.Add("Studious")
		Personalitie.Add("Shy")
		Personalitie.Add("Stubborn")
		Personalitie.Add("Loner")
		Personalitie.Add("Ruthless")
		Personalitie.Add("Friendly")
		Personalitie.Add("Impish")
		Personalitie.Add("Calm")
		Personalitie.Add("Eccentric")
		Personalitie.Add("Businessman")
		Personalitie.Add("Bubbly")
		Personalitie.Add("Dependent")
		Personalitie.Add("Bossy")
		Personalitie.Add("Sagacious")
	if (Race=="Demon")
		Personalitie.Add("Demonic")
	if (Race=="Shinjin") //Kaios get theirs too, pretty much the opposite of demons.
		Personalitie.Add("Divine")
	if (Race=="Changeling"|Race=="Android"|Race=="Kanassan"|Race=="Demon"|Class=="Ancient")
		Personalitie.Add("Overlord")
		Personalitie.Add("Dominator")
	if (Race=="Changeling"|Race=="Kanassan"|Race=="Demon"|Class=="Ancient"|Race=="Hybrid"|Race=="Saiyan"|Race=="Makyojin"|Race=="Primal Ape")
		Personalitie.Add("Murderous")
		Personalitie.Add("Psychopath")
		Personalitie.Add("Puppetmaster")
	if (Race=="Android")
		Personalitie.Add("Robotic Blank")
		Personalitie.Add("Terminator")
	if (Race=="Saiyan"|Race=="Primal Ape")
		Personalitie.Add("Saiyan Pride")
	if (Race=="Kanassan")
		Personalitie.Add("Elite Pride")
	switch(input("What kind of personality does your character have? This isn't resigning you to this one aspect, it's just their starting dominant character trait. Growth is encouraged!","",text) in Personalitie)
		if("Normal")
			Personality="Normal"
			Choice=alert(src,"An Average background means your character has lived the ordinary sort of life for a character of your race. It went to school where it probably had average grades, it's parents are still alive where applicable, and there was overall nothing really special about the way the character grew up. Is this the type of History you want? ","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					usr<<"Congratulations, Average character! You've chosen the Jack of all paths!"//I want to congratulate the people that make average characters... again. For people to be special there has to be other people to compare em to :O.
		if("Pacifist")
			Personality="Pacifist"
			Choice=alert(src,"Your character hates fighting in all it's forms. It might train it's body for self-betterment, but if there's one thing that makes them angry it's fighting and having to fight. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MaxAnger*=1.25
					OffMod*=1.7
					MedMod*=1.35
		if("Curious")
			Personality="Curious"
			Choice=alert(src,"Your character loves to read and learn things. They're a bookworm, a scholar, or anything they can do to find something out. It nags them not to know! Might be confused for being easily distracted in extreme ases. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					Int_Mod*=1.2
					SpdMod*=1.5
					MedMod*=1.1
					DefMod*=1.9
		if("Shy")
			Personality="Shy"
			Choice=alert(src,"Your character is a wreck in social situations to some degree. Whether they're barely able to even get a proper word out amongst friends, or easily embarrased over small things, shy people are definitely interesting characters. They tend to have a hard time getting angry, but most of them have worked hard at becoming masters of running away from social situations! Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					EndMod*=1.8
					MaxAnger*=1.9
					SpdMod*=1.4
					DefMod*=1.1
		if("Stubborn")
			Personality="Stubborn"
			Choice=alert(src,"Your character just doesn't know when to concede the point or defeat. They can be headstrong or insistent about doing things their own way. This affects their ability to train alone as it means they can repeatedly do the same thing wrong and admit it's right, but they're better when working with others.Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					EndMod*=1.4
					OffMod*=1.8
		if("Loner")
			Personality="Loner"
			Choice=alert(src,"Your character doesn't really hang around people all too much. They might not have any friends at all for whatever reason it is that makes them a loner. Being a loner has it's benefits though. Doing things for yourself tends to make you... tough. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					EndMod*=1.2
					StrMod*=1.2
		if("Ruthless")
			Personality="Ruthless"
			Choice=alert(src,"This character doesn't care who he or she hurts. If you're in their way, they'll deal with you by any means necessary. They show no quarter and 'mercy' might not even be in their vocabulary at all. They're a bit shoddy at defending themselves, but they know how to hit you where it hurts... Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					StrMod*=1.4
					OffMod*=1.1
					DefMod*=1.7
		if("Friendly")
			Personality="Friendly"
			Choice=alert(src,"This character is rather socially adept.  They're good at making friends and are rather good at defending them too. They have a warm personality that just seems to attract people to them and make them feel calm and trusting. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					EndMod*=1.2
					SpdMod*=1.2
					DefMod*=1.2
					StrMod*=1.5
					OffMod*=1.5
		if("Impish")
			Personality="Impish"
			Choice=alert(src,"This character is generally a troublemaker or just looking for a bit of fun. They play pranks or mess with people's heads or just do all they can to have a good time all the time! They tend to be fast and good at taking damage, but they're usually too busy playing to work on their strength and form much. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					EndMod*=1.3
					StrMod*=1.8
					OffMod*=1.8
					SpdMod*=1.3
		if("Calm")
			Personality="Calm"
			Choice=alert(src,"This character isn't really the type to get worked up over things. In fact he's just the opposite, though this does come with the ability to focus better. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MaxAnger*=1.6
					MedMod*=1.4
					KiMod*=1.2
		if("Eccentric")
			Personality="Eccentric"
			Choice=alert(src,"This type of character is a bit of an oddball. They tend to be obsessive, confusing, and at times even their most serious behavior can be considered Wacky. Eccentric people tend to be true Geniuses- forgetful about some things simply because their mind is too focused on their latest project or subject. They're curious people taken to an extreme. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					Int_Mod*=1.5
					StrMod*=1.7
					SpdMod*=1.8
					MedMod*=1.2
					DefMod*=1.8
		if("Demonic")
			Personality="Demonic"
			Choice=alert(src,"This character is, well, ever see an angry demon in a movie? That's this character. An engine of destruction. It wants blood and souls. A 'pure evil' personality this is. Built for ripping people in half before they rip it in half. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					StrMod*=1.75
					EndMod*=1.6
					KiMod*=1.6
					DefMod*=1.6
					MaxAnger*=1.5
		if("Divine")
			Personality="Divine"
			Choice=alert(src,"This character is as saintlike as they come. Generally calm and wise, giving, caring, whatever you might picture a deity doing that's this person. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					KiMod*=1.2
					StrMod*=1.8
					EndMod*=1.7
					KiMod*=1.3
		if("Overlord")
			Personality="Overlord"
			Choice=alert(src,"Mwahahahaa, dominate the universe! This character wants to rule everything, plain and simple. It wants to claw it's way to the top of everything and stay there no matter what. Overlords train hard, but tend to see more result in the overall power they so crave than their actual skill. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					BPMod*=1.2
					MedMod*=1.7
					DefMod*=1.7
		if("Dominator")
			Personality="Dominator"
			Choice=alert(src,"Kind of the dual-personality to Overlord. Dominators have similar goals but rather than being after power itself, they're after that lovely feeling power over another being gives. They tend to get more skill than overlords, but as a result they gain less overall power. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					BPMod*=1.8
					MedMod*=1.3
					DefMod*=1.3
		if("Murderous")
			Personality="Murderous"
			Choice=alert(src,"You want to kill things. That's pretty much it. You like ending the lives of the living- whether you do that columbine style or have an elaborate plan varies from person to person, but your main defining trait is the fact that you like when things around you die. Is this the type of personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					StrMod*=1.85
					EndMod*=1.8
					DefMod*=1.8
					MedMod*=1.3
		if("Psychopath")
			Personality="Psychopath"
			Choice=alert(src,"You have more than a few screws loose- if there is a person alive that can predict what you're going to do, they're probably just as insane as you are. Is this the type of personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					SpdMod*=1.5
					StrMod*=1.75
		if("Puppetmaster")
			Personality="Puppetmaster"
			Choice=alert(src, "Dance, puppets, dance! You are a mastermind, a master of manipulation. You don't so much kill people as you convince other people to kill them for you. You toy with emotions and anything you can do to keep your plan going. The power of your mind is formidable. Is this the type of personality you want")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MedMod*=1.35
					KiMod*=1.5
					StrMod*=1.85
					EndMod*=1.85
					SpdMod*=1.85
		if("Saiyan Pride")
			Personality="Saiyan Pride"
			Choice=alert(src,"You are a standard prideful saiyan, the last to admit you're wrong, the first to brag about how superior your race is. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MedMod*=1.75
		if("Studious")
			Personality="Studious"
			Choice=alert(src,"You hit the books and never learned how to stop. You're a great catch at parties (not), but at least your name is known at your local library! Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					Int_Mod*=1.75
					StrMod*=1.75
					SpdMod*=1.85
					MedMod*=1.25
		if("Elite Pride")
			Personality="Elite Pride"
			Choice=alert(src,"You are even more prideful than your average Saiyan- and for good reason. You are an elite! A member of the strongest class of your race! You are easy to look down on others and push your superiority even on other members of your race. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MedMod*=1.5
					KiMod*=1.5
					StrMod*=1.85
					EndMod*=1.85
					SpdMod*=1.85

		if("Businessman")
			Personality="Businessman"
			Choice=alert(src,"You are business-minded in all areas of life. Your answer to a plea for help is 'Whats in it for me'. As a result you've earned a buck or too, but you generally don't tend to focus on fighting. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					EndMod*=0.95
					StrMod*=0.95
		if("Bubbly")
			Personality="Bubbly"
			Choice=alert(src,"Eternally joyous and sees only the good in everyone and every situation; your character is an optimist with a joyous twist of hyper and cute. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					EndMod*=1.75
					MedMod*=1.75
		if("Dependent")
			Personality="Dependent"
			Choice=alert(src,"Your character is usually dependent on the opinion or approval of others. This could mean they are clingy or obsessive, or just prone to getting depressed when someone points out one of their not-so-good ideas. Sometimes the person is dependent on other people's ideas entirely. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					Int_Mod*=1.25
					EndMod*=1.75
		if("Bossy")
			Personality="Bossy"
			Choice=alert(src,"Your character likes to be the head honcho. Whether it's the leader of a small group of 'friends' or an entire planet, your character insists that others do what they say exactly how they say it. Some are more forceful than others. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					Int_Mod*=1.75
					MedMod*=1.95
					StrMod*=1.35
		if("Sagacious")
			Personality="Sagacious"
			Choice=alert(src,"Your character is the type everyone turns to for advice. Whether it be because they are inherently wise or just acting, there's no question that there's an air of mystery or at least knowledge about them. Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MedMod*=1.35
		if("Robotic Blank")
			Personality="Robotic Blank"
			Choice=alert(src,"Your character is clean-slate, starting with no memories and maybe no personality whatsoever of it's own. It falls upon either a programmer or the android itself to experience enough to fill this gaping void...  Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MedMod*=1.35
					EndMod*=1.85
		if("Terminator")
			Personality="Terminator"
			Choice=alert(src,"Terminate with extreme prejudice! Once you have a target you never let it leave your sights until you've hunted it down and destroyed it. You might act like a zombie with the intensity of which you seek your target. Who knows what you'll do once they're dead, but it's the journey that counts, right?  Is this the type of Personality you want?","","Yes","No")
			switch(Choice)
				if("No")
					Personality()
				if("Yes")
					MedMod*=1.75
					SpdMod*=1.4
					DefMod*=1.3
					KiMod*=1.25