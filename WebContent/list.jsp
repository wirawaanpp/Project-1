<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Show Database Application</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>	
body{
	background-image:linear-gradient(rgba(0,0,0,0.3),rgba(0,0,0,0.3)),url("IT.png");
	background-size:cover;
}

.nav{
	width: 85%;
	margin: auto;
	padding: 35px 0;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.logo{
	width: 60px;
	cursor: pointer;
}

.nav ul li{
	list-style: none;
	display: inline-block;
	margin: 0 20px;
	position: relative;
}

.nav ul li a{
	text-decoration: none;
	color: #fff;
	text-transform: uppercase;
}

.nav ul li::after{
	content: '';
	height: 3px;
	width: 0;
	background: #009688;
	position: absolute;
	left: 0;
	bottom: -5px;
	transition: 0.5s;
}

.nav ul li:hover::after{
	width: 100%;
}

</style>
</head>
<body>
	
	<header>
	<div class="nav">
	<img src="ats.png" class="logo">
		<ul>
			<li><a href="index.jsp">Home</a></li>
			<li><a href="<%=request.getContextPath()%>/list">List</a></li>
			<li><a href="#">About Us</a></li>
		</ul>
	</div>
	</header>
	

	<div class="row">
	<div class="container">
			<h3 class="text-center">List of Data</h3>
			<hr>
			<div class="container text-left">

				<a href="<%=request.getContextPath()%>/new" class="btn btn-success">Add
					New User</a>
			</div>
			<br>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Date</th>
						<th>City</th>
						<th>Status</th>
						<th>Operation</th>
					</tr>
				</thead>
				<tbody>
				
					<c:forEach var="task" items="${listTask}">

						<tr>
							<td><c:out value="${task.id}" /></td>
							<td><c:out value="${task.name}" /></td>
							<td><c:out value="${task.date}" /></td>
							<td><c:out value="${task.city}" /></td>
							<td><a href="view?id=<c:out value='${task.id}' />">view</a>
							<td><a href="edit?id=<c:out value='${task.id}' />">Edit</a>
								&nbsp;&nbsp;&nbsp;&nbsp; <a
								href="delete?id=<c:out value='${task.id}' />">Delete</a></td>
								
						</tr>
					</c:forEach>
					
				</tbody>
				
			</table>
			<input type="submit" value="Download PDF" name="download" onclick="window.print()" />
		</div>
	</div>
	 
</body>
</html>