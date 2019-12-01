<%-- charset과 pageEncoding = EUC-KR 사용 --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<title>등록한 레시피 확인하기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

</script>
<style>
</style>

</head>
<body>
<div>

	<form  method="post" enctype="multipart/form-data" >
			<div>
			<h1>Recipe Reading</h1>

<%
	PreparedStatement pstmt=null;
	ResultSet rs = null;

	String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false"; //db경로설정
	String dbId = "jspid"; //dbid설정
	String dbPass = "jsppass"; //db비밀번호 설정
	
%>
<%
	//db연결   
	try {
		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver"); //Driver로 connection객체와 연결
		// connection 객체 세팅
	
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결

		/* 
		코드ㅡ 테이블에서 가져오려고 시도했던 부분
		String RecipeTypeCategorySQL ="select * from RecipeTypeCategory";
		
		pstmt = conn.prepareStatement(RecipeTypeCategorySQL);
		
		rs = pstmt.executeQuery();
		int RecipeTypeCategory_No = rs.getInt("RecipeTypeCategory_No");
		String RecipeTypeCategory_Name = rs.getString("RecipeTypeCategory_Name"); */
		
		
		//========================================================================
		//Recipe_No=? 이렇게 해서 클릭 된 레시피 보여주기
		String RecipeSQL ="select * from Recipe where Recipe_No = 24";
		
		pstmt = conn.prepareStatement(RecipeSQL);
		
		rs = pstmt.executeQuery();
		while(rs.next())
		{
			
			String Recipe_Title = rs.getString("Recipe_Title");
			String Recipe_Introduce = rs.getString("Recipe_Introduce");
			String Recipe_ThumbnailOriginalName = rs.getString("Recipe_ThumbnailOriginalName");
			String Recipe_ThumbnailChangeName = rs.getString("Recipe_ThumbnailChangeName");
			String Recipe_ThumbnailSavePath = rs.getString("Recipe_ThumbnailSavePath");
			String Recipe_HiddenVideoUrl = rs.getString("Recipe_VideoUrl");
			int Recipe_TypeCategory = rs.getInt("Recipe_TypeCategory");
			int Recipe_SituationCategory = rs.getInt("Recipe_SituationCategory");
			int Recipe_MaterialCategory = rs.getInt("Recipe_MaterialCategory");
			String Recipe_PersonnelInfo = rs.getString("Recipe_PersonnelInfo");
			String Recipe_TimeInfo = rs.getString("Recipe_TimeInfo");
			String Recipe_DifficultyInfo = rs.getString("Recipe_DifficultyInfo");
			String Recipe_CookingTips = rs.getString("Recipe_CookingTips");
			String Recipe_Date = rs.getString("Recipe_Date");
			
			// 카테고리 values를 String으로 변환시켜 보여주는 변수
			String RecipeTypeCategory_Name = "";
			String RecipeSituationCategory_Name = "";
			String RecipeMaterialCategory_Name = "";
			
			//종류별============================================
			if( Recipe_TypeCategory == 1)
			{
				RecipeTypeCategory_Name = "국";
			}
			else if(Recipe_TypeCategory == 2)
			{
				RecipeTypeCategory_Name = "탕";
			}
			else if(Recipe_TypeCategory == 3)
			{
				RecipeTypeCategory_Name = "찜";
			}
			else if(Recipe_TypeCategory == 4)
			{
				RecipeTypeCategory_Name = "찌개";
			}
			else if(Recipe_TypeCategory == 5)
			{
				RecipeTypeCategory_Name = "반찬";
			}
			else if(Recipe_TypeCategory == 6)
			{
				RecipeTypeCategory_Name = "밥";
			}
			else if(Recipe_TypeCategory == 7)
			{
				RecipeTypeCategory_Name = "죽";
			}
			else if(Recipe_TypeCategory == 8)
			{
				RecipeTypeCategory_Name = "면";
			}
			else if(Recipe_TypeCategory == 9)
			{
				RecipeTypeCategory_Name = "퓨전";
			}
			else if(Recipe_TypeCategory == 10)
			{
				RecipeTypeCategory_Name = "빵";
			}
			else if(Recipe_TypeCategory == 11)
			{
				RecipeTypeCategory_Name = "샐러드";
			}
			else if(Recipe_TypeCategory == 12)
			{
				RecipeTypeCategory_Name = "디저트";
			}
			else
			{
				RecipeTypeCategory_Name = "종류별";
			}
			
			
			//상황별============================================
			if( Recipe_SituationCategory == 1)
			{
				RecipeSituationCategory_Name = "일상";
			}
			else if(Recipe_SituationCategory == 2)
			{
				RecipeSituationCategory_Name = "손님접대";
			}
			else if(Recipe_SituationCategory == 3)
			{
				RecipeSituationCategory_Name = "영양식";
			}
			else if(Recipe_SituationCategory == 4)
			{
				RecipeSituationCategory_Name = "초스피드";
			}
			else if(Recipe_SituationCategory == 5)
			{
				RecipeSituationCategory_Name = "다이어트";
			}
			else if(Recipe_SituationCategory == 6)
			{
				RecipeSituationCategory_Name = "이유식";
			}
			else if(Recipe_SituationCategory == 7)
			{
				RecipeSituationCategory_Name = "도시락";
			}
			else if(Recipe_SituationCategory == 8)
			{
				RecipeSituationCategory_Name = "간식";
			}
			else
			{
				RecipeSituationCategory_Name = "상황별";
			}
			
			
			//재료별============================================
			if( Recipe_MaterialCategory == 1)
			{
				RecipeMaterialCategory_Name = "육류";
			}
			else if(Recipe_MaterialCategory == 2)
			{
				RecipeMaterialCategory_Name = "해물류";
			}
			else if(Recipe_MaterialCategory == 3)
			{
				RecipeMaterialCategory_Name = "채소류";
			}
			else if(Recipe_MaterialCategory == 4)
			{
				RecipeMaterialCategory_Name = "곡류";
			}
			else if(Recipe_MaterialCategory == 5)
			{
				RecipeMaterialCategory_Name = "버섯류";
			}
			else if(Recipe_MaterialCategory == 6)
			{
				RecipeMaterialCategory_Name = "건어물류";
			}
			else if(Recipe_MaterialCategory == 7)
			{
				RecipeMaterialCategory_Name = "달걀류";
			}
			else if(Recipe_MaterialCategory == 8)
			{
				RecipeMaterialCategory_Name = "유제품";
			}
			else
			{
				RecipeMaterialCategory_Name = "재료별";
			}
					
					
					
			out.println("Success1");
			%>
			제목 : <%= Recipe_Title %> <br>
			한줄소개 : <%= Recipe_Introduce %> <br>
			썸네일 : <img src="\RecipeWriting\RecipePhotoUpload\<%= Recipe_ThumbnailChangeName %>" width="110px" height="110px" /><br/>
			동영상 :<div>
			 <iframe width="300" height="200" src="<%= Recipe_HiddenVideoUrl %>" frameborder="1" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
			종류별 : <%= RecipeTypeCategory_Name %> <br>
			상황별 : <%= RecipeSituationCategory_Name %> <br>
			재료별 : <%= RecipeMaterialCategory_Name %> <br>
			인원 : <%= Recipe_PersonnelInfo %> <br>
			시간 : <%= Recipe_TimeInfo %> <br>
			난이도 : <%= Recipe_DifficultyInfo %> <br>
			요리팁 : <%= Recipe_CookingTips %>
			날짜 : <%= Recipe_Date %> <br>
								
			<%
	
			String RecipeIngredientSQL ="Select * From RecipeIngredient Where Recipe_No = 24 Order by RecipeIngredient_No";
			
			pstmt = conn.prepareStatement(RecipeIngredientSQL);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				
				String RecipeIngredient_No = rs.getString("RecipeIngredient_No");
				String RecipeIngredient_Name = rs.getString("RecipeIngredient_Name");
				String RecipeIngredient_Quantity  = rs.getString("RecipeIngredient_Quantity");
				
				out.println("Success2"); 
				%>
				
				재료명 : <%= RecipeIngredient_No %> <%= RecipeIngredient_Name %> <br>
				재료양 : <%= RecipeIngredient_No %> <%= RecipeIngredient_Quantity %> <br> <hr>

			<%
			}
			String RecipeCookingSQL ="Select * From RecipeCooking Where Recipe_No = 24 Order by RecipeCooking_No";
			
			pstmt = conn.prepareStatement(RecipeCookingSQL);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				
				String RecipeCooking_No = rs.getString("RecipeCooking_No");
				String RecipeCooking_Description = rs.getString("RecipeCooking_Description");
				String RecipeCooking_PhotoChangeName  = rs.getString("RecipeCooking_PhotoChangeName");
				String RecipeCooking_PhotoSavePath  = rs.getString("RecipeCooking_PhotoSavePath");
				
				out.println("Success3"); 
				%>
				조리방법  <%= RecipeCooking_No %> : <%= RecipeCooking_Description %> <br> <hr>
				
				이미지 <%= RecipeCooking_No %> :  <img src="\RecipeWriting\RecipePhotoUpload\<%= RecipeCooking_PhotoChangeName %>" width="110px" height="110px" /><br/> <br>
				
			<%
			}
			
			String RecipeFinishedPhotoSQL ="Select * From RecipeFinishedPhoto Where Recipe_No = 24 Order by RecipeFinishedPhoto_No";
			
			pstmt = conn.prepareStatement(RecipeFinishedPhotoSQL);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				
				String RecipeFinishedPhoto_No = rs.getString("RecipeFinishedPhoto_No");
				String RecipeFinishedPhoto_ChangeName = rs.getString("RecipeFinishedPhoto_ChangeName");
				String RecipeFinishedPhoto_SavePath   = rs.getString("RecipeFinishedPhoto_SavePath");
				
				out.println("Success4"); 
				%>
				완성사진  <%= RecipeFinishedPhoto_No %> : <img src="\RecipeWriting\RecipePhotoUpload\<%= RecipeFinishedPhoto_ChangeName %>" width="110px" height="110px" /><br/> <br>
				
			<%
			}
	} //Recipe While문 닫는 부분
		conn.close();
	

	}catch (SQLException sql) {
			out.println("What?");
			System.out.println(sql.getMessage());
			return;
		}

		
%>
			</div>
	</form>
</div>
</body>
</html>