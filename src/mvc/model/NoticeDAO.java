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

	// 선택된 게시물 상세 내용 가져오기
	public NoticeDTO getNoticeByNum(int num, int page) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO dto = null;
		
		updateHit(num);
		String sql = "SELECT * FROM notice WHERE not_num = ?";
		
		try {
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new NoticeDTO();
				dto.setNum(rs.getInt("not_num"));
				dto.setId(rs.getString("writer_id"));
				dto.setName(rs.getString("writer_name"));
				dto.setTitle(rs.getString("not_title"));
				dto.setContent(rs.getString("not_content"));
				String date = rs.getString("not_date").substring(0, 10); // 시간 제외, 날짜만 출력
				dto.setDate(date);
				dto.setHit(rs.getInt("not_hit"));
			}
			
			return dto;
			
		} catch(Exception e) {
			
			System.out.println("getNoticeByNum() error : " + e);
			
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
	
	// 선택한 게시물의 조회수 증가
	public void updateHit(int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = DBConn.getConnection();
			
			String sql = "SELECT not_hit FROM notice WHERE not_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			int hit = 0;
			if(rs.next())
				hit = rs.getInt("not_hit") + 1;
			
			sql = "UPDATE notice SET not_hit = ? WHERE not_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			
			System.out.println("updateHit() error : " + e);
			
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

	// 게시물 삭제
	public void deleteNotice(int num ) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "DELETE FROM notice WHERE not_num = ?";
		
		try {
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			
			System.out.println("deleteNotice() error : " + e);
			
		} finally {
			
			try {
				
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch(Exception e) {
				
				throw new RuntimeException(e.getMessage());
			}
		}
	}
	
	// 수정할 게시물 내용 가져오기
	public NoticeDTO updateForm(int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO dto = null;
		
		updateHit(num);
		
		try {
			
			conn = DBConn.getConnection();
			
			String sql = "SELECT * FROM notice WHERE not_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			String userId = null;
			if(rs.next()) {
				dto = new NoticeDTO();
				dto.setNum(rs.getInt("not_num"));
				userId = rs.getString("writer_id");
				dto.setTitle(rs.getString("not_title"));
				dto.setContent(rs.getString("not_content"));
			}
			
			// 사용자 이름은 member 테이블에서 가져옴
			sql = "SELECT user_name FROM member WHERE user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				dto.setName(rs.getString("user_name"));
			
			return dto;
			
		} catch(Exception e) {
			
			System.out.println("updateForm() error : " + e);
			
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
	
	// 기존 데이터 수정 (게시물 수정)
	public void updateNotice(NoticeDTO dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			
			String sql = "UPDATE notice SET writer_name=?, not_title=?, not_content=?, not_date=? WHERE not_num=?";
			
			conn = DBConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			conn.setAutoCommit(false);
			
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getDate());
			pstmt.setInt(5, dto.getNum());
			
			pstmt.executeUpdate();
			conn.commit();
			
		} catch(Exception e) {
			
			System.out.println("updateNotice() error : " + e);
			
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