package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;

import mvc.database.DBConn;

public class ReservationDAO {

	private static ReservationDAO instance;
	
	private ReservationDAO() {}
	
	public static ReservationDAO getInstance() {
		if(instance == null)
			instance = new ReservationDAO();
		return instance;
	}
	
	// 객실 정보 가져오기 (room 테이블의 레코드 가져오기)
	public ArrayList<RoomDTO> getRoomList() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM room";
		ArrayList<RoomDTO> roomList = new ArrayList<RoomDTO>();
		DecimalFormat format = new DecimalFormat("###,###");
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { // index 행으로 커서 이동
				
				RoomDTO room = new RoomDTO();
				room.setType(rs.getString("rm_type"));
				room.setName(rs.getString("rm_name"));
				room.setBasicPeople(rs.getInt("basic_people"));
				room.setAddPeople(rs.getInt("add_person"));
				room.setWeekdayPrice(rs.getInt("price_weekday"));
				room.setWeekendPrice(rs.getInt("price_weekend"));
				room.setExtraCharge(rs.getInt("extra_charge"));
				room.setNum(rs.getInt("rm_num"));
				room.setWeekdayPrice_s(format.format(rs.getInt("price_weekday")));
				room.setWeekendPrice_s(format.format(rs.getInt("price_weekend")));
				roomList.add(room);
			}
			return roomList;
			
		} catch(Exception e) {
			System.out.println("getRoomList() error : " + e);
			
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