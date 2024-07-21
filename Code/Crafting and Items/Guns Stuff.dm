


/*

mob/verb/CheckGunBPAssign()
	var/M = input("Tech Level") as num
	usr<<"[GunBPAssign(M)]"*/

proc/GunBPAssign(TechLevel,TechMod)
	var/BPScale=2.012984951
	var/BPTier=150
	BPTier*=(BPScale**min(25,TechLevel))
	if(TechLevel>25)
		BPTier=500000
		BPScale=1.131849642
		BPTier*=BPScale**min(75,(TechLevel-25))
	if(TechLevel>75)
		BPTier=1000000
		BPScale=1.068000433
		BPTier*=BPScale**min(145,(TechLevel-75))
	if(TechLevel>145)
		BPTier=100000000
		BPScale=1.044834776
		BPTier*=BPScale**(TechLevel-145)
	return (BPTier*TechMod)/2
