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
			<query name="qResult"/>
		</in>	
		<out>
		</out>
	</io>	
</fusedoc>
--->

<cfset session.dbformstep = 0>
<cfoutput>
<h2>DB Explorer: Take a look.</h2>
<cfif isDefined("qResult")>
	<cfdump var="#qResult#">
</cfif>	

<cfform action="#session.dbfrp.self#" method="post" id="dbform" name="dbform">

<input type="radio" name="db_type" value="mysql" #iif(session.db_type eq "mysql",de("checked"),de(""))#><label>mySql</label>
<br>
<input type="radio" name="db_type" value="mssql" #iif(session.db_type eq "mssql",de("checked"),de(""))#><label>MS SQL Server</label>
<br>
<br>

<cfinput type="text" name="db_dsn" value="#session.db_dsn#" size="40" required="true" message="enter a valid datasource name.">
<label for="db_dsn">Datasource</label>
<br>
<br>

<cfinput type="text" name="db_table" value="#session.db_table#" size="40" required="false" message="enter a valid database table name.">
<label for="db_table">Table (leave blank, and i'll show you all the tables I find)</label>
<br>
<br>
<cfif len(session.db_table)>
<cfinput type="text" name="db_id_field" value="#session.db_id_field#" size="40" required="true" message="enter a valid database id field name.">
<cfselect name="queryparam_id_field" query="session.dbfrp.qParams" value="param" display="name" selected="#session.queryparam_id_field#"></cfselect>
<label for="db_id_field">ID Field and datatype</label> (unique ID or primary key field in table)
<br>
<br>

<cfinput type="text" name="db_search_field" value="#session.db_search_field#" size="40" required="true" message="enter a valid database search field name.">
<cfselect name="queryparam_search_field" query="session.dbfrp.qParams" value="param" display="name" selected="#session.queryparam_search_field#"></cfselect>
<label for="db_search_field">Search Field and datatype</label> (field to use for find/replace)
<br>
<br>

</cfif>

<cfinput type="text" name="maxrows" value="#session.maxrows#" size="10" required="true" message="enter the maximum number of rows to return">
<label for="maxrows">Max ## of rows to return for previwing</label>
<br>
<br>

<input type="hidden" id="fuseaction" name="fuseaction">
<input type="button" name="submitForm" value="Try it" onClick="setFuseaction('main.explore')">
<cfif len(session.db_table)>
<input type="button" name="submitForm" value="Move on to Step 1" onClick="setFuseaction('main.submitform_step_1')">
</cfif>
</cfform>
</cfoutput>