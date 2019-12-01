<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");

	int eventid = Integer.parseInt(request.getParameter("eventid"));
	int eventtype = Integer.parseInt(request.getParameter("eventtype"));
	
	String EventCommentContent = request.getParameter("EventCommentContent");
	Timestamp register = new Timestamp(System.currentTimeMillis());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8"); //한글깨지지말라고
	
	String sqlInsertEventComment = "INSERT INTO EventComment(EventComment_Content,EventComment_Date,EventComment_Writer,Event_Id) values(?,?,?,?)";
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	try {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useSSL=false&useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC";
		String dbId = "jspid"; //dbid설정
		String dbPass = "jsppass"; //db비밀번호 설정

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); 
		
		pstmt = conn.prepareStatement(sqlInsertEventComment);
		pstmt.setString(1,EventCommentContent);
		pstmt.setString(2,sdf.format(cal.getTime()));
		pstmt.setString(3,userid);
		pstmt.setInt(4,eventid);
		pstmt.executeUpdate();
		
		pstmt.close();
		
		response.sendRedirect("EventShow.jsp?eventid="+eventid+"&eventtype="+eventtype);
	
	} catch (SQLException sql) {
			System.out.println(sql.getMessage());
	} finally {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (SQLException sql) {
			System.out.println(sql.getMessage());
		}
	}
%>
</body>
</html>