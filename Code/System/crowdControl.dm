mob
	var
		KBResist=0


	var/tmp
		Stunned
		StunImmune
		Slow=0
		SlowDuration=0
		SlowImmune
		BonusSpeed=0
		BonusSpeedDuration=0
		Stagger=0
		StaggerImmune
		Frozen






proc
	Stun(mob/m,amount=5,timefreeze=0)
		if(m.StunImmune)
			m.CombatOut("You resisted the stun.")
			return
		var/Stun_Amount=world.time+(amount*10)-m.KBResist
		if(!m.Stunned)
			m.CombatOut("You are stunned. ([amount]x Stun)")
			m.Stunned=Stun_Amount
			if(m.Flying) m.Flight_Land()
			if(timefreeze)
				var/image/_overlay = image('TimeFreeze.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
				m.overlays += _overlay
			else
				var/image/_overlay = image('stunoverlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
				m.overlays += _overlay
	StunCheck(mob/mob)
		if(mob.Stunned)
			if(mob.Stunned<world.time)
				var/image/_overlay = image('stunoverlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
				mob.overlays -= _overlay
				var/image/_overlay2 = image('TimeFreeze.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
				mob.overlays -= _overlay2
				mob.Stunned=0
				mob.StunImmune=world.time+30+mob.KBResist
			else
				return 1
	StunImmuneCheck(mob/mob)
		if(mob.StunImmune)
			if(mob.StunImmune<world.time)
				mob.StunImmune=0
			else
				return 1

	Stagger(mob/m,amount=3)
		if(m.StaggerImmune)
			m.CombatOut("You resisted the stagger.")
			return
		if(!m.Stagger)
			m.CombatOut("Your movement becomes staggered. ([amount]x Stagger)")
			m.Stagger=amount
			var/image/_overlay = image('Stun.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
			m.overlays += _overlay
	StaggerCheck(mob/mob)
		if(mob.Stagger)
			mob.Stagger--
			if(mob.Stagger<1)
				mob.CombatOut("Your movement is no longer staggered.")
				var/image/_overlay = image('Stun.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
				mob.overlays -= _overlay
				mob.Stagger=0
				mob.StaggerImmune=world.time+30+mob.KBResist
	StaggerImmuneCheck(mob/mob)
		if(mob.StaggerImmune)
			if(mob.StaggerImmune<world.time)
				mob.StaggerImmune=0
			else
				return 1

	Slow(mob/m,amount=5,Str=25)
		if(m.SlowImmune)
			m.CombatOut("You resisted the slow.")
			return
		if(!m.SlowDuration)
			m.CombatOut("You become slowed. ([Str]x Slow)")
			m.SlowDuration=world.time+(amount*10)-m.KBResist
			m.Slow=Str
			var/image/_overlay = image('Slow Overlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
			m.overlays += _overlay
	SlowCheck(mob/mob)
		if(mob.BonusSpeedDuration)
			if(mob.BonusSpeedDuration<world.time)
				mob.BonusSpeedDuration=0
				mob.BonusSpeed=0
				var/image/I=image(icon='SweepingKick.dmi',icon_state="1",pixel_y=-32,pixel_x=-32,layer=MOB_LAYER-1)
				mob.overlays-=I
		if(mob.SlowDuration)
			if(mob.SlowDuration<world.time)
				mob.SlowDuration=0
				mob.Slow=0
				mob.SlowImmune=world.time+30+mob.KBResist
				var/image/_overlay = image('Slow Overlay.dmi',layer=MOB_LAYER+EFFECTS_LAYER+10)
				mob.overlays -= _overlay
			else
				return 1
	SlowImmuneCheck(mob/mob)
		if(mob.SlowImmune)
			if(mob.SlowImmune<world.time)
				mob.SlowImmune=0
			else
				return 1

	Acceleration(mob/m,amount=5,Str=50)
		if(!m.BonusSpeedDuration)
			m.CombatOut("You accelerate. ([Str]x Move Speed)")
			m.BonusSpeedDuration=world.time+(amount*10)
			m.BonusSpeed=Str
			var/image/I=image(icon='SweepingKick.dmi',icon_state="1",pixel_y=-32,pixel_x=-32,layer=MOB_LAYER-1)
			m.overlays+=I


