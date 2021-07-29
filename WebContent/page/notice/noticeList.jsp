<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.NoticeDTO"%>
<%
	String sessionId;
	if(session.getAttribute("id") != null)
		sessionId = (String)session.getAttribute("id");
	else
		sessionId = "guest";
	
	List noticeList = (List)request.getAttribute("list");
	int total_record = ((Integer)request.getAttribute("total_record")).intValue(); // 총 게시물 수
	int pageNum = ((Integer)request.getAttribute("pageNum")).intValue();
	int total_page = ((Integer)request.getAttribute("total_page")).intValue();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/noticeList.css'/>">
    <title>SOSO HOTEL | 공지사항</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="notice">
        <div id="title">
            <h2>공지사항</h2><hr>
        </div>
        <table>
        	<tr id="column" style="padding: 10px;">
        		<th style="width: 110px;">글번호</th>
        		<th style="width: 600px;">제목</th>
        		<th style="width: 120px;">작성자</th>
        		<th style="width: 200px;">작성일</th>
        		<th style="width: 110px;">조회수</th>
        	</tr>
        	<tr>
        		<th colspan="5" style="padding: 5px;"><hr><hr></th>
        	</tr>
        	<%
        		for(int i=0; i < noticeList.size(); i++) {
        			NoticeDTO notice = (NoticeDTO)noticeList.get(i);
        	%>
        	<tr>
        		<td><%=notice.getNum()%></td>
        		<td id="not_title"><%=notice.getTitle()%></td>
        		<td><%=notice.getName()%></td>
        		<td><%=notice.getDate()%></td>
        		<td><%=notice.getHit()%></td>
        	</tr>
        	<tr>
        		<th colspan="5" style="padding: 5px;"><hr></th>
        	</tr>
        	<%
        		}
        	%>
        </table>
        <div id="page_number">
        	<div align="center">
        		<c:set var="pageNum" value="<%=pageNum%>"/>
        		<c:forEach var="i" begin="1" end="<%=total_page%>"> <!-- 반복문 -->
        			<a href="<c:url value='./NoticeListAction.do?pageNum=${i}'/>">
        				<c:choose>
        					<c:when test="${pageNum == i}">
        						<font color="#646e78"><b>${i}</b></font>
        					</c:when>
        					<c:otherwise>
        						<font color="bebbb7">${i}</font>
        					</c:otherwise>
        				</c:choose>
        			</a>
        		</c:forEach>
        	</div>
        	<div align="right">
        		<button style="height: 40px;" onclick="">글쓰기</button>
        	</div>
        	<form action="<c:url value='/NoticeListAction.do'/>" method="post">
		        <div style="width: 565px; margin: 20px auto 0 auto;">
			        <select name="items" id="items_select">
			        	<option value="not_title">제목</option>
			        	<option value="not_content">내용</option>
			        	<option value="writer_name">작성자</option>
			        </select>
			        <input name="text" type="text" placeholder="검색어를 입력하세요" id="search_input">
			        <input type="submit" id="search_btn" value="검색">
			    </div>
		    </form>
        </div>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>