<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.sun.xml.internal.ws.api.ha.StickyFeature"%>
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
		// name으로 읽어오기
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		String emailId = request.getParameter("email");
		String emailSelected = request.getParameter("emailSelected");
		String email = emailId+"@"+emailSelected;
		
		// MySQL 연결에 필요한 변수 선언
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/sosohotel";
		String sql_id = "root";
		String sql_pw = "mysql";
		// DB 연결
		Connection con = null;
		// sql 생성
		Statement stmt = null;
		String sql = "";

		try {
			// 드라이버 로더
			Class.forName(driver);
			// DB 연결
			con = DriverManager.getConnection(url, sql_id, sql_pw);
			// DB에 값을 입력하는 sql 작성
			sql = String.format("INSERT INTO member VALUES ('%s', '%s', '%s', '%s', '%s', sysdate());", id, pw, name, tel, email);
			stmt = con.prepareStatement(sql);
			
			// INSERT문으로 생성한 레코드 값을 저장
			int result = stmt.executeUpdate(sql);

			if(result < 1) {
				%>
				<script type="text/javascript">
					alert("가입이 정상적으로 진행되지 않았습니다. 다시 시도해주세요.");
					location.href = "../main.jsp";
				</script>
				<%
			} else {
				%>
				<script type="text/javascript">
					alert("정상적으로 가입되었습니다. 가입하신 아이디로 로그인 해주세요.");
					location.href = "../main.jsp";
				</script>
				<%
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) stmt.close();
				if(con != null) con.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>