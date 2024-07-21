mob/var/Fused
mob/var/Fusing

mob/proc/Potara_Revert(mob/T)
	src.Base -= T.Base / 2
	src.MaxKi -= T.MaxKi / 2
	src.Ki = src.MaxKi
	src.KiMod -= T.KiMod / 2
	src.BPMod -= T.BPMod / 2
	src.StrMod -= T.StrMod / 2
	src.EndMod -= T.EndMod / 2
	src.SpdMod -= T.SpdMod / 2
	src.OffMod -= T.OffMod / 2
	src.DefMod -= T.DefMod / 2
	src.BaseRegeneration -= T.BaseRegeneration / 2
	src.BaseRecovery -= T.BaseRecovery / 2
	view(src) << "Time ran out, [T] has defused from [src]!"
	src.Fused = 0
	T.Fused = 0
	if(src.Dead)
		T.Death("dying while fused")
	T.loc = locate(src.x, src.y, src.z)
	T.Get_Observe(T)

obj
	Potara_Earrings
		desc="You can use these to fuse with another person regardless of race. This fusion is only permanent for Shinjin, and will last for a short time for others."
		verb/Fuse()
			set category="Skills"
			set name="Potara Fusion"
			if(usr.icon_state=="KO") return
			for(var/mob/A in get_step(usr,usr.dir)) if(A.client)
				if(usr.Fusing || A.Fusing || usr.Fused) return
				if(A.client) if(A.Fused|A.client.address==usr.client.address|!A.client|A.Dead|A.icon_state=="KO")
					usr<<"You cannot fuse with this person"
					return
				usr.Fusing=1
				A.Fusing=1
				var/Choice=alert(A, "[usr] wants to fuse with you using the Potara Earrings, do you accept?","","No","Yes")
				switch(Choice)
					if("Yes")
						view(usr)<<"[usr] fuses with [A]!"
						LogHook("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Potara Earrings with [key_name(A)]")
						alertAdmins("[key_name(usr)] used Potara Earrings with [key_name(A)]")
						usr.saveToLog("| [usr.client.address ? (usr.client.address) : "IP not found"] | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] used Potara Earrings with [key_name(A)].\n")
						A.saveToLog("| [A.client.address ? (A.client.address) : "IP not found"] | ([A.x], [A.y], [A.z]) | [key_name(A)] used Potara Earrings with [key_name(usr)].\n")
						A.Base+=usr.Base / 2
						A.MaxKi+=usr.MaxKi / 2
						A.Ki = A.MaxKi
						A.KiMod += usr.KiMod / 2
						A.BPMod += usr.BPMod / 2
						A.StrMod += usr.StrMod / 2
						A.EndMod += usr.EndMod / 2
						A.SpdMod += usr.SpdMod / 2
						A.OffMod += usr.OffMod / 2
						A.DefMod += usr.DefMod / 2
						A.BaseRegeneration += usr.BaseRegeneration / 2
						A.BaseRecovery += usr.BaseRecovery / 2
						usr.Fused = 1
						A.Fused = 1
						if(usr.Race == "Shinjin"&&A.Race == "Shinjin")
							spawn usr.Death("sacrificing their life using the Potara Earrings")
						else
							usr.loc = locate(A.contents)
							usr.Get_Observe(A)
							spawn(36000)
								A.Potara_Revert(usr) //Lasts an hour
					else view(A) << "[A] declines [usr]'s offer to fuse."
				usr.Fusing=0
				A.Fusing=0
				