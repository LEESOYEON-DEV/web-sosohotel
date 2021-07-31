package mvc.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.NoticeDAO;
import mvc.model.NoticeDTO;

public class NoticeController extends HttpServlet {
	
	private static final long serialVersionUID = 1L; // 직렬화에 사용되는 식별자*
	static final int LISTCOUNT = 10; // 한 목록에 게시물 10개

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
		
		// 공지사항 목록 출력
		if(command.equals("/notice/NoticeListAction.do")) {
			reqNoticeList(req); // 등록된 글 목록 가져오기
			RequestDispatcher rd = req.getRequestDispatcher("../page/notice/noticeList.jsp");
			rd.forward(req, resp);
		// 게시물 작성 페이지 출력
		} else if(command.equals("/notice/NoticeWriteForm.do")) {
			reqLoginName(req); // 인증된 사용자 이름 가져오기 (작성자)
			RequestDispatcher rd = req.getRequestDispatcher("../page/notice/noticeWriteForm.jsp");
			rd.forward(req, resp);
		// 새 게시물 등록
		} else if(command.equals("/notice/NoticeWriteAction.do")) {
			reqNoticeWrite(req);
			RequestDispatcher rd = req.getRequestDispatcher("/notice/NoticeListAction.do");
			rd.forward(req, resp);
		// 선택한 게시물 가져오기
		} else if(command.equals("/notice/NoticeViewAction.do")) {
			reqNoticeView(req);
			RequestDispatcher rd = req.getRequestDispatcher("/notice/NoticeView.do");
			rd.forward(req, resp);
		// 선택한 게시물 페이지 출력
		} else if(command.equals("/notice/NoticeView.do")) {
			RequestDispatcher rd = req.getRequestDispatcher("../page/notice/noticeView.jsp");
			rd.forward(req, resp);
		// 게시물 삭제
		} else if(command.equals("/notice/NoticeDeleteAction.do")) {
			reqNoticeDelete(req);
			RequestDispatcher rd = req.getRequestDispatcher("/notice/NoticeListAction.do?pageNum=1");
			rd.forward(req, resp);
		// 수정할 게시물 정보 가져오기
		} else if(command.equals("/notice/NoticeUpdateForm.do")) {
			reqNoticeUpdateForm(req);
			RequestDispatcher rd = req.getRequestDispatcher("/notice/NoticeUpdate.do");
			rd.forward(req, resp);
		// 게시물 수정 페이지 출력
		} else if(command.equals("/notice/NoticeUpdate.do")) {
			RequestDispatcher rd = req.getRequestDispatcher("../page/notice/noticeUpdateForm.jsp");
			rd.forward(req, resp);
		// 게시물 수정
		} else if(command.equals("/notice/NoticeUpdateAction.do")) {
			reqNoticeUpdate(req);
			RequestDispatcher rd = req.getRequestDispatcher("/notice/NoticeListAction.do");
			rd.forward(req, resp);
		}
	}
	
	// 등록된 글 목록 가져오기
	public void reqNoticeList(HttpServletRequest req) {
		
		NoticeDAO dao = NoticeDAO.getInstance();
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		int pageNum = 1;
		int limit = LISTCOUNT;
		
		if(req.getParameter("pageNum") != null) // pageNum 파라미터 값이 들어있다면 해당 값을 대입
			pageNum = Integer.parseInt(req.getParameter("pageNum"));
		
		String items = req.getParameter("items");
		String text = req.getParameter("text");
		
		int total_record = dao.getListCount(items, text); // 테이블의 레코드 개수
		list = dao.getNoticeList(pageNum, limit, items, text); // 레코드 가져오기
		
		int total_page;
		
		if(total_record % limit == 0) {
			total_page = total_record / limit;
			Math.floor(total_page); // 이게 왜 필요하지?
		} else {
			total_page = total_record / limit;
			total_page = total_page + 1; // 마지막 페이지는 한 페이지에 출력되는 게시물 수가 미달
		}
		
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("total_page", total_page);
		req.setAttribute("total_record", total_record);
		req.setAttribute("list", list);
	}

	// 인증된 사용자 이름 가져오기 (작성자)
	public void reqLoginName(HttpServletRequest req) {
		
		String id = req.getParameter("id");
		
		NoticeDAO dao = NoticeDAO.getInstance();
		String name = dao.getLoginNameById(id);
		
		req.setAttribute("name", name);
	}
	
	// 새 게시물 등록
	public void reqNoticeWrite(HttpServletRequest req) {
		
		NoticeDTO dto = new NoticeDTO();
		dto.setId(req.getParameter("id"));
		dto.setName(req.getParameter("name"));
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		dto.setHit(0);
		
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH)+1;
		int day = now.get(Calendar.DAY_OF_MONTH);
		int hour = now.get(Calendar.HOUR_OF_DAY);
		int minute = now.get(Calendar.MINUTE);
		int second = now.get(Calendar.SECOND);
		String date = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
		dto.setDate(date);
		
		NoticeDAO dao = NoticeDAO.getInstance();
		dao.insertNotice(dto);
	}
	
	// 선택한 게시물 상세 페이지 가져오기
	public void reqNoticeView(HttpServletRequest req) {
		
		int num = Integer.parseInt(req.getParameter("num"));
		int page = Integer.parseInt(req.getParameter("pageNum"));
		
		NoticeDAO dao = NoticeDAO.getInstance();
		NoticeDTO dto = new NoticeDTO();
		dto = dao.getNoticeByNum(num, page);
		
		req.setAttribute("num", num);
		req.setAttribute("page", page);
		req.setAttribute("notice", dto);
	}
	
	// 게시물 삭제
	public void reqNoticeDelete(HttpServletRequest req) {
		
		int num = Integer.parseInt(req.getParameter("num"));
		
		NoticeDAO dao = NoticeDAO.getInstance();
		dao.deleteNotice(num);
	}

	// 게시물 수정 페이지 설정
	public void reqNoticeUpdateForm(HttpServletRequest req) {
		
		int num = Integer.parseInt(req.getParameter("num"));
		
		NoticeDAO dao = NoticeDAO.getInstance();
		NoticeDTO dto = new NoticeDTO();
		dto = dao.updateForm(num);
		
		req.setAttribute("num", num);
		req.setAttribute("notice", dto);
	}
	
	// 게시물 수정
	public void reqNoticeUpdate(HttpServletRequest req) {
		
		NoticeDTO dto = new NoticeDTO();
		dto.setNum(Integer.parseInt(req.getParameter("num")));
		dto.setName(req.getParameter("name"));
		dto.setTitle(req.getParameter("title"));
		dto.setContent(req.getParameter("content"));
		
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH)+1;
		int day = now.get(Calendar.DAY_OF_MONTH);
		int hour = now.get(Calendar.HOUR_OF_DAY);
		int minute = now.get(Calendar.MINUTE);
		int second = now.get(Calendar.SECOND);
		String date = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
		dto.setDate(date);
		
		NoticeDAO dao = NoticeDAO.getInstance();
		dao.updateNotice(dto);
	}
}