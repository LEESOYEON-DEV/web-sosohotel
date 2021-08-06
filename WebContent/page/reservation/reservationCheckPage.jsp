<%@page import="mvc.model.PaymentDTO"%>
<%@page import="mvc.model.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	List resInfo = (List)request.getAttribute("resInfo");
	ReservationDTO res = (ReservationDTO)resInfo.get(0);
	List payInfo = (List)request.getAttribute("payInfo");
	PaymentDTO pay = (PaymentDTO)payInfo.get(0);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reservationSubmit.css'/>">
    <script src="<c:url value='/resources/js/res_submit_check.js'/>" charset="UTF-8"></script>
    <title>SOSO HOTEL | 예약확인</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="title">
        <h2>예약확인</h2><hr>
    </div>
    <div style="width: 100%; ">
    	<div style="background: yellow; width: 1080px; height: 150px; background: #dfe4ec; margin: 0 auto 20px auto; padding: 30px;">
    		<div style="background: #ffffff; width: 1080px; height: 50px; text-align: center; padding: 50px 0;">
		    	<h2>예약이 완료되었습니다.</h2>
		    	( 예약번호 : ${resNum} )
	    	</div>
    	</div>
    </div>
    <form name="fm" action="" method="post" enctype="UTF-8" id="fm" onsubmit="return resInfoChk()">
        <div id="box">
        	<div id="room">
        		<h3>객실정보</h3>
        		<table>
        			<tr><th>객실명</th><td><input name="roomName" value="<%=res.getRoomType()%>" type="text" readonly></td></tr>
        			<tr><th>체크인</th><td><input name="checkIn" value="<%=res.getCheckIn()%>" type="text" readonly></td></tr>
        			<tr><th>체크아웃</th><td><input name="checkOut" value="<%=res.getCheckOut()%>" type="text" readonly></td></tr>
        			<tr><th>숙박일수</th><td><input name="nights" value="<%=res.getNights()%>" type="text" readonly></td></tr>
        			<tr><th>객실수</th><td><input name="roomCnt" value="<%=res.getRoomCount()%>" type="text" readonly></td></tr>
        			<tr><th>성인</th><td><input name="adultCnt" value="<%=res.getAdult()%>" type="text" readonly></td></tr>
        			<tr><th>어린이</th><td><input name="childCnt" value="<%=res.getChild()%>" type="text" readonly></td></tr>
        		</table>
        	</div>
        	<div id="guest">
        		<h3>예약자정보</h3>
        		<table>
        			<tr><th>예약자명</th><td><input name="name" value="<%=res.getUserName()%>" type="text" readonly></td></tr>
        			<tr><th>연락처</th><td><input name="tel" value="<%=res.getUserTel()%>" type="text" readonly></td></tr>
        			<tr><th>이메일</th><td><input name="email" value="<%=res.getUserEmail()%>" type="text" readonly></td></tr>
        		</table>
        		<br><hr><br>
        		<h3>결제정보</h3>
        		<table>
        			<tr><th>결제수단</th><td><input name="method" value="<%=pay.getMethod()%>" type="text" readonly></td></tr>
        			<tr><th>결제금액</th><td><input name="amount" value="<%=pay.getAmount()%>" type="text" readonly></td></tr>
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
                    <tr><td colspan="2"><button type="reset" id="reset" onclick="<c:url value='./main.jsp'/>">확인</button></td></tr>
                    <tr><td colspan="2"><button type="submit" id="submit">예약취소</button></td></tr>
                </table>
        	</div>
        </div>
    </form>
	<jsp:include page="../footer.jsp"/>
</body>
</html>