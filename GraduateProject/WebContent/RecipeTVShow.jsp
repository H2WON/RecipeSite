<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	request.setCharacterEncoding("UTF-8");

	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");

	String sub = request.getParameter("sub"); 
	if(sub==null) sub = "Recipe_My";
	String subPage = sub + ".jsp?userid=userid"; 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
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
	
	
<title>등록한 레시피 확인하기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

</script>
<style>
	.panel-title{
		color:#0080c0;
		font-weight:bold;
	}
	#circle {
		background-color:#0080c0;
		width:30px;
		height:30px;
		border-radius:75px;
		text-align:center;
		margin-right:10px;
		font-size:20px;
		font-weight:bold;
		color:white;
		float:left;
		clear:left;
	}
	font{
		color:#0080c0;
		font-weight:bold;
	}
</style>

</head>
<body>
<!-- 고정 메뉴 시작 -->
<div id="navbar-full">
    <div class="container">
        <nav class="navbar navbar-ct-blue navbar-transparent navbar-fixed-top" role="navigation">
          
          <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="Lindex.jsp?target=Login_Index">
                	<img src="assets/img/logo.png" style="width:70px;height:70px;transform: skew(0deg, -10deg);">
                </a>
            </div>
        
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            	<ul class="nav navbar-nav">
            	<li class="active"><a href="Lindex.jsp">Home</a></li>
                <li class="dropdown">
                <a href="RecipeView.jsp" class="dropdown-toggle" data-toggle="dropdown">Recipe <b class="caret"></b></a>
                	<ul class="dropdown-menu">
                		<li><a href="RecipeView.jsp?sub=Recipe_My">My Recipe</a></li>
                        <li><a href="RecipeView.jsp?sub=Recipe_TV">TV Recipe</a></li>
                        <li><a href="RecipeView.jsp?sub=Recipe_Sense">요리 상식</a></li>
                	</ul>
                </li>
                <li><a href="QuestionList.jsp">Q&A</a></li>
                <li><a href="EventList.jsp">Event</a></li>
                </ul>
                <%
                if(login == null)
                {
                %>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="javascript:void(0)" onclick="openLoginModal();" class="btn btn-round btn-default" data-toggle="modal">Login/Register</a></li>
                </ul>
                	<%
                }
        				if(login != null)
        				{
        			%>
        				<ul class="nav navbar-nav navbar-right">
        					<li><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:50px;height:50px;margin:5px;"></li>
		                	<li><a href="#gsdk"><%= userid %></a></li>
		                	<li><a href="Logout_Act.jsp" class="btn btn-round btn-default">Log Out</a></li>
		                    <li><a href="MypageForm.jsp?mypageid=<%=userid %>" class="btn btn-round btn-default" data-toggle="modal">MyPage</a></li>
		                </ul>
        			<%
        				}
        			%>              
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
    </div><!--  end container-->
    
    <div class='blurred-container' style="height:100px">
        <div class="background" style="background-color:rgba(52, 172, 220, 0.98); width:100%; height:100px;"></div>
    </div>
    
</div>  
<!-- 고정 메뉴 끝 -->

	<form  method="post" enctype="multipart/form-data" >
<%
	PreparedStatement pstmt=null;
	ResultSet rs = null;

	String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false";
	String dbId = "jspid"; //dbid설정
	String dbPass = "jsppass"; //db비밀번호 설정
	
	int recipeno = Integer.parseInt(request.getParameter("recipeno"));
	
	//db연결   
	try {
		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver"); //Driver로 connection객체와 연결
		// connection 객체 세팅
	
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결

		//========================================================================
		String RecipeSQL = "select * from TvRecipe where TvRecipe_No=?";
		
		pstmt = conn.prepareStatement(RecipeSQL);
		pstmt.setInt(1,recipeno);
		
		rs = pstmt.executeQuery();
		while(rs.next())
		{
			
			String Recipe_Title = rs.getString("TvRecipe_Title");
			String Recipe_Introduce = rs.getString("TvRecipe_Introduce");
			String Recipe_ThumbnailOriginalName = rs.getString("TvRecipe_ThumbnailOriginalName");
			String Recipe_ThumbnailChangeName = rs.getString("TvRecipe_ThumbnailChangeName");
			String Recipe_ThumbnailSavePath = rs.getString("TvRecipe_ThumbnailSavePath");
			int Recipe_TypeCategory = rs.getInt("TvRecipe_TypeCategory");
			int Recipe_SituationCategory = rs.getInt("TvRecipe_SituationCategory");
			int Recipe_MaterialCategory = rs.getInt("TvRecipe_MaterialCategory");
			String Recipe_HiddenVideoUrl = rs.getString("TvRecipe_VideoUrl");
			String Recipe_PersonnelInfo = rs.getString("TvRecipe_PersonnelInfo");
			String Recipe_TimeInfo = rs.getString("TvRecipe_TimeInfo");
			String Recipe_DifficultyInfo = rs.getString("TvRecipe_DifficultyInfo");
			String Recipe_CookingTips = rs.getString("TvRecipe_CookingTips");
			String Recipe_Writer = rs.getString("TvRecipe_Writer");
			String Recipe_Date = rs.getString("TvRecipe_Date");
			
			String Recipe_TypeCategoryName = "";
			String Recipe_SituationCategoryName = "";
			String Recipe_MaterialCategoryName = "";
		
			switch(Recipe_TypeCategory)
			{
				case 1:
					Recipe_TypeCategoryName = "한식";
					break;
				case 2:
					Recipe_TypeCategoryName = "양식";
					break;
				case 3:
					Recipe_TypeCategoryName = "중식";
					break;
				case 4:
					Recipe_TypeCategoryName = "일식";
					break;
				case 5:
					Recipe_TypeCategoryName = "동남아";
					break;
				case 6:
					Recipe_TypeCategoryName = "디저트";
					break;
			}
			
			switch(Recipe_SituationCategory)
			{
				case 1:
					Recipe_SituationCategoryName = "일상";
					break;
				case 2:
					Recipe_TypeCategoryName = "손님접대";
					break;
				case 3:
					Recipe_TypeCategoryName = "영양식";
					break;
				case 4:
					Recipe_TypeCategoryName = "초스피드";
					break;
				case 5:
					Recipe_TypeCategoryName = "다이어트";
					break;
				case 6:
					Recipe_TypeCategoryName = "이유식";
					break;
				case 7:
					Recipe_TypeCategoryName = "도시락";
					break;
				case 8:
					Recipe_TypeCategoryName = "간식";
					break;
			}
			
			switch(Recipe_MaterialCategory)
			{
				case 1:
					Recipe_MaterialCategoryName = "육류";
					break;
				case 2:
					Recipe_MaterialCategoryName = "해물류";
					break;
				case 3:
					Recipe_MaterialCategoryName = "채소류";
					break;
				case 4:
					Recipe_MaterialCategoryName = "곡류";
					break;
				case 5:
					Recipe_MaterialCategoryName = "버섯류";
					break;
				case 6:
					Recipe_MaterialCategoryName = "건어물류";
					break;
				case 7:
					Recipe_MaterialCategoryName = "달걀";
					break;
				case 8:
					Recipe_MaterialCategoryName = "유제품";
					break;
			}
%>
<div class="main">
    <div class="container tim-container">
        <div id="extras">
            <div class="row">
            	<div class="col-md-12 col-sm-22">
	            	<h1 class="text-center">
	                    <%= Recipe_Title %><p><p>
	                    <font size="4px" color="gray" class="subtitle">"<%= Recipe_Introduce %>"</font>
	                </h1>
	                <div style="float:left;">
	                	<font size="3" style="margin-left:20px;" class="font">작성일&nbsp;:&nbsp;<%= Recipe_Date %></font>
	                </div>
                </div>
            </div>
            <div class="row">
            	<div class="col-md-12 col-sm-22">
            		<hr>
            	</div>
            </div>
            <div class="row">
                <div class="col-md-7 col-md-offset-0 col-sm-10 col-sm-offset-1">
                    <div class="text-center">
                        <img src="\GraduateProject\RecipePhotoUpload\<%= Recipe_ThumbnailChangeName %>" width="650px" height="350px" />
                    </div>
                </div>
                <div class="col-md-5 col-sm-12">
               		<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseFour" href="#collapseFour" data-toggle="gsdk-collapse">
					                	인원수
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseFour" class="panel-collapse collapse">
					        	<div class="panel-body">
					            	<%= Recipe_PersonnelInfo%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
					<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseFive" href="#collapseFive" data-toggle="gsdk-collapse">
					                	시간
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseFive" class="panel-collapse collapse">
					        	<div class="panel-body">
					            	<%= Recipe_TimeInfo%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
					<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseSix" href="#collapseSix" data-toggle="gsdk-collapse">
					                	난이도
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseSix" class="panel-collapse collapse">
					        	<div class="panel-body">
					            	<%= Recipe_DifficultyInfo%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
					<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseSeven" href="#collapseSeven" data-toggle="gsdk-collapse">
					                	요리팁
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseSeven" class="panel-collapse collapse">
					        	<div class="panel-body">
					            	<%= Recipe_CookingTips%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
                </div>
            </div>
            <div class="row">
            	<div class="col-md-12 col-sm-22">
            		<hr>
            	</div>
            </div>
            <div class="row">
                <div class="col-md-7 col-md-offset-0 col-sm-10 col-sm-offset-1">
                    <div class="text-center">
                        <div>
						 	<iframe width="100%" height="400px" src="<%= Recipe_HiddenVideoUrl %>" frameborder="1" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
						</div>
                    </div>
                </div>
                <div class="col-md-5 col-sm-12">
                	<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseOne" href="#collapseOne" data-toggle="gsdk-collapse">
					                	재료양
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseOne" class="panel-collapse collapse">
					        	<div class="panel-body">
					            	<%
										String RecipeIngredientSQL ="Select * From TvRecipeIngredient Where TvRecipe_No = ? Order by TvRecipeIngredient_No";
										
										pstmt = conn.prepareStatement(RecipeIngredientSQL);
										pstmt.setInt(1,recipeno);
										
										rs = pstmt.executeQuery();
										while(rs.next())
										{
											
											String RecipeIngredient_No = rs.getString("TvRecipeIngredient_No");
											String RecipeIngredient_Name = rs.getString("TvRecipeIngredient_Name");
											String RecipeIngredient_Quantity  = rs.getString("TvRecipeIngredient_Quantity");
											
									%>
											
									<div style="margin-bottom:20px;"><div id="circle"> <%= RecipeIngredient_No %> </div> <%= RecipeIngredient_Name %>&nbsp;:&nbsp;<%= RecipeIngredient_Quantity %></div>
									<% }%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
					<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseTwo" href="#collapseTwo" data-toggle="gsdk-collapse">
					                	조리방법
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseTwo" class="panel-collapse collapse">
					        	<div class="panel-body">
					            	<%
						            	String RecipeCookingSQL ="Select * From TvRecipeCooking Where TvRecipe_No = ? Order by TvRecipeCooking_No";
						    			
						    			pstmt = conn.prepareStatement(RecipeCookingSQL);
						    			pstmt.setInt(1,recipeno);
						    			
						    			rs = pstmt.executeQuery();
						    			while(rs.next())
						    			{
						    				
						    				String RecipeCooking_No = rs.getString("TvRecipeCooking_No");
						    				String RecipeCooking_Description = rs.getString("TvRecipeCooking_Description");
						    				String RecipeCooking_PhotoChangeName  = rs.getString("TvRecipeCooking_PhotoChangeName");
						    				String RecipeCooking_PhotoSavePath  = rs.getString("TvRecipeCooking_PhotoSavePath");
						    				
					    			%>
					    				<div id="circle"> <%= RecipeCooking_No %> </div><br><br><font size="4px" color="black"><%= RecipeCooking_Description %></font><br><p><p>
					    				<img src="\GraduateProject\RecipePhotoUpload\<%= RecipeCooking_PhotoChangeName %>" width="100%" height="auto" /> 
					    				<hr>
					    			
									<% }%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
					<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseThree" href="#collapseThree" data-toggle="gsdk-collapse">
					                	완성사진
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseThree" class="panel-collapse collapse">
					        	<div class="panel-body">
					            	<%
										String RecipeFinishedPhotoSQL ="Select * From TvRecipeFinishedPhoto Where TvRecipe_No = ? Order by TvRecipeFinishedPhoto_No";
				                	
										pstmt = conn.prepareStatement(RecipeFinishedPhotoSQL);
										pstmt.setInt(1,recipeno);
										
										rs = pstmt.executeQuery();
										while(rs.next())
										{
											
											String RecipeFinishedPhoto_No = rs.getString("TvRecipeFinishedPhoto_No");
											String RecipeFinishedPhoto_ChangeName = rs.getString("TvRecipeFinishedPhoto_ChangeName");
											String RecipeFinishedPhoto_SavePath   = rs.getString("TvRecipeFinishedPhoto_SavePath");
											
									%>
										<div style="margin-bottom:20px;"><div id="circle"> <%= RecipeFinishedPhoto_No %></div><br><br><img src="\GraduateProject\RecipePhotoUpload\<%= RecipeFinishedPhoto_ChangeName %>" width="100%" height="auto" /></div>
									<%}
		} //TVRecipe While문 닫는 부분
%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
                </div>
            </div>
            <div class="row">
            	<div class="col-md-12 col-sm-22">
            		<hr>
            	</div>
            </div>
             <div class="row" style="margin:10px;">
            	<div class="col-md-12 col-sm-24" style="text-align:center;">
            		<a href="RecipeView.jsp?sub=Recipe_TV"><img src="./assets/img/golist.PNG"></img> </a>
            	</div>
            </div>
        </div>
    <!--     end extras -->    
    </div>
<!-- end container -->
<div class="space-30"></div>
</div>
</form>
<!-- 댓글 다는 것 -->
<%
		
	String sqlCommentCount = "SELECT COUNT(*) FROM TVRecipeComment WHERE TVRecipe_No = ?";
	pstmt = conn.prepareStatement(sqlCommentCount);
	pstmt.setInt(1,recipeno);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		Integer CommentCount = rs.getInt(1);

if(login != null)
{
%>
<form name="TVRecipeCommentForm" action="RecipeTVCommentInsert_Act.jsp?recipeno=<%=recipeno %>" method="post">
<div class="TVRecipecommentmain" style="text-align:center;float:center;">
	<div class="row">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="text-align:Left; font-size:30px;">
			댓글 &nbsp; <font color="#0080c0;"><%= CommentCount%></font>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
	<div class="row" style="margin-top:10px">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="text-align:Left; size:10px;">
			<textarea name="TVRecipeCommentContent" placeholder="내용을 입력해 주세요" cols="50" rows="5" style="resize:none; letter-spacing: 1px;" class="form-control"></textarea>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
	<div class="row" style="margin-top:10px">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="text-align:right; size:10px;">
			<input type="submit" value="댓글쓰기" class="btn btn-info" style="background-color:rgba(52, 172, 220, 0.98);color:white;">
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
</div>
</form>

<%
	}
}
%>
<div class="main">
<%	
	String sqlComment = "SELECT TVRecipeComment_Id,TVRecipeComment_Content,TVRecipeComment_Date,TVRecipeComment_Writer FROM TVRecipeComment WHERE TVRecipe_No = ? ORDER BY TVRecipeComment_Id DESC";
	pstmt = conn.prepareStatement(sqlComment);
	pstmt.setInt(1,recipeno);
	rs = pstmt.executeQuery();
	
	while(rs.next()){
		Integer TVRecipeComment_Id = rs.getInt("TVRecipeComment_Id");
		String TVRecipeComment_Content = rs.getString("TVRecipeComment_Content");
		String TVRecipeComment_Date = rs.getString("TVRecipeComment_Date");
		String TVRecipeComment_Writer = rs.getString("TVRecipeComment_Writer");
%>
	<div class="row" style="margin-top:20px;">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="align:center; size:10px;">
			<table style="width:80%; align:center;font-size:20px;">
				<tr>
					<a href="MypageForm.jsp?mypageid=<%=TVRecipeComment_Writer%>"><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:40px;height:40px;margin-right:20px; float:left;"><font size="5"><%=TVRecipeComment_Writer %></font></a>
					&nbsp;&nbsp;작성일 : <%=TVRecipeComment_Date %>&nbsp;&nbsp;
<%
					if(TVRecipeComment_Writer.equals(userid))
					{
						%>
						<a href="RecipeTVCommentDelete_Act.jsp?tvrecipecommentid=<%=TVRecipeComment_Id%>&recipeno=<%=recipeno%>">삭제</a>
						<%
					}
%>
				</tr>
				<tr style="margin-top:10px;">
					<td style="margin-left:40px"><%=TVRecipeComment_Content %></td>
				</tr>
			</table>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
	<div class="row">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="align:center; size:10px;">
			<hr>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
<%
	}
%>
</div>			
<%
		conn.close();

	}catch (SQLException sql) {
			out.println("What?");
			System.out.println(sql.getMessage());
			return;
		}

%>
<!-- Start Login -->
<div class="login">
		 <div class="modal fade login" id="loginModal">
		      <div class="modal-dialog login animated">
    		      <div class="modal-content">
    		         <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Login</h4>
                    </div>
                    <div class="modal-body">
                        <div class="box">
                             <div class="content">
                                <div class="error"></div>
                                <div class="form loginBox">
                                    <form id="LoginForm" name="LoginForm" method="post" action="Login_Act.jsp" accept-charset="UTF-8">
                                    <input id="Lid" class="form-control" type="text" placeholder="Id" name="Lid">
                                    <input id="Lpassword" class="form-control" type="password" placeholder="Password" name="Lpassword">
                                    <input id="login-btn" class="btn btn-default btn-login" type="submit" value="Login" >
                                    </form>
                                </div>
                             </div>
                        </div>
                        <div class="box">
                            <div class="content registerBox" style="display:none;">
                             <div class="form">
                                <form method="post" action="Join_Act.jsp" accept-charset="UTF-8"> <!--  html="{:multipart=>true}" data-remote="true" -->
                                <input id="Jid" class="form-control" type="text" placeholder="Id" name="Jid">
                                <input id="Jname" class="form-control" type="text" placeholder="Name" name="Jname">
                                <input id="Jpassword" class="form-control" type="password" placeholder="Password" name="Jpassword">
                                <input id="Jpassword_confirmation" class="form-control" type="password" placeholder="Repeat Password" name="Jpassword_confirmation">
                                	<div class="alert-success" id="alert-success">비밀번호가 일치합니다.</div>
                                	<div class="alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
                                <input class="btn btn-default btn-register" type="submit" value="Create account" name="commit" id="register-btn">
                                </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="forgot login-footer">
                            <span>Looking to
                                 <a href="javascript: showRegisterForm();">create an account</a>
                            ?</span>
                        </div>
                        <div class="forgot register-footer" style="display:none">
                             <span>Already have an account?</span>
                             <a href="javascript: showLoginForm();">Login</a>
                        </div>
                    </div>
    		      </div>
		      </div>
		  </div>
    </div>
<!-- End Login -->

</body>

    <script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>

	<script src="bootstrap3/js/bootstrap.js" type="text/javascript"></script>
	<script src="assets/js/gsdk-checkbox.js"></script>
	<script src="assets/js/gsdk-radio.js"></script>
	<script src="assets/js/gsdk-bootstrapswitch.js"></script>
	<script src="assets/js/get-shit-done.js"></script>
    <script src="assets/js/custom.js"></script>

<script type="text/javascript">
         
    $('.btn-tooltip').tooltip();
    $('.label-tooltip').tooltip();
    $('.pick-class-label').click(function(){
        var new_class = $(this).attr('new-class');  
        var old_class = $('#display-buttons').attr('data-class');
        var display_div = $('#display-buttons');
        if(display_div.length) {
        var display_buttons = display_div.find('.btn');
        display_buttons.removeClass(old_class);
        display_buttons.addClass(new_class);
        display_div.attr('data-class', new_class);
        }
    });
    $( "#slider-range" ).slider({
		range: true,
		min: 0,
		max: 500,
		values: [ 75, 300 ],
	});
	$( "#slider-default" ).slider({
			value: 70,
			orientation: "horizontal",
			range: "min",
			animate: true
	});
	$('.carousel').carousel({
      interval: 2000
    });
	
	//회원가입 비밀번호 확인
	$(function(){
        $("#alert-success").hide();
        $("#alert-danger").hide();
        $("input").keyup(function(){
            var pwd=$("#Jpassword").val();
            var pwdcon=$("#Jpassword_confirmation").val();
            if(pwd != "" || pwdcon != ""){
                if(pwd == pwdcon){
                    $("#alert-success").show();
                    $("#alert-danger").hide();
                    $("#register-btn").removeAttr("disabled");
                }else{
                    $("#alert-success").hide();
                    $("#alert-danger").show();
                    $("#register-btn").attr("disabled", "disabled");
                }    
            }
        });
    });
</script>
</html>