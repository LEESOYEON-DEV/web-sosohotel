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
		
		if(dto.getUserId().substring(0, 6).equals("guest_")) {
			sql = "INSERT INTO reservation(res_num, rm_type, guest_id, user_name, user_tel, user_email, check_in, check_out, nights, rm_count, res_adult, res_child, res_date, res_con) " + 
					 "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
		}
		
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
				if(rs.getString("user_id") != null)
					resDto.setUserId(rs.getString("user_id"));
				else
					resDto.setUserId(rs.getString("guest_id"));
				resDto.setUserName(rs.getString("user_name"));
				resDto.setUserTel(rs.getString("user_tel"));
				resDto.setUserEmail(rs.getString("user_email"));
				resDto.setCheckIn((rs.getString("check_in")).substring(0, 10));
				resDto.setCheckOut((rs.getString("check_out")).substring(0, 10));
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