<!---
<fusedoc fuse="FBX_Switch.cfm">
	<responsibilities>
		I am the cfswitch statement that handles the fuseaction, delegating work to various fuses.
	</responsibilities>
	<io>
		<string name="fusebox.fuseaction" />
		<string name="fusebox.circuit" />
	</io>	
</fusedoc>
--->
<cfswitch expression = "#fusebox.fuseaction#">

	<cfcase value="fusebox.defaultfuseaction">
		<!---This will be the value returned if someone types in "circuitname.", omitting the actual fuseaction request--->
	</cfcase>
	
	<cfcase value="welcome">
		<cfinclude template="dsp_welcome.cfm">
		<cfinclude template="act_step_1.cfm">
		<cfinclude template="dsp_step_1.cfm">
	</cfcase>

	<cfcase value="install">
		<cfinclude template="dsp_install.cfm">
	</cfcase>

	<cfcase value="how">
		<cfinclude template="dsp_how.cfm">
	</cfcase>

	<cfcase value="about">
		<cfinclude template="dsp_about.cfm">
	</cfcase>

	<cfcase value="explore">
		<cfinclude template="act_explore.cfm">
		<cfinclude template="dsp_explore.cfm">
	</cfcase>
	
	<cfcase value="submitform_step_1">
		<cfinclude template="act_step_1.cfm">
		<cfinclude template="dsp_step_1.cfm">
	</cfcase>

	<cfcase value="submitform_step_2">
		<cfinclude template="act_step_2.cfm">
		<cfinclude template="dsp_step_2.cfm">
	</cfcase>

	<cfcase value="submitform_step_3">
		<cfinclude template="act_step_3.cfm">
		<cfinclude template="dsp_step_3.cfm">
	</cfcase>

	<cfcase value="submitform_step_4">
		<cfinclude template="act_step_3.cfm">
		<cfinclude template="act_step_4.cfm">		
		<cfinclude template="dsp_step_4.cfm">
	</cfcase>

	<cfcase value="submitform_step_5">
		<cfinclude template="act_step_5.cfm">
		<cfinclude template="dsp_step_5.cfm">
	</cfcase>

	<cfcase value="cleanupTempFiles">
		<cfinclude template="act_cleanupTempFiles.cfm">
		<cfinclude template="dsp_cleanupTempFiles.cfm">
	</cfcase>
	
	<cfdefaultcase>
		<!---This will just display an error message and is useful in catching typos of fuseaction names while developing--->
		<cfoutput>This is the cfdefaultcase tag. I received a fuseaction called "#attributes.fuseaction#" and I don't know what to do with it.</cfoutput>
	</cfdefaultcase>

</cfswitch>
