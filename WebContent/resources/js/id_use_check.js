/**
 * 아이디 중복 확인
 */

// 유효성 검사
function useChk() {
	
	if(fm.id.value == "guest") {
		alert("사용할 수 없는 아이디입니다.");
		fm.id.value = "";
		fm.id.focus();
		return false;
	}
	
	if(!fm.id.value) {
		alert("아이디를 입력해주세요.");
		fm.id.focus();
		return false;
	}
	
	// 정규표현식 : 영소문자, 숫자만 입력 가능 (4~12자)
	var regId = /^[a-z0-9]{4,12}$/;
	
	if(!regId.test(fm.id.value)) {
		alert("아이디는 4~12자의 영소문자, 숫자로 입력해주세요.");
		fm.id.value = "";
		fm.id.focus();
		return false;
	}
}

function useId() {
	
	if(fm.id.value == "guest") {
		alert("사용할 수 없는 아이디입니다.");
		fm.id.value = "";
		fm.id.focus();
		return;
	}
	
	if(!fm.id.value) {
		alert("아이디 중복확인을 해주세요.");
		fm.id.focus();
		return;
	}
	
	var regId = /^[a-z0-9]{4,12}$/;
	
	if(!regId.test(fm.id.value)) {
		alert("아이디는 4~12자의 영소문자, 숫자로 입력해주세요.");
		fm.id.value = "";
		fm.id.focus();
		return;
	}
	
	// 사용할 아이디를 부모창에 전달
	opener.document.getElementById("id").value = fm.id.value;
	opener.document.getElementById("idInfoText").innerHTML = "사용 가능한 아이디입니다.";
	self.close();
}

// 창 닫기
function winClose() {
	
	opener.document.getElementById("id").value = "";
	self.close();
}