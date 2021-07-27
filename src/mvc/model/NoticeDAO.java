package mvc.model;

public class NoticeDAO {
	
	// singleton 적용
	private static NoticeDAO instance;
	
	private NoticeDAO() {}
	
	private static NoticeDAO getInstance() {
		if(instance == null)
			instance = new NoticeDAO();
		return instance;
	}
}
