

mob/var/tmp/TechWindowOpen
mob/var/tmp/MagicWindowOpen

mob/verb/CreateWindow()
	if(!HasCreated)
		usr<<"You must create a character first."
		return
	if(!TechWindowOpen)
		Grid("Create")
		TechWindowOpen=1
	else
		TechWindowOpen=0
		winshow(client,"Grid",0)

mob/verb/refreshTechWindow()
	set name = ".techrefresh"
	if(!HasCreated)
		usr<<"You must create a character first."
		return
	if(!TechWindowOpen)
		Grid("Tech")
		TechWindowOpen=1
	else
		TechWindowOpen=0
		winshow(client,"Grid",0)
mob/verb/refreshMagicWindow()
	set name = ".magicrefresh"
	if(!HasCreated)
		usr<<"You must create a character first."
		return
	if(!MagicWindowOpen)
		Grid("Magic")
		MagicWindowOpen=1
	else
		MagicWindowOpen=0
		winshow(client,"Grid",0)
		