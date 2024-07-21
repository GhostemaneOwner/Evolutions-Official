mob/Pet
	Saiba
		icon='Saibaman.dmi'
		icon_state="Saibaman"
		BP=1200
		HP=100
		MaxKi=500
		Ki=500
		Str=1.5
		Pow=1.5
		Spd=1.5
		End=3
		Off=1.1
		Def=1
		GravMastered=30
		MaxAnger=105
		BPMod=1
		KiMod=1
		StrMod=1
		SpdMod=1
		EndMod=1
		OffMod=1
		DefMod=1
		GravMod=0.2
		ZenkaiMod=0.5
		movespeed=3
		pet=1
		player=0
		monster=0
		attackable=1
		move=1
mob/var/pet
mob/var/petmaster
mob/var/petxp=0
mob/var/petlvl=1
mob/var/owner=0
mob
	var
		monster
		player
		movespeed
		ZenkaiMod
		HP
		PL
		SLVL=1
		SXP=1
		SBP=1
		KO=0
		saibaout=0
mob/proc/Pokevolve()
	petxp+=1
	if(petxp>=(petlvl*petlvl*5))
		petxp-=petlvl*petlvl*5
		petlvl+=1
		view(src)<<"[src] pokevolves!"
		BP*=2
		usr.SXP=petxp
		usr.SLVL=petlvl
		usr.SBP=PL
		usr.suffix="Level [usr.SLVL]"
mob/proc/Pet_AI()
	spawn while(src)
		if(HP<=0)
			view(src)<<"[src] is defeated..."
	//			A.saibaout=0
			del(src)
		if(!KO)
			if(!Target)
				var/dostuff=1
				for(var/mob/M in view(2,src)) if(petmaster==M)
					dostuff=0
					break
				if(dostuff)
					for(var/mob/M) if(petmaster==M)
						z=M.z
						if(prob(20)) step_rand(src)
						else step_towards(src,M)
			if(Target)
				step_towards(src,Target)
				//Blasts--------
				if(prob(petlvl**3))
					var/bcolor='12.dmi'
					bcolor+=rgb(50,250,50)
				//	var/obj/A=new/obj/attack/blast/
					spawn(Pow+50) if(usr) del(usr)
					usr.loc=locate(x,y,z)
					usr.icon=bcolor
					usr.icon_state="12"
					usr.density=0
					src.BP=BP
					usr.owner=src
					step(usr,dir)
					walk(usr,dir,2)
					usr.density=1
				//--------------
				var/confirmtarget=0
				for(var/mob/M in oview(src))
					if(M.z==z&&Target==M)
						confirmtarget=1
						break
				if(!confirmtarget) Target=null
		sleep(movespeed)
		