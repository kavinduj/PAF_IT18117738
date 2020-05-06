 package com;

import java.sql.Statement;

import javax.servlet.http.HttpServlet;

import java.sql.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Hospital extends HttpServlet {
	
	private Connection connect() {
	Connection con = null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");

		// Provide the correct details: DBServer/DBName, username, password
		con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3308/paf", "root", "");
	} catch (Exception e) {
		e.printStackTrace();
	}
	return con;
	}
	
	public String insertHos(String HospitalName, String Email, String Address, String PhoneNumber, String Reg_Number)
	 {
	 String output = "";
	 try
	 {
	 Connection con = connect();
	 if (con == null)
	 {return "Error while connecting to the database for inserting."; }
	 // create a prepared statement
	 String query = " insert into registered_hospital(`Hospital_ID`,`HospitalName`,`Email`,`Address`,`PhoneNumber`,`Reg_Number`)"
	 + " values (?, ?, ?, ?, ?, ?)";
	 PreparedStatement preparedStmt = con.prepareStatement(query);
	 // binding values
	 preparedStmt.setInt(1, 0);
	 preparedStmt.setString(2, HospitalName);
	 preparedStmt.setString(3, Email);
	 preparedStmt.setString(4, Address);
	 preparedStmt.setString(5, PhoneNumber);
	 preparedStmt.setString(6, Reg_Number);
	
	 
	// execute the statement
	 preparedStmt.execute();
	 con.close();

		String newH = readHos();
		 output = "{\"status\":\"success\", \"data\": \"" +newH + "\"}"; 
		 
		//output = "Inserted successfully";
	} catch (Exception e) {
		output = "{\"status\":\"error\", \"data\":\"Error while inserting the item.\"}";
		//output = "Error while inserting the item.";
		System.err.println(e.getMessage());
	}
	return output;
	
	 } 

	


	
	
	public String readHos()
	 {
	 String output = "";
	 try
	 {
	 Connection con = connect();
	 if (con == null)
	 {return "Error while connecting to the database for reading."; }
	 // Prepare the html table to be displayed
	 output = "<table border=\"1\"><tr><th>Hospital_ID</th><th> HospitalName </th><th> Email </th><th> Address </th><th> PhoneNumber </th><th> Reg_Number </th> <th class=\"bg-secondary\"></th> <th class=\"bg-danger\">  </th></tr>";
	 String query = "select * from registered_hospital";
	 Statement stmt = con.createStatement();
	 ResultSet rs = stmt.executeQuery(query);
	 // iterate through the rows in the result set
	 while (rs.next())
	 {
		 String Hospital_ID = Integer.toString(rs.getInt("Hospital_ID"));
		 String HospitalName = rs.getString("HospitalName");
		 String Email = rs.getString("Email");
		 String Address = rs.getString("Address");		
		 String PhoneNumber = rs.getString("PhoneNumber");
		 String Reg_Number = rs.getString("Reg_Number");
			
		 //output += "<tr><td><input id='hidItemIDUpdate' name='hidItemIDUpdate' type='hidden' value='" + Reg_Number + "'>" + HospitalName + "</td>";
		 
		 // Add into the html table
		 //output += "<tr><td>" + Hospital_ID + "</td>";
		 output += "<tr><td><input id=\"hidItemIDUpdate\" value=\"" + Hospital_ID + "\" name=\"hidItemIdUpdate\" type=\"hidden\"> "+ Hospital_ID  +" </td>";
		 output += "<td>" + HospitalName + "</td>";
		 output += "<td>" + Email + "</td>";
		 output += "<td>" + Address + "</td>";
		 output += "<td>" + PhoneNumber + "</td>";
		 output += "<td>" + Reg_Number + "</td>";

		 
			output += "<td><input name='btnUpdate' type='button' value='Update' class='btnUpdate btn btn-secondary'></td><td><input name='btnRemove' type='button' value='Remove' class='btnRemove btn btn-danger' data-hosid='"
					 + Hospital_ID + "'>" + "</td></tr>";

	 }
	 con.close();
	 // Complete the html table
	 output += "</table>";
	 }
	 catch (Exception e)
	 {
	 output = "Error while getting hospitals.";
	 System.err.println(e.getMessage());
	 }
	 return output;
	 } 
	
	
	
	
	public String updateHos(String Hospital_ID, String HospitalName, String Email, String Address, String PhoneNumber, String Reg_Number)
	 {
	 String output = "";
	 try
	 {
	 Connection con = connect();
	 if (con == null)
	 {return "Error while connecting to the database for updating."; }
	 // create a prepared statement
	 String query = "UPDATE registered_hospital SET HospitalName=?,Email=?,Address=?,PhoneNumber=?,Reg_Number=?WHERE Hospital_ID=?";
	 
	 PreparedStatement preparedStmt = con.prepareStatement(query);
	 // binding values
	 preparedStmt.setString(1, HospitalName);
	 preparedStmt.setString(2, Email);
	 preparedStmt.setString(3, Address);
	 preparedStmt.setString(4, PhoneNumber);
	 preparedStmt.setString(5, Reg_Number);
	 preparedStmt.setInt(6,Integer.parseInt(Hospital_ID));
	 // execute the statement
	 preparedStmt.execute();
	 con.close();
	 
	 
		//output = "Updated successfully";
		String newH = readHos();
		 output = "{\"status\":\"success\", \"data\": \"" +newH + "\"}";
		
	} catch (Exception e) {
		output = "{\"status\":\"error\", \"data\":\"Error while updating the item.\"}";
		//output = "Error while updating the item.";
		System.err.println(e.getMessage());
	}
	return output;
}
	
	
	
	public String deleteHos(String Hospital_ID)
	 {
	 String output = "";
	 try
	 {
	 Connection con = connect();
	 if (con == null)
	 {return "Error while connecting to the database for deleting."; }
	 // create a prepared statement
	 String query = "delete from registered_hospital where Hospital_ID=?";
	 PreparedStatement preparedStmt = con.prepareStatement(query);
	 // binding values
	 preparedStmt.setInt(1, Integer.parseInt(Hospital_ID));
	 // execute the statement
	 preparedStmt.execute();
	 con.close();
		//output = "Deleted successfully";
		String newH = readHos();
		 output = "{\"status\":\"success\", \"data\": \"" +newH + "\"}";
		
	} catch (Exception e) {
		output = "{\"status\":\"error\", \"data\":\"Error while deleting the hospital.\"}";
		//output = "Error while deleting the item.";
		System.err.println(e.getMessage());
	}
	return output;
}

	
	

	
	
}
