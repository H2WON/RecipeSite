<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8"); //한글깨지지말라고 %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
    
<%
	/* String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	} */
		
	String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC&useSSL=false"; //db경로설정
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
<title>Insert title here</title>



<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>   <!-- 중복인가? -->
<script src="//code.jquery.com/jquery.min.js"></script>
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
	$("#RecipeSenseThumbnailPreview").on('change', function() {
		ReadSenseThumbanilURL(this);
	}); 
});

function ReadSenseThumbanilURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('#RecipeSense_ThumbnailName').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

//STEP 동적 추가하는 부분============================================================================================================================= 
Step_cnt = 0;
function RecipeSenseStep_AddItem() 
{
	
	Step_cnt++;
	RecipeSenseStep = document.createElement('RecipeSenseStep'); //div id값 받아오는 부분
	RecipeSenseStep.className = 'row';
	RecipeSenseStep.innerHTML += "<br>"+"STEP #"
			+ Step_cnt
			+ "&nbsp;&nbsp;&nbsp;&nbsp;"
			//+"<input type=text name=RecipeSenseStepDescription placeholder='꼬막이 담긴 볼에 물을 넉넉히 붓고 소금 약간을 넣어 여러 번 씻어주세요.'style='height:50px; width:450px;'>"
			+"<textarea name=RecipeSenseStepDescription placeholder='꼬막이 담긴 볼에 물을 넉넉히 붓고 소금 약간을 넣어 여러 번 씻어주세요.' cols='80' rows='3' style='resipze:none; letter-spacing:1px;'></textarea>"
			+"&nbsp;&nbsp;&nbsp;" 
			+"<img name=RecipeSenseStepPhoto id=RecipeSenseStepPhoto"+Step_cnt + " alt=조리사진 style='max-width:20%; height:auto;' />"
			+"&nbsp;&nbsp;"
			+"<input type=button value='X' onclick='RecipeSenseStep_removeRow(this)'  style='font-weight:bold; font-size:10px; background-color:#8C8C8C; border:1 solid #000000; height:20px; width:20px;'><br><br>"
			+"&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;"
			+"<input type=file name=RecipeSenseStepFile"+Step_cnt + " id=RecipeSenseStepPreview"+Step_cnt + " accept='.jpeg, .jpg, .jpe, .jfif, .PNG, .png, .img' /><br><br>";
			
			document.getElementById('RecipeSenseStep').appendChild(RecipeSenseStep); //Input 값 유지시켜주는 부분
			
			$(function() {
				$('#RecipeSenseStepPreview' + Step_cnt).on('change', function() {
					ReadSensePhotoURL(this);
				}); 
			});

			function ReadSensePhotoURL(input) {
				if (input.files && input.files[0]) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#RecipeSenseStepPhoto' + Step_cnt).attr('src', e.target.result);
					}
					reader.readAsDataURL(input.files[0]);
				}

			}
}

 //STEP 삭제
 function RecipeSenseStep_removeRow(input)
 {
	 document.getElementById('RecipeSenseStep').removeChild(input.parentNode);
 }
 

</script>


<style>
table {
	border: 1px solid #444444;
	border-collapse: collapse;
}

tr, td {
	border-bottom: 1px solid #444444;
	padding: 10px;
}

</style>

</head>
<body>
<div align=center>
		<h1 style="text-align: center;">Sense Writing</h1>
		<form name="RecipeSenseForm" action="RecipeSense_Act.jsp" method="post" enctype="multipart/form-data"  >
		
		
			<table style="width:60%; border:1; margin-left:auto; margin-right:auto;">
				<tr style="border: 0; align: center;">
					<td style="text-align: center;">제목</td>
					<td><input type=text size="70" name="RecipeSense_Title" placeholder="꼬막 손질법" style="text-align: left; height: 20px; letter-spacing: 3px"></td>
					<td rowspan="2" style="width: 25%;"><img id="RecipeSense_ThumbnailName" src='#' alt="Thumbnail" style="max-width:80%; height:auto;" /></td>
				</tr>
				<!-- width="150px" height="120px" -->
				<tr>
					<td align="center">썸네일</td>
					<td><input type="file" size="5" id="RecipeSenseThumbnailPreview" name="RecipeSense_ThumbnailFile" accept=".jpeg, .jpg, .jpe, .jfif, .PNG, .png, .img"><font size="2">★ 꼭 썸네일을 선택해 주세요.</font></td>
				<tr>
					<td align="center">동영상</td>
					<td colspan=2 ><input type="text" id="inputURL" name="RecipeSense_VideoUrl" style="width:70%">
									<input type="hidden" id="hidden_src" name="RecipeSense_HiddenVideoUrl" value=""/>
					<input type="button" name="btnUpload" value="참고 동영상 등록" onclick="changeIframe()"><p></p>
					<div id="youtubedivId"></div></td>
				</tr>
			</table>
			<br> <br>

			
			<table  style="name:Sense; width:60%; border:1; margin-left:auto; margin-right:auto;">
				<tr style="width:20%; border:0;">
					<td></td>
					<td colspan=2><font size="2">★분류를 바르게 설정해주시면, 이용자들이 쉽게 레시피를 검색할 수 있어요.</font></td>
				</tr>

				<tr style="width:100; border:0;">
					<td align="center" width="70">카테고리</td>
					<td align="center" width="730" colspan="2">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select name="RecipeSense_Category" style="width: 150px;">
							<option title="카테고리" value="0">카테고리</option>
							<%
								try {
									Class.forName("com.mysql.jdbc.Driver"); //con = DBConnection.getCon();
									conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //위에서 로딩한 드라이버를 가지고 connection객체에 연결
									String RecipeSenseCategory_sql = "SELECT * FROM RecipeSenseCategory GROUP BY RecipeSenseCategory_Id ORDER BY RecipeSenseCategory_Id";
									//쿼리를 실행시킬 객체에 쿼리 전달 //

									pstmt = conn.prepareStatement(RecipeSenseCategory_sql);
									rs = pstmt.executeQuery();
									while (rs.next()) {
										int Sel_SenseCategory_Id = rs.getInt("RecipeSenseCategory_Id");
										String Sel_SenseCategory_Name = rs.getString("RecipeSenseCategory_Name");
							%>
							<option value=<%=Sel_SenseCategory_Id%>>
								<%=Sel_SenseCategory_Name%>
							</option>
							<%
								}
								} catch (SQLException sql) {
									System.out.println(sql.getMessage());
								} finally {
									try {
										
										if (rs != null)
											rs.close();
										if (pstmt != null)
											pstmt.close();
										if (conn != null)
											conn.close();
									} catch (SQLException sql) {
										System.out.println(sql.getMessage());
									}
								}
							%>
					</select> &nbsp;&nbsp; 
					</td>
				</tr>
	
			</table>
			<br> <br>
			

	<!-- 테이블 -->
	 <table style="name:Sense; width:60%; border:0; cellpadding:0; cellspacing:0; id:Cooking_Table;">
	 	<tr>
			<td align="center" width="70" colspan="4" > <font size="2">★ 재료 손질법을 소개 해주세요.</font></td>
		</tr>
		<tr>
			<td align="center" width="15%">손질 순서</td>
			<td width="85%" colspan=2> <div id="RecipeSenseStep" style="align:center"></div> </td>
			<td></td>
		</tr>
		<tr>
			<td colspan=4 align=center> <input type="button" value="STEP 추가" onclick="RecipeSenseStep_AddItem()"> </td>
		</tr>
	</table>
	
			 <br> <input type=submit width="80" height="40"  value="글 쓰기"/> 
			<input type=reset width="80" height="40" value="작성취소" />
			<!--  다른버튼 눌렀을 때 DB 저장버튼이 아니라는 것을 명확히 하기 위해 form을 다르게함 -->

		</form>
	</div>
	
</body>
</html>