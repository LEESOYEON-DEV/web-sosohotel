package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;

import mvc.database.DBConn;

public class PaymentDAO {
	
	private static PaymentDAO instance;
	
	private PaymentDAO() {}
	
	public static PaymentDAO getInstance() {
		if(instance == null)
			instance = new PaymentDAO();
		return instance;
	}
	
	// 결제상태 반환
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
}