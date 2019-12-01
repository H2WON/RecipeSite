<%-- charset과 pageEncoding = UTF-8 사용 --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% 
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
	
<title>Insert title here</title>
<title>등록한 Sense 확인하기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

</script>
<style>
	.panel-title{
		color:#0080c0;
		font-weight:bold;
	}
	.title{
		color:#0080c0;
		font-weight:bold;
		float:left;
		font-size:20px;
		margin-bottom:20px;
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
            	<li><a href="Lindex.jsp">Home</a></li>
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
                %>
                
                	<%
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
<%
	PreparedStatement pstmt=null;
	ResultSet rs = null;

	String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useSSL=false&useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC";
	String dbId = "jspid"; //dbid설정
	String dbPass = "jsppass"; //db비밀번호 설정
	
	int recipesenseno = Integer.parseInt(request.getParameter("recipesenseno"));
	
	//db연결   
	try {
		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver"); //Driver로 connection객체와 연결
		// connection 객체 세팅
	
		Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결

		//========================================================================
		String SenseSQL = "select * from RecipeSense where RecipeSense_Id=?";
		
		pstmt = conn.prepareStatement(SenseSQL);
		pstmt.setInt(1,recipesenseno);
		
		rs = pstmt.executeQuery();
		while(rs.next())
		{
			String RecipeSense_Title = rs.getString("RecipeSense_Title");
			String RecipeSense_ThumbnailOriginalName = rs.getString("RecipeSense_ThumbnailOriginalName");
			String RecipeSense_ThumbnailChangeName = rs.getString("RecipeSense_ThumbnailChangeName");
			String RecipeSense_ThumbnailSavePath = rs.getString("RecipeSense_ThumbnailSavePath");
			String RecipeSense_HiddenVideoUrl = rs.getString("RecipeSense_VideoUrl");
			int RecipeSense_Category = rs.getInt("RecipeSense_Category");
			String RecipeSense_Date = rs.getString("RecipeSense_Date");
			
			// 카테고리 values를 String으로 변환시켜 보여주는 변수
			String RecipeSenseCategory_Name = "";
			
			if( RecipeSense_Category == 1)
			{
				RecipeSenseCategory_Name = "육류";
			}
			else if(RecipeSense_Category == 2)
			{
				RecipeSenseCategory_Name = "해물류";
			}
			else if(RecipeSense_Category == 3)
			{
				RecipeSenseCategory_Name = "청과류";
			}
			else if(RecipeSense_Category == 4)
			{
				RecipeSenseCategory_Name = "채소류";
			}
			else
			{
				RecipeSenseCategory_Name = "카테고리";
			}
			
			%>
<div class="main">
    <div class="container tim-container">
        <div id="extras">
            <div class="row">
            	<div class="col-md-12 col-sm-22">
	            	<h1 class="text-center">
	                    <%= RecipeSense_Title %> <br>
	                    <small><%= RecipeSenseCategory_Name %></small>
	                </h1>
	                <div style="float:left;">
	                	<font size="3" style="color:"> 작성일 &nbsp; : &nbsp; <%= RecipeSense_Date %></font>
	                </div>
	        	</div>
            </div>
            <div class="row">
            	<div class="col-md-12 col-sm-22">
            		<hr>
            	</div>
            </div>
            <div class="row">
            	<div class="col-md-6 col-md-offset-0 col-sm-11 col-sm-offset-1">
                    <div class="text-center">
                    	<div class="title">썸네일</div>
                        <img src="\GraduateProject\SenseSavePath\<%= RecipeSense_ThumbnailChangeName %>" width="100%" height="auto" />
                    </div>
                </div>
                <div class="col-md-6 col-sm-11">
                    <div class="text-center">
                    	<div class="title">동영상</div>
                        <iframe width="100%" height="300px" src="<%= RecipeSense_HiddenVideoUrl %>" frameborder="1" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
            <div class="row">
            	<div class="col-md-12 col-sm-22">
					<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseTwo" href="#collapseTwo" data-toggle="gsdk-collapse">
					                	손질 방법
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseTwo" class="panel-collapse collapse">
					        <div class="panel-body">
					        <%
						            	String RecipeSenseStepSQL ="Select * From RecipeSenseStep Where RecipeSense_Id = ? Order by RecipeSenseStep_Id";
						    			
						    			pstmt = conn.prepareStatement(RecipeSenseStepSQL);
						    			pstmt.setInt(1,recipesenseno);
						    			
						    			rs = pstmt.executeQuery();
						    			while(rs.next())
						    			{
						    				
						    				String RecipeSenseStep_Id = rs.getString("RecipeSenseStep_Id");
						    				String RecipeSenseStep_Description = rs.getString("RecipeSenseStep_Description");
						    				String RecipeSenseStep_PhotoChangeName  = rs.getString("RecipeSenseStep_PhotoChangeName");
						    				String RecipeSenseStep_PhotoSavePath  = rs.getString("RecipeSenseStep_PhotoSavePath");
						    				
					    			%>
					    				<div class="text-left">
					    				<div id="circle"> <%= RecipeSenseStep_Id %> </div> <%= RecipeSenseStep_Description %>
					    				</div>
					    				
					    				<div class="text-right">
					    				<img src="\GraduateProject\SenseSavePath\<%= RecipeSenseStep_PhotoChangeName %>" width="50%" height="auto" /> 
					    				</div><hr>
								<% }
			} //Recipe While문 닫는 부분
%>
								</div>
					    	</div>
						</div>
					</div>
            	</div>
            </div>
          	<div class="row" style="margin:10px;">
          		<div class="col-md-12 col-sm-24" style="text-align:center;">
          			<a href="RecipeView.jsp?sub=Recipe_Sense"><img src="./assets/img/golist.PNG"></img> </a>
          			<!-- <a href="RecipeView.jsp?sub=Recipe_Sense"><button class="btn btn-primary"> 목록보기 </button></a> -->
          		</div>
          	</div>
 		</div>
    <!--     end extras -->    
	</div>
</div>
<!-- end container -->
<div class="space-30"></div>
<!-- 댓글 다는 것 -->
<%
		
	String sqlCommentCount = "SELECT COUNT(*) FROM RecipeSenseComment WHERE RecipeSense_Id = ?";
	pstmt = conn.prepareStatement(sqlCommentCount);
	pstmt.setInt(1,recipesenseno);
	rs = pstmt.executeQuery();
	
	Integer CommentCount = 0;
	
	if(rs.next()){
		CommentCount = rs.getInt(1);
	}
%>
<form name="RecipeSenseCommentForm" action="RecipeSenseCommentInsert_Act.jsp?recipesenseno=<%=recipesenseno %>" method="post">
<div class="recipesensecommentmain" style="text-align:center;float:center;">
	<div class="row">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="text-align:Left; font-size:30px;">
			댓글 &nbsp; <font color="#0080c0"><%= CommentCount %></font>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
<%
	if(login != null)
	{
%>
	<div class="row" style="margin-top:10px">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="text-align:Left; size:10px;">
			<textarea name="RecipeSenseCommentContent" placeholder="내용을 입력해 주세요" cols="50" rows="5" style="resize:none; letter-spacing: 1px;" class="form-control"></textarea>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>

	<div class="row" style="margin-top:10px">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="text-align:right; size:10px;">
			<input type="submit" value="댓글쓰기" class="btn btn-info" style=" background-color:rgba(52, 172, 220, 0.98);color:white;">
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
<%
	}
%>
</div>
</form>
<div class="main">
<%	
	String sqlComment = "SELECT RecipeSenseComment_Id,RecipeSenseComment_Content,RecipeSenseComment_Date,RecipeSenseComment_Writer FROM RecipeSenseComment WHERE RecipeSense_Id = ? ORDER BY RecipeSenseComment_Id DESC";
	pstmt = conn.prepareStatement(sqlComment);
	pstmt.setInt(1,recipesenseno);
	rs = pstmt.executeQuery();
	
	Integer RecipeComment_Id;
	String RecipeComment_Content = "";
	String RecipeComment_Date = "";
	String RecipeComment_Writer = "";
	
	
	while(rs.next()){
		RecipeComment_Id = rs.getInt("RecipeSenseComment_Id");
		RecipeComment_Content = rs.getString("RecipeSenseComment_Content");
		RecipeComment_Date = rs.getString("RecipeSenseComment_Date");
		RecipeComment_Writer = rs.getString("RecipeSenseComment_Writer");
%>
		<div class="row" style="margin-top:20px;">
			<div class="col-md-2 col-sm-4">
			</div>
			<div class="col-md-8 col-sm-12" style="align:center; size:10px;">
				<table style="width:80%; align:center;font-size:20px;">
					<tr>
						<a href="MypageForm.jsp?mypageid=<%=RecipeComment_Writer%>">
							<img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:40px;height:40px; margin-right:20px; float:left;">
							<font size="5"><%=RecipeComment_Writer %></font>
						</a>
						&nbsp;&nbsp;작성일 : <%=RecipeComment_Date %>&nbsp;&nbsp;
<%
					
					if(RecipeComment_Writer.equals(userid))
					{
 %>
						<a href="RecipeSenseCommentDelete_Act.jsp?recipesensecommentid=<%=RecipeComment_Id%>&recipesenseno=<%=recipesenseno%>">삭제</a>
<%
					}
%>				
				</tr>
				<tr style="margin-top:10px;">
					<td style="margin-left:40px"><%=RecipeComment_Content %></td>
				</tr>
			</table>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
	<div class="row">
		<div class="col-md-8 col-sm-12" style="align:center; size:10px;">
			<hr>
		</div>
		<div class="col-md-2 col-sm-4">
		</div>
	</div>
<%
	}
		rs.close();
		pstmt.close();
		conn.close();
	}catch (SQLException sql) {
			sql.printStackTrace();
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