

mob/var/tmp/inConfirm=0
mob/proc/Confirm(Source)
	if(inConfirm) return 0
	else inConfirm=1
	var/Choice=alert(usr,"[Source]","","Yes","No")
	switch(Choice)
		if("Yes")
			inConfirm=0
			return 1
		if("No")
			inConfirm=0
			return 0
