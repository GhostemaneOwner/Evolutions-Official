



mob/proc/AlignmentCalibrate()
	if(AlignmentNumber>=5) Alignment="Very Pure"
	else if(AlignmentNumber>1) Alignment="Pure"
	else if(AlignmentNumber<=-5) Alignment="Very Chaotic"
	else if(AlignmentNumber<-1) Alignment="Chaotic"
	else Alignment="Neutral"

mob/var
	Teacher
	Judgement
	NextAlignmentShift


Skill/Support/Make_Judgement
	desc="Judges a soul to heaven, hell or the checkpoint. Also gives you the power to then forcibly send them there. Sunder Soul removes a dead person's body and knocks them out."
	verb/Make_Judgement(mob/M in oview(5))
		set category="Other"
		if(M.Dead)
			if(M.Judgement) if(M.Confirm("They were already judged to [M.Judgement], reassign?"))
				M.Judgement=input("Judge [M] to Heaven, Hell or the Checkpoint?") in list("Heaven","Hell","Checkpoint")
				switch(M.Judgement)
					if("Hell") M.AlignmentNumber-=3
					if("Heaven") M.AlignmentNumber+=3
					if("Checkpoint") if(M.AlignmentNumber!=0) M.AlignmentNumber/=5
				view(usr)<<"[M] has been judged to [M.Judgement]."
				//("| | ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] judged [key_name(M)] to [M.Judgement]")
				M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(usr)] judged [key_name(M)] to [M.Judgement].\n")
			else
				M.Judgement=input("Judge [M] to Heaven, Hell or the Checkpoint?") in list("Heaven","Hell","Checkpoint")
				view(usr)<<"[M] has been judged to [M.Judgement]."
				switch(M.Judgement)
					if("Hell") M.AlignmentNumber-=3
					if("Heaven") M.AlignmentNumber+=3
					if("Checkpoint") if(M.AlignmentNumber!=0) M.AlignmentNumber/=5
				M.AlignmentCalibrate()
				M.saveToLog("|  | ([M.x], [M.y], [M.z]) | [key_name(usr)] judged [key_name(M)] to [M.Judgement].\n")
		else usr<<"They are not a soul."
	verb/Return_Soul(mob/M in oview(5))
		set category="Other"
		if(M.Dead&&M.Judgement) if(usr.Confirm("Send [M] to [M.Judgement]?"))
			switch(M.Judgement)
				if("Hell") M.SendToHell()
				if("Heaven") M.SendToHeaven()
				if("Checkpoint") M.SendToCheckpoint()
	verb/Sunder_Soul(mob/M in oview(5))
		set category="Skills"
		if(M.Dead)
			M.KO("Soul Sundering")
			view(usr)<<"[usr] has sundered [M]s soul!"
mob/proc
	SendToHell()
		loc=locate(rand(100,200),rand(100,200),11)
	SendToHeaven()
		loc=locate(rand(50,400),rand(235,500),10)
	SendToCheckpoint()
		loc=locate(rand(100,200),rand(100,200),8)
