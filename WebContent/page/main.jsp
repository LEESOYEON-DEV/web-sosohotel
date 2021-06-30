<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SOSO HOTEL | 메인</title>
    <link rel="stylesheet" type="text/css" href="../resources/css/common.css">
    <link rel="stylesheet" type="text/css" href="../resources/css/main.css">
    <script src="../resources/js/image_size.js" charset="UTF-8"></script>
	<script src="../resources/js/auto_date.js" charset="UTF-8"></script>
	<script src="../resources/js/auto_nights.js" charset="UTF-8"></script>
</head>
<body onload="checkInOut(); nights();">
	<jsp:include page="header.jsp"></jsp:include>
    <div id="mainTop">
        <div id="promotionImgFm">
            <img class="promotionImg" src="http://placehold.it/280x280" alt="" width="280" height="280">
            <img class="promotionImg" src="http://placehold.it/280x280" alt="" width="280" height="280">
            <img class="promotionImg" src="http://placehold.it/280x280" alt="" width="280" height="280">
            <img class="promotionImg" src="http://placehold.it/280x280" alt="" width="280" height="280">
        </div>
    </div>
    <div id="mainBottom">
        <div id="reservationFm">
            <table>
                <tr>
                    <th>체크인</th>
                    <th></th>
                    <th>체크아웃</th>
                    <th>객실</th>
                    <th>성인</th>
                    <th>어린이</th>
                    <th rowspan="2"><button type="submit" id="searchBtn">검색</button></th>
                </tr>
                <tr>
                    <th><input type="date" id="checkIn" onchange="dateCheck(); nights();"></th>
                    <th id="nights"></th>
                    <th><input type="date" id="checkOut" onchange="dateCheck(); nights();"></th>
                    <th><input type="number" min="1" max="1" value="1"></th>
                    <th><input type="number" min="1" max="2" value="1"></th>
                    <th><input type="number" min="0" max="2" value="0"></th>
                </tr>
            </table>
        </div>
    </div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>