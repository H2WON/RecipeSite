<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="assets/img/favicon.png">	
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>TV 레시피 목록 페이지</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
	
    <link href="bootstrap3/css/bootstrap.css" rel="stylesheet" />
	<link href="assets/css/gsdk.css" rel="stylesheet" />  
    <link href="assets/css/demo.css" rel="stylesheet" /> 
    
    <!--     Font Awesome     -->
    <link href="bootstrap3/css/font-awesome.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Grand+Hotel' rel='stylesheet' type='text/css'>
</head>
<body>
<div class="main" style="text-align:center;float:center;">
	<div class="row">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-16">
	        <ul class="nav nav-tabs">
	        	<li><a href="RecipeView.jsp?sub=Recipe_My">My Recipe</a></li>
				<li class="active"><a href="RecipeView.jsp?sub=Recipe_TV">TV Recipe</a></li>
				<li><a href="RecipeView.jsp?sub=Recipe_Sense">요리 상식</a></li>
			</ul>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>

	<div class="row" style="margin-left:200px; margin-right:300px;">
		<div class="col-md-4 col-sm-6">
		   	<a href="Recipe_TVcategory.jsp?category_No=1">
		   		<button class="btn btn-block btn-lg btn-info btn-simple" style="width:150%; height:auto;">
		   		<img src="images/KoreanFood.png" width="170px" height="170px"><p>한식
		   		</button>
		   	</a>
		</div>
		<div class="col-md-4 col-sm-6">
		   <a href="Recipe_TVcategory.jsp?category_No=2">
		   		<button class="btn btn-block btn-lg btn-info btn-simple" style="width:150%; height:auto;">
		   		<img src="images/WesternFood.png" width="170px" height="170px"><p>양식
		   		</button>
		   </a>
		</div>
		<div class="col-md-4 col-sm-6">
		   	<a href="Recipe_TVcategory.jsp?category_No=3">
				<button class="btn btn-block btn-lg btn-info btn-simple" style="width:150%; height:auto;">
		   		<img src="images/ChineseFood.png" width="170px" height="170px"><p>중식
		   		</button>
			</a>
		</div>
	</div>
	
	<div class="row" style="margin-left:200px; margin-right:300px">
	   <div class="col-md-4 col-sm-6">
	   		<a href="Recipe_TVcategory.jsp?category_No=4">
	   			<button class="btn btn-block btn-lg btn-info btn-simple" style="width:150%; height:auto;">
		   		<img src="images/JapaneseFood.png" width="170px" height="170px"><p>일식
		   		</button>
	   		</a>
	   </div>
	   <div class="col-md-4 col-sm-6">
	   		<a href="Recipe_TVcategory.jsp?category_No=5">
	   			<button class="btn btn-block btn-lg btn-info btn-simple" style="width:150%; height:auto;">
		   		<img src="images/SoutheastAsiaFood.png" width="170px" height="170px"><p>동남아
		   		</button>
			</a>
	   </div>
	   <div class="col-md-4 col-sm-6">
	   		<a href="Recipe_TVcategory.jsp?category_No=6">
	   			<button class="btn btn-block btn-lg btn-info btn-simple" style="width:150%; height:auto;">
		   		<img src="images/Dessert.png" width="170px" height="170px"><p>디저트
		   		</button>
	   		</a>
	   </div>
	</div>
</div>
</body>
	<script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>

	<script src="bootstrap3/js/bootstrap.js" type="text/javascript"></script>
	<script src="assets/js/gsdk-checkbox.js"></script>
	<script src="assets/js/gsdk-radio.js"></script>
	<script src="assets/js/gsdk-bootstrapswitch.js"></script>
	<script src="assets/js/get-shit-done.js"></script>
    <script src="assets/js/custom.js"></script>

</html>