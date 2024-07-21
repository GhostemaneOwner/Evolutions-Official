
mob/verb/Read_Login()
	//set category="Other"
	var/ServerInfo={"<body style="background-color:#212121" text="#80d8FF"><font size=4>Server Information<br><font size=2>
	[YearOutput()]<br>
	Year Speed: 1 Week Every [(Year_Speed)] Minutes<br>
	Wipe Day: [WipeDay]<br>
	True BP Cap: [Commas(TrueBPCap)]x BPMod<br>
	Tech/Magic Cap: [TechCap] + Tech/Magic Mod<br>
	Stat Soft Cap: [Commas(round(SoftStatCap))] x Mod<br>
	Total Stat Cap: [Commas(round(SoftStatCap*6.5))]<br>
	Radiant Energy occurring on [RadiantEnergy==1?"Earth":RadiantEnergy==2?"Namek":RadiantEnergy==3?"Vegeta":RadiantEnergy==4?"Icer":RadiantEnergy==5?"Arconia":RadiantEnergy==6?"Dark Planet":RadiantEnergy==7?"Space Station":"???"].<br>
	"}
	if(Year>5)
		ServerInfo+={"
		Starter Boost BP: [Commas(StarterBoostBP)]<br>
		Starter Gain Multiplier:[MinGainMult]<br>
		"}

	ServerInfo+={"<br>
	Global Transformations: [Global_Trans ? "On" : "Off"]<br>
	Global SSj: [Global_SSJ3 ? "3" :Global_SSJ2 ? "2" :Global_SSJ ? "1" : "Off"]<br>
	Global Ascension: [Global_Ascension ? "On" : "Off"]<br>
	Global God Ki: [Global_GodKi ? "On ([Global_GodKiCap] Cap)" : "Off"]<br>
<br><br>
Current Objective: [GlobalObjective]<br>
	"}
	usr << browse(ServerInfo,"window=version;size=300x325;bgcolor=#000000;fontcolor=#FFFFFF")

var/tmp/mob/WritingNotes
var/tmp/mob/WritingStory
var/tmp/mob/WritingRules
var/tmp/mob/WritingUpdates


mob/verb/Rules()
	switch(input("Do you want to open the rules in discord?") in list("No", "Yes"))
		if("Yes")
			usr<<link("https://discord.com/channels/1117640044103090196/1128011192342954074")
		else
			usr << browse(Rules,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")

mob/verb/Story()
	usr << browse(Story,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")

mob/proc/StoryPrompt()
	switch(z)
		if(1) src << browse(EarthStory,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
		if(2) src << browse(NamekStory,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
		if(3) src << browse(VegetaStory,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")
		if(11) src << browse(ArconiaStory,"window=version;size=400x400;bgcolor=#212121;fontcolor=#80d8FF")

var/global

	Rules={"<body style="background-color:#212121" text="#80d8FF">
<u><b>General Rules</b></u><br><br>
1. The admin team has the authority to determine the punishment for any rule violation or inappropriate behaviour within the community and server. Repeated spamming in out-of-character (OOC) chat and being a toxic member can result in a ban, while new players may receive a warning for combat-related issues.
<br><br>
2. Players and admins are expected to maintain appropriate conduct in official communication channels such as Ahelp and Admin PMs. Avoid arguing or instigating arguments in these channels and keep conversations clear and concise.
<br><br>
3. If an admin asks you to stop a certain action, cooperate and comply with their request. Answer their questions when asked.
<br><br>
4. Your character's name should start with a capital letter and consist only of alphanumeric characters (A-Z, 1-0). While not strictly enforced, consider the naming conventions of your chosen race, avoiding names that don't fit the race's characteristics. Use creativity and realism when choosing a name in line with the roleplay (RP) environment. The name you choose during character creation should be the one you stick with.
<br><br>
5. Posting explicit or pornographic content is not allowed in any in-game channels. Erotic roleplay (ERP) is also prohibited. Avoid engaging in overly sexualized roleplays and never hint at or involve rape in any form.
<br><br>
6. Interacting with your alternate characters, either directly or indirectly, is not permitted. Additionally, having alternate characters on the same Z plane as your main character is prohibited.
<br><br>
7. Using the ability to change object icons in the game to deceive others is not allowed. This includes making attacks or charging icons invisible, altering icons of teleporter pads, cloning tanks, doors, or making mobs smaller than 16x16 or invisible. Mana Pylons and Drill Towers cannot have their icons changed.
<br><br>
8. Choose an icon for your character that matches the general appearance theme of your race. For example,, purple appearance for Yardrats, humanoid appearance for Kaios and Demigods, and humans without animal traits like tails or cat ears. Aliens, Puars, Androids, and Demons have more freedom in selecting their icons.
<br><br>
9. When building structures, ensure there is a door or opening leading into the building, as well as rooms inside it. Avoid placing more than one door per tile without any underlying purpose, as it may interfere with the Hacking Console. Building in a disruptive or obstructive manner, such as spamming ugly tiles or blocking public access, may result in punishment and removal of your buildings.
<br><br>
10. Being present "out of character" (OOC) in certain events without explicit admin permission is not allowed.
<br><br>
11. Any items destroyed during sparring or fights are considered in-character (IC). If someone not involved in combat accidentally destroys an item, it may be eligible for a refund based on the situation.
<br><br>
12. OOC teaching is prohibited. Teaching skills requires an emote of sufficient size and detail for each skill, involving both the teacher and the student.
<br><br>
13. In general, you should roleplay any action that affects another character/player, whether positive or negative. This includes actions like medical scans, imitation, Instant-Transmission, healing, stun chips, or any action targeting another player, which requires an accompanying emote.
<br><br>
14. Breaking into bases, walls, or doors that you did not create requires an emote of at least 50 words and a countdown of 60 seconds. If a base consists of multiple buildings or rooms, each building or room requires its own emote of at least 25 words and a cooldown of 30 seconds after the initial emote with a 60-second countdown. Destroying items within a base also requires its own emote of 25 words and a 30-second cooldown per room.
<br><br>
15. Taking items that you did not create or were not ICly given to you requires an emote of at least 25 words and a 60-second cooldown. If you break into a base and are stealing from it, the initial emote for the robbery (separate from the breaking/entry emote) should be at least 50 words with a 60-second cooldown. If you need to make multiple trips to complete the robbery, each trip requires a new emote of at least 25 words and a 30-second cooldown. To summarize, the initial theft requires a 50-word emote with a 60-second cooldown, and subsequent trips require a 30-second cooldown and an emote of 25 words. Whenever stealing, you must put in the Emote all they intend to steal.
<br><br>
16. In chat channels:
<br><br>
<li>Avoid spamming or flooding with excessive messages in IC, OOC, or LOOC chats
<br><br>
<li>Excessive flaming or harassment may result in an immediate mute. Heated discussions are allowed, but continuous bashing, shaming, or trolling will have consequences.
<br><br>
<li>Do not share IC information or post IC emotes or says in OOC channels. Exceptions may be made for personal emotes or says intended for humor.
<br><br>
<li>Making threats of hacking, cracking, DoS, or DDoS attacks against the server or player base, even in a joking manner, is strictly prohibited. Violation will result in a ban of at least one day without the possibility of appeal.
<br><br>
<li>Advertising other BYOND games within the current game or promoting the current game in other BYOND games is not allowed.
<br><br>
<u><b>Combat Rules</b></u><br><br>
<b>Phases of Combat</b><br>
Each combat sequence consists of three distinct phases:
<br><br>
<b>Roleplay Phase:</b><br>
This phase involves main roleplay, including stating targets and intentions.
<br><br>
During the roleplay phase, all participants engaging in combat, causing harm, healing, or supporting, must emote their intended actions. It is necessary to declare malicious intent if planning to use lethal force, injure, or steal during the resolution phase.
<br><br>
<b>Spectating:</b> Those who do not emote during the roleplay phase are considered implied spectators and are subject to the consequences of collateral damage. Deliberately targeting spectators will lead to punishment. Using RP mode to avoid injury while spectating is not allowed.
<br><br>
An acceptable roleplay emote during the main phase should clearly communicate the character's actions or intentions. It must consist of at least 50 words. The language used does not affect in-character communication, but it is a player-to-player restriction.
<br><br>
Once all active participants have posted their roleplays, a designated person performs a countdown. When the countdown ends, the Battle Phase begins, and the verb portion of the fight commences. Participants must not start their actions before the timer reaches zero, except for using buffs.
<br><br>
<b>Battle Phase:</b><br>
The battle phase consists of verb combat, where actions are executed.
<br><br>
This phase remains active until one side remains standing while all others are knocked out, successfully flee, or all parties agree to stop fighting and declare a draw. If knocked out, participants must activate RP mode until the Resolution Phase begins. At the end of the Battle Phase, participants who are still standing can carry out their stated intentions, such as theft or using the injure verb. Subsequently, they must roleplay the results. Participation in the results roleplay is optional for the target.
<br><br>
<b>Combat Pause:</b> Combat pauses can be requested during the Battle Phase. When a pause is called, everyone must enter RP mode. Participants can change their RP intentions or perform a new specific action. Pauses do not allow new parties to join the Battle Phase. Each side is granted a single pause that must be honoured when requested. Emotes during a combat pause should be limited to ~50 words.
<br><br>
<b>Player Disconnection:</b> If a participant involved in active or imminent combat suddenly disconnects, a free pause is given to await their return. If they do not return within a reasonable timeframe (ten minutes), the situation may proceed without them, using a new countdown.
<br><br>
<b>Resolution Phase:</b><br>
The resolution phase includes the injure verb and roleplay of the results.
<br><br>
After the Battle Phase concludes, all parties move to the resolution phase. All participants must have RP mode enabled and heal their Willpower to its current level. The victor(s) can use the Injure/Absorb verb on one target, steal one item from a target, or choose to flee the scene. Onlookers who were not part of the combat phase must not interfere and should wait until the resolution phase is completed. After performing the action, the results must be roleplayed. Parties directly affected by the action may respond with an RP post detailing their side of the struggle, injury, etc., but it is not mandatory. Once all result and continuation emotes have been posted, the combat can proceed to the next battle phase. The exception is when inflicting a fatal injury, where the attacker must post the emote first and allow the victim to post a death emote in response.
<br><br>
<u><b>Flee Rules</b></u><br><br>
<li>To flee, you must clearly indicate your intent to flee in your roleplay and include "(Flee)" at the end of your emote. Then, you use the Flee verb and await the result. Others may choose to respond by attempting to chase you if they are hostile or join you in a flee attempt if they are your ally.
<br><br>
<li>If you fail your flee roll (rolling lower than your opponent's chase result), you are caught and must engage in combat with anyone who targets you. Once the round is completed, you can attempt to flee again. If you win the fight after a failed flee roll, you can injure one of the individuals you defeated, but this means you cannot flee the scene. If you are caught, you must fight against everyone who targets you, not just the one who caught you.
<br><br>
<li>If you succeed in a flee (rolling higher than or equal to those chasing you, with the person fleeing always winning a tie), you must immediately leave the scene, and those you fled from cannot engage you in combat for the remainder of the scene. The person who fled should try to remain hidden.
<br><br>
<li>Flee rolls and chase rolls are counted individually. If multiple people are fleeing, those who succeed in fleeing can choose to stay behind and assist those who failed their flee attempts. Only one fleeing person can be "caught" by a pursuer, as opposed to everyone with lower rolls.
<br><br>
<li>If you chase someone and fail, you cannot participate in the combat round of the original situation from which they fled. Once that round is over, you may rejoin.
<br><br>
<li>If you voluntarily leave a scene without anyone chasing you, you still cannot return until the scene is over. However, if you disengage from combat without fleeing and aren't marked for immediate injury (MI'd), you can continue to observe the ongoing conflict from the sidelines.
<br><br>
Note: If no emotes have occurred in a given situation, you are not obligated to emote your exit. An RP situation does not begin until there is an emote!
<br><br>
<u><b>Misc Rules</b></u><br><br>
<b>Imprisonment:</b> If someone is captured and placed in a prison, they must receive roleplay (RP). If they haven't received RP for an hour, they are allowed to Ahelp to be set free, but it must be roleplayed accordingly.
<br><br>
<b>Building During Combat:</b> Building roofs, walls, tiles, etc., during combat is not allowed. However, you are permitted to build magic or tech items in the middle of the fight, but you must include them in your emote.
<br><br>
<b>Mulligans:</b> If a situation arises where rules are broken or a bug significantly alters the combat outcome, an admin may declare a redo of the situation. Combatants will be restored to their pre-combat positions, and the situation will restart after a countdown.
<br><br>
<b>KO Verbs:</b> Auto KO verbs like stun chips or Soul Contract are considered combat actions and must be roleplayed according to regular combat rules. You can also use one of these in place of an injury if you win a round, but only one per round.
<br><br>
<b>AFK Rules:</b> You are not allowed to harm any player who is AFK in any way. Building structures around AFK players to wall them off is also prohibited. The protection provided by the AFK tag itself is the only safeguard. Deliberately flagging yourself as AFK to avoid harm is not allowed. Do not AFK camp someone because you are deliberately trying to use malicious intent. 
<br><br>
<b>Rescues:</b> Anyone with more than 0 Willpower (WP) can be rescued by an ally in a save attempt. After combat has ceased, they can regenerate their WP by normal means. Save attempts involve Flee/Chase rolls between the "Saver" and the "Attacker." Once someone's WP reaches 0, they cannot be saved, with one exception (see #7/8).
<br><br>
<b>0 WP and Defenselessness:</b> When a person's WP reaches 0, they are considered "defenseless" and unable to take actions or declare malicious intents. However, they must still roleplay their condition. Someone cannot simply approach a defenseless person and execute them on the spot. The attacker must actively participate in the ongoing combat scenario or fight against defenders, depending on the circumstances.
<br><br>
<b>Interference with Defenseless Players:</b> Those not directly involved in a lethal combat scene cannot target someone reduced to 0 WP in that conflict without participating in the battle. This means they cannot "snipe" the defenseless person from the sidelines. This rule also applies to verbs like Absorb. To harm, kidnap, etc., someone in this manner, the attacker must join the next round of the lethal combat and fight through at least one round.
<br><br>
<b>Defense of Defenseless Players in Safe Zones:</b> After a lethal combat has concluded, a person reduced to 0 WP who is in a "safe zone" (their own base, a regen tank with allies, etc.) cannot be killed on the spot. If there are allied parties present, they are allowed to defend the defenseless individual. If the attacking party loses, they lose their right to kill for that round but may attempt again. If the attacking party is successful in KOing all defenders, they may follow through with their action. Additional defenders cannot join after an initial defense attempt has failed.
<br><br>
<b>Grab Rule:</b> During combat, you are not allowed to grab items that would disrupt players from dealing damage to you, such as training dummies or punching bags. However, grabbing other players is acceptable if you intend to use a damaging ability on them, such as Throw or Megaton Throw.
<br><br>
<b>Combat Avoidance:</b> Spending more than half the time running away from an opponent is considered combat avoidance. Combat avoidance is not the same as dodging or evasion; it refers to fleeing in a situation where fleeing is not appropriate.
<br><br>
<b>Tile Limits:</b> You should generally stay within a 15-tile range of another person at all times during combat. Spending more than 5 seconds outside of this range or repeatedly going beyond the 15-tile limit can be considered a violation of the rule. The general guideline is to stay within the screen of your opponent. The only exception is when an enemy uses Homing Finisher; you can temporarily leave the boundaries of combat until the attack is resolved.
<br><br>
<b>Changing Z-Coordinates:</b> Using pods or ships to change Z-coordinates during combat is not allowed. If you wish to change Z-coordinates after a combat situation, it must be done through a full RP and cooldown, whether using a telepad, magic portal, or another Z-shifting skill. Using pods or ships to escape a Z-coordinate is only permitted when combat has entirely concluded. If you want to change Z-coordinates, it must be done between rounds and fights.
<br><br>
<b>1 Injury Per Loss:</b> Each time someone loses a round of combat, they may only be injured once, regardless of the number of winning parties. The person who knocked them out has the right to perform the injure action. The progression of injuries for a limb follows the sequence: Healthy => Broken => Maimed => Removed. The "Injure" verb will manage the progression, ensuring that the provided injury is within the correct parameters.
<br><br>
<b>Leaving vs. Fleeing:</b> If you voluntarily leave a scene and no one chases you, you still cannot return to that scene. However, if you win a round of combat and choose not to perform an injury, and no one can chase you, you can leave the scene.
"}
	Story={"<body style="background-color:#212121" text="#80d8FF">

-Sadala-<br><br>
From the earliest written records, Saiyans have ruled over planet Sadala due to their innate fighting power. Tsufurujin on the other hand weren’t as physically capable, and reluctantly were forced to work under their Saiyan overlords. Thankfully however, they weren’t seen as useless and their advanced intellect proved useful for the Saiyans. An uneasy, yet functional arrangement was developed and outside of a few rogues and rebels, the Tsufurujin served the Saiyans for several generations. Saiyans grew stronger, Tsufurujin grew smarter, both could be considered content.<br>
<br>
This was the way until around 150 years prior to the start of our story. The scaled beings, our Changelings, were attracted to the planet to create a galactic army, conscripting and manipulating the natives into serving them without question, allowing for their reach to extend to all habitable worlds.<br>
<br>
Upon arrival, there were many battles between the Changelings and Saiyans, even the Tsufurujin attempted to fight them off, however, after 75 years of being beaten into submission, the children of the invaded generations began bending the knee, little by little, the Saiyan and Tuffle children began to accept their overlords, slowly but surely being manipulated into thinking that this was the norm. Great Warriors were killed, techniques forgotten and technology lost, all in service of maintaining independence.<br>
<br>
Even their children, our current generation, must bend the knee. However, there is the occasional native who recalls their grandfather’s words of Saiyan pride and Tuffle intellect. A spark of hope is realised as the previous Emperor passes away and their young Child begins taking the throne. Perhaps this is the opportunity to overthrow the young Tyrant and regain that which their grandparents spoke of, or simply suffer trying.<br>
<br>
Time will simply tell...<br>
<br><br>
-Earth-<br><br>
A beautiful blue sphere, orbiting a medium sized star with grace. Earth seemed to be an oasis within the collection of planets that orbit the Sun. With enough time, life had begun to spring up all over the world the world, causing to take on it's trademark green and blue colors.<br>
<br>
Many Human civilizations had come to rise and fall through the entirety of Earth's history. Eras were filled with a mix of wealth and darkness. Humanity somehow always found a means of survival, and clawed back their existence from the edge of annihilation. Around a century or so ago, a single human with great magical prowess, decided to channel all of his amassed power to create something to permanently allow the Human race to flourish. Being guided by an unknown voice, he created Seven special orbs. During the ritual of creation for these artefacts, a rift in reality formed and from it spawned monsters and unimaginable horrors The Humans fought back over countless years.<br>
<br>
Eventually, nearly 50 years since the rift first appeared the Humans regained a foothold, and in one final push were able to bring the creator, now an old man with the title of Guardian, to the site of the breach. Using the remaining years of his life and the last of his power he was finally able to seal the breach.<br>
<br>
As the eldritch rift closed, the remaining creatures were transformed, their aberrant forms taking on a more Humanoid appearance, eventually becoming the Maykojin. With the sheer abundance of mana and magical energies being cut off from the plane they originated from, it condensed down into a physical form, creating the Puar.<br>
<br>
Noticing the difference between the original creatures and these two new 'races' - an uneasy peace would be in place as the Humans attempted to rebuild their world, while the Makyojin and Puar tried to find their place in it.<br>
<br>
Humans found themselves split on what to do with these new neighbours, some wished to slay, some to enslave, others to endure and share their world. After all, it could be said that the Humans caused these problems, and the remaining Makyojin and Puar are simply victims of the Human's selfish desire.<br>
<br>
The Puar, found themselves trying to fit in peacefully, while the Makyojin' morality varied heavily.<br>
<br>
One of the Warriors, who helped close the rift with the Creator, took up the mantle of Earth Guardian, holding dear the knowledge of the seven orbs, and works tirelessly to keep them out of the hands of others, especially the Makyojin whom they fear knows of their power.<br>
<br><br>
-Namek-<br><br>
A peaceful green orb floats in space, undisturbed by space-faring civilizations over the passage of time. The indigenous people of the planet often lead simple lives. Enjoying one another’s company and often seen going through several hours of meditation isn’t an unusual affair for the average Namekian.<br>
<br>
If the planet would be Mother Namek, then Porunga would be the Father. Both entities provide everything required for the Namekians to exist peacefully with one another, with many Namekians content to live out their days in bliss and harmony, while bolstering their connection with both Namek and Prounga.<br>
<br>
Our story begins above the skies of Namek. A colony ship has been travelling for countless years towards a lifeless planet in order to give its occupants a new home. Several generations have lived and died aboard the ship, as it travelled the cosmos across the hundreds of lightyears to reach their destination, Arconia. One such child is awoken suddenly by an explosion, followed by alerts and a violent shaking. “The ship is under attack!” one of the crew shouts across an intercom. “Get to the escape pods!” another voice cries out. Only a few moments later, another explosion is heard, followed by another and another.<br>
<br>
Of the several thousand inhabitants aboard the vessel, only a handful made it to the pods, and of those handfuls, only some survived the descent onto the surface of Namek.<br>
<br>
A sly grin forms over the face of a blue skinned alien, for you see, this Captain has just halted an invasion of his Promised Land. A holy place where it is believed the Souls of the Heran race reside with every wish fulfilled, and every desire catered for. Each clan of Herans fan out amongst the stars, living a nomadic life, protecting their Promised Land for when it is their turn to visit, they too can then rest like all the Souls they believe reside there. Well paid Konatsians, are often found aboard Heran ships, assisting the Heran clans. A large explosion is heard as the grin is quickly washed away from the Captain's face as a piece of the debris from the Colony ship strikes the Heran craft.<br>
<br>
A moment later, the Heran vessel becomes unresponsive and as if fate decided to play a crew hand as Namekian gravity pulls it to the surface.<br>
<br>
The gentle green Namekian people notice there is something wrong in the skies above, a shower of light heads in one direction, split into multiple little shards, a single larger light can be seen screaming down in the opposite direction.<br>
<br>
Namek has just joined the Galactic Neighbourhood, even if at this moment, they don’t yet realise it...<br>
<br><br>
-Afterlife-<br>
Having been created by the powers unknown with this intention, the Afterlife was deemed perfectly compatible for any life to set foot on its seemingly endless lands. Though this sounds capable of producing nothing more than beauty, and sights of wonder and awe, The unknown forces were not expecting beings of chaos, and darkness to set foot in its lands. With the arrival of the Demons, the world needed to transform itself once again. A large portion of the Afterlife was slowly, yet gradually corrupted, before eventually descending into the depths below the clouds, and forming the pits of Hell. As this was finalized, the skies of the afterlife seemed to change and morph, becoming brighter, and exponentially more beautiful. From these beautiful skies descended a gateway. This gateway guarded the home created for the Kaio as to preserve the balance of the world they inhabited.<br>
<br>
The Kaio, aware of the Demon's new home in Hell, had done everything they could to repel the Demon's though it always seemed they'd come to a stalemate. Thousands of years have passed since the war between order and chaos began.<br>
<br>

<br><br><br>
"}

	ArconiaStory={"<body style="background-color:#212121" text="#80d8FF">
-Afterlife-<br>
Having been created by the powers unknown with this intention, the Afterlife was deemed perfectly compatible for any life to set foot on its seemingly endless lands. Though this sounds capable of producing nothing more than beauty, and sights of wonder and awe, The unknown forces were not expecting beings of chaos, and darkness to set foot in its lands. With the arrival of the Demons, the world needed to transform itself once again. A large portion of the Afterlife was slowly, yet gradually corrupted, before eventually descending into the depths below the clouds, and forming the pits of Hell. As this was finalized, the skies of the afterlife seemed to change and morph, becoming brighter, and exponentially more beautiful. From these beautiful skies descended a gateway. This gateway guarded the home created for the Kaio as to preserve the balance of the world they inhabited.<br>
<br>
The Kaio, aware of the Demon's new home in Hell, had done everything they could to repel the Demon's though it always seemed they'd come to a stalemate. Thousands of years have passed since the war between order and chaos began.<br>
"}

	VegetaStory={"<body style="background-color:#212121" text="#80d8FF">
-Sadala-<br><br>
From the earliest written records, Saiyans have ruled over planet Sadala due to their innate fighting power. Tsufurujin on the other hand weren’t as physically capable, and reluctantly were forced to work under their Saiyan overlords. Thankfully however, they weren’t seen as useless and their advanced intellect proved useful for the Saiyans. An uneasy, yet functional arrangement was developed and outside of a few rogues and rebels, the Tsufurujin served the Saiyans for several generations. Saiyans grew stronger, Tsufurujin grew smarter, both could be considered content.<br>
<br>
This was the way until around 150 years prior to the start of our story. The scaled beings, our Changelings, were attracted to the planet to create a galactic army, conscripting and manipulating the natives into serving them without question, allowing for their reach to extend to all habitable worlds.<br>
<br>
Upon arrival, there were many battles between the Changelings and Saiyans, even the Tsufurujin attempted to fight them off, however, after 75 years of being beaten into submission, the children of the invaded generations began bending the knee, little by little, the Saiyan and Tuffle children began to accept their overlords, slowly but surely being manipulated into thinking that this was the norm. Great Warriors were killed, techniques forgotten and technology lost, all in service of maintaining independence.<br>
<br>
Even their children, our current generation, must bend the knee. However, there is the occasional native who recalls their grandfather’s words of Saiyan pride and Tuffle intellect. A spark of hope is realised as the previous Emperor passes away and their young Child begins taking the throne. Perhaps this is the opportunity to overthrow the young Tyrant and regain that which their grandparents spoke of, or simply suffer trying.<br>
<br>
Time will simply tell...
"}

	EarthStory={"<body style="background-color:#212121" text="#80d8FF">
-Earth-<br><br>
A beautiful blue sphere, orbiting a medium sized star with grace. Earth seemed to be an oasis within the collection of planets that orbit the Sun. With enough time, life had begun to spring up all over the world the world, causing to take on it's trademark green and blue colors.<br>
<br>
Many Human civilizations had come to rise and fall through the entirety of Earth's history. Eras were filled with a mix of wealth and darkness. Humanity somehow always found a means of survival, and clawed back their existence from the edge of annihilation. Around a century or so ago, a single human with great magical prowess, decided to channel all of his amassed power to create something to permanently allow the Human race to flourish. Being guided by an unknown voice, he created Seven special orbs. During the ritual of creation for these artefacts, a rift in reality formed and from it spawned monsters and unimaginable horrors The Humans fought back over countless years.<br>
<br>
Eventually, nearly 50 years since the rift first appeared the Humans regained a foothold, and in one final push were able to bring the creator, now an old man with the title of Guardian, to the site of the breach. Using the remaining years of his life and the last of his power he was finally able to seal the breach.<br>
<br>
As the eldritch rift closed, the remaining creatures were transformed, their aberrant forms taking on a more Humanoid appearance, eventually becoming the Maykojin. With the sheer abundance of mana and magical energies being cut off from the plane they originated from, it condensed down into a physical form, creating the Puar.<br>
<br>
Noticing the difference between the original creatures and these two new 'races' - an uneasy peace would be in place as the Humans attempted to rebuild their world, while the Makyojin and Puar tried to find their place in it.<br>
<br>
Humans found themselves split on what to do with these new neighbours, some wished to slay, some to enslave, others to endure and share their world. After all, it could be said that the Humans caused these problems, and the remaining Makyojin and Puar are simply victims of the Human's selfish desire.<br>
<br>
The Puar, found themselves trying to fit in peacefully, while the Makyojin' morality varied heavily.<br>
<br>
One of the Warriors, who helped close the rift with the Creator, took up the mantle of Earth Guardian, holding dear the knowledge of the seven orbs, and works tirelessly to keep them out of the hands of others, especially the Makyojin whom they fear knows of their power.<br>

"}

	NamekStory={"<body style="background-color:#212121" text="#80d8FF">
-Namek-<br><br>
A peaceful green orb floats in space, undisturbed by space-faring civilizations over the passage of time. The indigenous people of the planet often lead simple lives. Enjoying one another’s company and often seen going through several hours of meditation isn’t an unusual affair for the average Namekian.<br>
<br>
If the planet would be Mother Namek, then Porunga would be the Father. Both entities provide everything required for the Namekians to exist peacefully with one another, with many Namekians content to live out their days in bliss and harmony, while bolstering their connection with both Namek and Prounga.<br>
<br>
Our story begins above the skies of Namek. A colony ship has been travelling for countless years towards a lifeless planet in order to give its occupants a new home. Several generations have lived and died aboard the ship, as it travelled the cosmos across the hundreds of lightyears to reach their destination, Arconia. One such child is awoken suddenly by an explosion, followed by alerts and a violent shaking. “The ship is under attack!” one of the crew shouts across an intercom. “Get to the escape pods!” another voice cries out. Only a few moments later, another explosion is heard, followed by another and another.<br>
<br>
Of the several thousand inhabitants aboard the vessel, only a handful made it to the pods, and of those handfuls, only some survived the descent onto the surface of Namek.<br>
<br>
A sly grin forms over the face of a blue skinned alien, for you see, this Captain has just halted an invasion of his Promised Land. A holy place where it is believed the Souls of the Heran race reside with every wish fulfilled, and every desire catered for. Each clan of Herans fan out amongst the stars, living a nomadic life, protecting their Promised Land for when it is their turn to visit, they too can then rest like all the Souls they believe reside there. Well paid Konatsians, are often found aboard Heran ships, assisting the Heran clans. A large explosion is heard as the grin is quickly washed away from the Captain's face as a piece of the debris from the Colony ship strikes the Heran craft.<br>
<br>
A moment later, the Heran vessel becomes unresponsive and as if fate decided to play a crew hand as Namekian gravity pulls it to the surface.<br>
<br>
The gentle green Namekian people notice there is something wrong in the skies above, a shower of light heads in one direction, split into multiple little shards, a single larger light can be seen screaming down in the opposite direction.<br>
<br>
Namek has just joined the Galactic Neighbourhood, even if at this moment, they don’t yet realise it...

"}


