<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/membership.css'/>">
    <script src="<c:url value='/resources/js/id_check_new_win.js'/>" charset="UTF-8"></script>
    <script src="<c:url value='/resources/js/join_check.js'/>" charset="UTF-8"></script>
    <script src="<c:url value='/resources/js/email_input.js'/>" charset="UTF-8"></script>
    <title>SOSO HOTEL | 회원가입</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="membership">
        <div id="title">
            <h2>회원가입</h2><hr>
        </div>
        <form action="membershipPro.jsp" class="membershipFm" name="fm" method="post" enctype="UTF-8" onsubmit="return joinChk()">
            <table>
                <tr>
                	<th>아이디</th>
                	<td><input type="text" id="id" name="id"onclick="openIdChk()" onfocus="openIdChk()" onchange="openIdChk()" readonly></td>
                	<td><button type="button" id="checkBtn" onclick="openIdChk()">중복확인</button></td>
                </tr>
                <tr>
                	<td colspan="3" id="idInfoText">아이디는 4~12자의 영소문자, 숫자로 입력해주세요.</td>
                </tr>
                <tr>
                	<th>비밀번호</th>
                	<td><input type="password" name="password" onchange="pwChk()"></td>
                	<td></td>
                </tr>
                <tr>
                	<th>비밀번호 확인</th>
                	<td><input type="password" name="passwordCheck" onchange="pwChk()"></td>
                	<td></td>
                </tr>
                <tr>
                	<td colspan="3" id="pwInfoText">비밀번호는 4~12자의 영소문자, 숫자로 입력해주세요.</td>
                </tr>
                <tr>
                	<td colspan="3"><hr></td>
                </tr>
                <tr>
                	<th>이름</th>
                	<td><input type="text" name="name"></td>
                	<td></td>
                </tr>
                <tr>
                	<th>연락처</th>
                	<td><input type="text" name="tel"></td>
                	<td class="infoText">'-'은 제외하고 입력</td>
                </tr>
                <tr class="emailInput">
                	<th id="emailText">이메일</th>
                	<th colspan="2">
                		<input type="text" id="email" name="email">
                		@
                		<input type="text" id="emailSelected" name="emailSelected" disabled>
                	</th>
                </tr>
                <tr>
                	<th></th>
                	<th>
	                    <select id="emailSelect" name="emailSelect" onchange="emailChange()">
	                   		<option value="none">선택하세요</option>
	                        <option value="naver.com">naver.com</option>
	                        <option value="daum.net">daum.net</option>
	                        <option value="google.com">google.com</option>
	                        <option value="nate.com">nate.com</option>
	                        <option value="textBoxOpen">직접입력</option>
	                    </select>
	                </th>
	                <th></th>
                </tr>
                <tr id="btnBox">
                    <td colspan="3">
                        <button type="submit">가입</button>
                        <button type="reset" id="resetBtn" onclick="location.href='../main.jsp'">취소</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>