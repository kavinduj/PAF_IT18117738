<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.Hospital"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Hospital Management</title>
<link rel="stylesheet" href="Views/bootstrap.min.css">
<script src="Components/jquery-3.4.0.min.js"></script>
<script src="Components/Hos.js"></script> 
</head>
<body>

	<div class="container">
		

				<h1><center>Hospital Management</center></h1>

				<form id="formHospital" name="formHospital" method="post" action="hos.jsp">
				
					Hospital Name : <input id="HospitalName" name="HospitalName" type="text"
						class="form-control form-control-sm"> <br> 
					Email : <input id="Email" name="Email" type="text"
						class="form-control form-control-sm"> <br> 
					Address : <input id="Address" name="Address" type="text"
						class="form-control form-control-sm"> <br> 
					PhoneNumber : <input id="PhoneNumber" name="PhoneNumber" type="text"
						class="form-control form-control-sm"> <br> 
					Reg_Number : <input id="Reg_Number" name="Reg_Number" type="text"
						class="form-control form-control-sm"> <br>
					
					<center>	
					<div class="w-25">
					 	<center><input id="btnSave" class="btn btn-primary btn-block" name="btnSave" type="button" value="Save"
						class="btn btn-primary"> <input type="hidden"
						id="hidItemIDSave" name="hidItemIDSave" value=""></center>
						</div>
				</form>

				<div id="alertSuccess" class="alert alert-success"></div>
				<div id="alertError" class="alert alert-danger"></div>
				<br>
				
				<center>
					<div id="divItemsGrid">
					<%
					Hospital hosobj = new Hospital();
					out.print(hosobj.readHos());
					%>
				</div>
				</center>
		
				

</body>
</html>