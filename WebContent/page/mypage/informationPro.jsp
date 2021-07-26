<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SOSO HOTEL</title>
</head>
<body>
	<%
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		// session으로 읽어오기
		String id = (String)session.getAttribute("id");
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
			sql = "SELECT * FROM member WHERE user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// SELECT문으로 검색한 레코드 값을 저장
			rs = pstmt.executeQuery();
			
			if(!rs.next()) {
				%>
				<script type="text/javascript">
					alert("데이터를 읽어올 수 없습니다.");
				</script>
				<%
			}

			String pw = rs.getString("user_pw");
			String name = rs.getString("user_name");
			String tel = rs.getString("user_tel");
			String email = rs.getString("user_email");
			
			request.setAttribute("pw", pw);
			request.setAttribute("name", name);
			request.setAttribute("tel", tel);
			request.setAttribute("email", email);
			
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
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("informationForm.jsp");
		dispatcher.forward(request, response);
	%>
</body>
</html>