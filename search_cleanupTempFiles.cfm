<!---
<fusedoc fuse="dsp_cleanupTempFiles.cfm">
	<responsibilities>
		I display the results of the file delete in a nice "before an' after" format.
		I also provide the user a chance to go nuclear and delete 'em all.'
	</responsibilities>	
	<properties>
	
	</properties>
	<io>
		<in>
			<query name="qDirBefore"/>
			<query name="qDirAfter"/>
		</in>	
		<out>
		</out>
	</io>	
</fusedoc>
--->

<cfoutput>
	<h1>Before</h1>	
		<cfdump var="#qDirBefore#">

	<h1>After</h1>	
	<cfdump var="#qDirAfter#">
	
	<cfform action="#session.dbfrp.self#" method="post" name="dbform" id="dbform">
	<input type="hidden" id="dbformstep" name="dbformstep">
	<input type="hidden" id="fuseaction" name="fuseaction">
	<input type="button" name="submitCleanItUp" value="Delete everything! Del all those temp files." onClick="setFuseaction('main.cleanupTempFiles')">
	</cfform>

	
</cfoutput>