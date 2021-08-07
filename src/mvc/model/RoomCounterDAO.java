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
		ResultSet rs = null;
		
		String sql = "SELECT rm_count FROM room_counter WHERE rm_code=?";
		
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCode());
			rs = pstmt.executeQuery();
			
			int count = 0;
			if(rs.next()) { // 날짜, 객실이 일치하는 데이터가 있을 경우 기존 데이터의 예약객실수 증가
				count = rs.getInt("rm_count") + dto.getCount();
				sql = "UPDATE room_counter SET rm_count=? WHERE rm_code=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, count);
				pstmt.setString(2, dto.getCode());
				pstmt.executeUpdate();
			} else { // 날짜, 객실이 일치하는 데이터가 없을 경우 새 데이터 입력
				sql = "INSERT INTO room_counter(rm_code, check_in, rm_type, rm_count) VALUES(?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getCode());
				pstmt.setString(2, dto.getCheckIn());
				pstmt.setString(3, dto.getType());
				pstmt.setInt(4, dto.getCount());
				pstmt.executeUpdate();
			}
			
		} catch(Exception e) {
			System.out.println("insertRoomCounter() error : " + e);
			
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
	}
}