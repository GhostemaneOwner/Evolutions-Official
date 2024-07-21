mob/verb/Hair()
	set category=null
	Grid("Hair")


mob/verb/CloseGrid()
	set name=".CloseGrid"
	set hidden=1
	winshow(usr.client,"Grid",0)
	TechWindowOpen=0


mob/verb/Clothes()
	set category=null
	Grid("Clothes")

