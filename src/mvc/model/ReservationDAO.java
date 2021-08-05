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

	// 예약상태 반환
	public String getResCondition(String payCondition) {
		
		String resCon = null;
		
		switch(payCondition) {
		case "결제완료": case "결제예정":
			resCon = "예약완료";
			break;
		case "결제대기":
			resCon = "예약대기";
			break;
		}
		return resCon;
	}
	
	// 예약내역 저장 (resevation 테이블에 추가)
	public void insertReservation(ReservationDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO reservation(res_num, rm_type, user_id, user_name, user_tel, user_email, check_in, check_out, nights, rm_count, res_adult, res_child, res_date, res_con) " + 
					 "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNum());
			pstmt.setString(2, dto.getRoomType());
			pstmt.setString(3, dto.getUserId());
			pstmt.setString(4, dto.getUserName());
			pstmt.setString(5, dto.getUserTel());
			pstmt.setString(6, dto.getUserEmail());
			pstmt.setString(7, dto.getCheckIn());
			pstmt.setString(8, dto.getCheckOut());
			pstmt.setInt(9, dto.getNights());
			pstmt.setInt(10, dto.getRoomCount());
			pstmt.setInt(11, dto.getAdult());
			pstmt.setInt(12, dto.getChild());
			pstmt.setString(13, dto.getResDate());
			pstmt.setString(14, dto.getCondition());
			pstmt.executeUpdate();			
			
		} catch(Exception e) {
			System.out.println("insertReservation() error : " + e);
			
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
	}
	
	// 예약내역 반환
	public ArrayList<ReservationDTO> getResInfo(String resNum) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM reservation WHERE res_num=?";
		ArrayList<ReservationDTO> resInfo = new ArrayList<ReservationDTO>();
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ReservationDTO resDto = new ReservationDTO();
				resDto.setNum(resNum);
				resDto.setRoomType(rs.getString("rm_type"));
				resDto.setUserId(rs.getString("user_id"));
				resDto.setUserName(rs.getString("user_name"));
				resDto.setUserTel(rs.getString("user_tel"));
				resDto.setUserEmail(rs.getString("user_email"));
				resDto.setCheckIn(rs.getString("chech_in"));
				resDto.setCheckOut(rs.getString("check_out"));
				resDto.setNights(rs.getInt("nights"));
				resDto.setRoomCount(rs.getInt("rm_count"));
				resDto.setAdult(rs.getInt("res_adult"));
				resDto.setChild(rs.getInt("res_child"));
				resDto.setResDate(rs.getString("res_date"));
				resDto.setCondition(rs.getString("res_con"));
				resInfo.add(resDto);
			}
			return resInfo;
			
		} catch(Exception e) {
			System.out.println("getResInfo() error : " + e);
			
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