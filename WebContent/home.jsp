<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Welcome
<%HttpSession s1 = request.getSession();
String userName = s1.getAttribute("User").toString();
String cname = s1.getAttribute("Client_name").toString();
out.println("<input type='text' value='"+userName+"'>");
out.println("<input type='text' value='"+cname+"'>");%>
<br>
<a href="summa.jsp" >Do a transation</a>
<br>
<a href="">Settle Older</a>

</body>
</html>