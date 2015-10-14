<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<title>Register Page</title>
		<meta name="layout" content="main">
	</head>
	<body>
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<g:form action="register" controller="login">
			  <div class="form-group">
			    <label for="name">Name</label>
			    <g:textField name="name" type="text" class="form-control" placeholder="Name"/>
			  </div>
			  <div class="form-group">
			    <label for="password">Password</label>
			    <g:passwordField name="password" type="password" class="form-control" placeholder="Password"/>
			  </div>
			  <div class="form-group">
			  	<label for="birthday">Birthday</label>
			  	<g:datePicker name="birthday" value="${new Date()}" precision="day" years="${1930..2015}"/>
			  </div>
			  <div class="form-group">
			  	<label for="email">Mail Address</label>
			  	<g:textField name="email" type="text" class="form-control" placeholder="Mail Address"/>
			  </div>
			  <input type="submit" class="btn btn-default" value="Register">
			</g:form>
		</div>
		<div class="col-md-2"></div>
	</body>
</html>
