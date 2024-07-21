Team/
	var
		openJoining=0											//Allows for a team to allow people near
																//The members of the team to join freely,
																//Given you have room
		maxMembers=5											//Allows for parties to have limits on
																//The amount of players can join a team
																//At any given time
	var/tmp/list/
		Members=new()											//Allows for easy tracking of members who
																//Have joined the team, order of the team
																//Defining leadership([1] being leader)
	proc

		AddMember(mob/M)										//When adding a mob into the team;
			if(src.Members.len>=src.maxMembers){ return FALSE }	//Check if the team is full or not,
			if(M in src.Members){ return TRUE }					//Make sure the player cannot join twice
			if(M.Team.Members.len)								//Then make sure the mob isn't already in a team
				var/list/members=M.Team.Members
				switch(input(M,"You're currently in [M==members[1] ? "your own" : "[members[1]]'s"] team, are you sure you want to join [src.Members[1]]'s team?","Join Team")in list("Yes","No"))
				 												//If they are, give them the option to leave their
				 												//Current team and join the new(this) one.
					if("Yes")
						if(src.Members.len>=src.maxMembers)		//Check to make sure the player can still join.
							M<<"Team is full."
							return FALSE
						M.Team.RemoveMember(M)					//Remove the player from the old team.

					if("No")
						return FALSE

			src.Members<<"[M] has joined the team!"
			src.Members.Add(M)									//Then add them to the new team
			M.Team=src
			M.verbs+=/mob/verb/Leave_Team						//Allow the players who join, the chance to leave
			M.TakeTeamLeader()									//Make sure the players joining don't have Team Leader verbs
			if(src.openJoining)									//If the team is openly allowing members
				M.verbs+=/mob/verb/Join_Team					//Allow players near the new member to join
			return TRUE

		RemoveMember(mob/M)										//When a mob leaves a team
			if(Members[1]==M&&Members.len>1)					//Check if the mob is the leader of a active team
				var/mob/m2=Members[2]							//Assign the mob in the second position leadership role
				Members<<"[M] has left the team, [m2] has taken command!"
				Members.Remove(m2)
				Members.Insert(1,m2)
				m2.MakeTeamLeader()							//I like chicken.
			else
				Members<<"[M] has left the team."
			M.TakeTeamLeader()
			Members.Remove(M)
			if(Members.len)
				M.Team=new()
				M.Team.AddMember(M)						//If player leaves a active team,
																//Make sure they don't 'ghost' the team.

		Invite(mob/M)											//When Inviting a mob to join
			if(M in src.Members){ return TRUE }
			switch(input(M,"You have been invited to join [src.Members[1]]'s team, do you accept?","Team Invite")in list("Yes","No"))
				if("Yes")										//Allow them to decline
					spawn() src.AddMember(M)					//Then, if accepted, add them to the team
					return TRUE
				/*if("Decline")
					return FALSE*/
			return FALSE


mob

	Login()
		..()
		verbs-=/mob/verb/Join_Team								//Ensure players who join
		verbs-=/mob/verb/Leave_Team							//Don't have these un-needed verb
		src.Team.AddMember(src)

	Logout()													//When the player leaves
		if(src.Team.Members.len)								//If they have a team
			src.Team.RemoveMember(src)							//Remove them from the team
		..()													//Continue logging the player out

	var

		teaminvite = 1											//Allow the players to toggle invites
		tmp/Team/Team=new()									//Keep track of the player's team.
																//Without saving the team when they leave

	verb

		Start_Team()											//When starting a team
			set category="Team"
			if(src.Team.Members[1]==usr)
				usr<<"You are already the leader of your own team."
				src.verbs-=typesof(/mob/TeamLeader/verb/)
				src.verbs+=typesof(/mob/TeamLeader/verb/)
				return
			if(src.Team.Members.len)							//check if the player is in a team
				switch(input(src,"Are you sure you want to leave [src.Team.Members[1]]'s team?","Leave Team") in list("Yes","No"))
																//Ask the player if they want to leave the team
					if("Yes")									//If they do, remove their old team.
						src.Team.RemoveMember(src)
						/*src.Team=new()
						src.Team.AddMember(src)*/
					if("No")									//Otherwise, stop them from creating it
						return
			src.Team=new()
			src.Team.AddMember(src)							//Now, add them to the 'new' team
			src.MakeTeamLeader()								//And give them leadership verbs

		View_Team()
			set category="Team"
			if(!src.Team)
				usr<<"You are not in a team."
				return											//When a mob wants to leave said team.
			usr<<"Members: ([src.Team.Members.len]) [src.Team.Members.Join(", ")]"
		Leave_Team()
			set category="Team"
			if(!src.Team)
				usr<<"You are not in a team."
				return											//When a mob wants to leave said team.
			switch(input(src,"Are you sure you want to leave [src.Team.Members[1]]'s team?","Leave Team") in list("Yes","No"))
																//Ask the player if they want to leave the team
				if("Yes")										//If they do, remove their old team.
					src.Team.RemoveMember(src)
					src.Team=new()
					src.Team.AddMember(src)

		Join_Team()											//When in view of a open team
			set category="Team"
			set src in oview()
			if(!src.Team.openJoining)
				usr<<"Their team is not open for joining."
				return
			if(src.Team!=usr.Team&&!src.Team.AddMember(usr))	//Allow players to attempt to join
				usr<<"You were unable to join [src]'s team."

		ToggleTeamInvites()
			src.teaminvite=!src.teaminvite					//Toggle the invites on and off
			src<<"[src.teaminvite ? "You are now accepting team invites" : "You are no longer accepting team invites."]"

	TeamLeader													//Seperate set of verb types for the mob
		verb													//For when the mob is a team leader

			Team_Invite()
				set category="Team"
				var/list/l=new()								//Create a list
				for(var/mob/player/m in oview(usr))			//Search for all mobs outside of the player
																//This can be changed to a player-specific container or view()
					if(m.teaminvite&&m.Team!=src.Team)		//If they're available for invites
						l+=m									//Add them to the list
				if(l.len) src.Team.Invite(input(src,"Please, select someone to invite to your team.","Team Invite")as mob in l)
																//Allow the player to select from a list of players
																//Whom are eligable. This method defaults when only
																//One choice is available, so you may wish to add a check here
			ChangeOpenJoin()									//Allow or disallow open joining of players
				set category="Team"
				set name = "Open/Close Team"
				src.Team.openJoining=!src.Team.openJoining	//Switch your team's status
				view(usr,10)<<"[src]'s team is [src.Team.openJoining ? "now" : "no longer"] openly accepting members!"
			ChangeTeamLeader()									//Manually select a new team leader
				set category="Team"
				set name = "Transfer Team Leader"
				var/list/members=Team.Members
				if(members.len>1)								//Check to ensure there's someone to select
					var/mob/m = input(src,"Select whom you would like to make your team leader.","Transfer Leadership")as null|mob in members-src
					if(m)										//Allow players to cancel their selection
						members.Remove(m)						//Then remove and insert
						members.Insert(1,m)						//The selected player as leader
						src.TakeTeamLeader()
						m.MakeTeamLeader()
			Kick_Player()
				set category="Team"
				set name = "Remove Team Member"
				var/mob/m = input(src,"Select whom you would like to kick out of the team.","Remove Team Member")as null|mob in src.Team.Members-src
				if(m)											//Allow players to cancel their selection
					src.Team.RemoveMember(m)					//Remove the selected player from the team.

	proc

		MakeTeamLeader()										//When becoming a team leader
			src.verbs+=typesof(/mob/TeamLeader/verb/)			//Give players leadership verbs
//			src.verbs-=/mob/verb/StartTeam						//Disallow leaders from creating a new team
		TakeTeamLeader()										//When losing a team leadership
			src.verbs-=typesof(/mob/TeamLeader/verb/)			//Take leadership verbs
//			src.verbs+=/mob/verb/StartTeam						//Then allow them to create a new team
