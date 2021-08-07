package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;

import mvc.database.DBConn;

public class RefundDAO {

	private static RefundDAO instance;
	
	private RefundDAO() {}
	
	public static RefundDAO getInstance() {
		if(instance == null)
			instance = new RefundDAO();
		return instance;
	}

	// 환불내역 입력
	public void insertRefund(String resNum) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO refund(ref_num, res_num, ref_date, ref_amount) VALUES(?, ?, ?, ?)";
		
		CommonDAO comDao = CommonDAO.getInstance();
		PaymentDAO payDao = PaymentDAO.getInstance();
		
		try {
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "RF"+comDao.getRandomCode());
			pstmt.setString(2, resNum);
			pstmt.setString(3, comDao.getStringNow());
			pstmt.setInt(4, payDao.getPayAmount(resNum));
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertRefund() error : " + e);
			
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