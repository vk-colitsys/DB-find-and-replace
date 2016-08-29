<!---
<fusedoc fuse="act_step_4.cfm">
	<responsibilities>
		I do the for-real Find/Replace.
	</responsibilities>	
	<properties>

</properties>
	<io>
		<in>
			<array name="dbfrp.arrResults" scope="request"/>
			<string name="db_id_field" scope="session"/>
			<string name="db_search_field" scope="session"/>
			<string name="db_table" scope="session"/>
			<string name="db_dsn" scope="session"/>
			<string name="queryparam_id_field" scope="session"/>
			<string name="queryparam_search_field" scope="session"/>
			<string name="dbfrp.timestamp" scope="request"/>
			<array name="dbfrp.arrResults" scope="request"/>
			<string name="err_msg" scope="attributes"/>
			<boolean name="overridescriptblock" scope="session"/>						
		</in>	
		<out>
			<array name="dbfrp.arrResults" scope="request"/>
			<string name="err_msg" scope="attributes"/>
			<file name="#expandPath('backups')#/#session.dbfrp.timestamp#.xml">
			<file name="#expandPath('backups')#/#session.dbfrp.timestamp#-#i#.txt">
			<query name="qAfterResults/">
		</out>
	</io>	
</fusedoc>
--->
<cfset session.findstring = replaceBlocked(session.overridescriptblock,session.findstring)>
<cfset session.replacestring = replaceBlocked(session.overridescriptblock,session.replacestring)>

<cfif len(attributes.err_msg) gt 0>
	<!--- argh. --->
<cfelseif arrayLen(session.dbfrp.arrResults) EQ 0>
	<!--- argh. --->
	<cfset attributes.err_msg = "arrayLen(session.dbfrp.arrResults) EQ 0. I guess your find/replace returned nothing.">
<cfelse>
	<cftransaction action = "begin">
	<cfloop from="1" to="#arrayLen(session.dbfrp.arrResults)#" index="i">
		<!--- First off, get the original db field --->
		<cftry>	
		<cfquery name="qOriginalField" datasource="#session.db_dsn#">
			SELECT
			#session.db_search_field# AS search_field
			FROM
			#session.db_table#
			WHERE
			#session.db_id_field#
			=
			<cfqueryparam
				CFSQLType="#session.queryparam_id_field#"
				value="#session.dbfrp.arrResults[i].id#" />
		</cfquery>
		<cfcatch type="Database">
			<cfset attributes.err_msg="DB Error, most likely datatype mismatch on the ID field.">
			<cfbreak>
		</cfcatch>
		</cftry>
		<!--- first time through? If you made it this far there wasn't a db error,
		so write out the metadata we'll need to do a restore to an .xml file --->
		
		<cfif i EQ 1>
			<cfset dbattribs = structNew()>
			<cfset dbattribs.timestamp = session.dbfrp.timestamp>
			<cfset dbattribs.db_dsn = session.db_dsn>
			<cfset dbattribs.db_table = session.db_table>
			<cfset dbattribs.db_id_field = session.db_id_field>
			<cfset dbattribs.db_search_field = session.db_search_field>
			<cfset dbattribs.queryparam_id_field = session.queryparam_id_field>
			<cfset dbattribs.queryparam_search_field = session.queryparam_search_field>
			<cfset dbattribs.arrIDs = arrayNew(1)>
		</cfif>
		
		<!--- Stuff the actual id into our array. Why?
		Well, originally, I was going to incorporate the field ID value into the
		resulting filename, then use that filename to reconsititue the field id.
		Thing is, I have no assurance the field ID will result in a valid filename,
		so the safe thing to do is to instead carry that informatin within our metadata .xml file. --->
		<cfset dbattribs.arrIDs[i] = session.dbfrp.arrResults[i].id>
		
		<!--- Write out each query row to the "/backups" dir as a .txt file--->
		<cfset fRowName="#expandPath('backups')#/#session.dbfrp.timestamp#-#i#.txt">
		<cffile action="write" output="#qOriginalField.search_field#" file="#fRowName#">
		
		<!--- Do the update --->
		<cfset search_field = qOriginalField.search_field>
		
		<cfswitch expression="#session.findstyle#">
	
			<cfcase value="replace">
				<cfset result=replace(search_field,session.findstring,session.replacestring,"all")>
			</cfcase>
		
			<cfcase value="reReplace">
				<cfset result=reReplace(search_field,session.findstring,session.replacestring,"all")>
			</cfcase>
	
			<cfcase value="replaceNoCase">
				<cfset result=replaceNoCase(search_field,session.findstring,session.replacestring,"all")>				
			</cfcase>
		
			<cfcase value="reReplaceNoCase">
				<cfset result=reReplaceNoCase(search_field,session.findstring,session.replacestring,"all")>
			</cfcase>
			
		</cfswitch>
		<cftry>
		<cfquery name="qUpdateField" datasource="#session.db_dsn#">
			UPDATE
			#session.db_table#
			SET
			#session.db_search_field#
			=
			<cfqueryparam
				CFSQLType="#session.queryparam_search_field#"
				value="#result#" />
			WHERE
			#session.db_id_field#
			=
			<cfqueryparam
				CFSQLType="#session.queryparam_id_field#"
				value="#session.dbfrp.arrResults[i].id#" />
		</cfquery>
		<cfcatch type="Database">
			<cfset attributes.err_msg="DB Error, most likely datatype mismatch on the search field.">
			<cfbreak>
		</cfcatch>
		</cftry>
	</cfloop>

	<cfif len(attributes.err_msg) EQ 0>
		<cftransaction action="commit"/>
		<cfset attributes.fXMLName="#expandPath('backups')#/#session.dbfrp.timestamp#.xml">
		<!--- do a little path separator flippin' --->
		<cfif variables.fuseboxOSName contains "Windows">
			<cfset attributes.fXMLName=replace(attributes.fXMLName,"/","\","All")>
		<cfelse>
			<cfset attributes.fXMLName=replace(attributes.fXMLName,"\","/","All")>
		</cfif>	
		
		<cfwddx action="cfml2wddx" input="#dbattribs#" output="wddx_dbattribs">
		<!--- Write out our .xml file to the "/backups" dir --->
		<cffile action="write" output="#wddx_dbattribs#" file="#attributes.fXMLName#">
		
	<cfelse>
		  <cftransaction action="rollback"/>
	</cfif>
	</cftransaction>

</cfif>

<!--- If all went well, let's run a query to grab the results. This way you can see for yourself. No doubts. --->
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
				value="#arrayToList(dbattribs.arrIDs)#"
			    list="True"/>
			 )
		</cfquery>

		<cftry>	
		
		<cfcatch type="Database">
			<cfset attributes.err_msg="The Find/Replace is done, but I threw a DB error while trying to returnthe results to you.">
		</cfcatch>
		</cftry>
</cfif>