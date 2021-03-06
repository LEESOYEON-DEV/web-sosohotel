package mvc.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import mvc.model.CommonDAO;
import mvc.model.MemberDAO;
import mvc.model.MemberDTO;
import mvc.model.PaymentDAO;
import mvc.model.PaymentDTO;
import mvc.model.RefundDAO;
import mvc.model.ReservationDAO;
import mvc.model.ReservationDTO;
import mvc.model.RoomCounterDAO;
import mvc.model.RoomCounterDTO;
import mvc.model.RoomDAO;
import mvc.model.RoomDTO;
import oracle.jrockit.jfr.tools.ConCatRepository;

public class ReservationController extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String requestURI = req.getRequestURI(); // 웹 브라우저가 요청한 URI 경로 (ex. /web_sosohotel/page/testPage.jsp)
		String contextPath = req.getContextPath(); // 웹 애플리케이션 콘텍스트 경로 (ex. /web_sosohotel)
		String command = requestURI.substring(contextPath.length()); // requestURI에서 contextPath 이후 글자부터 출력 (ex. /page/testPage.jsp)
		
		req.setCharacterEncoding("UTF-8"); // 웹 브라우저에 응답할 문자 인코딩 설정
		resp.setContentType("text/html; charset=UTF-8"); // 웹 브라우저에 응답할 MIME 유형 설정
		
		// 실시간 예약 페이지 출력
		if(command.equals("/resController/reservationForm.do")) {
			reqRoomList(req); // 객실 목록 및 사용자 정보 가져오기
			RequestDispatcher rd = req.getRequestDispatcher("../page/reservation/reservationForm.jsp");
			rd.forward(req, resp);
		// 예약 내용 확인 및 진행 페이지 출력
		} else if(command.equals("/resController/resAmountForm.do")) {
			reqAmountForm(req); // 결제 금액 출력
			RequestDispatcher rd = req.getRequestDispatcher("../page/reservation/reservationSubmitForm.jsp");
			rd.forward(req, resp);
		// 예약 내역 저장
		} else if(command.equals("/resController/resSave.do")) {
			reqReservation(req);
			RequestDispatcher rd = req.getRequestDispatcher("/resController/resResult.do");
			rd.forward(req, resp);
		// 예약 완료 페이지 출력
		} else if(command.equals("/resController/resResult.do")) {
			reqResResultPage(req);
			RequestDispatcher rd = req.getRequestDispatcher("../page/reservation/reservationCheckPage.jsp");
			rd.forward(req, resp);
		// 예약 내역 삭제 (예약 취소)
		} else if(command.equals("/resController/resDeleteAction.do")) {
			reqResDelete(req);
			RequestDispatcher rd = req.getRequestDispatcher("../page/main.jsp");
			rd.forward(req, resp);
		}
	}
	
	// 객실 목록 가져오기
	public void reqRoomList(HttpServletRequest req) {
		
		List<RoomDTO> roomList = new ArrayList<RoomDTO>();
		RoomDAO dao = RoomDAO.getInstance();
		roomList = dao.getRoomList();
		req.setAttribute("roomList", roomList);
		
		// 회원인 경우 (예약자 정보 자동 입력)
		if(req.getParameter("id") != null) {
			String id = (String)req.getParameter("id");
			reqMemberInfo(req, id);
		}
	}
	
	// 회원 정보 가져오기
	public void reqMemberInfo(HttpServletRequest req, String id) {
		
		List<MemberDTO> memberInfo = new ArrayList<MemberDTO>();
		MemberDAO dao = MemberDAO.getInstance();
		memberInfo = dao.getMemberInfo(id);
		req.setAttribute("memberInfo", memberInfo);
	}
	
	// 결제 금액 출력
	@SuppressWarnings("deprecation")
	public void reqAmountForm(HttpServletRequest req) {
		
		int weekday=0, weekday_nights=0, weekend=0, weekend_nights=0, amount=0;
		String weekday_s=null, weekend_s=null, amount_s=null;
		
		RoomDAO dao = RoomDAO.getInstance();
		ArrayList<RoomDTO> dto = new ArrayList<RoomDTO>();
	
		if(req.getParameter("roomName") != null) {
			
			String name = (String)req.getParameter("name");
			String tel = (String)req.getParameter("tel");
			String email = (String)req.getParameter("email");
			
			String roomName = (String)req.getParameter("roomName");
			String checkIn = (String)req.getParameter("checkIn");
			String checkOut = (String)req.getParameter("checkOut");
			
			String[] inArr = checkIn.split("-");
			String[] outArr = checkOut.split("-");
			int inYear = Integer.parseInt(inArr[0]);
			int inMonth = Integer.parseInt(inArr[1])-1;
			int inDay = Integer.parseInt(inArr[2]);
			int outYear = Integer.parseInt(outArr[0]);
			int outMonth = Integer.parseInt(outArr[1])-1;
			int outDay = Integer.parseInt(outArr[2]);
			Date inObj = new Date(inYear, inMonth, inDay);
		    Date outObj = new Date(outYear, outMonth, outDay);
		    long nights = (outObj.getTime() - inObj.getTime())/1000/60/60/24;
		    
			String roomCnt = (String)req.getParameter("roomCnt");
			String adultCnt = (String)req.getParameter("adultCnt");
			String childCnt = (String)req.getParameter("childCnt");
			
			String method = (String)req.getParameter("method");
			
			req.setAttribute("name", name);
			req.setAttribute("tel", tel);
			req.setAttribute("email", email);
			
			req.setAttribute("roomName", roomName);
			req.setAttribute("checkIn", checkIn);
			req.setAttribute("checkOut", checkOut);
			req.setAttribute("nights", nights);
			req.setAttribute("roomCnt", roomCnt);
			req.setAttribute("adultCnt", adultCnt);
			req.setAttribute("childCnt", childCnt);
			
			req.setAttribute("method", method);
			
			dto = dao.getRoomCharge(roomName);
			RoomDTO room = (RoomDTO)dto.get(0);
			weekday = room.getWeekdayPrice();
			weekend = room.getWeekendPrice();
			weekday_s = room.getWeekdayPrice_s();
			weekend_s = room.getWeekendPrice_s();
			
			weekday_nights = getWeekdays(checkIn, nights);
			weekend_nights = getWeekends(checkIn, nights);
			
			amount = (weekday*weekday_nights) + (weekend*weekend_nights);
			
			DecimalFormat format = new DecimalFormat("###,###");
			amount_s = format.format(amount);
			
			req.setAttribute("weekday", weekday_s);
			req.setAttribute("weekday_nights", weekday_nights);
			req.setAttribute("weekend", weekend_s);
			req.setAttribute("weekend_nights", weekend_nights);
			req.setAttribute("amount", amount);
			req.setAttribute("amount_s", amount_s);
		}
	}

	// 예약 내역 저장
	public void reqReservation(HttpServletRequest req) {
		
		ReservationDAO resDao = ReservationDAO.getInstance();
		RoomDAO roomDao = RoomDAO.getInstance();
		PaymentDAO payDao = PaymentDAO.getInstance();
		CommonDAO comDao = CommonDAO.getInstance();

		String id = (String)req.getParameter("id");
		if(id.equals("guest")) id = getGuestId(); // 비회원의 경우 비회원번호 생성
		String roomName = (String)req.getParameter("roomName");
		String roomType = roomDao.getRoomType(roomName);
		int roomCount = Integer.parseInt(req.getParameter("roomCnt"));
		String method = (String)req.getParameter("method");
		String payCondition = payDao.getPayCondition(method);
		String resCondition = resDao.getResCondition(payCondition);
		String checkIn = (String)req.getParameter("checkIn");
		
		String date = comDao.getStringNow();
		String resNum = "RS"+comDao.getRandomCode();
		String payNum = "PA"+comDao.getRandomCode();
		
		ReservationDTO resDto = new ReservationDTO();
		resDto.setNum(resNum);
		resDto.setRoomType(roomType);
		resDto.setUserId(id);
		resDto.setUserName(req.getParameter("name"));
		resDto.setUserTel(req.getParameter("tel"));
		resDto.setUserEmail(req.getParameter("email"));
		resDto.setCheckIn(checkIn);
		resDto.setCheckOut(req.getParameter("checkOut"));
		resDto.setNights(Integer.parseInt(req.getParameter("nights")));
		resDto.setRoomCount(roomCount);
		resDto.setAdult(Integer.parseInt(req.getParameter("adultCnt")));
		resDto.setChild(Integer.parseInt(req.getParameter("childCnt")));
		resDto.setResDate(date);
		resDto.setCondition(resCondition);
		resDao.insertReservation(resDto);
		
		PaymentDTO payDto = new PaymentDTO();
		payDto.setPayNum(payNum);
		payDto.setResNum(resNum);
		payDto.setDate(date);
		payDto.setCondition(payCondition);
		payDto.setMethod(method);
		payDto.setAmount(Integer.parseInt(req.getParameter("amount")));
		payDao.insertPayment(payDto);

		RoomCounterDTO roomCntDto = new RoomCounterDTO();
		roomCntDto.setCode(roomDao.getRoomCode(roomName)+comDao.getDateCode(checkIn));
		roomCntDto.setCheckIn(checkIn); // 체크인 날짜별로 다 필요
		roomCntDto.setType(roomType);
		roomCntDto.setCount(roomCount);
		RoomCounterDAO roomCntDao = RoomCounterDAO.getInstance();
		roomCntDao.insertRoomCounter(roomCntDto);
		
		req.setAttribute("resNum", resNum);
	}
	
	// 예약 확인 페이지 출력
	public void reqResResultPage(HttpServletRequest req) {
		
		String resNum = null;
		if(req.getAttribute("resNum") != null)
			resNum = (String)req.getAttribute("resNum");
		else if(req.getParameter("resNum") != null)
			resNum = (String)req.getParameter("resNum");
		req.setAttribute("resNum", resNum);
		// 예약 정보
		List<ReservationDTO> resInfo = new ArrayList<ReservationDTO>();
		ReservationDAO resDao = ReservationDAO.getInstance();
		resInfo = resDao.getResInfo(resNum);
		req.setAttribute("resInfo", resInfo);
		// 결제 정보
		List<PaymentDTO> payInfo = new ArrayList<PaymentDTO>();
		PaymentDAO payDao = PaymentDAO.getInstance();
		payInfo = payDao.getPayInfo(resNum);
		req.setAttribute("payInfo", payInfo);
		// 결제 내역 표시
		List<RoomDTO> roomInfo = new ArrayList<RoomDTO>();
		RoomDAO roomDao = RoomDAO.getInstance();
		
		int weekday_nights=0, weekend_nights=0, amount=0;
		String weekday_s=null, weekend_s=null, amount_s=null;
		
		String checkIn = resInfo.get(0).getCheckIn();
		int nights = resInfo.get(0).getNights();
		String roomType = resInfo.get(0).getRoomType();		// 객실타입
		String roomName = roomDao.getRoomName(roomType);	// 객실명
		
		// 객실가
		roomInfo = roomDao.getRoomCharge(roomName);
		RoomDTO room = (RoomDTO)roomInfo.get(0);
		
		weekday_s = room.getWeekdayPrice_s();
		weekend_s = room.getWeekendPrice_s();
		weekday_nights = getWeekdays(checkIn, nights);
		weekend_nights = getWeekends(checkIn, nights);
		
		DecimalFormat format = new DecimalFormat("###,###");
		amount = payInfo.get(0).getAmount();
		amount_s = format.format(amount);
		
		req.setAttribute("weekday", weekday_s);
		req.setAttribute("weekday_nights", weekday_nights);
		req.setAttribute("weekend", weekend_s);
		req.setAttribute("weekend_nights", weekend_nights);
		req.setAttribute("amount_s", amount_s);
	}
	
	// 예약 내역 삭제
	public void reqResDelete(HttpServletRequest req) {
		
		String resNum = (String)req.getParameter("resNum");
		
		// payment : 예약번호로 결제상태(결제완료, 결제대기, 결제예정), 결제금액 조회
		// 1. 결제상태 = 결제대기, 결제예정
		//    refund : 거래번호, 환불일시 생성하여 입력 (거래번호, 예약번호, 환불일시, 환불금액) ok
		//    reservation : 예약상태를 '취소완료'로 변경, 취소일시는 현재 시각으로 입력 ok
		//    room_counter : 예약된 객실 수만큼 감소 (예약객실수가 0이면 데이터 삭제) ok
		// 2. 결제상태 = 결제완료 : reservation의 예약상태를 '취소신청'으로 변경, 취소일시는 현재 시각으로 입력 (추후 관리자 페이지에서 승인, 진행될 때마다 취소일시 수정) ok
		
		PaymentDAO payDao = PaymentDAO.getInstance();
		String payCon = payDao.getPayConDelete(resNum);
		
		ReservationDAO resDao = ReservationDAO.getInstance();
		resDao.updateResCondition(payCon, resNum);
		
		if(payCon.equals("결제대기") || payCon.equals("결제예정")) {
			RefundDAO refDao = RefundDAO.getInstance();
			refDao.insertRefund(resNum);
			
			RoomDAO roomDao = RoomDAO.getInstance();
			CommonDAO comDao = CommonDAO.getInstance();
			String roomCode = roomDao.getRoomCodeInResNum(resNum)+comDao.getDateCode(resDao.getCheckIn(resNum));
			int resRoomCnt = resDao.getResRoomCnt(resNum);
			RoomCounterDAO roomCntDao = RoomCounterDAO.getInstance();
			roomCntDao.deleteRoomCounter(roomCode, resRoomCnt);
			
		} else if(payCon.equals("결제완료")) {
			
		}
	}
	
	// 평일(일~목) 숙박일수 반환
	public int getWeekdays(String checkIn, long nights) {
		
		int weekdays = 0;
		
		String[] inArr = new String[3];
		inArr = checkIn.split("-");
		int inYear = Integer.parseInt(inArr[0]);
		int inMonth = Integer.parseInt(inArr[1])-1;
		int inDay = Integer.parseInt(inArr[2]);
		
		Calendar date = Calendar.getInstance();
		date.set(inYear, inMonth, inDay);
		int start = date.get(Calendar.DAY_OF_WEEK);
		
		long nightsCnt = nights;
		
		for(int i=0; i<nightsCnt; i++) {
			if(start <= 5) weekdays++;
			if(start == 7) start = 1;
			else start++;
		}
		return weekdays;
	}

	// 주말(금~토) 숙박일수 반환
	public int getWeekends(String checkIn, long nights) {
		
		int weekends = 0;
		
		String[] inArr = new String[3];
		inArr = checkIn.split("-");
		int inYear = Integer.parseInt(inArr[0]);
		int inMonth = Integer.parseInt(inArr[1])-1;
		int inDay = Integer.parseInt(inArr[2]);
		
		Calendar date = Calendar.getInstance();
		date.set(inYear, inMonth, inDay);
		int start = date.get(Calendar.DAY_OF_WEEK);
		
		long nightsCnt = nights;
		
		for(int i=0; i<nightsCnt; i++) {
			if(start >= 6) weekends++;
			if(start == 7) start = 1;
			else start++;
		}
		return weekends;
	}
	
	// 비회원번호 반환 (guest_YYMMDD0000)
	public String getGuestId() {
		
		String guestId = null;
		
		CommonDAO comDao = CommonDAO.getInstance();
		String dateCode = comDao.getDateCode();
		int randomNumber = (int)((Math.random()*9999)+1000);
		
		guestId = "guest_"+dateCode+randomNumber;
		return guestId;
	}
}