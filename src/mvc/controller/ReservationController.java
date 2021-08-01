package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			reqRoomList(req); // 객실 목록 가져오기
			RequestDispatcher rd = req.getRequestDispatcher("../page/reservation/reservationForm.jsp");
			rd.forward(req, resp);
		}
	}
	
	// 객실 목록 가져오기
	public void reqRoomList(HttpServletRequest req) {
		
		List<RoomDTO> roomList = new ArrayList<RoomDTO>();
		ReservationDAO dao = ReservationDAO.getInstance();
		roomList = dao.getRoomList();
		req.setAttribute("roomList", roomList);
	}
}