<!---
<fusedoc fuse="dsp_step_5.cfm">
	<responsibilities>
	I display the results of your attempted Big Undo.
	</responsibilities>	
	<properties>

	</properties>
	<io>
		<in>
			<string name="err_msg" scope="attributes"/>
			<query name="qAfterResults"/>			
		</in>	
		<out>
		</out>
	</io>	
</fusedoc>
--->
<cfoutput>

<p><b>The big UNDO:</b></p>

<cfif len(attributes.err_msg) GT 0>

	<span class="bad">#attributes.err_msg#</span>
	<cfdump var="#session.dbfrp.dbattribs#">

<cfelse>

	<p>If you didn't get any errors, the affected records in your db have been restored. See for yourself.</p>
	<cfdump var="#qAfterResults#">
</cfif>

</cfoutput>
