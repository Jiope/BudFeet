<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<title>My Account</title>
		<asset:stylesheet src="calendar.css"/>
		<asset:link rel="" href=""/>
		<meta name="layout" content="main">
		
	</head>
	<body>
	
	<table class="dataLoupe">
		<tr>
		  <td>Name :</td>
		  <td>${user.name}</td>
		</tr>
		<tr>
		  <td>Birthday :</td>
		  <td>${user.birthday}</td>
		</tr>
		<tr>
		  <td>Email :</td>
		  <td>${user.email}</td>
		</tr>
		<tr>
		  <td>Identifier :</td>
		  <td>${user.id}</td>
		</tr>
	</table>
	
	</body>
</html>