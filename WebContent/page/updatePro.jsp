<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>SOSO HOTEL</title>
    <link rel="stylesheet" type="text/css" href="../css/common.css">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		
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
			// id 값으로 데이터 검색
			sql = String.format("UPDATE member SET user_pw='%s', user_name='%s', user_tel='%s', user_email='%s' WHERE user_id='%s';", pw, name, tel, email, id);
			stmt = con.createStatement();
			
			// UPDATE문으로 수정한 레코드 값을 저장
			int result = stmt.executeUpdate(sql);
			
			if(result < 1) {
				%>
				<script type="text/javascript">
					alert("데이터를 수정할 수 없습니다. 다시 시도해주세요.");
					history.back();
				</script>
				<%
			} else {
				%>
				<script type="text/javascript">
					alert("회원정보가 수정되었습니다.");
					location.href = "main.jsp";
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