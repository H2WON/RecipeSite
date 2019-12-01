<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.sql.*"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="assets/img/favicon.png">	
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title>Recipe WebSite</title>

	
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
	
	<!-- <script type="text/javascript">
		function check(){
			frm = document.LoginForm;
			if(frm.Lid.value==""||frm.Lpassword.value=="")
			{
				shakeModal();
			}else{
				out.println(frm.Lid.value);
				frm.action="Login_Act.jsp";
				frm.submit();
			}
			
		}
	</script> -->
	
</head>
<body>

<!-- 상단 고정 메뉴바 -->
<div id="navbar-full">
    <div class="container">
        <nav class="navbar navbar-ct-orange navbar-transparent navbar-fixed-top" role="navigation">
          
          <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="index.jsp">
                	<img src="assets/img/logo.png" style="width:70px;height:70px;transform: skew(0deg, -10deg);">
                </a>
            </div>
        
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            	<ul class="nav navbar-nav" style="font-size:20px;text-align:center;">
	            	<li class="active"><a href="index.jsp">Home</a></li>
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
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="javascript:void(0)" onclick="openLoginModal();" class="btn btn-round btn-default" data-toggle="modal">Login/Register</a></li>
                </ul>
              
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
    </div><!--  end container-->
    
    <div class='blurred-container'>
        <div class="motto">
        	<div class="border">오</div><p>
            <div style="margin-bottom:5px;">늘</div>
            <div class="border">뭐</div>
            <div class="border">먹</div>
            <div>지?</div>
        </div>
        <div class="img-src" style="background-image: url('assets/img/background.jpg');"></div>
        <div class='img-src blur' style="background-image: url('assets/img/background_blur.jpg');"></div>
    </div> 
</div>     
<!-- 상단 고정 메뉴바  끝 -->

<div class="main">
    <div class="container tim-container">
    	<div class="row" style="margin-top:20px;margin-bottom:10px;">
    		<div class="col-md-8 col-sm-4">
    			<h2>My Recipe</h2>
    		</div>
    		<div class="col-md-2 col-sm-4">
    		</div>
    		<div class="col-md-2 col-sm-4">
    			<a href="RecipeView.jsp?sub=Recipe_My"><button class="btn btn-block btn-lg btn-round" style="width:120px; height:50px;">더 보기</button></a>
    		</div>
    	</div>
       	<div class="row" style="color:#454545;">
       	<%
	       	ResultSet rs = null;
			PreparedStatement pstmt = null;
		
			String driverName = "com.mysql.jdbc.Driver";
			String dbURL = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
	
			try {
				Class.forName(driverName);
				Connection con = DriverManager.getConnection(dbURL, "jspid", "jsppass");
				
				String sql_MyRecipe = "SELECT Recipe_No,Recipe_Title,Recipe_ThumbnailChangeName FROM Recipe ORDER BY Recipe_Date DESC LIMIT 4";
				String sql_TvRecipe = "SELECT TvRecipe_No, TvRecipe_Title, TvRecipe_ThumbnailChangeName From TvRecipe ORDER BY TvRecipe_Date DESC LIMIT 4";
				String sql_RandomEasyRecipe = "SELECT TvRecipe_No, TvRecipe_Title, TvRecipe_ThumbnailChangeName FROM TvRecipe WHERE TvRecipe_DifficultyInfo = ?";
				String sql_Sense = "SELECT RecipeSense_Id, RecipeSense_Title, RecipeSense_ThumbnailChangeName FROM RecipeSense ORDER BY RecipeSense_Date DESC LIMIT 4";
				
				//쉬운 레시피를 랜덤으로 찍기 위한 ArrayList
				ArrayList<Integer> EasyRecipe_No = new ArrayList<Integer>();
				ArrayList<String> EasyRecipe_Title = new ArrayList<String>();
				ArrayList<String> EasyRecipe_ThumbnailChangeName = new ArrayList<String>();
				
				Random random = new Random();
				
				//MyRecipe 최신순 4개
				pstmt = con.prepareStatement(sql_MyRecipe);
				rs = pstmt.executeQuery();
	
				while(rs.next())
				{
					Integer Recipe_No = rs.getInt("Recipe_No");
					String Recipe_Title = rs.getString("Recipe_Title");
					String Recipe_ThumbnailChangeName = rs.getString("Recipe_ThumbnailChangeName");
				
		%>
					<div class="col-md-3 col-sm-4">
			        	<a href="RecipeShow.jsp?recipeno=<%=Recipe_No %>">
		 				<button class="btn btn-block btn-lg btn-info btn-simple">
		 					<img src="\GraduateProject\RecipePhotoUpload\<%= Recipe_ThumbnailChangeName %>" class="img-rounded" width="180px" height="180px" />
		 					<p><br><font size="4px"><%= Recipe_Title %></font>
		 				</button>
		 			</a>
			        </div>
		<%
				}
		%>
		</div>
				<div class="row" style="margin-top:5px;">
    				<div class="col-md-12 col-sm-12">
    					<hr>
    				</div>
    			</div>
				
				<div class="row" style="margin-top:20px;margin-bottom:10px;">
		    		<div class="col-md-8 col-sm-4">
		    			<h2>TV Recipe</h2>
		    		</div>
		    		<div class="col-md-2 col-sm-4">
		    		</div>
		    		<div class="col-md-2 col-sm-4">
		    			<a href="RecipeView.jsp?sub=Recipe_TV"><button class="btn btn-block btn-lg btn-round" style="width:120px; height:50px;">더 보기</button></a>
		    		</div>
		    	</div>
				<div class="row" style="color:#454545;">
		<%
				//TvRecipe 최신순 4개
				pstmt = con.prepareStatement(sql_TvRecipe);
				rs = pstmt.executeQuery();
	
				while(rs.next())
				{
					Integer TvRecipe_No = rs.getInt("TvRecipe_No");
					String TvRecipe_Title = rs.getString("TvRecipe_Title");
					String TvRecipe_ThumbnailChangeName = rs.getString("TvRecipe_ThumbnailChangeName");
				
		%>
					<div class="col-md-3 col-sm-4">
			        	<a href="RecipeTVShow.jsp?recipeno=<%=TvRecipe_No %>">
		 				<button class="btn btn-block btn-lg btn-info btn-simple">
		 					<img src="\GraduateProject\RecipePhotoUpload\<%= TvRecipe_ThumbnailChangeName %>" class="img-rounded" width="180px" height="180px" />
		 					<p><br><font size="4px"><%= TvRecipe_Title %></font>
		 				</button>
		 			</a>
			        </div>
		<%
				}
		%>
				</div>
				
				<div class="row" style="margin-top:5px;">
    				<div class="col-md-12 col-sm-12">
    					<hr>
    				</div>
    			</div>
    			
    			<div class="row" style="margin-top:20px;margin-bottom:10px;">
		    		<div class="col-md-9 col-sm-4">
		    			<h2>요리상식</h2>
		    		</div>
		    		<div class="col-md-1 col-sm-4">
		    		</div>
		    		<div class="col-md-2 col-sm-4">
		    			<a href="RecipeView.jsp?sub=Recipe_Sense"><button class="btn btn-block btn-lg btn-round" style="width:120px; height:50px;">더 보기</button></a>
		    		</div>
		    	</div>
				<div class="row" style="color:#454545;">
		<% 
				//요리상식 최신순 4개
				pstmt = con.prepareStatement(sql_Sense);
				rs = pstmt.executeQuery();
	
				while(rs.next())
				{
					Integer RecipeSense_Id = rs.getInt("RecipeSense_Id");
					String RecipeSense_Title = rs.getString("RecipeSense_Title");
					String RecipeSense_ThumbnailChangeName = rs.getString("RecipeSense_ThumbnailChangeName");
				
		%>
					<div class="col-md-3 col-sm-4">
			        	<a href="RecipeShow.jsp?recipeno=<%=RecipeSense_Id %>">
		 				<button class="btn btn-block btn-lg btn-info btn-simple">
		 					<img src="\GraduateProject\SenseSavePath\<%= RecipeSense_ThumbnailChangeName %>" class="img-rounded" width="180px" height="180px" />
		 					<p><br><font size="4px"><%= RecipeSense_Title %></font>
		 				</button>
		 			</a>
			        </div>
		<%
				}
		%>
				</div>
				
				<div class="row" style="margin-top:5px;">
    				<div class="col-md-12 col-sm-12">
    					<hr>
    				</div>
    			</div>
    			
    			<div class="row" style="margin-top:20px;margin-bottom:10px;">
		    		<div class="col-md-9 col-sm-4">
		    			<h2>쉬운 레시피</h2>
		    		</div>
		    		<div class="col-md-1 col-sm-4">
		    		</div>
		    		<div class="col-md-2 col-sm-4">
		    			<a href="RecipeView.jsp?sub=Recipe_TV"><button class="btn btn-block btn-lg btn-round" style="width:120px; height:50px;">더 보기</button></a>
		    		</div>
		    	</div>
    	<%
				//쉬운 레시피 랜덤 4개
				pstmt = con.prepareStatement(sql_RandomEasyRecipe);
    			pstmt.setString(1,"★");
				rs = pstmt.executeQuery();

				while(rs.next())
				{
					EasyRecipe_No.add(rs.getInt("TvRecipe_No"));
					EasyRecipe_Title.add(rs.getString("TvRecipe_Title"));
					EasyRecipe_ThumbnailChangeName.add(rs.getString("TvRecipe_ThumbnailChangeName"));
				}
				
				//0 ~ ArrayList EasyRecipe_No 사이즈까지 난수 발생
				int ran = random.nextInt(EasyRecipe_No.size());
				
				for(int i=0; i<4; i++)
				{
		%>
					<div class="col-md-3 col-sm-4">
		        		<a href="RecipeTVShow.jsp?recipeno=<%= EasyRecipe_No.get(ran) %>">
	 						<button class="btn btn-block btn-lg btn-info btn-simple">
	 							<img src="\GraduateProject\RecipePhotoUpload\<%= EasyRecipe_ThumbnailChangeName.get(ran) %>" class="img-rounded" width="180px" height="180px" />
	 							<p><br><font size="4px"><%= EasyRecipe_Title.get(ran) %></font>
	 						</button>
	 					</a>
		        	</div>
		<%
					ran = random.nextInt(EasyRecipe_No.size());
				}
		%>
				</div>
		<%
				rs.close();
    			pstmt.close();
    			con.close();
    			
    		} catch (SQLException e) {
    			out.println("Sql Where is your mysql jdbc driver?");
    			e.printStackTrace();
    		} catch (ClassNotFoundException e) {
    			out.println("Class Where is your mysql jdbc driver?");
    			e.printStackTrace();
    		}
       	%>
	</div>

<div class="parallax-pro">
    <div class="img-src" style="background-image: url('http://get-shit-done-pro.herokuapp.com/assets/img/bg6.jpg');"></div>
    <div class="container">
        <div class="row">

            <div class="col-md-6 col-md-offset-3 col-md-12 text-center">
                 <div class="actions">
                     <a class="btn btn-lg btn-warning btn-fill" id="top" href="#">GO TOP</a>
                </div>
            </div>
        </div>
        <div class="space-30"></div>
        <div class="row">
             <div class="col-md-12 text-center">
                <div class="credits">
                    Copyright &copy; <script>document.write(new Date().getFullYear())</script> by Team H<sup>3</sup> All Rights Reserved<i class="fa fa-heart heart" alt="love"></i>
                </div>
            </div>
        </div>
    </div>

</div>




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