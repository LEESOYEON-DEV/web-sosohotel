# WebProject_sosohotel 연동 DB

/*
# 생성된 DB 목록 확인
SHOW DATABASES;

# 데이터베이스 생성
CREATE SCHEMA DB;
CREATE DATABASE DB;

# 데이터베이스 삭제
DROP SCHEMA DB;

# DB 선택 (= 더블클릭)
USE DB;

# 선택된 DB의 테이블 확인
SHOW TABLES;

# 테이블 생성
CREATE TABLE 테이블(
	컬럼 타입 PRIMARY KEY NOT NULL DEFAULT,
    컬럼 타입 PRIMARY KEY NOT NULL DEFAULT,
	PRIMARY KEY(컬럼),
	UNIQUE(컬럼),
	FOREIGN KEY(컬럼) REFERENCES 참조테이블(참조컬럼)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# 선택된 테이블의 상세정보 조회
DESC 테이블;

# 테이블 수정
ALTER TABLE 테이블 ADD 컬럼 타입 [NULL|IS NOT NULL] [DEFAULT] [FIRST|AFTER 컬럼]; -- 필드 추가
ALTER TABLE 테이블 DROP 컬럼; -- 필드 삭제
ALTER TABLE 테이블 CHANGE old컬럼 new컬럼 타입 [NULL|IS NOT NULL] [DEFAULT] [FIRST|AFTER 컬럼]; -- 컬럼명, 데이터타입 변경
ALTER TABLE 테이블 MODIFY 컬럼 타입; -- 데이터타입 변경
ALTER TABLE 테이블 ALTER 컬럼 SET DEFAULT '값'|DROP DEFAULT; -- 디폴트 정의 및 삭제
ALTER TABLE 테이블 RENAME new테이블; -- 테이블명 변경
ALTER TABLE 테이블 ADD FOREIGN KEY(컬럼) REFERENCES 참조테이블(참조컬럼); -- 키 설정 추가
ALTER TABLE member AUTO_INCREMENT = 값; -- AUTO_INCREMENT 값 초기화 (INT, PK or FK, NN)

#테이블 삭제
DROP TABLE 테이블;

# 데이터 입력
INSERT INTO 테이블(컬럼, 컬럼) VALUES(값, 값);
INSERT INTO 테이블 VALUES(값, 값); -- 모든 필드에 대한 값을 입력할 경우만 가능
INSERT INTO 테이블(컬럼, 컬럼) SELECT 컬럼, 컬럼 FROM 가져올테이블 WHERE 조건; -- 다른 테이블에서 값을 가져옴

# 데이터 수정
UPDATE 테이블 SET 컬럼=값, 컬럼=값 WHERE 조건; -- 조건을 지정하지 않으면 모든 데이터가 변경 (주의)

# 데이터 삭제
DELETE FROM 테이블 WHERE 조건; -- 조건을 지정하지 않으면 모든 데이터가 삭제 (주의)

# 데이터 조회
SELECT DISTINCT 컬럼, 컬럼 FROM 테이블 AS 별칭
	INNER JOIN 테이블 AS 별칭 ON 조인조건 WHERE 조회조건
	GROUP BY 컬럼, 컬럼 HAVING 그룹검색조건
    ORDER BY 컬럼 ASC(오름차순)|DESC(내림차순) LIMIT 값; -- 값이 3이면 하위|상위 3개의 데이터
    
# WHERE 조건
WHERE 컬럼명 BETWEEN A AND B : A~B에 해당하는 데이터
WHERE 컬럼명 LIKE '%컴', '%컴%', '컴%' -- [wildcard] % : 0개 이상의 문자를 대체, _ : 1개의 문자를 대체
WHERE 컬럼명 IN(값, 값, ,,) <> NOT IN은 일치하지 않았으면 하는 조건 (각 조건은 IN, NOT IN 모두 OR로 처리)
WHERE 컬럼명 IS NULL|IS NOT NULL
*/


# 데이터베이스 생성
CREATE SCHEMA sosohotel;
USE sosohotel;

# 데이터베이스 삭제
DROP SCHEMA sosohotel;

# 테이블 생성
CREATE TABLE member(
	user_id VARCHAR(20) PRIMARY KEY,
    user_pw VARCHAR(20) NOT NULL,
    user_name VARCHAR(10) NOT NULL,
    user_tel VARCHAR(20) NOT NULL,
    user_email VARCHAR(30) NOT NULL,
    user_date TIMESTAMP NOT NULL    
) ENGINE = InnoDB;

DROP TABLE member; -- 테이블 삭제
SHOW TABLE STATUS LIKE 'member'; -- 테이블 상세정보

CREATE TABLE room(
	rm_type VARCHAR(20) PRIMARY KEY,
    rm_code VARCHAR(2) NOT NULL UNIQUE,
    rm_name VARCHAR(20) NOT NULL UNIQUE,
    basic_people INT NOT NULL,
    add_person INT,
    price_weekday INT NOT NULL,
    price_weekend INT NOT NULL,
    extra_charge INT,
	rm_num INT NOT NULL
) ENGINE = InnoDB;

DROP TABLE room;

# 데이터 입력 : room (4건)
-- 추가인원 데이터 제외 (add_person, extra_charge)
INSERT INTO room(rm_type, rm_code, rm_name, basic_people, price_weekday, price_weekend, rm_num)
	VALUES('single', 'SG', 'Single Room', 1, 50000, 70000, 10);
INSERT INTO room(rm_type, rm_code, rm_name, basic_people, price_weekday, price_weekend, rm_num)
	VALUES('twin', 'TW', 'Twin Room', 2, 80000, 120000, 10);
INSERT INTO room(rm_type, rm_code, rm_name, basic_people, price_weekday, price_weekend, rm_num)
	VALUES('double', 'DB', 'Double Room', 2, 80000, 120000, 10);
INSERT INTO room(rm_type, rm_code, rm_name, basic_people, price_weekday, price_weekend, rm_num)
	VALUES('suite', 'ST', 'Suite Room', 2, 120000, 160000, 10);

CREATE TABLE room_counter(
	rm_code VARCHAR(10) PRIMARY KEY,
    check_in TIMESTAMP NOT NULL,
    rm_type VARCHAR(20) NOT NULL,
    rm_count INT NOT NULL, -- 예약객실수
    FOREIGN KEY(rm_type) REFERENCES room(rm_type)
) ENGINE = InnoDB;

DROP TABLE room_counter;

CREATE TABLE reservation(
	res_num VARCHAR(20) PRIMARY KEY, -- RS(YYMMDD)(랜덤2, 10~99)(랜덤4, 1000~9999)
	rm_type VARCHAR(20) NOT NULL,
    user_id VARCHAR(20),
    guest_id VARCHAR(20) UNIQUE,
    user_name VARCHAR(10) NOT NULL,
    user_tel VARCHAR(20) NOT NULL,
    user_email VARCHAR(30) NOT NULL,
    check_in TIMESTAMP NOT NULL,
    check_out TIMESTAMP NOT NULL,
    nights INT NOT NULL,
    rm_count INT NOT NULL,
    res_adult INT NOT NULL,
    res_child INT NOT NULL,
    res_date TIMESTAMP NOT NULL,
    res_con VARCHAR(10) NOT NULL, -- 예약대기(결제대기), 예약완료(결제완료, 결제예정)
    can_date TIMESTAMP, -- 취소신청(관리자 승인 전), 환불대기(환불금액이 있을 경우), 취소완료(환불금액이 없을 경우)
    FOREIGN KEY(rm_type) REFERENCES room(rm_type)
) ENGINE = InnoDB;

DROP TABLE reservation;

CREATE TABLE payment(
	pay_num VARCHAR(20) PRIMARY KEY, -- PA(YYMMDD)(랜덤2, 10~99)(랜덤4, 1000~9999)
    res_num VARCHAR(20) NOT NULL UNIQUE,
    app_num VARCHAR(20) UNIQUE, -- 신용카드 결제일 때만 입력
    pay_date TIMESTAMP NOT NULL,
    pay_con VARCHAR(10) NOT NULL, -- 결제완료, 결제대기, 결제예정
    pay_method VARCHAR(10) NOT NULL, -- 신용카드, 무통장입금(상세 데이터 입력란 필요), 현장결제
    pay_amount INT NOT NULL,
    FOREIGN KEY(res_num) REFERENCES reservation(res_num)
) ENGINE = InnoDB;

DROP TABLE payment;

CREATE TABLE refund(
	ref_num VARCHAR(20) PRIMARY KEY, -- RF(YYMMDD)(랜덤2, 10~99)(랜덤4, 1000~9999)
    res_num VARCHAR(20) NOT NULL,
    ref_date TIMESTAMP NOT NULL,
    ref_amount INT NOT NULL,
    FOREIGN KEY(res_num) REFERENCES reservation(res_num)
) ENGINE = InnoDB;

DROP TABLE refund;

CREATE TABLE notice(
	not_num INT PRIMARY KEY AUTO_INCREMENT,
    writer_id VARCHAR(20) NOT NULL,
    writer_name VARCHAR(10) NOT NULL,
    not_title VARCHAR(100) NOT NULL,
    not_content TEXT NOT NULL,
    not_date TIMESTAMP NOT NULL,
    not_hit INT NOT NULL,
    FOREIGN KEY(writer_id) REFERENCES member(user_id)
) ENGINE = InnoDB;

DROP TABLE notice;

INSERT INTO notice(writer_id, writer_name, not_title, not_content, not_date, not_hit)
	VALUES('tomato', '토마토', '데이터연결테스트제목', '내용내용', sysdate(), 100);
INSERT INTO notice(writer_id, writer_name, not_title, not_content, not_date, not_hit)
	VALUES('tomato', '토마토', '데이터연결테스트제목2', '내용내용2', sysdate(), 200);
INSERT INTO notice(writer_id, writer_name, not_title, not_content, not_date, not_hit)
	VALUES('admin', '관리자', '테스트제목', '테스트내용', sysdate(), 0);


# 데이터 입력 : member (20건)
INSERT INTO member VALUES('admin', '1234', '관리자', '01000000000', 'admin@sosohotel.com', sysdate());
INSERT INTO member VALUES('test1', 'test1', '테스트', '01011111111', 'test1@test.com', sysdate());
INSERT INTO member VALUES('test2', 'test2', '테스트', '01022222222', 'test2@test.com', sysdate());
INSERT INTO member VALUES('test3', 'test3', '테스트', '01033333333', 'test3@test.com', sysdate());
INSERT INTO member VALUES('test4', 'test4', '테스트', '01044444444', 'test4@test.com', sysdate());

INSERT INTO member VALUES('apple', '1234', '김사과', '01011112222', 'apple10@test.com', sysdate());
INSERT INTO member VALUES('banana', '1234', '반하나', '01011113333', 'banana@test.com', sysdate());
INSERT INTO member VALUES('strawberry', '1234', '이딸기', '01011114444', 's2berry@test.com', sysdate());
INSERT INTO member VALUES('melon123', '1234', '이메론', '01011115555', 'melonyyy@test.com', sysdate());
INSERT INTO member VALUES('greentea', '1234', '박녹차', '01011116666', 'latte@test.com', sysdate());
INSERT INTO member VALUES('apeach', '1234', '어피치', '01011117777', 'apeach@test.com', sysdate());
INSERT INTO member VALUES('ryan', '1234', '라이언', '01011118888', 'ryan@test.com', sysdate());
INSERT INTO member VALUES('choco99', '1234', '나초코', '01011119999', 'chocolate@test.com', sysdate());
INSERT INTO member VALUES('lemon', '1234', '신레몬', '01011110000', 'imlemon@test.com', sysdate());
INSERT INTO member VALUES('java3387', '1234', '김자바', '01022221111', 'kim3387@test.com', sysdate());
INSERT INTO member VALUES('orange2012', '1234', '김오렌지', '01022223333', 'annoying@test.com', sysdate());
INSERT INTO member VALUES('freesia', '1234', '이지아', '01022224444', 'jia_12@test.com', sysdate());
INSERT INTO member VALUES('rose', '1234', '한장미', '01022225555', 'rosehan@test.com', sysdate());
INSERT INTO member VALUES('2sun2', '1234', '이선희', '01022226666', 'sunny2@test.com', sysdate());
INSERT INTO member VALUES('cherry', '1234', '유체리', '01022227777', 'blossom@test.com', sysdate());
INSERT INTO member VALUES('tomato', '1234', '토마토', '01022228888', 'tomato@test.com', sysdate());
INSERT INTO member VALUES('mang0', '1234', '김망고', '01022229999', 'mango2129@test.com', sysdate());
INSERT INTO member VALUES('avocado', '1234', '이보아', '01022220000', 'balee@test.com', sysdate());
INSERT INTO member VALUES('moonstar', '1234', '문별', '01033331111', 'm1111s@test.com', sysdate());
INSERT INTO member VALUES('sunflower', '1234', '이해바라기', '01033332222', '78927@test.com', sysdate());

# 데이터 입력 : reservation (15건)
-- 어린이 데이터 제외 (res_child)
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101000', 'double', 'apple', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:10', '예약완료'); -- 신용카드, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101001', 'single', 'banana', '2021-10-09', '2021-10-10', 1, 1, 1, '2021-04-30 23:10:13', '예약완료'); -- 신용카드, 70000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101002', 'double', 'melon123', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:15', '예약완료'); -- 신용카드, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101003', 'double', 'strawberry', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:18', '예약완료'); -- 신용카드, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101004', 'suite', 'greentea', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:19', '예약완료'); -- 신용카드, 160000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101005', 'twin', 'apeach', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:23', '예약완료'); -- 무통장입금, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101006', 'twin', 'ryan', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:24', '예약완료'); -- 무통장입금, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101009', 'double', 'choco99', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:34', '예약대기'); -- 무통장입금, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101010', 'double', 'lemon', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:37', '예약대기'); -- 무통장입금, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101014', 'double', 'java3387', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:45', '예약대기'); -- 무통장입금, 120000

INSERT INTO reservation(res_num, rm_type, guest_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101007', 'double', 'guest_2104301111', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:30', '예약완료'); -- 신용카드, 120000
INSERT INTO reservation(res_num, rm_type, guest_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101008', 'single', 'guest_2104301112', '2021-10-09', '2021-10-10', 1, 1, 1, '2021-04-30 23:10:33', '예약완료'); -- 신용카드, 70000
INSERT INTO reservation(res_num, rm_type, guest_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101011', 'double', 'guest_2104301113', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:38', '예약완료'); -- 신용카드, 120000
INSERT INTO reservation(res_num, rm_type, guest_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101012', 'double', 'guest_2104301114', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:39', '예약완료'); -- 현장결제, 120000
INSERT INTO reservation(res_num, rm_type, guest_id, check_in, check_out, nights, rm_count, res_adult, res_date, res_con)
	VALUES('RS210430101013', 'double', 'guest_2104301115', '2021-10-09', '2021-10-10', 1, 1, 2, '2021-04-30 23:10:41', '예약완료'); -- 현장결제, 120000

# 데이터 입력 : payment (10건)
-- 신용카드 결제 (8건)
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101000', 'RS210430101000', '210430101000', '2021-04-30 23:10:10', '결제완료', '신용카드', 120000);
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101001', 'RS210430101001', '210430101001', '2021-04-30 23:10:13', '결제완료', '신용카드', 70000);
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101002', 'RS210430101002', '210430101002', '2021-04-30 23:10:15', '결제완료', '신용카드', 120000);
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101003', 'RS210430101003', '210430101003', '2021-04-30 23:10:18', '결제완료', '신용카드', 120000);
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101004', 'RS210430101004', '210430101004', '2021-04-30 23:10:19', '결제완료', '신용카드', 160000);
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101007', 'RS210430101007', '210430101007', '2021-04-30 23:10:3', '결제완료', '신용카드', 120000);
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101008', 'RS210430101008', '210430101008', '2021-04-30 23:10:33', '결제완료', '신용카드', 70000);
INSERT INTO payment(pay_num, res_num, app_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101011', 'RS210430101011', '210430101011', '2021-04-30 23:10:38', '결제완료', '신용카드', 120000);
-- 무통장입금 (2건)
INSERT INTO payment(pay_num, res_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101005', 'RS210430101005', '2021-04-30 23:15:32', '결제완료', '무통장입금', 120000);
INSERT INTO payment(pay_num, res_num, pay_date, pay_con, pay_method, pay_amount)
	VALUES('PA210430101006', 'RS210430101006', '2021-04-30 23:17:41', '결제완료', '무통장입금', 120000);

/*
결제내역 없는 예약내역 : 예약대기 OR 예약완료(현장결제)
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, res_adult, res_date, res_con)
	VALUES('RS210430101009', 'double', 'choco99', '2021-10-09', '2021-10-10', 1, 2, '2021-04-30 23:10:34', '예약대기'); -- 무통장입금, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, res_adult, res_date, res_con)
	VALUES('RS210430101010', 'double', 'lemon', '2021-10-09', '2021-10-10', 1, 2, '2021-04-30 23:10:37', '예약대기'); -- 무통장입금, 120000
INSERT INTO reservation(res_num, rm_type, user_id, check_in, check_out, nights, res_adult, res_date, res_con)
	VALUES('RS210430101014', 'double', 'java3387', '2021-10-09', '2021-10-10', 1, 2, '2021-04-30 23:10:45', '예약대기'); -- 무통장입금, 120000
INSERT INTO reservation(res_num, rm_type, guest_id, check_in, check_out, nights, res_adult, res_date, res_con)
	VALUES('RS210430101012', 'double', 'guest_2104301114', '2021-10-09', '2021-10-10', 1, 2, '2021-04-30 23:10:39', '예약완료'); -- 현장결제, 120000
INSERT INTO reservation(res_num, rm_type, guest_id, check_in, check_out, nights, res_adult, res_date, res_con)
	VALUES('RS210430101013', 'double', 'guest_2104301115', '2021-10-09', '2021-10-10', 1, 2, '2021-04-30 23:10:41', '예약완료'); -- 현장결제, 120000
*/

# 데이터 입력 : room_counter (4건)
INSERT INTO room_counter(rm_code, check_in, rm_type, rm_count) VALUES('SG211009', '2021-10-09', 'single', 2);
INSERT INTO room_counter(rm_code, check_in, rm_type, rm_count) VALUES('TW211009', '2021-10-09', 'twin', 2);
INSERT INTO room_counter(rm_code, check_in, rm_type, rm_count) VALUES('DB211009', '2021-10-09', 'double', 10);
INSERT INTO room_counter(rm_code, check_in, rm_type, rm_count) VALUES('ST211009', '2021-10-09', 'suite', 1);

/*
# 데이터 입력
INSERT INTO member(user_id, user_pw, user_name, user_tel, user_email, user_date) VALUES ('', '', '', '', '', sysdate());
INSERT INTO member(user_id, user_pw, user_name, user_tel, user_email, user_date) VALUES (?, ?, ?, ?, ?, sysdate());

# 데이터 조회
SELECT user_pw FROM member WHERE user_id='';
SELECT user_pw FROM member WHERE user_id=?
SELECT * FROM member WHERE user_id =?

# 데이터 수정
UPDATE member SET user_pw, user_name='', user_tel='', user_email='' WHERE user_id='';
UPDATE member SET user_pw='%s', user_name='%s', user_tel='%s', user_email='%s' WHERE user_id='%s';

# 데이터 삭제
DELETE FROM member WHERE user_id='';
*/