

#define LOWER_ASCII_MIN 97
#define LOWER_ASCII_MAX 122
#define UPPER_ASCII_MIN 65
#define UPPER_ASCII_MAX 90
#define NUMBER_ASCII_MIN 60
#define NUMBER_ASCII_MAX 71
#define IN_BOUNDS( X, A, B ) ( X >= A && X <= B )
#define IS_LOWERCASE(X) IN_BOUNDS( X, LOWER_ASCII_MIN, LOWER_ASCII_MAX )
#define IS_UPPERCASE(X) IN_BOUNDS( X, UPPER_ASCII_MIN, UPPER_ASCII_MAX )
#define IS_NUMBER(X) IN_BOUNDS( X, NUMBER_ASCII_MIN, NUMBER_ASCII_MAX )
proc/CheckText(var/T, var/pos)
	var/txt = lowertext(T)
	var/Choose = rand(1,3)
	if(txt == "a")
		if(Choose == 1) txt = "e"
		if(Choose == 2) txt = "i"
		if(Choose == 3) txt = "c"
	if(txt == "b")
		Choose = rand(1,3)
		if(Choose == 1) txt = "d"
		if(Choose == 2) txt = "p"
		if(Choose == 3) txt = "p"
	if(txt == "c")
		Choose = rand(1,3)
		if(Choose == 1) txt = "e"
		if(Choose == 2) txt = "s"
		if(Choose == 3) txt = "k"
	if(txt == "d")
		Choose = rand(1,3)
		if(Choose == 1) txt = "e"
		if(Choose == 2) txt = "b"
		if(Choose == 3) txt = "g"
	if(txt == "e")
		Choose = rand(1,3)
		if(Choose == 1) txt = "a"
		if(Choose == 2) txt = "t"
		if(Choose == 3) txt = "i"
	if(txt == "f")
		Choose = rand(1,3)
		if(Choose == 1) txt = "s"
		if(Choose == 2) txt = "r"
		if(Choose == 3) txt = "m"
	if(txt == "g")
		Choose = rand(1,3)
		if(Choose == 1) txt = "d"
		if(Choose == 2) txt = "e"
		if(Choose == 3) txt = "d"
	if(txt == "h")
		Choose = rand(1,3)
		if(Choose == 1) txt = "f"
		if(Choose == 2) txt = "a"
		if(Choose == 3) txt = "n"
	if(txt == "i")
		Choose = rand(1,3)
		if(Choose == 1) txt = "y"
		if(Choose == 2) txt = "u"
		if(Choose == 3) txt = "h"
	if(txt == "j")
		Choose = rand(1,3)
		if(Choose == 1) txt = "p"
		if(Choose == 2) txt = "g"
		if(Choose == 3) txt = "i"
	if(txt == "k")
		Choose = rand(1,3)
		if(Choose == 1) txt = "d"
		if(Choose == 2) txt = "v"
		if(Choose == 3) txt = "c"
	if(txt == "l")
		Choose = rand(1,3)
		if(Choose == 1) txt = "i"
		if(Choose == 2) txt = "u"
		if(Choose == 3) txt = "j"
	if(txt == "m")
		Choose = rand(1,3)
		if(Choose == 1) txt = "n"
		if(Choose == 2) txt = "h"
		if(Choose == 3) txt = "q"
	if(txt == "n")
		Choose = rand(1,3)
		if(Choose == 1) txt = "h"
		if(Choose == 2) txt = "m"
		if(Choose == 3) txt = "q"
	if(txt == "o")
		Choose = rand(1,3)
		if(Choose == 1) txt = "u"
		if(Choose == 2) txt = "s"
		if(Choose == 3) txt = "i"
	if(txt == "p")
		Choose = rand(1,3)
		if(Choose == 1) txt = "d"
		if(Choose == 2) txt = "b"
		if(Choose == 3) txt = "p"
	if(txt == "q")
		Choose = rand(1,3)
		if(Choose == 1) txt = "e"
		if(Choose == 2) txt = "i"
		if(Choose == 3) txt = "c"
	if(txt == "r")
		Choose = rand(1,3)
		if(Choose == 1) txt = "w"
		if(Choose == 2) txt = "a"
		if(Choose == 3) txt = "b"
	if(txt == "s")
		Choose = rand(1,3)
		if(Choose == 1) txt = "h"
		if(Choose == 2) txt = "c"
		if(Choose == 3) txt = "e"
	if(txt == "t")
		Choose = rand(1,3)
		if(Choose == 1) txt = "e"
		if(Choose == 2) txt = "u"
		if(Choose == 3) txt = "w"
	if(txt == "u")
		Choose = rand(1,3)
		if(Choose == 1) txt = "o"
		if(Choose == 2) txt = "e"
		if(Choose == 3) txt = "y"
	if(txt == "v")
		Choose = rand(1,3)
		if(Choose == 1) txt = "w"
		if(Choose == 2) txt = "a"
		if(Choose == 3) txt = "m"
	if(txt == "w")
		Choose = rand(1,3)
		if(Choose == 1) txt = "m"
		if(Choose == 2) txt = "w"
		if(Choose == 3) txt = "h"
	if(txt == "x")
		Choose = rand(1,3)
		if(Choose == 1) txt = "s"
		if(Choose == 2) txt = "e"
		if(Choose == 3) txt = "c"
	if(txt == "y")
		Choose = rand(1,3)
		if(Choose == 1) txt = "i"
		if(Choose == 2) txt = "r"
		if(Choose == 3) txt = "u"
	if(txt == "z")
		Choose = rand(1,3)
		if(Choose == 1) txt = "s"
		if(Choose == 2) txt = "g"
		if(Choose == 3) txt = "b"
	if(pos == 1) txt = uppertext(txt)
	return txt

proc/Language_Shift( w, p)
	var/NewText = null
	var/Text = null
	var/TextLength = length(w)
	while(TextLength >= 1)
		Text ="[copytext(w,(length(w)-TextLength)+1,(length(w)-TextLength)+2)]"
		var/Change = 0
		Change = prob(100 - p)
		if(Change)
			NewText+="[CheckText(Text,TextLength)]"
		if(Change == 0)
			NewText+="[copytext(w,(length(w)-TextLength)+1,(length(w)-TextLength)+2)]"
		TextLength--
	return NewText

mob/var/Language/lan
mob/var/TeachLangCD=-1

Language
	parent_type=/obj
	var
		Mastery=1
		LearnType
		Teach=1
		Difficulty=1
		ID=0
	Saiyan
		Difficulty=1
	English
		Difficulty=1.5
	Namekian
		Difficulty=3
	Demonic
		Difficulty=5
	Tuffle
		Difficulty=3
	Old_Tongue
		Difficulty=10
	Kaio
		Difficulty=5
	Yardrat
		Difficulty=4
	Arconian
		Difficulty=2
	Heran
		Difficulty=1.5
	Kanassan
		Difficulty=3
	Common
		Difficulty=1.5
	Changeling
		Difficulty=3
	Machine
		Difficulty=10000
	CustomLanguage
		Difficulty=10
	BabyTalk
		Difficulty=10000000000
	Click()
		..()
		if(src in usr) usr.lan=src
		usr<<"You change your spoken language to [src]."
	New(percent = 100,mob/B)
		//if(!B) return
		if(istype(src,/Language/CustomLanguage)&&!ID) ID=rand(1,100000)
		LearnType=src.type
		Mastery=percent
		//owner=B
		if(B) if(ismob(B))
			if(!B.lan) B.lan=src
			for(var/Language/L in B) if(L.name==src) del(src)//No doubles
	//	..()

	verb/Teach()
		set category="Other"
		if(istype(src,/Language/BabyTalk)) return
		if(usr.TeachLangCD+1>WipeDay)
			usr<<"This is still on cool down (Day [usr.TeachLangCD+1])."
			return
		var/list/Targs=list()
		for(var/mob/T in oview(5,usr)) Targs+=T
		Targs+="Cancel"
		var/mob/targ=input(usr,"Teach [src] to whom?") in Targs
		if(targ!="Cancel")
			usr<<"You teach [targ] some [src]."
			targ<<"[usr] teaches you some [src]."
			targ.improve_language(src, 50)
			usr.TeachLangCD=WipeDay

	verb/Change_Language()
		set hidden=1
		usr.lan=src
		usr<<"Your spoken language is [usr.lan]."

mob/proc/improve_language(Language/l, percent as num)
	if(!src) return
	if(istype(l,/Language/BabyTalk)) return
	if(ismob(src))
		if(!percent) percent = 10
		var/found=0
		if(istype(l,/Language/CustomLanguage))
			for(var/Language/L in src) if(L.ID==l.ID||L.name==l.name)
				found=1
				if(L.Mastery+percent <=100)
					L.Mastery += percent/l.Difficulty
					if(src.Race=="Android") L.Mastery += (percent/l.Difficulty)*4
				else L.Mastery=100
		else
			for(var/Language/L in src) if(L.type==l.LearnType)
				found=1
				if(L.Mastery+percent <=100)
					L.Mastery += percent/l.Difficulty
					if(src.Race=="Android") L.Mastery += (percent/l.Difficulty)*4
				else L.Mastery=100
			/*for(var/Activity/A in src) if(A.Subtype=="Language")
				if(!A.TT) A.TT=L.name
				if(L.name==A.TT) A.CheckProgress(L.Mastery,L.name,src)*/
		if(!found)
			src<<"You're beginning to understand a new language!"
			if(istype(l,/Language/CustomLanguage))
				var/Language/CustomLanguage/CL=new
				CL.name=l.name
				CL.ID=l.ID
				CL.Mastery=5
				src.contents+=CL
			else src.contents+=new l.LearnType(5,src)
			//src.contents+=new l(2,src)


mob/proc/LanguageSay(msg as text,Language/language,skill as num,mob/M as mob)
	ASSERT(language)
	ASSERT(skill)
	var/Understanding=0
	if(findtext(msg,name))if(M!=src) M.MakeContact(src,1)
	if(M!=src) M.improve_language(language,length(msg)/120*Int_Mod)
	//if(TicksOfMerriment)skill-=(TicksOfMerriment/80)
	if(!prob(skill)) msg = Language_Shift(msg,skill)
	//if(istype(language,/Language/BabyTalk)) Understanding=0
	for(var/Language/L in M) if(istype(L,language)) Understanding=L.Mastery
	for(var/obj/items/Translator/T in src) if(!istype(language,/Language/BabyTalk)) Understanding=100
	for(var/obj/items/Stone_Of_Understanding/SOU in M) if(!istype(language,/Language/BabyTalk)) Understanding=100
	if(M.AdminMode) Understanding=100
	msg = Language_Shift(msg,Understanding)
	//usr<<"Speaker skill [skill] Listener skill [Understanding]"
	return msg
