/**
 * 실시간예약 페이지 자동 입력 기능
 */

// 객실 목록의 예약 정보 자동 입력
function autoData() {
	
	var checkIn = document.getElementById("checkIn");
	var checkOut = document.getElementById("checkOut");
	var room = document.getElementById("room");
	var adult = document.getElementById("adult");
	var child = document.getElementById("child");
	
	for(i=0; i<4; i++) {
		var checkInText = document.getElementsByClassName("checkInText")[i];
		var checkOutText = document.getElementsByClassName("checkOutText")[i];
		var roomText = document.getElementsByClassName("roomText")[i];
		var adultText = document.getElementsByClassName("adultText")[i];
		var childText = document.getElementsByClassName("childText")[i];
		
		checkInText.innerHTML = checkIn.value;
		checkOutText.innerHTML = checkOut.value;
		roomText.innerHTML = room.value;
		adultText.innerHTML = adult.value;
		childText.innerHTML = child.value;
	}
}