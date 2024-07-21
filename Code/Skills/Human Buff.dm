



mob/proc/MakePostHuman() if(Race=="Human")
	src<<"As you try to release the energy within your psyche, you find yourself unable to let go and return to your former Humanity. You are something entirely different now."
	Race="Post-Human"
	Zenkai=3
	GravMastered+=50
	BaseMaxAnger+=10
	BaseRegeneration*=1.05
	alertAdmins("[src] has finally left their Humanity behind and become a Post-Human!")


Skill/Buff/Super_Human_Form
	RequiresApproval = 0
	Tier=4
	BP=1.75
	Spd=1.45
	Off=1.45
	Recov=1.35
	buffon="unlocks the power of their Super Human Form"
	buffoff="represses the power of their Super Human Form"
	Experience=100
	/*GetDescription(mob/Getter)
		return "Third Eye is a relatively simplistic Human ability, but it can be extremely hard to attain for most Humans. You gain [BP]x BP, [Spd]x Spd, [Off]x Off, [Def]x Def, [Recov]x Recov."
		..()*/
	icon='Third Eye.dmi'
	verb/Super_Human_Form()
		set category="Skills"
		set src = usr.contents
		use(usr)
		usr.FirstTransWPRestore(usr)

Skill/Buff/Third_Eye
	RequiresApproval = 0
	Tier=4
	BP=1.45
	Spd=1.2
	Off=1.2
	Def=1.2
	Recov=1.2
	buffon="unlocks the power of their third eye chakra!"
	buffoff="represses the power of their third eye chakra."
	Experience=100
	/*GetDescription(mob/Getter)
		return "Third Eye is a relatively simplistic Human ability, but it can be extremely hard to attain for most Humans. You gain [BP]x BP, [Spd]x Spd, [Off]x Off, [Def]x Def, [Recov]x Recov."
		..()*/
	icon='Third Eye.dmi'
	verb/Third_Eye()
		set category="Skills"
		set src = usr.contents
		use(usr)
		usr.FirstTransWPRestore(usr)


Skill/Buff/Humanism
	RequiresApproval = 0
	Tier=4
	buffon="unlocks the power of Humanism!"
	buffoff="'s energy returns to normal."
	BP=1.75
	Regen=1.2
	Recov=1.2
	//energydrain=MediumDrain
	Experience=100
	icon='MasamuneSparks.dmi'
	layer=MOB_LAYER+1
	/*GetDescription()
		return "You have awakened to a power that is distinctly Human in nature.  You have resisted the temptation of forgoing your Humanity and are that much stronger for it. By drawing upon your complex well of Human emotions, you are able to achieve great power. ([BP]x BP, [Spd]x Speed, [Off]x Off, [Def]x Def, [Regen]x Regen and [Recov]x Recov)"
		..()*/
	verb/Humanism()
		set category="Skills"
		set src = usr.contents
		use(usr)
		usr.FirstTransWPRestore(usr,2)







Skill/Buff/Forsaken_Monster
	RequiresApproval = 0
	buffon="unlocks the power of Forsaken Monster!"
	buffoff="'s energy signature returns to normal."
	BP=1.7
	Anger=1.7
	Experience=100
//	energydrain=0.5
	icon='Sacred_Armor.dmi'
	layer=MOB_LAYER+1
	GetDescription()
		return "You have awakened to a power beyond that of Humanity's natural restraints. You have ascended beyond your mortal awareness to a plane futher beyond.<br>Using this ability will increase your BP by [BP]x, and anger by [Anger]x."
		..()
	verb/Forsaken_Monster()
		set category="Skills"
		set src = usr.contents
		use(usr)

