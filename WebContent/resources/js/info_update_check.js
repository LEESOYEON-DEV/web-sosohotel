/**
 * 정보수정 입력 항목 유효성 검사
 */

// 정규표현식으로 형식 지정 (password, name, email)
var regPw = /^[a-z0-9]{4,12}$/;
var regName = /^[가-힣]{2,5}$/;
var regEmail = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;

// 유효성 검사
function joinChk() {
	
	if(!fm.password.value) {
		alert("비밀번호를 입력해주세요.");
		fm.password.focus();
		return false;
	}
	
	if(!regPw.test(fm.password.value)) {
		alert("비밀번호는 4~12자의 영소문자, 숫자로 입력해주세요.");
		fm.password.value = "";
		fm.passwordCheck.value = "";
		fm.password.focus();
		return false;
	}
	
	if(!fm.passwordCheck.value) {
		alert("비밀번호를 확인해주세요.");
		fm.password.value = "";
		fm.passwordCheck.value = "";
		fm.password.focus();
		return false;
	}
	
	if(!regPw.test(fm.passwordCheck.value)) {
		alert("비밀번호는 4~12자의 영소문자, 숫자로 입력해주세요.");
		fm.password.value = "";
		fm.passwordCheck.value = "";
		fm.password.focus();
		return false;
	}
	
	if(fm.password.value != fm.passwordCheck.value) {
		alert("비밀번호가 일치하지 않습니다.");
		fm.password.value = "";
		fm.passwordCheck.value = "";
		fm.password.focus();
		return false;
	}
	
	if(!fm.name.value) {
		alert("이름을 입력해주세요.");
		fm.name.focus();
		return false;
	}
	
	if(!regName.test(fm.name.value)) {
		alert("이름은 2~5자의 한글로 입력해주세요.");
		fm.name.value = "";
		fm.name.focus();
		return false;
	}
	
	if(!fm.tel.value) {
		alert("연락 가능한 전화번호를 입력해주세요.");
		fm.tel.focus();
		return false;
	}
	
	if(isNaN(fm.tel.value)) {
		alert("연락처는 숫자만 입력해주세요.");
		fm.tel.value = "";
		fm.tel.focus();
		return false;
	}
	
	if(!fm.email.value) {
		alert("이메일 주소를 입력해주세요.");
		fm.email.focus();
		return false;
	}
	
	if(!regEmail.test(fm.email.value)) {
		alert("이메일 형식이 올바르지 않습니다.");
		fm.email.value = "<%=email %>";
		fm.email.focus();
		return false;
	}
	
	// 확인 버튼을 누를 경우에만 전송
	var check = false;
	check = confirm("정말 수정하시겠습니까?");
	if(check) { return true; }
	else { return false; }
}