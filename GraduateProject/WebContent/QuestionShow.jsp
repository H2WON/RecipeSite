<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%

	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	int questionid = Integer.parseInt(request.getParameter("questionid")); //QuestionList에서 Question_Id 받아오기
	
	int pg = Integer.parseInt(request.getParameter("pg"));

%>
	<%

		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
	
		String driverName="com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc-kr&serverTimezone=UTC&useSSL=false";
		String jdbcid="jspid";
		String jdbcpwd="jsppass";
		String QuestionCommentInsertSQL ="INSERT INTO QUESTIONCOMMENT("
									+ "QUESTION_ID,"
									+ "QUESTIONCOMMENT_ID,"
									+ "QUESTIONCOMMENT_WRITER,"
									+ "QUESTIONCOMMENT_CONTENT,"
									+ "QUESTIONCOMMENT_DATE)"
									+ "VALUES (?,?,?,?,?)";
							
		
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
	
<title>Q&A 내용 페이지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

function check()
{
	if(QuestionCommentForm.QuestionComment_Content.value == "")
	{
		alert('댓글 내용을 입력하세요');
		QuestionCommentForm.QuestionComment_Content.focus();
		return false;
	}
}

function goBack(){
   /*  window.history.back(); */
   location.href="QuestionList.jsp?pg="+pg;
}

</script>
<style>
	.panel-title{
		color:rgba(52, 172, 220, 0.98);
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
                if(login != null)
                	{	
                %>
                <ul class="nav navbar-nav navbar-right">
                	<li><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:50px;height:50px;margin:5px;"></li>
                	<li><a href="MypageForm.jsp"><%= userid %></a></li>
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
<div class="main">
		<%
		try{
			
			String jdbcUrl = "jdbc:mysql://localhost:3309/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
			String dbId = "jspid"; //dbid설정
			String dbPass = "jsppass"; //db비밀번호 설정

			//드라이버 로딩
			Class.forName("com.mysql.jdbc.Driver"); //Driver로 connection객체와 연결
			// connection 객체 세팅
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
		
			String QuestionSQL="SELECT * FROM Question WHERE Question_Id=?";
			pstmt = conn.prepareStatement(QuestionSQL);
			pstmt.setInt(1,questionid);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				String Question_Title = rs.getString("Question_Title");
				String Question_Writer = rs.getString("Question_Writer");
				String Question_Date = rs.getString("Question_Date");
				String Question_Content = rs.getString("Question_Content");
				String Question_Secret = rs.getString("Question_Secret");

		%>
            <div class="row">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12">
					<h1 class="text-center">
                    	<%= Question_Title %> 
                	</h1>
                	<div style="float:left;">
	                	<a href="MypageForm.jsp?mypageid=<%=Question_Writer%>"><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:40px;height:40px;margin-right:10px;float:left;"><font size="5"><%=Question_Writer %></font></a>
	                	<font size="3" style="margin-left:20px;">작성일&nbsp;:&nbsp;<%= Question_Date %></font>
	                </div>
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12">
					<hr>
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12" style="margin-left:20px;margin-right:20px;">
					<%= Question_Content %>
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12">
					<hr>
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12">
					<div class="panel-group">
						<div class="panel panel-default">
					    	<div class="panel-heading">
					       		<h4 class="panel-title">
					             	<a data-target="#collapseFour" href="#collapseFour" data-toggle="gsdk-collapse">
					                	첨부사진
					             	</a>
					        	</h4>
					        </div>
					    	<div id="collapseFour" class="panel-collapse collapse">
					        	<div class="panel-body">
<%
			
									String QuestionPhotoSQL = "Select * From QUESTIONPHOTO Where Question_Id = ?";
									
									pstmt = conn.prepareStatement(QuestionPhotoSQL);
									pstmt.setInt(1,questionid);
									rs = pstmt.executeQuery();
									
									while(rs.next())
									{
										String QuestionPhoto_Id = rs.getString("QuestionPhoto_Id");
										String QuestionPhoto_ChangeName = rs.getString("QuestionPhoto_ChangeName");
										String QuestionPhoto_SavePath   = rs.getString("QuestionPhoto_SavePath");
%>
					        		<div id="circle"> <%= QuestionPhoto_Id %> </div> &nbsp;
					            	<img src ="\GraduateProject\QuestionSavePath\<%= QuestionPhoto_ChangeName  %>" width="50%" height="auto" />
<%
									} //QuestionPhoto 닫는부분
							
%>
									<div class="space-30"></div>
								</div>
					    	</div>
						</div>
					</div>
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>
			<div class="row" style="margin-top:20px;">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12" style="text-align:center;">
					<button onclick="window.location='QuestionList.jsp?pg=<%=pg %>'" class="btn btn-info">목록보기</button> &nbsp;
					<%
						if(login != null)
							if(userid.equals(Question_Writer))
							{
						%>
							<input type=button value="삭제" OnClick="window.location='QuestionDelete_Act.jsp?questionid=<%=questionid%>&pg=<%=pg%>'" class="btn btn-danger">
						<%
							}
					
			} //Question 닫는부분
						%>
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>				
</div>
<!-- Question 게시물 내용 보여주는 곳 end -->
<%
		
	String sqlCommentCount = "SELECT COUNT(*) FROM QUESTIONCOMMENT WHERE Question_Id = ?";
	pstmt = conn.prepareStatement(sqlCommentCount);
	pstmt.setInt(1,questionid);
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		Integer CommentCount = rs.getInt(1);
	
%>
		<form name="QuestionCommentForm" method="post" onsubmit="return check()" action="QuestionComment_Act.jsp?questionid=<%= questionid %>&pg=<%= pg %>" >
			<div class="row">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12" style="text-align:Left; font-size:30px;">
					댓글 &nbsp; <font color="#0080c0;"><%= CommentCount%></font>
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
					<textarea name="QuestionComment_Content" id="QuestionComment_Content" placeholder="댓글 내용을 입력해 주세요" cols="70" rows="3" style="resize:none; letter-spacing: 1px;" class="form-control"></textarea>
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>
			<div class="row" style="margin-top:10px">
				<div class="col-md-2 col-sm-4">
				</div>
				<div class="col-md-8 col-sm-12" style="text-align:right; size:10px;">
					<input type="submit" value="댓글쓰기" class="btn btn-info" style="align:center; background-color:rgba(52, 172, 220, 0.98);color:white;">
				</div>
				<div class="col-md-2 col-sm-4">
				</div>
			</div>
		</form>
<%
	}
}
%>	
<div class="main">			
<%
	String QuestionCommentSQL = "Select * From QUESTIONCOMMENT Where Question_Id = ? Order By QuestionComment_Id desc";
	
	pstmt = conn.prepareStatement(QuestionCommentSQL);
	pstmt.setInt(1,questionid);
					
	rs = pstmt.executeQuery();
	while(rs.next())
		{
			String QuestionComment_Id = rs.getString("QuestionComment_Id");
			String QuestionComment_Writer = rs.getString("QuestionComment_Writer");
			String QuestionComment_Content = rs.getString("QuestionComment_Content");
			String QuestionComment_Date = rs.getString("QuestionComment_Date");
%>
	<div class="row" style="margin-top:20px;">
		<div class="col-md-2 col-sm-4">
		</div>
		<div class="col-md-8 col-sm-12" style="align:center; size:10px;">
			<table style="width:80%; align:center;font-size:20px;">
				<tr>
					<a href="MypageForm.jsp?mypageid=<%=QuestionComment_Writer%>"><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:40px;height:40px;margin-right:20px; float:left;"><font size="5"><%=QuestionComment_Writer %></font></a>
					&nbsp;&nbsp;작성일 : <%=QuestionComment_Date %>&nbsp;&nbsp;
<%
					if(QuestionComment_Writer.equals(userid))
					{
						%>
						<a href="QuestionCommentDelete_Act.jsp?questionccommentid=<%=QuestionComment_Id%>&questionid=<%=questionid%>&pg=<%=pg%>">삭제</a>
						<%
					}
%>
				</tr>
				<tr style="margin-top:10px;">
					<td style="margin-left:40px"><%=QuestionComment_Content %></td>
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
				
		rs.close();
		pstmt.close();
		conn.close();
					
		}catch(Exception e){
			out.println("Where is your mysql jdbc driver?");
			out.println(e.getMessage());
			e.printStackTrace();
		}
%>
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