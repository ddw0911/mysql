SELECT * FROM 동아리가입학생학과;

create table 학과 (select 학번, 학생이름, 학과번호, 학과명 from 동아리가입학생학과);
select * from 학과;

create table 동아리(select distinct 동아리번호, 동아리명, 동아리개설일 from 동아리가입학생학과);
select * from 동아리;

create table 동아리가입학생 (select distinct 학번, 학생이름, 학과번호, 학과명, 동아리번호, 동아리가입일 from 동아리가입학생학과);
select * from 동아리가입학생;

-- 동아리와 동아리가입학생 관계맺기 / 동아리번호는 동아리와 fk, 동아리가입학생학과의 주키는 (학번과 동아리번호)
alter table 동아리가입학생 add constraint 동아리가입학생_학번동아리번호pk primary key 동아리가입학생(학번, 동아리번호);
alter table 동아리가입학생 add constraint 동아리가입학생_동아리번호fk foreign key (동아리번호) references 동아리(동아리번호);
desc 동아리가입학생;

-- 제약조건 적용확인
select * from information_schema.table_constraints where table_name='동아리가입학생';

create table 학생(select 학번, 학생이름 from 학과);
select * from 학생;
desc 학생;
alter table 학생 add constraint 학생_학번_pk primary key (학번);

create table 학과정보 (select distinct 학과번호, 학과명 from 학과);
select * from 학과정보;
alter table 학과정보 add constraint 학과정보_학과번호_pk primary key (학과번호);

create table 동아리가입(select 동아리번호, 학번, 동아리가입일  from 동아리가입학생);
select * from 동아리가입;
alter table 동아리가입 add constraint 동아리가입_동아리번호_fk foreign key (동아리번호) references 동아리(동아리번호);
alter table 동아리가입 add constraint 동아리가입_학번_fk foreign key (학번) references 학생(학번);
alter table 동아리가입 add constraint 동아리가입_학번_동아리번호_pk primary key (학번, 동아리번호);