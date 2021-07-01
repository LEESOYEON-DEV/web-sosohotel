/**
 * 아이디 중복확인 새 창에서 열기
 */

// 아이디 중복확인 새 창에서 열기
function openIdChk() {
	
	window.name = "Form";
	window.open("idCheckForm.jsp", "idCheckForm", "width=500, height=281, scrollbars=no");
}