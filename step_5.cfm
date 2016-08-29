<!---
<fusedoc fuse="act_step_5.cfm">
	<responsibilities>
		I'm doing the UNDO.
	</responsibilities>	
	<properties>

</properties>
	<io>
		<in>
			<string name="timestamp" scope="attributes"/>
			<array name="dbfrp.arrResults" scope="request"/>
			<string name="err_msg" scope="attributes"/>
			<file name="#expandPath('backups')#/#session.dbfrp.timestamp#.xml">
			<file name="#expandPath('backups')#/#session.dbfrp.timestamp#-#i#.txt">			
		</in>	
		<out>
			<string name="err_msg" scope="attributes"/>
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
			<query name="qAfterResults"/>
		</out>
	</io>	
</fusedoc>
--->

<cfset fXMLName="#expandPath('backups')#/#session.timestamp#.xml">

<!--- do a little path separator flippin' --->
<cfif variables.fuseboxOSName contains "Windows">
	<cfset fXMLName=replace(fXMLname,"/","\","All")>
<cfelse>
	<cfset fXMLName=replace(fXMLname,"\","/","All")>
</cfif>	

<!--- Read in our .xml file to the "/backups" dir --->
<cffile action="read" file="#fXMLName#" variable="wddx_dbattribs">

<!--- Reconsititue back to a struct --->
<cfwddx action="wddx2cfml" input="#wddx_dbattribs#" output="session.dbfrp.dbattribs">
<!--- And get our variables back. --->
<cfset session.db_dsn = session.dbfrp.dbattribs.db_dsn>
<cfset session.db_id_field = session.dbfrp.dbattribs.db_id_field>
<cfset session.db_search_field  = session.dbfrp.dbattribs.db_search_field>
<cfset session.queryparam_id_field = session.dbfrp.dbattribs.queryparam_id_field>
<cfset session.queryparam_search_field  = session.dbfrp.dbattribs.queryparam_search_field>
<cfset session.db_table = session.dbfrp.dbattribs.db_table>
<cfset session.timestamp = session.dbfrp.dbattribs.timestamp>

<cfset fXMLName="#expandPath('backups')#/#session.dbfrp.timestamp#.xml">
<!--- do a little path separator flippin' --->
<cfif variables.fuseboxOSName contains "Windows">
	<cfset fXMLName=replace(fXMLname,"/","\","All")>
<cfelse>
	<cfset fXMLName=replace(fXMLname,"\","/","All")>
</cfif>	


<!--- If 0 results, we ain't doin' nuthin'. --->
<cfif arrayLen(session.dbfrp.dbattribs.arrIDs) EQ 0>
	<cfset attributes.err_msg = "arrayLen(session.dbfrp.dbattribs.arrIDs) eq 0">
</cfif>

<cfif len(attributes.err_msg) EQ 0>
	<cftransaction action = "begin">

	<cfset sqlType = "#session.queryparam_id_field#">
	<cfloop from="1" to="#arrayLen(session.dbfrp.dbattribs.arrIDs)#" index="i">
		

		<!--- get name of this row's .txt backup file --->
		<cfset fRowName="#expandPath('backups')#/#session.dbfrp.dbattribs.timestamp#-#i#.txt">
		<!--- do a little path separator flippin' --->
		<cfif variables.fuseboxOSName contains "Windows">
			<cfset fRowName=replace(fRowName,"/","\","All")>
		<cfelse>
			<cfset fRowName=replace(fRowName,"\","/","All")>
		</cfif>	

		<!--- Read in the .txt file --->
		<cffile action="read" file="#fRowName#" variable="originalData" />
		<cftry>
		<!--- First off, get the original db field --->
		<cfquery name="qRestoreField" datasource="#session.db_dsn#">
			UPDATE
			#session.db_table#
			SET
			#session.db_search_field#
			=
			<cfqueryparam
				CFSQLType="#session.queryparam_search_field#"
				value="#originalData#" />
			WHERE
			#session.db_id_field#
			=
			<cfqueryparam
				CFSQLType="#session.queryparam_id_field#"
				value="#session.dbfrp.dbattribs.arrIDs[i]#" />
		</cfquery>
		<cfcatch type="Database">
			<cfset attributes.err_msg="DB Error, could not do the undo.">
			<cfrethrow>
			<cfbreak>
		</cfcatch>
		</cftry>
	</cfloop>

	<cfif len(attributes.err_msg) EQ 0>
		<cftransaction action="commit"/>
	<cfelse>
		<cftransaction action="rollback"/>
	</cfif>

	</cftransaction>

</cfif>

<cfif len(attributes.err_msg) EQ 0>
		<cfquery name="qAfterResults" datasource="#session.db_dsn#">
			SELECT
			#session.db_id_field#
			,
			#session.db_search_field#
			FROM
			#session.db_table#
			WHERE
			#session.db_id_field#
			IN
			(
			<cfqueryparam
				CFSQLType="#session.queryparam_id_field#"
				value="#arrayToList(session.dbfrp.dbattribs.arrIDs)#"
			    list="True"/>
			 )
		</cfquery>

		<cftry>	
		
		<cfcatch type="Database">
			<cfset attributes.err_msg="The Find/Replace is done, but I threw a DB error while trying to returnthe results to you.">
		</cfcatch>
		</cftry>
</cfif>