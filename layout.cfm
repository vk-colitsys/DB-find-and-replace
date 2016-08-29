<cfoutput><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>#session.dbfrp.apptitle#</title>
	<link rel="Stylesheet" href="layout.css">
	
	<script type="text/javascript" language="javascript">
	tryagain = function(formstep){
		var fuseaction = 'main.submitform_step_' + formstep;
		var target = document.getElementById('dbform');
		document.getElementById('dbformstep').value = formstep;
		document.getElementById('fuseaction').value = fuseaction;
		if(target.onsubmit()){
		 	target.submit();
		 }
	}
	trynext = function(formstep){
		var nextstep = parseInt(formstep) + 1;
		var fuseaction = 'main.submitform_step_' + nextstep;
		var target = document.getElementById('dbform');
		document.getElementById('dbformstep').value = nextstep;
		document.getElementById('fuseaction').value = fuseaction;
		if(target.onsubmit()){
		 	target.submit();
		 }
	}
	setFuseaction = function(fuseaction){
		var target = document.getElementById('dbform');
		document.getElementById('fuseaction').value = fuseaction;
		if(target.onsubmit()){
		 	target.submit();
		 }
	}

	</script>
</head>
<body>
<div id="header">
	<a href="#session.dbfrp.self#?fuseaction=main.welcome" class="headline">#session.dbfrp.apptitle#</a>
	<span class="nav">
		<a href="#session.dbfrp.self#?fuseaction=main.install">Installation</a>
		&curren;
		<a href="#session.dbfrp.self#?fuseaction=main.explore">DB Explore</a>
		&curren;
		<a href="#session.dbfrp.self#?fuseaction=main.how">How to use</a>
		&curren;
		<a href="#session.dbfrp.self#?fuseaction=main.about">About</a>
	</span>
</div>	

<cfif session.dbformstep GT 0>
	<div id="statusbar">	
		<cfloop from="1" to="5" index="i">
			<span class="#iif(session.dbformstep eq i,de("status_highlighted"),de("status"))#">
				#session.dbfrp.steplist[i].name#
				<cfif session.dbformstep eq i>
					: #session.dbfrp.steplist[1].description#
				</cfif>
			</span>
		</cfloop>
	</div>
</cfif>

<div id="content">
	#fusebox.layout#
	<div style="clear: both;"></div>
</div>

<div id="footer">

	<!--- uncomment to debug
	<cfoutput><cfdump var="#application#"><cfdump var="#session#"><cfdump var="#attributes#"></cfoutput>
	--->
</div>
</body>
</html></cfoutput>