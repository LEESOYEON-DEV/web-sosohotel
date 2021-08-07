package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConn;

public class PaymentDAO {
	
	private static PaymentDAO instance;
	
	private PaymentDAO() {}
	
	public static PaymentDAO getInstance() {
		if(instance == null)
			instance = new PaymentDAO();
		return instance;
	}
	
	// 결제상태 반환 (예약 진행 시)
	public String getPayCondition(String method) {
		
		String resCon = null;
		
		switch(method) {
		case "신용카드":
			resCon = "결제완료";
			break;
		case "무통장입금":
			resCon = "결제대기";
			break;
		case "현장결제":
			resCon = "결제예정";
			break;
		}
		return resCon;
	}
	
	// 결제상태 반환 (예약 취소 시)
	public String getPayConDelete(String resNum) {
		
		String resCon = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT pay_con FROM payment WHERE res_num=?";
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resNum);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				resCon = rs.getString("pay_con");
			
			return resCon;
			
		} catch(Exception e) {
			System.out.println("getPayConDelete() error : " + e);
			
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
	
	// 결제금액 반환 (예약 취소 시)
	public int getPayAmount(String resNum) {
		
		int resCon = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT pay_amount FROM payment WHERE res_num=?";
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resNum);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				resCon = rs.getInt("pay_amount");
			
			return resCon;
			
		} catch(Exception e) {
			System.out.println("getPayAmount() error : " + e);
			
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return 0;
	}
	
	// 결제내역 저장 (payment 테이블에 추가)
	public void insertPayment(PaymentDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO payment(pay_num, res_num, pay_date, pay_con, pay_method, pay_amount) " + 
					 "VALUES(?, ?, ?, ?, ?, ?);";
		
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPayNum());
			pstmt.setString(2, dto.getResNum());
			pstmt.setString(3, dto.getDate());
			pstmt.setString(4, dto.getCondition());
			pstmt.setString(5, dto.getMethod());
			pstmt.setInt(6, dto.getAmount());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertPayment() error : " + e);
			
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
	}
	
	// 결제내역 반환
	public ArrayList<PaymentDTO> getPayInfo(String resNum) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM payment WHERE res_num=?";
		ArrayList<PaymentDTO> payInfo = new ArrayList<PaymentDTO>();
		
		try {	
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PaymentDTO payDto = new PaymentDTO();
				payDto.setMethod(rs.getString("pay_method"));
				payDto.setAmount(rs.getInt("pay_amount"));
				payInfo.add(payDto);
			}
			return payInfo;
			
		} catch(Exception e) {
			System.out.println("getPayInfo() error : " + e);
			
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