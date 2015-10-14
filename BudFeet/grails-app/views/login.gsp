<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<title>Login Page</title>
		<meta name="layout" content="main">
	</head>
	<body>
		<div class="col-md-4"></div>
		<div class="col-md-4" style="padding:20px;">
			<div id="errors" style="color:red;font-size:1.2em;padding:20px;text-align:center;">
				<%= errorMsg %>
			</div>
			<g:form action="login" controller="login">
			  <div class="form-group">
			    <label for="name">Name</label>
			    <g:textField name="name" type="text" class="form-control" placeholder="Name"/>
			  </div>
			  <div class="form-group">
			    <label for="password">Password</label>
			    <g:passwordField name="password" type="password" class="form-control" placeholder="Password"/>
			  </div>
			  <input type="submit" class="btn btn-default" value="Login">
			</g:form>
		</div>
		<div class="col-md-4"></div>
	</body>
</html>