<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		// name으로 읽어오기
		String id = request.getParameter("id");
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
			// id, pw 일치여부 확인
			sql = "SELECT user_pw FROM member WHERE user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// SELECT문으로 얻어온 레코드 값을 저장 (테이블 형태)
			rs = pstmt.executeQuery();
			// rs에 저장된 데이터와 입력된 password 비교
			if(!rs.next()) { // 값이 없을 경우
				%>
				<script type="text/javascript">
					alert("존재하지 않는 아이디입니다.");
					location.href = "loginForm.jsp";
				</script>
				<%
			} else { // 값이 있을 경우
				rs.getString(1);
				String db_pw = rs.getString("user_pw");
				if(pw.equals(db_pw)) { // password가 일치할 경우
					// session 값 생성 후 main으로 이동
					session.setAttribute("id", id);
					%>
					<script type="text/javascript">
						alert("로그인 되었습니다.");
						location.href = "main.jsp";
					</script>
					<%
				} else { // password가 일치하지 않을 경우
					%>
					<script type="text/javascript">
						alert("비밀번호가 일치하지 않습니다.");
						location.href = "loginForm.jsp";
					</script>
					<%
				}
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