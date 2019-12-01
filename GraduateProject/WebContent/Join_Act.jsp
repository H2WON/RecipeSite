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
	String id = request.getParameter("Jid");
	String pwd = request.getParameter("Jpassword");
	String name = request.getParameter("Jname");
	Boolean manager = false;
	Timestamp register = new Timestamp(System.currentTimeMillis());

	PreparedStatement pstmt=null;
	
	String driverName="com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
	String jdbcid="jspid";
	String jdbcpwd="jsppass";

	try{
		Class.forName(driverName); 
		Connection conn = DriverManager.getConnection(url,jdbcid,jdbcpwd);
		
		String sql_checkId = "SELECT * FROM Member WHERE Member_Id = ?";
		
		pstmt = conn.prepareStatement(sql_checkId);
		pstmt.setString(1, id);
		
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			out.println("<script>");
			out.println("alert('중복된 아이디입니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		else
		{
			String sql = "insert into Member(Member_Id,Member_PassWord,Member_Name,Member_Manager,Member_Register) values(?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setBoolean(4, manager);
			pstmt.setTimestamp(5, register);

			pstmt.executeUpdate();
			
			response.sendRedirect("index.jsp");
			
			pstmt.close();
			conn.close();
		}
	}catch(ClassNotFoundException e){
		out.println("Where is your mysql jdbc driver?");
		e.printStackTrace();
		return;
	}
%>
</body>
</html>