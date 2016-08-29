<!---
<fusedoc fuse="dsp_step_1.cfm">
	<responsibilities>
		I display step 1, where the user enters the preliminary database info.
	</responsibilities>	
	<properties>
	
</properties>
	<io>
		<in>
		</in>	
		<out>
			<string name="fuseaction" scope="attributes"/>
			<string name="db_dsn" scope="attributes"/>
			<string name="db_table" scope="attributes"/>
			<string name="db_id_field" scope="attributes"/>
			<string name="queryparam_id_field" scope="attributes"/>
			<string name="db_search_field" scope="attributes"/>
			<string name="queryparam_search_field" scope="attributes"/>
			<number name="maxrows" scope="attributes"/>
			<number name="dbformstep" scope="attributes"/>			
		</out>
	</io>	
</fusedoc>
--->

<cfset readonlyPassthrough = "true">
<cfset readonlyFRPassthrough = "false">

<cfoutput>
<h2>Step 1: Enter the settings for the database you wish to modify.</h2>

<cfform action="#session.dbfrp.self#" method="post" id="dbform" name="dbform">

<cfinput type="text" name="db_dsn" value="#session.db_dsn#" size="40" required="true" message="enter a valid datasource name.">
<label for="db_dsn">Datasource</label>
<br>
<br>

<cfinput type="text" name="db_table" value="#session.db_table#" size="40" required="true" message="enter a valid database table name.">
<label for="db_table">Table</label>
<br>
<br>

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

<cfinput type="text" name="maxrows" value="#session.maxrows#" size="10" required="true" message="enter the maximum number of rows to return">
<label for="maxrows">Max ## of rows to return for previwing</label>
<br>
<br>
<input type="hidden" name="findstyle" value="reReplace">
<input type="hidden" name="findstring" value="#session.dbfrp.ignorestring#">
<input type="hidden" name="overridescriptblock" value="#session.overridescriptblock#">
<input type="hidden" name="replacestring">



<input type="hidden" id="dbformstep" name="dbformstep">
<input type="hidden" id="fuseaction" name="fuseaction">
<input type="button" name="submitNextStep" value="Go to next step" onClick="trynext('#session.dbformstep#')">

</cfform>
</cfoutput>