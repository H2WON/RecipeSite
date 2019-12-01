<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%

String target = request.getParameter("target"); 
if(target==null) target = "Login_Index";
String targetPage = target + ".jsp?userid=userid"; 

%>
<!doctype html>
<html lang="en">
<head>
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
<%
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	}
%>
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
                <a href="Lindex.jsp">
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
                <ul class="nav navbar-nav navbar-right">
                	<li><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:50px;height:50px;margin:5px;"></li>
                	<li><a href="MypageForm.jsp"><%= userid %></a></li>
                	<li><a href="Logout_Act.jsp" class="btn btn-round btn-default">Log Out</a></li>
                    <li><a href="MypageForm.jsp" class="btn btn-round btn-default">MyPage</a></li>
                </ul>
              
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
    </div><!--  end container-->
    
    <!-- 배경 로고 -->
    <div class='blurred-container'>
        <div class="motto">
        	<div class="border">오</div><p>
            <div style="margin-bottom:5px;">늘</div>
            <div class="border">뭐</div>
            <div class="border">먹</div>
            <div>지?</div>
        </div>
        <div class="img-src" style="background-image: url('assets/img/background.jpg');"></div>
        <div class='img-src blur' style="background-image: url('assets/img/background_blur.jpg')"></div>
    </div> 
</div>     

<jsp:include page="<%= targetPage %>" flush="false" />


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
      interval: 4000
    });
	
	//회원가입 비밀번호 확인
	$(function(){
        $("#alert-success").hide();
        $("#alert-danger").hide();
        $("input").keyup(function(){
            var pwd=$("#Rpassword").val();
            var pwdcon=$("#Rpassword_confirmation").val();
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