<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	int questionid = Integer.parseInt(request.getParameter("questionid")); //QuestionList에서 Question_Id 받아오기
	int pg = Integer.parseInt(request.getParameter("pg"));
	
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
		String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
		String dbId="jspid";
		String pwd="jsppass"; 
		
		Class.forName ("com.mysql.jdbc.Driver");
		
		conn=DriverManager.getConnection(jdbcUrl, dbId, pwd);
			String sql1 = "delete from QuestionComment where Question_Id="+questionid;
			String sql2 = "delete from QuestionPhoto where Question_Id="+questionid;
			String sql3 = "delete from Question where Question_Id="+questionid;
			
			pstmt= conn.prepareStatement(sql1);
			pstmt.executeUpdate();
			pstmt.close();
			
			pstmt= conn.prepareStatement(sql2);
			pstmt.executeUpdate();
			pstmt.close();
			
			pstmt= conn.prepareStatement(sql3);
			pstmt.executeUpdate();
			
			out.println("<script>");
			out.println("alert('해당 글이 삭제되었습니다.')");
			out.println("location.href='QuestionList.jsp';");
			out.println("</script>");
			
			
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