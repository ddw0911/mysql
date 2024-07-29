-- 데이터형식
-- 1. 숫자
-- 정수 : bit(n) 1~64bit // tynyInt 1byte (~255) // smallInt 2byte (~65535) // mediumInt 3byte // int(integer) 4byte (~42억) // bigInt 9byte (~1800경)
-- 실수 : float 4byte (소수점 7자리) // double(real) 8byte (소수점15) - 근사치
--       decimal(m:전체자릿수, [d]:소수점자릿수) 5~17byte - 정확한 수치

-- 2. 문자
-- 1) char(n:글자수) 1~255 byte : 고정길이 문자형 ex) char = char(1)
-- mysql charset= utf-8 - 영문이냐 한글이냐에 따라 크기가 다름
-- 2) varchar() variable char 1~65535
-- 3) binary(n) 1~255 고정길이의 이진데이터 , varbinary(n)

-- 4) text 형식 - 대용량 글자 저장
-- tinyText 1~255, text 1~65535, mediumText 1~16,777,215, longText 1~4,294,967,295

-- 5) BLOB (Binary Large Object Object) - 대용량 데이터 저장 - 이미지, 음성, 동영상 , 문서파일

-- 6) ENUM - 65535개의 열거형 데이터

-- 3. 날짜, 시간
-- Date 3byte - 1001-01-01 ~ 9999-12-31, 'YYYY-MM-DD'
-- TIME 3byte - HH:MM:SS
-- DateTime 8byte - 'YYYY-MM-DD HH:MM:SS'
-- TimeStamp 4byte - time_zone 시스템의 변수로 utc 시간대로 변환

select cast('2024-07-01 12:30:22' as date) as 'DATE';
select cast('2024-07-01 12:30:22' as datetime) as 'DATE';

-- Geometry 공간데이터 형식으로 선, 점, 다각형 같은 공간 데이터 개체 저장, 조작 가능한 데이터타입
-- Json 8byte : JavaScript Object Notation 문서 저장