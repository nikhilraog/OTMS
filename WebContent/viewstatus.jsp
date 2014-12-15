<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><%@ page import="javax.sql.*" %>
<html>
<head><title>Enter to database</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	
</head>
<body>
<div class="pull-right">

		<form action="logout" method="get">
			<input type="submit" class="btn btn-default btn-sm btn-primary"
				value="Logout">
		</form>
	</div>
	<a class="pull-right " href="client_home.jsp">
		<button type="button" class="btn btn-default btn-sm btn-primary">Home</button>
	</a>

<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*;" %>
<%

java.sql.Connection con;
java.sql.Statement s;
java.sql.ResultSet rs;
java.sql.PreparedStatement pst;

con=null;
s=null;
pst=null;
rs=null;

HttpSession s1 = request.getSession();
String client_id= s1.getAttribute("Client_name").toString();

// Remember to change the next line with your own environment 
String url= 
"jdbc:mysql://localhost/oil";
String id= "root";
String pass = "";
try{

Class.forName ("com.mysql.jdbc.Driver").newInstance ();
con = java.sql.DriverManager.getConnection(url, id, pass);

}catch(ClassNotFoundException cnf){
out.print("Error on mysql - ask admin 1800-(oil)-(tran)");
cnf.printStackTrace();
}


String sql = "SELECT date,t.id transaction_id,t.quantity,(CASE WHEN buy_sell like 'b%' THEN \"Bought\" ELSE \"Sold\" END) As Buy_Sell, t.cost_of_transaction,h.com_charge, (CASE WHEN comtype <> 0 THEN 'Cash' ELSE 'Oil' END) As Comission_Mode,\r\n(CASE \r\nWHEN h.settled_flag = 2 THEN 'Accepted'\r\n WHEN h.settled_flag = 1 THEN 'Applied for st'\r\nWHEN h.settled_flag = 0 THEN 'Settle this in settle dues'\r\nWHEN h.settled_flag = 3 THEN 'Rejected'\r\nEND\r\n)As Settlement FROM transaction t, client_trader_transaction_history h where t.id=h.transaction_id and client_id=?";
try{
pst = con.prepareStatement(sql);
pst.setInt(1, Integer.valueOf(request.getSession().getAttribute("Client_name").toString()));
rs = pst.executeQuery();


%>

<div class="container-fluid">
<br>
<br>
<table class="table table-bordered table-condensed table-stripped">
<tr>
   
   <th>Date</th>
   <th>Transaction ID</th>
   <th>Quantity</th>
   <th>Bought_Or_Sold</th>
   <th>Cost</th>
   <th>Commission</th>
   <th>Comission_Mode</th>
   <th>Accepted/Rejected</th>
</tr>

<%
while( rs!=null && rs.next() ){
%>
<tr>

	<td><%= rs.getTimestamp(1) %></td>
	<td><%= rs.getInt(2) %></td>
	<td><%= rs.getDouble(3) %></td>
	<td><%= rs.getString(4) %></td>
	<td><%= rs.getDouble(5) %></td>
	<td><%= rs.getDouble(6) %></td>
	<td><%= rs.getString(7) %></td>
	<td><%= rs.getString(8) %></td>

</tr>
<%
}
%>
<%

}
catch(Exception e){
	
}

finally{
if(rs!=null) rs.close();
if(s!=null) s.close();
if(con!=null) con.close();
}
%>
</body>
</html>