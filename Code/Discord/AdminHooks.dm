proc/NewPortHook()
	var/ServerAddress="byond://[world.internet_address]:[world.port]"
	if(!TestServerOn)if(world.host=="SRTeam")
		usr.client.HttpPost(
						// Replace this with the webhook URL that you can Copy in Discord's Edit Webhook panel.
						"https://discordapp.com/api/webhooks/1205050010052329482/FvhR6cCTtborFZ0BVi82fnIUaoq4Yz30TgMnwHQ_03c_n9ynqFdMN6BoqAHVKgQmB3HA",

						/*
						[content] is required and can't be blank.
							It's the message posted by the webhook.

						[avatar_url] and [username] are optional.
							They're taken from your key.
							They override the webhook's name and avatar for the post.
						*/
						list(
							content = "**Server Open** \n @everyone Server is live at [ServerAddress]",
						)
					)
		world<<"<span class=\"announce\"> Discord notified of world address!</span>"

proc/LogHook(var/text)if(!TestServerOn)
	var list/l = splittext(text, "")
	var skip = 0
	var inTag = 0  // Variable to track if inside an HTML tag
	for (var/i = 1; i <= l.len; i++)
		if (l[i] == "<")
			inTag = 1
			skip = 1  // Flag to skip over the HTML tag and its contents
			l[i] = ""  // Remove the opening "<" of the HTML tag
		else if (l[i] == ">")
			if (inTag)
				inTag = 0
				skip = 0  // Reset the skip flag when closing the HTML tag
				l[i] = ""  // Remove the closing ">"
		else if (!inTag && l[i] == "-" && i < l.len && l[i+1] == ">")
			i++  // Skip over the ">" symbol, retain the "-"
		else if (skip)
			l[i] = ""  // Remove all characters within the HTML tag
	var/new_text = l.Join("")

	usr.client.HttpPost(
					"https://discordapp.com/api/webhooks/1205050010052329482/FvhR6cCTtborFZ0BVi82fnIUaoq4Yz30TgMnwHQ_03c_n9ynqFdMN6BoqAHVKgQmB3HA",
					list(
						content = "Year - [Year], Time - [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")] \n ```[new_text]```",
					)
				)
				