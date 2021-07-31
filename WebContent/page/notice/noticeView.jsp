<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="mvc.model.NoticeDTO"%>
<%
	String sessionId = (String)session.getAttribute("id");
	NoticeDTO notice = (NoticeDTO)request.getAttribute("notice");
	int num = ((Integer)request.getAttribute("num")).intValue();
	int nowPage = ((Integer)request.getAttribute("page")).intValue();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <title>SOSO HOTEL | 공지사항</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="notice">
        <div id="title">
            <h2>공지사항</h2><hr>
        </div>
        <div style="width: 1140px; margin: 0 auto;">
        	<div><h1><%=notice.getTitle()%></h1></div>
        	<div style="margin-top: 20px;">
        		<div style="float: left;">
        			<%=notice.getName()%> | <%=notice.getDate()%>
        		</div>
        		<% if(sessionId.equals(notice.getId())) { %>
        		<div style="float: right;">
        			<a href="./notice/NoticeUpdateForm.do?num=<%=notice.getNum()%>">수정</a>
        			<a href="./notice/NoticeDeleteAction.do?num=<%=notice.getNum()%>">삭제</a>
        		</div>
        		<% } %>
        	</div><br>
        	<hr style="margin-top: 20px;"><hr>
        	<div style="font-size: 20px; margin-top: 40px; margin-bottom: 200px;">
        		<textarea readonly style="width: 1140px; height: 600px; border: none;"><%=notice.getContent()%></textarea>
        	</div>
        </div>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>