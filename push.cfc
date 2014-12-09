<cfcomponent name="pushCFC" output="false">
<cfsetting showdebugoutput="false" />

<!--- Pseudo-constructor --->
<cfset variables.datasource = application.datasource />


<cffunction name="sendPush" access="remote" output="false" returns="struct">

    <cfscript>
        request.pusherAppID = "0000";
        request.pusherKey = "0000";
        request.pusherSecret = "0000";
        // *********************************************************

        // Create an instance of our pusher component using our demo
        // credentials and the Crypto library.
        request.pusher = new cfcs.Pusher(
        appID = request.pusherAppID,
        appKey = request.pusherKey,
        appSecret = request.pusherSecret
        );
    </cfscript>


    <cfset message = {"text" = "reload"} />

    <cfset request.pusher.pushToAllSubscribers(
			channel = "product-report",
			eventType = "message",
			message = message
			) />

    <cffile action="append" file="C:\ColdFusionBuilder3\ColdFusion\cfusion\wwwroot\mysql-push\sendPush.log" output="#Now()#" />

</cffunction>

<cffunction name="getReport" access="remote" output="false" returns="string" returnformat="plain">

    <cfquery name="getData" datasource="#application.datasource#">
        SELECT *
        FROM products
        ORDER BY product_id DESC
    </cfquery>

    <cfsavecontent variable="html">
        <table>
            <tr>
                <td>Product ID</td>
                <td>Product</td>
                <td>Price</td>
            </tr>
            <cfoutput query="getData">
            <tr>
                <td>#getData.product_id#</td>
                <td>#getData.product_name#</td>
                <td>#getData.product_price#</td>
            </tr>
            </cfoutput>
        </table>
    </cfsavecontent>

    <cfreturn html />
</cffunction>


<!--- *** AUTHORIZATION & REGISTRATION *** --->
<!--- This should be called via HTTPS
<cffunction name="authUser" access="remote" output="false" returns="struct">
	<cfargument name="u" type="string" required="true" />
	<cfargument name="p" type="string" required="true" />
	<cfargument name="seckey" type="string" required="true" />

	<cfif cgi.REQUEST_METHOD NEQ "POST">
		<cfreturn returnError('10002') />
	</cfif>

	<cfif cgi.HTTPS NEQ "on" AND application.production EQ 1>
		<cfreturn returnError('10005') />
	</cfif>

	<cfif arguments.seckey NEQ variables.SEC_KEY>
		<cfreturn returnError('10000') />
	</cfif>

	<cfstoredproc procedure="m3_mdlinx_auth_user" datasource="#variables.datasource#">
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(trim(arguments.u))#" />
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" value="#trim(arguments.p)#" />
		<cfprocparam cfsqltype="CF_SQL_VARCHAR" value="" />
		<cfprocresult name="local.get_user" />
	</cfstoredproc>

	<cfif local.get_user.recordcount EQ 0>
		<cfreturn returnError('10003') />
	<cfelse>
		<cfreturn
		{ "success"=javaCast("int", local.get_user.recordCount)
		, "uic"=local.get_user.user_id_code
		, "fname"=local.get_user.fname
		, "lname"=local.get_user.lname
		, "email"=local.get_user.email
		, "uid"=local.get_user.user_id}
		/>
	</cfif>
</cffunction>
--->

<!--- *** UTILIZATION *** --->
<cffunction name="returnError" access="private" output="false" return="struct">
	<cfargument name="error_id" type="string" required="true" default="00001" />

     <cffile action="append" file="C:\ColdFusionBuilder3\ColdFusion\cfusion\wwwroot\mysql-push\error.log" output="#Now()#" />

	<cfmail to="email" from="email" subject="Push.cfc ERROR" type="html">
		API Error - ERROR ##: #error_id#<br />
		#DateFormat(Now(),'mm/dd/yyyy')# #TimeFormat(Now(),'mm/dd/yyyy')#<br />
		<cfdump var="#CGI#">
		<cfif CGI.REQUEST_METHOD EQ "POST">
			<cfdump var="#FORM#" />
		<cfelse>
			<cfdump var="#URL#" />
		</cfif>
	</cfmail>

	<cfreturn {"error"="###error_id#"} />
</cffunction>

</cfcomponent>




