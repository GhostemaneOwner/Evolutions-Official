obj/items

	Slot_Machine
		icon = 'slot_machine.dmi'
		Savable=1
		Bolted=1
		Health=50000
		pixel_x=-16
		density=1
		// health etc should be inherited
		var/list/symbols = list("Cherry" = 12000, "Bell" = 20000, "Amethyst" = 15000, "Lemon" = 5000, "Topaz" = 14000, "Bar" = 40000, "Seven" = 60000, "Horseshoe" = 10000, "Diamond" = 80000)
		var/money = 0
		var/spins = 0
		var/total_spins = 0
		var/total_earned = 0
		var/stakes = 1
		var/lost = 0
		var/tmp/last_player
		var/min_amount = 5000
		var/password = null

		proc
			roll_reel(mob/player)
				if(last_player != player)
					total_spins = 0
					total_earned = 0
					lost = 0
					stakes = 1
				last_player = player
				var/resultA = pick(symbols)
				var/resultB = pick(symbols)
				var/resultC = pick(symbols)
				var/result1 = pick(symbols)
				var/result2 = pick(symbols)
				var/result3 = pick(symbols)
				var/resultD = pick(symbols)
				var/resultE = pick(symbols)
				var/resultF = pick(symbols)
				player << "Result: \[ [resultA] | [resultB] | [resultC] \]"
				player << "Result: \[ [result1] | [result2] | [result3] \]"
				player << "Result: \[ [resultD] | [resultE] | [resultF] \]"
				var/prize = 0
				if(result1 == result2 && result2 == result3)
					prize = symbols[result1]
				if(resultA == result2 && result2 == resultF)
					prize = max(prize, symbols[resultA] * 0.65)
				if(resultD == result2 && result2 == resultC)
					prize = max(prize, symbols[resultD] * 0.65)
				if(resultB == result2 && result2 == resultE)
					prize = max(prize, symbols[resultB] * 0.8)
				if(resultA == result1 && result1 == resultD)
					prize = max(prize, symbols[resultA] * 0.5)
				if(resultC == result3 && result3 == resultF)
					prize = max(prize, symbols[resultC] * 0.5)
				if(resultA == resultB && resultB == resultC)
					prize = max(prize, symbols[resultA] * 0.5)
				if(resultD == resultE && resultE == resultF)
					prize = max(prize, symbols[resultD] * 0.5)
				// remove spin
				spins -= 1
				prize = prize * stakes
				player << "You win: [prize]."
				total_earned += prize
				lost += (min_amount * stakes) - prize
				total_spins += 1
				player << "Total Spins: [total_spins]."
				player << "Spins Left: [spins]."
				player << "Total Earned: [total_earned]."
				player << "Net Gain: [total_earned - lost]."

			set_password(mob/player)
				var/new_pw = input("", "Enter a new password.") as null | text
				if(!new_pw)
					player << "You must enter a password."
					return
				password = new_pw
				player << "You have changed the password."


		verb
			Play()
				set src in view(1)
				if(spins < 1)
					usr << "Insert resources for spins."
					return
				roll_reel(usr)

			Set_Stakes()
				set src in view(1)
				var/setting = input("", "Set your stakes multiplier") as null | anything in list(1, 2)
				if(!setting) return
				stakes = setting
				last_player = usr

			Insert_Money()
				set src in view(1)
				for(var/obj/Resources/M in usr)
					var/amount = input("", "How many resources?") as null | num
					if(!amount || amount < min_amount)
						usr << "You must enter at least [min_amount]."
						return
					if(amount / min_amount != round(amount / min_amount))
						usr << "You must enter multiples of [min_amount]."
						return
					if(M.Value > amount)
						M.Value-=amount
						money = amount
						spins += amount / min_amount
						total_earned = 0
						lost = 0
						usr << "You have entered [amount] and gained [amount / min_amount] spins."
					else
						usr << "You don't have enough resources."
						return
			Cash_Out_Winnings()
				set src in view(1)
				var/net_gain = total_earned - lost
				if(net_gain <= 0)
					usr << "You have nothing to cash out"
					total_spins = 0
					total_earned = 0
					lost = 0
					stakes = 1
					return
				if(net_gain > money)
					usr << "ERROR: Payout Invalid, see customer service."
					// don't reset it, they'll need it as proof
					return
				// give them total_earned in resources
				for(var/obj/Resources/M in usr) M.Value += net_gain
				usr << "You cash out for [net_gain] resources."
				total_earned = 0
				lost = 0

			Check_Details()
				set src in view(1)
				var/mob/player = usr
				player << "Total Spins: [total_spins]."
				player << "Spins Left: [spins]."
				player << "Total Earned: [total_earned]."
				player << "Net Gain: [total_earned - lost]."

			Maintenance()
				set src in view(1)
				var/list/options = list("Change Password", "Withdraw All", "Withdraw Amount")
				var/option = input("", "Select an option.") as null | anything in options
				if(!option) return
				if(option != "Change Password" && !length(password))
					usr << "A password needs set to do maintenance."
					return
				if(length(password))
					var/old_pw = input("", "Enter password") as null | text
					if(old_pw != password)
						usr << "ERROR: Wrong password"
						return
				if(option == "Change Password")
					set_password(usr)
				else if(option == "Withdraw All")
					if(money <= 0)
						usr << "There's no money to withdraw"
						return
					usr << "You have withdrawn [money] resources."
					for(var/obj/Resources/M in usr) M.Value += money
					money = 0
					return
				else if(option == "Withdraw Amount")
					var/amt = input("", "How much?") as null | num
					if(!amt || !isnum(amt) || amt < 0) return
					if(amt > money)
						usr << "There isn't enough"
						return
					usr << "You have withdrawn [amt] resources."
					for(var/obj/Resources/M in usr) M.Value += amt
					money -= amt
					