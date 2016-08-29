<!---
<fusedoc fuse="act_step_3.cfm">
	<responsibilities>
	I will give your find/select a go.
	For each record I find, I'll stuff something into session.dbfrp.arrResults.
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
			<boolean name="overridescriptblock" scope="session"/>			
		</in>	
		<out>
			<array name="dbfrp.arrResults" scope="request"/>
			<string name="err_msg" scope="attributes"/>
			<array name="dbfrp.arrResults" scope="request"/>
		</out>
	</io>	
</fusedoc>
--->

<cfset session.findstring = replaceBlocked(session.overridescriptblock,session.findstring)>
<cfset session.replacestring = replaceBlocked(session.overridescriptblock,session.replacestring)>

<!--- First just get the IDs --->
<cftry>	
<cfquery name="qTryFind" datasource="#session.db_dsn#">
	SELECT
	#session.db_id_field# AS id
	FROM
	#session.db_table#
</cfquery>
<cfcatch type="Database">
	<cfset attributes.err_msg="
	SELECT
	#session.db_id_field# AS id
	FROM
	#session.db_table#
</pre> DB Error. Either the table or field does not exist.">
</cfcatch>
</cftry>

<cfif len(attributes.err_msg) EQ 0>
	<cfif qTryFind.recordcount EQ 0>
		<cfset attributes.err_msg = "No records found [qTryFind]">
	</cfif>	
</cfif>	

<cfif len(attributes.err_msg) EQ 0>
	<!--- create array to hold our results. --->
	<cfset session.dbfrp.arrResults = arrayNew(1)>
	<cfset foundIndex = 1>
	<!--- Now we will do a loop over those IDs and query for each one individually.
	Why? Because I have no idea how many records exist, nor do I know the real volume
	of data returned. I don't want to conk out somebody's system on this. --->
	<cfloop query="qTryFind">
		<cfset thisId = qTryFind.id>
		<cftry>
		<cfquery name="qResults" datasource="#session.db_dsn#">
		SELECT
		#session.db_search_field# AS search_field
		FROM
		#session.db_table#
		WHERE
		#session.db_id_field#
		=
		<cfqueryparam
			CFSQLType="#session.queryparam_id_field#"
			value="#thisId#" />
		</cfquery>
		<cfcatch type="Database">
			<cfset attributes.err_msg="DB Error, most likely datatype mismatch on the ID field.">
			<cfbreak>
		</cfcatch>
		</cftry>
		
		
		<cfset search_field = qResults.search_field>
		
		<cfswitch expression="#session.findstyle#">
	
			<cfcase value="replace">
				<cfset exists=find(session.findstring,search_field)>
				<cfset result=replace(search_field,session.findstring,session.replacestring,"all")>
				
			</cfcase>
		
			<cfcase value="reReplace">
				<cfset exists=reFind(session.findstring,search_field)>
				<cfset result=reReplace(search_field,session.findstring,session.replacestring,"all")>
			</cfcase>
	
			<cfcase value="replaceNoCase">
				<cfset exists=findNoCase(session.findstring,search_field)>
				<cfset result=replaceNoCase(search_field,session.findstring,session.replacestring,"all")>
				
			</cfcase>
		
			<cfcase value="reReplaceNoCase">
				<cfset exists=reFindNoCase(session.findstring,search_field)>
				<cfset result=reReplaceNoCase(search_field,session.findstring,session.replacestring,"all")>
			</cfcase>
			
		</cfswitch>
				
		<cfif val(exists) GT 0>
			<cfset session.dbfrp.arrResults[foundIndex] = structNew()>
			<cfset session.dbfrp.arrResults[foundIndex].id = thisId>
			<cfset session.dbfrp.arrResults[foundIndex].before = search_field>
			<cfset session.dbfrp.arrResults[foundIndex].after = result>		
			<cfset foundIndex = foundIndex + 1>	
		</cfif>
	
	</cfloop>
	<!--- If 0 results, roll the step back 1 --->
	<cfif len(attributes.err_msg) EQ 0>
		<cfif arrayLen(session.dbfrp.arrResults) EQ 0>
			<cfset attributes.err_msg="No records returned.">
		</cfif>
	</cfif>
</cfif>

<cfif len(attributes.err_msg) GT 0>
	<cfset session.dbformstep = session.dbformstep - 1>
</cfif>