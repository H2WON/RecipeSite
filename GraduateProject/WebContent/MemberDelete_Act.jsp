<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	request.setCharacterEncoding("UTF-8");

	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	String cPwd = request.getParameter("Dpassword");
	
	//로그인이 안돼있는 경우 index 페이지로 돌아감 
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

Connection conn = null;
PreparedStatement pstmt=null;
ResultSet rs = null;


try{
	String jdbcUrl="jdbc:mysql://localhost:3306/jsptest";
	String dbId="jspid";
	String pwd="jsppass";
	
	Class.forName ("com.mysql.jdbc.Driver");
	
	conn=DriverManager.getConnection(jdbcUrl, dbId, pwd);
	
	String check="select * from Member where Member_id= ?";
	
	pstmt = conn.prepareStatement(check);
	
	pstmt.setString(1,userid);
	
	//?연결 시키기
	rs = pstmt.executeQuery();
	if(rs.next()){
		
		String rPwd = rs.getString("Member_PassWord");
		
		if(rPwd.equals(cPwd))
		{	
			String Msql = "delete from Member where Member_Id = ?";
			pstmt= conn.prepareStatement(Msql);
			pstmt.setString(1, userid);
			pstmt.executeUpdate();
			
			String Fsql = "delete from Follow where Follow_Recipient = ? or Follow_Sender = ?";
			pstmt= conn.prepareStatement(Fsql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userid);
			pstmt.executeUpdate();
			
			session.removeAttribute("userid");
			session.removeAttribute("login");
			
			response.sendRedirect("index.jsp");
		}else
		{
			out.println("<script>");
			out.println("alert('비밀번호가 틀렸습니다.')");
			out.println("location.href='MypageForm.jsp'");
			out.println("</script>");
		}
		
	}
	
	
}catch(Exception e){//에러가 났을 때 나오는 메시지
	e.printStackTrace();
}finally{
	if(pstmt != null)
	{
		try{pstmt.close();}catch(Exception e){}
	}
	if(conn != null)
	{
		try{pstmt.close();}catch(Exception e){}
	}
}
%>
</body>
</html>