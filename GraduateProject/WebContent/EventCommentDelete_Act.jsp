<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int eventcommentid = Integer.parseInt(request.getParameter("eventcommentid"));
	int eventid = Integer.parseInt(request.getParameter("eventid"));
	int eventtype = Integer.parseInt(request.getParameter("eventtype"));

	PreparedStatement pstmt=null;
	
	String driverName="com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jsptest?useSSL=false&useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC";
	String jdbcid="jspid";
	String jdbcpwd="jsppass";
	
	try{
		Class.forName(driverName); 
		Connection conn = DriverManager.getConnection(url,jdbcid,jdbcpwd);
		
		String sql = "DELETE FROM EventComment WHERE EventComment_Id = ?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setInt(1, eventcommentid);
			
		pstmt.executeUpdate();
		
		response.sendRedirect("EventShow.jsp?eventid="+eventid+"&eventtype="+eventtype);
	}catch(ClassNotFoundException e){
		out.println("Where is your mysql jdbc driver?");
		e.printStackTrace();
		return;
	}

%>
</body>
</html>