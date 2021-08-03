package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;

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

	// 회원 정보 가져오기 (member 테이블의 레코드 가져오기)
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

	// 객실가 가져오기
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
}