/**
 * 아이디, 비밀번호 입력 확인
 */

// 로그인 유효성 검사
function loginChk() {
	
	if(!fm.id.value) {
		alert("아이디를 입력해주세요.");
		fm.id.focus();
		return;
	}
	
	if(!fm.password.value) {
		alert("비밀번호를 입력해주세요.");
		fm.password.focus();
		return;
	}
	
	fm.action = "loginPro.jsp";
	fm.submit();
}