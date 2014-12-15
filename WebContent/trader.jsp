<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    

    <title>Trader Page</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	
	</head>
 <br>
<br>
 <div class="container">
	<div class="row">
        <div class="col-sm-15">
            <legend>Welcome 
           <%HttpSession s1 = request.getSession();
String traderid = s1.getAttribute("trader_id").toString();
String traderName = s1.getAttribute("User").toString();
out.println(traderName);%>


<!-- //out.println("<input type='text' value='"+cname+"'>");%> -->
            </legend> 
        </div>
        <div class="pull-right">
					<form action="logout" method="get">
						<input type="submit" class="btn btn-default btn-sm btn-primary"
							value="Logout">
					</form>
				</div>
        <!-- panel preview -->
        <div class="col-sm-5">
            
            <div class="panel panel-default col-sm-10">
                <div class="panel-body form-horizontal payment-form">
						
					<div class="form-group">
                        
						<a href="accept_reject.jsp" role="button" class="btn btn-primary btn-large">Accept/Reject a Transaction</a>
						<br>
						<br>
						<a href="search.jsp" role="button" class="btn btn-primary btn-large">Search Client</a>
                        <!-- <h4 id=" status"> Account Type :</h4> -->
						
						
                    </div>
					
					
                     
                   </div>
            </div>            
        </div> <!-- / panel preview -->
      </div>
</div>

</html>