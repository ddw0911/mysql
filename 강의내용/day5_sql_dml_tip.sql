-- 출력 개수를 제한하는 limit
select employee_id, hire_date from employees order by hire_date DESC limit 5;
select employee_id, hire_date from employees order by hire_date DESC limit 1,6;

-- 테이블 복제
create table job_grades1(select * from job_grades);
alter table job_grades1 add constraint pk_job_grades1 PRIMARY key(grade_level);

desc job_grades1;

-- insert : 삽입
-- insert (into) table[(열1, 열2, 열3, ...)] values(값1, 값2, ...);
-- table 다음열은 생략가능, 생략할 경우 values 다음에 오는 (값들의 순서 및 개수)가 (열 순서 및 개수)와 동일해야

create table testtbl (id int, username char(5), age int);
insert testtbl values(1, 'ssg', 30);
insert testtbl(id, username) values(2, 'ksg');
insert testtbl(id, username) values(3, 'hsg');
rollback;
commit; -- 해주지 않으면 다른 ip로부터 접근 불가
select * from testtbl;

select @@autocommit;
set autocommit = 0;

-- Auto-increment (insert할 때 해당 열은 알아서 증가시켜 입력)
-- 제약조건으로 pk, unique 지정, 타입은 숫자형만
create table testtbl2 (id int auto_increment primary key, username char(5));
insert testtbl2 values(null, 'hhh');
insert testtbl2 values(null, 'ggg');
insert testtbl2 values(null, 'kkk');
insert testtbl2 values(null, 'lll');
select * from testtbl2;
-- 지금까지 증가된 숫자 확인법
select last_insert_id();
-- 시작값 셋팅 가능
alter table testtbl2 auto_increment = 1000;
rollback;
commit;
set @@auto_increment_increment = 3; -- 3씩 증가시키도록 세팅

-- 대량의 데이터를 생성
-- insert into 테이블이름(열1,열2,...) select문;
select count(employee_id) from employees;

create table testtbl3(id int, fname varchar(50), lname varchar(50));
insert into testtbl3
select employee_id, first_name, last_name from employees;
alter table testtbl3 add constraint pk_testtbl3_id primary key(id);

-- update : 수정
-- update 테이블 set 열=값, 열=값, 열=값, ... (where 조건); -- 조건 생략 시 테이블 전체 행에 대해 변경

select * from testtbl3;
update testtbl3 set lname = 'yyy'; -- 1175 에러코드 : 실행할거면 safe모드 끄세요 (위험경고)
update testtbl3 set lname = 'yyy';
rollback;

set sql_safe_updates = 0; -- safe모드 해제

-- delete : 삭제 (행 단위)
-- delete from 테이블 where 조건;
delete from testtbl3 where fname like 'Lex';
rollback;
commit;

create table testtbl4(select employee_id, first_name, last_name from employees);
insert testtbl4 select employee_id, first_name, last_name from employees;
commit;

select * from testtbl4 where last_name like 'Chen';
delete from testtbl4 where last_name like 'Chen' limit 3; -- 데이터 조회 후 삭제 (procedure)