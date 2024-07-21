

//Ignore_Taxes()
mob/verb/Misc_Options()
	set category=null
	var/PP=input("Change what option?","Misc Options") in list("Toggle Show Res/Mana Gains","Toggle Show Drains","Toggle Pay Taxes","Toggle Languages","Toggle Body Parts","Change Macro Set","Cancel")
	switch(PP)
		if("Toggle Show Res/Mana Gains")Toggle_Show_ResMana()
		if("Toggle Show Drains")Toggle_Show_Drains()
		if("Toggle Pay Taxes")Ignore_Taxes()
		if("Toggle Languages")Toggle_Languages()
		if("Toggle Body Parts")Toggle_Body_Parts()
		if("Change Macro Set") ChangeMacro()


mob/var/ToggleViewResMana=1

mob/verb/Toggle_Show_ResMana()
	set hidden=1
	usr.ToggleViewResMana=!usr.ToggleViewResMana
	if(usr.ToggleViewResMana)
		usr<<"Now seeing Mana/Res gains in combat tab."
		usr.ToggleViewResMana=1
	else
		usr<<"No longer showing Mana/Res gains in combat tab."
		usr.ToggleViewResMana=0

mob/var/ToggleViewDrain=1
mob/var/tmp/SkillTierUses//tracks the tier of skills used, depletes by 1 per 1.5 seconds and increases the cost of skills. only tracks tiers above 1. Caps at 10 which is 2x costs


mob/verb/Toggle_Show_Drains()
	set hidden=1
	usr.ToggleViewDrain=!usr.ToggleViewDrain
	if(usr.ToggleViewDrain)
		usr<<"Now seeing Ki drain in combat tab."
		usr.ToggleViewDrain=1
	else
		usr<<"No longer showing Ki drain in combat tab."
		usr.ToggleViewDrain=0
mob/proc/DrainKi(Source, DrainType, Drain,show=1)
	if(Drain<0) Drain=0
	if(!isnum(Ki)) return
	if(DrainType=="Percent")
		Drain/=100
		Drain*=BaseMaxKi
	if(DrainType=="SoftCapPercent")
		Drain/=100
		Drain*=SoftStatCap
	if(DrainType!="Percent"&&DrainType!="SoftCapPercent"&&GodKiActive)
		var/GDrain=Drain*0.1
		GodKi=max(0,GodKi-GDrain)
	if(istype(Source,/Skill/))//only increases the drain of skill usage
		var/Skill/S=Source
		if(S.Tier>1) SkillTierUses=min(10,SkillTierUses+S.Tier)
		if(SkillTierUses)
			var/CostIncrease=1+(SkillTierUses/10)
			Drain*=CostIncrease
		//increases skill cost by 10% per SkillTierUses
	Ki=max(0,Ki-Drain)
	if(ToggleViewDrain&&show) CombatOut("[(Drain)] Energy spent ([Source])")

