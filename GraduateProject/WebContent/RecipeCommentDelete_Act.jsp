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
	int recipecommentid = Integer.parseInt(request.getParameter("recipecommentid"));
	int recipeno = Integer.parseInt(request.getParameter("recipeno"));

	PreparedStatement pstmt=null;
	
	String driverName="com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
	String jdbcid="jspid";
	String jdbcpwd="jsppass";
	
	try{
		Class.forName(driverName); 
		Connection conn = DriverManager.getConnection(url,jdbcid,jdbcpwd);
		
		String sql = "DELETE FROM RecipeComment WHERE RecipeComment_Id = ?";
		pstmt= conn.prepareStatement(sql);
		pstmt.setInt(1, recipecommentid);
			
		pstmt.executeUpdate();
		
		response.sendRedirect("RecipeShow.jsp?recipeno="+recipeno);
	}catch(ClassNotFoundException e){
		out.println("Where is your mysql jdbc driver?");
		e.printStackTrace();
		return;
	}

%>
</body>
</html>