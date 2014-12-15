<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<title>Search Client</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script>
	$(document).ready(function() {
		$('#searchby').on('change', function() {
			if (this.value == '1') {
				$("#choice1").show();
				$("#choice2").hide();
				$("#choice3").hide();
			} else if (this.value == '2') {
				$("#choice2").show();
				$("#choice1").hide();
				$("#choice3").hide();
			} else if (this.value == '3') {
				$("#choice3").show();
				$("#choice1").hide();
				$("#choice2").hide();
			} else {
				$("#choice1").hide();
				$("#choice2").hide();
				$("#choice3").hide();
			}
		});
	});
</script>

</head>
<body>
	<br>
	
		<div class="container">
			<div class="row">
				<div class="col-sm-15">
					<legend>Search for a client!</legend>
				</div>
				<div class="pull-right">

					<form action="logout" method="get">
						<input type="submit" class="btn btn-default btn-sm btn-primary"
							value="Logout">
					</form>
				</div>

				<a class="pull-right " href="trader.jsp">
					<button type="button" class="btn btn-default btn-sm btn-primary">Home</button>
				</a>
				<form method="get" action="search">
				<!-- panel preview -->
				<div class="col-sm-5">
					<h4>Enter client details :</h4>
					<div class="panel panel-default col-sm-10">
						<div class="panel-body form-horizontal payment-form">
							<div class="form-group">
								<label for="searchby" class="col-sm-4 control-label">Search
									By</label>
								<div class="col-sm-6">
									<select class="form-control" id="searchby" name="searchby"
										onchange="updateCommision(this)">
										<option value="1">Client ID</option>
										<option value="2">Last Name</option>
										<option value="3">First Name</option>
									</select>
								</div>
							</div>
							<div class="col-sm-10" id="choice1">
								<input type="text" name="cid" id="cid" class="form-control"
									placeholder="Enter Client ID">
							</div>
							<div class="col-sm-10" style="display: none;" id="choice2">
								<input type="text" name="clname" id="clname"
									class="form-control" placeholder="Enter Client Last Name">
							</div>
							<div class="col-sm-10" style="display: none;" id="choice3">
								<input type="text" name="cfname" id="cfname"
									class="form-control" placeholder="Enter Client First Name">
							</div>
							
							<br> <br>
							<div class="col-sm-4">
								<button type="submit" class="btn btn-primary btn-block pull-right" value="submit">Submit</button>
							</div>



						</div>
					</div>
				</div>
				</form>
				<!-- / panel preview -->
			</div>
		</div>
	
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
</body>
</html>