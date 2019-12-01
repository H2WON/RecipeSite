<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="EventForm" action="EventInsert_Act.jsp" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>제목</td>
			<td><input type="text" name="EventTitle"></td>
		</tr>
		<tr>
			<td>썸네일</td>
			<td><input type="file" size="60" id="ThumbnailPreview" name="EventThumbnailFile" accept=".jpeg, .jpg, .jpe, .jfif, .PNG, .png, .img"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea name="EventContent" placeholder="내용을 입력해 주세요" cols="100" rows="10" style="resize:none; letter-spacing: 1px;" class="form-control"></textarea></td>
		</tr>
		<tr>
			<td> 시작일</td>
			<td><input type="date" name="EventStart"/></td>
		</tr>
		<tr>
			<td>종료일</td>
			<td><input type="date" name="EventEnd"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="작성하기"/></td>
		</tr>
	</table>
</form>
</body>
</html>