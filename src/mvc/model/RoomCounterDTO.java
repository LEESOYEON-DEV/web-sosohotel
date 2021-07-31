package mvc.model;

public class RoomCounterDTO {
	
	private String code;	// 구분
	private String checkIn;	// 체크인
	private String type;	// 객실타입
	private int num;		// 보유객실수
	private int count;		// 예약객실수
	private int remained;	// 잔여객실수
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getRemained() {
		return remained;
	}
	public void setRemained(int remained) {
		this.remained = remained;
	}
}