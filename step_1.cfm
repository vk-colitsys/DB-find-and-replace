<!---
<fusedoc fuse="act_step_1.cfm">
	<responsibilities>
		I really don't do a whole lot, I just increment session.dbformstep.
	</responsibilities>	
	<properties>

	</properties>
	<io>
		<in>
			<number name="dbformstep" scope="session"/>
		</in>	
		<out>
		</out>
	</io>	
</fusedoc>
--->
<cfset session.dbformstep = 1>