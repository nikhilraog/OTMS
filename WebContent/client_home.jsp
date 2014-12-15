<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<title>Summary Page</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>

</head>
<br>

<div class="pull-right">
	<form action="logout" method="get">
		<input type="submit" class="btn btn-default btn-sm btn-primary"
			value="Logout">
	</form>
</div>
<div class="container">
	<div class="row">
		<div class="col-sm-15">
			<legend>
				Welcome
				<%
				HttpSession s1 = request.getSession();
				String userName = s1.getAttribute("User").toString();
				String oil_bal = s1.getAttribute("oil_balance").toString();
				String cash_bal = s1.getAttribute("cash_balance").toString();
				String cname = s1.getAttribute("Client_name").toString();
				out.println(userName);
			%>


				<!-- //out.println("<input type='text' value='"+cname+"'>");%> -->
			</legend>

			<!-- panel preview -->
			<div class="col-sm-6">
				<h4>Summary :</h4>
				<div class="panel panel-default col-sm-10">
					<div class="panel-body form-horizontal payment-form">

						<div class="form-group">

							<a href="transaction.jsp" role="button"
								class="btn btn-primary btn-large">Make a Transaction</a> <a
								href="st.jsp" role="button" class="btn btn-primary btn-large">
								Settle Dues </a> <a href="viewstatus.jsp" role="button"
								class="btn btn-primary ">View Status</a> <br> <br>
							<!-- <h4 id=" status"> Account Type :</h4> -->
							<h4 id=" oilbal">
								Your Oil Balance :
								<%
								out.print(oil_bal);
							%>
							</h4>
							<h4 id=" cashbal">
								Your Cash Balance :
								<%
								out.print(cash_bal);
							%>
							</h4>

						</div>



					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</html>
