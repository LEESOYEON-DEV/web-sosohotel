<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reservationCheck.css'/>">
    <title>SOSO HOTEL | 예약확인</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="reservationCheck">
        <div id="title">
            <h2>예약확인</h2><hr>
        </div>
        <div id="resChkFm">
            <!-- 예약번호로 조회 -->
            <div id="chk1"><br><br>
            <form action="" method="post" enctype="UTF-8">
            	<table>
            		<tr>
            			<th>예약번호</th>
            			<td><input type="text"></td>
            		</tr>
            		<tr>
            			<th colspan="2"><button type="submit">조회</button></th>
            		</tr>
            	</table>                
            </form>
            </div>
            <!-- 예약번호로 조회 -->
            <div id="verticalLine"></div>
            <!-- 예약자명, 연락처로 조회 -->
            <div id="chk2">
            <form action="" method="post" enctype="UTF-8">
            	<table>
            		<tr><th>예약자명</th><td><input type="text"></td></tr>
            		<tr><th>연락처</th><td><input type="text"></td></tr>
            		<tr><th colspan="2"><button type="submit">조회</button></th></tr>
            	</table>
            </form>
            </div>
            <!-- 예약자명, 연락처로 조회 -->
        </div>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>