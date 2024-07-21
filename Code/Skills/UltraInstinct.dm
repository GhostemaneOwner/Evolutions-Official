mob/var/UI_event
mob/var/Cancel_UI
obj/UI
   // Difficulty=450
    desc="A Power of the Gods, Only Given to thoes who have mastered the art of God ki, It Drains Heavely at first but eventually can be Mastered with the Proper Traning."
    verb/UI()
        set category="Skills"
        if(!Using)
            if(isnull(usr.UI_event))
              // usr.UI_event = new(skills_scheduler, usr)
                skills_scheduler.schedule(usr.UI_event, 20)
            //    usr.UI_Clicks += 1  
                Using=1
                view(usr)<<"[usr] goes still as there Ki changes, unlocking Ultra Instinct"
                for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] begins UIing their energy.\n")
                usr.BP*=5
                usr.Spd*=2
                usr.SpdMod*=2
                usr.Off*=300
                usr.Def*=300
                usr.Regeneration*=2
     //   else {usr.Cancel_UI()}

mob/proc/UI_Revert() for(var/obj/UI/A in src) if(A.Using)
    A.Using=0
    view(src)<<"[src] stops using Ultra Instict"
    for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] stops UIing their energy.\n")
    BP/=5
    Spd/=2
    SpdMod/=2
    Off/=300
    Def/=300
    Regeneration/=2
/*Event/Timer/UltraInstinct
	var/tmp/mob/player
	New(var/EventScheduler/scheduler, var/mob/D)
		..(scheduler, 25)
		src.player = D
	fire()
		..() // Make sure we allow the /Event/Timer fire() to do it's thing.
		if(isnull(player)){skills_scheduler.cancel(src);return}
		//Focus
		if(player.UltraInstinct_Clicks > 2)
			player.UltraInstinct_Clicks -= 1
			return
		for(var/Skill/Buff/UltraInstinct/A in player) if(!player.RPMode)
			if(A.Using)
				if(player.Ki>=player.MaxKi*0.02)
					player.DrainKi("Ultra Instinct", "SoftCapPercent", Tier3Drain)
					//player.Ki=max(0,player.Ki-(player.MaxKi*0.2)/A.Experience)
					if(!player.afk&&player.icon_state!="Meditate") A.Experience+=0.5
					if(prob(20)) player.Willpower-=0.25
					if(A.Experience>100) A.Experience=100
				else {player.Cancel_UltraInstinct();player=null}
			else {player.Cancel_UltraInstinct();player=null}


mob/var/tmp/Event/Timer/UltraInstinct/ultrainstinct_event = null
mob/var/tmp/UltraInstinct_Clicks = 0
mob/proc/Cancel_UltraInstinct()
	if (src.ultrainstinct_event)
		skills_scheduler.cancel(src.ultrainstinct_event)
		del(src.ultrainstinct_event)
		src.ultrainstinct_event = null
	src.UltraInstinct_Revert()*/

Skill/Buff/Ultra_Instinct
	BP=3.5
	Spd=2
	Off=2
	Def=2
	Recov=2
	icon='SatsuiAura.dmi'
	buffon="begins using Ultra Instinct."
	buffoff="stops using Ultra Instinct."
	layer=MOB_LAYER+1
	buffslot=3
	healthdrain=1
	var/Precog=0
	Experience=1
	/*GetDescription(mob/Getter)
		return "Increases God Ki by 50%, BP by [BP]x, Speed by [Spd]x, Offense by [Off]x and Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	New()
		//icon-=rgb(130,0,0)
		icon+=rgb(0,184,184,200)
		//157,95,191
		..()
	verb/Ultra_Instinct()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/UIAura,0,0,0,0,0,0,0,1)
		usr.FirstTransWPRestore(usr,6)

Skill/Buff/Royal_Blue_Form
	BP=1.85
	Spd=1.65
	Str=2
	End=1.8
	Def=1.55
	Recov=2.5
	icon='SatsuiAura.dmi'
	buffon="begins using Ultra Ego."
	buffoff="stops using Ultra Ego."
	layer=MOB_LAYER+1
	buffslot=2
	healthdrain=1
	var/Precog=0
	Experience=1
	New()
		//icon-=rgb(130,0,0)
		icon+=rgb(0,184,184,200)
		//157,95,191
		..()
	verb/Royal_Blue_Form()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/UIAura,0,0,0,0,0,0,0,1)

Skill/Buff/Ultra_Ego
	BP=3.5
	Spd=2
	Str=2
	End=2.5
	Def=2.5
	Recov=2.5
	icon='SatsuiAura.dmi'
	buffon="begins using Ultra Ego."
	buffoff="stops using Ultra Ego."
	layer=MOB_LAYER+1
	buffslot=3
	healthdrain=1
	var/Precog=0
	Experience=1
	New()
		//icon-=rgb(130,0,0)
		icon+=rgb(0,184,184,200)
		//157,95,191
		..()
	verb/Ultra_Ego()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/UIAura,0,0,0,0,0,0,0,1)

Skill/Buff/Invert_Power
	BP=2
	Spd=1.55
	Str=1.65
	End=1.45
	Def=1.75
	Recov=2.2
	icon='SatsuiAura.dmi'
	buffon="awakens there Inverted Power!."
	buffoff="stops using there Inverted Power.!"
	layer=MOB_LAYER+1
	buffslot=2
	healthdrain=1
	var/Precog=0
	Experience=1
	/*GetDescription(mob/Getter)
		return "Increases God Ki by 50%, BP by [BP]x, Speed by [Spd]x, Offense by [Off]x and Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	New()
		//icon-=rgb(130,0,0)
		icon+=rgb(196, 110, 29, 200)
		//157,95,191
		..()
	verb/Invert_Power()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/UIAura,0,0,0,0,0,0,0,1)
		usr.FirstTransWPRestore(usr,6)
		

Skill/Buff/Darkness_of_the_Flames
	BP=2
	Spd=1.55
	Str=1.65
	End=1.45
	Def=1.75
	Recov=2.5
//	see_invisible = 71
	buffslot = 3
	Experience=100
	Tier=3
	layer=MOB_LAYER+1
	icon='SharinganEyes.dmi'
    //BuffTechniques=list("/obj/Skills/Six_Paths_of_Pain")
	buffon="ascends into enlightment as their eyes perceive all six paths of Samsara!"
	buffoff="closes their eyes to the truth of the world..."
	verb/Darkness_of_the_Flames()
		set category="Skills"
		set name="Sharingan Eyes"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0,0,0,0)

Skill/Buff/Samara_Susano
	BP=1.55
	Spd=1.55
	Str=1.65
	End=1.45
	Def=1.75
	Recov=2.5
//	see_invisible = 71
	buffslot = 3
	Tier=3
	Experience=100
	layer=MOB_LAYER+1
	icon='Susano Itachi.dmi'
    //BuffTechniques=list("/obj/Skills/Six_Paths_of_Pain")
	buffon="ascends into enlightment as their eyes perceive all six paths of Samsara!"
	buffoff="closes their eyes to the truth of the world..."
	verb/Samara_Susano()
		set category="Skills"
		set name="Susano Itachi"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0,0,0,0)

Skill/Buff/Orange_Namekian
	BP=2
	Spd=1.55
	Str=1.65
	End=1.45
	Def=1.75
	Recov=2.2
	icon='SatsuiAura.dmi'
	buffon="awakens the power of the Namekians of Old."
	buffoff="stops using The Ancient Namekian Power."
	layer=MOB_LAYER+1
	buffslot=3
	healthdrain=1
	var/Precog=0
	Experience=1
	/*GetDescription(mob/Getter)
		return "Increases God Ki by 50%, BP by [BP]x, Speed by [Spd]x, Offense by [Off]x and Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	New()
		//icon-=rgb(130,0,0)
		icon+=rgb(196, 110, 29, 200)
		//157,95,191
		..()
	verb/Orange_Namekian()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/UIAura,0,0,0,0,0,0,0,1)
		usr.FirstTransWPRestore(usr,6)

Skill/Buff/Resolve_of_Chaos
	BP=2
	Spd=1.55
	Str=1.65
	End=1.45
	Def=1.75
	Recov=2.2
	icon='SatsuiAura.dmi'
	buffon="awakens the power of Resolve of Chaos."
	buffoff="stops using the Chaos Power!."
	layer=MOB_LAYER+1
	buffslot=3
	healthdrain=1
	var/Precog=0
	Experience=1
	/*GetDescription(mob/Getter)
		return "Increases God Ki by 50%, BP by [BP]x, Speed by [Spd]x, Offense by [Off]x and Defense by [Def]x and Recovery by [Recov]x."
		..()*/
	New()
		//icon-=rgb(130,0,0)
		icon+=rgb(196, 110, 29, 200)
		//157,95,191
		..()
	verb/Resolve_of_Chaos()
		set category="Skills"
		set src = usr.contents
		use(usr,/Icon_Obj/Cloak/UIAura,0,0,0,0,0,0,0,1)
		usr.FirstTransWPRestore(usr,6)


		// Under this line is Greys Transformation Buff
mob/var/Invert_event
mob/var/Cancel_Invert
obj/Invert
   // Difficulty=450
    desc="A Power of the Gods, Only Given to thoes who have mastered the art of God ki, It Drains Heavely at first but eventually can be Mastered with the Proper Traning."
    verb/UI()
        set category="Skills"
        if(!Using)
            if(isnull(usr.Invert_event))
              // usr.UI_event = new(skills_scheduler, usr)
                skills_scheduler.schedule(usr.UI_event, 20)
            //    usr.UI_Clicks += 1  
                Using=1
                view(usr)<<"[usr] goes Invert!"
                for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] begins UIing their energy.\n")
                usr.BP*=5
                usr.Spd*=2
                usr.SpdMod*=2
                usr.Off*=300
                usr.Def*=300
                usr.Regeneration*=2
     //   else {usr.Cancel_UI()}

mob/proc/Invert_Revert() for(var/obj/UI/A in src) if(A.Using)
    A.Using=0
    view(src)<<"[src] stops using Invert ability."
    for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] stops UIing their energy.\n")
    BP/=5
    Spd/=2
    SpdMod/=2
    Off/=300
    Def/=300
    Regeneration/=2
	