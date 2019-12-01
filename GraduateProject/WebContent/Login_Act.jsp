<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("Lid");
	String pwd = request.getParameter("Lpassword");	

	out.println(pwd);
	
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	
	String driverName="com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
	String jdbcid="jspid";
	String jdbcpwd="jsppass";

	try{
		Class.forName(driverName); 
		Connection conn = DriverManager.getConnection(url,jdbcid,jdbcpwd);
		
		String sql="select * from Member where Member_Id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			String DBPwd = rs.getString("Member_PassWord");
			
			if(id != null && DBPwd.equals(pwd))
			{
				session.setAttribute("UserID", id);
				session.setAttribute("Login", "yes");
				
				response.sendRedirect("Lindex.jsp");
			}
			else if(!DBPwd.equals(pwd))
			{
				out.println("<script>");
				out.println("alert('비밀번호가 틀렸습니다.')");
				out.println("location.href='index.jsp'");
				out.println("</script>");
			}
		}
		else{
			out.println("<script>");
			out.println("alert('가입하지 않은 아이디 입니다.')");
			out.println("location.href='index.jsp'");
			out.println("</script>"); 
		}

		rs.close();
		pstmt.close();
		conn.close();

	}catch(ClassNotFoundException e){
		out.println("Where is your mysql jdbc driver?");
		e.printStackTrace();
		return;
	}
%>
</body>
</html>