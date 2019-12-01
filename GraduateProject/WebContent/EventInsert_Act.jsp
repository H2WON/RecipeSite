<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%

	request.setCharacterEncoding("UTF-8"); //한글깨지지말라고
	
	String SavePath = application.getRealPath("EventSavePath");

	int max = 1024 * 1024 * 80; //업로드 받을 이미지의 최대 크기 10Mb로 용량 제한
	String encoding = "UTF-8"; //인코딩

	MultipartRequest Event_multi = null;
	Event_multi = new MultipartRequest(request, SavePath, max, encoding, new DefaultFileRenamePolicy());
	
	String sqlInsertEvent = "INSERT INTO EVENT(Event_Title,Event_Content,Event_StartDate,Event_EndDate,Event_ThumbOriginalName,Event_ThumbChangeName,Event_ThumbNailSavePath) values(?,?,?,?,?,?,?)";
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useSSL=false&useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC";
		String dbId = "jspid"; //dbid설정
		String dbPass = "jsppass"; //db비밀번호 설정

		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver"); //Driver로 connection객체와 연결
		// connection 객체 세팅
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결
		
		//Request.getParameter("a").replaceAll("\r\n","<br/>")
		pstmt = conn.prepareStatement(sqlInsertEvent);
		pstmt.setString(1,Event_multi.getParameterValues("EventTitle")[0]);
		pstmt.setString(2,Event_multi.getParameterValues("EventContent")[0].replaceAll("\r\n","<br/>"));
		pstmt.setString(3,Event_multi.getParameterValues("EventStart")[0]);
		pstmt.setString(4,Event_multi.getParameterValues("EventEnd")[0]);
		pstmt.setString(5,Event_multi.getOriginalFileName("EventThumbnailFile"));
		pstmt.setString(6,Event_multi.getFilesystemName("EventThumbnailFile"));
		pstmt.setString(7, SavePath);
		pstmt.executeUpdate();
		
		pstmt.close();
		
		out.println("성공");
	
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
<body>

</body>
</html>