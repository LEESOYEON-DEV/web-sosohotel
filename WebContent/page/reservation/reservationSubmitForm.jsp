<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reservationSubmit.css'/>">
    <title>SOSO HOTEL | 실시간 예약</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="title">
        <h2>실시간 예약</h2><hr>
    </div>
    <form name="fm" action="" method="post" enctype="UTF-8" id="fm">
        <div id="box">
        	<div id="room">
        		<h3>객실정보</h3>
        		<table>
        			<tr><th>객실명</th><td><input value="${name}" type="text" readonly></td></tr>
        			<tr><th>체크인</th><td><input value="${checkIn}" type="text" readonly></td></tr>
        			<tr><th>체크아웃</th><td><input value="${checkOut}" type="text" readonly></td></tr>
        			<tr><th>숙박일수</th><td><input value="${nights}" type="text" readonly></td></tr>
        			<tr><th>객실수</th><td><input value="${roomCnt}" type="text" readonly></td></tr>
        			<tr><th>성인</th><td><input value="${adultCnt}" type="text" readonly></td></tr>
        			<tr><th>어린이</th><td><input value="${childCnt}" type="text" readonly></td></tr>
        		</table>
        	</div>
        	<div id="guest">
        		<h3>예약자정보</h3>
        		<table>
        			<tr><th>예약자명</th><td><input value="${name}" type="text" readonly></td></tr>
        			<tr><th>연락처</th><td><input value="${tel}" type="text" readonly></td></tr>
        			<tr><th>이메일</th><td><input value="${email}" type="text" readonly></td></tr>
        		</table>
        		<br><hr><br>
        		<h3>결제정보</h3>
        		<table>
        			<tr><th>결제수단</th><td><input value="${method}" type="text" readonly></td></tr>
        			<tr><th>결제금액</th><td><input value="${amount}" type="text" readonly></td></tr>
        		</table>
        	</div>
        	<div id="pay">
        		<h3>결제내역</h3>
        		<table style="">
                    <tr><td></td><td class="right">${weekday} × ${weekday_nights}박</td></tr>
                    <tr><td></td><td class="right">${weekend} × ${weekend_nights}박</td></tr>
                    <tr><td colspan="2"><hr></td></tr>
                    <tr id="result"><td>결제금액</td><td class="right">${amount_s}원</td></tr>
                    <tr><td></td><td class="right1">(VAT포함)</td></tr>
                    <tr></tr><tr></tr>
                    <tr><td colspan="2"><button type="submit" id="submit">예약하기</button></td></tr>
                    <tr><td colspan="2"><button type="reset" id="reset">취소하기</button></td></tr>
                </table>
        	</div>
        </div>
    </form>
	<jsp:include page="../footer.jsp"/>
</body>
</html>