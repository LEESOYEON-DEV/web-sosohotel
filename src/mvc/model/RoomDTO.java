package mvc.model;

public class RoomDTO {
	
	private String type;		// 객실타입
	private String name;		// 객실명
	private int basicPeople;	// 기준인원
	private int addPeople;		// 추가인원
	private int weekdayPrice;	// 평일가격
	private int weekendPrice;	// 주말가격
	private int extraCharge;	// 추가요금
	private int num;			// 보유객실수
	private String weekdayPrice_s;	// 평일가격
	private String weekendPrice_s;	// 주말가격
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBasicPeople() {
		return basicPeople;
	}
	public void setBasicPeople(int basicPeople) {
		this.basicPeople = basicPeople;
	}
	public int getAddPeople() {
		return addPeople;
	}
	public void setAddPeople(int addPeople) {
		this.addPeople = addPeople;
	}
	public int getWeekdayPrice() {
		return weekdayPrice;
	}
	public void setWeekdayPrice(int weekdayPrice) {
		this.weekdayPrice = weekdayPrice;
	}
	public int getWeekendPrice() {
		return weekendPrice;
	}
	public void setWeekendPrice(int weekendPrice) {
		this.weekendPrice = weekendPrice;
	}
	public int getExtraCharge() {
		return extraCharge;
	}
	public void setExtraCharge(int extraCharge) {
		this.extraCharge = extraCharge;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWeekdayPrice_s() {
		return weekdayPrice_s;
	}
	public void setWeekdayPrice_s(String weekdayPrice_s) {
		this.weekdayPrice_s = weekdayPrice_s;
	}
	public String getWeekendPrice_s() {
		return weekendPrice_s;
	}
	public void setWeekendPrice_s(String weekendPrice_s) {
		this.weekendPrice_s = weekendPrice_s;
	}
}