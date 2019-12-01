<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
	String login = (String) session.getAttribute("Login");
	String userid = (String) session.getAttribute("UserID"); 
	
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	request.setCharacterEncoding("UTF-8"); //�ѱ۱����������
	
	//connection��ü ����
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		String QuestionComment_Content = request.getParameter("QuestionComment_Content");
		String questionid = request.getParameter("questionid"); //QuestionList���� Question_Id �޾ƿ���
	
		//db����   
		try {

			String jdbcUrl = "jdbc:mysql://localhost:3306/jsptest?useUnicode=true&characterEncoding=euc-kr&serverTimezone=UTC&useSSL=false";
			String dbId = "jspid"; //dbid����
			String dbPass = "jsppass"; //db��й�ȣ ����

			//����̹� �ε�
			Class.forName("com.mysql.jdbc.Driver"); //Driver�� connection��ü�� ����
			// connection ��ü ����
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass); //������ �ε��� ����̹��� ������ connection��ü�� ����
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
			
			
			String QuestionCommentInsertSQL ="INSERT INTO QUESTIONCOMMENT("
					+ "QUESTION_ID,"
					+ "QUESTIONCOMMENT_WRITER,"
					+ "QUESTIONCOMMENT_CONTENT,"
					+ "QUESTIONCOMMENT_DATE)"
					+ "VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(QuestionCommentInsertSQL);
		
			out.println(questionid);
			pstmt.setString(1, questionid);
			pstmt.setString(2, userid); //userid�� �������ֱ�
			pstmt.setString(3, QuestionComment_Content);
			pstmt.setString(4, sdf.format(cal.getTime()));
			pstmt.executeUpdate();
			
			response.sendRedirect("QuestionShow.jsp?questionid="+questionid+"&pg="+pg);
			pstmt.close();
		}

		catch (SQLException sql) {
			out.println("What?");
			out.println(sql.getMessage());
			return;
		}
%>