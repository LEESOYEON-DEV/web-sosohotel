<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SOSO HOTEL</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		session.invalidate(); // session 재시작 (저장된 값 삭제)
	%>
	<script type="text/javascript">
		alert("로그아웃 되었습니다.");
		location.href = "main.jsp";
	</script>
</body>
</html>