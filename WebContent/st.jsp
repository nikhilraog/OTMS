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

<script type="text/javascript">
	function aler() {
	alert("Hey!! Your oil and cash balance will be updated after trader accepts your transaction");
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

	<a class="pull-right " href="client_home.jsp">
		<button type="button" class="btn btn-default btn-sm btn-primary">Home</button>
	</a>
	<%@ page import="java.util.*"%>
	<%@ page import="javax.sql.*;"%>
	<%
		HttpSession s1 = request.getSession();
	String userName = s1.getAttribute("User").toString();
	String oil_bal = s1.getAttribute("oil_balance").toString();
	String cash_bal = s1.getAttribute("cash_balance").toString(); 
	String cname = s1.getAttribute("Client_name").toString();
	ArrayList<Object> trans = new ArrayList<Object>();

	java.sql.Connection con;
	java.sql.Statement s;
	java.sql.ResultSet rs;
	java.sql.PreparedStatement pst;

	con=null;
	s=null;
	pst=null;
	rs=null;

	// Remember to change the next line with your own environment 
	String url= 
	"jdbc:mysql://localhost/oil";
	String id= "root";
	String pass = "";
	try{

	Class.forName ("com.mysql.jdbc.Driver").newInstance ();
	con = java.sql.DriverManager.getConnection(url, id, pass);

	}catch(ClassNotFoundException cnfex){
	out.print("Ertt;kjjh");
	cnfex.printStackTrace();

	}

	String sql = "SELECT date,t.id transaction_id,t.quantity,(CASE WHEN buy_sell like 'b%' THEN \"Bought\" ELSE \"Sold\" END) As Buy_Sell, t.cost_of_transaction,h.com_charge, (CASE WHEN comtype <> 0 THEN 'Cash' ELSE 'Oil' END) As Comission_Mode,\r\n(CASE \r\nWHEN h.settled_flag = 1 THEN 'Applied_for_Settlement'\r\nWHEN h.settled_flag = 0 THEN 'Not_Yet_Applied'\r\nWHEN h.settled_flag = 2 THEN 'Accpeted'\r\nWHEN h.settled_flag = 3 THEN 'Rejected'\r\nEND\r\n)As Settlement FROM transaction t, client_trader_transaction_history h where t.id=h.transaction_id and client_id=? and h.settled_flag in (0,1)";
	try{
	pst = con.prepareStatement(sql);
	pst.setInt(1, Integer.valueOf(request.getSession().getAttribute("Client_name").toString()));
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
			</tr>

			<%
				while( rs!=null && rs.next() ){
			%>
			<tr>

				<td><%=rs.getTimestamp(1)%></td>
				<td><%=rs.getInt(2)%></td>
				<%
					trans.add(rs.getInt(2));
				%>
				<td><%=rs.getDouble(3)%></td>
				<td><%=rs.getString(4)%></td>
				<td><%=rs.getDouble(5)%></td>
				<td><%=rs.getDouble(6)%></td>
				<td><%=rs.getString(7)%></td>
				<td><%=rs.getString(8)%></td>

			</tr>
			<%
				}
			%>



			<%
				}
			catch(Exception e){e.printStackTrace();}
			finally{
			if(rs!=null) rs.close();
			if(s!=null) s.close();
			if(con!=null) con.close();
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
			<br>
			<br>
			<%
				out.println("<font size=\"4\" color=red>If nothing is displayed then check View Status</font>");
			%>


			<br>
			<br>
			<%
				int client_id = Integer.valueOf(request.getSession().getAttribute("Client_name").toString());
			%>
			<input type="submit" class="btn btn-primary"
				value="Settle Transaction Now" onClick="aler(<%%>);" />

			<div class="pull-right">
				<button TYPE="button" class="btn btn-primary"
					onClick="history.go(0)" VALUE="Refresh">Refresh</button>
			</div>
			<br>

			<%
				String tlist = trans.toString();
			%>

			<br>
</body>

<script type="text/javascript">

function aler(cid) {
	

	  alert("Hey!! Your are now  b4 calling appling to settle all your unsetlled transaction oil and cash balance will be updated after trader accepts your transaction");
	  var client_id = "<%=cname%>"+"#" ;
	  var tl = "<%=tlist%>"+"#";
	  var set_one_settledflag = 1;
	  var data = client_id + tl +set_one_settledflag;
	  alert(data);
	  $.get("http://localhost:8080/tryout_odb/settr",{"param2": data});
}
</script>

<br>
<table class="table table-bordered table-condensed table-stripped">
	<!-- column headers -->
	<tr>
		<c:forEach var="columnName" items="${result.columnNames}">
			<th><c:out value="${columnName}" /></th>
		</c:forEach>
	</tr>
	<!-- column data -->
	<c:forEach var="row" items="${result.rowsByIndex}">
		<tr>
			<c:forEach var="column" items="${row}">
				<td><c:out value="${column}" /></td>
			</c:forEach>
		</tr>
	</c:forEach>
</table>


</html>