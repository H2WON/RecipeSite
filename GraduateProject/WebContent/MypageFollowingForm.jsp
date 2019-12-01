<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	//로그인이 안돼있는 경우 index 페이지로 돌아감 
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	}
	
	//팔로워, 팔로잉 수 받아오기
	String mypageid = request.getParameter("mypageid");
	
	//자신의 마이페이지 들어왔을 경우 
	if(mypageid == null || mypageid == userid)
	{
		mypageid = userid;
	}
		 
		int loginMemberId_postCount = 0;
		int loginMemberId_followerCount = 0;
		int loginMemberId_followingCount = 0;
		
		int checkBtnFollow = 0;
		
		ResultSet rs = null;
		PreparedStatement pstmt = null;
	
		String driverName = "com.mysql.jdbc.Driver";
		//?useUnicode=true& useUnicode=true&characterEncoding=euc_kr	=> 을 붙여야 한글이 DB에 저장될 때 물음표로 깨지지 않음
		String dbURL = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";

		try {
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(dbURL, "jspid", "jsppass");
			
			//마이페이지 회원의 게시글수/팔로워수/팔로잉수 가져오는 부분
			String sql_postCount = "SELECT COUNT(*) FROM Recipe WHERE Recipe_Writer = ?";
			String sql_followerCount = "SELECT COUNT(*) FROM Follow WHERE Follow_Recipient = ?";
			String sql_followingCount = "SELECT COUNT(*) FROM Follow WHERE Follow_Sender = ?";
			
			//게시글수
			pstmt = con.prepareStatement(sql_postCount);
			pstmt.setString(1, mypageid);
			rs = pstmt.executeQuery();

			if(rs.next())
			{
				//결과값이 있다면 첫 번째 결과값을 int형으로 변수에 저장
				loginMemberId_postCount = rs.getInt(1);
			} 
			
			//팔로워수
			pstmt = con.prepareStatement(sql_followerCount);
			pstmt.setString(1, mypageid);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				loginMemberId_followerCount = rs.getInt(1);
			}
			
			//팔로잉수
			pstmt = con.prepareStatement(sql_followingCount);
			pstmt.setString(1, mypageid);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				loginMemberId_followingCount = rs.getInt(1);
			}
			
			//다른 회원의 마이페이지에 들어온 것이라면W
			if(!userid.equals(mypageid))
			{
				String sql_checkFollow = "SELECT * FROM Follow WHERE Follow_Sender = ? and Follow_Recipient = ?";
				
				pstmt = con.prepareStatement(sql_checkFollow);
				pstmt.setString(1, userid);
				pstmt.setString(2, mypageid);
				rs = pstmt.executeQuery();
				
				if(rs.next())
				{
					//팔로잉 관계 - 언팔로잉 버튼 활성화
					checkBtnFollow = 1;
				}
				else
				{
					//언팔로잉 관계 - 팔로잉 버튼 활성화
					checkBtnFollow = 2;	
				}
			}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    
	<title>마이 페이지</title>
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
                <ul class="nav navbar-nav navbar-right">
                	<li><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:50px;height:50px;margin:5px;"></li>
                	<li><a href="MypageForm.jsp?mypageid=<%=userid %>"><%= userid %></a></li>
                	<li><a href="Logout_Act.jsp" class="btn btn-round btn-default">Log Out</a></li>
                    <li class="active"><a href="MypageForm.jsp?mypageid=<%=userid %>" class="btn btn-round btn-default" data-toggle="modal">MyPage</a></li>
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

<!-- 마이페이지 시작 -->
<div class="main">
    <div class="container tim-container">
        <div id="extras">
            <div class="space"></div>
            <div class="row">
                <div class="col-md-5 col-md-offset-0 col-sm-10 col-sm-offset-1">
                    <div class="text-center">
                        <img src="assets/img/original.png" alt="Rounded Image" class="img-circle" style="width:200px;height:200px;">
                    	<div style="font-size:30px; margin:5px;"><%=mypageid %></div>
                    </div>
                </div>
                <!-- 게시글수/팔로워수/팔로잉수 찍어주는 테이블 -->
                <div class="col-md-7 col-sm-12">
	                <table style="width:100%; height:250px; font-weight:bold; font-size:30px; align:center;">
						<tr style="text-align:center; height:34%;">
							<td style="width:34%;"><a href="MypageForm.jsp?mypageid=<%=mypageid%>" style="color:black;"><%= loginMemberId_postCount %></a></td>
							<td style="width:33%;"><a href="MypageFollowerForm.jsp?mypageid=<%=mypageid%>" style="color:black;" ><%= loginMemberId_followerCount %></a></td>
							<td style="padding-left:20px;"><a href="MypageFollowingForm.jsp?mypageid=<%=mypageid%>"><%= loginMemberId_followingCount %></a></td>
						</tr>
						<tr style="text-align:center; height:33%;">
							<td><a href="MypageForm.jsp?mypageid=<%=mypageid%>" style="color:black;">게시글</a></td>
							<td><a href="MypageFollowerForm.jsp?mypageid=<%=mypageid%>" style="color:black;">팔로워</a></td>
							<td><a href="MypageFollowingForm.jsp?mypageid=<%=mypageid%>">팔로잉</a></td>
						</tr>
						<tr style="text-align:center;">
							<td colspan="3">
								<%
								if(checkBtnFollow == 1)
								{
							%>
									<a href="Follow_DAct.jsp?mypageid=<%= mypageid %>">
									<!-- <img src="assets/img/follow/btnUnfollow.png"> -->
										<button class="btn btn-block btn-lg btn-danger btn-fill" style="width:100%">언팔로우</button>
									</a>
							  <%}
								else if(checkBtnFollow == 2)
								{%>
									<a href="Follow_Act.jsp?mypageid=<%= mypageid %>">
									<!-- <img src="assets/img/follow/btnFollow.png"> -->
										<button class="btn btn-block btn-lg btn-info btn-fill" style="width:100%">팔로우</button>
									</a>
							  <%}
							  	else
								  	{%>
								  		<button class="btn btn-block btn-lg btn-warning btn-fill" style="width:100%" data-toggle="modal" data-target="#myModal">회원탈퇴</button>
								  		<!-- Modal -->
						                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						                  <div class="modal-dialog">
						                    <div class="modal-content">
						                      <div class="modal-header">
						                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						                        <h4 class="modal-title" id="myModalLabel" style="color:red;font-weight:bold;">회원 탈퇴</h4>
						                      </div>
						                      <form name="DeleteForm" action="MemberDelete_Act.jsp" method="post" accept-charset="UTF-8">
							                      <div class="modal-body">	
							                       	<h4> 정말 회원 탈퇴 하시겠습니까? </h4>
							                       	<h4> 다시 한번 생각하시고 비밀번호를 적어주십시오. </h4>
							                       	<input type="password" id="Dpassword" name="Dpassword" placeholder="비밀번호" class="form-control"/>
							                      </div>
							                      <div class="modal-footer">
							                        <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">취소</button>
							                        <div class="divider"></div>
							                        <input type="submit" class="btn btn-info btn-simple" value="탈퇴">
							                      </div>
						                      </form>
						                    </div>
						                  </div>
						                </div>
								  	<%}%>
							</td>
						</tr>
					</table>
					
                </div>
            </div>
            <div class="row">
            <hr>
            </div>
            <div class="row">
            <%
            
           		Integer count = 0;
            
    			//마이페이지 회원의 게시글수/팔로워수/팔로잉수 가져오는 부분
    			String sql_MyRecipe = "SELECT Follow_Recipient FROM Follow WHERE Follow_Sender = ?";
    			pstmt = con.prepareStatement(sql_MyRecipe);
    			pstmt.setString(1,mypageid);
    			
    			rs = pstmt.executeQuery();
    			
    			while(rs.next())
    			{
    				String Follow_Recipient = rs.getString("Follow_Recipient");
    				if(count % 4 == 0)
    				{
    			%>
    					</div>
		 				<div class="row" style="margin-top:10px;">
    			<%	}
    			%>
    				<div class="col-md-3 col-sm-6">
    					<a href="MypageForm.jsp?mypageid=<%=Follow_Recipient %>">
    						<button class="btn btn-block btn-lg btn-info btn-simple" style="width:60%;height:auto;">
				 				<img src="./assets/img/original.png" width="100%" height="auto" class="img-circle" />
				 				<h4><%=Follow_Recipient %></h4>
				 			</button> 
				 		</a>
				 	</div>
    			<%
    				count++;
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
        </div>
    <!--     end extras -->    
    </div>
<!-- end container -->
<div class="space-30"></div>
</div>
<!-- 마이페이지 끝 -->


</body>
</html>