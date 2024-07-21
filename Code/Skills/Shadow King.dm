
Skill/Buff/Shadow_King
	BP=1.85
	Str=1.55
	End=1.25
	Def=1.55
	Anger=1.25
	Regen=1.25
	buffslot=1
//	energydrain=MediumDrain
	buffon="taps into other-worldly power!"
	buffoff="stops tapping into other-worldly power."
	/*GetDescription()
		return "Shadow King counts as 2 Buff Slots. It grants [BP]x BP, [End]x Endurance, [Anger]x Anger and [Regen]x Regeneration."
		..()*/
	//var/LastUse=0
	verb/Shadow_King()
		set category="Skills"
		use(usr)
		usr.Shadow_Overlays(Using)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)


mob/proc/Shadow_Overlays(add=0)
	var/image/A=image(icon='Okage.dmi',icon_state="1",layer=MOB_LAYER+2,pixel_y=32)
	var/image/B=image(icon='Okage.dmi',icon_state="2")
	underlays.Remove('Okage.dmi',A)
	overlays-=B
	if(add)
		underlays.Add('Okage.dmi',A)
		overlays+=B







mob/var/DisableRegen=0

Skill/Buff/Arcane_Power
	BP=1.4
	Str=1.4
	Pow=1.4
	Spd=1.2
	buffslot=1
//	staticenergydrain=HighStaticDrain
	icon='Arcane Power (1).dmi'
	buffon="displays tremendous magical power!"
	buffoff="stops their display of arcane power."
	New()
		..()
		icon=pick('Arcane Power (1).dmi','Arcane Power (2).dmi')
	/*GetDescription()
		return "Will of the Dead counts as 2 Buff Slots. It grants [BP]x BP, [Str]x Strength, [Pow]x Force and disables Regeneration while active. It has no drain."
		..()*/
	//var/LastUse=0
	verb/Arcane_Power()
		set category="Skills"
		use(usr, null, 0, 0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

