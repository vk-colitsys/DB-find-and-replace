<!---
<fusedoc fuse="FBX_Settings.cfm">
	<responsibilities>
		I set up the enviroment settings for this circuit. If this settings file is being inherited, then you can use CFSET to override a value set in a parent circuit or CFPARAM to accept a value set by a parent circuit
	</responsibilities>	
</fusedoc>
--->

<cfset fusebox.suppressErrors = false>

<!--- In case no fuseaction was given, I'll set up one to use by default. --->
<cfparam name="attributes.fuseaction" default="main.welcome">

<!---
cfset Uncomment this if you wish to have code specific that only executes if the circuit running is the home circuit.
<cfif fusebox.IsHomeCircuit>
	<!--- put settings here that you want to execute only when this is the application's home circuit (for example "<cfapplication>" )--->
<cfelse>
	<!--- put settings here that you want to execute only when this is not an application's home circuit --->
</cfif>

--->
<cfapplication name="dbfrp"
	scriptprotect="none"
		sessionmanagement="true">


<cfset attributes.err_msg = "">	
<cfif isDefined("url.reinit")>
	<cfset structClear(session)>
</cfif>
	

<cfif NOT isDefined("session.dbfrp")>
	<cfset session.dbfrp = structNew()>
	<cfset session.dbfrp.self = "index.cfm">
	<cfset session.dbfrp.apptitle = "db find &amp; replace">
	<cfset session.dbfrp.timestamp = "#dateFormat(now(),"yyyymmdd")##timeformat(now(),"hhmmssL")#">
	<cfset session.dbfrp.ignorestring="C1132A9316AEFBEDA4546F99C7A1F68042C88E414289C54C98969BCA210F4DBA">
	<cfscript>
		session.dbfrp.steplist = arrayNew(1);
		session.dbfrp.steplist[1]=structNew();
		session.dbfrp.steplist[1].name="Step 1";
		session.dbfrp.steplist[1].description="DB Settings";
		session.dbfrp.steplist[2]=structNew();
		session.dbfrp.steplist[2].name="Step 2";
		session.dbfrp.steplist[2].description="Find/Replace Settings";
		session.dbfrp.steplist[3]=structNew();
		session.dbfrp.steplist[3].name="Step 3";
		session.dbfrp.steplist[3].description="Verify Find/Replace";
		session.dbfrp.steplist[4]=structNew();
		session.dbfrp.steplist[4].name="Step 4";
		session.dbfrp.steplist[4].description="Find/Replace Complete";
		session.dbfrp.steplist[5]=structNew();
		session.dbfrp.steplist[5].name="";
		session.dbfrp.steplist[5].description="Undo (if needed)";
		session.dbfrp.steplist[6]=structNew();
		session.dbfrp.steplist[6].name="";
		session.dbfrp.steplist[6].description="Clear the old stuff out?";
	</cfscript>
	<cfset session.dbfrp.qParams = queryNew("name,param")>
	<cfloop index="i" list="BIGINT,BIT,CHAR,BLOB,CLOB,DATE,DECIMAL,DOUBLE,FLOAT,IDSTAMP,INTEGER,LONGVARCHAR,MONEY,MONEY4,NUMERIC,REAL,REFCURSOR,SMALLINT,TIME,TIMESTAMP,TINYINT,VARCHAR">
		<cfset queryAddRow(session.dbfrp.qParams)>
		<cfset querySetCell(session.dbfrp.qParams,"name",i)>
		<cfset querySetCell(session.dbfrp.qParams,"param","CF_SQL_#i#")>	
	</cfloop>
	<cfset session.db_type = "mysql"><!--- mysql,mssql. really comes into play in act_explore.cfm --->
	<cfset session.db_dsn = "">
	<cfset session.db_table = "">
	<cfset session.db_id_field = "">
	<cfset session.db_search_field = "">
	<cfset session.dbformstep = "0">
	<cfset session.findstring = "">
	<cfset session.replacestring = "">
	<cfset session.findstyle = "replaceNoCase">
	<cfset session.testmode = "1">
	<cfset session.queryparam_id_field = "CF_SQL_INTEGER">
	<cfset session.queryparam_search_field = "CF_SQL_VARCHAR">
	<cfset session.maxrows = "10">
	<cfset session.overridescriptblock = "false">	
</cfif>

<cfloop index="i" list="db_type,db_dsn,db_table,db_id_field,db_search_field,dbformstep,findstring,replacestring,findstyle,testmode,queryparam_id_field,queryparam_search_field,maxrows,overridescriptblock">
	<cfif isDefined("attributes[i]")>
		<cfset session[i] = attributes[i]>
	</cfif>
</cfloop>


<!--- UDFs --->
<cfscript>
function replaceBlocked(toggle,str){
	var result = str;
	if(toggle IS TRUE){
		result=replace(str,"<invalidTag","<script","ALL");
	}
	return result;
}
</cfscript>