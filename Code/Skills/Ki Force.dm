//if(Race=="Cerealian"&&MaxKi>=40000&&!(locate(/obj/RedEye)in src))
  //      contents+=new/obj/RedEye
mob/var/RedEye_Clicks
mob/var/RedEye_event
obj/RedEye
   // Difficulty=100000000
    desc="The Cerealian Transformation, Unleashing your red eye allows you to tap into your real power, but at a cost of energy"
    verb/RedEye()
        set category="Skills"
        if(!Using)
            if(isnull(usr.RedEye_event))
           //     usr.RedEye_event = new(skills_scheduler, usr)
                skills_scheduler.schedule(usr.RedEye_event, 20)
                usr.RedEye_Clicks += 1
                Using=1
                view(usr)<<"[usr] begins to open their red eye seeing the real world around them"
                for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] begins opening their red eye.\n")
                usr.BP*=8
                usr.Spd*=2
                usr.SpdMod*=2
                usr.Def*=2
                usr.DefMod*=2
                usr.Regeneration*=3
     //   else {usr.Cancel_RedEye()}

mob/proc/RedEye_Revert() for(var/obj/RedEye/A in src) if(A.Using)
    A.Using=0
    view(src)<<"[src] closes their red eye"
    for(var/mob/player/M in view(usr)) if(M.client) M.saveToLog("| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] stops RedEyeing their energy.\n")
    BP/=8
    Spd/=2
    SpdMod/=2
    Def/=2
    DefMod/=2
    Regeneration/=3

Skill/Buff/Ki_Force
	buffon="begins using Ki Force."
	buffoff="stops using Ki Force."
	BP=1.45
	Pow=1.45
	Str=0.8
	Tier=2
	DoesNotStackWith="Muscle Force"
//	energydrain=LowDrain
	icon='blackflameaura.dmi'
	layer=MOB_LAYER+1
	DoesNotStackWith="Muscle Force"
	Experience=100
	/*GetDescription(mob/Getter)
		return "Using this ability drains a constant amount of energy. While using this your BP increase by [BP]x, Force will increase by [Pow]x, but decrease your Strength by [Str]x."
		..()*/
	New()
		src.icon+=rgb(rand(1,225),rand(1,225),rand(1,225))
		..()
	verb/Ki_Force()
		set category="Skills"
		set src = usr.contents
		use(usr,null,0,0,0,0,0,0)
	verb/Teach(mob/player/A in view(usr))
		set category="Other"
		Teachify(usr,A)



