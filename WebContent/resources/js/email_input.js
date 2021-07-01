/**
 * 이메일 입력 양식 설정
 */

// 이메일 입력 설정
function emailChange() {
	
	if(fm.emailSelect.value == "none") {
		document.fm.emailSelected.disabled = true;
		document.fm.emailSelected.value = "";
		
	} else if(fm.emailSelect.value == "textBoxOpen") {
		document.fm.emailSelected.disabled = false;
		document.fm.emailSelected.value = "";
		document.fm.emailSelected.focus();
		
	} else {
		document.fm.emailSelected.disabled = false;
		document.fm.emailSelected.value = document.fm.emailSelect.value;
	}
}