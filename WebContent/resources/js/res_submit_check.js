/**
 * 예약 정보 확인 및 진행 페이지 유효성 검사
 */

// 정규표현식으로 형식 지정 (name, email)
var regName = /^[가-힣]{2,5}$/;
var regEmail = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;

function resInfoChk() {
	
	if(!fm.roomName.value) {
		alert("객실명이 입력되지 않았습니다.");
		return false;
	}
	
	if(!fm.checkIn.value) {
		alert("체크인 날짜가 입력되지 않았습니다.");
		return false;
	}
	
	if(!fm.checkOut.value) {
		alert("체크아웃 날짜가 입력되지 않았습니다.");
		return false;
	}
	
	if(!fm.nights.value) {
		alert("숙박일수가 입력되지 않았습니다.");
		return false;
	}
	
	if(!fm.roomCnt.value) {
		alert("객실수가 입력되지 않았습니다.");
		return false;
	}
	
	if(!fm.adultCnt.value) {
		alert("숙박인원(성인)이 입력되지 않았습니다.");
		return false;
	}
	
	if(!fm.childCnt.value) {
		alert("숙박인원(어린이)이 입력되지 않았습니다.");
		return false;
	}
	
	if(!fm.name.value) {
		alert("예약자명이 입력되지 않았습니다.");
		return false;
	}
	
	if(!regName.test(fm.name.value)) {
		alert("예약자명은 2~5자의 한글로 입력해주세요.");
		return false;
	}
	
	if(!fm.tel.value) {
		alert("연락처가 입력되지 않았습니다.");
		return false;
	}
	
	if(isNaN(fm.tel.value)) {
		alert("연락처는 숫자만 입력해주세요.");
		return false;
	}
	
	if(!fm.email.value) {
		alert("이메일이 입력되지 않았습니다.");
		return false;
	}
	
	if(!regEmail.test(fm.email.value)) {
		alert("이메일 형식이 올바르지 않습니다.");
		return false;
	}
	
	if(!fm.method.value) {
		alert("결제수단이 선택되지 않았습니다.");
		return false;
	}
	
	if(!fm.amount.value) {
		alert("결제금액이 입력되지 않았습니다.");
		return false;
	}
	
	var check = false;
	check = confirm("정말 예약하시겠습니까?");
	if(check) { return true; }
	else { return false; }
}