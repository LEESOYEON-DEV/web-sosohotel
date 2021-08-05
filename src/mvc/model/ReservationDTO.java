package mvc.model;

public class ReservationDTO {
	
	private String num;			// 예약번호
	private String roomType;	// 객실타입
	private String userId;		// 회원아이디
	private String guestId;		// 비회원번호
	private String user_name;	// 예약자명
	private String user_tel;	// 연락처
	private String user_email;	// 이메일
	private String checkIn;		// 체크인
	private String checkOut;	// 체크아웃
	private int nights;			// 숙박일수
	private int roomCount;		// 예약객실수
	private int adult;			// 성인
	private int child;			// 어린이
	private String resDate;		// 예약일시
	private String condition;	// 예약상태
	private String canDate;		// 취소일시
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getGuestId() {
		return guestId;
	}
	public void setGuestId(String guestId) {
		this.guestId = guestId;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}
	public String getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}
	public int getNights() {
		return nights;
	}
	public void setNights(int nights) {
		this.nights = nights;
	}
	public int getRoomCount() {
		return roomCount;
	}
	public void setRoomCount(int roomCount) {
		this.roomCount = roomCount;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getChild() {
		return child;
	}
	public void setChild(int child) {
		this.child = child;
	}
	public String getResDate() {
		return resDate;
	}
	public void setResDate(String resDate) {
		this.resDate = resDate;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getCanDate() {
		return canDate;
	}
	public void setCanDate(String canDate) {
		this.canDate = canDate;
	}
}