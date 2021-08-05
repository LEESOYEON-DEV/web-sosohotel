package mvc.model;

public class PaymantDTO {
	
	private String payNum;		// 거래번호
	private String resNum;		// 예약번호
	private String appNum;		// 승인번호
	private String date;		// 결제일시
	private String condition;	// 결제상태
	private String method;		// 결제수단
	private int amount;			// 결제금액
	
	public String getPayNum() {
		return payNum;
	}
	public void setPayNum(String payNum) {
		this.payNum = payNum;
	}
	public String getResNum() {
		return resNum;
	}
	public void setResNum(String resNum) {
		this.resNum = resNum;
	}
	public String getAppNum() {
		return appNum;
	}
	public void setAppNum(String appNum) {
		this.appNum = appNum;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
}