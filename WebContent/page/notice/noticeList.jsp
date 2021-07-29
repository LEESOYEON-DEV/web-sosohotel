<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.NoticeDTO"%>
<%
	String sessionId = (String)session.getAttribute("id");
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
    <title>SOSO HOTEL | 공지사항</title>
</head>
<body>
	<jsp:include page="../header.jsp"/>
	<div id="notice">
        <div id="title">
            <h2>공지사항</h2><hr>
        </div>
        <table style="margin: 0 auto; width: 1140px; text-align: center;">
        	<tr style="padding: 10px;">
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
        		<td style="text-align: left; padding-left: 10px;"><%=notice.getTitle()%></td>
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
        <div style="width: 1140px; margin: 20px auto 200px auto;">
        	<div>
        		<c:set var="pageNum" value="<%=pageNum%>"/>
        		<c:forEach var="i" begin="1" end="<%=total_page%>">
        			<a href="<c:url value='./NoticeListAction.do?pageNum=${i}'/>">
        				<c:choose>
        					<c:when test="${pageNum == i}">
        						<font color="red"><b>[${i}]</b></font>
        					</c:when>
        					<c:otherwise>
        						<font color="blue">[${i}]</font>
        					</c:otherwise>
        				</c:choose>
        			</a>
        		</c:forEach>
        	</div>
<!--         	<table>
        		<tr>
        			<td style="background: pink; width: 200px;"><button style="height: 40px;" onclick="location.href='noticeWriteForm.jsp'">글쓰기</button></td>
        			<td style="background: yellow; width: 740px; text-align: center;"><  1  2  3  4  5  ></td>
        			<td style="background: black; width: 200px;"></td>
        		</tr>
        	</table> -->
	        
	        <div style="width: 565px; margin: 20px auto 0 auto;">
		        <select style="width: 115px; height: 40px; margin-right: 5px; padding: 0 10px; border: 1px solid #d4d6d6; border-radius: 7px; color: black; font-weight: normal;">
		        	<option>제목+내용</option>
		        	<option>작성자</option>
		        </select>
		        <input type="text" placeholder="검색어를 입력하세요" style="width: 300px; height: 40px; margin-right: 5px; padding: 0 10px; border: 1px solid #d4d6d6; border-radius: 7px; color: black; font-weight: normal;">
		        <button style="height: 40px; background: #95a4a6;">검색</button>
		    </div>
        </div>
    </div>
	<jsp:include page="../footer.jsp"/>
</body>
</html>