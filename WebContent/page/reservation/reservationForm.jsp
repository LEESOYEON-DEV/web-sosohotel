<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.RoomDTO"%>
<%@ page import="mvc.model.MemberDTO"%>
<%
	String sessionId;
	if(session.getAttribute("id") != null) sessionId = (String)session.getAttribute("id");
	else sessionId = "guest";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reservation.css'/>">
    <script src="<c:url value='/resources/js/auto_date.js'/>" charset="UTF-8"></script>
    <script src="<c:url value='/resources/js/auto_nights.js'/>" charset="UTF-8"></script>
    <script src="<c:url value='/resources/js/res_form_auto_data.js'/>" charset="UTF-8"></script>
	<title>SOSO HOTEL | 실시간 예약</title>
</head>
<body onload="checkInOut(); nights(); autoData();">
	<jsp:include page="../header.jsp"/>
    <div class="reservationStep1">
        <div id="title">
            <h2>실시간 예약</h2><hr>
        </div>
        <div class="reservationBox">
            <table>
                <tr>
                    <th>체크인</th>
                    <th></th>
                    <th>체크아웃</th>
                    <th>객실</th>
                    <th>성인</th>
                    <th>어린이</th>
                    <th rowspan="2"><button id="searchBtn" type="submit" onclick="autoData();">검색</button></th>
                </tr>
                <tr>
                    <th><input type="date" id="checkIn" onchange="dateCheck(); nights(); autoData();"></th>
                    <th id="nights"></th>
                    <th><input type="date" id="checkOut" onchange="dateCheck(); nights(); autoData();"></th>
                    <th><input id="room" type="number" min="1" max="1" value="1" onchange="autoData();"></th>
                    <th><input id="adult" type="number" min="1" max="2" value="1" onchange="autoData();"></th>
                    <th><input id="child" type="number" min="0" max="2" value="0" onchange="autoData();"></th>
                </tr>
            </table>
        </div>
    </div>

    <div class="reservationStep2">
        <div class="roomSelectForm">
        <%
        	if(request.getAttribute("roomList") != null) {
	        	List roomList = (List)request.getAttribute("roomList");
	        	for(int i=0; i<roomList.size(); i++) {
	        		RoomDTO room = (RoomDTO)roomList.get(i);
        %>
            <div class="roomSelect">
                <div><img src="http://placehold.it/150x150" width="150" height="150"></div>
                <div class="roomInfo">
                    <table>
                        <tr><td colspan="2" class="roomTitle"><%=room.getName()%></td></tr>
                        <tr><td>기준인원 <span><%=room.getBasicPeople()%></span>명</td><td></td></tr>
                        <tr class="textCen"><td>평일(일~목)</td><td>주말(금~토)</td></tr>
                        <tr class="textCen"><td><%=room.getWeekdayPrice_s()%></td><td><%=room.getWeekendPrice_s()%></td></tr>
                    </table>
                </div>
                <div class="resInfo">
                    <table>
                        <tr><th>체크인</th><td class="checkInText"></td></tr>
                        <tr><th>체크아웃</th><td class="checkOutText"></td></tr>
                        <tr><th>객실수</th><td class="roomText"></td></tr>
                        <tr><th>성인</th><td class="adultText"></td></tr>
                        <tr><th>어린이</th><td class="childText"></td></tr>
                    </table>
                </div>
                <div id="selectBtn"><button value="<%=i%>" onclick="selectChk(this);">선택</button></div>
            </div>
        <%
        		}}
        %>            
        </div>
    </div>

<%
	String cusName = null, cusTel = null, cusEmail = null;
	if(session.getAttribute("id") != null) {
		if(request.getAttribute("memberInfo") != null) {
			List memberInfo = (List)request.getAttribute("memberInfo");
			MemberDTO member = (MemberDTO)memberInfo.get(0);
			cusName = member.getName();
			cusTel = member.getTel();
			cusEmail = member.getEmail();
		} else {
			cusName = "회원정보를";
			cusTel = "읽어오지";
			cusEmail = "못했습니다";
		}
	} else {
		cusName = "비회원";
		cusTel = "";
		cusEmail = "";
	}
%>
    <div class="reservationStep3">
        <div class="infoCheckForm">
            <form name="resFm" class="infoCheck" method="post" enctype="UTF-8">
                <div class="customerInfo">
                    <h3>예약자정보</h3>
                    <table>
                        <tr><th>예약자명</th><td><input name="name" id="cusName" type="text" value="<%=cusName%>"></td></tr>
                        <tr><th>연락처</th><td><input name="tel" id="cusTel" type="text" value="<%=cusTel%>"></td></tr>
                        <tr><th>이메일</th><td><input name="email" id="cusEmail" type="email" value="<%=cusEmail%>"></td></tr>
                    </table>
                </div>
                <div class="resultInfo">
                    <h3>예약정보</h3>
                    <table>
                        <tr><th>객실명</th><td><input name="roomName" id="resRmName" type="text" readonly></td></tr>
                        <tr><th>체크인</th><td><input name="checkIn" id="resCheckIn" type="text" readonly></td></tr>
                        <tr><th>체크아웃</th><td><input name="checkOut" id="resCheckOut" type="text" readonly></td></tr>
                        <tr><th>숙박일수</th><td><input name="nights" id="resNights" type="text" readonly></td></tr>
                        <tr><th>객실수</th><td><input name="roomCnt" id="resRmCnt" type="text" readonly></td></tr>
                        <tr><th>성인</th><td><input name="adultCnt" id="resAdultCnt" type="text" readonly></td></tr>
                        <tr><th>어린이</th><td><input name="childCnt" id="resChildCnt" type="text" readonly></td></tr>
                    </table>
                </div>
                <div id="paymentInfo">
                    <div id="methodSelect">
                        <h3>결제수단</h3>
                        <div id="methodCheck">
                            <div id="radioBox">
                                <input name="method" value="신용카드" type="radio" style="vertical-align: -8px;"> 신용카드<br>
                                <input name="method" value="무통장입금" type="radio" style="vertical-align: -8px;"> 무통장입금<br>
                                <input name="method" value="현장결제" type="radio" style="vertical-align: -8px;"> 현장결제<br>
                            </div>
                            <div id="btnBox">
                                <button type="button" onclick="resInfoChk()">결제</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
	<jsp:include page="../footer.jsp"/>
	<script type="text/javascript">
		// 예약 정보 확인
		function resInfoChk() {
			
			if(!resFm.name.value) {
				alert("예약자명을 입력해주세요.");
				resFm.name.focus();
				return;
			}
			if(!resFm.tel.value) {
				alert("연락처를 입력해주세요.");
				resFm.tel.focus();
				return;
			}
			if(!resFm.email.value) {
				alert("이메일을 입력해주세요.");
				resFm.email.focus();
				return;
			}
			if(!resFm.roomName.value) {
				alert("객실을 선택해주세요.");
				resFm.roomName.focus();
				return;
			}
			if(!resFm.method.value) {
				alert("결제수단을 선택해주세요.");
				resFm.method.focus();
				return;
			}
			
			resFm.action = "../resController/resAmountForm.do";
			resFm.submit();
		}
    	// 예약 정보 자동 입력
    	function selectChk(e) {
    		
    		inputData();
    		
			var i = e.value;
			var roomName = document.getElementsByClassName("roomTitle")[i].innerHTML;
			document.getElementById("resRmName").value = roomName;
		}
    	
    	// 객실 정보 자동 입력
    	function inputData() {
    		
			var checkIn = document.getElementById("checkIn");
			var checkOut = document.getElementById("checkOut");
			var nights = document.getElementById("nights");
			var room = document.getElementById("room");
			var adult = document.getElementById("adult");
			var child = document.getElementById("child");
			
			document.getElementById("resCheckIn").value = checkIn.value;
			document.getElementById("resCheckOut").value = checkOut.value;
			document.getElementById("resNights").value = nights.innerHTML;
			document.getElementById("resRmCnt").value = room.value;
			document.getElementById("resAdultCnt").value = adult.value;
			document.getElementById("resChildCnt").value = child.value;
		}
    </script>
</body>
</html>