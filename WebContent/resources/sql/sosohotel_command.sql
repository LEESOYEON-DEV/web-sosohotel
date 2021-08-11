# WebProject_sosohotel 연동 DB 자주 쓰는 명령어

USE sosohotel;
SHOW TABLES;

DESC member;
DESC room;
DESC reservation;
DESC payment;
DESC room_counter;
DESC refund;

SELECT * FROM member;
SELECT * FROM room;
SELECT * FROM reservation;
SELECT * FROM payment;
SELECT * FROM room_counter;
SELECT * FROM refund;
SELECT * FROM notice;

DELETE FROM reservation WHERE res_num='RS210430101009';
DELETE FROM member WHERE user_id='guest';
SELECT * FROM member WHERE user_id='tomato';

SELECT count(*) FROM notice;
SELECT * FROM notice WHERE writer_name LIKE '%관%' ORDER BY not_num DESC;
DELETE FROM notice WHERE not_num = 9;

UPDATE notice SET writer_name="토마토마토", not_title="1234", not_content="12345", not_date=sysdate() WHERE not_num=6;
SELECT * FROM room WHERE rm_name="Twin Room";
SELECT rm_type FROM room WHERE rm_name="Twin Room";
SELECT rm_code FROM room WHERE rm_name="Twin Room";
DELETE FROM reservation WHERE user_id = "tomato";
DELETE FROM payment WHERE pay_date LIKE '2021-08%';
SELECT * FROM reservation WHERE res_num="RS210430101003";
SELECT * FROM payment WHERE pay_date LIKE '2021-08%';

SELECT rm_count FROM room_counter WHERE rm_code="ST210813";
UPDATE room_counter SET rm_count=2 WHERE rm_code="ST210813";

INSERT INTO refund(ref_num, res_num, ref_date, ref_amount) VALUES('RF210808797569', 'RS210807297185', '2021-8-8 0:6:35', 440000);