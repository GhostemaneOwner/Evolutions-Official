/*
 * _techmain.dm
 *
 * populate a global list at the start of the world with every dummy tech object we have.
 * these dummy objects will create the actual object once clicked.
*/
#define TECH_GRID "grid_Tech"
#define MAGIC_GRID "grid_Magic"
#define TECHWINDOW "windowTech"
#define childtypes(type) typesof(type) - type
var/list/globTechlist = new
var/list/globMagiclist = new
var/GlobalResourceRate=2500000

// Global resource replenish proc
proc/Resources()
	for(var/area/A in world) if(A.type!=/area) if(A.type!=/area/Inside&&A.type!=/area/UndergroundMine) A.Value+=GlobalResourceRate*A.ResourceRate
proc/Mana()
	for(var/area/A in world) if(A.type!=/area) if(A.type!=/area/Inside&&A.type!=/area/UndergroundMine) A.Value_Mana+=GlobalResourceRate*A.ManaRate

proc/fill_techlist()
/*
 * fill_techlist()
 *
 * a simple for loop that adds all dummy objects to the global tech list
 * sleep is disabled because the loop is rather small, so there's no need to force it to the background.
*/
	for(var/A in childtypes(/obj/Technology))
		var/obj/Technology/B = new A
		if(B.Cost == 0) continue // If it has no cost, then the item is disabled. So skip.
		globTechlist+=B
	for(var/A in childtypes(/obj/Magic))
		var/obj/Magic/B = new A
		if(B.Cost == 0) continue // If it has no cost, then the item is disabled. So skip.
		globMagiclist+=B

