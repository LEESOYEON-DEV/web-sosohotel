package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;

import mvc.database.DBConn;

public class RoomCounterDAO {

	private static RoomCounterDAO instance;
	
	private RoomCounterDAO() {}
	
	public static RoomCounterDAO getInstance() {
		if(instance == null)
			instance = new RoomCounterDAO();
		return instance;
	}

	// 예약내역 저장 (room_counter 테이블에 반영하여 일일 예약 객실 수 파악)
	public void insertRoomCounter(RoomCounterDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO room_counter(rm_code, check_in, rm_type, rm_count) VALUES(?, ?, ?, ?)";
		
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCode());
			pstmt.setString(2, dto.getCheckIn());
			pstmt.setString(3, dto.getType());
			pstmt.setInt(4, dto.getCount());
			pstmt.executeUpdate();			
			
		} catch(Exception e) {
			System.out.println("insertRoomCounter() error : " + e);
			
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
	}
}