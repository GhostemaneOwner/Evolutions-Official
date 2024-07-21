/mob/proc/HasPrimaryTrait(name)
	if(HasTrait(name))
		var/trait/racial/genetic/T = GetTraitByName(name)
		return T.primary

/trait/racial/genetic
	var/primary = 0

/trait/racial/genetic/Saiyan
	name = "Saiyan Genome"
	desc = "The Saiyan genome is entwined with your own.  This grants you the ability to grow stronger from damage \
			inflicted upon you (Zenkai), but greatly affects your temperament (+0.2 anger). \
			(Gain access to the What Doesn't Kill You trait.) \
			(If primary: Gain access to the Super Perfect form.)"

	IsValidRace(mob/M)
		return M && M.Race == "Bio-Android"

	SpecialGainEvent(mob/M)
		if(!M || !M.client) return
		M.Zenkai = 0.7
		M.MaxAnger += 20

/trait/racial/genetic/Changeling
	name = "Frost Lord Genome"
	desc = "The Frost Lord genome is entwined with your own.  You are imbued with a sense of supreme confidence in your \
			own superiority, and a taste for sadistic actions.  Gain an increased chance to inflict an injury to your foe \
			the higher your power tier is relative to theirs (+2% per greater tier). \
			(If primary: Gain access to the Overlord form.)"

	IsValidRace(mob/M)
		return M && M.Race == "Bio-Android"

	SpecialGainEvent(mob/M)
		if(!M || !M.client) return

/trait/racial/genetic/Puranto
	name = "Puranto Genome"
	desc = "The Puranto genome is entwined with your own.  You are capable of regenerating even from the most grevious of wounds. \
			(Gain Regeneration skill and +1.5x Death Regeneration.) \
			(If primary: Gain access to the Fervent Regeneration trait.)"

	IsValidRace(mob/M)
		return M && M.Race == "Bio-Android"

	SpecialGainEvent(mob/M)
		if(!M || !M.client) return
		M.Regenerate = 1.5

/trait/racial/genetic/Human
	name = "Human Genome"
	desc = "The Human genome is entwined with your own.  You are much more effective at adapting to and overcoming foes \
			using your raw cunning and wit. (0.9x Intelligence, +1 adaptation.) \
			(Gain access to the Unparalleled Ingenuity trait.) \
			(If primary: Gain access to the Pump Up form.)"

	IsValidRace(mob/M)
		return M && M.Race == "Bio-Android"

	SpecialGainEvent(mob/M)
		if(!M || !M.client) return
		M.Int_Mod = 0.9