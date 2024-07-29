-- 함수

-- 1. 제어흐름 함수: if, ifnull, nullif, case~when~else~end
-- 1) if(수식) 수식이 참인지 거짓인지 결과에 따라 분기
select if(100 > 200,'참','거짓');
-- 2) ifnull(수식1, 수식2) 수식1이 null이 아니면 수식1 반환, null이면 수식2 반환
select ifnull(null, '널이네'), ifnull(100, '널이여');
-- 3) nullif(수식1, 수식2) : 수식1 = 수식2 null 반환, 다르면 수식1 반환
select nullif(100, 100), nullif(200,100);
-- 4) case~when~else~end - 연산자로 구분
select case 2
	when 1 then '일'
	when 3 then '삼'
	when 5 then '오'
    else '모름'
end '숫자확인';

-- ** 문자열 함수 **
-- ascii(아스키코드), char(숫자)
select ascii('a'), char(65);
-- mysql charset=utf8 - 글자당 영문자 1byte, 한글 3byte 사용
-- bit_length() 비트 크기, char_length() 문자개수 반환, length byte 수 반환
select bit_length('abc'), char_length('abc'), length('abc'); -- 24 3 3
select bit_length('가나다'), char_length('가나다'), length('가나다'); -- 72 3 9
-- contcat, concat_ws(구분자, 문자열, 문자열, ...) - 구분자를 넣어 문자열 합치기
select concat_ws('/', '2024', '우승자', '래리 킴');

-- elt, field, fint_in_set, instr, locate - 위치찾기
select elt(2, 'one', 'two', 'three'); -- 2번째 값 반환
-- 찾는 값이 있는 위치 반환
select field('둘', 'one', 'two', 'three'); 
select find_in_set('둘', 'one, two, three'); 
select instr('하나둘셋', '둘'); -- locate보다 instr 사용
select locate('둘', '하나둘셋');

-- 4) format(숫자, 소숫점 자릿수) ; 소수점자릿수 표현, 1000단위로 ,
SELECT FORMAT(123456.123456, 3);
-- 진수 변환
select bin(31), hex(31), oct(31); -- 10진수를 2,16,8진수로 변환
-- insert
select insert('asdfqwer', 3, 4, '####'); -- insert (기준문자열, 위치, 길이, 삽입할 문자열)
-- left, right
select left('abcdefg', 3), right('abcdefg', 3); -- ~로부터 ~개 반환
-- upper, lower
select lower(upper('def'));
-- lpad(문자열, 채울문자열), rpad
select lpad('ssg', 5, '&');
-- trim 양쪽공백제거
select trim('          ssg   ');
select rtrim('          ssg   ');
-- substr(문자열, 시작위치, 길이) substr(문자열 from 시작위치 for 길이)
select substr('qwerty', 3, 2);
select substr('qwerty' from 3 for 2);

-- 날짜 및 시간 함수
-- adddate(날짜, 차이) subdate(날짜, 차이)
select adddate('2025-01-01', interval 31 day); -- 더하기
select subdate('2025-02-01', interval 31 day); -- 빼기
select subdate('2025-02-01', interval 1 month);

select addtime('2025-02-01 16:57:23', '1:1:1');
select subtime('2025-02-01 16:57:23', '1:1:1');
-- curdate() : 현재 연-월-일 //  curtime() : 현재 시:분:초  // now(), sysdate(), localtime(), localstamp() : 연-월-일 시:분:초

-- year(날짜), month(날짜), day(날짜), hour(시간), minute(시간), second(시간), microsecond(시간)
select year(curdate());
select hour(curtime());
select second(now());