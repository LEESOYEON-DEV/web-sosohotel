package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;

import mvc.database.DBConn;

public class RoomDAO {
	
	private static RoomDAO instance;
		
	private RoomDAO() {}
	
	public static RoomDAO getInstance() {
		if(instance == null)
			instance = new RoomDAO();
		return instance;
	}
	
	// 객실 정보 반환
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
			
			while(rs.next()) {
				
				RoomDTO room = new RoomDTO();
				room.setType(rs.getString("rm_type"));
				room.setName(rs.getString("rm_name"));
				room.setBasicPeople(rs.getInt("basic_people"));
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
	
	// 객실명으로 객실가 반환
	public ArrayList<RoomDTO> getRoomCharge(String roomName) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM room WHERE rm_name=?";
		ArrayList<RoomDTO> roomList = new ArrayList<RoomDTO>();
		DecimalFormat format = new DecimalFormat("###,###");
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				RoomDTO room = new RoomDTO();
				room.setWeekdayPrice(rs.getInt("price_weekday"));
				room.setWeekendPrice(rs.getInt("price_weekend"));
				room.setWeekdayPrice_s(format.format(rs.getInt("price_weekday")));
				room.setWeekendPrice_s(format.format(rs.getInt("price_weekend")));
				roomList.add(room);
			}
			return roomList;
			
		} catch(Exception e) {
			System.out.println("getRoomCharge() error : " + e);
			
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
	
	// 객실타입으로 객실명 반환
	public String getRoomName(String roomType) {
		
		String roomName = null;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT rm_name FROM room WHERE rm_type=?";
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, roomType);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				roomName = rs.getString("rm_name");
			
			return roomName;
			
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