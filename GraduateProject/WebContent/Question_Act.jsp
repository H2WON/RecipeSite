<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileNotFoundException"%>

<%-- 업로드 위해 필요한 2가지, 두 번째 import는 파일 이름 중복을 막아줌(중복되는 파일명 뒤에 (2) 붙여줌) --%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%-- charset과 pageEncoding = UTF-8 사용 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String login = (String) session.getAttribute("Login");
	String userid = (String) session.getAttribute("UserID");
	request.setCharacterEncoding("UTF-8"); //한글깨지지말라고
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	String SavePath = application.getRealPath("QuestionSavePath");

	int max = 1024 * 1024 * 80; //업로드 받을 이미지의 최대 크기 10Mb로 용량 제한
	String encoding = "UTF-8"; //인코딩

	MultipartRequest Question_multi = null;
	Question_multi = new MultipartRequest(request, SavePath, max, encoding, new DefaultFileRenamePolicy());
%>
<%
	String sqlGetMaxQuestionID = "SELECT MAX(QUESTION_ID) FROM QUESTION";
	
	String sqlInsertQuestion = "INSERT INTO QUESTION("
			+ " QUESTION_ID,"
			+ " QUESTION_TITLE,"
			+ " QUESTION_WRITER,"
			+ " QUESTION_DATE,"
			+ " QUESTION_CONTENT,"
			+ " QUESTION_SECRET,"
			+ " QUESTION_SECRETPWD)"
			+ " VALUES(?,?,?,?,?,?,?)";
	
	String sqlInsertQuestionPhoto = "INSERT INTO QUESTIONPHOTO("
			+ " QUESTION_ID,"
			+ " QUESTIONPHOTO_ID,"
			+ " QUESTIONPHOTO_ORIGINALNAME,"
			+ " QUESTIONPHOTO_CHANGENAME,"
			+ " QUESTIONPHOTO_SAVEPATH"
			+ "		)"
			+ " VALUES(?,?,?,?,?)";

	/* Boolean Secret = Question_multi.getParameter("checkSecret").equals("on") ? true : false; */
	Boolean Secret;
	String Check = Question_multi.getParameter("checkSecret");
 	if(Check == "on"){
		Secret = true;
	} else{
		Secret = false;
	}
	
	//connection객체 생성
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	

	//db연결   
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
		String dbId = "jspid"; //dbid설정
		String dbPass = "jsppass"; //db비밀번호 설정

		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver"); //Driver로 connection객체와 연결
		// connection 객체 세팅
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결


		// Recipe ID를 일치시키기 위해 현재 존재하는 ID의 최대값 사용 ================================================================================
		pstmt = conn.prepareStatement(sqlGetMaxQuestionID);
		rs = pstmt.executeQuery();

		int MaxQID = 0;
		if (rs.next()) {
			MaxQID = rs.getInt(1) + 1;
		}
		rs.close();
		pstmt.close();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		
		// QUESTION 정보 입력 ==============================================================================================================
		pstmt = conn.prepareStatement(sqlInsertQuestion);
		pstmt.setInt(1, MaxQID);
		pstmt.setString(2, Question_multi.getParameterValues("Question_Title")[0]);
		pstmt.setString(3, userid);
		pstmt.setString(4, sdf.format(cal.getTime()));
		pstmt.setString(5, Question_multi.getParameterValues("Question_Content")[0].replaceAll("\r\n","<br/>"));
		pstmt.setBoolean(6, false);
		pstmt.setString(7, "0");
		
		pstmt.executeUpdate();
		pstmt.close();
		
		
		// QUESTIONPHOTO 정보 입력==============================================================================================================
		
		//첨부사진 파일 부분 (각각의 갯수를 체크하기 위해 사용)
		Enumeration<?> en = Question_multi.getFileNames();
		
		// 첨부사진의 갯수를 계산
		int QCnt = 0;
		while (en.hasMoreElements()) {
		String name = (String) en.nextElement();
			if (name.indexOf("QuestionPhotoFile") != -1) {
				QCnt++;
				continue;
			}
		}
		
		for(int i=0; i<QCnt;i++)
		{
			pstmt = conn.prepareStatement(sqlInsertQuestionPhoto);
			pstmt.setInt(1, MaxQID);
			pstmt.setInt(2, i + 1);
			pstmt.setString(3, Question_multi.getOriginalFileName("QuestionPhotoFile"+(i+1)));
			pstmt.setString(4, Question_multi.getFilesystemName("QuestionPhotoFile"+(i+1)));
			pstmt.setString(5, SavePath);
			pstmt.executeUpdate();
			pstmt.close();
		}
		response.sendRedirect("QuestionShow.jsp?questionid="+MaxQID+"&pg="+pg);
	}

	catch (SQLException sql) {
		sql.printStackTrace();
		System.out.println(sql.getMessage());
	}
	finally {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
			
		} catch (SQLException sql) {
			System.out.println(sql.getMessage());
		}
	}
	
%>