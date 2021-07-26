<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reservation.css'/>">
    <script src="<c:url value='/resources/js/auto_date.js'/>" charset="UTF-8"></script>
    <script src="<c:url value='/resources/js/auto_nights.js'/>" charset="UTF-8"></script>
	<title>SOSO HOTEL | 실시간 예약</title>
</head>
<body onload="checkInOut(); nights();">
	<jsp:include page="../header.jsp"/>
    <div class="reservationStep1">
        <div id="title">
            <h2>실시간 예약</h2><hr>
        </div>
        <div class="reservationBox">
            <form action="" method="get" enctype="utf-8">
            <table>
                <tr>
                    <th>체크인</th>
                    <th></th>
                    <th>체크아웃</th>
                    <th>객실</th>
                    <th>성인</th>
                    <th>어린이</th>
                    <th rowspan="2"><button id="searchBtn" type="submit">검색</button></th>
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
            </form>
        </div>
    </div>

    <div class="reservationStep2">
        <div class="roomSelectForm">
            <div class="roomSelect">
                <div><img src="http://placehold.it/150x150" alt="single room" width="150" height="150"></div>
                <div class="roomInfo">
                    <table>
                        <tr><td colspan="2" class="roomTitle">Single Room</td></tr>
                        <tr><td>기준인원 <span>1</span>명</td><td></td></tr>
                        <tr class="textCen"><td>평일(일~목)</td><td>주말(금~토)</td></tr>
                        <tr class="textCen"><td>50,000</td><td>70,000</td></tr>
                    </table>
                </div>
                <div class="resInfo">
                    <table>
                        <tr><th>체크인</th><td>2021-05-01</td></tr>
                        <tr><th>체크아웃</th><td>2021-05-02</td></tr>
                        <tr><th>객실수</th><td>1</td></tr>
                        <tr><th>성인</th><td>1</td></tr>
                        <tr><th>어린이</th><td>0</td></tr>
                    </table>
                </div>
                <div id="selectBtn"><button>선택</button></div>
            </div>
            <div class="roomSelect">
                <div><img src="http://placehold.it/150x150" alt="twin room" width="150" height="150"></div>
                <div class="roomInfo">
                    <table>
                        <tr><td colspan="2" class="roomTitle">Twin Room</td></tr>
                        <tr><td>기준인원 <span>2</span>명</td><td></td></tr>
                        <tr class="textCen"><td>평일(일~목)</td><td>주말(금~토)</td></tr>
                        <tr class="textCen"><td>80,000</td><td>120,000</td></tr>
                    </table>
                </div>
                <div class="resInfo">
                    <table>
                        <tr><th>체크인</th><td>2021-05-01</td></tr>
                        <tr><th>체크아웃</th><td>2021-05-02</td></tr>
                        <tr><th>객실수</th><td>1</td></tr>
                        <tr><th>성인</th><td>1</td></tr>
                        <tr><th>어린이</th><td>0</td></tr>
                    </table>
                </div>
                <div id="selectBtn"><button>선택</button></div>
            </div>
            <div class="roomSelect">
                <div><img src="http://placehold.it/150x150" alt="double room" width="150" height="150"></div>
                <div class="roomInfo">
                    <table>
                        <tr><td colspan="2" class="roomTitle">Double Room</td></tr>
                        <tr><td>기준인원 <span>2</span>명</td><td></td></tr>
                        <tr class="textCen"><td>평일(일~목)</td><td>주말(금~토)</td></tr>
                        <tr class="textCen"><td>80,000</td><td>120,000</td></tr>
                    </table>
                </div>
                <div class="resInfo">
                    <table>
                        <tr><th>체크인</th><td>2021-05-01</td></tr>
                        <tr><th>체크아웃</th><td>2021-05-02</td></tr>
                        <tr><th>객실수</th><td>1</td></tr>
                        <tr><th>성인</th><td>1</td></tr>
                        <tr><th>어린이</th><td>0</td></tr>
                    </table>
                </div>
                <div id="selectBtn"><button>선택</button></div>
            </div>
            <div class="roomSelect">
                <div><img src="http://placehold.it/150x150" alt="suite room" width="150" height="150"></div>
                <div class="roomInfo">
                    <table>
                        <tr><td colspan="2" class="roomTitle">Suite Room</td></tr>
                        <tr><td>기준인원 <span>2</span>명</td><td></td></tr>
                        <tr class="textCen"><td>평일(일~목)</td><td>주말(금~토)</td></tr>
                        <tr class="textCen"><td>120,000</td><td>160,000</td></tr>
                    </table>
                </div>
                <div class="resInfo">
                    <table>
                        <tr><th>체크인</th><td>2021-05-01</td></tr>
                        <tr><th>체크아웃</th><td>2021-05-02</td></tr>
                        <tr><th>객실수</th><td>1</td></tr>
                        <tr><th>성인</th><td>1</td></tr>
                        <tr><th>어린이</th><td>0</td></tr>
                    </table>
                </div>
                <div id="selectBtn"><button>선택</button></div>
            </div>
        </div>
    </div>

    <div class="reservationStep3">
        <div class="infoCheckForm">
            <form class="infoCheck" action="" method="post" enctype="UTF-8">
                <div class="customerInfo">
                    <h3>예약자정보</h3>
                    <table>
                        <tr><th>이름</th><td><input type="text"></td></tr>
                        <tr><th>연락처</th><td><input type="text"></td></tr>
                        <tr><th>이메일</th><td><input type="email"></td></tr>
                    </table>
                </div>
                <div class="resultInfo">
                    <h3>예약정보</h3>
                    <table>
                        <tr><th>객실타입</th><td><input type="text" readonly></td></tr>
                        <tr><th>체크인</th><td><input type="date" readonly></td></tr>
                        <tr><th>체크아웃</th><td><input type="date" readonly></td></tr>
                        <tr><th>숙박일수</th><td><input type="text" readonly></td></tr>
                        <tr><th>객실수</th><td><input type="text" readonly></td></tr>
                        <tr><th>성인</th><td><input type="text" readonly></td></tr>
                        <tr><th>어린이</th><td><input type="text" readonly></td></tr>
                    </table>
                </div>
                <div id="paymentInfo">
                    <div id="amountInfo">
                        <h3>결제금액</h3>
                        <table>
                            <tr><td></td><td>70,000</td></tr>
                            <tr><td></td><td>(1박)</td></tr>
                            <tr><td colspan="2"><hr></td></tr>
                            <tr id="infoText"><td>결제금액</td><td>70,000원</td></tr>
                        </table>
                    </div>
                    <div id="methodSelect">
                        <h3>결제수단</h3>
                        <div id="methodCheck">
                            <div id="radioBox">
                                <input type="radio" style="vertical-align: -8px;"> 신용카드<br>
                                <input type="radio" style="vertical-align: -8px;"> 무통장입금<br>
                                <input type="radio" style="vertical-align: -8px;"> 현장결제<br>
                            </div>
                            <div id="btnBox">
                                <button>결제</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>