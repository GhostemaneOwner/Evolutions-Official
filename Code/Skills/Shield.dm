
mob/var/Shielding=0
Skill/Buff/Shield
	End=1.05
//	var/SMEnd=1.1
	buffon="begins to shield themselves."
	buffoff="stops using the shield technique."
	Tier=2
	Experience=100
	New()
		icon=pick('Shield, Legendary.dmi','Pride_Shield.dmi','Basic_Shield.dmi')
		icon+=rgb(rand(1,200),rand(1,200),rand(1,200))
		..()
	icon='Shield, Legendary.dmi'
	/*GetDescription(mob/Getter)
		return "This ability will take 30% of your recovery ticks and convert it into a shield which increases your endurance by [End]x while active. This will also grant a 10% chance to deflect projectiles, reduces beam damage by 10% and reduces explosion damage by 50%."
		..()*/
	buffslot=0
	Using = 0
//	layer=MOB_LAYER+3
	var/Master=0
	verb/Shield()
		set category="Skills"
		if(usr.HasShieldMaster)End=1.1
		else End=1.05
		use(usr,null,0,0,0,0,0,0,1)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)
