


mob/var
	Cyber_Left_Arm = 0
	Cyber_Left_Leg = 0
	Cyber_Right_Leg = 0
	Cyber_Right_Arm = 0
	Cyber_Sight = 0
	Cyber_Torso=0


Skill/Technology/Cybernetic_Limb
	desc={"Replace someone's limb with an upgraded, cybernetic version. (Limb gets +50 Max Health
	Cybernetic Eyes grant 3% Offense/Defense. Cybernetic Legs give 2.5% Speed.
	Cybernetic Arms give 2.5% Strength and Force. Cyberntic Torso gives 3% End and Max Energy. All cyber limbs reduce Regen by 5%. Embrace the Future MP doubles the stat bonuses.)"}
	Experience=100
	verb/Cybernetic_Limb()
		set category="Other"

		var/Cost = 500000000
		var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
		usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."

		for(var/obj/Resources/M in usr)
			if(M.Value > Actual)
				var/list/Choices=new
				Choices+="Cancel"
				for(var/mob/player/PP in view(3)) Choices+=PP
				var/mob/A=input("Cybernetic Limb") in Choices
				if(A=="Cancel") return
				var/list/BPChoices=list("Eyes","Chest","Left Arm","Right Arm","Left Leg","Right Leg","Cancel")
				if(A.Cyber_Sight) BPChoices-="Eyes"
				if(A.Cyber_Torso) BPChoices-="Chest"
				if(A.Cyber_Right_Arm) BPChoices-="Right Arm"
				if(A.Cyber_Left_Arm) BPChoices-="Left Arm"
				if(A.Cyber_Right_Leg) BPChoices-="Right Leg"
				if(A.Cyber_Left_Leg) BPChoices-="Left Leg"
				var/C=input("Which limb?") in BPChoices
				var/Boost
				switch(C)
					if("Eyes")Boost="+3% Off/Def -5% Regen"
					if("Right Arm")Boost="+2.5% Strength/Force -5% Regen"
					if("Left Arm")Boost="+2.5% Strength/Force -5% Regen"
					if("Right Leg")Boost="+2.5% Speed -5% Regen"
					if("Left Leg")Boost="+2.5% Speed -5% Regen"
					if("Chest")Boost="+3% Endurance/Max Energy -5% Regen"
				if(C=="Cancel") return
				var/CC=input(A,"Allow [usr] to cyberize your [C]? (Offers [Boost])") in list("Yes","No")
				if(CC=="Yes")
					var/BodyPart/BPP=null
					for(var/BodyPart/BP in A) if(BP.name==C) BPP=BP
					if(BPP)
						BPP.Cybernetic=1
						if(BPP.MaxHealth<150) BPP.MaxHealth=150
						A.CyberLimb(BPP)
						A.Injure_Heal(200,BPP,1)
						A.Injure_Heal(200,BPP,1)
						M.Value-=Actual
						view(usr)<<"[usr] has successfully replaced [A]'s [C] with a cybernetic version."
			else
				usr << "You do not have [Commas(Actual)] resources to spare in order to use the Cybernetic Limb."
				return


mob/proc/CyberLimb(BodyPart/BP)
	if(istype(BP,/BodyPart/Right_Arm))Cyber_Right_Arm=1
	if(istype(BP,/BodyPart/Right_Leg))Cyber_Right_Leg=1
	if(istype(BP,/BodyPart/Left_Arm))Cyber_Left_Arm=1
	if(istype(BP,/BodyPart/Left_Leg))Cyber_Left_Leg=1
	if(istype(BP,/BodyPart/Eyes))Cyber_Sight=1
	if(istype(BP,/BodyPart/Chest))Cyber_Torso=1

Skill/Technology/Replace_Limb
	Experience=100
	desc="Replace someone's missing or damaged limb."
	verb/Replace_Limb()
		set category="Other"
		var/Cost = 105000000
		var/Actual = round(initial(Cost)/usr.Int_Mod*(1-(0.15*usr.HasDeepPockets)))
		usr << "Base cost for this skill is [Commas(Cost)] resources. Your intelligence means it costs [Commas(Actual)] resources for you."

		for(var/obj/Resources/M in usr)
			if(M.Value > Actual)
				var/list/Choices=new
				Choices+="Cancel"
				for(var/mob/player/PP in view(3)) Choices+=PP
				var/mob/A=input("Replace Limb") in Choices
				if(A=="Cancel") return
				var/list/BPChoices=new
				BPChoices+="Cancel"
				for(var/BodyPart/BP in A) BPChoices+=BP
				var/BodyPart/C=input("Which limb?") in BPChoices
				if(C=="Cancel") return
				var/CC=input(A,"Allow [usr] to replace your [C]?") in list("Yes","No")
				if(CC=="Yes")
					M.Value-=Actual
					A.Injure_Heal(200,C,1)
					A.Injure_Heal(200,C,1)
					view(usr)<<"[usr] has successfully replaced [A]'s [C]."


			else
				usr << "You do not have [Commas(Actual)] resources to spare in order to use Replace Limb."
				return
