<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
    
	<title>이벤트 현재 목록</title>
</head>
<body>

<div class="main" style="text-align:center;float:center;">
	<div class="row">
		<div class="col-md-2">
		</div>
		<div class="col-md-8">
	        <ul class="nav nav-tabs">
	        	<li class="active"><a href="EventList.jsp">진행중인 이벤트</a></li>
				<li><a href="EventList.jsp?sub=EventClose">종료된 이벤트</a></li>
				<li><a href="EventList.jsp?sub=EventWinner">당첨자 발표</a></li>
			</ul>
		</div>
		<div class="col-md-2">
		</div>	
	</div>
	<div class="space-30"></div>
<%
			PreparedStatement pstmt=null;
			ResultSet rs = null;
			String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
			String dbId = "jspid"; //dbid설정
			String dbPass = "jsppass"; //db비밀번호 설정
			
			int eventtype=1;
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
			
				Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

				String RecipeSQL = "select * from Event where Event_Id = 1 or Event_Id = 2 or Event_Id = 3 or Event_Id = 4";
				pstmt = conn.prepareStatement(RecipeSQL);
				
				rs = pstmt.executeQuery();
				while(rs.next())
				{
					Integer Event_Id = rs.getInt("Event_Id");
					String Event_Title = rs.getString("Event_Title");
					String Event_Content = rs.getString("Event_Content");
					Date Event_StartDate = rs.getDate("Event_StartDate");
					Date Event_EndDate = rs.getDate("Event_EndDate");
					String Event_ThumbChangeName = rs.getString("Event_ThumbChangeName");
					String Event_ThumbNailSavePath = rs.getString("Event_ThumbNailSavePath");
%>
		<div class="row">
			<div class="col-md-2 col-sm-4" >
			</div>
			<div class="col-md-4 col-sm-6">
				<a href="EventShow.jsp?eventid=<%=Event_Id %>&eventtype=<%=eventtype%>">
					<img src="\GraduateProject\EventSavePath\<%= Event_ThumbChangeName %>" width="100%" height="auto" />
				</a>
			</div>
			<div class="col-md-4 col-sm-6">
				<a href="EventShow.jsp?eventid=<%=Event_Id %>&eventtype=<%=eventtype%>">
		 		<button class="btn btn-block btn-lg btn-info btn-simple">
		 			<h5 style="float:left"><%= Event_Title%></h5>
		 			<div style="float:left"><small><%=Event_StartDate %> ~ <%=Event_EndDate %></small></div>
		 		</button>
		 		</a>
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
<%
				}
				conn.close();
				rs.close();
				pstmt.close();
			}catch (SQLException sql) {
				out.println("What?");
				System.out.println(sql.getMessage());
				return;
			}
%>
		<div class="row">
			<div class="col-md-2 col-sm-4">
			</div>
			<div class="col-md-8 col-sm-12">
				<ul class="pagination ct-blue"> 
				  <li class="active"><a href="EventList.jsp">1</a></li>
				</ul>
			</div>
			<div class="col-md-2 col-sm-4">
			</div>
		</div>
</div>
</body>
</html>