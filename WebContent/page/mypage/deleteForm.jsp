<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/delete.css'/>">
    <title>SOSO HOTEL | 회원탈퇴</title>
    
</head>
<body onload="fm.password.focus()">
	<jsp:include page="../header.jsp"/>
	<div id="delete">
        <div id="title">
            <h2>회원탈퇴</h2><hr>
        </div>
        <form action="deletePro.jsp" name="fm" method="post" enctype="UTF-8">
      	<table>
      		<tr id="pwChk">
      			<th>비밀번호 확인</th>
      			<td><input type="password" name="password"></td>
      		</tr>
      		<tr>
      			<td colspan="2" id="pwInfoText">비밀번호를 입력 후 탈퇴 버튼을 눌러주세요.</td>
      		</tr>
      		<tr>
      			<th colspan="2" id="btnBox">
       			<button type="submit">탈퇴</button>
       			<button type="reset" id="resetBtn" onclick="location.href='../main.jsp'">취소</button>
       		</th>
      		</tr>
      	</table>
        </form>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>