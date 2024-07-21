
mob/proc/getPortrait() return {"
						<html>
						<body style="background-color:#F3EADB;">
						<img src="[ImageLink]" width="192" height="266"> </center>
						</body>
						</html>
						"}

mob/verb/Check_Profile(mob/M in view(usr,10))
	set category=null
	set popup_menu = 0
	for(var/obj/items/Disguise/A in M) if(A.suffix)
		usr<<"You can not see past their disguise."
		return
	if(M.FakeProfile) src << browse(M.FakeProfile[1],"window=character_profile;size=700x600")
	else if(!M.UsingCustom)
		winshow(usr.client,"CharacterProfile",1)
		winset(src.client,"cname","text=\"[M.name]\"")
		var/properAge = "Infant"
		if(M.Age>1) properAge="Young"
		if(M.Age==M.InclineAge||M.Age>M.InclineAge) properAge="Prime"
		if(M.Decline-M.Age<10) properAge="Mature"
		if(M.Decline-M.Age<3) properAge="Old"
		if(M.Age>M.Decline) properAge="Elderly"


		if(M.FakeAge)winset(src.client,"cage","text=\"[M.FakeAge]\"")
		else winset(src.client,"cage","text=\"[properAge]\"")

		if(M.FakeGender) winset(src.client,"cgender","text=\"[M.FakeGender]\"")
		else if(M.ShowGender) winset(src.client,"cgender","text=\"[uppertext(M.gender)]\"")
		else winset(src.client,"cgender","text=\"???\"")


	//	if(M.ShowSize) winset(src.client,"cbody","text=\"[M.Size]\"")
	//	else winset(src.client,"cbody","text=\"[M.Size]\"")


		if(M.FakeHeight) winset(src.client,"cheight","text=\"[M.FakeHeight] inches\"")
		else winset(src.client,"cheight","text=\"[M.Height] inches\"")
		if(M.FakeWeight) winset(src.client,"cweight","text=\"[M.FakeWeight] lbs\"")
		else winset(src.client,"cweight","text=\"[M.BodyWeight] lbs\"")
		if(M.FakeBackstory) winset(src.client,"cbackstory","text=\"[M.FakeBackstory]\"")
		else winset(src.client,"cbackstory","text=\"[M.Backstory]\"")
		if(M.FakePortrait) src << output(M.FakePortrait, "cportrait")
		else src << output(M.Portrait, "cportrait")
	else
		if(!M.CustomProfile)
			src << browse(M.DefaultProfile[1],"window=character_profile;size=700x600")
		else
			src << browse(M.CustomProfile[1],"window=character_profile;size=700x600")

mob/verb/Profile_Options()
	var/PP=input("Change what option?","Profile Options") in list("Custom HTML","Cancel")
	switch(PP)
		if("Description") Backstory()
		if("Height") ChangeHeight()
		if("Weight") ChangeWeight()
		if("Portrait") ChangeImage()
		if("Toggle Gender")
			ShowGender=!ShowGender
			usr<<"Show Gender [ShowGender]"
		if("Custom HTML") CustomHTML()

mob/var
	ShowRace=0
	ShowGender=0
	FakeAge
	FakeGender
	FakePortrait
	FakeBackstory
	FakeHeight
	FakeWeight
	FakeProfile
	UsingCustom=0
	EditingHTML=0
	CustomProfile
	DefaultProfile=list({"<head><title>Character Profile</title></head>
<body>
<body background="https://bit.ly/3PzsgtC" text="#FFFFFF" style="background-position:top; background-repeat">
<table align="center" cellpadding="0" border="0" cellspacing="0">
  <tr>
    <td>
      <table align="center" cellspacing="5" cellpadding="0" bgcolor="#111">
        <tr>
          <td bgcolor="#333" width="375" height="375" border="0" background="https://bit.ly/44p3xMQ" style="background-no-repeat">
            <div style="margin-top:375px;background:#111;padding:0px;font-family:constantia;letter-spacing:-3px;text-transform:uppercase;font-size:28px;color:#777;text-align:center;">
              <font color="white">Your Name</font>
              <div style="margin-top:-5px;font-family:constantia;letter-spacing:2px;text-transform:uppercase;font-size:12px;color:#55565F;">
                Your Title
              </div>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<td></td>
<td>
  <table align="center" cellpadding="2" border="0" cellspacing="0" bgcolor="white">
    <tr>
      <td>
        <table align="left">
          <table align="left" cellspacing="3" cellpadding="0">
            <tr>
              <td align="top" bgcolor="#000000" height="276" width="550" border="0">
                <div style="padding:float:left;6px;font-family:constantia;letter-spacing:-10px;font-size:20px;color:black;margin-bottom:0px;"></div>
                <div style="padding:3px;background:#000000;width:93%;margin:0 auto;"></div>
                <div style="padding-left:5px;padding-right:5px;line-height:175%;font-family:constantia;color:black>;font-size:11px;">
                  <div style="border-bottom:1px solid #000000"><b>
                      <font color="#FCF52D">
                        <font color="#FFFFFF">
                          <div style="border-bottom:1px solid#FFFFFF;text-align:right"><b>Info</b></div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Age:</font></b> Your Age</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Alignment:</font></b> Your Alignment</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Build:</font></b> Your Build</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Height:</font></b> Your Height</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Hair Color:</font></b> Your Hair Color</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Eye Color:</font></b> Your Eye Color</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Gender:</font></b> Your Gender</div>
						  <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Race:</font></b> Your Race</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Blood Type:</font></b> Your Blood Type</div>
                          <div style="border-bottom:1px solid #FFFFFF"><b><font color="Silver">Occupation:</font></b> Your Occupation</div>
                          <div style="border-bottom:4px solid #FFFFFF"><b><font color="Silver">Alias:</font></b> Your Alias</div>
                          <div style="border-bottom:4px solid #FFFFFF"><b><font color="Silver">Notable Features:</font></b> <br> - Your Notable Features</div>
                          <iframe width="0" height="0" src="Link to your song here(use picosong.com)"></iframe>
                        </font>
                      </font>
                    </b>
                  </div>
                </div>
              </td>
            </tr>
          </table>
        </table>
      </td>
    </tr>
  </table>
</td>
</body>"})

mob/verb
	CustomHTML()
		set hidden = 1
		if(usr.EditingHTML==0)
			if(usr.UsingCustom==0)
				usr << "You will now use Custom HTML for your Character Profile."
				usr.UsingCustom=1
			usr.EditingHTML=1
			if(!usr.CustomProfile)
				usr.CustomProfile= list(input("Write your Custom HTML (head and title required)","Character Profile",DefaultProfile[1]) as message)
			else
				usr.CustomProfile[1]= input("Write your Custom HTML (head and title required)","Character Profile",CustomProfile[1]) as message
			usr.EditingHTML=0

			// Parse the HTML code for the head tags
			var headStart = findtext(usr.CustomProfile[1], "<head>") + 6
			var headEnd = findtext(usr.CustomProfile[1], "</head>")

			// Check if the head tag is empty or contains only whitespace
			if(headStart > 6 && headEnd > headStart)
				var headContent = copytext(usr.CustomProfile[1], headStart, headEnd)
				if(text2ascii(headContent, 1) == 32 || text2ascii(headContent, 1) == 10)
					usr << "You left the head tag blank, it was replaced with the default."
					usr.CustomProfile[1] = replacetext(usr.CustomProfile[1], headContent, "<title>Character Profile</title>", headStart, headEnd)
					return

				// Parse the HTML code for the title tags
				var titleStart = findtext(usr.CustomProfile[1], "<title>") + 7
				var titleEnd = findtext(usr.CustomProfile[1], "</title>")

				// Check if the title tag is empty
				if(titleStart > 7 && titleEnd > titleStart)
					var titleContent = copytext(usr.CustomProfile[1], titleStart, titleEnd)
					// Check if the contents of the tag contains whitespace
					if(text2ascii(titleContent, 1) == 32 || text2ascii(titleContent, 1) == 10)
						usr << "You left the title tag blank, it was replaced with the default."
						usr.CustomProfile[1] = replacetext(usr.CustomProfile[1], titleContent, "Character Profile", titleStart, titleEnd)
						return

				// If there's no space between the two tags
				else if(titleStart == titleEnd)
					usr << "You left the title tag blank, it was replaced with the default."
					usr.CustomProfile[1] = replacetext(usr.CustomProfile[1], "", "Character Profile", titleStart, titleEnd)
					return
				else
					usr << "You're missing the title tag, it was replaced with the default."
					usr.CustomProfile[1] = replacetext(usr.CustomProfile[1], headContent, "<title>Character Profile</title>", headStart, headEnd)
					return

			// If there's no space between the two tags
			else if(headStart == headEnd)
				usr << "You left the head tag blank, it was replaced with the default."
				usr.CustomProfile[1] = replacetext(usr.CustomProfile[1], "", "<title>Character Profile</title>", headStart, headEnd)
				return
			else
				usr << "You're missing the head tag, your character profile was replaced with the default."
				usr.CustomProfile[1] = usr.DefaultProfile[1]
				return
		else
			usr << "You're already editing your Character Profile!"
			return

	Backstory()
		set instant = 1
		if(usr.UsingCustom==1)
			usr.UsingCustom=0
			usr << "You're no longer using Custom HTML for your Character Profile."
		if((winget(client,"Backstory","is-visible")=="true"))
			winshow(client,"Backstory",0)
			return
		winshow(client,"Backstory",1)
		winset(client, "Backstory.emoteinput", "focus=true")


	BackstoryS()
		set hidden = 1
		var/msg=winget(usr, "Backstory.emoteinput", "text")
		msg = copytext(sanitize_n(msg), 1, MAX_PROFILE_LEN)
		usr.Backstory=("[msg]")
		winshow(client,"Backstory",0)
		winset(usr.client, "Backstory.emoteinput", "text=")

	ChangeHeight()
		set hidden=1
		if(usr.UsingCustom==1)
			usr.UsingCustom=0
			usr << "You're no longer using Custom HTML for your Character Profile."
		usr.Height = input("Please select your height (in inches). This will output in your profile") as num

	ChangeWeight()
		set hidden=1
		if(usr.UsingCustom==1)
			usr.UsingCustom=0
			usr << "You're no longer using Custom HTML for your Character Profile."
		usr.BodyWeight = input("Please select your weight (in pounds). This will output in your profile") as num

	ChangeImage()
		set hidden=1
		if(usr.UsingCustom==1)
			usr.UsingCustom=0
			usr << "You're no longer using Custom HTML for your Character Profile."
		usr.ImageLink = input("Please input a link to the image you would like to use for your profile.  Image will be sized to fit width=165 and height=250") as text
//		getPortrait()
		usr.Portrait= {"
						<html>
						<body style="background-color:#C6D5D7;">
						<img src="[ImageLink]"width="165" height="250"></center>
						</body>
						</html>
						"}
						