package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConn;

public class NoticeDAO {
	
	// singleton 적용
	private static NoticeDAO instance;
	
	private NoticeDAO() {}
	
	public static NoticeDAO getInstance() {
		if(instance == null)
			instance = new NoticeDAO();
		return instance;
	}
	
	// notice 테이블의 레코드 개수를 구하는 메소드
	public int getListCount(String items, String text) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int result = 0;
		
		String sql;
		
		if(items == null && text == null) // 검색X (전체 게시물)
			sql = "SELECT count(*) FROM notice";
		else // 검색했을 때의 게시물
			sql = "SELECT count(*) FROM notice WHERE " + items + " LIKE '%" + text + "%'"; // text를 포함하는 모든 데이터의 수
		
		try {
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				result = rs.getInt(1);
			
		} catch(Exception e) {
			
			System.out.println("getListCount() error : " + e);
			
		} finally {
			
			try {
				
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				
				throw new RuntimeException(e.getMessage());
			}
		}
		
		return result;
	}
	
	// notice 테이블의 레코드를 가져오는 메소드
	public ArrayList<NoticeDTO> getNoticeList(int pageNum, int limit, String items, String text) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int total_record = getListCount(items, text);
		int start = (pageNum - 1) * limit;
		int index = start + 1;
		
		String sql;
		
		if(items == null && text == null) // 검색X (전체 게시물)
			sql = "SELECT * FROM notice ORDER BY not_num DESC";
		else // 검색했을 때의 게시물
			sql = "SELECT * FROM notice WHERE " + items + " LIKE '%" + text + "%' ORDER BY not_num DESC"; // text를 포함하는 모든 데이터의 수
		
		ArrayList<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		try {
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.absolute(index)) { // index 행으로 커서 이동
				
				NoticeDTO notice = new NoticeDTO();
				notice.setNum(rs.getInt("not_num"));
				notice.setId(rs.getString("writer_id"));
				notice.setName(rs.getString("writer_name"));
				notice.setTitle(rs.getString("not_title"));
				notice.setContent(rs.getString("not_content"));
				String date = rs.getString("not_date").substring(0, 10); // 시간 제외, 날짜만 출력
				notice.setDate(date);
				notice.setHit(rs.getInt("not_hit"));
				list.add(notice);
				
				if(index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}
			
			return list;
			
		} catch(Exception e) {
			
			System.out.println("getNoticeList() error : " + e);
			
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

	// 인증된 id의 사용자 이름을 가져오는 메소드
	public String getLoginNameById(String id) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String name = null;
		String sql = "SELECT * FROM member WHERE user_id = ?";
		
		try {
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				name = rs.getString("user_name");
			
			return name;
			
		} catch(Exception e) {
			
			System.out.println("getLoginNameById() error : " + e);
			
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

	// notice 테이블에 새 게시물 삽입
	public void insertNotice(NoticeDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			conn = DBConn.getConnection();
			
			String sql = "INSERT INTO notice(writer_id, writer_name, not_title, not_content, not_date, not_hit) VALUES(?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getDate());
			pstmt.setInt(6, dto.getHit());
			pstmt.executeUpdate();			
			
		} catch(Exception e) {
			
			System.out.println("insertNotice() error : " + e);
			
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