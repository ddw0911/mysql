-- 저장프로시져 : 쿼리문의 집합 - 동작 일괄처리
DELIMITER $$
create procedure userProc()
begin
	select * from usertbl;
end $$
DELIMITER ;
call userProc();

-- in param
-- param 1개
DELIMITER $$
create procedure userProc1(in username varchar(10))
begin
	select * from usertbl where name = username;
end $$
DELIMITER ;
call userProc1('조용필');

-- param 2개
DELIMITER $$
drop procedure if exists userProc2;
create procedure userProc2(in custyear int ,in custheight int)
begin
	select * from usertbl where birthYear > custyear and height >= custheight ;
end $$
DELIMITER ;
call userProc2(1970, 178);

-- out
create table testtbl(id int auto_increment primary key, txt char(10));

delimiter $$
create procedure userProc3(in txtval char(10), out outval int)
begin
	insert testtbl values(null, txtval);
    select max(id) into outval from testtbl;
end $$
delimiter ;
call userProc3('테스트2',@myval);
truncate testtbl;
select concat('현재 입력된 ID값 ==> ' ,@myval) 결과;

-- 구구단
create table gugudan(txt varchar(100));
delimiter $$
create procedure gugu()
begin 
	declare str varchar(100);
	declare i int;
	declare j int;
	set i = 2;
    
	while i < 10 do
    set str = '';
    set j = 1;
		while j < 10 do
			set str = concat(str, ' ', i, ' x ', j, ' = ', i * j);
            set j = j+1;
		end while;
        set i = i + 1;
        insert gugudan values(str);
	end while;
end $$
delimiter ;
drop procedure gugu;
truncate gugudan;
call gugu();
select * from gugudan;


-- 저장된 프로시져 이름과 내용확인
select * from information_schema.routines where routine_schema = 'bookstore' and routine_type = 'procedure';
-- 저장된 프로시져의 파라미터 내용확인
select * from information_schema.parameters where specific_name = 'userProc3';

show create procedure bookstore.userProc3;

-- 프로시져에 내가 원하는 테이블이름을 전달해 조회하기
delimiter $$
create procedure nameTableProc(in tblname varchar(30))
begin
	set @sqlQuery = concat('select * from ', tblname);
    prepare myQuery from @sqlQuery;
    execute myQuery;
    deallocate prepare myQuery;
end $$
delimiter ;

call nameTableProc('book');
call nameTableProc('buytbl');
call nameTableProc('orders');

delimiter $$
create procedure gradeproc(in score int)
begin
	 declare point int;
     declare credit char(1);
     set point = score;
     
     case
		when point >= 90 then set credit = 'A';
		when point >= 80 then set credit = 'B';
		when point >= 70 then set credit = 'C';
		when point >= 60 then set credit = 'D';
        else set credit = 'F';
	end case;
		select concat('당신의 학점은 ===> ', credit, '입니다.') 성적;
	end $$;
delimiter ;

drop procedure gradeproc;

call gradeproc(85);

delimiter $$
create procedure gradeproc2(in score int , out credit char(1))
begin 
	declare point int;
    set point = score;
    
     case
		when point >= 90 then set credit = 'A';
		when point >= 80 then set credit = 'B';
		when point >= 70 then set credit = 'C';
		when point >= 60 then set credit = 'D';
        else set credit = 'F';
	end case;
	end $$;
delimiter ;

drop procedure gradeproc2;
call gradeproc2(90, @credit);
select concat('당신의 학점은 ===> ', @credit, '입니다.') 성적;

select u.userID, sum(b.price*b.amount) 총구매액,
	case
		when price * amount >= 1500 then '최우수 고객'
		when price * amount >= 1000 then '우수 고객'
		when price * amount >= 1 then '일반 고객'
		else '유령 고객'
	end 고객등급
from buytbl b right join usertbl u on b.userid=u.userid
group by userID
order by 총구매액 desc;

delimiter $$
create procedure whileproc1()
begin
	declare i int;
    declare total int;
    set i = 1;
    set total = 0;
    
    while i <=100 do
    set total = total + i;
    set i = i + 1;
    end while;
    select total;
end $$
delimiter ;
call whileproc1;

delimiter $$
create procedure whileproc2()
begin
	declare i int;
    declare total int;
    set i = 1;
    set total = 0;
    
    myWhile: while i <=100 do
			if(i%7=0) then set i = i+1;
				iterate myWhile;
			end if;
            
			set total = total + i;
            if(total > 10000) then leave myWhile; 
            end if;
            
			set i = i + 1;
			end while;
			select total;
end $$
delimiter ;
call whileproc2();