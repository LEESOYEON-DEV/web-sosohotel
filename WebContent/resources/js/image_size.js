/**
 * 메인 프로모션 이미지 크기 변경
 */

// 커서가 이미지 위로 올라가면 확대
window.onmouseover = function (e) {
	
    if(e.target.className != "promotionImg") { return; }
    e.target.width = "300";
    e.target.height = "300";
    e.target.style.margin = "90px 0";
}

// 커서가 이미지를 벗어나면 원래 크기로
window.onmouseout = function (e) {
	
    if(e.target.className != "promotionImg") { return; }
    e.target.width = "280";
    e.target.height = "280";
    e.target.style.margin = "100px 0";
}