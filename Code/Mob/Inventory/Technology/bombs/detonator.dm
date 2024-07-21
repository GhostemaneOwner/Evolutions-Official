
obj/items/Detonator
	icon='Cell Phone.dmi'
	desc="This can be used to activate the detonation sequence on bombs or missiles from up to 8 tiles away."
	verb/Set() Password=input("Set a password to activate bombs of matching passwords.") as text
	verb/Use()
		if(!Password)
			usr<<"You must set a password to activate bombs of the same password"
			return
		switch(input("Confirm detonation command:") in list("Yes","No"))
			if("Yes")
				view(usr)<<"[usr] activates their remote detonator"
				for(var/mob/player/M in view(usr))
					if(!M.client) return
					M.saveToLog("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] activates their remote detonator, bomb will detonate in 10 seconds.\n")
				var/list/Bombs=new
				for(var/obj/items/Bomb/A) if(A.z==usr.z&&A in range(8,usr)) Bombs+=A
				for(var/obj/B in Bombs)
					var/obj/items/Bomb/A=B
					if(src&&A.Password==Password&&!A.Bolted)
						if(!A.z) view(usr)<<"[src]: Command code denied for [A]."
						else
							view(usr)<<"[src]: Command code confirmed for [A]. It will detonate in 10 seconds."
							range(10,A)<<"<font color=red><font size=2>[A]: Detonation Code Confirmed. Detonation in 10 Seconds."
							for(var/mob/player/M in range(10,A))
								if(!M.client) return
								M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [A]: Detonation Code Confirmed. Detonation in 10 Seconds. Location: [A.x],[A.y],[A.z]\n")
							spawn(100) if(A) A.Remote_Detonation()
