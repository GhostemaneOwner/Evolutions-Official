/client/verb/Who()
	//set name = "Who"
	//set category = "Other"

	var/list/peeps = list()
	var/planet="??"

	for(var/mob/player/M in world)if(M.client)
		planet = (M.z == 0 ? "Login Screen" : M.z == 1 ? "Earth" : M.z == 2 ? "Namek" : M.z == 3 ? "Vegeta" : M.z == 4 ? "Ice" : M.z == 5 ? "Arconia" : \
		M.z==14&&M.x<=239&&M.y<=239 ? "Desert" : M.z==14&&M.x<=239&&M.y>=251 ? "Jungle" : M.z==14&&M.x>=251&&M.y<=240 ? "Alien" : M.z==8 ? "Afterlife" \
		: M.z==18 ? "Hell" : M.z==11 ? "Checkpoint" : M.z==6 ? "Dark Planet" : M.z==10 ? "Majin Absorb Area/Heaven" : M.z==17 ? "Ships/Magic Realms" : M.z==7 ? "Space Station" : M.z==9 ? "Final Realms/Tower/HBTC" : \
		M.z==9&&M.x<=150&&M.y>=350 ? "Android Ship" :  M.z==15? "Moons" : "??")
		if(usr.client.holder)
			peeps += {"\t<tr><td><font color=[M.TextColorOOC]>[M.key]</td>
						<td><font color=[M.TextColor]>[M.name]</td>
						<td>[M.Race ? M.Race : "/"]</td>
						<td>[planet]</td>
						<td>[M.RPs]</center></td>
						<td>[M.TotalXP]</center></td>
						<td>[M.XP]</center></td>
						<td>[Year-M.LastEmoteAudit>4?"Needs Audit!":"Year [M.LastEmoteAudit]"]</center></td>
						<td align=center><A HREF='?src=\ref[src.holder];adminplayeropts=\ref[M]'>X</A> |
						<A HREF='?src=\ref[src.holder];observe=\ref[M]'>Watch</A></td>
						</tr>"}
		else peeps += "\t<td><font color=[M.TextColorOOC]>[M.client]</td></tr>"
	peeps = sortList(peeps)
	var/dat
	dat += {"<body style="background-color:#212121" text="#80d8FF"><font size=6>Player Listing</font><hr><br>"}
	dat += "<font color=#80d8FF><br><b>Total Players: [length(peeps)]</b><br><br>"
	if(usr.client.holder) dat += "<font color=#80d8FF><table border=1 cellspacing=5><B><tr><th>Key</th><th>Name</th><th>Race</th><th>Planet</th><th>Total RP Count</th><th>Total XP</th><th>XP</th><th>Last Emote Audit</th><th>Admin Options</th></tr></B>"
	else dat += "<font color=#80d8FF><table border=1 cellspacing=5><B><tr><th>Key</th></tr></B>"
	for (var/p in peeps) dat += "[p]"
	dat += "<font color=#80d8FF></table><br><b>Total Players: [length(peeps)]</b></body>"
	usr << browse(dat,"window=playerlist;size=920x800")
mob/var/LastEmoteAudit=0
/client/verb/adminwho()
	//set category = "Other"
	set name = "Admins"
	usr << "<b>Current Admins:</b>"
	for(var/mob/player/M in world)if(M && M.client && M.client.holder) if(!M.afk) usr << "[M.key] is a [M.client.holder.rank]"
