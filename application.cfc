<cfcomponent>
<cfset This.name = "TestApplication3">
<cfset This.Sessionmanagement=true>
<cfset This.Sessiontimeout="#createtimespan(0,0,10,0)#">
<cfset This.applicationtimeout="#createtimespan(5,0,0,0)#">


<cffunction name="onApplicationStart">

    <cflog file="#This.Name#" type="Information" text="Application Started">
    <!--- You do not have to lock code in the onApplicationStart method that sets Application scope variables. --->
    <cfscript>
        Application.availableResources=0;
        Application.counter1=1;
        Application.sessions=0;
        Application.datasource = "mdlinx";
    </cfscript>


    <!--- You do not need to return True if you don't set the cffunction returntype attribute. --->
 </cffunction>

<cffunction name="onApplicationEnd">
    <cfargument name="ApplicationScope" required=true/>
    <cflog file="#This.Name#" type="Information" text="Application #ApplicationScope.applicationname# Ended">
</cffunction>


<cffunction name="onRequestStart">

</cffunction>

<cffunction name="onRequest">
    <cfargument name = "targetPage" type="String" required=true/>
    <cfinclude template=#Arguments.targetPage#>

</cffunction>

<!--- Display a different footer for logged in users than for guest users or
         users who have not logged in. --->

<cffunction name="onRequestEnd">
    <cfargument type="String" name = "targetTemplate" required=true/>

</cffunction>

<cffunction name="onSessionStart">
    <cfscript>
        Session.started = now();
    </cfscript>
    <cflock timeout="5" throwontimeout="No" type="EXCLUSIVE" scope="SESSION">
        <cfset Application.sessions = Application.sessions + 1>
    </cflock>
    <cflog file="#This.Name#" type="Information" text="Session:
        #Session.sessionid# started">
</cffunction>

<cffunction name="onSessionEnd">
    <cfargument name = "SessionScope" required=true/>
    <!---<cflog file="#This.Name#" type="Information" text="Session:
            #arguments.SessionScope.sessionid# ended">--->
</cffunction>

<cffunction name="onError">
    <cfargument name="Exception" required=true/>
    <cfargument type="String" name = "EventName" required=true/>
    <!--- Log all errors. --->
    <cflog file="#This.Name#" type="error" text="Event Name: #Eventname#">
    <cflog file="#This.Name#" type="error" text="Message: #exception.message#">
    <!--- Some exceptions, including server-side validation errors, do not
             generate a rootcause structure. --->
    <cfif isdefined("exception.rootcause")>
        <cflog file="#This.Name#" type="error"
            text="Root Cause Message: #exception.rootcause.message#">
    </cfif>
    <!--- Display an error message if there is a page context. --->
    <cfif NOT (Arguments.EventName IS onSessionEnd) OR (Arguments.EventName IS onApplicationEnd)>
        <cfoutput>
            <h2>An unexpected error occurred.</h2>
            <p>Please provide the following information to technical support:</p>
            <p>Error Event: #EventName#</p>
            <p>Error details:<br>
            <cfdump var=#exception#></p>
        </cfoutput>
    </cfif>
 </cffunction>

</cfcomponent>
