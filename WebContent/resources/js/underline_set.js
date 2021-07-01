/**
 * 텍스트에 밑줄 생성 및 제거
 */

// 텍스트에 밑줄 생성
function underline(e) {
	
    e.style.textDecoration = "underline";
    e.style.cursor = "pointer";
}

// 텍스트에 밑줄 제거
function underlineDelete(e) {
	
    e.style.textDecoration = "none";
}