package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
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
		if(command.equals("/NoticeListAction.do") ) {
			reqNoticeList(req); // 등록된 글 목록 가져오기
			RequestDispatcher rd = req.getRequestDispatcher("./page/notice/noticeList.jsp");
			rd.forward(req, resp);
		}
		
	}
	
	// 등록된 글 목록 가져오기
	public void reqNoticeList(HttpServletRequest req) {
		
		NoticeDAO dao = NoticeDAO.getInstance();
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		
		int pageNum = 1;
		int limit = LISTCOUNT;
		
		if(req.getParameter("pageNum") != null)
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
}
