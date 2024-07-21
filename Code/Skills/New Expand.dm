

mob/var
	HasExpand5=0

Skill/Buff/Expand
	buffon="'s muscles suddenly expand"
	buffoff="stops enhancing their muscles."
	BP=1
	Str=1.2
	End=1.3
	Spd=0.8
	Off=0.9
	Def=0.8
	Recov=0.9
	Tier=3
	buffslot=0
	Experience=100
	var/Icon
	/*GetDescription(mob/Getter)
		return "Expand gives [Str]x Strength, [End]x Endurance, [Spd]x Speed, [Off]x Offense and [Def]x Defense."
		..()*/
	verb/Expand()
		set category="Skills"
		set src = usr.contents
		if(usr.HasExpand5)End=1.4
		if(!Using)
			if(usr.Race=="Makyojin")
				if(MakyoStar) BP=1.35
				else BP=1
		use(usr,null,0,0,0,0,0,0,0,0,0)
	/*verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)*/
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)


