<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
	</style>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<%
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	if(userid != null)
	{
		out.println( userid + "님 환영합니다.");
		out.println("<br>");
	}
	else 
	{
		out.println("세션 생성 안됨");
	}
%>
<h1>Member List</h1>
	<form name="MemberForm" method="post" action="javascript:MypageCheck()">
		<table class='ltable'>
			<tr>
				<th class='lt'>
					사용자 이름
				</th>
				<th class='lt'>
					이름
				</th>
				<th class='lt'>
					가입일자 
				</th>
			</tr>
	<%
		PreparedStatement pstmt=null;
		ResultSet rs = null;
	
		String driverName="com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
		String jdbcid="jspid";
		String jdbcpwd="jsppass";
	
		try{
			Class.forName(driverName); 
			Connection conn = DriverManager.getConnection(url,jdbcid,jdbcpwd);
		
			String sql="select * from Member";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				String id = rs.getString("Member_Id");
				String name = rs.getString("Member_Name");
				String regdate = rs.getString("Member_Register");
	%>
				<tr >
					<td class='lt'>
						<a href="MypageForm.jsp?mypageid=<%=id%>"><%=id%></a>
					</td>
					<td class='lt'>
						<%=name %>
					</td>
					<td class='lt'>
						<%=regdate %>
					</td>
				</tr>
	<% 
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
		</table>
	</form>
</body>
</html>