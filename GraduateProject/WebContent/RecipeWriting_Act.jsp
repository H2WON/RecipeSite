<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
	String login = (String) session.getAttribute("Login");
	String userid = (String) session.getAttribute("UserID");
	request.setCharacterEncoding("UTF-8");
	
	System.out.println(login);
	System.out.println(userid);
	
	//DB에 파일이 저장되는 것이 아니라, 파일의 이름과 경로 등등만 DB에 저장되는 것이기 때문에
	//업로드 시킨 파일을 바로 서비스 하기 위해서는 톰캣 서버에 배치시켜야 됨
	//프로젝트 - WebContent - upload 폴더 생성함
	String SavePath = application.getRealPath("RecipePhotoUpload");
	
	int max = 1024 * 1024 * 80; //업로드 받을 이미지의 최대 크기 10Mb로 용량 제한
	String encoding = "utf-8"; //인코딩

	MultipartRequest Recipe_multi = null;
	Recipe_multi = new MultipartRequest(request, SavePath, max, encoding, new DefaultFileRenamePolicy());
%>

<%
	String sqlGetMaxRecipeID = "SELECT MAX(RECIPE_NO) FROM RECIPE";

	String sqlInsertRecipe = "INSERT INTO RECIPE( " 
			+ "                    RECIPE_NO "
			+ "                   ,RECIPE_TITLE " 
			+ "                   ,RECIPE_INTRODUCE "
			+ "                   ,RECIPE_THUMBNAILORIGINALNAME "
			+ "                   ,RECIPE_THUMBNAILCHANGENAME "
			+ "                   ,RECIPE_THUMBNAILSAVEPATH "
			+ "                   ,RECIPE_VIDEOURL "
			+ "                   ,RECIPE_PERSONNELINFO "
			+ "                   ,RECIPE_TIMEINFO " 
			+ "                   ,RECIPE_DIFFICULTYINFO "
			+ "                   ,RECIPE_COOKINGTIPS "
			+ "                   ,RECIPE_WRITER "
			+ "                   ,RECIPE_DATE " 
			+ "                   ) "
			+ "                   VALUES(?, ?, ?, ?, ?, "
			+ "                          ?, ?, ?, ?, ?, "
			+ "                          ?, ?, ?)";

	String sqlInsertRecipeIngredient = "INSERT INTO RECIPEINGREDIENT( "
			+ "                               RECIPE_NO "
			+ "                              ,RECIPEINGREDIENT_NO "
			+ "                              ,RECIPEINGREDIENT_NAME "
			+ "                              ,RECIPEINGREDIENT_QUANTITY "
			+ "                             ) "
			+ "                             VALUES(?, ?, ?, ?)";

	String sqlInsertRecipeCooking = "INSERT INTO RECIPECOOKING( "
			+ "                           RECIPE_NO "
			+ "                          ,RECIPECOOKING_NO "
			+ "                          ,RECIPECOOKING_DESCRIPTION "
			+ "                          ,RECIPECOOKING_PHOTOORIGINALNAME "
			+ "                          ,RECIPECOOKING_PHOTOCHANGENAME "
			+ "                          ,RECIPECOOKING_PHOTOSAVEPATH "
			+ "                         ) "
			+ "                         VALUES(?, ?, ?, ?, ?, ?)";

	String sqlInsertRecipeFinishPhoto = "INSERT INTO RECIPEFINISHEDPHOTO( "
			+ "                               RECIPE_NO "
			+ "                              ,RECIPEFINISHEDPHOTO_NO "
			+ "                              ,RECIPEFINISHEDPHOTO_ORIGINALNAME "
			+ "                              ,RECIPEFINISHEDPHOTO_CHANGENAME "
			+ "                              ,RECIPEFINISHEDPHOTO_SAVEPATH " + "                             ) "
			+ "                             VALUES(?, ?, ?, ?, ?)";

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
		pstmt = conn.prepareStatement(sqlGetMaxRecipeID);
		rs = pstmt.executeQuery();

		int MaxRID = 0;
		if (rs.next()) {
			MaxRID = rs.getInt(1) + 1;
		}

		rs.close();
		pstmt.close();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();

		// Recipe 정보 입력 ==============================================================================================================
		pstmt = conn.prepareStatement(sqlInsertRecipe);
		pstmt.setInt(1, MaxRID);
		pstmt.setString(2, Recipe_multi.getParameterValues("Recipe_Title")[0]);
		pstmt.setString(3, Recipe_multi.getParameterValues("Recipe_Introduce")[0]);
		pstmt.setString(4, Recipe_multi.getOriginalFileName("Recipe_ThumbnailFile"));
		pstmt.setString(5, Recipe_multi.getFilesystemName("Recipe_ThumbnailFile"));
		pstmt.setString(6, SavePath);
		pstmt.setString(7, Recipe_multi.getParameterValues("Recipe_HiddenVideoUrl")[0]);
		pstmt.setString(8, Recipe_multi.getParameterValues("Recipe_PersonnelInfo")[0]);
		pstmt.setString(9, Recipe_multi.getParameterValues("Recipe_TimeInfo")[0]);
		pstmt.setString(10, Recipe_multi.getParameterValues("Recipe_DifficultyInfo")[0]);
		pstmt.setString(11, Recipe_multi.getParameterValues("Recipe_CookingTips")[0]);
		pstmt.setString(12, userid);
		pstmt.setString(13, sdf.format(cal.getTime()));
		pstmt.executeUpdate();
		pstmt.close();

		// Ingredient 정보 입력 ==============================================================================================================
		int ICnt = Recipe_multi.getParameterValues("IngredientName").length;
		for (int i = 0; i < ICnt; i++) {
			pstmt = conn.prepareStatement(sqlInsertRecipeIngredient);
			pstmt.setInt(1, MaxRID);
			pstmt.setInt(2, i + 1);
			pstmt.setString(3, Recipe_multi.getParameterValues("IngredientName")[i]);
			pstmt.setString(4, Recipe_multi.getParameterValues("IngredientQuantity")[i]);
			pstmt.executeUpdate();
			pstmt.close();
		}

		// Cooking 정보 입력 ==============================================================================================================
		int CCnt = Recipe_multi.getParameterValues("CookingDescription").length;
		for (int i = 0; i < CCnt; i++) {
			pstmt = conn.prepareStatement(sqlInsertRecipeCooking);
			pstmt.setInt(1, MaxRID);
			pstmt.setInt(2, i + 1);
			
			String CookingDescription = Recipe_multi.getParameterValues("CookingDescription")[i];
			CookingDescription = CookingDescription.replace("\r\n", "<br>");
			pstmt.setString(3, CookingDescription);
			
			//pstmt.setString(3, Recipe_multi.getParameterValues("CookingDescription")[i]);
			pstmt.setString(4, Recipe_multi.getOriginalFileName("Recipe_CookingFile" + (i + 1)));
			pstmt.setString(5, Recipe_multi.getFilesystemName("Recipe_CookingFile" + (i + 1)));
			pstmt.setString(6, SavePath);
			pstmt.executeUpdate();
			pstmt.close();
		}

		// FinishedPhoto 정보 입력 ==============================================================================================================	

		//STEP 이미지 파일 부분 (각각의 갯수를 체크하기 위해 사용)
		Enumeration<?> en = Recipe_multi.getFileNames();

		// 결과사진의 갯수를 계산
		int FCnt = 0;
		while (en.hasMoreElements()) {
			String name = (String) en.nextElement();
			if (name.indexOf("Recipe_FinishedPhotoFile") != -1) {
				FCnt++;
				continue;
			}
		}

		for (int i = 0; i < FCnt; i++) {
			pstmt = conn.prepareStatement(sqlInsertRecipeFinishPhoto);
			pstmt.setInt(1, MaxRID);
			pstmt.setInt(2, i + 1);
			pstmt.setString(3, Recipe_multi.getOriginalFileName("Recipe_FinishedPhotoFile" + (i + 1)));
			pstmt.setString(4, Recipe_multi.getFilesystemName("Recipe_FinishedPhotoFile" + (i + 1)));
			pstmt.setString(5, SavePath);
			pstmt.executeUpdate();
			//response.sendRedirect("RecipeReading.jsp");
			pstmt.close();
		}
		
		out.println("<script>");
		out.println("alert(SavePath)");
		out.println("</script>");
				
		response.sendRedirect("RecipeShow.jsp?recipeno="+MaxRID);
	}

	catch (SQLException sql) {
		System.out.println(sql.getMessage());
		sql.printStackTrace();
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
			sql.printStackTrace();
		}
	}
	
%>

