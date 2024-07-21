obj
	Props
		Sign
			verb/Bolt()
				set src in oview(1)
				if(x&&y&&z&&!Bolted)
					Bolted=1
					Shockwaveable=0
					range(20,src)<<"[usr] bolts the [src] to the ground."
					return
				if(Bolted) if(src.Builder=="[usr.real_name]")
					range(20,src)<<"[usr] unbolts the [src] from the ground."
					Bolted=0
					Shockwaveable=1
					return
			icon='Sign.dmi'
			icon_state = "sign1"
			density=1
			Click() if(desc) usr<<desc
		Sign/Information_Panel
			icon='Lab.dmi'
			icon_state="Radar"
			Click() if(desc) usr<<desc
		Sign/Cross
			icon='Cross.dmi'
			Click() if(desc) usr<<desc
		Sign/Grave2
			icon='Grave1.dmi'
			Flammable = 1
			Click() if(desc) usr<<desc
		Sign/Grave3
			icon='Grave2.dmi'
			Click() if(desc) usr<<desc
		Sign/Grave4
			icon='Graves.dmi'
			icon_state="1"
			Click() if(desc) usr<<desc
		Sign/Grave5
			icon='Graves.dmi'
			icon_state="2"
			Click() if(desc) usr<<desc
		Sign/Grave6
			icon='Graves.dmi'
			icon_state="3"
			Click() if(desc) usr<<desc
		Sign/Grave7
			icon='Graves.dmi'
			icon_state="4"
			Click() if(desc) usr<<desc
		Sign/Grave8
			icon='Graves.dmi'
			icon_state="5"
			Click() if(desc) usr<<desc
		Sign/SignPost
			icon='SignPost.dmi'
			Flammable = 1
			Click() if(desc) usr<<desc
		Sign/Caution
			icon='CautionSign.dmi'
			Click() if(desc) usr<<desc
		Sign/ChalkBoard
			icon='SignChalkBoard.dmi'
			pixel_x = -16
			Click() if(desc) usr<<desc
		Sign/Board
			icon='Sign.dmi'
			icon_state="sign2"
			Flammable = 1
			Click() if(desc) usr<<desc
		Sign/Grave
			icon='grave.dmi'
			Click() if(desc) usr<<desc
			New()
				src.pixel_x = -8
		Sign/Large_Stone_Engraving
			icon='stone.dmi'
			Click() if(desc) usr<<desc
			New()
				src.pixel_x = -8
		Sign/MailDeposit
			icon='Urban.dmi'
			icon_state="MailDeposit"
			Click() if(desc) usr<<desc
			