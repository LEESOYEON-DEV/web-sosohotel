/**
 * 체크인, 체크아웃 날짜 자동 입력 및 선택 유효성 검사
 */

// 체크인, 체크아웃 날짜 자동 입력
function checkInOut() {
	
	var checkIn = document.getElementById("checkIn");
	var checkOut = document.getElementById("checkOut");
	var today = new Date(); // 오늘
	var tomorrow = new Date(today.valueOf() + (24*60*60*1000)); // 내일
	// 체크인 : 오늘
	checkIn.value = today.toISOString().substring(0, 10);
	// 체크아웃 : 내일
	checkOut.value = tomorrow.toISOString().substring(0, 10);
}

// 체크인, 체크아웃 날짜 선택 유효성 검사
function dateCheck() {
	
	var checkIn = document.getElementById("checkIn");
	var checkOut = document.getElementById("checkOut");
	var today = new Date(); // 오늘
	var tomorrow = new Date(today.valueOf() + (24*60*60*1000)); // 내일
	// 체크인은 오늘 이후만 선택 가능
	if(checkIn.value < today.toISOString().substring(0, 10)) {
		alert("체크인 날짜를 다시 입력해주세요.");
		checkIn.value = today.toISOString().substring(0, 10);
	}
	// 체크아웃은 내일 이후만 선택 가능
	if(checkOut.value < tomorrow.toISOString().substring(0, 10)) {
		alert("체크아웃 날짜를 다시 입력해주세요.");
		checkOut.value = tomorrow.toISOString().substring(0, 10)
	}
}