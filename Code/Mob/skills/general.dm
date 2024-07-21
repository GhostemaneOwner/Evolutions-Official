Skill/Attacks
	var/Wave
	var/tmp/chargelvl=1
	var/tmp/charging
	var/tmp/streaming
	var/KiReq
	var/WaveMult
	var/ChargeRate
	var/MaxDistance
	var/MoveDelay
	var/Piercer
	var/Power=1 //Damage multiplier
	var/Explosive=0
	var/Shockwave=0
	var/Paralysis=0
Skill/Attacks
	luminosity = 1
//	Scatter=0 //A barrage effect
//	Fatal=1 //Certain attacks may not be capable of killing

obj/ranged/Blast/proc/Zig_Zag(B,Z) while(src)
	var/A=dir
	var/C=B
	density=0
	while(C)
		step_rand(src)
		C-=1
	density=1
	dir=A
	sleep(Z)

Icon_Obj
	Bolted=1



atom/proc/CleanOverlay(var/image/A,var/Time=1)
	sleep(Time)
	overlays-=A
	overlays.Remove(A)
