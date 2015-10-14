<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<title>Fit Me Motherfucker !</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<!-- JQuery -->
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
		
		<!-- Bootstrap -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
		
		<!-- Custom CSS -->
		<asset:stylesheet src="main.css"/>
		
		<g:layoutHead/>
	</head>
	<body>
		<div class="body container-fluid">
	
	      <header class="row">
	        <div class="col-xs-12 col-sm-12 col-md-12">
	          <div class="header"></div>
	        </div>
	      </header>
	
	      <div class="row navigation">
	        <div class="col-xs-12 col-sm-12 col-md-12">
              <div>
              	<g:link controller="login" action="index" class="btn btn-default btn-circle">Login</g:link>
              	<g:link controller="login" action="signup" class="btn btn-default btn-circle">Register</g:link>
              	<g:link controller="navigation" action="calendar" class="btn btn-default btn-circle">Calendar</g:link>
              	<g:link controller="navigation" action="settings" class="btn btn-default btn-circle">Settings</g:link>
              	<g:link controller="login" action="account" class="btn btn-default btn-circle">Account</g:link>
              	<g:link controller="login" action="logout" class="btn btn-default btn-circle">Logout</g:link>
              </div>
            </div>
          </div>
	          
          <div class="row">
          	<div class="col-xs-2 col-sm-2 col-md-2" style="height:700px;background-color:#f1f1f1">
	        </div>
	        <div class="col-xs-8 col-sm-8 col-md-8" style="height:700px">
	          <g:layoutBody/>
	        </div>	
	      	<div class="col-xs-2 col-sm-2 col-md-2" style="height:700px;background-color:#f1f1f1">
	      	</div>
	      </div>
	        
	
	      <footer class="row footer">
	        <div class="col-xs-12 col-sm-12 col-md-12">
	        	WebApp by Jiope
	        </div>
	      </footer>
	
	    </div>
	</body>
</html>
