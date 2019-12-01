<%-- charset과 pageEncoding = UTF-8 사용 --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
/* 	String login = (String) session.getAttribute("Login");
	String userid = (String) session.getAttribute("UserID");
 */
 	request.setCharacterEncoding("UTF-8"); //한글깨지지말라고

	//DB에 파일이 저장되는 것이 아니라, 파일의 이름과 경로 등등만 DB에 저장되는 것이기 때문에
	//업로드 시킨 파일을 바로 서비스 하기 위해서는 톰캣 서버에 배치시켜야 됨
	//프로젝트 - WebContent - upload 폴더 생성함
	String SavePath = application.getRealPath("SenseSavePath");

	int max = 1024 * 1024 * 80; //업로드 받을 이미지의 최대 크기 10Mb로 용량 제한
	String encoding = "UTF-8"; //인코딩

	MultipartRequest Sense_multi = null;
	Sense_multi = new MultipartRequest(request, SavePath, max, encoding, new DefaultFileRenamePolicy());
%>
<%
String sqlGetMaxSenseID = "SELECT MAX(RECIPESENSE_ID) FROM RECIPESENSE";

String sqlInsertSense = "INSERT INTO RECIPESENSE( " 
		+ "                    RECIPESENSE_ID "
		+ "                   ,RECIPESENSE_TITLE " 
		+ "                   ,RECIPESENSE_THUMBNAILORIGINALNAME "
		+ "                   ,RECIPESENSE_THUMBNAILCHANGENAME "
		+ "                   ,RECIPESENSE_THUMBNAILSAVEPATH "
		+ "                   ,RECIPESENSE_VIDEOURL "
		+ "                   ,RECIPESENSE_CATEGORY "
		+ "                   ,RECIPESENSE_WRITER "
		+ "                   ,RECIPESENSE_DATE " 
		+ "                   ) "
		+ "                   VALUES(?, ?, ?, ?, ?, "
		+ "                          ?, ?, ?, ?) ";


String sqlInsertSenseStep = "INSERT INTO RECIPESENSESTEP( "
		+ "                           RECIPESENSE_ID "
		+ "                          ,RECIPESENSESTEP_ID "
		+ "                          ,RECIPESENSESTEP_DESCRIPTION "
		+ "                          ,RECIPESENSESTEP_PHOTOORIGINALNAME "
		+ "                          ,RECIPESENSESTEP_PHOTOCHANGENAME "
		+ "                          ,RECIPESENSESTEP_PHOTOSAVEPATH "
		+ "                         ) "
		+ "                         VALUES(?, ?, ?, ?, ?, ?)";

//connection객체 생성
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;

	//db연결   
	try {
		String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useSSL=false&useUnicode=true&characterEncoding=utf8"; //db경로설정
		String dbId = "jspid"; //dbid설정
		String dbPass = "jsppass"; //db비밀번호 설정

		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver"); //Driver로 connection객체와 연결
		// connection 객체 세팅
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결

		// Recipe ID를 일치시키기 위해 현재 존재하는 ID의 최대값 사용 ================================================================================
		pstmt = conn.prepareStatement(sqlGetMaxSenseID);
		rs = pstmt.executeQuery();

		int MaxSID = 0;
		if (rs.next()) {
			MaxSID = rs.getInt(1) + 1;
		}

		rs.close();
		pstmt.close();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();

		// Recipe 정보 입력 ==============================================================================================================
		pstmt = conn.prepareStatement(sqlInsertSense);
		pstmt.setInt(1, MaxSID);
		pstmt.setString(2, Sense_multi.getParameterValues("RecipeSense_Title")[0]);
		pstmt.setString(3, Sense_multi.getOriginalFileName("RecipeSense_ThumbnailFile"));
		pstmt.setString(4, Sense_multi.getFilesystemName("RecipeSense_ThumbnailFile"));
		pstmt.setString(5, SavePath);
		pstmt.setString(6, Sense_multi.getParameterValues("RecipeSense_HiddenVideoUrl")[0]);
		pstmt.setString(7, Sense_multi.getParameterValues("RecipeSense_Category")[0]);
		pstmt.setString(8, "TestWriter"); //userid
		pstmt.setString(9, sdf.format(cal.getTime()));
		pstmt.executeUpdate();
		pstmt.close();

		// Cooking 정보 입력 ==============================================================================================================
		int SCnt = Sense_multi.getParameterValues("RecipeSenseStepDescription").length;
		for (int i = 0; i < SCnt; i++) {
			pstmt = conn.prepareStatement(sqlInsertSenseStep);
			pstmt.setInt(1, MaxSID);
			pstmt.setInt(2, i + 1);
			
			String RecipeSenseStepDescription = Sense_multi.getParameterValues("RecipeSenseStepDescription")[i];
			RecipeSenseStepDescription = RecipeSenseStepDescription.replace("\r\n", "<br>");
			pstmt.setString(3, RecipeSenseStepDescription);
			
			//pstmt.setString(3, Sense_multi.getParameterValues("RecipeSenseStepDescription")[i]);
			pstmt.setString(4, Sense_multi.getOriginalFileName("RecipeSenseStepFile" + (i + 1)));
			pstmt.setString(5, Sense_multi.getFilesystemName("RecipeSenseStepFile" + (i + 1)));
			pstmt.setString(6, SavePath);
			pstmt.executeUpdate();
			pstmt.close();
		}

		
		//response.sendRedirect("RecipeSenseShow.jsp?recipesenseno="+MaxSID);
		response.sendRedirect("RecipeSenseForm.jsp");
	}

	catch (SQLException sql) {
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

