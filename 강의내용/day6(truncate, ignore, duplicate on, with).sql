select count(emp_no) from employees;

-- 테이블 복제 (원본 유지)
create table bittbl1(select * from employees);
create table bittbl2(select * from employees);
create table bittbl(select * from employees);

-- 삭제명령어 delete 행단위 삭제, drop 테이블 자체 삭제, truncate 행단위 삭제 (테이블구조만 남기고 삭제)
set sql_safe_updates = 0; 
delete from bittbl1; -- 2.250s dml은 트랜잭션 로그를 기록하기 때문
drop table bittbl2; -- 0.109s
truncate bittbl; -- 0.047s

-- insert tip
create table membertbl(select userID, name, addr from usertbl limit 3);
insert membertbl(select userID, name, addr from usertbl limit 3);
select * from membertbl;
alter table membPRIMARYertbl add constraint pk_membertbl_userid primary key(userID);
desc membertbl;

insert membertbl values('SJH', '서장훈', '한국'); 
insert ignore membertbl values('SJH', '서장훈', '한국'); -- ignore pk문제(중복오류) 발생 시 무시하고 진행
insert ignore membertbl values('HJY', '현주엽', '미국');
commit;

truncate membertbl;
commit;

-- on duplicate key update
select * from membertbl;

insert membertbl values('BBK', '빠삐킴', '미국') on duplicate key update name = '빠삐킴', addr ='미국'; -- pk 중복시 update
insert membertbl values('MCM', '엠씨몽', '미국') on duplicate key update name = '엠씨몽', addr ='미국'; -- pk 중복 아닐 시 insert

-- with 절 - CTE(common table expression, Ansi-sql99 표준)를 표현하기 위한 구문 - 8.0 이후 기능
-- CTE - non-Recursive 비재귀 vs recursive 재귀

-- CTE 중 non-Recursive
-- with 테이블이름(열이름1, 열이름2)
-- as(쿼리문)
-- select 열이름 from 테이블이름;

select userID, sum(price * amount) '총구매액'
from buytbl
group by userID;

with abc(userid, total) 
as (select userID, sum(price * amount) -- abc 속성과 매핑
from buytbl
group by userID)
select * from abc order by total desc;

select * from usertbl;

with giant(height)
as (select max(height)
from usertbl
group by addr)
select avg(height) from giant;