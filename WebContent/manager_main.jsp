<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Manager Main Page</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	
 <br>
 
 <div class="container">
	<div class="row">
        <div class="col-sm-15">
            <legend>Welcome Manager!</legend> 
            <br>
            <h4>Note</h4>
            
            <h5> Settled Flag : 0 - Client has not applied for transaction settlement</h5>
            <h5> Settled Flag : 1 - Client has applied for transaction settlement and awaiting response</h5>
            <h5> Settled Flag : 2 - Trader has accepted  the transaction settlement</h5>
            <h5> Settled Flag : 3 - Trader has rejected  the transaction settlement</h5>
            <br>
        </div>
        <div class="pull-right">

				<form action="logout" method="get">
					<input type="submit" class="btn btn-default btn-sm btn-primary"
						value="Logout">
				</form>
			</div>
       <form method="get" action="manager">
        <div class="col-sm-10">
            <h4>Transaction History:</h4>
            <div class="row">
                <div class="col-xs-12">
                    <h5>Enter Date Range to view History:<h5>
					<div class="table-responsive">
                        <table class="table">
                            <thead>
                                
								<tr>
									<td>
										<div class="form-group">
											<label for="date" class="col-sm-4 control-label">From Date:</label>
												<div class="col-sm-6">
													<input type="date" class="form-control" id="fromdate" name="fromdate">
												</div>
										</div>
									</td>
								<td>
										<div class="form-group">
											<label for="date" class="col-sm-4 control-label">To Date:</label>
												<div class="col-sm-6">
													<input type="date" class="form-control" id="todate" name="todate">
										</div>
										</div>
								</td>
								</tr>
								<tr>
									<td><td>
									<td>
										<div class="col-sm-10">
											<button type="submit" class="btn btn-primary btn-block" value="submit">Submit</button>
										</div> 
								</tr>
								
						</table>		
					</div>
                </div>
				
            </div>
            
            
        </div>
        </form>
	</div>
</div>

</head>
</body>


	<table class="table table-bordered table-condensed table-stripped"">
            <!-- column headers -->
            <tr>
                <c:forEach var="columnName" items="${result.columnNames}">
                    <th><c:out value="${columnName}"/></th>
                </c:forEach>
            </tr>
            <!-- column data -->
            <c:forEach var="row" items="${result.rowsByIndex}">
                <tr>
                    <c:forEach var="column" items="${row}">
                        <td><c:out value="${column}"/></td>
                    </c:forEach>
                </tr>
            </c:forEach>
        </table>

</html>