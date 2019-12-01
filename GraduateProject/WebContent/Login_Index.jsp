<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>
<%
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	}
	
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	
	String driverName = "com.mysql.jdbc.Driver";
	//?useUnicode=true& useUnicode=true&characterEncoding=euc_kr	=> 을 붙여야 한글이 DB에 저장될 때 물음표로 깨지지 않음
	String dbURL = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc_kr&serverTimezone=UTC&useSSL=false";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>
<div class="main">
    <div class="container tim-container">
    <%
    	try {
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(dbURL, "jspid", "jsppass");
		
			//로그인한 회원이 팔로잉한 회원아이디를 가져오는 SQL
			String sql_FollowingId = "SELECT Follow_Recipient FROM Follow WHERE Follow_Sender = ?";
			
			//SQL을 통해 SELECT한 팔로잉 회원 ID를 모두 담을 변수
			ArrayList<String> FollowingId = new ArrayList<String>();

			pstmt = con.prepareStatement(sql_FollowingId);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
			
			//FollowingId라는 동적배열(ArrayList)에 SELECT를 통해 받아온 팔로잉한 회원ID를 추가
			while(rs.next())
			{
				FollowingId.add(rs.getString("Follow_Recipient"));
			}
			
			//FollowingId 받는 부분 확인용
			/*
			if(FollowingId.size() != 0)
			{
				for(int i=0; i<FollowingId.size(); i++)
				{
					System.out.println(FollowingId.get(i));
				}
			}
			*/

			//로그인한 회원이 팔로잉한 회원의 레시피 썸네일 사진을 가져오는 SQL - 최신순으로 4개까지만
			String sql = "SELECT Recipe_ThumbnailChangeName, Recipe_Title, Recipe_No FROM Recipe WHERE Recipe_Writer = ? ORDER BY Recipe_Date DESC LIMIT 4";
			
			ArrayList<String> Recipe_ThumbnailChangeName = new ArrayList<String>();
			ArrayList<String> Recipe_Title = new ArrayList<String>();
			ArrayList<Integer> Recipe_No = new ArrayList<Integer>();
			
			//로그인한 회원이 팔로잉한 회원이 있다면
			if(FollowingId.size() != 0)
			{
				//화면 출력부분 (화면 출력부분 안에서 썸네일 이미지 SELECT 및 출력함)
				for(int i=0; i<FollowingId.size(); i++)
				{
					//썸네일 받는 부분
		    		//팔로잉한 회원 중 1명에 대해 SELECT한 게시글 썸네일 이미지 4개를 ArrayList(Recipe_ThumbnailChangeName)에 담는 부분
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, FollowingId.get(i));
					rs = pstmt.executeQuery();
							
					while(rs.next())
					{
						Recipe_ThumbnailChangeName.add(rs.getString("Recipe_ThumbnailChangeName"));
						Recipe_Title.add(rs.getString("Recipe_Title"));
						Recipe_No.add(rs.getInt("Recipe_No"));
					}
					
					//rs를 통해 받아온 Recipe_No가 없다면
					//로그인한 회원이 팔로잉한 회원ID의 게시글이 존재하지 않는 것으로 간주
					
					//로그인한 회원이 팔로잉한 회원ID의 게시글이 존재하지 않는다면
					//그 회원 출력은 Skip
					if(!Recipe_No.isEmpty())
					{
	%>
						<!-- 팔로잉한 회원 아이디 출력 부분 -->
						<div class="row" style="margin-top:20px;margin-bottom:10px;">
			    			<div class="col-md-12 col-sm-24">
			    				<a href="MypageForm.jsp?mypageid=<%=FollowingId.get(i)%>"><img src="assets/img/original.png" alt="Circle Image" class="img-circle" style="width:50px;height:50px;margin-right:20px; float:left;"><h2><%=FollowingId.get(i) %></h2></a>
			    			</div>
			    		</div>
						<!-- row를 미리 열어둠 -->
						<div class="row">
	<%
						//썸네일 출력부분
						//썸네일 출력 부분 반복문
						for(int j=0; j<Recipe_ThumbnailChangeName.size(); j++)
						{
	%>
					        <div class="col-md-3 col-sm-4">
					        	<a href="RecipeShow.jsp?recipeno=<%=Recipe_No.get(j) %>">
					        		<button class="btn btn-block btn-lg btn-info btn-simple">
					        			<img src="\GraduateProject\RecipePhotoUpload\<%= Recipe_ThumbnailChangeName.get(j) %>" alt="Rounded Image" class="img-rounded" style="width:180px; height:180px;">
					        			<p><br><font size="4px"><%= Recipe_Title.get(j) %></font>
					        		</button>
					        	</a>
							</div>
	<%
				       	}
	%>
						<!-- 한명의 팔로잉회원ID에 대한 썸네일 모두 출력 후 row 닫아줌 -->
						</div>
	<%					
						//다음 인덱스번호 팔로잉회원ID의 정보들을 ArrayList 처음부터 다시 받고 출력해주기 위해 초기화
						Recipe_ThumbnailChangeName.clear();
						Recipe_Title.clear();
						Recipe_No.clear();
						
						//마지막 팔로잉회원ID에 대한 영역은 구분선이 필요없으므로
						//마지막 팔로잉회원ID가 아니면 구분선 출력
						if(i != FollowingId.size()-1)
						{
	%>
							<div class="row" style="margin-top:5px;">
				    			<div class="col-md-12 col-sm-12">
				    				<hr>
				    			</div>
				    		</div>
	<%
						}	
					}
				}
			}
			
			//로그인한 회원이 팔로잉한 회원ID가 없다
			//비회원 화면과 동일하게 출력
			//팔로잉 회원이 있더라도 출력
			
			pstmt.close();
			rs.close();			
	%>			
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
				Integer Recipe_No_non = rs.getInt("Recipe_No");
				String Recipe_Title_non = rs.getString("Recipe_Title");
				String Recipe_ThumbnailChangeName_non = rs.getString("Recipe_ThumbnailChangeName");
				
	%>
			<div class="col-md-3 col-sm-4">
        		<a href="RecipeShow.jsp?recipeno=<%=Recipe_No_non %>">
					<button class="btn btn-block btn-lg btn-info btn-simple">
						<img src="\GraduateProject\RecipePhotoUpload\<%= Recipe_ThumbnailChangeName_non %>" class="img-rounded" width="180px" height="180px" />
						<p><br><font size="4px"><%= Recipe_Title_non %></font>
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
					<div class="col-md-8 col-sm-4">
						<h2>쉬운 레시피</h2>
					</div>
					<div class="col-md-2 col-sm-4">
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
</body>
</html>