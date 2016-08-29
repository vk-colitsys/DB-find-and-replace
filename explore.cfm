<!---
<fusedoc fuse="dsp_explore.cfm">
	<responsibilities>
		I was going to build out this app without a database explorer,
		but it was a pain to use the app without it. So here you go.
		
		You supply a datasource, and I'll show the tables therein.
		You stick in a table, and I'll show you the fields.
	</responsibilities>	
	<properties>
	</properties>
	<io>
		<in>
		</in>	
		<out>
			<query name="qResult"/>
		</out>
	</io>	
</fusedoc>
--->

<cfif len(session.db_dsn)>
	<cfif len(session.db_table)>
		<cfquery name="qResult" datasource="#session.db_dsn#" maxrows="#session.maxrows#">
		SELECT
			*
		FROM
			#session.db_table#
		</cfquery>
	<cfelse>
		<cfquery name="qResult" datasource="#session.db_dsn#">
			<cfif session.db_type eq "mysql">
				SHOW TABLES
			<cfelseif session.db_type eq "mssql">
				SELECT
					name
				FROM
					sysobjects
				WHERE
					xtype = 'U'
			<cfelse>
				<!--- you adding in your own db type? If so, change stuff here.--->
				<cfabort showerror="unrecognized db_type.">
			</cfif>
		</cfquery>	
	</cfif>
</cfif>