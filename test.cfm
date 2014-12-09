    <cfscript>
        request.pusherAppID = "99452";
        request.pusherKey = "7af9fad3df855a1968e5";
        request.pusherSecret = "8dc08dc71ebb470ace7a";
        // *********************************************************

        // Create an instance of our pusher component using our demo
        // credentials and the Crypto library.
        request.pusher = new cfcs.Pusher(
        appID = request.pusherAppID,
        appKey = request.pusherKey,
        appSecret = request.pusherSecret
        );
    </cfscript>

    <cfset message = {"text" = "reload - #timeformat(Now(),'hhmmss')#"} />

    <cfset temp = request.pusher.pushToAllSubscribers(
			channel = "product-report",
			eventType = "message",
			message = message
			) />

<cfdump var="#temp#" />
