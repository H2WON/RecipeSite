<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<%
		String userid = (String)session.getAttribute("UserID");
		String mypageid = request.getParameter("mypageid");
	
		String driverName = "com.mysql.jdbc.Driver";
		//?useUnicode=true& useUnicode=true&characterEncoding=euc_kr	=> 을 붙여야 한글이 DB에 저장될 때 물음표로 깨지지 않음
		String dbURL = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
		
		try {
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(dbURL, "jspid", "jsppass");

			String sql_deleteFollow = "DELETE FROM Follow WHERE Follow_Sender=? and Follow_Recipient=?";
			
			PreparedStatement pstmt = con.prepareStatement(sql_deleteFollow);
			pstmt.setString(1, userid);
			pstmt.setString(2, mypageid);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			con.close();
			
			response.sendRedirect("MypageForm.jsp?mypageid=" + mypageid);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
	}
	%>
</head>
<body>
</body>
</html>