<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String pw = (String)request.getAttribute("pw");
	String name = (String)request.getAttribute("name");
	String tel = (String)request.getAttribute("tel");
	String email = (String)request.getAttribute("email");
%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SOSO HOTEL | 회원정보</title>
    <link rel="stylesheet" type="text/css" href="../resources/css/common.css">
    <link rel="stylesheet" type="text/css" href="../resources/css/information.css">
    <script src="../resources/js/info_update_check.js" charset="UTF-8"></script>
    <script src="../resources/js/underline_set.js" charset="UTF-8"></script>
</head>
<body>
	<form action="updatePro.jsp" id="infoFm" name="fm" method="post" enctype="UTF-8" onsubmit="return joinChk()">
	    <table style="">
	    	<tr>
	    		<th>아이디</th>
	    		<td><input type="text" name="id" value="<%=id %>" readonly></td>
	    	</tr>
	    	<tr>
	    		<th>비밀번호</th>
	    		<td><input type="password" name="password"></td>
	    	</tr>
	    	<tr>
	    		<th>비밀번호 확인</th>
	    		<td><input type="password" name="passwordCheck"></td>
	    	</tr>
	    	<tr>
	    		<th>이름</th>
	    		<td><input type="text" name="name" value="<%=name %>"></td>
	    	</tr>
	    	<tr>
	    		<th>연락처</th>
	    		<td><input type="text" name="tel" value="<%=tel %>"></td>
	    	</tr>
	    	<tr>
	    		<th>이메일</th>
	    		<td><input type="text" name="email" value="<%=email %>"></td>
	    	</tr>
	    	<tr>
	    		<td colspan="2" id="deleteInfo" onmouseover="underline(this)" onmouseout="underlineDelete(this)" onclick="location.href='deleteForm.jsp'">회원탈퇴</td>
	    	</tr>
	    	<tr>
	    		<th colspan="2" id="updateInfo" >비밀번호를 입력 후 수정 버튼을 눌러주세요.</th>
	    	</tr>
	    	<tr>
	    		<th></th>
	    		<th id="btnFm">
	     		<button type="submit">수정</button>
	     		<button type="reset" id="resetBtn" onclick="location.href='main.jsp'">취소</button>
	     	</th>
	    	</tr>
	    </table>
	</form>
</body>
</html>