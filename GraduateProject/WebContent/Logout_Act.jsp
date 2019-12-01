<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
/*
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");

	if(userid != null && login != null)
	{
		session.removeAttribute("userid");
		session.removeAttribute("login");
		
		response.sendRedirect("index.jsp");
	}
*/
	session.invalidate();	//세션 무효화시킴
	response.sendRedirect("index.jsp");
%>
</body>
</html>