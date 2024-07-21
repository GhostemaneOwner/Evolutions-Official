/*
	EasyFiles browser-based file selection by Lummox JR
	version 1.0
 */

client/var/filedialog/fdlg

filedialog
	var/callsrc
	var/callback	// proc reference

	var/client/owner

	var/msg
	var/title
	var/root
	var/cd
	var/default_file
	var/ext
	var/filter
	var/saving

	var/bodyspec	// additional attributes in the <body> tag
	var/cssfile		// CSS file to use, if any; include classes .file and .fileconfirm
	var/size="320x320"


	New(callback_src, callback_proc)
		callsrc=callback_src
		callback=callback_proc

	proc/Create(client/C)
		owner = C
		C.fdlg = src
		if(callback) Display()

	proc/SendRscFiles()
		if(cssfile) owner << browse_rsc(cssfile)

	proc/PageHead()
		. = "<html>\n"
		if(cssfile || title)
			. += "<head>\n"
			if(cssfile) . += "<link rel=stylesheet href=\"[html_encode("[cssfile]")]\" />"
			if(title) . += "<title>[title]</title>\n"
			. += "</head>\n"
		. += "<body[bodyspec?" ":""][bodyspec]>\n"

	proc/PageFoot()
		. = "\n</body></html>"

	proc/PageLayout(filelist)
		. = "<div><table><tr><td>\n\
			<p>[html_encode(msg)]<br>The current date is: [time2text(world.realtime, "Month DD YYYY")]<br>The time is: [time2text(world.realtime, "hh:mm:ss")]</p>\n"
		. += ListFiles(filelist)
		. += "\n</td></tr></table></div></center>"

	proc/DisplayDir()
		. = "<b>[html_encode(cd)]</b>"

	proc/DisplayFile(F)
		if(F) . = "<a href=\"byond://?file=[url_encode(F)]\">[html_encode(F)]</a>"
		else . = "<form method=get action='byond://'><input type=submit value=\"New file\"/> <input type=edit name=file value=\"[default_file]\" /></form>"

	proc/ListFiles(list/filelist)
		if(cd) . = "<p class=file>[DisplayDir()]</p>\n"
		else . = ""
		. += "<p class=file>\n"
		for(var/i in 1 to filelist.len)
			if(i>1) . += "<br />\n"
			. += DisplayFile(filelist[i])
		. += "\n</p>"

	// returns true if F is a directory
	proc/IsDir(F)
		if(!istext(F)) F="[F]"
		if(!F) return
		if(text2ascii(F,length(F))==47) return 1

	proc/Display()
		if(!owner || owner.fdlg!=src) del(src)
		if(!istext(root)) root="[root]"
		if(!istext(cd)) cd="[cd]"
		if(!cd || length(cd)<length(root)) cd=root
		var/i,j,k,tj,tk,dirk
		// start where the default file is
		i=findtextEx(default_file,"/")
		if(i)
			do
				j=findtextEx(default_file,"/",i+1)
				if(j) i=j
			while(j)
			cd+=copytext(default_file,++i)
			default_file=copytext(default_file,i)
			i=findtextEx(default_file,"/")
		var/list/filelist=flist(cd)
		// change all filenames to text and delete empties
		for(i=1,i<=filelist.len,++i)
			if(!istext(filelist[i])) filelist[i]="[filelist[i]]"
			if(!filelist[i])
				filelist.Cut(i,i+1); --i; continue
			if(filter)
				j=length(filelist[i])
				if(text2ascii(filelist[i],j)==47) continue
				if(istext(filter))
					if(!findtext(filelist[i],filter,j-length(filter)+1))
						filelist.Cut(i,i+1); --i
				else
					var/fext
					for(fext in filter)
						if(findtext(filelist[i],fext,j-length(fext)+1)) break
					if(!fext)
						filelist.Cut(i,i+1); --i
		for(i=1,i<filelist.len,++i)
			k=i; tk=filelist[i]
			dirk=IsDir(tk)
			for(j=i+1,j<=filelist.len,++j)
				tj=filelist[j]
				if(IsDir(tj))
					if(!dirk || sorttext(tk,tj)<0)
						k=j; tk=tj
						dirk=1
				else if(!dirk && sorttext(tk,tj)<0)
					k=j; tk=tj
			if(k!=j) filelist.Swap(i,k)
		if(cd!=root) filelist.Insert(1,"../")
		if(saving) filelist+=null
		var/html=PageHead()+PageLayout(filelist)+PageFoot()
		SendRscFiles()
		owner << browse(html,"window=file;size=[size]")

	proc/PickFile(F,confirm)
		if(!istext(F)) F="[F]"
		if(!owner || owner.fdlg!=src) del(src)
		var/i=findtextEx(F,"/")
		while(i)
			if(findtextEx(F,"../")==1)
				if(cd!=root)
					var/j=length(cd)
					while(--j>0) if(text2ascii(cd,j)==47) break
					if(j>0) cd=copytext(cd,1,j+1)
					else cd=root
				F=copytext(F,4)
			else
				cd+=copytext(F,1,++i)
				F=copytext(F,i)
			if(!F) return Display()
			else i=findtextEx(F,"/")
		if(saving)
			for(i=length(F),i>0,--i)
				var/ch=text2ascii(F,i)
				if(ch==46) break		// . found; extension exists
				if(ch<48 || ch>122 || (ch>=58 && ch<65) || (ch>90 && ch<97))
					i=0
			if(i<=0) F+=ext
			if(fexists(cd+F))
				if(!confirm)
					var/html=PageHead()
					html+="\n<p>The file <span class=fileconfirm>[html_encode(F)]</span> \
						already exists. Do you really want to overwrite it?</p>\n\
						<p class=file>\
						<a href=\"byond://?file=[url_encode(F)]&confirm=yes\">Yes</a> \
						<a href=\"byond://?file=[url_encode(F)]&confirm=no\">No</a>\
						</p>\n</center>"
					html+=PageFoot()
					SendRscFiles()
					owner << browse(html,"window=file;size=[size]")
					return
				if(lowertext(confirm)!="yes")
					default_file=F
					return Display()
		else if(!fexists(cd+F))
			return Display()
		owner.fdlg=null
		owner << browse(null,"window=file")
		if(callsrc) call(callsrc,callback)(cd+F,saving)
		else call(callback)(cd+F,saving)
		del(src)
