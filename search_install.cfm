<!---
<fusedoc fuse="dsp_install.cfm">
	<responsibilities>
		I display the contents of INSTALL.txt
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
<cfset session.dbformstep = 0>
<h2>Installation</h2>
<cffile action="read" file="INSTALL.txt" variable="filetxt">
<cfoutput>
<cfloop list="#filetxt#" delimiters="#chr(10)#" index="i">
#i#<br>
</cfloop>
</cfoutput>