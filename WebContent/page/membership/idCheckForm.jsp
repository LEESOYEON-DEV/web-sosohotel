<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/idCheck.css'/>">
    <script src="<c:url value='/resources/js/id_use_check.js'/>" charset="UTF-8"></script>
    <title>SOSO HOTEL | 아이디 중복확인</title>
</head>
<body onload="fm.id.focus()">
	<div id="chkFm">
	<form action="idCheckPro.jsp" name="fm" method="get" enctype="UTF-8" onsubmit="return useChk()">
		<table>
			<tr id="chkBox">
				<th>아이디</th>
				<td><input type="text" id="id" name="id"></td>
				<td><button type="submit" style="">중복확인</button></td>
			</tr>
			<tr>
				<th id="btnBox" colspan="3">
					<button type="button" onclick="useId()">사용</button>
					<button type="button" id="resetBtn" onclick="winClose()">취소</button>
				</th>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>