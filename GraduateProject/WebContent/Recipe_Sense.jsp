<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="assets/img/favicon.png">	
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>Get Shit Done Kit by Creative Tim</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
	
    <link href="bootstrap3/css/bootstrap.css" rel="stylesheet" />
	<link href="assets/css/gsdk.css" rel="stylesheet" />  
    <link href="assets/css/demo.css" rel="stylesheet" /> 
    
    <!--     Font Awesome     -->
    <link href="bootstrap3/css/font-awesome.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Grand+Hotel' rel='stylesheet' type='text/css'>
    
    <!-- 로그인 관련 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<link href="assets/css/login-register.css" rel="stylesheet" />
	<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">

	<script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/login-register.js" type="text/javascript"></script>
	<script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>

	<script src="bootstrap3/js/bootstrap.js" type="text/javascript"></script>
	<script src="assets/js/gsdk-checkbox.js"></script>
	<script src="assets/js/gsdk-radio.js"></script>
	<script src="assets/js/gsdk-bootstrapswitch.js"></script>
	<script src="assets/js/get-shit-done.js"></script>
    <script src="assets/js/custom.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
%>
</head>
<body>
<div class="main" style="text-align:center;float:center;">
	<div class="row">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8">              
	        <ul class="nav nav-tabs">
	        	<li><a href="RecipeView.jsp?sub=Recipe_My">My Recipe</a></li>
				<li><a href="RecipeView.jsp?sub=Recipe_TV">TV Recipe</a></li>
				<li class="active"><a href="RecipeView.jsp?sub=Recipe_Sense">요리 상식</a></li>
			</ul>
		</div>	
		<div class="col-md-2">
			
		</div>	
	</div>	
	
	<div class="row">
		<div class="col-md-2 col-sm-3">
		</div>
		<%
		int CountRow = 0;
	
		String driverName = "com.mysql.jdbc.Driver";
		String dbURL = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";	
		try {
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(dbURL, "jspid", "jsppass");
		
			String sql = "select RecipeSense_Id,RecipeSense_Title,RecipeSense_ThumbnailChangeName from RecipeSense order by RecipeSense_Id DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
	 		{
				Integer RecipeSense_Id = rs.getInt("RecipeSense_Id");
				String RecipeSense_Title = rs.getString("RecipeSense_Title");
				String RecipeSense_ThumbnailChangeName = rs.getString("RecipeSense_ThumbnailChangeName");
				
	 			if(CountRow % 4 == 0)
	 			{
	 	%>
	 </div>
	 <div class="row">
	 	<div class="col-md-2 col-sm-3">
		</div>
	 	<%		}
	 	%>
		 <div class="col-md-2 col-sm-3">
		 	<a href="RecipeSenseShow.jsp?recipesenseno=<%=RecipeSense_Id %>">
		 		<button class="btn btn-block btn-lg btn-info btn-simple" style="width:250px;height:250px;">
		 			<img src="\GraduateProject\SenseSavePath\<%= RecipeSense_ThumbnailChangeName %>" class="img-rounded" width="170px" height="140px" />
		 			<p><%= RecipeSense_Title %>
		 		</button>
		 	</a>
		 </div>
		<%
		 		CountRow++;
	 		}
	 	%>
	</div>
		<div class="col-md-2 col-sm-3">
		</div>
		<%
    			rs.close();
    			pstmt.close();
    			con.close();
    			
    		} catch (SQLException e) {
    			out.println("Sql Where is your mysql jdbc driver?");
    			e.printStackTrace();
    			e.printStackTrace();
    		} catch (ClassNotFoundException e) {
    			out.println("Class Where is your mysql jdbc driver?");
    			e.printStackTrace();
    		}
         %>	
		<div class="col-md-2">
		</div>	
</div>
</body>
	

</html>