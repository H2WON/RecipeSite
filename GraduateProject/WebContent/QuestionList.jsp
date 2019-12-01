<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
    <%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>
<%
	request.setCharacterEncoding("UTF-8");

	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
%>
<%
	final int ROWSIZE = 5;
	final int BLOCK = 3;

	int pg = 1;

	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int start = (pg*ROWSIZE) - (ROWSIZE-1);
	int end = (pg*ROWSIZE);
	
	int allPage = 0;
	
	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;

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
	
<title>Q&A 목록 페이지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<style>
	.content{
	border-top : 1px solid #b0b0b0;
	border-bottom:1px solid #b0b0b0;
	height:45px;
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
<!-- 고정 메뉴 끝 -->
<div class="main">
    <div class="container tim-container" style="width:80%; align:center;">
    	<div class="row">
    		<div class="col-md-2 col-sm-4">
			</div>
			<div class="col-md-8 col-sm-16" style="float:left;">
		    	<h1 style="color:#1f50ab;">Q&A</h1>
		    </div>
			<div class="col-md-2 col-sm-4">
			</div>	
    	</div>
 <%
	if(login != null)
	{
%>
    	<div class="row">
    		<div class="col-md-2 col-sm-4">
			</div>
			<div class="col-md-8 col-sm-16">
		    	<a href="QuestionInsertForm.jsp?pg=<%=pg%>"><button class="btn btn-primary" style="float:right; margin:10px;">글 쓰기</button></a>
			</div>
			<div class="col-md-2 col-sm-4">
			</div>	
    	</div>
<%
	}
%>
    	<div class="row">
    		<div class="col-md-2 col-sm-4">
			</div>
			<div class="col-md-8 col-sm-16">
				<table style="width:100%;align:center;">
					<tr style="font-weight:bold; font-size:15px;text-align:center;border-top:2px solid #b0b0b0;border-bottom:2px solid #b0b0b0;height:40px;">
						<td style="width:10%">No</td>
						<td style="width:50%">제목</td>
						<td style="width:20%">작성자</td>
						<td style="width:20%">등록일</td>
					</tr>
<%
		
			PreparedStatement pstmt=null;
			ResultSet rs = null;
		
			String driverName="com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
			String jdbcid="jspid";
			String jdbcpwd="jsppass";
			int total = 0;
			
			try{
				Class.forName(driverName); 
				Connection conn = DriverManager.getConnection(url,jdbcid,jdbcpwd);
		
				
				String count = "select count(*) from Question";
				pstmt = conn.prepareStatement(count);
				rs= pstmt.executeQuery();
				
				if(rs.next())
				{
					total = rs.getInt(1);
				}
				
				allPage = (int)Math.ceil(total/(double)ROWSIZE);
				
				if(endPage > allPage) {
					endPage = allPage;
				}
				
				String QuestionSQL="SELECT * FROM Question WHERE Question_Id >= "+ start +" and Question_Id <= " +end + " Order by Question_Id Desc";
				
				pstmt = conn.prepareStatement(QuestionSQL);
				
				rs = pstmt.executeQuery();
		
				while(rs.next())
				{
					String Question_Id = rs.getString("Question_Id");
					String Question_Title = rs.getString("Question_Title");
					String Question_Writer = rs.getString("Question_Writer");
					String Question_Date = rs.getString("Question_Date");

					Date date = new Date(); 
					SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); 
					String year = (String)simpleDate.format(date); 
					String yea = Question_Date.substring(0,10);
%>
					<tr style="text-align:center;" class="content">
						<td style="width:10%"><%= Question_Id %></td>
						<td style="width:50%"><%
						if(year.equals(yea)){
						%>
									&nbsp;<img src='./assets/img/new.jpeg' />
						<%
								}  
						%>
						<a href="QuestionShow.jsp?questionid=<%= Question_Id %>&pg=<%=pg%>"> <%= Question_Title %> </a></td>
						<td style="width:20%"><%= Question_Writer %></td>
						<td style="width:20%"><%= Question_Date %></td>
					</tr>
					<%} %>
					<tr>
						<td colspan="4" align="center">
							<ul class="pagination ct-blue"> 
							<%
								if(pg>BLOCK) {
							%>
								<li><a href="QuestionList.jsp?pg=1">&laquo;</a></li>
								<li><a href="QuestionList.jsp?pg=<%=startPage-1%>">&lt;</a></li>
							<%
								}
							%>
							
							<%
								for(int i=startPage; i<= endPage; i++){
									if(i==pg){
							%>
										<li class="active"><a href="QuestionList.jsp?pg=<%=i %>"><%=i %></a></li>
							<%
									}else{
							%>
										 <li><a href="QuestionList.jsp?pg=<%=i %>"><%=i %></a></li>
							<%
									}
								}
							%>
							
							<%
								if(endPage<allPage){
							%>
								<li><a href="QuestionList.jsp?pg=<%=endPage+1%>">&gt;</a></li>
								<li><a href="QuestionList.jsp?pg=<%=allPage%>">&raquo;</a></li>
							<%
								}
							%>
							</ul>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-md-2 col-sm-4">
			</div>	
    	</div>
<%
		conn.close();
		
		}catch(ClassNotFoundException e){
			out.println("Where is your mysql jdbc driver?");
			e.printStackTrace();
			return;
		}
		
%>
</div>
</div> <!-- end main -->

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
                    <div class="modal-footer" style="height:160px">
                        <div class="forgot login-footer">
                        	<br><br><br><br><br><br>
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