<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	}
	
	String driverName = "com.mysql.jdbc.Driver";
	String dbURL = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC&useSSL=false";
	String dbId = "jspid"; 
	String dbPass = "jsppass"; 

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
	<link rel="icon" type="image/png" href="assets/img/favicon.png">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <link href="bootstrap3/css/bootstrap.css" rel="stylesheet" />
	<link href="assets/css/gsdk.css" rel="stylesheet" />  
    <link href="assets/css/demo.css" rel="stylesheet" />
    <link href="bootstrap3/css/font-awesome.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Grand+Hotel' rel='stylesheet' type='text/css'>
	
	<script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>
	<script src="bootstrap3/js/bootstrap.js" type="text/javascript"></script>
	<script src="assets/js/gsdk-checkbox.js"></script>
	<script src="assets/js/gsdk-radio.js"></script>
	<script src="assets/js/gsdk-bootstrapswitch.js"></script>
	<script src="assets/js/get-shit-done.js"></script>
    <script src="assets/js/custom.js"></script>
    
	<title>이벤트 목록 페이지</title>
<script type="text/javascript">

//유튜브 동영상 보이기================================================================================================================
		var iframe_cnt = 0;  //동적으로 생성 한번만 되게 하는 count 변수
		
		function changeIframe()
		{
			var src = document.getElementById('inputURL').value;
			var findStr1 = "watch?";	//사용자가 유튜브 동영상의 주소창을 복사해왔을 경우
			var findStr2 = "youtu.be";	//사용자가 유튜브 동영상 share 버튼 눌러 url을 copy 해왔을 경우
				
			//https://www.youtube.com/embed/UDLoxcpbPfs
			//input에 입력된 주소를 위와 같이 수정해줘야 됨(embed/비디오 고유주소 형식으로)
			if(src.indexOf(findStr1) != -1)
			{
				//주소창 복사해서 input에 입력했을 경우의 동영상 주소 형식 :  https://www.youtube.com/watch?v=UDLoxcpbPfs
				src = src.split("=");
				src = "https://www.youtube.com/embed/" + src[src.length-1];
			}
			else if(src.indexOf(findStr2) != -1)
			{
				//우클릭 share를 통해 주소 copy 했을 경우의 동영상 주소 형식 : https://youtu.be/UDLoxcpbPfs
				src = src.split("/");
				src = "https://www.youtube.com/embed/" + src[src.length-1];
			}
			else
			{
				alert("동영상 URL을 다시 입력해 주세요");	
				$("#inputURL").focus();
				return false;
			}
			
			if(iframe_cnt == 0){
				var iframe = document.createElement('iframe');
				iframe.frameBorder = 1;
				iframe.width = "350";
				iframe.height = "200";
				iframe.id="iframe_id";
				iframe.setAttribute("src", src);
				document.getElementById("youtubedivId").appendChild(iframe);
	
				document.getElementById("hidden_src").value = src;
			}
			iframe_cnt++;
		}

	//이미지 미리보기(썸네일)==============================================================================================================
	$(function() {
		$("#ThumbnailPreview").on('change', function() {
			ReadThumbanilURL(this);
		}); 
	});

	function ReadThumbanilURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#Recipe_ThumbnailName').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}

	}
	
	//이미지 미리보기(완성사진)테스트 중==============================================================================================================
	
		$(function() {
			$('#FinishedPhotoPreview' + FinishedPhoto_cnt).on('change', function() {
				ReadFinishedPhotoURL(this);
			}); 
		});

		function ReadFinishedPhotoURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#Recipe_FinishedPhoto' + FinishedPhoto_cnt).attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}

		}
		
	//재료 동적 추가하는 부분=============================================================================================================================
	Ingredient_cnt = 0;
	 function Ingredient_AddItem(){
		 Ingredient_cnt++;
		 Recipe_Ingredient = document.createElement('Recipe_Ingredient'); //div id값 받아오는 부분
		 Recipe_Ingredient.className = 'row';
		 Recipe_Ingredient.innerHTML += "<br>"+"재료 #"
			 + Ingredient_cnt
			 + "&nbsp;&nbsp;&nbsp;&nbsp;"
			 + "<input type=text name=IngredientName placeholder='재료명' style='height:30px; width:200px;'>"
			 + "&nbsp; &nbsp;☞&nbsp;&nbsp;"
			 + "<input type=text name=IngredientQuantity placeholder='적정량에 대해 설명해주세요.' style='height:30px; width:350px;'>"
			 + "&nbsp; &nbsp;"
			 + "<input type=button value= 'X' onclick='Ingredient_removeRow(this)' style='font-weight:bold; font-size:10px; background-color:#8C8C8C; border:1 solid #000000; height:20px; width:20px;'><br><br>";
			 
		 document.getElementById('Recipe_Ingredient').appendChild(Recipe_Ingredient); //Input 값 유지시켜주는 부분
	 }
	 //재료 삭제
	 function Ingredient_removeRow(input)
	 {
		 document.getElementById('Recipe_Ingredient').removeChild(input.parentNode);
		 Ingredient_cnt--;
	 }
	 
	//STEP 동적 추가하는 부분============================================================================================================================= 
	Cooking_cnt = 0;
	function Cooking_AddItem() 
	{
		
		Cooking_cnt++;
		Recipe_Cooking = document.createElement('Recipe_Cooking'); //div id값 받아오는 부분
		Recipe_Cooking.className = 'row';
		Recipe_Cooking.innerHTML += "<br>"+"STEP #"
				+ Cooking_cnt
				+ "&nbsp;&nbsp;&nbsp;&nbsp;"
				+ "<textarea name=CookingDescription placeholder='소고기는 기름기를 떼어내고 적당한 크기로 썰어주세요.' cols='80' rows='3' style='resize:none; letter-spacing:1px;'></textarea>"
				+"&nbsp;&nbsp;&nbsp;" 
				+"<img name=Recipe_CookingPhoto id=Recipe_StepPhoto"+Cooking_cnt + " src='' style='max-width:20%; height:auto;' />"
				+"&nbsp;&nbsp;"
				+"<input type=button value='X' onclick='Cooking_removeRow(this)'  style='font-weight:bold; font-size:10px; background-color:#8C8C8C; border:1 solid #000000; height:20px; width:20px;'><br><br>"
				+"&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;"
				+"<input type=file name=Recipe_CookingFile"+Cooking_cnt + " id=StepPreview"+Cooking_cnt + " accept='.jpeg, .jpg, .jpe, .jfif, .PNG, .png, .img' /><br><br>";
				
				document.getElementById('Recipe_Cooking').appendChild(Recipe_Cooking); //Input 값 유지시켜주는 부분
				
				$(function() {
					$('#StepPreview' + Cooking_cnt).on('change', function() {
						ReadCookingPhotoURL(this);
					}); 
				});

				function ReadCookingPhotoURL(input) {
					if (input.files && input.files[0]) {
						var reader = new FileReader();
						reader.onload = function(e) {
							$('#Recipe_StepPhoto' + Cooking_cnt).attr('src', e.target.result);
						}
						reader.readAsDataURL(input.files[0]);
					}

				}
	}
	
	 //STEP 삭제
	 function Cooking_removeRow(input)
	 {
		 document.getElementById('Recipe_Cooking').removeChild(input.parentNode);
		 Cooking_cnt--;
	 }
	 
	 //완성사진 동적 추가하는 부분============================================================================================================================
	FinishedPhoto_cnt = 0;
	 function FinishedPhoto_AddItem()
	 {
		 FinishedPhoto_cnt++;
		 Recipe_FinishedPhoto = document.createElement('Recipe_FinishedPhoto'); //div id값 받아오는 부분
		 Recipe_FinishedPhoto.className = 'row';
		 Recipe_FinishedPhoto.innerHTML += "<br>" + "사진 #"
		 	+ FinishedPhoto_cnt
			+ "&nbsp;&nbsp;"
			+ "<img name=Recipe_FinishedPhoto id=Recipe_FinishedPhoto"+ FinishedPhoto_cnt +" src='' style='max-width: 50%; height: auto;'/>"
			+ "&nbsp;&nbsp;"
			+ "<input type=file name=Recipe_FinishedPhotoFile"+ FinishedPhoto_cnt + " id=FinishedPhotoPreview"+ FinishedPhoto_cnt +" accept='.jpeg, .jpg, .jpe, .jfif, .PNG, .png, .img' />"
			+ "&nbsp;&nbsp;"
			+"<div id=preview> </div>"
			+ "<input type=button value='X' onclick='FinishedPhoto_removeRow(this)' style='font-weight:bold; font-size:10px; background-color:#8C8C8C; border:1 solid #000000; height:20px; width:20px;' />";
			
			document.getElementById('Recipe_FinishedPhoto').appendChild(Recipe_FinishedPhoto); //Input 값 유지시켜주는 부분	
			
			$(function() {
				$('#FinishedPhotoPreview' + FinishedPhoto_cnt).on('change', function() {
					ReadFinishedPhotoURL(this);
				}); 
			});

			function ReadFinishedPhotoURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#Recipe_FinishedPhoto' + FinishedPhoto_cnt).attr('src', e.target.result);
					}
					reader.readAsDataURL(input.files[0]);
				}

			}
			
	 }
	 //FinishedPhoto 삭제
	 function FinishedPhoto_removeRow(input)
	 {
		 document.getElementById('Recipe_FinishedPhoto').removeChild(input.parentNode);
		 FinishedPhoto_cnt--;
	 }
	 
	 $('.btn-tooltip').tooltip('show');
	 
	 function goBack(){
	        window.history.back();
	}

</script>
</head>
<body>
<div align="center"><h1>레시피 작성</h1></div>
<div class="main"> 
    <div class="container tim-container" style="width:80%; align:center;">
    	<form name="Recipe" action="RecipeWriting_Act.jsp" method="post" enctype="multipart/form-data"  >
	    	<div class="row" style="margin-top:20px;">
	    		<div class="col-md-2 col-sm-4">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				제목
	    			</button>
	    		</div>
	    		<div class="col-md-10 col-sm-20">
	    			<input type=text size="70" name="Recipe_Title" placeholder="제목" style="letter-spacing: 3px" class="form-control">
	    		</div>
	    	</div>
	    	<div class="row" style="margin-top:20px;">
	    		<div class="col-md-2 col-sm-4">
	    			<button type="button" class="btn btn-default btn-tooltip" data-toggle="tooltip" data-placement="right" title="이미지를 꼭 선택해주세요." style="border:none;color:#1f50ab;font-weight:bold;">
	    				썸네일
	    			</button> 
	    		</div>
	    		<div class="col-md-5 col-sm-10">
	    			<input type="file" size="60" id="ThumbnailPreview" name="Recipe_ThumbnailFile" accept=".jpeg, .jpg, .jpe, .jfif, .PNG, .png, .img">
	    		</div>
	    		<div class="col-md-5 col-sm-10">
	    			<img id="Recipe_ThumbnailName" src='' style="max-width:50%; height:auto;" />
	    		</div>
	    	</div>
	    	<div class="row" style="margin-top:20px;">
	    		<div class="col-md-2 col-sm-4">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				한줄 소개
	    			</button>
	    		</div>
	    		<div class="col-md-10 col-sm-20">
	    			<input type=text size=70 name="Recipe_Introduce" placeholder="한줄 소개 " style="letter-spacing: 1px" class="form-control">
	    		</div>
	    	</div>
	    	<div class="row" style="margin-top:20px;">
	    		<div class="col-md-2 col-sm-4" style="align:center;">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				동영상
	    			</button>
	    		</div>
	    		<div class="col-md-5 col-sm-10" style="align:center;">
	    			<input type="text" id="inputURL" name="Recipe_VideoUrl" size="100%" class="form-control">
	    		</div>
	    		<div class="col-md-5 col-sm-10" style="align:center;">
	    			<input type="button" name="btnUpload" value="유튜브  URL 등록" onclick="changeIframe()" class="btn btn-success">
	    			<input type="hidden" id="hidden_src" name="Recipe_HiddenVideoUrl" value="">
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-2 col-sm-4">
	    		</div>
	    		<div class="col-md-10 col-sm-20">
	    			<div id="youtubedivId"></div>	
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<hr>
	    		</div>
	    	</div>	
	    	<div class="row">
	    		<div class="col-md-2 col-sm-8">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				인분 & 소요시간 & 난이도
	    			</button>
	    		</div>
	    		<div class="col-md-3 col-sm-5">
	    			<select name="Recipe_PersonnelInfo" style="width: 150px;">
							<option title="인원정보">인원정보</option>
							<option value="1인분">1인분</option>
							<option value="2인분">2인분</option>
							<option value="3인분">3인분</option>
							<option value="4인분">4인분</option>
							<option value="5인분">5인분</option>
							<option value="6인분이상">6인분이상</option>
					</select>
				</div>
	    		<div class="col-md-3 col-sm-5">
	    			<select name="Recipe_TimeInfo" style="width: 150px;">
							<option title="시간정보">시간정보</option>
							<option value="5분이내">5분이내</option>
							<option value="10분이내">10분이내</option>
							<option value="15분이내">15분이내</option>
							<option value="30분이내">30분이내</option>
							<option value="60분이내">60분이내</option>
							<option value="90분이내">90분이내</option>
							<option value="2시간이내">2시간이내</option>
							<option value="2시간이상">2시간이상</option>
					</select>
				</div>
				<div class="col-md-4 col-sm-6">
	    			<select name="Recipe_DifficultyInfo" style="width:150px;">
							<option title="난이도정보">난이도정보</option>
							<option value="★">★</option>
							<option value="★★">★★</option><!-- data-icon="Image/btnWrite.PNG" data-html-text="iMac Station&lt;i&gt;in stock&lt;/i&gt;"  -->
							<option value="★★★">★★★</option>
							<option value="★★★★">★★★★</option>
							<option value="★★★★★">★★★★★</option>
					</select>
				</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<hr>
	    		</div>
	    	</div>	
	    	<div class="row">
		    	<div class="col-md-12 col-sm-24">
		    	</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-2 col-sm-4">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				재료
	    			</button>
	    		</div>
	    		<div class="col-md-10 col-sm-20">
	    			<div id="Recipe_Ingredient" style="align:center"></div>
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<input type="button" value="재료 추가" onclick="Ingredient_AddItem()" class="btn btn-block btn-lg btn-info btn-round"  style="align:center; background-color:rgba(52, 172, 220, 0.98);color:white;">
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<hr>
	    		</div>
	    	</div>	
	    	<div class="row">
	    		<div class="col-md-2 col-sm-4">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				조리과정
	    			</button>
	    		</div>
	    		<div class="col-md-10 col-sm-20">
	    			<div id="Recipe_Cooking" style="align:center"></div>
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<input type="button" value="STEP 추가" onclick="Cooking_AddItem()" class="btn btn-block btn-lg btn-info btn-round"  style="align:center; background-color:rgba(52, 172, 220, 0.98);color:white;">
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<hr>
	    		</div>
	    	</div>	
	    	<div class="row">
	    		<div class="col-md-2 col-sm-4">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				완성사진
	    			</button>
	    		</div>
	    		<div class="col-md-10 col-sm-20">
	    			<div id="Recipe_FinishedPhoto" style="align:center"></div>
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<input type="button" value="완성사진 추가" onclick="FinishedPhoto_AddItem()" class="btn btn-block btn-lg btn-info btn-round"  style="align:center; background-color:rgba(52, 172, 220, 0.98);color:white;">
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<hr>
	    		</div>
	    	</div>	
	    	<div class="row">
	    		<div class="col-md-2 col-sm-4">
	    			<button type="button" class="btn btn-default" style="border:none;color:#1f50ab;font-weight:bold;">
	    				요리팁
	    			</button>
	    		</div>
	    		<div class="col-md-10 col-sm-20">
	    			<input type="text" name="Recipe_CookingTips" placeholder="고기요리에는 소금보다 설탕을 먼저 넣어야 단맛이 겉돌지 않고 육질이 부드러워요." class="form-control">
	    		</div>
	    	</div>
	    	<div class="row">
	    		<div class="col-md-12 col-sm-24">
	    			<hr>
	    		</div>
	    	</div>	
	    	<div class="row">
	    		<div class="col-md-6 col-sm-12" style="text-align:center;">
	    			<input type="submit" width="80" height="40" value="입력완료" class="btn btn-success"/> 
	    		</div>
	    		<div class="col-md-6 col-sm-12" style="text-align:center;">
	    			<a href="RecipeView.jsp"><img src="./assets/img/backimage.PNG" width="90" hegiht="60"></a>
	    		</div>
	    	</div>
	    	<div class="space-30"></div>
    	</form>
	</div>
</div>
</body>
</html>