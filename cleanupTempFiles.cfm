<!---
<fusedoc fuse="act_cleanupTempFiles.cfm">
	<responsibilities>
		I'm gonna clean that backups directory up!
	</responsibilities>	
	<properties>
	
	</properties>
	<io>
		<in>
			<string name="timestamp" scope="attributes"/>
		</in>	
		<out>
			<query name="qDirBefore"/>
			<query name="qDirAfter"/>
		</out>
	</io>	
</fusedoc>
--->
<!--- In short, if you don't spec a timestamp, it's all gonna go! --->
<cfparam name="session.timestamp" default="">

<cfset dirName="#expandPath('backups')#">
<cfdirectory directory="#dirName#" action="list" name="qDirBefore">

<cfloop query="qDirBefore">
	<cfif find(session.timestamp, qDirBefore.name) AND qDirBefore.type eq "file">
		<cffile action="delete" file="#dirName#/#qDirBefore.name#">
	</cfif>
</cfloop>

<cfdirectory directory="#dirName#" action="list" name="qDirAfter">
