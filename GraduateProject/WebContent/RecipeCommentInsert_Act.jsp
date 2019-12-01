<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");

	int recipeno = Integer.parseInt(request.getParameter("recipeno"));
	
	String RecipeCommentContent = request.getParameter("RecipeCommentContent");
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
	
	String sqlInsertRecipeComment = "INSERT INTO RecipeComment(RecipeComment_Content,RecipeComment_Date,RecipeComment_Writer,Recipe_No) values(?,?,?,?)";
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	try {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
		String dbId = "jspid"; //dbid설정
		String dbPass = "jsppass"; //db비밀번호 설정

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); 
		
		pstmt = conn.prepareStatement(sqlInsertRecipeComment);
		pstmt.setString(1,RecipeCommentContent);
		pstmt.setString(2,sdf.format(cal.getTime()));
		pstmt.setString(3,userid);
		pstmt.setInt(4,recipeno);
		pstmt.executeUpdate();
		
		pstmt.close();
		
		response.sendRedirect("RecipeShow.jsp?recipeno="+recipeno);
	
	} catch (SQLException sql) {
			sql.printStackTrace();
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