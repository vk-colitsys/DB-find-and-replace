<!---
<fusedoc fuse="dsp_step_4.cfm">
	<responsibilities>
	I display the Step 4 page. No form here, really. Well, sort of.
	This is where you see if the Find/Replace worked or not.
	If all went well, you're done.
	You may, however, choose to undo the whle thing by proceeding on to
	Step 5, the Big Undo.
	</responsibilities>	
	<properties>

	</properties>
	<io>
		<in>
			<string name="err_msg" scope="attributes"/>
			<query name="qAfterResults/">			
		</in>	
		<out>
		</out>
	</io>	
</fusedoc>
--->
<cfoutput>
<cfif len(attributes.err_msg) GT 0>
	<h2>Step 4: <span class="bad">Something went wrong. Go back. Try again.</span></h2>
	<h3 class="bad">#attributes.err_msg#</h3>
	<input type="button" name="back" value="Go back to previous step" onClick="history.go(-1)">
<cfelse>
	<h2>Step 4: Database Find/Replace complete!</h2>
	<p>The database Find/Replace is done.</p>
	<p>You might want to keep this window open while you verify the change is what you wanted it to be.</p>
	<p>You have one last chance to undo the work just done.</p>
	
	<div width="100%">
	<cfdump var="#qAfterResults#">
	</div>

	<cfform action="#session.dbfrp.self#" method="post" name="dbform" id="dbform">
	<input type="hidden" name="timestamp" value="#session.dbfrp.timestamp#">
	<input type="hidden" id="dbformstep" name="dbformstep">
	<input type="hidden" id="fuseaction" name="fuseaction">
	<input type="button" name="submitCleanItUp" value="Looks good! Del the temp files." onClick="setFuseaction('main.cleanupTempFiles')">
	<input type="button" name="submitNextStep" value="Augh! Undo! Undo it all! Now!" onClick="trynext('#session.dbformstep#')">
	
	</cfform>
</cfif>
</cfoutput>