<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%><%@ page
	import="javax.sql.*"%>
<html>
<head>
<title>Enter to database</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script>
			
			function  butfunc(b){
				
				
				var $id = b.id+"@";
				//alert("Hhey"+ $id);
				var $row = $(b).closest("tr");    // Find the row
			    var $text1 = $row.find(".c1").text()+"@"; // Find the text
			    var $text2 = $row.find(".c2").text()+"@";
			    var $text3 = $row.find(".c3").text()+"@";
			    var $text4 = $row.find(".c4").text()+"@";
			    var $text5 = $row.find(".c5").text()+"@";
			    var $text6 = $row.find(".c6").text()+"@";
			    var $text7 = $row.find(".c7").text()+"@";
			    var $text8 = $row.find(".c8").text()+"@";
			    var $text9 = $row.find(".c9").text();
			    //var data = $id + "*"+$text1;
			    var data = $id + $text1+ $text2+ $text3+ $text4+ $text5+ $text6+ $text7+ $text8+ $text9;
			    //alert( $id +' '+ $text1);
			    alert(data);
			    
			    $.get("http://localhost:8080/tryout_odb/accept",{"param1": data});
     
			}
			
  </script>
<script>
		         
 function disableFunction(obj) {
		
     document.getElementById("1-"+obj).disabled = 'true';
     document.getElementById("2-"+obj).disabled = 'true';	
     			           
     
     
}
function colorButton(obj1,obj2){
if(obj1==1){
document.getElementById("1-"+obj2).style.backgroundColor = '#5cb85c';
}
else{
document.getElementById("2-"+obj2).style.backgroundColor = '#ff0000';
}
}
			
	</script>

</head>
<body>
<div class="pull-right">

		<form action="logout" method="get">
			<input type="submit" class="btn btn-default btn-sm btn-primary"
				value="Logout">
		</form>
	</div>

	<a class="pull-right " href="trader.jsp">
		<button type="button" class="btn btn-default btn-sm btn-primary">Home</button>
	</a>
	<%@ page import="java.util.*"%>
	<%@ page import="javax.sql.*;"%>
	<%
		java.sql.Connection con;
		java.sql.Statement s;
		java.sql.ResultSet rs;
		java.sql.PreparedStatement pst;

		con = null;
		s = null;
		pst = null;
		rs = null;

		// Remember to change the next line with your own environment 
		String url = "jdbc:mysql://localhost/oil";
		String id = "root";
		String pass = "";
		try {

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = java.sql.DriverManager.getConnection(url, id, pass);

		} catch (ClassNotFoundException cnfex) {
			out.print("Ertt;kjjh");
			cnfex.printStackTrace();

		}

		//String sql = "SELECT date,t.id transaction_id,t.quantity,(CASE WHEN buy_sell like 'b%' THEN \"Bought\" ELSE \"Sold\" END) As Buy_Sell ,\r\nt.cost_of_transaction,h.com_charge, (CASE WHEN comtype <> 0 THEN 'Cash' ELSE 'Oil' END) As Comission_Mode,\r\n(CASE WHEN h.settled_flag = 1 THEN 'Applied for settlement' ELSE 'Client_has_Not_Yet_Applied_for_settlement' END) As Settlement\r\n ,h.client_id client_id FROM transaction t, client_trader_transaction_history h \r\nwhere t.id=h.transaction_id ";
		String sql = "SELECT date,t.id transaction_id,t.quantity,(CASE WHEN buy_sell like 'b%' THEN \"Bought\" ELSE \"Sold\" END) As Buy_Sell ,\r\nt.cost_of_transaction,h.com_charge, (CASE WHEN comtype <> 0 THEN 'Cash' ELSE 'Oil' END) As Comission_Mode,\r\n(CASE WHEN h.settled_flag = 1 THEN 'Applied for settlement' ELSE 'Client_has_Not_Yet_Applied_for_settlement' END) As Settlement\r\n ,h.client_id client_id FROM transaction t, client_trader_transaction_history h \r\nwhere t.id=h.transaction_id and h.settled_flag not in (2,3)";

		try {
			pst = con.prepareStatement(sql);
			//pst.setInt(1, Integer.valueOf(request.getSession().getAttribute("Client_name").toString()));
			rs = pst.executeQuery();
	%>
	<div class="container-fluid">
		<br> <br>
		<table class="table table-bordered table-condensed table-stripped">
			<tr>

				<th>Date</th>
				<th>Transaction ID</th>
				<th>Quantity</th>
				<th>Bought_Or_Sold</th>
				<th>Cost</th>
				<th>Commission</th>
				<th>Comission_Mode</th>
				<th>Settled_Or_NotSettled</th>
				<th>Client_id</th>
				<th>Accept/Reject</th>
			</tr>

			<%
				while (rs != null && rs.next()) {
			%>
			<tr>

				<td class="c1"><%=rs.getTimestamp(1)%></td>
				<td class="c2"><%=rs.getInt(2)%></td>
				<td class="c3"><%=rs.getDouble(3)%></td>
				<td class="c4"><%=rs.getString(4)%></td>
				<td class="c5"><%=rs.getDouble(5)%></td>
				<td class="c6"><%=rs.getDouble(6)%></td>
				<td class="c7"><%=rs.getString(7)%></td>
				<td class="c8"><%=rs.getString(8)%></td>
				<td class="c9"><%=rs.getString(9)%></td>

				<td><button id='1-<%=rs.getInt(2)%>' class="use-address btn btn-default"
						name="accept"
						onclick="butfunc(this); disableFunction(<%=rs.getInt(2)%>); colorButton(1,<%=rs.getInt(2)%>);">Accept</button>
					<button id='2-<%=rs.getInt(2)%>' type="button" class="use-address btn btn-default"
						name="reject" 
						onclick="butfunc(this); disableFunction(<%=rs.getInt(2)%>); colorButton(2,<%=rs.getInt(2)%>);">Reject</button></td>

			</tr>
			<%
				}
			%>

			<%
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (rs != null)
						rs.close();
					if (s != null)
						s.close();
					if (con != null)
						con.close();
				}
			%>

			<%
				out.println("<font size=\"4\" color=red>Note:</font>");
			%>
			<br>
			<%
				out.println("<font size=\"4\" color=red>If Comission_mode is Cash : then cash balance will be debited from your account</font>");
			%>
			<br>
			<%
				out.println("<font size=\"4\" color=red>If Comission_mode is Oil  : then oil  balance will be debited from your account</font>");
			%>
</table>
</div>

			<br>
			<br>
</body>
</html>