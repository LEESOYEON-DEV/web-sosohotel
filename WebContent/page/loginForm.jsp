<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/login.css'/>">
    <script src="<c:url value='/resources/js/login_check.js'/>" charset="UTF-8"></script>
    <script src="<c:url value='/resources/js/underline_set.js'/>" charset="UTF-8"></script>
    <title>SOSO HOTEL | 로그인</title>
</head>
<body onload="fm.id.focus()">
	<jsp:include page="header.jsp"/>
	<div id="login">
        <div id="title">
            <h2>로그인</h2><hr>
        </div>
        <form id="loginFm" name="fm" method="post" enctype="UTF-8">
            <table id="loginTable">
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="id" onkeydown="if(event.keyCode == 13) loginChk()"></td>
                    <td rowspan="2"><button type="button" onclick="loginChk()">로그인</button></td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="password" onkeydown="if(event.keyCode == 13) loginChk()"></td>
                </tr>
            </table>
            <hr>
            <table id="loginAssistTable">
                <tr>
                    <td onmouseover="underline(this)" onmouseout="underlineDelete(this)">아이디·비밀번호 찾기</td>
                    <td onmouseover="underline(this)" onmouseout="underlineDelete(this)" onclick="location.href='membership/membershipForm.jsp'">회원가입</td>
                </tr>
            </table>
        </form>
    </div>
	<jsp:include page="footer.jsp"/>
</body>
</html>