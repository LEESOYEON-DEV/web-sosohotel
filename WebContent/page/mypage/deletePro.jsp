<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
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
		String id = (String)session.getAttribute("id");
		String pw = request.getParameter("password");
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
			// id 값으로 데이터 검색
			sql = "SELECT user_pw FROM member WHERE user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// SELECT문으로 검색한 레코드 값을 저장
			rs = pstmt.executeQuery(); // SELECT
			
			if(!rs.next()) {
				%>
				<script type="text/javascript">
					alert("데이터를 읽어올 수 없습니다.");
				</script>
				<%
			} else {
				rs.getString(1);
				String db_pw = rs.getString("user_pw");
				if(pw.equals(db_pw)) { // password가 일치할 경우
					// 회원정보 삭제
					sql = "DELETE FROM member WHERE user_id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate(); // INSERT, UPDATE, DELETE
					// 로그아웃
					session.invalidate(); // session 재시작 (저장된 값 삭제)
					%>
					<script type="text/javascript">
						alert("회원탈퇴가 정상적으로 처리되었습니다. 이용해 주셔서 감사합니다.");
						location.href = "../main.jsp";
					</script>
					<%
				} else { // password가 일치하지 않을 경우
					%>
					<script type="text/javascript">
						alert("비밀번호가 일치하지 않습니다.");
						history.back();
					</script>
					<%
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>