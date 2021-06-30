/**
 * 숙박일수 자동입력
 */

// 숙박일수 자동입력
function nights() {
	
	// 입력된 날짜를 '-'로 나눠서 배열에 담고
	var checkIn = document.getElementById("checkIn").value;
	var checkOut = document.getElementById("checkOut").value;
    var inArr = checkIn.split("-");
    var outArr = checkOut.split("-");

	// 날짜를 초 단위로 변환하여
    var inObj = new Date(inArr[0], Number(inArr[1])-1, inArr[2]);
    var outObj = new Date(outArr[0], Number(outArr[1])-1, outArr[2]);

    // 계산 후 경과일수를 대입
    var result = (outObj.getTime() - inObj.getTime())/1000/60/60/24;
    var nights = document.getElementById("nights");
    nights.innerHTML = result + "박";

}