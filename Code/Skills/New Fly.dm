

mob/proc/Flight_Land() if(Flying)
	density=1
	if(src.KOd==0) icon_state=""
	//layer=MOB_LAYER
	var/image/_overlay = image(FlightAura) // not sure if the equipped thing is an icon/object so=
	_overlay.layer= MOB_LAYER+EFFECTS_LAYER
	overlays -= _overlay
	Flying=0
	for(var/Skill/Misc/Fly/A in src)
		if(A.overlays) overlays+=A.overlays
		A.Flying=0
mob/var/tmp/Flying=0
Skill/Misc/Fly
	Tier=1
	Experience=100
	desc="Obviously this lets you fly. But it drains energy to do so. The more you use it the more you \
	master it, and the more you master it, the less it drains. Also you can decrease the drain to a \
	lesser level by simply gaining more energy, but the effect is not the same as mastering the move \
	itself. This will let you move much faster than you can by walking."
	var/tmp/Flying
	var/tmp/Clicks = 0
	verb/Fly()
		set category="Skills"
		//set src in usr.SkillList
		if(usr.RPMode) return
		if(isobj(usr.loc)) return
		if(Clicks) return
		for(var/area/UndergroundMine/V in range(0,usr))
			usr<<"You may not fly here."
			return
		Clicks = 1
		if(usr.KOd==0&&usr.icon_state!="Train"&&usr.icon_state!="Meditate")
			if(!usr.Flying&&!Flying)
				if(usr.Ki>=1+(usr.MaxKi*0.5/usr.FlySkill))
					usr.Flying_Loop(src)
					usr.icon_state="Flight"
					//usr.layer=MOB_LAYER+1
//					hearers(6,usr) << 'Flight Start.wav'
					//usr.overlays+=/Icon_Obj/Shadow
					if(usr.SuperFly)
						var/image/_overlay = image(usr.FlightAura) // not sure if the equipped thing is an icon/object so=
						_overlay.layer= MOB_LAYER+EFFECTS_LAYER
						usr.overlays += _overlay
					if(usr.icon=='Demon (10).dmi'||usr.icon=='Demon (15).dmi'||usr.icon=='Demon (16).dmi')
						overlays-=overlays
						overlays=usr.overlays
						usr.overlays-=usr.overlays
					Create_Shadow(usr) // Creates a shadow to give the appearance of floating above ground
					Flight(usr)	// Handles shadow's opacity; makes player bob up and down while flying
					if(usr.KB) usr.AerialRecovery()
				else usr<<"You are too tired to fly."
			else
//				hearers(6,usr) << 'groundhit.wav'
				usr.Flight_Land()
		spawn(10) Clicks=0
	verb/Ki_Settings()
		set category="Other"
		usr.SuperFly=!usr.SuperFly
		if(usr.SuperFly)
			if(Flying)
				var/image/_overlay = image(usr.FlightAura) // not sure if the equipped thing is an icon/object so=
				_overlay.layer= MOB_LAYER+EFFECTS_LAYER
				usr.overlays += _overlay
			usr<<"Super flight activated for when flying"
		else
			if(Flying)
				var/image/_overlay = image(usr.FlightAura) // not sure if the equipped thing is an icon/object so=
				_overlay.layer= MOB_LAYER+EFFECTS_LAYER
				usr.overlays -= _overlay
			usr<<"Super flight deactivated"
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)

mob/proc/Flying_Loop(var/Skill/Misc/Fly/flySkillObj)
	if(flySkillObj)
		flySkillObj.Flying=1
		Flying=1
		spawn(20)
			if(src&&(client||adminObserve))
				if(Flying==1&&flySkillObj.Flying)
					icon_state="Flight"
					if(isobj(src.loc))
						src<< "You stop flying."
						Ki = max(0,Ki)	//don't want negatives
						Flight_Land()
						return
					if(src.loc == locate(0,0,0))
						src<< "You stop flying."
						Ki = max(0,Ki)	//don't want negatives
						Flight_Land()
						return
					if(Ki>25+(MaxKi*0.5/FlySkill/KiMod))  //&& client.inactivity<=3000
						if(!RPMode)
							Flying_Gain()
							icon_state="Flight"
							//layer=MOB_LAYER+1
							if(SuperFly)
								Flying_Gain()
								if(HasFlightMaster) Ki -= 2.5+(((MaxKi)/FlySkill)/10)
								else Ki -= 50+((MaxKi)/FlySkill)
								if(FlySkill<(2000*FlyMod)) FlySkill += (1*FlyMod)
							else
								if(HasFlightMaster) Ki -= 0.25+((((MaxKi*0.5)/FlySkill)/KiMod)/10)
								else Ki -= 5+((MaxKi*0.5)/FlySkill/KiMod)
								if(FlySkill<(1000*FlyMod)) FlySkill += (0.2*FlyMod)
							Ki = max(0,Ki)
					else
						src<< "You stop flying."
						Ki = max(0,Ki)
						Flight_Land()
						return
				else
					Flight_Land()
					return
			src.Flying_Loop(flySkillObj)
	else return
