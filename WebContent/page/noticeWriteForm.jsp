<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SOSO HOTEL | 공지사항</title>
    <link rel="stylesheet" type="text/css" href="../css/common.css">
</head>
<body>
	<jsp:include page="header.jsp"/>
	<div id="notice">
        <div id="title">
            <h2>공지사항</h2><hr>
        </div>
        <div style="width: 1140px; margin: 0 auto;">
        	<div style="background: yellow;">
        		<input type="text" style="width: 1120px; height: 30px; font-size: 30sp; padding: 10px; text-align: left;" placeholder="글제목">
        	</div>
        	<div style="margin-top: 20px;">
        		<div style="float: left;">작성자 | 2021-07-19</div>
        		<div style="float: right;">등록 취소</div>
        	</div><br>
        	<div style="background: pink; font-size: 20sp; margin-top: 40px; margin-bottom: 200px;">
	        	<textarea rows="" cols="" style="width: 1120px; height: 800px; padding: 10px; font-size: 20sp;">
	        		나리는 꽃가루에 눈이 따끔해 (아야)
					눈물이 고여도 꾹 참을래
					내 마음 한켠 비밀스런 오르골에 넣어두고서
					영원히 되감을 순간이니까
					우리 둘의 마지막 페이지를 잘 부탁해
					어느 작별이 이보다 완벽할까
					나리는 꽃가루에 눈이 따끔해 (아야) 눈물이 고여도 꾹 참을래 내 마음 한켠 비밀스런 오르골에 넣어두고서 영원히 되감을 순간이니까 우리 둘의 마지막 페이지를 잘 부탁해 어느 작별이 이보다 완벽할까 Love me only till this spring 오 라일락 꽃이 지는 날 good bye 이런 결말이 어울려 안녕 꽃잎 같은 안녕 하이얀 우리 봄날의 climax 아 얼마나 기쁜 일이야 Ooh ooh Love me only till this spring 봄바람처럼 Ooh ooh Love me only till this spring 봄바람처럼 기분이 달아 콧노래 부르네 (랄라) 입꼬리는 살짝 올린 채 어쩜 이렇게 하늘은 더 바람은 또 완벽한 건지 오늘따라 내 모습 맘에 들어 처음 만난 그날처럼 예쁘다고 말해줄래 어느 이별이 이토록 달콤할까 Love resembles misty dream 오 라일락 꽃이 지는 날 good bye 이런 결말이 어울려 안녕 꽃잎 같은 안녕 하이얀 우리 봄날의 climax 아 얼마나 기쁜 일이야 Ooh ooh Love resembles misty dream 뜬구름처럼 Ooh ooh Love resembles misty dream 뜬구름처럼 너도 언젠가 날 잊게 될까 지금 표정과 오늘의 향기도 단잠 사이에 스쳐간 봄날의 꿈처럼 오 라일락 꽃이 지는 날 good bye 너의 대답이 날 울려 안녕 약속 같은 안녕 하이얀 우리 봄날에 climax 아 얼마나 기쁜 일이야 Ooh ooh Love me only untill this spring 봄바람처럼 Ooh ooh Love me only untill this spring 봄바람처럼 Ooh ooh Love resembles misty dream 뜬구름처럼 Ooh ooh Love resembles misty dream 뜬구름처럼
					나리는 꽃가루에 눈이 따끔해 (아야) 눈물이 고여도 꾹 참을래 내 마음 한켠 비밀스런 오르골에 넣어두고서 영원히 되감을 순간이니까 우리 둘의 마지막 페이지를 잘 부탁해 어느 작별이 이보다 완벽할까 Love me only till this spring 오 라일락 꽃이 지는 날 good bye 이런 결말이 어울려 안녕 꽃잎 같은 안녕 하이얀 우리 봄날의 climax 아 얼마나 기쁜 일이야 Ooh ooh Love me only till this spring 봄바람처럼 Ooh ooh Love me only till this spring 봄바람처럼 기분이 달아 콧노래 부르네 (랄라) 입꼬리는 살짝 올린 채 어쩜 이렇게 하늘은 더 바람은 또 완벽한 건지 오늘따라 내 모습 맘에 들어 처음 만난 그날처럼 예쁘다고 말해줄래 어느 이별이 이토록 달콤할까 Love resembles misty dream 오 라일락 꽃이 지는 날 good bye 이런 결말이 어울려 안녕 꽃잎 같은 안녕 하이얀 우리 봄날의 climax 아 얼마나 기쁜 일이야 Ooh ooh Love resembles misty dream 뜬구름처럼 Ooh ooh Love resembles misty dream 뜬구름처럼 너도 언젠가 날 잊게 될까 지금 표정과 오늘의 향기도 단잠 사이에 스쳐간 봄날의 꿈처럼 오 라일락 꽃이 지는 날 good bye 너의 대답이 날 울려 안녕 약속 같은 안녕 하이얀 우리 봄날에 climax 아 얼마나 기쁜 일이야 Ooh ooh Love me only untill this spring 봄바람처럼 Ooh ooh Love me only untill this spring 봄바람처럼 Ooh ooh Love resembles misty dream 뜬구름처럼 Ooh ooh Love resembles misty dream 뜬구름처럼
	        	</textarea>
	        	<div style="margin: 0 auto; width: 210px;">
		        	<input type="submit" value="등록" style="margin: 0 auto; width: 100px; height: 60px; background: #646e78; border: none; border-radius: 7px; color: #ffffff; font-weight: bold; font-size: 15px; cursor: pointer;">
		        	<input type="reset" value="취소" style="margin: 0 auto; width: 100px; height: 60px; background: #95a4a6; border: none; border-radius: 7px; color: #ffffff; font-weight: bold; font-size: 15px; cursor: pointer;">
	        	</div>
        	</div>
        </div>
    </div>
	<jsp:include page="footer.jsp"/>
</body>
</html>