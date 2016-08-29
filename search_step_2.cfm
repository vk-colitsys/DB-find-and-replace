<!---
<fusedoc fuse="dsp_step_2.cfm">
	<responsibilities>
		I display the Step 2 form for this app.
		Step 2 is where you see if you are getting the right table and fields returned.
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
			<string name="findstyle" scope="session"/>
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
			<string name="findstyle" scope="attributes"/>
			<boolean name="overridescriptblock" scope="attributes"/>
		</out>
	</io>	
</fusedoc>
--->

<cfset readonlyPassthrough = "true">
<cfset readonlyFRPassthrough = "false">

<cfoutput>
<h2>Step 2: Enter your Find/Replace</h2>
<p><b>I am now only doing a search to verify the table and fields are correct.</b> I will try your Find/Replace in the next step.</p>
<p>When you submit the form, I will show you any matches that result, in a "before and after" format so you can test if the results are correct.</p>

<h3>Here are the results of your query.</h3>
<cfdump var="#qResults#">


<cfform action="#session.dbfrp.self#" method="post" name="dbform" id="dbform">

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

<cfinput type="radio" name="findstyle" value="replace" checked="#iif(session.findstyle eq "replace",de("true"),de("false"))#">
<label for="findstyle">replace</label>
<br>
<cfinput type="radio" name="findstyle" value="reReplace" checked="#iif(session.findstyle eq "reReplace",de("true"),de("false"))#">
<label for="findstyle">reReplace (Regular Expression)</label>
<br>
<cfinput type="radio" name="findstyle" value="replaceNoCase" checked="#iif(session.findstyle eq "replaceNoCase",de("true"),de("false"))#">
<label for="findstyle">replaceNoCase</label>
<br>
<cfinput type="radio" name="findstyle" value="reReplaceNoCase" checked="#iif(session.findstyle eq "reReplaceNoCase",de("true"),de("false"))#">
<label for="findstyle">reReplaceNoCase (Regular Expression)</label>
<br>
<br>

<cfinput type="text" name="findstring" value="#session.findstring#" size="40" validate="regex" pattern="^(.*)+$" message="enter a find string (cannot be blank)" passthrough="#readonlyFRPassthrough#">
<label for="findstring">Find String</label>
<br>
<br>

<cfinput type="text" name="replacestring" value="#session.replacestring#" size="40" required="false" passthrough="#readonlyFRPassthrough#">
<label for="replacestring">Replace String</label>
<br>
<br>

<input type="checkbox" name="overridescriptblock" id="overridescriptblock" value="true" #iif(session.overridescriptblock IS TRUE,de("checked"),de(""))#> Treat <span class="highlight">&lt;invalidTag</span> as <span class="highlight">&lt;script</span>? (You'll know if you need this)
<br>
<br>

<input type="hidden" id="dbformstep" name="dbformstep">
<input type="hidden" id="fuseaction" name="fuseaction">

<input type="button" name="submitTryAgain" value="Try this step again" onClick="tryagain2('#session.dbformstep#')">
<input type="button" name="submitNextStep" value="Go to next step" onClick="trynext('#session.dbformstep#')">

</cfform>

</cfoutput>