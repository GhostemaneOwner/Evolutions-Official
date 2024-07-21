#define CREATE_PATH list(/obj,/mob,/turf)
#define _CSS "<style type='text/css'></style>"

obj/admins/proc/Edit(atom/A as mob|obj|turf|area in world)
	set category = "Admin"
	set name = "Edit Variables"
	log_admin("[key_name(usr)] begins to edit [key_name(A)].")
	alertAdmins("<font color=red>[key_name(usr)] begins to edit [key_name(A)].</b>")
	usr.client<<link("?command=edit;target=\ref[A];type=view;")


client
	Topic(hr,h[],hs)
		var/html=_CSS
		var/extra="clear=1;window=[h["window"]?h["window"]:"popup"]"

		switch(h["command"])

			if("edit")
				if(!src.holder) return
				//	if(!(ckey in Admin)){mob<<"\red You cannot access this command. This attempted breech of security has been recorded!";world.log<<"[mob.name] ([mob.key]) attempted to use edit!";return..()}
				var/atom/O = locate(h["target"])
				if(!O)return
				var/list/varz[0]
				log_admin("[key_name(usr)] begins to edit [O].")
				html+={"<script type="text/javascript">
var OV="";
function Show(L){
	if(OV){
		var YY = document.getElementsByTagName("tr");
		for(var xi=1;xi<=YY.length;xi++) if(YY\[xi]&&YY\[xi].name)if(OV=="*"||YY\[xi].name.charAt(0).toUpperCase()==OV) YY\[xi].style.display='none';
		}

	document.getElementById("tid").style.display='';
	var ZZ = document.getElementById("fmr");
	if(ZZ)ZZ.style.display='none';
	var YY = document.getElementsByTagName("tr");
	for(var xi=1;xi<=YY.length;xi++) if(YY\[xi]&&YY\[xi].name)if(YY\[xi].name.charAt(0).toUpperCase()==L||L=="HideAll") YY\[xi].style.display=(L=="HideAll"?'none':'');
	OV = L;
}

function Search(){
	Show("HideAll");
	var T = document.getElementById("search").value.toLowerCase();
	var YY = document.getElementsByTagName("tr");
	for(var xi=1;xi<=YY.length;xi++) if(YY\[xi]&&YY\[xi].name)if((YY\[xi].name.toLowerCase().search(T))>=0) YY\[xi].style.display='';
	OV="*";
}

function Retrieve(){window.open("byond://?command=edit;target=[h["target"]];type=[h["type"]];category="+OV,"_self");}

</script><body style="background-color:#212121" text="#80d8FF"><font color=#80d8FF>
<h3 align=center>[O.name] ([O.type])</h3>"}
				for(var/X in O.vars)
					var/AA = uppertext(copytext(X,1,2))
					//if(isnum(AA))AA="#"
					if(!(AA in varz))
						var/pos=1
						for(var/XR in varz) if(sorttext(AA, XR) != 1){pos++}else break
						varz.Insert(pos,AA)
						varz[AA]=list()
					varz[AA]+=X
				html+="<hr>"
				for(var/R in varz) html+={"<a href="javascript:Show('[R]')">[R]</a> &nbsp; "}
				html+={"<form method="GET" action="javascript:Search()"><input type="text" id="search" name="value"><input type="submit" value="Search for variable" ></form><form method="get"><input type="hidden" name="command" value="edit" ><input type="hidden" name="target" value="[h["target"]]" ><input type="hidden" name="type" value="search" ></form></center><hr>"}
				html += {"<table id="tid" style="display: 'none';" width=100%>\n<tr><td>VARIABLE NAME</td><td>CURRENT VALUE</td><td>PROBABLE TYPE</td><td><a href="javascript:Retrieve();">UPDATE VARS</a></td></tr>\n"}
				for(var/Y in varz)
					BubbleSort(varz[Y])
					for(var/X in varz[Y])
						if(findtext(X,"learn"))
							continue
						//if(findtext(X,"str")||findtext(X,"skill")||findtext(X,"skill")||findtext(X,"pow")||findtext(X,"end")||findtext(X,"mod")||findtext(X,"grav")||findtext(X,"add")||findtext(X,"magic")||findtext(X,"decline")||findtext(X,"spd")||findtext(X,"def")||findtext(X,"off")||findtext(X,"regen")||findtext(X,"recov")||findtext(X,"req")||findtext(X,"ki")||findtext(X,"max")||findtext(X,"zen")||findtext(X,"base")||findtext(X,"rank")) if(usr.client.holder.level < 4)
							//continue
						else
							var/AA=X
							if(!(X in list("type","client","lastKnownKey","key","ckey","tmpkey","tmpckey","parent_type","verbs","vars","group","address","lastKnownIP","appearance","appearance_flags","animate_movement","bounds","","")+((isarea(O)||isturf(O))?list("x","y","z","loc"):null)))AA={"<a href=byond://?command=edit;target=[h["target"]];type=edit;var=[X]>[X]</a>"}
							html += {"<tr name="[X]" style="display: 'none';"><td>[AA]"}
							if(!issaved(O.vars[X])) html += " <font color=red>(*)</font></td>"
							else html += "</td>"
							html += "<td>[DetermineVarValue(O.vars[X])]</td><td>[DetermineVarType(O.vars[X])]</td></tr>"
				html += "</table>[h["category"]&&h["category"]!="*"?{"<body onLoad="Show('[h["category"]]');">"}:""]"
				switch(h["type"])
					if("view")
						html += "<br><font color=red>(*)</font> A warning is given when a variable \
						may potentially cause an error if modified.  If you ignore that warning and \
						continue to modify the variable, you alone are responsible for whatever \
						mayhem results!</body></html>"
					if("edit")
						var/X,Y=h["nval"],W=h["var"],P=h["nvalue"],L[0],pre="<a href=byond://?command=edit;target=[h["target"]];type=edit;"
						if(h["list"])
							L=dd_text2list(h["list"],"`")
							X=O.vars
							for(var/a in L)X=X[a]
							if(W in X)X=X[W]
						else
							if(h["var"])X=O.vars[h["var"]]
						html+={"<form name="input" id="fmr" action="byond://?" method="get"><h2>[W]</h2></center>"}
						if(Y)
							html+="<h3>"
							if((ckey(W) in list("client","type","parent_type"))||((isarea(O)||isturf(O))&&ckey(W)=="loc")) html+="This variable is not allowed to be edited"
							else if(("nvalue" in h)||Y=="file"||Y=="icon")
								var/I
								if(Y=="file"||Y=="icon")
									switch(Y)
										if("file")I = input(src,"Please select the file you wish to upload.","File Upload") as file|null
										if("icon")I = input(src,"Please select the icon you wish to upload.","Icon Upload") as icon|null
									if(!I)return..()
								html+="[W]: [X] ([DetermineVarType(X)]) has been changed to "
								O.vars[W]=(Y=="num")?text2num(P) :(Y=="type")?text2path(P) :(Y=="ref")? locate(P) :I?I :P //text
								html+="[O.vars[W]] ([DetermineVarType(O.vars[W])])."

								alertAdmins("<font color=red>[usr.key] modified [O.name]'s [W] [X] ([DetermineVarType(X)]) to [O.vars[W]] ([DetermineVarType(O.vars[W])])",2)
								log_admin("[usr.key] modified [O.name]'s [W] [X] ([DetermineVarType(X)]) to [O.vars[W]] ([DetermineVarType(O.vars[W])])")

								if(I&&Y=="icon")
									src<<browse_rsc(I,"\ref[I].png")
									html+={"<img src="\ref[I].png" alt="[copytext("[I]",1,length("[I]")-3)]">"}
							else
								html+={"<input type="hidden" name="command" value="edit">
<input type="hidden" name="target" value="[h["target"]]">
<input type="hidden" name="type" value="edit">
<input type="hidden" name="var" value="[W]">
<input type="hidden" name="nval" value="[Y]">"}
								switch(Y)
									if("remove") //Remove value from list
										if((alert(src,"Are you sure you want to remove this value from its' list?","Remove list value","Yes","No"))!="Yes")return..()
										L-=W
										X=O.vars
										for(var/a in L)X=X[a]
										X-=W
										alert(src,"The value has been removed from its' list?","List value removed")
										html+="VARIABLE/VALUE REMOVED!"

										alertAdmins("<font color=red>[usr.key] removed [O.name]'s [W] variable",2)
										log_admin("[usr.key] removed [O.name]'s [W] variable")

									if("default")
										if((alert(src,"Are you sure you want to restore this variable to its' default value: [initial(O.vars[W])]?","Restore initial value","Yes","No"))!="Yes")return..()
										html+="[W]: [X] ([DetermineVarType(X)]) has been changed to "
										O.vars[W]=initial(O.vars[W])
										html+="[O.vars[W]] ([DetermineVarType(O.vars[W])])."

										alertAdmins("<font color=red>[usr.key] modified [O.name]'s [W] [X] ([DetermineVarType(X)]) to [O.vars[W]] ([DetermineVarType(O.vars[W])])",2)
										log_admin("[usr.key] modified [O.name]'s [W] [X] ([DetermineVarType(X)]) to [O.vars[W]] ([DetermineVarType(O.vars[W])])")

									if("text") html += {"<input type="text" name="nvalue" value="[X]"><input type="submit" value="Change Data">"}
									if("num") html += {"<input type="text" name="nvalue" value="[X]"><input type="submit" value="Change Data">"}
									if("type")
										if(!h["parent"])
											html+={"Please select the parent path you want:</h3><select name="parent" size="4">"}
											for(var/a in list(/mob,/obj,/turf,/area,/atom,/atom/movable))html+="<option>[a]</opion>"
											html+={"</select><br><input type="submit" value="View parent type">"}
										else
											html+={"Please select the path you want:</h3><select name="nvalue" size="10">"}
											for(var/a in typesof(h["parent"]))html+="<option>[a]</opion>"
											html+={"</select><br><input type="submit" value="Change Type">"}
									if("ref")
										if(!h["parent"])
											html+={"Please select the parent path you want:</h3><select name="parent" size="4">"}
											for(var/a in list(/mob,/obj,/turf,/area))html+="<option>[a]</opion>"
											html+={"</select><br><input type="submit" value="View parent type">"}
										else
											html+={"Please select the path you want:<input type="hidden" name="parent" value="[h["parent"]]" ></h3><select name="nvalue" size="10">"}
											var/lisss[0]
											for(var/atom/a)if(!(a.type in lisss))if(istype(a,text2path(h["parent"]))){lisss+=a.type;html+={"<option value="\ref[a]">[a.type][(h["parent"]=="/mob"&&a:client)?" ([a:key])" : ""]</opion>"}}
											html+={"</select><br><input type="submit" value="Change Type" >"}
									if("null")
										if(W=="gender")
											html+="This is not allowed!"
										else
											if((alert(src,"Are you sure you want to turn this variable to null?","Nullify value","Cancel","Yes","No"))!="Yes")return..()
											html+="[W]: [X] ([DetermineVarType(X)]) has been changed to "
											O.vars[W]=null
											html+="[O.vars[W]] ([DetermineVarType(O.vars[W])])."

											alertAdmins("<font color=red>[usr.key] modified [O.name]'s [W] [X] ([DetermineVarType(X)]) to [O.vars[W]] ([DetermineVarType(O.vars[W])])",2)
											log_admin("[usr.key] modified [O.name]'s [W] [X] ([DetermineVarType(X)]) to [O.vars[W]] ([DetermineVarType(O.vars[W])])")

									if("list")html+="Edit to \"List\" has been denied!"
							html+="</h3><p>"
						if(Y!="remove")
							html +="<table width=100%>\n<tr><td>CURRENT VALUE</td><td>PROBABLE TYPE</td></tr>\n"
							html +="<td>[DetermineVarValue(X)]</td><td>[DetermineVarType(X)]</td></tr></table>\n"
							if(L.len||islist(X))pre+="list=[dd_list2text(L+W,"`")]"
							if(!islist(X))
								pre += ";var=[W];nval="
								if(L.len) html +="<hr><h4>What do your wish to do?</h4>[pre]remove>Remove [W] from the list</a>"
								else if(W)html +="<hr><h4>Change variable to:</h4>[pre]default>Default [DetermineVarType(initial(O.vars[W]))]</a><br>[pre]text>Text</a><br>[pre]num>Number</a><br>[pre]type>Type</a><br>[pre]ref>Reference</a><br>[pre]file>File</a><br>[pre]icon>Icon</a><br>[pre]null>Null</a>"
							else
								html +="<hr><h4>The following variables are in the list:</h4><br>"
								if(length(X))
									L+=W
									for(var/a in X)html += "[pre];var=[a]>[a]</a><br>"
								else html+="There's nothing in the list!"
						html+="</form>"
					if("view")
						html +="<h3>Letter <u>[h["letter"]]</u> Index</h3></center><table width=100%>\n<tr><td>VARIABLE NAME</td><td>CURRENT VALUE</td><td>PROBABLE TYPE</td></tr>\n"
						for(var/Y in varz)for(var/X in varz[Y])
							html += {"<tr name="[Y]" style="display: 'none';"><td><a href=byond://?command=edit;target=[h["target"]];type=edit;var=[X]>[X]</a>"}
							if(!issaved(O.vars[X])) html += " <font color=red>(*)</font></td>"
							else html += "</td>"
							html += "<td>[DetermineVarValue(O.vars[X])]</td><td>[DetermineVarType(O.vars[X])]</td></tr>"
						html += "</table>"
						html += "<br><br><font color=red>(*)</font> A warning is given when a variable \
						may potentially cause an error if modified.  If you ignore that warning and \
						continue to modify the variable, you alone are responsible for whatever \
						mayhem results!</body></html>"
		if(html!=_CSS)mob<<browse(html,extra)
		return..()

proc
	DetermineVarType(X)return "[islist(X)? "List" : istext(X)? "Text" : isloc(X)? "Atom" : isnum(X)? "Num" : isicon(X)? "Icon" : istype(X,/datum)? "Type (or datum)" : isnull(X)? X==0?"Num" : "(Null)" : "(Unknown)"]"
	DetermineVarValue(variable)
		if(istext(variable))return "\"[variable]\""
		if(isloc(variable))return "<i>[variable:name]</i> ([variable:type])"
		if(isnum(variable))
			var/return_val = num2text(variable,13)+"<font size=1>"
			switch(variable)
				if(0)return_val  += "(FALSE)"
				if(1)return_val  += "(TRUE, NORTH, or AREA_LAYER)"
				if(2)return_val  += "(SOUTH or TURF_LAYER)"
				if(3)return_val  += "(OBJ_LAYER)"
				if(4)return_val  += "(EAST or MOB_LAYER)"
				if(5)return_val  += "(NORTHEAST or FLOAT_LAYER)"
				if(6)return_val  += "(SOUTHEAST)"
				if(8)return_val  += "(WEST)"
				if(9)return_val  += "(NORTHWEST)"
				if(10)return_val += "(SOUTHWEST)"
			return return_val+"</font>"
		if(isnull(variable))return "null"

		return "- [variable] -"
		