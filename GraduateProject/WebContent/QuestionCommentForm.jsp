<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
    <%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	String login = (String)session.getAttribute("Login");
	String userid = (String)session.getAttribute("UserID");
	
	if(userid == null)
	{
		response.sendRedirect("index.jsp");
	}
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
							
		String Question_Id = request.getParameter("question_id"); //QuestionList에서 Question_Id 받아오기
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

</script>
</head>
<body>
<div style="align:center;">
<h1>Question Comment</h1>
	<form name="QuestionCommentForm" method="post" onsubmit="return check()" action="QuestionComment_Act.jsp?question_id=<%= Question_Id %>" >

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
			pstmt.setString(1,Question_Id);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				String Question_Title = rs.getString("Question_Title");
				String Question_Writer = rs.getString("Question_Writer");
				String Question_Date = rs.getString("Question_Date");
				String Question_Content = rs.getString("Question_Content");
				String Question_Secret = rs.getString("Question_Secret");

		%>
			<table>
				<tr>
					<td style="width:30%; background-color:lightgray;" >
						제목
					</td>
					<td>
						<%= Question_Title %>
					</td>
				</tr>
				<tr>
					<td style="width:30%; background-color:lightgray;">
						작성자 
					</td>
					<td>
						<%= Question_Writer %>
					</td>
				</tr>
				<tr>
					<td style="width:30%; background-color:lightgray;">
						내용
					</td>
					<td>
						<%= Question_Content %>
					</td>
				</tr>
					<%
						String QuestionPhotoSQL = "Select * From QUESTIONPHOTO Where Question_Id = ?";
						
						pstmt = conn.prepareStatement(QuestionPhotoSQL);
						pstmt.setString(1,Question_Id);
						rs = pstmt.executeQuery();
						
						while(rs.next())
						{
							String QuestionPhoto_Id = rs.getString("QuestionPhoto_Id");
							String QuestionPhoto_ChangeName = rs.getString("QuestionPhoto_ChangeName");
							String QuestionPhoto_SavePath   = rs.getString("QuestionPhoto_SavePath");
					%>
						<tr>
							<td  style="width:30%; background-color:lightgray;">
								첨부사진#<%= QuestionPhoto_Id %> &nbsp;
							</td>
							<td>
								<img src ="\RecipeWriting\QuestionSavePath\<%= QuestionPhoto_ChangeName  %>" width="110px" height="110px" />
							</td>
						</tr>			
						<%
						} //QuestionPhoto 닫는부분
						%>
			</table>
			<table>
				<tr>
					<td>
						<textarea name="QuestionComment_Content" id="QuestionComment_Content" placeholder="댓글 내용을 입력해 주세요" cols="70" rows="3" style="resize:none; letter-spacing: 1px;" class="form-control"></textarea>
						<input type=submit value="등록"/> 
					</td>
				</tr>
			</table>
					
			<table>			
				
			<%
				
				String QuestionCommentSQL = "Select * From QUESTIONCOMMENT Where Question_Id = ? Order By QuestionComment_Id desc";
	
				pstmt = conn.prepareStatement(QuestionCommentSQL);
				pstmt.setString(1,Question_Id);
					
				rs = pstmt.executeQuery();
					while(rs.next())
					{
						String QuestionComment_Id = rs.getString("QuestionComment_Id");
						String QuestionComment_Writer = rs.getString("QuestionComment_Writer");
						String QuestionComment_Content = rs.getString("QuestionComment_Content");
						String QuestionComment_Date = rs.getString("QuestionComment_Date");
					%>
						<tr>
							<td style="background-color:lightgray; align:left;">
								<%= Question_Id %> # <%= QuestionComment_Id %> &nbsp; 작성자☞ <%= QuestionComment_Writer %> 시간 ☞ <%= QuestionComment_Date %> <br>
							</td>
						</tr>
						<tr>
							<td style="width:150; background-color:lightgreen; align:left;">
							 댓글☞ <%= QuestionComment_Content %> &nbsp;<br>
						</td>
					</tr> 
					<%
					}		
					
				} //Question 닫는부분
			
					rs.close();
					pstmt.close();
					conn.close();
					
				}catch(Exception e){
					out.println("Where is your mysql jdbc driver?");
					out.println(e.getMessage());
					e.printStackTrace();
					return;
					}
					%>
			</table>
		</form>
</div>
</body>
</html>