package mvc.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.MemberDTO;
import mvc.model.ReservationDAO;
import mvc.model.RoomDTO;

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
		} else if(command.equals("/resController/resAmountForm.do")) {
			reqAmountForm(req); // 결제 금액 출력
			RequestDispatcher rd = req.getRequestDispatcher("../page/reservation/reservationSubmitForm.jsp");
			rd.forward(req, resp);
		}
	}
	
	// 객실 목록 가져오기
	public void reqRoomList(HttpServletRequest req) {
		
		List<RoomDTO> roomList = new ArrayList<RoomDTO>();
		ReservationDAO dao = ReservationDAO.getInstance();
		roomList = dao.getRoomList();
		req.setAttribute("roomList", roomList);
		
		// 회원인 경우 (예약자 정보 자동 입력)
		if(req.getParameter("id") != null) {
			String id = (String)req.getParameter("id");
			reqMemberInfo(req, id);
		}
	}
	
	// 예약 회원 정보 가져오기
	public void reqMemberInfo(HttpServletRequest req, String id) {
		
		List<MemberDTO> memberInfo = new ArrayList<MemberDTO>();
		ReservationDAO dao = ReservationDAO.getInstance();
		memberInfo = dao.getMemberInfo(id);
		req.setAttribute("memberInfo", memberInfo);
	}
	
	// 결제 금액 출력
	public void reqAmountForm(HttpServletRequest req) {
		
		int weekday=0, weekday_nights=0, weekend=0, weekend_nights=0, amount=0;
		String weekday_s=null, weekend_s=null, amount_s=null;
		
		ReservationDAO dao = ReservationDAO.getInstance();
		ArrayList<RoomDTO> dto = new ArrayList<RoomDTO>();
	
		if(req.getParameter("roomName") != null) {
			
			String name = (String)req.getParameter("name");
			String tel = (String)req.getParameter("tel");
			String email = (String)req.getParameter("email");
			
			String roomName = (String)req.getParameter("roomName");
			String checkIn = (String)req.getParameter("checkIn");
			String checkOut = (String)req.getParameter("checkOut");
			String nights = (String)req.getParameter("nights");
			StringBuffer sb = new StringBuffer(nights);
			sb.delete(sb.length()-1, sb.length());
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
			req.setAttribute("nights", sb);
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
			
			weekday_nights = 1;
			weekend_nights = 3;
			
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
}