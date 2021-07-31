<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.NoticeDTO"%>
<%
	String sessionId = (String)session.getAttribute("id");
	NoticeDTO notice = (NoticeDTO)request.getAttribute("notice");
	int num = ((Integer)request.getAttribute("num")).intValue();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/noticeWriteForm.css'/>">
    <title>SOSO HOTEL | 공지사항</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="notice">
        <div id="title">
            <h2>공지사항</h2><hr>
        </div>
        <form action="./notice/NoticeUpdateAction.do?num=<%=num%>" method="post" onsubmit="return check()" name="fm">
	        <div id="write_form">
	        	<div>
	        		<input name="title" type="text" value="<%=notice.getTitle()%>" id="title" style="width: 1120px;">
	        		<input name="name" type="text" value="<%=notice.getName()%>" readonly>
	        	</div>
	        	<div id="content_box">
		        	<textarea name="content" id="content"><%=notice.getContent()%></textarea>
		        	<div id="btn_box">
			        	<input type="submit" value="수정" id="btn_submit">
			        	<input type="reset" value="취소" onclick="location.href='./notice/NoticeListAction.do?pageNum=1'" id="btn_reset">
		        	</div>
	        	</div>
	        </div>
        </form>
    </div>
	<jsp:include page="../footer.jsp"/>
	
	<script type="text/javascript">
		function check() {
			if(fm.name.value == null) {
				alert("로그인을 해주세요.");
				return false;
			}
			if(!fm.title.value) {
				alert("제목을 입력해주세요.");
				return false;
			}
			if(!fm.content.value) {
				alert("내용을 입력해주세요.");
				return false;
			}
		}
	</script>
</body>
</html>