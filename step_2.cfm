<!---
<fusedoc fuse="dsp_step_1.cfm">
	<responsibilities>
		I display step 1, where the user enters the preliminary database info.
	</responsibilities>	
	<properties>

</properties>
	<io>
		<in>
			<string name="fuseaction" scope="attributes"/>
			<string name="db_dsn" scope="session"/>
			<string name="db_table" scope="session"/>
			<string name="db_id_field" scope="session"/>
			<string name="queryparam_id_field" scope="session"/>
			<string name="db_search_field" scope="session"/>
			<string name="queryparam_search_field" scope="session"/>
			<number name="maxrows" scope="session"/>
			<number name="dbformstep" scope="session"/>			
		</in>	
		<out>
			<query name="qResults">
				<string name="#session.db_id_field#" comments="datatype unknown"/>
				<string name="#session.db_search_field#" comments="datatype unknown"/>				
			</query>
		</out>
	</io>	
</fusedoc>
--->

<!--- reset session.findstring --->
<cfif session.findstring eq session.dbfrp.ignorestring>
	<cfset session.findstring = "">
</cfif>

<cfquery name="qResults" datasource="#session.db_dsn#" maxrows="#session.maxrows#">
	SELECT
	#session.db_id_field#
	,
	#session.db_search_field#
	FROM
	#session.db_table#
</cfquery>