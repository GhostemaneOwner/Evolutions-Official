mob/proc/CanOOC()
	var/planet=src.z
	switch(planet)
		if (1) if(looc_1) return 1
		if (2) if(looc_2) return 1
		if (3) if(looc_3) return 1
		if (4) if(looc_4) return 1
		if (5) if(looc_5) return 1
		if (6) if(looc_6) return 1
		if (7) if(looc_7) return 1
		if (8) if(looc_8) return 1
		if (9) if(looc_9) return 1
		if (10) if(looc_10) return 1
		if (11) if(looc_11) return 1
		if (12) if(looc_12) return 1
		if (13) if(looc_13) return 1
		if (14) if(looc_14) return 1
		if (15) if(looc_15) return 1
		if (16) if(looc_16) return 1
		if (17) if(looc_17) return 1
		if (18) if(looc_18) return 1
	src<<"LOOC has been toggled for your planet!"
	return 0
	