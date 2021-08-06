package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;

import mvc.database.DBConn;

public class MemberDAO {

	private static MemberDAO instance;
	
	private MemberDAO() {}
	
	public static MemberDAO getInstance() {
		if(instance == null)
			instance = new MemberDAO();
		return instance;
	}

	// 회원 정보 반환
	public ArrayList<MemberDTO> getMemberInfo(String id) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM member WHERE user_id=?";
		ArrayList<MemberDTO> memberInfo = new ArrayList<MemberDTO>();
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				MemberDTO member = new MemberDTO();
				member.setName(rs.getString("user_name"));
				member.setTel(rs.getString("user_tel"));
				member.setEmail(rs.getString("user_email"));
				memberInfo.add(member);
			}
			return memberInfo;
			
		} catch(Exception e) {
			System.out.println("getMemberInfo() error : " + e);
			
		} finally {
			
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return null;
	}
}