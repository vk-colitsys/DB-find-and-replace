
<cfif GetFileFromPath(CGI.SCRIPT_NAME) neq "index.cfm">
	<cflocation url="index.cfm" addtoken="No">
</cfif>

<cfset setEncoding("URL", "iso-8859-1")>
<cfset setEncoding("FORM", "iso-8859-1")>
<cfcontent type="text/html; charset=iso-8859-1">