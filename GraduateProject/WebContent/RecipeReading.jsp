<%-- charset�� pageEncoding = EUC-KR ��� --%>
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

<title>����� ������ Ȯ���ϱ�</title>
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

	String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false"; //db��μ���
	String dbId = "jspid"; //dbid����
	String dbPass = "jsppass"; //db��й�ȣ ����
	
%>
<%
	//db����   
	try {
		//����̹� �ε�
		Class.forName("com.mysql.jdbc.Driver"); //Driver�� connection��ü�� ����
		// connection ��ü ����
	
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //������ �ε��� ����̹��� ������ connection��ü�� ����

		/* 
		�ڵ�� ���̺��� ���������� �õ��ߴ� �κ�
		String RecipeTypeCategorySQL ="select * from RecipeTypeCategory";
		
		pstmt = conn.prepareStatement(RecipeTypeCategorySQL);
		
		rs = pstmt.executeQuery();
		int RecipeTypeCategory_No = rs.getInt("RecipeTypeCategory_No");
		String RecipeTypeCategory_Name = rs.getString("RecipeTypeCategory_Name"); */
		
		
		//========================================================================
		//Recipe_No=? �̷��� �ؼ� Ŭ�� �� ������ �����ֱ�
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
			
			// ī�װ� values�� String���� ��ȯ���� �����ִ� ����
			String RecipeTypeCategory_Name = "";
			String RecipeSituationCategory_Name = "";
			String RecipeMaterialCategory_Name = "";
			
			//������============================================
			if( Recipe_TypeCategory == 1)
			{
				RecipeTypeCategory_Name = "��";
			}
			else if(Recipe_TypeCategory == 2)
			{
				RecipeTypeCategory_Name = "��";
			}
			else if(Recipe_TypeCategory == 3)
			{
				RecipeTypeCategory_Name = "��";
			}
			else if(Recipe_TypeCategory == 4)
			{
				RecipeTypeCategory_Name = "�";
			}
			else if(Recipe_TypeCategory == 5)
			{
				RecipeTypeCategory_Name = "����";
			}
			else if(Recipe_TypeCategory == 6)
			{
				RecipeTypeCategory_Name = "��";
			}
			else if(Recipe_TypeCategory == 7)
			{
				RecipeTypeCategory_Name = "��";
			}
			else if(Recipe_TypeCategory == 8)
			{
				RecipeTypeCategory_Name = "��";
			}
			else if(Recipe_TypeCategory == 9)
			{
				RecipeTypeCategory_Name = "ǻ��";
			}
			else if(Recipe_TypeCategory == 10)
			{
				RecipeTypeCategory_Name = "��";
			}
			else if(Recipe_TypeCategory == 11)
			{
				RecipeTypeCategory_Name = "������";
			}
			else if(Recipe_TypeCategory == 12)
			{
				RecipeTypeCategory_Name = "����Ʈ";
			}
			else
			{
				RecipeTypeCategory_Name = "������";
			}
			
			
			//��Ȳ��============================================
			if( Recipe_SituationCategory == 1)
			{
				RecipeSituationCategory_Name = "�ϻ�";
			}
			else if(Recipe_SituationCategory == 2)
			{
				RecipeSituationCategory_Name = "�մ�����";
			}
			else if(Recipe_SituationCategory == 3)
			{
				RecipeSituationCategory_Name = "�����";
			}
			else if(Recipe_SituationCategory == 4)
			{
				RecipeSituationCategory_Name = "�ʽ��ǵ�";
			}
			else if(Recipe_SituationCategory == 5)
			{
				RecipeSituationCategory_Name = "���̾�Ʈ";
			}
			else if(Recipe_SituationCategory == 6)
			{
				RecipeSituationCategory_Name = "������";
			}
			else if(Recipe_SituationCategory == 7)
			{
				RecipeSituationCategory_Name = "���ö�";
			}
			else if(Recipe_SituationCategory == 8)
			{
				RecipeSituationCategory_Name = "����";
			}
			else
			{
				RecipeSituationCategory_Name = "��Ȳ��";
			}
			
			
			//��Ằ============================================
			if( Recipe_MaterialCategory == 1)
			{
				RecipeMaterialCategory_Name = "����";
			}
			else if(Recipe_MaterialCategory == 2)
			{
				RecipeMaterialCategory_Name = "�ع���";
			}
			else if(Recipe_MaterialCategory == 3)
			{
				RecipeMaterialCategory_Name = "ä�ҷ�";
			}
			else if(Recipe_MaterialCategory == 4)
			{
				RecipeMaterialCategory_Name = "���";
			}
			else if(Recipe_MaterialCategory == 5)
			{
				RecipeMaterialCategory_Name = "������";
			}
			else if(Recipe_MaterialCategory == 6)
			{
				RecipeMaterialCategory_Name = "�Ǿ��";
			}
			else if(Recipe_MaterialCategory == 7)
			{
				RecipeMaterialCategory_Name = "�ް���";
			}
			else if(Recipe_MaterialCategory == 8)
			{
				RecipeMaterialCategory_Name = "����ǰ";
			}
			else
			{
				RecipeMaterialCategory_Name = "��Ằ";
			}
					
					
					
			out.println("Success1");
			%>
			���� : <%= Recipe_Title %> <br>
			���ټҰ� : <%= Recipe_Introduce %> <br>
			����� : <img src="\RecipeWriting\RecipePhotoUpload\<%= Recipe_ThumbnailChangeName %>" width="110px" height="110px" /><br/>
			������ :<div>
			 <iframe width="300" height="200" src="<%= Recipe_HiddenVideoUrl %>" frameborder="1" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
			������ : <%= RecipeTypeCategory_Name %> <br>
			��Ȳ�� : <%= RecipeSituationCategory_Name %> <br>
			��Ằ : <%= RecipeMaterialCategory_Name %> <br>
			�ο� : <%= Recipe_PersonnelInfo %> <br>
			�ð� : <%= Recipe_TimeInfo %> <br>
			���̵� : <%= Recipe_DifficultyInfo %> <br>
			�丮�� : <%= Recipe_CookingTips %>
			��¥ : <%= Recipe_Date %> <br>
								
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
				
				���� : <%= RecipeIngredient_No %> <%= RecipeIngredient_Name %> <br>
				���� : <%= RecipeIngredient_No %> <%= RecipeIngredient_Quantity %> <br> <hr>

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
				�������  <%= RecipeCooking_No %> : <%= RecipeCooking_Description %> <br> <hr>
				
				�̹��� <%= RecipeCooking_No %> :  <img src="\RecipeWriting\RecipePhotoUpload\<%= RecipeCooking_PhotoChangeName %>" width="110px" height="110px" /><br/> <br>
				
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
				�ϼ�����  <%= RecipeFinishedPhoto_No %> : <img src="\RecipeWriting\RecipePhotoUpload\<%= RecipeFinishedPhoto_ChangeName %>" width="110px" height="110px" /><br/> <br>
				
			<%
			}
	} //Recipe While�� �ݴ� �κ�
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