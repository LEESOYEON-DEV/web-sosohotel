<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SOSO HOTEL</title>
    <link rel="stylesheet" type="text/css" href="../css/common.css">
</head>
<body>
    <div id="header">
        <div id="headerBox">
            <div id="loginArea">
            <%	// 현재 로그인 상태가 아닐 경우 (session에 저장된 id가 없을 경우)
            	String id = (String)session.getAttribute("id");
            	if(session.getAttribute("id") == null) { %>
	                <a href="loginForm.jsp">로그인</a> |
	                <a href="membershipForm.jsp">회원가입</a> |
            <%  } else { // 현재 로그인 상태일 경우 %>
	            	<a href="logoutPro.jsp">로그아웃</a> |
	                <a href="informationPro.jsp?id=<%=id %>">정보수정</a> |
            <%	} %>
              	<a href="reservationCheckForm.jsp">예약확인</a>
            </div>
            <div id="logoArea">
                <h1><a href="main.jsp">SOSO HOTEL</a></h1>
            </div>
        </div>
    </div>
    <div id="nav">
        <div id="navBox">
            <div id="menu">
                <ul class="menuList">
                    <li class="menuDropdown">
                        <a href="#">호텔소개</a>
                        <div class="menuItem">
                            <a href="#">호텔소개</a>
                            <a href="#">오시는길</a>
                        </div>
                    </li>
                    <li class="menuDropdown">
                        <a href="#">객실안내</a>
                        <div class="menuItem">
                            <a href="#">Single Room</a>
                            <a href="#">Twin Room</a>
                            <a href="#">Double Room</a>
                            <a href="#">Suite Room</a>
                        </div>
                    </li>
                    <li class="menuDropdown">
                        <a href="#">부대시설</a>
                        <div class="menuItem">
                            <a href="#">Restaurant</a>
                            <a href="#">Meeting Room</a>
                            <a href="#">Banquet Hall</a>
                        </div>
                    </li>
                    <li class="menuDropdown">
                        <a href="#">프로모션</a>
                        <div class="menuItem">
                            <a href="#">Event</a>
                            <a href="#">Package</a>
                        </div>
                    </li>
                    <li class="menuDropdown" id="menuDropdownRight">
                        <a href="#">객실예약</a>
                        <div class="menuItem">
                            <a href="reservationForm.jsp">실시간예약</a>
                            <a href="reservationCheckForm.jsp">예약확인</a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>