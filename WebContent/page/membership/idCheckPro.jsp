<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css'/>">
    <title>SOSO HOTEL</title>
</head>
<body>
	<%
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		// name으로 읽어오기
		String id = request.getParameter("id");
		ResultSet rs = null;
		
		// MySQL 연결에 필요한 변수 선언
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/sosohotel";
		String sql_id = "root";
		String sql_pw = "mysql";
		// DB 연결
		Connection con = null;
		// sql 생성
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			// 드라이버 로더
			Class.forName(driver);
			// DB 연결
			con = DriverManager.getConnection(url, sql_id, sql_pw);
			// id, pw 일치여부 확인
			sql = "SELECT user_id FROM member WHERE user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// SELECT문으로 얻어온 레코드 값을 저장 (테이블 형태)
			rs = pstmt.executeQuery();
			if(!rs.next()) { // 값이 없을 경우 (해당 아이디가 존재하지 않을 경우)
				%>
				<script type="text/javascript">
					alert("사용 가능한 아이디입니다.");
					history.back();
				</script>
				<%
			} else {
				%>
				<script type="text/javascript">
					alert("이미 사용중인 아이디입니다.");
					location.href = "idCheckForm.jsp";
				</script>
				<%
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		}
	%>
</body>
</html>