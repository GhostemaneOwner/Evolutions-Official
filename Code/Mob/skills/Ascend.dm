
Skill/Buff/Ascend
	RequiresApproval=0
	buffslot=0
	Tier=4
	BP=1.85
	Spd=1.55
	Off=1.55
	Def=1.55
	Experience=100
	TimedBuff=450
	CDOverride=1800
	NotTeachable = 1
	energydrain=MediumDrain
	buffon="ascends beyond entering God-send!"
	buffoff="returns to normal."
	icon='Ultra_Instinct.dmi'
	alpha=200
	layer=MOB_LAYER+1
	New()
		..()
		icon-=rgb(100,100,100)
	/*GetDescription()
		return "While using this your BP increases by [BP]x, Speed by [Spd]x and Offense by [Off]x for 45 seconds. 30 minute cooldown."
		..()*/
	verb/Ascend()
		set category="Skills"
		if(!Using)
			if(!usr.CanAttack(100,src)) return
			if(usr.ssj==1)
				usr.overlays.Remove(usr.hair,usr.SSjHair,usr.USSjHair,usr.SSjFPHair,usr.SSj2Hair,usr.SSj3Hair,usr.SSj4Hair,usr.SSGFPHair,usr.SSGSSHair,usr.SSRHair,usr.SSGHair)
				usr.overlays+=usr.USSjHair
				buffon="transforms into an ascended Super Saiyan!"
			else if(usr.ssj==2)
				usr.overlays.Remove(usr.hair,usr.SSjHair,usr.USSjHair,usr.SSjFPHair,usr.SSj2Hair,usr.SSj3Hair,usr.SSj4Hair,usr.SSGFPHair,usr.SSGSSHair,usr.SSRHair,usr.SSGHair)
				usr.overlays+=usr.SSj3Hair
				usr.Super_Saiyan_3_Effects()
				buffon="goes even further beyond!"
			else if(usr.ssj==5) buffon="transforms into a form beyond Super Saiyan God Super Saiyan!"
			else if(usr.Oozaru)
				buffon="transforms into a Super Saiyan Oozaru!"
				if(usr.Class=="Legendary") usr.icon='oozaruhayatelssj.dmi'
				else usr.icon='oozaruhayatessj.dmi'
			else buffon="ascends!" //Check
			//usr.DrainKi(src,"Percent",10)
			usr.DrainKi(src, 1, 100,1)
			use(usr)
