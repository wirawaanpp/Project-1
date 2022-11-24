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
	background-image:linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)),url("IT.png");
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
		<li><a href="<%=request.getContextPath()%>/list">Context</a></li>
		<li><a href="#">About Us</a></li>
	</ul>
</div>

</header>
<br>
	<div class="container col-md-5">
		<div class="card">
			<div class="card-body">
				<c:if test="${task != null}">
					<form action="update" method="post">
				</c:if>
				<c:if test="${task == null}">
					<form action="insert" method="post">
				</c:if>

				<caption>
				<h2>
						<c:if test="${task != null}">
            			Edit 
            		</c:if>
						<c:if test="${task == null}">
            			Add New 
            		</c:if>
					</h2>
				</caption>
								<c:if test="${task != null}">
					<input type="hidden" name="id" value="<c:out value='${task.id}' />" />
				</c:if>

				<fieldset class="form-group">
					<label>Name</label> <input type="text"
						value="<c:out value='${task.name}' />" class="form-control"
						name="name" required="required">
				</fieldset>

				<fieldset class="form-group">
					<label>Email</label> <input type="text"
						value="<c:out value='${task.email}' />" class="form-control"
						name="email">
				</fieldset>

				<fieldset class="form-group">
					<label>Address</label> <input type="text"
						value="<c:out value='${task.address}' />" class="form-control"
						name="address">
				</fieldset>
				
				<fieldset class="form-group">
					<label>Phone</label> <input type="text"
						value="<c:out value='${task.phone}' />" class="form-control"
						name="phone">
				</fieldset>
				
				<fieldset class="form-group">
					<label>City</label> <input type="text"
						value="<c:out value='${task.city}' />" class="form-control"
						name="city">
				</fieldset>
				
				<fieldset class="form-group">
					<label>Country</label> <input type="text"
						value="<c:out value='${task.country}' />" class="form-control"
						name="country">
				</fieldset>
				
				<fieldset class="form-group">
					<label>Education</label> <input type="text"
						value="<c:out value='${task.education}' />" class="form-control"
						name="education">
				</fieldset>
				
				<fieldset class="form-group">
					<label>Photo</label> <input type="file"
						value="<c:out value='${task.photo}' />" class="form-control"
						name="photo">
					<img src="getimage?id=<c:out value='${task.id}' />"width="125" height ="125"  border="1">
				</fieldset>
				
				<button type="submit" class="btn btn-success">Save</button>
				</form>
				<input type="submit" value="Download PDF" name="download" onclick="window.print()" /> 
			</div>
		</div>
	</div>
	
	
</body>
</html>