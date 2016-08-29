<!--- include the core FuseBox  --->
<cflock type="READONLY" name="#server.coldfusion.productVersion#" timeout="10">
	<cfset variables.fuseboxOSName=server.os.name>
</cflock>
<!--- i switched the core fusebox30 file extensions to .cfml so I could do find-n-replaces
on *.cfm without messin these core files up --->
<cfif variables.fuseboxOSName contains "Windows">
	<cfinclude template="fbx_fusebox30_CF50.cfml">
<cfelse>
	<cfinclude template="fbx_fusebox30_CF50_nix.cfml">
</cfif>
