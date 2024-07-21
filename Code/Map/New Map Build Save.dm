
var/list/CustomTurfs=new
//var/list/worldObjectList = new // Looped through during the saving of objects



proc/Save_Custom_Turfs()
	set background = 1
	world<<"<small>Server: Saving Custom Turfs..."
	var/Amount=0
	var/E=1
	var/savefile/F=new("Data/MapSaves/CustomTurfs[E]")
	var/list/Types=new
	var/list/Healths=new
	var/list/Levels=new
	var/list/Builders=new
	var/list/Xs=new
	var/list/Ys=new
	var/list/Zs=new
	var/list/Icons=new
	var/list/Icons_States=new
	var/list/Densitys=new
	var/list/isRoof=new
	var/list/Opacitys=new
	var/list/FlyOver=new
	var/list/isOutside=new


	for(var/turf/Upgradeable/CustomTurf/A in CustomTurfs)
		if(A)
			Types+=A.type
			Healths+="[num2text(round(A.Health),100)]"
			Levels+="[num2text(A.Level,100)]"
			Builders+=A.Builder
			Xs+=A.x
			Ys+=A.y
			Zs+=A.z
			Icons+=A.icon
			Icons_States+=A.icon_state
			Densitys+=A.density
			isRoof+=A.Roof
			Opacitys+=A.opacity
			FlyOver+=A.FlyOverAble
			isOutside+=A.Inside
			Amount+=1
			if(Amount % 20000 == 0)
				F["Types"]<<Types
				F["Healths"]<<Healths
				F["Levels"]<<Levels
				F["Builders"]<<Builders
				F["Xs"]<<Xs
				F["Ys"]<<Ys
				F["Zs"]<<Zs
				F["Icons"]<<Icons
				F["Icons_States"]<<Icons_States
				F["Densitys"]<<Densitys
				F["isRoof"]<<isRoof
				F["Opacitys"]<<Opacitys
				F["FlyOver"]<<FlyOver
				F["isOutside"]<<isOutside
				E ++
				F=new("Data/MapSaves/CustomTurfs[E]")
				Types=new
				Healths=new
				Levels=new
				Builders=new
				Xs=new
				Ys=new
				Zs=new
				Icons=new
				Icons_States=new
				Densitys=new
				isRoof=new
				Opacitys=new
				FlyOver=new
				isOutside=new

	if(Amount % 20000 != 0)
		F["Types"]<<Types
		F["Healths"]<<Healths
		F["Levels"]<<Levels
		F["Builders"]<<Builders
		F["Xs"]<<Xs
		F["Ys"]<<Ys
		F["Zs"]<<Zs
		F["Icons"]<<Icons
		F["Icons_States"]<<Icons_States
		F["Densitys"]<<Densitys
		F["isRoof"]<<isRoof
		F["Opacitys"]<<Opacitys
		F["FlyOver"]<<FlyOver
		F["isOutside"]<<isOutside
	world<<"<small>Server: Custom Turfs Saved([Amount])."

proc/Load_Custom_Turfs()
	set background = 1
	if(fexists("Data/MapSaves/CustomTurfs1"))
		world<<"<small>Server: Loading Custom Turfs..."
		var/Amount=0
		var/DebugAmount= 0
		var/E=1
		load
		if(!fexists("Data/MapSaves/CustomTurfs[E]"))
			goto end
		var/savefile/F=new("Data/MapSaves/CustomTurfs[E]")
		sleep(1)
		var/list/Types=F["Types"]
		var/list/Healths=F["Healths"]
		var/list/Levels=F["Levels"]
		var/list/Builders=F["Builders"]
		var/list/Xs=F["Xs"]
		var/list/Ys=F["Ys"]
		var/list/Zs=F["Zs"]
		var/list/Icons=F["Icons"]
		var/list/Icons_States=F["Icons_States"]
		var/list/Densitys=F["Densitys"]
		var/list/isRoof=F["isRoof"]
		var/list/Opacitys=F["Opacitys"]
		var/list/FlyOver=F["FlyOver"]
		var/list/isOutside=F["isOutside"]
		Amount = 0
		for(var/A in Types)
			Amount+=1
			DebugAmount += 1
			var/turf/Upgradeable/CustomTurf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
			T.icon= Icons[Amount]
			T.icon_state= Icons_States[Amount]
			T.density=text2num(list2params(Densitys.Copy(Amount,Amount+1)))
			T.opacity=text2num(list2params(Opacitys.Copy(Amount,Amount+1)))
			T.Roof=text2num(list2params(isRoof.Copy(Amount,Amount+1)))
			T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
			T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
			T.Builder=list2params(Builders.Copy(Amount,Amount+1))
			T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
			T.Inside=text2num(list2params(isOutside.Copy(Amount,Amount+1)))
			CustomTurfs+=T // Turfs is the global list for all objects placed by players.
			for(var/obj/Turfs/Edges/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Surf/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Trees/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/B in T) if(!B.Builder) del(B)

			if(Amount == 20000)
				sleep(1)
				break

		if(Amount == 20000)
			E ++
			goto load

		end
		world<<"<small>Server: Custom Turfs Loaded ([DebugAmount] in [E] Files.)"
	global.MapsLoaded=1
	global.CanSave = 1
proc/Save_Turfs()
	set background = 1
	world<<"<small>Server: Saving Map..."
	var/Amount=0
	var/E=1
	var/savefile/F=new("Data/MapSaves/File[E]")
	var/list/Types=new
	var/list/Healths=new
	var/list/Levels=new
	var/list/Builders=new
	var/list/Xs=new
	var/list/Ys=new
	var/list/Zs=new
	var/list/FlyOver=new
	var/list/isOutside=new

//	debuglog << "[__FILE__]:[__LINE__] We got this far for mapfile[E]"

	for(var/turf/A in Turfs)
		if(A)
			Types+=A.type
			Healths+="[num2text(round(A.Health),100)]"
			Levels+="[num2text(A.Level,100)]"
			Builders+=A.Builder
			Xs+=A.x
			Ys+=A.y
			Zs+=A.z
			FlyOver+=A.FlyOverAble
			isOutside+=A.Inside
			Amount+=1
			if(Amount % 20000 == 0)
				F["Types"]<<Types
				F["Healths"]<<Healths
				F["Levels"]<<Levels
				F["Builders"]<<Builders
				F["Xs"]<<Xs
				F["Ys"]<<Ys
				F["Zs"]<<Zs
				F["FlyOver"]<<FlyOver
				F["isOutside"]<<isOutside
				E ++
				F=new("Data/MapSaves/File[E]")
				Types=new
				Healths=new
				Levels=new
				Builders=new
				Xs=new
				Ys=new
				Zs=new
				FlyOver=new
				isOutside=new

//	debuglog << "[__FILE__]:[__LINE__] We got this far for mapfile[E]"

	if(Amount % 20000 != 0)
		F["Types"]<<Types
		F["Healths"]<<Healths
		F["Levels"]<<Levels
		F["Builders"]<<Builders
		F["Xs"]<<Xs
		F["Ys"]<<Ys
		F["Zs"]<<Zs
		F["FlyOver"]<<FlyOver
		F["isOutside"]<<isOutside

//	debuglog << "[__FILE__]:[__LINE__] Map saved mapfile[E] :: Total amount of crap: [Amount]"

	world<<"<small>Server: Map Saved([Amount])."
	Save_Custom_Turfs()

proc/Load_Turfs()
	set background = 1
	if(fexists("Data/MapSaves/File1"))
		world<<"<small>Server: Loading Map..."
		var/Amount=0
		var/DebugAmount= 0
		var/E=1
		load
		if(!fexists("Data/MapSaves/File[E]"))
			goto end
		var/savefile/F=new("Data/MapSaves/File[E]")
		sleep(1)
		var/list/Types=F["Types"]
		var/list/Healths=F["Healths"]
		var/list/Levels=F["Levels"]
		var/list/Builders=F["Builders"]
		var/list/Xs=F["Xs"]
		var/list/Ys=F["Ys"]
		var/list/Zs=F["Zs"]
		var/list/FlyOver=F["FlyOver"]
		var/list/isOutside=F["isOutside"]
		Amount = 0
		for(var/A in Types)
			Amount+=1
			DebugAmount += 1
			var/turf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
			T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
			T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
			T.Builder=list2params(Builders.Copy(Amount,Amount+1))
			T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
			T.Inside=text2num(list2params(isOutside.Copy(Amount,Amount+1)))
			Turfs+=T // Turfs is the global list for all objects placed by players.
			for(var/obj/Turfs/Edges/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Surf/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Trees/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/B in T) if(!B.Builder) del(B)

			if(Amount == 20000)
				sleep(1)
				break

		if(Amount == 20000)
			E ++
			goto load

		end
		world<<"<small>Server: Map Loaded ([DebugAmount] in [E] Files.)"
	else world<<"<small>Server: No Map Loaded"
	Load_Custom_Turfs()

//	spawn()SpawnMaterial()



/*

var/list/Builds=new // Builds is a list used to display icons in the buildpanel for players. This is NOT the things they have already built!
var/list/AdminBuilds=new //This is for /turf/Special, which is (normally) admin accessable only.
proc/Add_Builds()
	for(var/A in typesof(/turf))
		var/turf/C=new A(locate(1,1,1))
		if(C.Buildable&&C.type!=/turf)
			if(!istype(C,/turf/IconsX))
				var/obj/Build/B=new
				B.icon=C.icon
				B.icon_state=C.icon_state
				B.Creates=C.type
				B.name="-[C.name]-"
				Builds+=B
		del(C)
	for(var/A in typesof(/obj/Turfs))
		var/obj/B=new A
		if(B.Buildable&&B.type!=/obj/Turfs)
			if(!istype(B,/obj/Turfs/IconsX)&&!istype(B,/obj/Turfs/IconsXLBig))
				var/obj/Build/C=new
				C.icon=B.icon
				C.icon_state=B.icon_state
				C.Creates=B.type
				C.name="-[B.name]-"
				Builds+=C
	for(var/A in typesof(/turf/Special))
		var/turf/C=new A(locate(1,1,1))
		if(C.type!=/turf/Special)
			var/obj/Build/B=new
			B.icon=C.icon
			B.icon_state=C.icon_state
			B.Creates=C.type
			B.name="-[C.name]-"
			AdminBuilds+=B

var/list/Builds2=new
proc/Add_Builds2()
	for(var/A in typesof(/turf))
		var/turf/C=new A(locate(1,1,1))
		if(C.Buildable&&C.type!=/turf)
			if(istype(C,/turf/IconsX))
				var/obj/Build/B=new
				B.icon=C.icon
				B.icon_state=C.icon_state
				B.Creates=C.type
				B.name="-[C.name]-"
				Builds+=B
		del(C)
	for(var/A in typesof(/obj/Turfs))
		var/obj/B=new A
		if(B.Buildable&&B.type!=/obj/Turfs)
			if(istype(B,/obj/Turfs/IconsX)||istype(B,/obj/Turfs/IconsXLBig))
				var/obj/Build/C=new
				C.icon=B.icon
				C.icon_state=B.icon_state
				C.Creates=B.type
				C.name="-[B.name]-"
				Builds+=C
*/


proc/Build_Lay(obj/Build/O,mob/P) if(P.KOd==0 && !P.inertia_dir) //Type to build, player who is building it, location to put it, can't be floundering through space

	//debuglog << "[__FILE__]:[__LINE__] || src: [src ? src : "null"] usr: [usr ? usr : "null"] build_lay()"
	var/atom/D=P
	if(P.S) D=P.S
	var/obj/Resources/AA
	for(var/obj/Resources/B in P) AA=B
	if(!P.BuildIsFree&&!P.HasBuildingPermit)
		if(P.BuildWithMana)
			for(var/obj/Mana/B in P) AA=B
			if(AA.Value<100*(1-(0.15*P.HasDeepPockets)))
				P<<"You do not have enough mana. ([100*(1-(0.15*P.HasDeepPockets))] per tile)"
				return
			else AA.Value-=100*(1-(0.15*P.HasDeepPockets))
		else
			if(AA.Value<100*(1-(0.15*P.HasDeepPockets)))
				P<<"You do not have enough resources. ([100*(1-(0.15*P.HasDeepPockets))] per tile)"
				return
			else AA.Value-=100*(1-(0.15*P.HasDeepPockets))
	for(var/obj/Controls/N in view(1,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to ship controls"
		return
	for(var/obj/Controls/PodControls/N in view(3,locate(D.x,D.y,D.z)))
		P<<"You cannot build inside a pod"
		return
	for(var/obj/Magical_Portal/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build here."
		return
	for(var/obj/Airlock/N in view(1,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to an airlock!"
		return
	for(var/turf/Special/N in view(2,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to special tiles."
		return
	for(var/obj/Warper/W in view(2,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to warpers."
		return
	for(var/area/PlanetWrapper/W in view(3,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to the map edge."
		return
	for(var/obj/Warper/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build here."
		return
	if(P.z!=17) if(P.x<5||P.x>495||P.y<5||P.y>495)
		P<<"You cannot build this close to the edge."
		return
	for(var/area/UndergroundMine/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build here."
		return
	for(var/turf/Special/W in view(3,P)) if(!usr.client.holder||usr.client.holder.level<1)
		P<<"You cannot build this close to warpers."
		return
	for(var/turf/Other/Stars/S in view(1,locate(D.x,D.y,D.z))) if(!usr.client.holder||usr.client.holder.level<1) if(!usr.BuildInSpace)
		P<<"You cannot build in deep space."
		return
	if(P.z == SPACE_Z_LEVEL)
		if((P.x <= 3) || (P.x >= (world.maxx-3)) || (P.y <= 3) || (P.y >= (world.maxy-3))) if(!usr.client.holder||usr.client.holder.level<1)
			P << "You cannot build this close to the edge of space."
			return
	if(O.Creates==/obj/Door)
		for(var/obj/Door/DD in view(0,usr))
			P<<"You can not layer doors."
			return
	var/atom/C=new O.Creates(locate(D.x,D.y,D.z))
	C.Builder="[P.real_name]"
	if(isobj(C))
		var/Turf_Objects=0
		for(var/obj/K in get_turf(P))
			if(!(locate(K) in P))
				Turf_Objects++
			if(Turf_Objects>4)
				P<<"Nothing more can be placed here."
				del(C)
				return
			else
				global.worldObjectList+=C
				C.Savable=1
				if(P.BuildLayer) C.layer=P.BuildLayer
		if(P.ImmuneYear)
			P<<"Set with [P.ImmuneYear] as Immune Year"
			C.ImmuneYear=P.ImmuneYear
		if(istype(C,/obj/Door))
			C:Grabbable=0
			var/New_Password=input(P,"Enter a password or leave blank") as text
			if(!C) return
			C.Password=New_Password
			for(var/obj/Props/E in get_turf(P)) del(E)
			for(var/obj/Turfs/EE in get_turf(P)) del(EE)
		if(istype(C,/obj/Props/Sign))
			C.desc=input(P,"What do you want to write on the sign?") as text
		if(istype(C,/obj/Turfs/CustomObj1))
			C.icon=P.CustomObj1Icon
			C.icon_state=P.CustomObj1State
			C.layer=P.CustomObj1Layer
			C.density=P.CustomObj1Density
			C.pixel_x=P.CustomObj1X
			C.pixel_y=P.CustomObj1Y
	else
		var/ousside=0
		if(istype(C,/turf/Terrain/Water)) ousside=1
		if(istype(C,/turf/Terrain/Ground)) ousside=1
		if(istype(C,/turf/Terrain/Grass)) ousside=1
		for(var/obj/Props/E in view(0,locate(D.x,D.y,D.z))) del(E)
		for(var/obj/Turfs/EE in view(0,locate(D.x,D.y,D.z))) del(EE)
		if(istype(C,/turf/Upgradeable/CustomTurf))
			var/turf/Upgradeable/CustomTurf/CT=C
			C.icon=usr.CustomTurfIcon
			C.icon_state=usr.CustomTurfState
			CT.Roof=usr.CustomTurfRoof
			C.density=usr.CustomTurfDensity
			C.opacity=usr.CustomTurfOpacity
		if(!P.OutsideBuild&&!ousside) if(istype(C,/turf))
			var/turf/TTT=C
			TTT.Inside=1
		if(!istype(C,/turf/Upgradeable/CustomTurf))
			Turfs+=C
		else
			CustomTurfs+=C
		if(P.ImmuneYear)
			P<<"Set with [P.ImmuneYear] as Immune Year"
			C.ImmuneYear=P.ImmuneYear













mob/var
	CustomObj1Icon='ArtificalObj.dmi'
	CustomObj1State="QuestionMark"
	CustomObj1X=0
	CustomObj1Y=0
	CustomObj1Density=0
	CustomObj1Opacity=0
	CustomObj1Layer=3
	CustomTurfIcon='ArtificalObj.dmi'
	CustomTurfState="QuestionMark"
	CustomTurfRoof=0
	CustomTurfDensity=0
	CustomTurfOpacity=0

mob/verb
	CustomTurf()
		set category=null//"Other"
		//set name="Custom Turf"
		var/customselect=input("Choose a command.") in list("Cancel","Change Icon","Change Icon State","Change Roof Setting","Change Density","Change Opacity")
		switch(customselect)
			if("Cancel")
				return
			if("Change Icon")
				var/icon/_iconchoose=input(usr,"Choose an icon for your custom build object!","ChangeIcon")as icon
				var/icon/Z= new /icon(_iconchoose)
				if((length(Z) > 102400))
					usr <<"This file exceeds the limit of 100KB. It cannot be used."
					return
				if( Z.Width()!=32 || Z.Height()!=32 )
					usr<<"Custom turfs can only be 32x32."
					return
				usr.CustomTurfIcon=Z
				usr.CustomTurfState=input("Enter the icon's state name here.") as text
			if("Change Icon State")
				usr.CustomTurfState=input("Enter the icon's state name here.") as text
			if("Change Density")
				if(usr.CustomTurfDensity==1)
					usr.CustomTurfDensity=0
					usr<<"Custom Turf density disabled."
				else if(usr.CustomTurfDensity==0)
					usr.CustomTurfDensity=1
					usr<<"Custom Turf density enabled."
			if("Change Opacity")
				if(usr.CustomTurfOpacity==1)
					usr.CustomTurfOpacity=0
					usr<<"Custom turf opacity disabled."
				else if(usr.CustomTurfOpacity==0)
					usr.CustomTurfOpacity=1
					usr<<"Custom Turf opacity enabled."
			if("Change Roof Setting")
				if(usr.CustomTurfRoof==1)
					usr.CustomTurfRoof=0
					usr<<"Custom turf roof disabled."
				else if(usr.CustomTurfRoof==0)
					usr.CustomTurfRoof=1
					usr<<"Custom Turf roof enabled."

	CustomObject()
		set category=null//="Other"
		//set name="Custom Object"
		var/customselect=input("Choose a command.") in list("Cancel","Change Icon","Change Icon State","Change X Offset","Change Y Offset","Change Density","Change Opacity","Change Layer")
		switch(customselect)
			if("Cancel")
				return
			if("Change Icon")
				var/Z=input(usr,"Choose an icon for your custom build object!","ChangeIcon")as icon
				if((length(Z) > 102400))
					usr <<"This file exceeds the limit of 100KB. It cannot be used."
					return
				usr.CustomObj1Icon=Z
				usr.CustomObj1State=input("Enter the icon's state name here.") as text
			if("Change Icon State")
				usr.CustomObj1State=input("Enter the icon's state name here.") as text
			if("Change X Offset")
				usr.CustomObj1X=input("Enter the icon's Pixel X offset.") as num
			if("Change Y Offset")
				usr.CustomObj1Y=input("Enter the icon's Pixel Y offset.") as num
			if("Change Density")
				if(usr.CustomObj1Density==1)
					usr.CustomObj1Density=0
					usr<<"Custom object density disabled."
				else if(usr.CustomObj1Density==0)
					usr.CustomObj1Density=1
					usr<<"Custom object density enabled."
			if("Change Opacity")
				if(usr.CustomObj1Opacity==1)
					usr.CustomObj1Opacity=0
					usr<<"Custom object opacity disabled."
				else if(usr.CustomObj1Opacity==0)
					usr.CustomObj1Opacity=1
					usr<<"Custom object opacity enabled."
			if("Change Layer")
				usr.CustomObj1Layer=input("Enter the layer for the object. A higher number will be drawn 'above' objects of a lower layer. Most objects by default are 3. Minimum 2, Maximum 6.") as num
				if(usr.CustomObj1Layer<2)
					usr.CustomObj1Layer=2
				else if(usr.CustomObj1Layer>6)
					usr.CustomObj1Layer=6


obj/var
	Saved_X
	Saved_Y
	Saved_Z

proc/Save_Objects()
	set background = 1
	world<<"<small>Server: Saving Objects..."
	var/Amount=0
	var/E=1
	var/savefile/F=new("Saves/Itemsave/File[E]")
	var/list/Types=new
	for(var/obj/A in global.worldObjectList) if(A.Savable&&A.z)
		A.Saved_X=A.x
		A.Saved_Y=A.y
		A.Saved_Z=A.z
		Types+=A
		Amount+=1
		if(Amount % 250 == 0)
			F["Types"]<<Types
			E++
			F=new("Saves/Itemsave/File[E]")
			Types=new
	if(Amount % 250 != 0)
		F["Types"]<<Types
	hacklol
	if(fexists("Saves/Itemsave/File[E++]"))
		fdel("Saves/Itemsave/File[E++]")
		world<<"<small>Server: Objects DEBUG system check: extra objects file deleted!"
		E++
		goto hacklol
	world<<"<small>Server: Objects Saved([Amount])."


proc/Load_Objects()
	world<<"<small>Server: Loading Items..."
	var/amount=0
	var/filenum=0
	wowza
	filenum++
	if(fexists("Saves/Itemsave/File[filenum]"))
		var/savefile/F=new("Saves/Itemsave/File[filenum]")
		var/list/L=new
		F["Types"]>>L
		for(var/obj/A in L)
			amount+=1
			A.loc=locate(A.Saved_X,A.Saved_Y,A.Saved_Z)
		goto wowza
	world<<"<small>Server: Items Loaded ([amount])."
	