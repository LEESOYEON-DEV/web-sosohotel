<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/myPage.css'/>">
    <title>SOSO HOTEL | 마이페이지</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
    <div class="myPage">
        <div id="title">
            <h2>마이페이지</h2><hr>
        </div>
        <div class="myPageForm">
            <div class="myPageMenu">
                <div>정보수정</div>
                <hr>
                <div>예약내역</div>
                <hr>
                <div>취소내역</div>
            </div>
            <div class="myPageContent">
                <!-- 초기화면은 정보수정, 버튼 누르면 액션태그로 변경 -->
                <jsp:include page="informationForm.jsp"/>
            </div>
        </div>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>