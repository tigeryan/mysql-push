<cfset message = {"text" = "Ah, Push it! Push it real good!"} />

<cfset temp = request.pusher.pushToAllSubscribers(
			channel = "app-channel",
			eventType = "message",
			message = message
			) />

<cfdump var="#temp#" />
