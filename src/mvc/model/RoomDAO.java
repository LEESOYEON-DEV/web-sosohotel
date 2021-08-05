package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import mvc.database.DBConn;

public class RoomDAO {
	
	private static RoomDAO instance;
		
	private RoomDAO() {}
	
	public static RoomDAO getInstance() {
		if(instance == null)
			instance = new RoomDAO();
		return instance;
	}
	
	// 객실명으로 객실타입 반환
	public String getRoomType(String roomName) {
		
		String roomType = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT rm_type FROM room WHERE rm_name=?";
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomName);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				roomType = rs.getString("rm_type");
			
			return roomType;
			
		} catch(Exception e) {
			System.out.println("getRoomType() error : " + e);
			
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

	// 객실명으로 객실코드 반환
	public String getRoomCode(String roomName) {
		
		String roomCode = null;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT rm_code FROM room WHERE rm_name=?";
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomName);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				roomCode = rs.getString("rm_code");
			
			return roomCode;
			
		} catch(Exception e) {
			System.out.println("getRoomCode() error : " + e);
			
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