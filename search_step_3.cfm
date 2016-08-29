<!---
<fusedoc fuse="dsp_step_3.cfm">
	<responsibilities>
	I display the Step 3 form, where you give your Find/Replace a try.
	If you proceed to Step 4, I will attempt to do the Find/Replace for real.
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
			<array name="dbfrp.arrResults" scope="request"/>
			<string name="err_msg" scope="attributes"/>	
			<boolean name="overridescriptblock" scope="session"/>					
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
		</out>
	</io>	
</fusedoc>
--->

<cfset readonlyPassthrough = "readonly disabled">
<cfset readonlyFRPassthrough = "readonly disabled">

<cfoutput>

<cfif len(attributes.err_msg) EQ 0>
	<h2>Step 3: Verify the Find/Replace</h2>
	<p>These results, in <b>cfdump</b> format, show all the records which will be modified. It is not limited by the earlier "max rows" setting.</p>
	<p>Each matching row in your database is an element in the array shown.</p>
	<p>That array element has a structure within, with three elements, <b>After</b>, <b>Before</b>, and <b>ID</b>. The <b>Before</b> and <b>After</b> show you the effects of your Find/Replace.</p>
	<p>You need to tell me the datatype of the id and search fields. I will be using <b>cfqueryparam</b> and need to know the datatype to do so.</p>
	<p>If you choose to proceed, I will perform the Find/Replace for real.</p>
	<p>I will do this for all the database records that match.</p>
	<cfdump var="#session.dbfrp.arrResults#">	
<cfelse>
	<h2>Step 3: <span class="bad">#attributes.err_msg#</span></h2>
</cfif>


<cfform action="#session.dbfrp.self#" method="post" name="dbform" id="dbform">

<cfinput type="text" name="xdb_dsn" value="#session.db_dsn#" size="40" passthrough="#readonlyPassthrough#">
<input type="hidden" name="db_dsn" value="#session.db_dsn#">
<label for="db_dsn">Datasource</label>
<br>
<br>

<cfinput type="text" name="xdb_table" value="#session.db_table#" size="40" passthrough="#readonlyPassthrough#">
<input type="hidden" name="db_table" value="#session.db_table#">
<label for="db_table">Table</label>
<br>
<br>

<cfinput type="text" name="xdb_id_field" value="#session.db_id_field#" size="40" passthrough="#readonlyPassthrough#">
<input type="hidden" name="db_id_field" value="#session.db_id_field#">
<cfselect name="xqueryparam_id_field" query="session.dbfrp.qParams" value="param" display="name" selected="#session.queryparam_id_field#" passthrough="#readonlyPassthrough#"></cfselect>
<input type="hidden" name="queryparam_id_field" value="#session.queryparam_id_field#">
<label for="db_id_field">ID Field and datatype</label> (unique ID or primary key field in table)
<br>
<br>

<cfinput type="text" name="xdb_search_field" value="#session.db_search_field#" size="40" passthrough="#readonlyPassthrough#">
<input type="hidden" name="db_search_field" value="#session.db_search_field#">
<cfselect name="xqueryparam_search_field" query="session.dbfrp.qParams" value="param" display="name" selected="#session.queryparam_search_field#" passthrough="#readonlyPassthrough#"></cfselect>
<input type="hidden" name="queryparam_search_field" value="#session.queryparam_search_field#">
<label for="db_search_field">Search Field and datatype</label> (field to use for find/replace)
<br>
<br>

<cfinput type="text" name="xmaxrows" value="#session.maxrows#" size="10" passthrough="#readonlyPassthrough#">
<input type="hidden" name="maxrows" value="#session.maxrows#">
<label for="maxrows">Max ## of rows to return for previwing</label>
<br>
<br>

<cfinput type="radio" name="xfindstyle" value="replace" checked="#iif(session.findstyle eq "replace",de("true"),de("false"))#" passthrough="#readonlyPassthrough#">
<label for="findstyle">replace</label>
<br>
<cfinput type="radio" name="xfindstyle" value="reReplace" checked="#iif(session.findstyle eq "reReplace",de("true"),de("false"))#" passthrough="#readonlyPassthrough#">
<label for="findstyle">reReplace (Regular Expression)</label>
<br>
<cfinput type="radio" name="xfindstyle" value="replaceNoCase" checked="#iif(session.findstyle eq "replaceNoCase",de("true"),de("false"))#" passthrough="#readonlyPassthrough#">
<label for="findstyle">replaceNoCase</label>
<br>
<cfinput type="radio" name="xfindstyle" value="reReplaceNoCase" checked="#iif(session.findstyle eq "reReplaceNoCase",de("true"),de("false"))#" passthrough="#readonlyPassthrough#">
<label for="findstyle">reReplaceNoCase (Regular Expression)</label>
<input type="hidden" name="findstyle" value="#session.findstyle#">
<br>
<br>

<cfinput type="text" name="xfindstring" value="#session.findstring#" size="40" passthrough="#readonlyFRPassthrough#">
<input type="hidden" name="findstring" value="#session.findstring#">
<label for="findstring">Find String</label>
<br>
<br>

<cfinput type="text" name="xreplacestring" value="#session.replacestring#" passthrough="#readonlyFRPassthrough#">
<input type="hidden" name="replacestring" value="#session.replacestring#">
<label for="replacestring">Replace String</label>
<br>
<br>

<input type="checkbox" name="xoverridescriptblock" value="true" #iif(session.overridescriptblock IS TRUE,de("checked"),de(""))# #readonlyFRPassthrough#> Treat <span class="highlight">&lt;invalidTag</span> as <span class="highlight">&lt;script</span>? (You'll know if you need this)
<input type="hidden" name="overridescriptblock" id="overridescriptblock" value="#session.overridescriptblock#">
<br>
<br>


<input type="hidden" id="dbformstep" name="dbformstep">
<input type="hidden" id="fuseaction" name="fuseaction">
<!---<input type="button" name="submitTryAgain" value="Try this step again" onClick="tryagain('#session.dbformstep#')">--->

<input type="button" name="back" value="Go back to previous step" onClick="history.go(-1)">
<input type="button" name="submitNextStep" value="Go to next step" onClick="trynext('#session.dbformstep#')">

</cfform>

</cfoutput>