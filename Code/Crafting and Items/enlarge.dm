
atom/proc/Enlarge_Icon(scale)
	if(!icon) return
	var/icon/A=new(icon)
	A.Scale(32*scale,32*scale)
	//var/matrix/M = matrix()
	//M.Scale(scale,scale)
	//A.transform = M
	icon = A
	del(A)
	Enlarge_Overlays(scale)
atom/proc/Enlarge_Overlays(scale)
	if(!overlays) return
	for(var/O in overlays) if(O:icon)
		var/icon/A=new(O:icon,O:icon_state)
		//var/matrix/M = matrix()
		//M.Scale(scale,scale)
		//A.transform = M
		A.Scale(32*scale,32*scale)
		overlays -= O
		overlays += A
		del(A)

