<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	//로그인이 안돼있는 경우 index 페이지로 돌아감 
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery.min.js"></script> <!-- 이미지 미리보기 할 때 필요한 script -->
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
<script type="text/javascript">

//Question 첨부파일 동적 추가하는 부분============================================================================================================================
QuestionPhoto_cnt = 0;
 function QuestionPhoto_AddItem()
 {
	 QuestionPhoto_cnt++;
	 QuestionPhotodiv = document.createElement('QuestionPhotodiv'); //div id값 받아오는 부분
	 QuestionPhotodiv.className = 'row';
	 QuestionPhotodiv.innerHTML += "<br>" + "첨부파일 #"
	 	+ QuestionPhoto_cnt
		+ "<img name=QuestionPhoto id=QuestionPhoto"+ QuestionPhoto_cnt +" src='' style='width:30%;'/>"
		+ "&nbsp;&nbsp;"
		+ "<input type=file name=QuestionPhotoFile"+ QuestionPhoto_cnt + " id=QuestionPhotoPreview"+ QuestionPhoto_cnt +" accept='.jpeg, .jpg, .jpe, .jfif, .PNG, .png, .img' />"
		+ "&nbsp;&nbsp;"
		+ "<input type=button value='X' onclick='QuestionPhoto_removeRow(this)' style='font-weight:bold; font-size:10px;' class='btn btn-primary btn-fill' /> <hr>";
		
		document.getElementById('QuestionPhotodiv').appendChild(QuestionPhotodiv); //Input 값 유지시켜주는 부분	

		
		$(function() {
			$('#QuestionPhotoPreview' + QuestionPhoto_cnt).on('change', function() {
				ReadQuestionPhotoURL(this);
			}); 
		});

		function ReadQuestionPhotoURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#QuestionPhoto'+ QuestionPhoto_cnt).attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}

		}
		
 }
 //Question 동적으로 추가한 행 삭제
 function QuestionPhoto_removeRow(input)
 {
	 document.getElementById('QuestionPhotodiv').removeChild(input.parentNode);
	 QuestionPhoto_cnt--;
 }

//비밀글 체크와 비밀번호 입력하게 하는 부분============================================================================================================================

function check(box){
     if($("input:checkbox[id='checkSecret']").is(":checked")== true){
    	 document.getElementById("Stext").style.display="block";
    	
		} 
     else{

    	 document.getElementById("Stext").style.display="none";

     }
} 

// 등록 시 빈칸 검사============================================================================================================================
 function WriteCheck()
 {
	var form = document.QuestionForm;
	if(!form.Question_Title.value)
		{
		alert("제목을 입력해 주세요");
		form.Question_Title.focus();
		return false;
		}
	if(!form.Question_Content.value)
		{
		alert("내용을 입력해 주세요");
		form.Question_Content.focus();
		return false;
		}
	 form.submit();
 }
	
</script>
<style>
#Stext
{
	display: none;
}
input{
	height:40px;
}
.row{
	margin:10px;
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
                <ul class="nav navbar-nav navbar-right">
                	<li><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:50px;height:50px;margin:5px;"></li>
                	<li><a href="#gsdk"><%= userid %></a></li>
                	<li><a href="Logout_Act.jsp" class="btn btn-round btn-default">Log Out</a></li>
                    <li><a href="MypageForm.jsp?mypageid=<%=userid %>" class="btn btn-round btn-default" data-toggle="modal">MyPage</a></li>
                </ul>
              
            </div><!-- /.navbar-collapse -->
          </div><!-- /.container-fluid -->
        </nav>
    </div><!--  end container-->
    
    <div class='blurred-container' style="height:100px">
        <div class="background" style="background-color:rgba(52, 172, 220, 0.98); width:100%; height:150px;"></div>
    </div>
    
</div>  
<!-- 고정 메뉴 끝 --> 

<div class="main">

	<div class="space-30"></div>

	<div class="container tim-container" style=" width:70%; align:center; margin-top:10px;">
		<form name="QuestionForm" action="Question_Act.jsp?pg=<%=pg %>" method="post" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-12 col-sm-24">
					<div align="center"><h1 style="color:#1f50ab;">Q&A 작성</h1></div>
				</div>
			</div>
			<div class="row" style="margin-top:20px;">
				<div class="col-md-2 col-sm-4">
		    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;font-size:20px;">
	    					제목
	    				</button>
		    		</div>
		    	<div class="col-md-10 col-sm-20">
		    		<input type=text name="Question_Title" placeholder="제목을 입력해 주세요" class="form-control">
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-sm-4">
		    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;font-size:20px;">
		    				내용
		    			</button>
		    		</div>
		    	<div class="col-md-10 col-sm-20">
		    		<textarea name="Question_Content" placeholder="내용을 입력해 주세요" cols="100" rows="20" style="resize:none; letter-spacing: 1px;" class="form-control"></textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-sm-4">
		    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;font-size:20px;">
		    				첨부사진
		    			</button>
		    		</div>
		    	<div class="col-md-10 col-sm-20">
		    		<div id="QuestionPhotodiv" style="align:left;"></div>
		    		<input type="button" value="파일 추가하기" onclick="QuestionPhoto_AddItem()" class="btn btn-primary btn-round">
		    	</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-sm-24">
					<hr>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 col-sm-24" style="text-align:center;">
					<input type="button" value="글쓰기" onclick="WriteCheck();" class="btn btn-success"/>
				</div>
			</div>
		</form>
	</div>
</div> 
</body>
</html>