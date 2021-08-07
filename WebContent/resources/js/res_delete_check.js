/**
 * 예약 취소 확인
 */

function resDeleteChk(resNum) {

	var check = false;
	check = confirm("예약을 정말 취소하시겠습니까?");
	if(check) { location.href="./resDeleteAction.do?resNum="+resNum; }
	else { return; }
}