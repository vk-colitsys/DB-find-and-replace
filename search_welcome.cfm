<!---
<fusedoc fuse="dsp_welcome.cfm">
	<responsibilities>
		I pretty much display the intro page for this app.
	</responsibilities>	
	<properties>

	</properties>
	<io>
		<in>
		</in>	
		<out>
		</out>
	</io>	
</fusedoc>
--->
<cfoutput>
<div id="cougar"><img src="cougarInDaHouse.JPG"><p>Now you are messin with real power.</p></div>
<p>Welcome. Do something useful.</p>
<ul>
<li>This application is intended to be used by system administrators or developers.</li>
<li>Never install this app in a publicly-accessible location.</li>
<li>This is not a generic data browsing app. You probably have tools to do that.</li>
<li>This app will write files to your filesystem, into the /backups subdirectory under this app's root.</li>
<li>Make a backup of your database before using this tool.</li>
<li>Once you do the find/replace for real, there will be an opportunity to undo what was done. There is, however, no guarantee any of this will work, so you really need to have a backup of your database before messing with this tool.<li>
<li>You need to have a ColdFusion DSN to the database, and rights to update data in the tables.</li>
<li>You need to know which field you want to modify, and the datatype.</li>
<li>There needs to be a unique ID or primary key field in there, too
<li>There is no database to install for this app, instead, it writes files out for backup purposes.</li>
<li>Do a backup of your database first. I can't emphasize that enough.</li>
<li>Use this entirely at your own risk.</li>
</ul>
</cfoutput>