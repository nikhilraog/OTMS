<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
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
	<script type="text/javascript" src="css/bootstrap.min.js"></script>
	<script type="text/javascript">
		
		function updateBarrelQ(obj) {
			
			document.getElementById('qty').innerHTML=obj.value;

		}

		function updateCommision(obj) {
			
			document.getElementById('mode').innerHTML=obj.options[obj.selectedIndex].value;

		}
		
		function updateBuy(obj) {
			
			document.getElementById('opt').innerHTML=obj.options[obj.selectedIndex].value;

		}
		
		function updateTransaction(obj) {
			
			document.getElementById('type').innerHTML=obj.options[obj.selectedIndex].value;
			

		}
		
							
		</script>
		
		<script>
			$(document).ready(function () {
			//called when key is pressed in textbox
			$("#inputUserid").keypress(function (e) {
			//if the letter is not digit then display error and don't type anything
			if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
			//display error message
			$("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
			}
			});
			});
			
						
			/*  $(document).ready(function(){
			$('#transactiontype').on('change', function() {
			if ( this.value == 'Trader')
			{
			$("#choice").show();
			}
			else
			{
			$("#choice").hide();
			}
			});
			}); */
						
		</script>
	
	</head>
<body>
<%HttpSession s1 = request.getSession();
String ppb = s1.getAttribute("ppb").toString();
String com_rate = s1.getAttribute("com_rate").toString();
ArrayList<String> traderlist = (ArrayList<String>) s1.getAttribute("traderList");
%>
 <br>
 
 <div class="container">
	<div class="row">
        <div class="col-sm-15">
            <legend>Welcome</legend> 
        </div>
        <div class="pull-right">

				<form action="logout" method="get">
					<input type="submit" class="btn btn-default btn-sm btn-primary"
						value="Logout">
				</form>
			</div>

			<a class="pull-right " href="client_home.jsp">
				<button type="button" class="btn btn-default btn-sm btn-primary">Home</button>
			</a>
			<form class=" submitbut" method="get" action="client" role="form">
        <!-- panel preview -->
        <div class="col-sm-5">
            <h4>Transaction :</h4>
            <div class="panel panel-default">
                <div class="panel-body form-horizontal payment-form">
                
						<div class="col-sm-3">							
								<select class="form-control" id="buysell" name="buysell" onchange="updateBuy(this)" >
										<option value="Buy">Buy</option>
										<option value="Sell">Sell</option>
								</select>
						</div>
						<div class="col-sm-7">
							<input type="text" name ="quantity" id="inputUserid" class="form-control" placeholder="Enter Quantity in Barrels" required autofocus onblur="updateBarrelQ(this);">
						</div>
					<br>
					<br>
					<div class="form-group">
                        <label for="comissionstatus" class="col-sm-4 control-label">Comission Mode</label>
                        <div class="col-sm-5">
                            <select class="form-control" id="comissionstatus" name="comissionstatus" onchange="updateCommision(this)">
                                <option value="Cash">Cash</option>
                                <option value="Oil">Oil</option>
                            </select>
                        </div>
                    </div>
					<div class="form-group">
                        <label for="transactiontype" class="col-sm-4 control-label">Transaction Type</label>
                        <div class="col-sm-5">
                            <select class="form-control" id="transactiontype" name="transactiontype" onchange="updateTransaction(this)">
                                <option value="Self">Self</option>
                                <option value="Trader">Trader</option>
                            </select>
                        </div>
                    </div>
					<%-- <div class="form-group" style="display:none;" id="choice" >
                        <label for="tradername"  class="col-sm-4 control-label">Choose Trader</label>
                        <div class="col-sm-5">
                            <select class="form-control" array="traderlist" name="tradername" onchange="updateTradername(this)">
                                <option value="mark">mark</option>
                                <option value="Steve Smith">Steve Smith</option>
                                
                                
									    <c:forEach var="trader" items="${traderlist}">
									        <option><c:out value="${trader}"/></option>
									    </c:forEach>
								
                            </select>
                        </div>
                    </div> --%>
                     
                   </div>
            </div>            
        </div> <!-- / panel preview -->
        <div class="col-sm-10">
            <h4>Review Order:</h4>
            <div class="row">
                <div class="col-xs-12">
                    <div class="table-responsive">
                        <table class="table preview-table">
                            <thead>
                                <tr>
                                    <th>Buy/Sell</th>
                                    <th>Quantity</th>
									<th>Price per Barrel</th>
                                    <th>Commission %</th>
                                    <th>Commission Mode</th>
									<th>Transaction Type</th>
									                                   
                                </tr>
								<tr>
									<td id="opt">Buy</td>
									<td id="qty"></td>
									<td id="ppb"><% out.print(ppb);%></td>
									<td id="commi"> <% out.print(com_rate);%> </td>
									<td id="mode">Cash</td>
									<td id="type">Self</td>
								</tr>
                            </thead>
                            <tbody></tbody> <!-- preview content goes here-->
                        </table>
                    </div>                            
                </div>
            </div>
            <div class="row text-left">
                <div class="col-xs-12">
                    <h4>Total: <strong><span class="preview-total">  <%=request.getAttribute("total")%> </span></strong></h4>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <hr style="border:1px dashed #dddddd;">
                    
                    <button type="submit" class="btn btn-primary">Submit</button>
               	    
                </div>                
            </div>
        </div>
        </form>
	</div>
</div>

</body>
</html>