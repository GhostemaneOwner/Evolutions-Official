/obj
	Rank
		Click()
			if(!usr.client.holder)
				alert("You cannot perform this action. You must be of a higher administrative rank!")
				return
			if(alert("Delete this rank entry?",,"Yes","No") == "No")
				return
			log_admin({"[key_name(usr)] deleted a rank entry for [src]."})
			alertAdmins("[key_name(usr)] deleted a rank entry for [src].", 1)
			del(src)
obj/Rank
	var
		Rank_Key = null
		Rank_Name = null
		Rank_Player_Name = null
		Rank_Online = null
		Rank_Activity = null
		Rank_AFK = 0
		Rank_AFK_Total = 0
		Rank_RP = 0
//		Rank_Emotes = 0

mob
	proc
		CreateRank(var/Rank)
			var/obj/Rank/R = new
			R.Rank_Key = src.key
			R.Rank_Online = "Yes"
			R.Rank_Player_Name = src.name
			if(src.icon)
				var/icon/A=new(src.icon)
				R.icon = A
			for(var/icon/X in src.overlays) if(X.icon)
				var/icon/A2=new(X.icon)
				R.overlays += A2
			if(src.hair)
				R.overlays += src.hair
			R.Rank_Name = "[Rank]"
			R.name = "[Rank]"

proc
	UpdateRankings()
		set waitfor=0
		set background=1
		for(var/obj/Rank/R in Rankings)
			if(R.Rank_Key)
				var/mob/M = null
				for(var/mob/X in Players)
					if(X.key == R.Rank_Key)
						M = X
				if(M)
					var/N = 0
					if(M.afk)
						N = M.client.inactivity
						N = N / 10
					R.Rank_Online = "Yes"
					R.Rank_Player_Name = M.name
					R.Rank_Activity = "[time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]"
					R.Rank_AFK = N
					R.Rank_RP = M.RPs
				else
					R.Rank_Online = "No"
		sleep(3000)
		UpdateRankings()