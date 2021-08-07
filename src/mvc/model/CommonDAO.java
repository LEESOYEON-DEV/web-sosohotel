package mvc.model;

import java.util.Calendar;

public class CommonDAO {

	private static CommonDAO instance;
	
	private CommonDAO() {}
	
	public static CommonDAO getInstance() {
		if(instance == null)
			instance = new CommonDAO();
		return instance;
	}

	// 현재일시 반환
	public String getStringNow() {
		
		String date = null;
		
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH)+1;
		int day = now.get(Calendar.DAY_OF_MONTH);
		int hour = now.get(Calendar.HOUR_OF_DAY);
		int minute = now.get(Calendar.MINUTE);
		int second = now.get(Calendar.SECOND);
		
		date = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
		return date;
	}
	
	// 날짜 및 랜덤숫자 반환 (YYMMDD + 00 + 0000)
	public String getRandomCode() {
		
		String ranCode = null;
		
		Calendar now = Calendar.getInstance();
		String year = (Integer.toString(now.get(Calendar.YEAR))).substring(2);
		if(year.length() == 1) year = "0"+year;
		String month = Integer.toString(now.get(Calendar.MONTH)+1);
		if(month.length() == 1) month = "0"+month;
		String day = Integer.toString(now.get(Calendar.DAY_OF_MONTH));
		if(day.length() == 1) day = "0"+day;
		
		int num1 = (int)((Math.random()*90)+10);
		int num2 = (int)((Math.random()*9000)+1000);
		
		ranCode = year+month+day+num1+num2;
		return ranCode;
	}

	// 날짜 반환 (YYMMDD)
	public String getDateCode() {
		
		String dateCode = null;
		
		Calendar now = Calendar.getInstance();
		String year = (Integer.toString(now.get(Calendar.YEAR))).substring(2);
		if(year.length() == 1) year = "0"+year;
		String month = Integer.toString(now.get(Calendar.MONTH)+1);
		if(month.length() == 1) month = "0"+month;
		String day = Integer.toString(now.get(Calendar.DAY_OF_MONTH));
		if(day.length() == 1) day = "0"+day;
		
		dateCode = year+month+day;
		return dateCode;
	}
	public String getDateCode(String date) { // "yyyy-mm-dd"
		
		String dateCode = null;
		
		String year = date.substring(2, 4);
		String month = date.substring(5, 7);
		String day = date.substring(8, 10);
		
		dateCode = year+month+day;
		return dateCode;
	}
}